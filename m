From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 13 Jan 2014 16:40:21 +0000
Subject: [PATCH 3/4] arm64: topology: Tell the scheduler about the
 relative power of cores
In-Reply-To: <1389554441-27335-4-git-send-email-broonie@kernel.org>
References: <1389554441-27335-1-git-send-email-broonie@kernel.org>
 <1389554441-27335-4-git-send-email-broonie@kernel.org>
Message-ID: <20140113164021.GA6934@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 12, 2014 at 07:20:40PM +0000, Mark Brown wrote:

[...]

> @@ -89,7 +113,7 @@ static void __init parse_cluster(struct device_node *cluster, int depth)
>  	bool leaf = true;
>  	bool has_cores = false;
>  	struct device_node *c;
> -	static int cluster_id = 0;
> +	static int cluster_id;

It has to be __initdata, and the line change above does not belong in
this patch but patch 1.

[...]

>  static void __init parse_dt_topology(void)
>  {
> +	const struct cpu_efficiency *cpu_eff;
>  	struct device_node *cn;
> +	unsigned long min_capacity = ULONG_MAX;
> +	unsigned long max_capacity = 0;
> +	unsigned long capacity = 0;
> +	int cpu;
> +
> +	__cpu_capacity = kcalloc(nr_cpu_ids, sizeof(*__cpu_capacity),
> +				 GFP_NOWAIT);
>  
>  	cn = of_find_node_by_path("/cpus");
>  	if (!cn) {
> @@ -155,10 +219,84 @@ static void __init parse_dt_topology(void)
>  	if (!cn)
>  		return;
>  	parse_cluster(cn, 0);
> +
> +	for_each_possible_cpu(cpu) {
> +		const u32 *rate;
> +		int len;
> +
> +		/* Too early to use cpu->of_node */
> +		cn = of_get_cpu_node(cpu, NULL);
> +		if (!cn) {
> +			pr_err("Missing device node for CPU %d\n", cpu);
> +			continue;
> +		}
> +
> +		for (cpu_eff = table_efficiency; cpu_eff->compatible; cpu_eff++)
> +			if (of_device_is_compatible(cn, cpu_eff->compatible))
> +				break;
> +
> +		if (cpu_eff->compatible == NULL) {
> +			pr_warn("%s: Unknown CPU type\n", cn->full_name);
> +			continue;
> +		}
> +
> +		rate = of_get_property(cn, "clock-frequency", &len);
> +		if (!rate || len != 4) {
> +			pr_err("%s: Missing clock-frequency property\n",
> +				cn->full_name);
> +			continue;
> +		}

I am wondering why we spit an error for a property that in practice is
optional. Either we make it required, or we drop the error output.

Actually this is not defined anywhere apart from the ePAPR, which
defines this property as required, but following your attempt to
standardize it for ARM, I gather it should be considered optional.

If it is optional, should we really print an error ? (I know it is the
same on arm32, I am questioning that code too).

Lorenzo
