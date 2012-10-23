From: B18647@freescale.com (Lee Robert-B18647)
Date: Tue, 23 Oct 2012 16:09:08 +0000
Subject: [PATCH 10/10] ARM: imx6q: implement WAIT mode with coupled cpuidle
In-Reply-To: <1351005779-30347-11-git-send-email-shawn.guo@linaro.org>
References: <1351005779-30347-1-git-send-email-shawn.guo@linaro.org>
 <1351005779-30347-11-git-send-email-shawn.guo@linaro.org>
Message-ID: <D9DA41B75289BC488A38AE7992B7866301261C4A@039-SN2MPN1-022.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Shawn,

For your SRPG implementation, a couple of weeks ago an issue was found that affects all i.MX6 SRPG functionality that requires a work around for 100% reliable operation.  It's my understanding that the workaround is almost but not yet finalized.  Ranjani is most familiar with this issue so you and her can discuss further.

Best Regards,
Rob

> -----Original Message-----
> From: Shawn Guo [mailto:shawn.guo at linaro.org]
> Sent: Tuesday, October 23, 2012 10:23 AM
> To: linux-arm-kernel at lists.infradead.org
> Cc: Sascha Hauer; Lee Robert-B18647; Shawn Guo
> Subject: [PATCH 10/10] ARM: imx6q: implement WAIT mode with coupled
> cpuidle
> 
> The imx6q has a low power mode named WAIT.  When all cores are in WFI,
> imx6q will go into WAIT mode, and whenever there is a wakeup interrupt,
> it will exit WAIT mode.  Software can configure hardware behavior
> during WAIT mode, clock gating or power gating for ARM core.
> 
> This patch adds two more cpuidle states, wait and srpg, implementing
> the ARM clock gating and power gating in WAIT mode respectively.  They
> are added as coupled cpuidle states.  Though imx6q hardware already
> handles sequencing, the voting provided by coupled cpuidle is still
> quite useful, which will allow the system to at least get into clock
> gating when one cpu wants clock gating and the other wants power
> gating.
> 
> As WAIT mode is broken on TO1.0 silicon, the feature is only provided
> for revision later than TO1.0.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  arch/arm/mach-imx/Kconfig         |    1 +
>  arch/arm/mach-imx/common.h        |    1 +
>  arch/arm/mach-imx/cpuidle-imx6q.c |  155
> ++++++++++++++++++++++++++++++++++++-
>  arch/arm/mach-imx/cpuidle.c       |    3 +
>  arch/arm/mach-imx/headsmp.S       |   56 ++++++++++++++
>  arch/arm/mach-imx/mach-imx6q.c    |    7 +-
>  arch/arm/mach-imx/platsmp.c       |    5 ++
>  7 files changed, 225 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index 3ce2771..08435a6 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -831,6 +831,7 @@ config SOC_IMX6Q
>  	bool "i.MX6 Quad support"
>  	select ARCH_HAS_CPUFREQ
>  	select ARCH_HAS_OPP
> +	select ARCH_NEEDS_CPU_IDLE_COUPLED if SMP
>  	select ARM_CPU_SUSPEND if PM
>  	select ARM_ERRATA_743622
>  	select ARM_ERRATA_751472
> diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
> index ea11bbc..a3fe18b 100644
> --- a/arch/arm/mach-imx/common.h
> +++ b/arch/arm/mach-imx/common.h
> @@ -121,6 +121,7 @@ extern void imx_lluart_map_io(void);  static inline
> void imx_lluart_map_io(void) {}  #endif  extern void
> v7_cpu_resume(void);
> +extern int v7_suspend_finish(unsigned long val);
>  extern u32 *pl310_get_save_ptr(void);
>  #ifdef CONFIG_SMP
>  extern void v7_secondary_startup(void); diff --git a/arch/arm/mach-
> imx/cpuidle-imx6q.c b/arch/arm/mach-imx/cpuidle-imx6q.c
> index 83facc9..3acd6ce 100644
> --- a/arch/arm/mach-imx/cpuidle-imx6q.c
> +++ b/arch/arm/mach-imx/cpuidle-imx6q.c
> @@ -6,21 +6,172 @@
>   * published by the Free Software Foundation.
>   */
> 
> +#include <linux/clockchips.h>
> +#include <linux/cpu_pm.h>
>  #include <linux/cpuidle.h>
>  #include <linux/module.h>
>  #include <asm/cpuidle.h>
> +#include <asm/proc-fns.h>
> +#include <asm/suspend.h>
> 
> +#include "common.h"
>  #include "cpuidle.h"
> 
> +static atomic_t master = ATOMIC_INIT(0); static u32 g_diag_reg;
> +
> +/*
> + * The diagnostic register holds the ARM core errata bits,
> + * which need to be saved and restored.
> + */
> +static inline void save_cpu_arch_register(void) {
> +	asm("mrc p15, 0, %0, c15, c0, 1" : "=r"(g_diag_reg) : : "cc"); }
> +
> +static inline void restore_cpu_arch_register(void) {
> +	asm("mcr p15, 0, %0, c15, c0, 1" : : "r"(g_diag_reg) : "cc"); }
> +
> +#ifdef CONFIG_SMP
> +static inline void imx6q_wakeup_other_cpus(int cpu) {
> +	struct cpumask online = *cpu_online_mask;
> +	const struct cpumask *others;
> +
> +	cpumask_clear_cpu(cpu, &online);
> +	others = &online;
> +	arch_send_wakeup_ipi_mask(others);
> +}
> +#else
> +static inline void imx6q_wakeup_other_cpus(int cpu) { } #endif
> +
> +static int imx6q_enter_wait(struct cpuidle_device *dev,
> +			    struct cpuidle_driver *drv, int index) {
> +	int cpu = dev->cpu;
> +
> +	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &cpu);
> +
> +	if (atomic_inc_return(&master) == num_online_cpus()) {
> +		imx6q_set_lpm(WAIT_UNCLOCKED);
> +		cpu_do_idle();
> +		imx6q_set_lpm(WAIT_CLOCKED);
> +	} else {
> +		cpu_do_idle();
> +	}
> +
> +	atomic_dec(&master);
> +	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &cpu);
> +
> +	/*
> +	 * The coupled cpuidle requires all cores exit together.
> +	 * Wake up other cores which could still be in idle.
> +	 */
> +	imx6q_wakeup_other_cpus(cpu);
> +
> +	return index;
> +}
> +
> +static inline int imx6q_do_srpg(int cpu) {
> +	imx_set_cpu_jump(cpu, v7_cpu_resume);
> +	return cpu_suspend(cpu, v7_suspend_finish); }
> +
> +static int imx6q_enter_srpg(struct cpuidle_device *dev,
> +			    struct cpuidle_driver *drv, int index) {
> +	int cpu = dev->cpu;
> +	int ret;
> +
> +	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &cpu);
> +
> +	cpu_pm_enter();
> +
> +	if (atomic_inc_return(&master) == num_online_cpus()) {
> +		cpu_cluster_pm_enter();
> +		imx6q_set_lpm(WAIT_UNCLOCKED_POWER_OFF);
> +	}
> +
> +	save_cpu_arch_register();
> +	ret = imx6q_do_srpg(cpu);
> +	/*
> +	 * The ret is 0 if it returns from a successful SRPG,
> +	 * otherwise it just aborts from there.
> +	 */
> +	if (!ret) {
> +		restore_cpu_arch_register();
> +		cpu_pm_exit();
> +	}
> +
> +	if (atomic_dec_return(&master) == num_online_cpus() - 1) {
> +		imx6q_set_lpm(WAIT_CLOCKED);
> +		if (!ret)
> +			cpu_cluster_pm_exit();
> +		else
> +			/*
> +			 * It just aborts from SRPG, so wake up other cores
> +			 * to return exit together.
> +			 */
> +			imx6q_wakeup_other_cpus(cpu);
> +	}
> +
> +	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &cpu);
> +
> +	return ret ? -EBUSY : index;
> +}
> +
> +/*
> + * For each cpu, setup the broadcast timer because local timer
> + * stops for the states other than WFI.
> + */
> +static void imx6q_setup_broadcast_timer(void *arg) {
> +	int cpu = smp_processor_id();
> +
> +	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ON, &cpu); }
> +
>  static struct cpuidle_driver imx6q_cpuidle_driver = {
>  	.name = "imx6q_cpuidle",
>  	.owner = THIS_MODULE,
>  	.en_core_tk_irqen = 1,
> -	.states[0] = ARM_CPUIDLE_WFI_STATE,
> -	.state_count = 1,
> +	.states = {
> +		/* WFI */
> +		ARM_CPUIDLE_WFI_STATE,
> +		/* WAIT */
> +		{
> +			.exit_latency = 50,
> +			.target_residency = 75,
> +			.flags = CPUIDLE_FLAG_TIME_VALID |
> CPUIDLE_FLAG_COUPLED,
> +			.enter = imx6q_enter_wait,
> +			.name = "WAIT",
> +			.desc = "Clock off",
> +		},
> +		/* SRPG */
> +		{
> +			.exit_latency = 1000,
> +			.target_residency = 1200,
> +			.flags = CPUIDLE_FLAG_TIME_VALID |
> CPUIDLE_FLAG_COUPLED,
> +			.enter = imx6q_enter_srpg,
> +			.name = "SRPG",
> +			.desc = "Power off",
> +		},
> +	},
> +	.state_count = 3,
> +	.safe_state_index = 0,
>  };
> 
>  int __init imx6q_cpuidle_init(void)
>  {
> +	/* Set initial power mode */
> +	imx6q_set_lpm(WAIT_CLOCKED);
> +
> +	/* Configure the broadcast timer on each cpu */
> +	on_each_cpu(imx6q_setup_broadcast_timer, NULL, 1);
> +
>  	return imx_cpuidle_init(&imx6q_cpuidle_driver);
>  }
> diff --git a/arch/arm/mach-imx/cpuidle.c b/arch/arm/mach-imx/cpuidle.c
> index d4cb511..05a537f 100644
> --- a/arch/arm/mach-imx/cpuidle.c
> +++ b/arch/arm/mach-imx/cpuidle.c
> @@ -60,6 +60,9 @@ int __init imx_cpuidle_init(struct cpuidle_driver
> *drv)
>  		dev = per_cpu_ptr(imx_cpuidle_devices, cpu_id);
>  		dev->cpu = cpu_id;
>  		dev->state_count = drv->state_count;
> +#ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
> +		dev->coupled_cpus = *cpu_online_mask; #endif
> 
>  		ret = cpuidle_register_device(dev);
>  		if (ret) {
> diff --git a/arch/arm/mach-imx/headsmp.S b/arch/arm/mach-imx/headsmp.S
> index ac8a967..f920962 100644
> --- a/arch/arm/mach-imx/headsmp.S
> +++ b/arch/arm/mach-imx/headsmp.S
> @@ -71,6 +71,62 @@ ENDPROC(v7_secondary_startup)  #endif
> 
>  #ifdef CONFIG_PM
> +ENTRY(v7_suspend_finish)
> +	stmfd	sp!, {r4-r12, lr}
> +
> +	/* Disable D-cache */
> +	mrc	p15, 0, r0, c1, c0, 0
> +	bic	r0, r0, #(1 << 2)		@ clear SCTRL.C
> +	mcr	p15, 0, r0, c1, c0, 0
> +	isb
> +
> +	/* Flush D-cache */
> +	bl	v7_flush_dcache_louis
> +
> +#ifdef CONFIG_SMP
> +	/* Exit coherency */
> +	mrc	p15, 0, r0, c1, c0, 1
> +	bic	r0, r0, #(1 << 6)		@ clear ACTLR.SMP
> +	mcr	p15, 0, r0, c1, c0, 1
> +	isb
> +
> +	/* Invalidate SCU tag RAM for the cpu */
> +	bl	imx_get_scu_base		@ r0 = scu base
> +	mrc	p15, 0, r2, c0, c0, 5 		@ r2 = cpu id
> +	and	r2, r2, #0xf
> +	mov	r2, r2, lsl #2
> +	mov	r1, #0xf
> +	mov	r1, r1, lsl r2
> +	str	r1, [r0, #0xc]
> +	dsb
> +#endif
> +
> +	/*
> +	 * CPU can speculatively prefetch instructions, so add 16 NOPs
> +	 * after WFI per Cortex-A9 pipeline.
> +	 */
> +	wfi
> +	.rept 16
> +	nop
> +	.endr
> +
> +	/* Enable D-cache */
> +	mrc	p15, 0, r0, c1, c0, 0
> +	orr	r0, r0, #(1 << 2)		@ set SCTRL.C
> +	mcr	p15, 0, r0, c1, c0, 0
> +	isb
> +
> +#ifdef CONFIG_SMP
> +	/* Enter coherency */
> +	mrc	p15, 0, r0, c1, c0, 1
> +	orr	r0, r0, #(1 << 6) 		@ set ACTLR.SMP
> +	mcr	p15, 0, r0, c1, c0, 1
> +	isb
> +#endif
> +
> +	ldmfd	sp!, {r4-r12, pc}
> +ENDPROC(v7_suspend_finish)
> +
>  /*
>   * The following code is located into the .data section.  This is to
>   * allow phys_l2x0_saved_regs to be accessed with a relative load diff
> --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
> index 8ecdeb5..9c9dbf8 100644
> --- a/arch/arm/mach-imx/mach-imx6q.c
> +++ b/arch/arm/mach-imx/mach-imx6q.c
> @@ -182,7 +182,12 @@ static void __init imx6q_init_machine(void)
> 
>  static void __init imx6q_init_late(void)  {
> -	imx6q_cpuidle_init();
> +	/*
> +	 * WAIT mode is broken on TO1.0, so there is no point to
> +	 * have cpuidle running on it.
> +	 */
> +	if (imx6q_revision() > IMX_CHIP_REVISION_1_0)
> +		imx6q_cpuidle_init();
>  }
> 
>  static void __init imx6q_map_io(void)
> diff --git a/arch/arm/mach-imx/platsmp.c b/arch/arm/mach-imx/platsmp.c
> index fc25062..dcd590b 100644
> --- a/arch/arm/mach-imx/platsmp.c
> +++ b/arch/arm/mach-imx/platsmp.c
> @@ -24,6 +24,11 @@
> 
>  static void __iomem *scu_base;
> 
> +void __iomem *imx_get_scu_base(void)
> +{
> +	return scu_base;
> +}
> +
>  static struct map_desc scu_io_desc __initdata = {
>  	/* .virtual and .pfn are run-time assigned */
>  	.length		= SZ_4K,
> --
> 1.7.9.5
> 
