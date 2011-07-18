From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 18 Jul 2011 21:09:28 +0100
Subject: [PATCH] CNS3xxx: add SMP support
In-Reply-To: <1311018901-26726-1-git-send-email-kaloz@openwrt.org>
References: <1311018901-26726-1-git-send-email-kaloz@openwrt.org>
Message-ID: <20110718200928.GA13248@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 18, 2011 at 09:55:01PM +0200, Imre Kaloz wrote:
> diff --git a/arch/arm/mach-cns3xxx/Kconfig b/arch/arm/mach-cns3xxx/Kconfig
> index 29b13f2..a13f401 100644
> --- a/arch/arm/mach-cns3xxx/Kconfig
> +++ b/arch/arm/mach-cns3xxx/Kconfig
> @@ -3,6 +3,7 @@ menu "CNS3XXX platform type"
>  
>  config MACH_CNS3420VB
>  	bool "Support for CNS3420 Validation Board"
> +	select HAVE_ARM_SCU if SMP

This is not required:

config SMP
        select HAVE_ARM_SCU if !ARCH_MSM_SCORPIONMP

So you get the ARM SCU if you enable SMP anyway (if you're not scorpionmp).

> diff --git a/arch/arm/mach-cns3xxx/headsmp.S b/arch/arm/mach-cns3xxx/headsmp.S
> new file mode 100644
> index 0000000..456fd67
> --- /dev/null
> +++ b/arch/arm/mach-cns3xxx/headsmp.S
> @@ -0,0 +1,42 @@
> +/*
> + *  linux/arch/arm/mach-cns3xxx/headsmp.S
> + *
> + *  Cloned from linux/arch/arm/plat-versatile/headsmp.S
> + *
> + *  Copyright (c) 2003 ARM Limited
> + *  All Rights Reserved
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#include <linux/linkage.h>
> +#include <linux/init.h>
> +
> +	__INIT

This should (in all likely) be __CPUINIT so that secondary CPUs can
re-enter this on hot-plug, or if you boot with max_cpus= lower than
the number of CPUs you have and you later hotplug them in.

> diff --git a/arch/arm/mach-cns3xxx/hotplug.c b/arch/arm/mach-cns3xxx/hotplug.c
> new file mode 100644
> index 0000000..be0d499
> --- /dev/null
> +++ b/arch/arm/mach-cns3xxx/hotplug.c
> @@ -0,0 +1,130 @@
> +/* linux arch/arm/mach-cns3xxx/hotplug.c
> + *
> + *  Cloned from linux/arch/arm/mach-realview/hotplug.c
> + *
> + *  Copyright (C) 2002 ARM Ltd.
> + *  All Rights Reserved
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#include <linux/kernel.h>
> +#include <linux/errno.h>
> +#include <linux/smp.h>
> +
> +#include <asm/cacheflush.h>
> +
> +extern volatile int pen_release;
> +
> +static inline void cpu_enter_lowpower(void)
> +{
> +	unsigned int v;
> +
> +	flush_cache_all();
> +	asm volatile(
> +	"	mcr	p15, 0, %1, c7, c5, 0\n"
> +	"	mcr	p15, 0, %1, c7, c10, 4\n"
> +	/*
> +	 * Turn off coherency
> +	 */
> +	"	mrc	p15, 0, %0, c1, c0, 1\n"
> +	"	bic	%0, %0, %3\n"
> +	"	mcr	p15, 0, %0, c1, c0, 1\n"
> +	"	mrc	p15, 0, %0, c1, c0, 0\n"
> +	"	bic	%0, %0, %2\n"
> +	"	mcr	p15, 0, %0, c1, c0, 0\n"
> +	  : "=&r" (v)
> +	  : "r" (0), "Ir" (CR_C), "Ir" (0x40)
> +	  : "cc");
> +}
> +
> +static inline void cpu_leave_lowpower(void)
> +{
> +	unsigned int v;
> +
> +	asm volatile(
> +	"mrc	p15, 0, %0, c1, c0, 0\n"
> +	"	orr	%0, %0, %1\n"
> +	"	mcr	p15, 0, %0, c1, c0, 0\n"
> +	"	mrc	p15, 0, %0, c1, c0, 1\n"
> +	"	orr	%0, %0, %2\n"
> +	"	mcr	p15, 0, %0, c1, c0, 1\n"
> +	  : "=&r" (v)
> +	  : "Ir" (CR_C), "Ir" (0x40)
> +	  : "cc");
> +}
> +
> +static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
> +{
> +	/*
> +	 * there is no power-control hardware on this platform, so all
> +	 * we can do is put the core into WFI; this is safe as the calling
> +	 * code will have already disabled interrupts
> +	 */
> +	for (;;) {
> +		/*
> +		 * here's the WFI
> +		 */
> +		asm(".word	0xe320f003\n"
> +		    :
> +		    :
> +		    : "memory", "cc");
> +
> +		if (pen_release == cpu) {
> +			/*
> +			 * OK, proper wakeup, we're done
> +			 */
> +			break;
> +		}
> +
> +		/*
> +		 * Getting here, means that we have come out of WFI without
> +		 * having been woken up - this shouldn't happen
> +		 *
> +		 * Just note it happening - when we're woken, we can report
> +		 * its occurrence.
> +		 */
> +		(*spurious)++;
> +	}
> +}
> +
> +int platform_cpu_kill(unsigned int cpu)
> +{
> +	return 1;
> +}
> +
> +/*
> + * platform-specific code to shutdown a CPU
> + *
> + * Called with IRQs disabled
> + */
> +void platform_cpu_die(unsigned int cpu)
> +{
> +	int spurious = 0;
> +
> +	/*
> +	 * we're ready for shutdown now, so do it
> +	 */
> +	cpu_enter_lowpower();
> +	platform_do_lowpower(cpu, &spurious);
> +
> +	/*
> +	 * bring this CPU back into the world of cache
> +	 * coherency, and then restore interrupts
> +	 */
> +	cpu_leave_lowpower();
> +
> +	if (spurious)
> +		pr_warn("CPU%u: %u spurious wakeup calls\n", cpu, spurious);
> +}
> +
> +int platform_cpu_disable(unsigned int cpu)
> +{
> +	/*
> +	 * we don't allow CPU 0 to be shutdown (it is still too special
> +	 * e.g. clock tick interrupts)
> +	 */
> +	return cpu == 0 ? -EPERM : 0;
> +}

Have you thought about whether that's the best method?  Can you put a
secondary CPU back into reset or power down?  If so, it may be a good
idea to do that, rather than just copying the Realview code.

> +static void __iomem *scu_base_addr(void)
> +{
> +	return (void __iomem *)(CNS3XXX_TC11MP_SCU_BASE_VIRT);
> +}

If it's at a fixed address then don't do this.  Use a macro directly.
Even better - make sure your macros like CNS3XXX_TC11MP_SCU_BASE_VIRT
are correctly typed in the first place and avoid littering code with
casts.

> +	/*
> +	 * Send the secondary CPU a soft interrupt, thereby causing
> +	 * the boot monitor to read the system wide flags register,
> +	 * and branch to the address found there.
> +	 */
> +	gic_raise_softirq(cpumask_of(cpu), 1);

Will IPI0 do?  If so, please use IPI0.

> +void __init platform_smp_prepare_cpus(unsigned int max_cpus)
> +{
> +	int i;
> +
> +	/*
> +	 * Initialise the present map, which describes the set of CPUs
> +	 * actually populated at the present time.
> +	 */
> +	for (i = 0; i < max_cpus; i++)
> +		set_cpu_present(i, true);
> +
> +	scu_enable(scu_base_addr());
> +
> +	/*
> +	 * Write the address of secondary startup into the
> +	 * system-wide flags register. The boot monitor waits
> +	 * until it receives a soft interrupt, and then the
> +	 * secondary CPU branches to this address.
> +	 */
> +	__raw_writel(virt_to_phys(cns3xxx_secondary_startup),
> +			(void __iomem *)(CNS3XXX_MISC_BASE_VIRT + 0x0600));

Best move this into your boot_secondary() function so that hotplug works
after boot.

> +}

The above will change at the next merge window - if your CPUs are 0..N
then there'll be no need to touch the cpu present array.  So the only
thing left should be the call to scu_enable() here.
