From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 14 Apr 2014 19:28:23 +0200
Subject: [PATCH] arm: exynos: generalize power register address calculation
In-Reply-To: <1397041783-18531-1-git-send-email-chander.kashyap@linaro.org>
References: <1396973737-18693-1-git-send-email-chander.kashyap@linaro.org>
 <1397041783-18531-1-git-send-email-chander.kashyap@linaro.org>
Message-ID: <534C1AB7.3020007@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chander,

Few more comments inline.

On 09.04.2014 13:09, Chander Kashyap wrote:
> Currently status/configuration power register values are hard-coded for cpu1.
>
> Make it generic so that it is useful for SoC's with more than two cpus.
>
> Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
> ---
> changes in v2 : Used existing macros for clusterid and cpuid calculation
>
>   arch/arm/mach-exynos/hotplug.c  |   15 ++++++++++++---
>   arch/arm/mach-exynos/platsmp.c  |   20 +++++++++++++++-----
>   arch/arm/mach-exynos/regs-pmu.h |    9 +++++++--
>   3 files changed, 34 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm/mach-exynos/hotplug.c b/arch/arm/mach-exynos/hotplug.c
> index 5eead53..eab6121 100644
> --- a/arch/arm/mach-exynos/hotplug.c
> +++ b/arch/arm/mach-exynos/hotplug.c
> @@ -17,6 +17,7 @@
>
>   #include <asm/cacheflush.h>
>   #include <asm/cp15.h>
> +#include <asm/cputype.h>
>   #include <asm/smp_plat.h>
>
>   #include <plat/cpu.h>
> @@ -92,11 +93,19 @@ static inline void cpu_leave_lowpower(void)
>
>   static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
>   {
> +	unsigned int mpidr, cpunr, cluster;
> +
> +	mpidr = cpu_logical_map(cpu);
> +	cpunr = MPIDR_AFFINITY_LEVEL(mpidr, 0);
> +	cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
> +
> +	/* Maximum possible cpus in a cluster can be 4 */
> +	cpunr += cluster * 4;

This could be put in a helper, as it seems to be used both by hotplug 
and platsmp code. Also 4 could be defined as a preprocessor macro.

>   	for (;;) {
>
> -		/* make cpu1 to be turned off at next WFI command */
> -		if (cpu == 1)
> -			__raw_writel(0, S5P_ARM_CORE1_CONFIGURATION);
> +		/* make cpu to be turned off at next WFI command */
> +		if (cpu)

Do you need this if here at all? I don't think there would be any 
problem with this function called for CPU 0 (which shouldn't happen 
anyway, without CPU 0 hotplug support enabled).

> +			__raw_writel(0, S5P_ARM_CORE_CONFIGURATION(cpunr));
>
>   		/*
>   		 * here's the WFI
> diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
> index 8ea02f6..8d06b2c 100644
> --- a/arch/arm/mach-exynos/platsmp.c
> +++ b/arch/arm/mach-exynos/platsmp.c
> @@ -22,6 +22,7 @@
>   #include <linux/io.h>
>
>   #include <asm/cacheflush.h>
> +#include <asm/cputype.h>
>   #include <asm/smp_plat.h>
>   #include <asm/smp_scu.h>
>   #include <asm/firmware.h>
> @@ -92,6 +93,14 @@ static int exynos_boot_secondary(unsigned int cpu, struct task_struct *idle)
>   {
>   	unsigned long timeout;
>   	unsigned long phys_cpu = cpu_logical_map(cpu);
> +	unsigned int mpidr, cpunr, cluster;
> +
> +	mpidr = cpu_logical_map(cpu);
> +	cpunr = MPIDR_AFFINITY_LEVEL(mpidr, 0);
> +	cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
> +
> +	/* Maximum possible cpus in a cluster can be 4 */
> +	cpunr += cluster * 4;

Here basically the same code is used as in hotplug.c, so a helper would 
be nice. (e.g. cpunr = exynos_pmu_cpunr(mpidr)).

>
>   	/*
>   	 * Set synchronisation state between this boot processor
> @@ -109,14 +118,15 @@ static int exynos_boot_secondary(unsigned int cpu, struct task_struct *idle)
>   	 */
>   	write_pen_release(phys_cpu);
>
> -	if (!(__raw_readl(S5P_ARM_CORE1_STATUS) & S5P_CORE_LOCAL_PWR_EN)) {
> +	if (!(__raw_readl(S5P_ARM_CORE_STATUS(cpunr))
> +		& S5P_CORE_LOCAL_PWR_EN)) {
>   		__raw_writel(S5P_CORE_LOCAL_PWR_EN,
> -			     S5P_ARM_CORE1_CONFIGURATION);
> +			     S5P_ARM_CORE_CONFIGURATION(cpunr));
>
>   		timeout = 10;
>
> -		/* wait max 10 ms until cpu1 is on */
> -		while ((__raw_readl(S5P_ARM_CORE1_STATUS)
> +		/* wait max 10 ms until secondary cpu is on */
> +		while ((__raw_readl(S5P_ARM_CORE_STATUS(cpunr))
>   			& S5P_CORE_LOCAL_PWR_EN) != S5P_CORE_LOCAL_PWR_EN) {
>   			if (timeout-- == 0)
>   				break;
> @@ -125,7 +135,7 @@ static int exynos_boot_secondary(unsigned int cpu, struct task_struct *idle)
>   		}
>
>   		if (timeout == 0) {
> -			printk(KERN_ERR "cpu1 power enable failed");
> +			pr_err("cpu%x power enable failed", cpu);

Shouldn't %d be used instead? "cpu a" on a 10-core machine would sound 
weird.

>   			spin_unlock(&boot_lock);
>   			return -ETIMEDOUT;
>   		}
> diff --git a/arch/arm/mach-exynos/regs-pmu.h b/arch/arm/mach-exynos/regs-pmu.h
> index 7c029ce..16e17e4 100644
> --- a/arch/arm/mach-exynos/regs-pmu.h
> +++ b/arch/arm/mach-exynos/regs-pmu.h
> @@ -104,8 +104,13 @@
>   #define S5P_GPS_LOWPWR				S5P_PMUREG(0x139C)
>   #define S5P_GPS_ALIVE_LOWPWR			S5P_PMUREG(0x13A0)
>
> -#define S5P_ARM_CORE1_CONFIGURATION		S5P_PMUREG(0x2080)
> -#define S5P_ARM_CORE1_STATUS			S5P_PMUREG(0x2084)
> +#define S5P_ARM_CORE0_CONFIGURATION		S5P_PMUREG(0x2000)
> +#define S5P_ARM_CORE0_STATUS			S5P_PMUREG(0x2004)
> +
> +#define S5P_ARM_CORE_CONFIGURATION(_cpunr)	\
> +		(S5P_ARM_CORE0_CONFIGURATION + 0x80 * _cpunr)
> +#define S5P_ARM_CORE_STATUS(_cpunr)		\
> +		(S5P_ARM_CORE0_STATUS + 0x80 * _cpunr)

Please wrap _cpunr in parentheses to make sure that passed value doesn't 
affect the order of computations.

Best regards,
Tomasz
