From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 11 Nov 2011 10:17:54 +0000
Subject: [PATCH V2 1/5] ARM: exynos4: Add support for AFTR mode cpuidle
 state
In-Reply-To: <1320992977-11589-2-git-send-email-amit.kachhap@linaro.org>
References: <1320992977-11589-1-git-send-email-amit.kachhap@linaro.org>
 <1320992977-11589-2-git-send-email-amit.kachhap@linaro.org>
Message-ID: <20111111101753.GA6292@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Amit,

On Fri, Nov 11, 2011 at 06:29:33AM +0000, Amit Daniel Kachhap wrote:
> This patch adds support for AFTR(ARM OFF TOP RUNNING) mode in
> cpuidle driver for EXYNOS4210. L2 cache keeps their data in this mode.
> This patch adds the code to the latest interfaces to
> save/restore CPU state inclusive of CPU PM notifiers, l2
> resume and cpu_suspend/resume.
> 
> Signed-off-by: Jaecheol Lee <jc.lee@samsung.com>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@linaro.org>
> ---
>  arch/arm/mach-exynos/cpuidle.c          |  148 ++++++++++++++++++++++++++++++-
>  arch/arm/mach-exynos/include/mach/pmu.h |    2 +
>  2 files changed, 146 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
> index c6485d3..857ccc6 100644
> --- a/arch/arm/mach-exynos/cpuidle.c
> +++ b/arch/arm/mach-exynos/cpuidle.c
> @@ -12,13 +12,31 @@
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/cpuidle.h>
> +#include <linux/cpu_pm.h>

Included but not used, why ? Is GIC state kept in AFTR ? Even if it
is, VFP state is certainly gone, so you must call the notifiers anyway.

>  #include <linux/io.h>
> -
> +#include <linux/suspend.h>
> +#include <linux/err.h>
>  #include <asm/proc-fns.h>
> +#include <asm/smp_scu.h>
> +#include <asm/suspend.h>
> +#include <asm/unified.h>
> +#include <mach/regs-pmu.h>
> +#include <mach/pmu.h>
> +
> +#include <plat/exynos4.h>
> +#include <plat/cpu.h>
> +
> +#define REG_DIRECTGO_ADDR	(samsung_rev() == EXYNOS4210_REV_1_1 ? \
> +				S5P_INFORM7 : (S5P_VA_SYSRAM + 0x24))
> +#define REG_DIRECTGO_FLAG	(samsung_rev() == EXYNOS4210_REV_1_1 ? \
> +				S5P_INFORM6 : (S5P_VA_SYSRAM + 0x20))
>  
>  static int exynos4_enter_idle(struct cpuidle_device *dev,
>  			struct cpuidle_driver *drv,
>  			      int index);
> +static int exynos4_enter_lowpower(struct cpuidle_device *dev,
> +				struct cpuidle_driver *drv,
> +				int index);
>  
>  static struct cpuidle_state exynos4_cpuidle_set[] = {
>  	[0] = {
> @@ -26,9 +44,17 @@ static struct cpuidle_state exynos4_cpuidle_set[] = {
>  		.exit_latency		= 1,
>  		.target_residency	= 100000,
>  		.flags			= CPUIDLE_FLAG_TIME_VALID,
> -		.name			= "IDLE",
> +		.name			= "C0",
>  		.desc			= "ARM clock gating(WFI)",
>  	},
> +	[1] = {
> +		.enter			= exynos4_enter_lowpower,
> +		.exit_latency		= 300,
> +		.target_residency	= 100000,
> +		.flags			= CPUIDLE_FLAG_TIME_VALID,
> +		.name			= "C1",
> +		.desc			= "ARM power down",
> +	},
>  };
>  
>  static DEFINE_PER_CPU(struct cpuidle_device, exynos4_cpuidle_device);
> @@ -38,9 +64,95 @@ static struct cpuidle_driver exynos4_idle_driver = {
>  	.owner		= THIS_MODULE,
>  };
>  
> +/* Ext-GIC nIRQ/nFIQ is the only wakeup source in AFTR */
> +static void exynos4_set_wakeupmask(void)
> +{
> +	__raw_writel(0x0000ff3e, S5P_WAKEUP_MASK);
> +}
> +
> +static unsigned int g_pwr_ctrl, g_diag_reg;
> +
> +static void save_cpu_arch_register(void)
> +{
> +	/*read power control register*/
> +	asm("mrc p15, 0, %0, c15, c0, 0" : "=r"(g_pwr_ctrl) : : "cc");
> +	/*read diagnostic register*/
> +	asm("mrc p15, 0, %0, c15, c0, 1" : "=r"(g_diag_reg) : : "cc");
> +	return;
> +}
> +
> +static void restore_cpu_arch_register(void)
> +{
> +	/*write power control register*/
> +	asm("mcr p15, 0, %0, c15, c0, 0" : : "r"(g_pwr_ctrl) : "cc");
> +	/*write diagnostic register*/
> +	asm("mcr p15, 0, %0, c15, c0, 1" : : "r"(g_diag_reg) : "cc");
> +	return;
> +}
> +
> +static int idle_finisher(unsigned long flags)
> +{
> +	cpu_do_idle();
> +	return 1;
> +}
> +
> +static int exynos4_enter_core0_aftr(struct cpuidle_device *dev,
> +				struct cpuidle_driver *drv,
> +				int index)
> +{
> +	struct timeval before, after;
> +	int idle_time;
> +	unsigned long tmp;
> +
> +	local_irq_disable();
> +	do_gettimeofday(&before);
> +
> +	exynos4_set_wakeupmask();
> +
> +	/* Set value of power down register for aftr mode */
> +	exynos4_sys_powerdown_conf(SYS_AFTR);
> +
> +	save_cpu_arch_register();
> +

You must call the notifiers here, at least cpu_pm_enter();

> +	/* Setting Central Sequence Register for power down mode */
> +	tmp = __raw_readl(S5P_CENTRAL_SEQ_CONFIGURATION);
> +	tmp &= ~S5P_CENTRAL_LOWPWR_CFG;
> +	__raw_writel(tmp, S5P_CENTRAL_SEQ_CONFIGURATION);
> +
> +	cpu_suspend(0, idle_finisher);
> +
> +	scu_enable(S5P_VA_SCU);
> +

Again, you need to resume (VFP, if GIC is kept) through notifiers here, 
I do not understand why that code has been removed.

Lorenzo
