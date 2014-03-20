From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 20 Mar 2014 11:26:50 +0000
Subject: [PATCH 1/3] arm64: topology: Add support for topology DT bindings
In-Reply-To: <1395252139-16239-1-git-send-email-broonie@kernel.org>
References: <1395252139-16239-1-git-send-email-broonie@kernel.org>
Message-ID: <20140320112650.GA1408@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 19, 2014 at 06:02:17PM +0000, Mark Brown wrote:
> +#ifdef CONFIG_OF

This ifdef can be removed, CONFIG_OF is always selected for arm64 and
the !CONFIG_OF path

> +#else
> +static inline int parse_dt_topology(void) { return 0; }
> +#endif

is wrong, it should return failure. You should remove the CONFIG_OF
ifdeffery.

> +static int __init get_cpu_for_node(struct device_node *node)
> +{
> +	struct device_node *cpu_node;
> +	int cpu;
> +
> +	cpu_node = of_parse_phandle(node, "cpu", 0);
> +	if (!cpu_node)
> +		return -1;
> +
> +	for_each_possible_cpu(cpu) {
> +		if (of_get_cpu_node(cpu, NULL) == cpu_node)
> +			return cpu;
> +	}
> +
> +	pr_crit("Unable to find CPU node for %s\n", cpu_node->full_name);
> +	return -1;
> +}
> +
> +static int __init parse_core(struct device_node *core, int cluster_id,
> +			     int core_id)
> +{
> +	char name[10];
> +	bool leaf = true;
> +	int i = 0;
> +	int cpu;
> +	struct device_node *t;
> +
> +	do {
> +		snprintf(name, sizeof(name), "thread%d", i);
> +		t = of_get_child_by_name(core, name);
> +		if (t) {
> +			leaf = false;
> +			cpu = get_cpu_for_node(t);
> +			if (cpu >= 0) {
> +				cpu_topology[cpu].cluster_id = cluster_id;
> +				cpu_topology[cpu].core_id = core_id;
> +				cpu_topology[cpu].thread_id = i;
> +			} else {
> +				pr_err("%s: Can't get CPU for thread\n",
> +				       t->full_name);
> +				return -EINVAL;
> +			}
> +		}
> +		i++;
> +	} while (t);
> +
> +	cpu = get_cpu_for_node(core);
> +	if (cpu >= 0) {
> +		if (!leaf) {
> +			pr_err("%s: Core has both threads and CPU\n",
> +			       core->full_name);
> +			return -EINVAL;
> +		}
> +
> +		cpu_topology[cpu].cluster_id = cluster_id;
> +		cpu_topology[cpu].core_id = core_id;
> +	} else if (leaf) {
> +		pr_err("%s: Can't get CPU for leaf core\n", core->full_name);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int __init parse_cluster(struct device_node *cluster, int depth)
> +{
> +	char name[10];
> +	bool leaf = true;
> +	bool has_cores = false;
> +	struct device_node *c;
> +	static int __initdata cluster_id;

WARNING: __initdata should be placed after cluster_id
#103: FILE: arch/arm64/kernel/topology.c:96:
+	static int __initdata cluster_id;

> +	int core_id = 0;
> +	int i, ret;
> +
> +	/*
> +	 * First check for child clusters; we currently ignore any
> +	 * information about the nesting of clusters and present the
> +	 * scheduler with a flat list of them.
> +	 */
> +	i = 0;
> +	do {
> +		snprintf(name, sizeof(name), "cluster%d", i);
> +		c = of_get_child_by_name(cluster, name);
> +		if (c) {
> +			ret = parse_cluster(c, depth + 1);
> +			if (ret != 0)
> +				return ret;
> +			leaf = false;
> +		}
> +		i++;
> +	} while (c);
> +
> +	/* Now check for cores */
> +	i = 0;
> +	do {
> +		snprintf(name, sizeof(name), "core%d", i);
> +		c = of_get_child_by_name(cluster, name);
> +		if (c) {
> +			has_cores = true;
> +
> +			if (depth == 0)
> +				pr_err("%s: cpu-map children should be clusters\n",
> +				       c->full_name);
> +
> +			if (leaf) {
> +				ret = parse_core(c, cluster_id, core_id++);
> +				if (ret != 0) {
> +					return ret;
> +				}

WARNING: braces {} are not necessary for single statement blocks
#139: FILE: arch/arm64/kernel/topology.c:132:
+				if (ret != 0) {
+					return ret;
+				}

> +			} else {
> +				pr_err("%s: Non-leaf cluster with core %s\n",
> +				       cluster->full_name, name);
> +				return -EINVAL;
> +			}
> +		}
> +		i++;
> +	} while (c);
> +
> +	if (leaf && !has_cores)
> +		pr_warn("%s: empty cluster\n", cluster->full_name);
> +
> +	if (leaf)
> +		cluster_id++;
> +
> +	return 0;
> +}
> +
> +static int __init parse_dt_topology(void)
> +{
> +	struct device_node *cn;
> +
> +	cn = of_find_node_by_path("/cpus");
> +	if (!cn) {
> +		pr_err("No CPU information found in DT\n");
> +		return 0;
> +	}
> +
> +	/*
> +	 * When topology is provided cpu-map is essentially a root
> +	 * cluster with restricted subnodes.
> +	 */
> +	cn = of_get_child_by_name(cn, "cpu-map");
> +	if (!cn)
> +		return 0;
> +	return parse_cluster(cn, 0);

We still have a problem here. If the topology does not contain bindings
for some cpu nodes, parse_cluster() does not fail and we end up with an
incomplete topology. We have two choices: either we check the topology
info for all possible cpus here and reset if there is missing information
or we do the lazy version and reset the topology (for all possible cpus) in
update_siblings_masks().
I'd rather do it here, in preparation for MPIDR_EL1 fallback solution
(where there will always be topology information configured and the register
will always be there in all its glory).

This also means that update_sibling_masks() should just pr_debug on
missing information since by the time a cpu get there either the
topology has been parsed correctly or it has been reset for all CPUs, no
need to reset it again.

Lorenzo
