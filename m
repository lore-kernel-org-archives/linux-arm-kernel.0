From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 17 Dec 2013 17:40:37 +0000
Subject: [PATCH 2/4] arm64: topology: Add support for topology DT bindings
In-Reply-To: <1387212565-12668-2-git-send-email-broonie@kernel.org>
References: <1387212565-12668-1-git-send-email-broonie@kernel.org>
 <1387212565-12668-2-git-send-email-broonie@kernel.org>
Message-ID: <20131217174037.GC9831@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 16, 2013 at 04:49:23PM +0000, Mark Brown wrote:

[...]

> +#ifdef CONFIG_OF
> +static int cluster_id;
> +
> +static int __init get_cpu_for_node(struct device_node *node)
> +{
> +	struct device_node *cpu_node;
> +	int cpu;
> +
> +	cpu_node = of_parse_phandle(node, "cpu", 0);
> +	if (!cpu_node) {
> +		pr_crit("%s: Unable to parse CPU phandle\n", node->full_name);
> +		return -1;
> +	}
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
> +static void __init parse_core(struct device_node *core, int core_id)
> +{
> +	char name[10];
> +	bool leaf = true;
> +	int i, cpu;
> +	struct device_node *t;
> +
> +	i = 0;
> +	do {
> +		snprintf(name, sizeof(name), "thread%d", i);
> +		t = of_get_child_by_name(core, name);
> +		if (t) {
> +			leaf = false;
> +			cpu = get_cpu_for_node(t);
> +			if (cpu) {

I think that's wrong. If cpu == -1 that should be skipped.

> +				pr_info("CPU%d: socket %d core %d thread %d\n",
> +					cpu, cluster_id, core_id, i);
> +				cpu_topology[cpu].socket_id = cluster_id;
> +				cpu_topology[cpu].core_id = core_id;
> +				cpu_topology[cpu].thread_id = i;
> +			} else {
> +				pr_err("%s: Can't get CPU for thread\n",
> +				       t->full_name);
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
> +			return;
> +		}
> +
> +		pr_info("CPU%d: socket %d core %d\n",
> +			cpu, cluster_id, core_id);
> +		cpu_topology[cpu].socket_id = cluster_id;
> +		cpu_topology[cpu].core_id = core_id;
> +	} else if (leaf) {
> +		pr_err("%s: Can't get CPU for leaf core\n", core->full_name);
> +	}
> +}
> +
> +static void __init parse_cluster(struct device_node *cluster)
> +{
> +	char name[10];
> +	bool leaf = true;
> +	bool has_cores = false;
> +	struct device_node *c;
> +	int core_id = 0;
> +	int i;
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
> +			parse_cluster(c);
> +			leaf = false;
> +		}
> +		i++;
> +	} while (c);
> +

A cpu-map can only contain cluster nodes, this is not verified here, but
it has to be. Put it differently, a core node cannot be a cpu-map direct
child, a long winded way to say cpu-map cannot be parsed by this function
as it is.

> +	/* Now check for cores */
> +	i = 0;
> +	do {
> +		snprintf(name, sizeof(name), "core%d", i);
> +		c = of_get_child_by_name(cluster, name);
> +		if (c) {
> +			has_cores = true;
> +
> +			if (leaf)
> +				parse_core(c, core_id++);
> +			else
> +				pr_err("%s: Non-leaf cluster with core %s\n",
> +				       cluster->full_name, name);
> +		}
> +		i++;
> +	} while (c);
> +
> +	if (leaf && !has_cores)
> +		pr_warn("%s: empty cluster\n", cluster->full_name);
> +
> +	if (leaf)
> +		cluster_id++;
> +}
> +
> +static void __init parse_dt_topology(void)
> +{
> +	struct device_node *cn;
> +
> +	cn = of_find_node_by_path("/cpus");
> +	if (!cn) {
> +		pr_err("No CPU information found in DT\n");
> +		return;
> +	}
> +
> +	/*
> +	 * If topology is provided as a cpu-map it is essentially a
> +	 * root cluster.

No, because it can't contain core nodes as direct children.

"a cpu-map's child nodes can be: one or more cluster nodes" the bindings
say :)

Apart from these minor remarks, I think we should aim for consolidating
these parsing functions, after all they are all pretty similar bar minor
corner cases, or at least factor out the parsing/enumeration loops.

What do you think ?

Thanks,
Lorenzo
