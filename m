From: jg1.han@samsung.com (Jingoo Han)
Date: Wed, 11 Dec 2013 07:48:54 +0900
Subject: [PATCH] ARM: topology: Staticise non-exported symbols
In-Reply-To: <1386673649-15181-2-git-send-email-broonie@kernel.org>
References: <1386673649-15181-1-git-send-email-broonie@kernel.org>
 <1386673649-15181-2-git-send-email-broonie@kernel.org>
Message-ID: <001201cef5fa$00b90e40$022b2ac0$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, December 10, 2013 8:07 PM, Mark Brown wrote:
> 
> From: Mark Brown <broonie@linaro.org>
> 
> These symbols are only referenced in this source file so can be made
> static, and the efficiency table is constant data so can be declared as
> such.  This avoids polluting the global namespace and fixes warnings
> from sparse.
> 
> The function arch_scale_freq_power() is still not prototyped or static,
> this is a separate issue as this is overriding a weak symbol from the
> scheduler which neglects to provide a prototype.
> 
> Signed-off-by: Mark Brown <broonie@linaro.org>

It looks good.
Reviewed-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han

> ---
>  arch/arm/kernel/topology.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
> index 85a87370f144..0bc94b1fd1ae 100644
> --- a/arch/arm/kernel/topology.c
> +++ b/arch/arm/kernel/topology.c
> @@ -68,16 +68,16 @@ struct cpu_efficiency {
>   * Processors that are not defined in the table,
>   * use the default SCHED_POWER_SCALE value for cpu_scale.
>   */
> -struct cpu_efficiency table_efficiency[] = {
> +static const struct cpu_efficiency table_efficiency[] = {
>  	{"arm,cortex-a15", 3891},
>  	{"arm,cortex-a7",  2048},
>  	{NULL, },
>  };
> 
> -unsigned long *__cpu_capacity;
> +static unsigned long *__cpu_capacity;
>  #define cpu_capacity(cpu)	__cpu_capacity[cpu]
> 
> -unsigned long middle_capacity = 1;
> +static unsigned long middle_capacity = 1;
> 
>  /*
>   * Iterate all CPUs' descriptor in DT and compute the efficiency
> @@ -89,7 +89,7 @@ unsigned long middle_capacity = 1;
>   */
>  static void __init parse_dt_topology(void)
>  {
> -	struct cpu_efficiency *cpu_eff;
> +	const struct cpu_efficiency *cpu_eff;
>  	struct device_node *cn = NULL;
>  	unsigned long min_capacity = (unsigned long)(-1);
>  	unsigned long max_capacity = 0;
> @@ -158,7 +158,7 @@ static void __init parse_dt_topology(void)
>   * boot. The update of all CPUs is in O(n^2) for heteregeneous system but the
>   * function returns directly for SMP system.
>   */
> -void update_cpu_power(unsigned int cpu)
> +static void update_cpu_power(unsigned int cpu)
>  {
>  	if (!cpu_capacity(cpu))
>  		return;
> @@ -185,7 +185,7 @@ const struct cpumask *cpu_coregroup_mask(int cpu)
>  	return &cpu_topology[cpu].core_sibling;
>  }
> 
> -void update_siblings_masks(unsigned int cpuid)
> +static void update_siblings_masks(unsigned int cpuid)
>  {
>  	struct cputopo_arm *cpu_topo, *cpuid_topo = &cpu_topology[cpuid];
>  	int cpu;
> --
> 1.8.5.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
