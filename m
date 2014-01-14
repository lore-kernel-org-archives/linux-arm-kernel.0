From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 14 Jan 2014 11:43:37 +0000
Subject: [PATCH 2/4] arm64: topology: Add support for topology DT bindings
In-Reply-To: <1389554441-27335-3-git-send-email-broonie@kernel.org>
References: <1389554441-27335-1-git-send-email-broonie@kernel.org>
 <1389554441-27335-3-git-send-email-broonie@kernel.org>
Message-ID: <20140114114336.GB28912@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

apart from a couple of minor nits and a question, it looks fine to me.

On Sun, Jan 12, 2014 at 07:20:39PM +0000, Mark Brown wrote:
> +static void __init parse_core(struct device_node *core, int cluster_id,
> +			      int core_id)
> +{
> +	char name[10];
> +	bool leaf = true;
> +	int i, cpu;
> +	struct device_node *t;
> +
> +	i = 0;

You could initialize i at declaration, I can understand why you are doing that
explictly in parse_cluster (two loops, to make code clearer), but here
it does not make much sense to add a line for that.

> +	do {
> +		snprintf(name, sizeof(name), "thread%d", i);

If we wanted to be very picky, you need to copy "thread" just once (same
goes for other strings), but we'd better leave code as is IMHO.

> +		t = of_get_child_by_name(core, name);

Should we check the MT bit in MPIDR_EL1 before validating threads as well ?

I do not like the idea because this means reliance on MPIDR_EL1 for MT
and DT for topology bits, but it might be a worthwhile check.

It is certainly odd to have a DT with threads and an MPIDR_EL1 with the MT
bit clear.

> +		if (t) {
> +			leaf = false;
> +			cpu = get_cpu_for_node(t);
> +			if (cpu >= 0) {
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
> +		cpu_topology[cpu].socket_id = cluster_id;
> +		cpu_topology[cpu].core_id = core_id;
> +	} else if (leaf) {
> +		pr_err("%s: Can't get CPU for leaf core\n", core->full_name);
> +	}
> +}
> +
> +static void __init parse_cluster(struct device_node *cluster, int depth)
> +{
> +	char name[10];
> +	bool leaf = true;
> +	bool has_cores = false;
> +	struct device_node *c;
> +	static int cluster_id = 0;

static int __initdata cluster_id;

[...]

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

This comment is a bit misleading, because as you know, (1) topology
can only be provided with cpu-map, (2) cpu-map is not a root cluster.

> +	 */
> +	cn = of_find_node_by_name(cn, "cpu-map");
> +	if (!cn)
> +		return;
> +	parse_cluster(cn, 0);
> +}
> +
> +#else
> +static inline void parse_dt_topology(void) {}
> +#endif
> +
>  /*
>   * cpu topology table
>   */
> @@ -87,5 +227,8 @@ void __init init_cpu_topology(void)
>  		cpumask_clear(&cpu_topo->core_sibling);
>  		cpumask_clear(&cpu_topo->thread_sibling);
>  	}
> +
> +	parse_dt_topology();
> +
>  	smp_wmb();
>  }

With the changes/comments above pending:

Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
