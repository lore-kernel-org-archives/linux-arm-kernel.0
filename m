From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 17 Sep 2015 22:15:46 +0200
Subject: [PATCH v2 8/9] ARM: rockchip: add support smp for rk3036
In-Reply-To: <1442486286-1873-1-git-send-email-zhengxing@rock-chips.com>
References: <1442478540-15068-1-git-send-email-zhengxing@rock-chips.com>
 <1442486286-1873-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <22222181.r5MSqEbWpB@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 17. September 2015, 18:38:06 schrieb Xing Zheng:
> The rk3036 is dual-core soc, we can use this patch to enable cpu1
> enter boot secondary, and hotplug(online/offline).
> 
> Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
> ---
> 
> Changes in v2: None
> 
>  arch/arm/mach-rockchip/platsmp.c |  121
> ++++++++++++++++++++++++++++++++++++++ 1 file changed, 121 insertions(+)
> 
> diff --git a/arch/arm/mach-rockchip/platsmp.c
> b/arch/arm/mach-rockchip/platsmp.c index 3e7a4b7..14218eb 100644
> --- a/arch/arm/mach-rockchip/platsmp.c
> +++ b/arch/arm/mach-rockchip/platsmp.c
> @@ -34,6 +34,8 @@
> 
>  static void __iomem *scu_base_addr;
>  static void __iomem *sram_base_addr;
> +static void __iomem *cru_base_addr;
> +
>  static int ncores;
> 
>  #define PMU_PWRDN_CON		0x08
> @@ -41,6 +43,8 @@ static int ncores;
> 
>  #define PMU_PWRDN_SCU		4
> 
> +#define RK3036_SOFTRST_CON(x)	((x) * 0x4 + 0x110)
> +
>  static struct regmap *pmu;
> 
>  static int pmu_power_domain_is_on(int pd)
> @@ -184,6 +188,7 @@ static int __init rockchip_smp_prepare_sram(struct
> device_node *node) }
> 
>  	rsize = resource_size(&res);
> +
>  	if (rsize < trampoline_sz) {
>  		pr_err("%s: reserved block with size 0x%x is to small for trampoline 
size
> 0x%x\n", __func__, rsize, trampoline_sz);
> @@ -350,3 +355,119 @@ static struct smp_operations rockchip_smp_ops
> __initdata = { };
> 
>  CPU_METHOD_OF_DECLARE(rk3066_smp, "rockchip,rk3066-smp",
> &rockchip_smp_ops); +
> +/* for rk3036 */
> +
> +static int rk3036_set_power_domain(int pd, bool on)
> +{
> +	/* there are 2cpus on rk3036 soc, we just need to be care cpu1 */
> +	if (pd != 1)
> +		return 0;
> +
> +	if (on)
> +		writel_relaxed(0x20000, cru_base_addr + RK3036_SOFTRST_CON(0));
> +	else
> +		writel_relaxed(0x20002, cru_base_addr + RK3036_SOFTRST_CON(0));

this is definitly the wrong way. The reset handling is the same as on the 
rk3288 - so you can use the regular reset mechanism like the other socs and 
should definitly _never_ write to the cru directly.

The only visible difference is that you cannot control the power-domains of 
the cpu cores. Its sibling the rk3128 seems to have controllable power domains 
again.

I'm still pondering how to make this future proof...


Heiko

> +
> +	dsb();
> +
> +	return 0;
> +}
> +
> +static void __init rk3036_smp_prepare_cpus(unsigned int max_cpus)
> +{
> +	struct device_node *node;
> +	unsigned int l2ctlr;
> +	unsigned int i, cpu;
> +
> +	/* get cru_base_addr */
> +	node = of_find_compatible_node(NULL, NULL, "rockchip,rk3036-cru");
> +	if (!node) {
> +		pr_err("%s: could not find cru dt node\n", __func__);
> +		return;
> +	}
> +
> +	cru_base_addr = of_iomap(node, 0);
> +	if (!cru_base_addr) {
> +		pr_err("%s: could not map cru registers\n", __func__);
> +		return;
> +	}
> +
> +	/* get sram_base_addr */
> +	node = of_find_compatible_node(NULL, NULL, "rockchip,rk3036-smp-sram");
> +	if (!node) {
> +		pr_err("%s: could not find sram dt node\n", __func__);
> +		return;
> +	}
> +
> +	sram_base_addr = of_iomap(node, 0);
> +	if (!sram_base_addr) {
> +		pr_err("%s: could not map sram registers\n", __func__);
> +		return;
> +	}
> +
> +	/* get ncores */
> +	asm ("mrc p15, 1, %0, c9, c0, 2\n" : "=r" (l2ctlr));
> +	ncores = ((l2ctlr >> 24) & 0x3) + 1;
> +	cpu = MPIDR_AFFINITY_LEVEL(read_cpuid_mpidr(), 0);
> +
> +	/* Make sure that all cores except the first are really off */
> +	for (i = 1; i < ncores; i++)
> +		rk3036_set_power_domain(0 + i, false);
> +}
> +
> +static int rk3036_boot_secondary(unsigned int cpu, struct task_struct
> *idle) +{
> +	if (cpu >= ncores) {
> +		pr_err("%s: cpu %d outside maximum number of cpus %d\n",
> +			__func__, cpu, ncores);
> +		return -ENXIO;
> +	}
> +
> +	/* start the core */
> +	rk3036_set_power_domain(0 + cpu, true);
> +
> +	/*
> +	 * We need to wait a moment after soft reset CPUx on rk3036,
> +	 * otherwise, CPUx will startup failed.
> +	 */
> +	udelay(10);
> +	writel(virt_to_phys(secondary_startup), sram_base_addr + 8);
> +	writel(0xDEADBEAF, sram_base_addr + 4);
> +	dsb_sev();
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_HOTPLUG_CPU
> +static int rk3066_cpu_kill(unsigned int cpu)
> +{
> +	/*
> +	 * We need a delay here to ensure that the dying CPU can finish
> +	 * executing v7_coherency_exit() and reach the WFI/WFE state
> +	 * prior to having the power domain disabled.
> +	 */
> +	mdelay(1);
> +
> +	rk3036_set_power_domain(0 + cpu, false);
> +
> +	return 1;
> +}
> +
> +static void rk3066_cpu_die(unsigned int cpu)
> +{
> +	v7_exit_coherency_flush(louis);
> +	while (1)
> +		cpu_do_idle();
> +}
> +#endif
> +
> +static struct smp_operations rk3036_smp_ops __initdata = {
> +	.smp_prepare_cpus	= rk3036_smp_prepare_cpus,
> +	.smp_boot_secondary	= rk3036_boot_secondary,
> +#ifdef CONFIG_HOTPLUG_CPU
> +	.cpu_kill		= rk3066_cpu_kill,
> +	.cpu_die		= rk3066_cpu_die,
> +#endif
> +};
> +CPU_METHOD_OF_DECLARE(rk3036_smp, "rockchip,rk3036-smp", &rk3036_smp_ops);
