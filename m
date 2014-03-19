From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 19 Mar 2014 16:04:14 +0000
Subject: [PATCH 1/3] arm64: topology: Add support for topology DT bindings
In-Reply-To: <1394009975-28655-1-git-send-email-broonie@kernel.org>
References: <1394009975-28655-1-git-send-email-broonie@kernel.org>
Message-ID: <20140319160414.GA19953@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

sorry for the delay in reviewing.

On Wed, Mar 05, 2014 at 08:59:33AM +0000, Mark Brown wrote:

[...]

> +static int __init parse_cluster(struct device_node *cluster, int depth)
> +{
> +	char name[10];
> +	bool leaf = true;
> +	bool has_cores = false;
> +	struct device_node *c;
> +	static int __initdata cluster_id;
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
> +			parse_cluster(c, depth + 1);

You should check (and propagate) the return value here, otherwise we miss
detection of bodged topology bindings and fail to reset the topology data.

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

Should remove braces.

> +					return ret;
> +				}
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
> +}
> +
> +#else
> +static inline int parse_dt_topology(void) { return 0; }
> +#endif
> +
>  /*
>   * cpu topology table
>   */
> @@ -74,11 +225,7 @@ void store_cpu_topology(unsigned int cpuid)
>  	update_siblings_masks(cpuid);
>  }
>  
> -/*
> - * init_cpu_topology is called at boot when only one cpu is running
> - * which prevent simultaneous write access to cpu_topology array
> - */
> -void __init init_cpu_topology(void)
> +static void __init reset_cpu_topology(void)
>  {
>  	unsigned int cpu;
>  
> @@ -93,3 +240,18 @@ void __init init_cpu_topology(void)
>  		cpumask_clear(&cpu_topo->thread_sibling);
>  	}
>  }
> +
> +/*
> + * init_cpu_topology is called at boot when only one cpu is running
> + * which prevent simultaneous write access to cpu_topology array
> + */

Comment is stale.

> +void __init init_cpu_topology(void)
> +{
> +	int ret;
> +
> +	reset_cpu_topology();
> +
> +	ret = parse_dt_topology();
> +	if (ret != 0)
> +		reset_cpu_topology();

ret is unused so should be removed. You could remove the first reset call and
use static initialization for that, it is a matter of taste though.

A comment is in order, whatever approach you go for.

Thanks,
Lorenzo
