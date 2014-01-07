From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 7 Jan 2014 13:05:40 +0000
Subject: [PATCH 3/4] arm64: topology: Tell the scheduler about the
 relative power of cores
In-Reply-To: <1387483575-11430-4-git-send-email-broonie@kernel.org>
References: <1387483575-11430-1-git-send-email-broonie@kernel.org>
 <1387483575-11430-4-git-send-email-broonie@kernel.org>
Message-ID: <20140107130540.GA8090@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 19, 2013 at 08:06:14PM +0000, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> In non-heterogeneous systems like big.LITTLE systems the scheduler will be
> able to make better use of the available cores if we provide power numbers
> to it indicating their relative performance. Do this by parsing the CPU
> nodes in the DT.
> 
> This code currently has no effect as no information on the relative
> performance of the cores is provided.
> 
> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
>  arch/arm64/kernel/topology.c | 145 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 145 insertions(+)
> 
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c

[...]

> +/*
> + * Iterate all CPUs' descriptor in DT and compute the efficiency
> + * (as per table_efficiency). Also calculate a middle efficiency
> + * as close as possible to  (max{eff_i} - min{eff_i}) / 2
> + * This is later used to scale the cpu_power field such that an
> + * 'average' CPU is of middle power. Also see the comments near
> + * table_efficiency[] and update_cpu_power().
> + */
>  static void __init parse_dt_topology(void)
>  {
> +	const struct cpu_efficiency *cpu_eff;
>  	struct device_node *cn;
> +	unsigned long min_capacity = (unsigned long)(-1);

ULONG_MAX ?

> +	unsigned long max_capacity = 0;
> +	unsigned long capacity = 0;
> +	int alloc_size, cpu;
> +
> +	alloc_size = nr_cpu_ids * sizeof(*__cpu_capacity);
> +	__cpu_capacity = kzalloc(alloc_size, GFP_NOWAIT);

kcalloc ? BTW this patch should include slab.h not the previous ones,
because that's the only patch where memory allocation takes place unless
I am missing something.

>  	cn = of_find_node_by_path("/cpus");
>  	if (!cn) {
> @@ -158,10 +221,88 @@ static void __init parse_dt_topology(void)
>  	if (!cn)
>  		return;
>  	parse_cluster(cn);
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
> +		/* check if the cpu is marked as "disabled", if so ignore */
> +		if (!of_device_is_available(cn))
> +			continue;

It is time we defined what a "disabled" CPU means in ARM world, I need to
have a proper look into this since this topic has been brought up before.

Lorenzo
