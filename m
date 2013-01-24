From: robherring2@gmail.com (Rob Herring)
Date: Thu, 24 Jan 2013 11:51:39 -0600
Subject: [PATCH 4/4] irqchip: gic: Perform the gic_secondary_init() call
 via CPU notifier
In-Reply-To: <1358963974-5496-5-git-send-email-catalin.marinas@arm.com>
References: <1358963974-5496-1-git-send-email-catalin.marinas@arm.com>
 <1358963974-5496-5-git-send-email-catalin.marinas@arm.com>
Message-ID: <510174AB.7010102@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/23/2013 11:59 AM, Catalin Marinas wrote:
> All the calls to gic_secondary_init() pass 0 as the first argument.
> Since this function is called on each CPU when starting, it can be done
> in a platform-independent way via a CPU notifier registered by the GIC
> code.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: David Brown <davidb@codeaurora.org>
> Cc: Daniel Walker <dwalker@fifo99.com>
> Cc: Bryan Huntsman <bryanh@codeaurora.org>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Dinh Nguyen <dinguyen@altera.com>
> Cc: Viresh Kumar <viresh.linux@gmail.com>
> Cc: Shiraz Hashim <shiraz.hashim@st.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> ---

Acked-by: Rob Herring <rob.herring@calxeda.com>

> 
> Randomly chosen CPU notifier priority. I can add a definition somewhere
> though they don't seem to be used much and cause conflicts.
> 
>  arch/arm/mach-exynos/platsmp.c       |  8 --------
>  arch/arm/mach-highbank/platsmp.c     |  7 -------
>  arch/arm/mach-imx/platsmp.c          | 12 ------------
>  arch/arm/mach-msm/platsmp.c          |  8 --------
>  arch/arm/mach-omap2/omap-smp.c       |  7 -------
>  arch/arm/mach-shmobile/smp-emev2.c   |  7 -------
>  arch/arm/mach-shmobile/smp-r8a7779.c |  7 -------
>  arch/arm/mach-shmobile/smp-sh73a0.c  |  7 -------
>  arch/arm/mach-socfpga/platsmp.c      | 12 ------------
>  arch/arm/mach-spear13xx/platsmp.c    |  8 --------
>  arch/arm/mach-tegra/platsmp.c        |  8 --------
>  arch/arm/mach-ux500/platsmp.c        |  8 --------
>  arch/arm/plat-versatile/platsmp.c    |  8 --------
>  drivers/irqchip/irq-gic.c            | 28 +++++++++++++++++++++-------
>  include/linux/irqchip/arm-gic.h      |  1 -
>  15 files changed, 21 insertions(+), 115 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
> index a083e05..a0e8ff7 100644
> --- a/arch/arm/mach-exynos/platsmp.c
> +++ b/arch/arm/mach-exynos/platsmp.c
> @@ -20,7 +20,6 @@
>  #include <linux/jiffies.h>
>  #include <linux/smp.h>
>  #include <linux/io.h>
> -#include <linux/irqchip/arm-gic.h>
>  
>  #include <asm/cacheflush.h>
>  #include <asm/smp_plat.h>
> @@ -77,13 +76,6 @@ static DEFINE_SPINLOCK(boot_lock);
>  static void __cpuinit exynos_secondary_init(unsigned int cpu)
>  {
>  	/*
> -	 * if any interrupts are already enabled for the primary
> -	 * core (e.g. timer irq), then they will not have been enabled
> -	 * for us: do so
> -	 */
> -	gic_secondary_init(0);
> -
> -	/*
>  	 * let the primary processor know we're out of the
>  	 * pen, then head off into the C entry point
>  	 */
> diff --git a/arch/arm/mach-highbank/platsmp.c b/arch/arm/mach-highbank/platsmp.c
> index 8797a70..a984573 100644
> --- a/arch/arm/mach-highbank/platsmp.c
> +++ b/arch/arm/mach-highbank/platsmp.c
> @@ -17,7 +17,6 @@
>  #include <linux/init.h>
>  #include <linux/smp.h>
>  #include <linux/io.h>
> -#include <linux/irqchip/arm-gic.h>
>  
>  #include <asm/smp_scu.h>
>  
> @@ -25,11 +24,6 @@
>  
>  extern void secondary_startup(void);
>  
> -static void __cpuinit highbank_secondary_init(unsigned int cpu)
> -{
> -	gic_secondary_init(0);
> -}
> -
>  static int __cpuinit highbank_boot_secondary(unsigned int cpu, struct task_struct *idle)
>  {
>  	highbank_set_cpu_jump(cpu, secondary_startup);
> @@ -67,7 +61,6 @@ static void __init highbank_smp_prepare_cpus(unsigned int max_cpus)
>  struct smp_operations highbank_smp_ops __initdata = {
>  	.smp_init_cpus		= highbank_smp_init_cpus,
>  	.smp_prepare_cpus	= highbank_smp_prepare_cpus,
> -	.smp_secondary_init	= highbank_secondary_init,
>  	.smp_boot_secondary	= highbank_boot_secondary,
>  #ifdef CONFIG_HOTPLUG_CPU
>  	.cpu_die		= highbank_cpu_die,
> diff --git a/arch/arm/mach-imx/platsmp.c b/arch/arm/mach-imx/platsmp.c
> index b2872ec..7f63dda 100644
> --- a/arch/arm/mach-imx/platsmp.c
> +++ b/arch/arm/mach-imx/platsmp.c
> @@ -12,7 +12,6 @@
>  
>  #include <linux/init.h>
>  #include <linux/smp.h>
> -#include <linux/irqchip/arm-gic.h>
>  #include <asm/page.h>
>  #include <asm/smp_scu.h>
>  #include <asm/mach/map.h>
> @@ -42,16 +41,6 @@ void __init imx_scu_map_io(void)
>  	scu_base = IMX_IO_ADDRESS(base);
>  }
>  
> -static void __cpuinit imx_secondary_init(unsigned int cpu)
> -{
> -	/*
> -	 * if any interrupts are already enabled for the primary
> -	 * core (e.g. timer irq), then they will not have been enabled
> -	 * for us: do so
> -	 */
> -	gic_secondary_init(0);
> -}
> -
>  static int __cpuinit imx_boot_secondary(unsigned int cpu, struct task_struct *idle)
>  {
>  	imx_set_cpu_jump(cpu, v7_secondary_startup);
> @@ -86,7 +75,6 @@ static void __init imx_smp_prepare_cpus(unsigned int max_cpus)
>  struct smp_operations  imx_smp_ops __initdata = {
>  	.smp_init_cpus		= imx_smp_init_cpus,
>  	.smp_prepare_cpus	= imx_smp_prepare_cpus,
> -	.smp_secondary_init	= imx_secondary_init,
>  	.smp_boot_secondary	= imx_boot_secondary,
>  #ifdef CONFIG_HOTPLUG_CPU
>  	.cpu_die		= imx_cpu_die,
> diff --git a/arch/arm/mach-msm/platsmp.c b/arch/arm/mach-msm/platsmp.c
> index 42932865..00cdb0a 100644
> --- a/arch/arm/mach-msm/platsmp.c
> +++ b/arch/arm/mach-msm/platsmp.c
> @@ -15,7 +15,6 @@
>  #include <linux/jiffies.h>
>  #include <linux/smp.h>
>  #include <linux/io.h>
> -#include <linux/irqchip/arm-gic.h>
>  
>  #include <asm/cacheflush.h>
>  #include <asm/cputype.h>
> @@ -42,13 +41,6 @@ static inline int get_core_count(void)
>  static void __cpuinit msm_secondary_init(unsigned int cpu)
>  {
>  	/*
> -	 * if any interrupts are already enabled for the primary
> -	 * core (e.g. timer irq), then they will not have been enabled
> -	 * for us: do so
> -	 */
> -	gic_secondary_init(0);
> -
> -	/*
>  	 * let the primary processor know we're out of the
>  	 * pen, then head off into the C entry point
>  	 */
> diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
> index 3616779..c6ce880 100644
> --- a/arch/arm/mach-omap2/omap-smp.c
> +++ b/arch/arm/mach-omap2/omap-smp.c
> @@ -67,13 +67,6 @@ static void __cpuinit omap4_secondary_init(unsigned int cpu)
>  							4, 0, 0, 0, 0, 0);
>  
>  	/*
> -	 * If any interrupts are already enabled for the primary
> -	 * core (e.g. timer irq), then they will not have been enabled
> -	 * for us: do so
> -	 */
> -	gic_secondary_init(0);
> -
> -	/*
>  	 * Synchronise with the boot thread.
>  	 */
>  	spin_lock(&boot_lock);
> diff --git a/arch/arm/mach-shmobile/smp-emev2.c b/arch/arm/mach-shmobile/smp-emev2.c
> index 953eb1f..384e27d 100644
> --- a/arch/arm/mach-shmobile/smp-emev2.c
> +++ b/arch/arm/mach-shmobile/smp-emev2.c
> @@ -23,7 +23,6 @@
>  #include <linux/spinlock.h>
>  #include <linux/io.h>
>  #include <linux/delay.h>
> -#include <linux/irqchip/arm-gic.h>
>  #include <mach/common.h>
>  #include <mach/emev2.h>
>  #include <asm/smp_plat.h>
> @@ -85,11 +84,6 @@ static int __maybe_unused emev2_cpu_kill(unsigned int cpu)
>  }
>  
>  
> -static void __cpuinit emev2_secondary_init(unsigned int cpu)
> -{
> -	gic_secondary_init(0);
> -}
> -
>  static int __cpuinit emev2_boot_secondary(unsigned int cpu, struct task_struct *idle)
>  {
>  	cpu = cpu_logical_map(cpu);
> @@ -124,7 +118,6 @@ static void __init emev2_smp_init_cpus(void)
>  struct smp_operations emev2_smp_ops __initdata = {
>  	.smp_init_cpus		= emev2_smp_init_cpus,
>  	.smp_prepare_cpus	= emev2_smp_prepare_cpus,
> -	.smp_secondary_init	= emev2_secondary_init,
>  	.smp_boot_secondary	= emev2_boot_secondary,
>  #ifdef CONFIG_HOTPLUG_CPU
>  	.cpu_kill		= emev2_cpu_kill,
> diff --git a/arch/arm/mach-shmobile/smp-r8a7779.c b/arch/arm/mach-shmobile/smp-r8a7779.c
> index 3a4acf2..9949065 100644
> --- a/arch/arm/mach-shmobile/smp-r8a7779.c
> +++ b/arch/arm/mach-shmobile/smp-r8a7779.c
> @@ -23,7 +23,6 @@
>  #include <linux/spinlock.h>
>  #include <linux/io.h>
>  #include <linux/delay.h>
> -#include <linux/irqchip/arm-gic.h>
>  #include <mach/common.h>
>  #include <mach/r8a7779.h>
>  #include <asm/smp_plat.h>
> @@ -132,11 +131,6 @@ static int __maybe_unused r8a7779_cpu_kill(unsigned int cpu)
>  }
>  
>  
> -static void __cpuinit r8a7779_secondary_init(unsigned int cpu)
> -{
> -	gic_secondary_init(0);
> -}
> -
>  static int __cpuinit r8a7779_boot_secondary(unsigned int cpu, struct task_struct *idle)
>  {
>  	struct r8a7779_pm_ch *ch = NULL;
> @@ -186,7 +180,6 @@ static void __init r8a7779_smp_init_cpus(void)
>  struct smp_operations r8a7779_smp_ops  __initdata = {
>  	.smp_init_cpus		= r8a7779_smp_init_cpus,
>  	.smp_prepare_cpus	= r8a7779_smp_prepare_cpus,
> -	.smp_secondary_init	= r8a7779_secondary_init,
>  	.smp_boot_secondary	= r8a7779_boot_secondary,
>  #ifdef CONFIG_HOTPLUG_CPU
>  	.cpu_kill		= r8a7779_cpu_kill,
> diff --git a/arch/arm/mach-shmobile/smp-sh73a0.c b/arch/arm/mach-shmobile/smp-sh73a0.c
> index 9812ea3..f3b4912 100644
> --- a/arch/arm/mach-shmobile/smp-sh73a0.c
> +++ b/arch/arm/mach-shmobile/smp-sh73a0.c
> @@ -23,7 +23,6 @@
>  #include <linux/spinlock.h>
>  #include <linux/io.h>
>  #include <linux/delay.h>
> -#include <linux/irqchip/arm-gic.h>
>  #include <mach/common.h>
>  #include <asm/cacheflush.h>
>  #include <asm/smp_plat.h>
> @@ -59,11 +58,6 @@ static unsigned int __init sh73a0_get_core_count(void)
>  	return scu_get_core_count(scu_base);
>  }
>  
> -static void __cpuinit sh73a0_secondary_init(unsigned int cpu)
> -{
> -	gic_secondary_init(0);
> -}
> -
>  static int __cpuinit sh73a0_boot_secondary(unsigned int cpu, struct task_struct *idle)
>  {
>  	cpu = cpu_logical_map(cpu);
> @@ -138,7 +132,6 @@ static void sh73a0_cpu_die(unsigned int cpu)
>  struct smp_operations sh73a0_smp_ops __initdata = {
>  	.smp_init_cpus		= sh73a0_smp_init_cpus,
>  	.smp_prepare_cpus	= sh73a0_smp_prepare_cpus,
> -	.smp_secondary_init	= sh73a0_secondary_init,
>  	.smp_boot_secondary	= sh73a0_boot_secondary,
>  #ifdef CONFIG_HOTPLUG_CPU
>  	.cpu_kill		= sh73a0_cpu_kill,
> diff --git a/arch/arm/mach-socfpga/platsmp.c b/arch/arm/mach-socfpga/platsmp.c
> index 4e9e69d..4b468ef 100644
> --- a/arch/arm/mach-socfpga/platsmp.c
> +++ b/arch/arm/mach-socfpga/platsmp.c
> @@ -22,7 +22,6 @@
>  #include <linux/io.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> -#include <linux/irqchip/arm-gic.h>
>  
>  #include <asm/cacheflush.h>
>  #include <asm/smp_scu.h>
> @@ -33,16 +32,6 @@
>  extern void __iomem *sys_manager_base_addr;
>  extern void __iomem *rst_manager_base_addr;
>  
> -static void __cpuinit socfpga_secondary_init(unsigned int cpu)
> -{
> -	/*
> -	 * if any interrupts are already enabled for the primary
> -	 * core (e.g. timer irq), then they will not have been enabled
> -	 * for us: do so
> -	 */
> -	gic_secondary_init(0);
> -}
> -
>  static int __cpuinit socfpga_boot_secondary(unsigned int cpu, struct task_struct *idle)
>  {
>  	int trampoline_size = &secondary_trampoline_end - &secondary_trampoline;
> @@ -106,7 +95,6 @@ static void socfpga_cpu_die(unsigned int cpu)
>  struct smp_operations socfpga_smp_ops __initdata = {
>  	.smp_init_cpus		= socfpga_smp_init_cpus,
>  	.smp_prepare_cpus	= socfpga_smp_prepare_cpus,
> -	.smp_secondary_init	= socfpga_secondary_init,
>  	.smp_boot_secondary	= socfpga_boot_secondary,
>  #ifdef CONFIG_HOTPLUG_CPU
>  	.cpu_die		= socfpga_cpu_die,
> diff --git a/arch/arm/mach-spear13xx/platsmp.c b/arch/arm/mach-spear13xx/platsmp.c
> index af4ade6..551c69c 100644
> --- a/arch/arm/mach-spear13xx/platsmp.c
> +++ b/arch/arm/mach-spear13xx/platsmp.c
> @@ -15,7 +15,6 @@
>  #include <linux/jiffies.h>
>  #include <linux/io.h>
>  #include <linux/smp.h>
> -#include <linux/irqchip/arm-gic.h>
>  #include <asm/cacheflush.h>
>  #include <asm/smp_scu.h>
>  #include <mach/spear.h>
> @@ -28,13 +27,6 @@ static void __iomem *scu_base = IOMEM(VA_SCU_BASE);
>  static void __cpuinit spear13xx_secondary_init(unsigned int cpu)
>  {
>  	/*
> -	 * if any interrupts are already enabled for the primary
> -	 * core (e.g. timer irq), then they will not have been enabled
> -	 * for us: do so
> -	 */
> -	gic_secondary_init(0);
> -
> -	/*
>  	 * let the primary processor know we're out of the
>  	 * pen, then head off into the C entry point
>  	 */
> diff --git a/arch/arm/mach-tegra/platsmp.c b/arch/arm/mach-tegra/platsmp.c
> index c72e249..dea94d2 100644
> --- a/arch/arm/mach-tegra/platsmp.c
> +++ b/arch/arm/mach-tegra/platsmp.c
> @@ -18,7 +18,6 @@
>  #include <linux/jiffies.h>
>  #include <linux/smp.h>
>  #include <linux/io.h>
> -#include <linux/irqchip/arm-gic.h>
>  #include <linux/clk/tegra.h>
>  
>  #include <asm/cacheflush.h>
> @@ -45,13 +44,6 @@ static void __iomem *scu_base = IO_ADDRESS(TEGRA_ARM_PERIF_BASE);
>  
>  static void __cpuinit tegra_secondary_init(unsigned int cpu)
>  {
> -	/*
> -	 * if any interrupts are already enabled for the primary
> -	 * core (e.g. timer irq), then they will not have been enabled
> -	 * for us: do so
> -	 */
> -	gic_secondary_init(0);
> -
>  	cpumask_set_cpu(cpu, &tegra_cpu_init_mask);
>  }
>  
> diff --git a/arch/arm/mach-ux500/platsmp.c b/arch/arm/mach-ux500/platsmp.c
> index b8adac9..b4d0735 100644
> --- a/arch/arm/mach-ux500/platsmp.c
> +++ b/arch/arm/mach-ux500/platsmp.c
> @@ -16,7 +16,6 @@
>  #include <linux/device.h>
>  #include <linux/smp.h>
>  #include <linux/io.h>
> -#include <linux/irqchip/arm-gic.h>
>  
>  #include <asm/cacheflush.h>
>  #include <asm/smp_plat.h>
> @@ -55,13 +54,6 @@ static DEFINE_SPINLOCK(boot_lock);
>  static void __cpuinit ux500_secondary_init(unsigned int cpu)
>  {
>  	/*
> -	 * if any interrupts are already enabled for the primary
> -	 * core (e.g. timer irq), then they will not have been enabled
> -	 * for us: do so
> -	 */
> -	gic_secondary_init(0);
> -
> -	/*
>  	 * let the primary processor know we're out of the
>  	 * pen, then head off into the C entry point
>  	 */
> diff --git a/arch/arm/plat-versatile/platsmp.c b/arch/arm/plat-versatile/platsmp.c
> index f2ac155..1e1b2d7 100644
> --- a/arch/arm/plat-versatile/platsmp.c
> +++ b/arch/arm/plat-versatile/platsmp.c
> @@ -14,7 +14,6 @@
>  #include <linux/device.h>
>  #include <linux/jiffies.h>
>  #include <linux/smp.h>
> -#include <linux/irqchip/arm-gic.h>
>  
>  #include <asm/cacheflush.h>
>  #include <asm/smp_plat.h>
> @@ -37,13 +36,6 @@ static DEFINE_SPINLOCK(boot_lock);
>  void __cpuinit versatile_secondary_init(unsigned int cpu)
>  {
>  	/*
> -	 * if any interrupts are already enabled for the primary
> -	 * core (e.g. timer irq), then they will not have been enabled
> -	 * for us: do so
> -	 */
> -	gic_secondary_init(0);
> -
> -	/*
>  	 * let the primary processor know we're out of the
>  	 * pen, then head off into the C entry point
>  	 */
> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> index ef1429a..f103cb8 100644
> --- a/drivers/irqchip/irq-gic.c
> +++ b/drivers/irqchip/irq-gic.c
> @@ -28,6 +28,7 @@
>  #include <linux/module.h>
>  #include <linux/list.h>
>  #include <linux/smp.h>
> +#include <linux/cpu.h>
>  #include <linux/cpu_pm.h>
>  #include <linux/cpumask.h>
>  #include <linux/io.h>
> @@ -678,6 +679,25 @@ static int gic_irq_domain_xlate(struct irq_domain *d,
>  	return 0;
>  }
>  
> +#ifdef CONFIG_SMP
> +static int __cpuinit gic_secondary_init(struct notifier_block *nfb,
> +					unsigned long action, void *hcpu)
> +{
> +	if (action == CPU_STARTING)
> +		gic_cpu_init(&gic_data[0]);
> +	return NOTIFY_OK;
> +}
> +
> +/*
> + * Notifier for enabling the GIC CPU interface. Set an arbitrarily high
> + * priority because the GIC needs to be up before the ARM generic timers.
> + */
> +static struct notifier_block __cpuinitdata gic_cpu_notifier = {
> +	.notifier_call = gic_secondary_init,
> +	.priority = 100,
> +};
> +#endif
> +
>  const struct irq_domain_ops gic_irq_domain_ops = {
>  	.map = gic_irq_domain_map,
>  	.xlate = gic_irq_domain_xlate,
> @@ -768,6 +788,7 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
>  
>  #ifdef CONFIG_SMP
>  	set_smp_cross_call(gic_raise_softirq);
> +	register_cpu_notifier(&gic_cpu_notifier);
>  #endif
>  
>  	set_handle_irq(gic_handle_irq);
> @@ -778,13 +799,6 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
>  	gic_pm_init(gic);
>  }
>  
> -void __cpuinit gic_secondary_init(unsigned int gic_nr)
> -{
> -	BUG_ON(gic_nr >= MAX_GIC_NR);
> -
> -	gic_cpu_init(&gic_data[gic_nr]);
> -}
> -
>  #ifdef CONFIG_OF
>  static int gic_cnt __initdata = 0;
>  
> diff --git a/include/linux/irqchip/arm-gic.h b/include/linux/irqchip/arm-gic.h
> index a67ca55..59e59b3 100644
> --- a/include/linux/irqchip/arm-gic.h
> +++ b/include/linux/irqchip/arm-gic.h
> @@ -36,7 +36,6 @@ extern struct irq_chip gic_arch_extn;
>  
>  void gic_init_bases(unsigned int, int, void __iomem *, void __iomem *,
>  		    u32 offset, struct device_node *);
> -void gic_secondary_init(unsigned int);
>  void gic_cascade_irq(unsigned int gic_nr, unsigned int irq);
>  
>  static inline void gic_init(unsigned int nr, int start,
> 
