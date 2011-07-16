From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 16 Jul 2011 13:49:25 +0900
Subject: [PATCH] ARM: EXYNOS4: Add support Core1 Power On/Off with hotplug
	in/out
In-Reply-To: <1309494555-3001-1-git-send-email-junghi.min@samsung.com>
References: <1309494555-3001-1-git-send-email-junghi.min@samsung.com>
Message-ID: <037201cc4373$bf958910$3ec09b30$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

JungHi Min wrote:
> 
> To insert the code for power on/off with pmu control to support hotplug
in/out
> core1
> As for hotplug.c, the codes for core1 to be hotplug in/out is inserted.
> As for regs-pmu.h, S5P_CORE_LOCAL_PWR_EN is defined.
> As for platsmp.c, the codes for core1 to be powered on is inserted.
> 
> Signed-off-by: JungHi Min <junghi.min@samsung.com>
> ---
>  arch/arm/mach-exynos4/hotplug.c               |   13 ++++++----
>  arch/arm/mach-exynos4/include/mach/regs-pmu.h |    1 +
>  arch/arm/mach-exynos4/platsmp.c               |   33
> +++++++++++++++++++++++-
>  3 files changed, 40 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos4/hotplug.c
b/arch/arm/mach-exynos4/hotplug.c
> index 2b5909e..7490789 100644
> --- a/arch/arm/mach-exynos4/hotplug.c
> +++ b/arch/arm/mach-exynos4/hotplug.c
> @@ -13,9 +13,12 @@
>  #include <linux/kernel.h>
>  #include <linux/errno.h>
>  #include <linux/smp.h>
> +#include <linux/io.h>
> 
>  #include <asm/cacheflush.h>
> 
> +#include <mach/regs-pmu.h>
> +
>  extern volatile int pen_release;
> 
>  static inline void cpu_enter_lowpower(void)
> @@ -58,12 +61,12 @@ static inline void cpu_leave_lowpower(void)
> 
>  static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
>  {
> -	/*
> -	 * there is no power-control hardware on this platform, so all
> -	 * we can do is put the core into WFI; this is safe as the calling
> -	 * code will have already disabled interrupts
> -	 */
>  	for (;;) {
> +
> +		/* make cpu1 to be turned off at next WFI command */
> +		if (cpu == 1)
> +			__raw_writel(0, S5P_ARM_CORE1_CONFIGURATION);
> +
>  		/*
>  		 * here's the WFI
>  		 */
> diff --git a/arch/arm/mach-exynos4/include/mach/regs-pmu.h
b/arch/arm/mach-
> exynos4/include/mach/regs-pmu.h
> index a964337..96de0e7 100644
> --- a/arch/arm/mach-exynos4/include/mach/regs-pmu.h
> +++ b/arch/arm/mach-exynos4/include/mach/regs-pmu.h
> @@ -158,6 +158,7 @@
>  #define S5P_PMU_GPS_CONF			S5P_PMUREG(0x3CE0)
> 
>  #define S5P_PMU_SATA_PHY_CONTROL_EN		0x1
> +#define S5P_CORE_LOCAL_PWR_EN			0x3
>  #define S5P_INT_LOCAL_PWR_EN			0x7
> 
>  define S5P_CHECK_SLEEP				0x00000BAD
> diff --git a/arch/arm/mach-exynos4/platsmp.c
b/arch/arm/mach-exynos4/platsmp.c
> index c5e65a0..15aa2c0 100644
> --- a/arch/arm/mach-exynos4/platsmp.c
> +++ b/arch/arm/mach-exynos4/platsmp.c
> @@ -28,9 +28,12 @@
> 
>  #include <mach/hardware.h>
>  #include <mach/regs-clock.h>
> +#include <mach/regs-pmu.h>
> 
>  extern void exynos4_secondary_startup(void);
> 
> +#define CPU1_BOOT_REG S5P_VA_SYSRAM
> +
>  /*
>   * control for which core is the next to come out of the secondary
>   * boot "holding pen"
> @@ -100,16 +103,41 @@ int __cpuinit boot_secondary(unsigned int cpu,
struct
> task_struct *idle)
>  	 */
>  	write_pen_release(cpu);
> 
> +	if (!(__raw_readl(S5P_ARM_CORE1_STATUS) &
> S5P_CORE_LOCAL_PWR_EN)) {
> +		__raw_writel(S5P_CORE_LOCAL_PWR_EN,
> +			     S5P_ARM_CORE1_CONFIGURATION);
> +
> +		timeout = 10;
> +
> +		/* wait max 10 ms until cpu1 is on */
> +		while ((__raw_readl(S5P_ARM_CORE1_STATUS)
> +			& S5P_CORE_LOCAL_PWR_EN) !=
> S5P_CORE_LOCAL_PWR_EN) {
> +			if (timeout-- == 0)
> +				break;
> +
> +			mdelay(1);
> +		}
> +
> +		if (timeout == 0) {
> +			printk(KERN_ERR "cpu1 power enable failed");
> +			spin_unlock(&boot_lock);
> +			return -ETIMEDOUT;
> +		}
> +	}
>  	/*
>  	 * Send the secondary CPU a soft interrupt, thereby causing
>  	 * the boot monitor to read the system wide flags register,
>  	 * and branch to the address found there.
>  	 */
> -	gic_raise_softirq(cpumask_of(cpu), 1);
> 
>  	timeout = jiffies + (1 * HZ);
>  	while (time_before(jiffies, timeout)) {
>  		smp_rmb();
> +
> +		__raw_writel(BSYM(virt_to_phys(exynos4_secondary_startup)),
> +			CPU1_BOOT_REG);
> +		gic_raise_softirq(cpumask_of(cpu), 1);
> +
>  		if (pen_release == -1)
>  			break;
> 
> --
> 1.7.1

OK, applied.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
