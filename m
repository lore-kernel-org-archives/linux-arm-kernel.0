From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 17 Oct 2012 13:18:33 -0400 (EDT)
Subject: [RFC PATCH] ARM: SMP: consolidate holding pen
In-Reply-To: <1350487967-2555-1-git-send-email-marc.zyngier@arm.com>
References: <1350487967-2555-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <alpine.LFD.2.02.1210171316320.16518@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 17 Oct 2012, Marc Zyngier wrote:

> As with other bits of the SMP code, platforms have duplicated a lot
> of the RealView implementation. As an effort to slightly reduce
> the clutter, make the plat-versatile version of the holding pen
> a standard part of the SMP framework.
> 
> Platforms can still provide their own, but those who carried an exact
> duplicate of the Realview code are switched to the common implementation.
> 
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: David Brown <davidb@codeaurora.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Nicolas Pitre <nico@linaro.org>


> ---
>  arch/arm/include/asm/smp.h                     |  2 ++
>  arch/arm/kernel/Makefile                       |  2 +-
>  arch/arm/kernel/smp_pen.S                      | 41 ++++++++++++++++++++++++
>  arch/arm/mach-exynos/Makefile                  |  2 +-
>  arch/arm/mach-exynos/headsmp.S                 | 43 --------------------------
>  arch/arm/mach-exynos/platsmp.c                 |  6 ++--
>  arch/arm/mach-msm/Makefile                     |  2 +-
>  arch/arm/mach-msm/headsmp.S                    | 41 ------------------------
>  arch/arm/mach-msm/platsmp.c                    |  4 +--
>  arch/arm/mach-realview/platsmp.c               |  2 +-
>  arch/arm/mach-ux500/Makefile                   |  2 +-
>  arch/arm/mach-ux500/headsmp.S                  | 39 -----------------------
>  arch/arm/mach-ux500/platsmp.c                  |  5 +--
>  arch/arm/mach-vexpress/platsmp.c               |  2 +-
>  arch/arm/plat-versatile/Makefile               |  2 +-
>  arch/arm/plat-versatile/headsmp.S              | 41 ------------------------
>  arch/arm/plat-versatile/include/plat/platsmp.h |  1 -
>  17 files changed, 54 insertions(+), 183 deletions(-)
>  create mode 100644 arch/arm/kernel/smp_pen.S
>  delete mode 100644 arch/arm/mach-exynos/headsmp.S
>  delete mode 100644 arch/arm/mach-msm/headsmp.S
>  delete mode 100644 arch/arm/mach-ux500/headsmp.S
>  delete mode 100644 arch/arm/plat-versatile/headsmp.S
> 
> diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
> index 2e3be16..538a3ea 100644
> --- a/arch/arm/include/asm/smp.h
> +++ b/arch/arm/include/asm/smp.h
> @@ -72,6 +72,8 @@ struct secondary_data {
>  extern struct secondary_data secondary_data;
>  extern volatile int pen_release;
>  
> +extern void smp_pen_secondary_startup(void);
> +
>  extern int __cpu_disable(void);
>  
>  extern void __cpu_die(unsigned int cpu);
> diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
> index 5bbec7b..505cfc7 100644
> --- a/arch/arm/kernel/Makefile
> +++ b/arch/arm/kernel/Makefile
> @@ -32,7 +32,7 @@ obj-$(CONFIG_ARTHUR)		+= arthur.o
>  obj-$(CONFIG_ISA_DMA)		+= dma-isa.o
>  obj-$(CONFIG_PCI)		+= bios32.o isa.o
>  obj-$(CONFIG_ARM_CPU_SUSPEND)	+= sleep.o suspend.o
> -obj-$(CONFIG_SMP)		+= smp.o smp_tlb.o
> +obj-$(CONFIG_SMP)		+= smp.o smp_tlb.o smp_pen.o
>  obj-$(CONFIG_HAVE_ARM_SCU)	+= smp_scu.o
>  obj-$(CONFIG_HAVE_ARM_TWD)	+= smp_twd.o
>  obj-$(CONFIG_ARM_ARCH_TIMER)	+= arch_timer.o
> diff --git a/arch/arm/kernel/smp_pen.S b/arch/arm/kernel/smp_pen.S
> new file mode 100644
> index 0000000..6c81238
> --- /dev/null
> +++ b/arch/arm/kernel/smp_pen.S
> @@ -0,0 +1,41 @@
> +/*
> + *  linux/arch/arm/kernel/smp_pen.S
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
> +	__CPUINIT
> +
> +/*
> + * Generic specific entry point for secondary CPUs.
> + * This provides a "holding pen" into which all secondary cores are held
> + * until we're ready for them to initialise.
> + */
> +ENTRY(smp_pen_secondary_startup)
> +	mrc	p15, 0, r0, c0, c0, 5
> +	and	r0, r0, #15
> +	adr	r4, 1f
> +	ldmia	r4, {r5, r6}
> +	sub	r4, r4, r5
> +	add	r6, r6, r4
> +pen:	ldr	r7, [r6]
> +	cmp	r7, r0
> +	bne	pen
> +
> +	/*
> +	 * we've been released from the holding pen: secondary_stack
> +	 * should now contain the SVC stack for this core
> +	 */
> +	b	secondary_startup
> +
> +	.align
> +1:	.long	.
> +	.long	pen_release
> +ENDPROC(smp_pen_secondary_startup)
> diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
> index 9b58024..fc19fb9 100644
> --- a/arch/arm/mach-exynos/Makefile
> +++ b/arch/arm/mach-exynos/Makefile
> @@ -24,7 +24,7 @@ obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
>  
>  obj-$(CONFIG_ARCH_EXYNOS)	+= pmu.o
>  
> -obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
> +obj-$(CONFIG_SMP)		+= platsmp.o
>  
>  obj-$(CONFIG_EXYNOS4_MCT)	+= mct.o
>  
> diff --git a/arch/arm/mach-exynos/headsmp.S b/arch/arm/mach-exynos/headsmp.S
> deleted file mode 100644
> index 5364d4b..0000000
> --- a/arch/arm/mach-exynos/headsmp.S
> +++ /dev/null
> @@ -1,43 +0,0 @@
> -/*
> - *  linux/arch/arm/mach-exynos4/headsmp.S
> - *
> - *  Cloned from linux/arch/arm/mach-realview/headsmp.S
> - *
> - *  Copyright (c) 2003 ARM Limited
> - *  All Rights Reserved
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - */
> -#include <linux/linkage.h>
> -#include <linux/init.h>
> -
> -	__CPUINIT
> -
> -/*
> - * exynos4 specific entry point for secondary CPUs.  This provides
> - * a "holding pen" into which all secondary cores are held until we're
> - * ready for them to initialise.
> - */
> -ENTRY(exynos4_secondary_startup)
> -	mrc	p15, 0, r0, c0, c0, 5
> -	and	r0, r0, #15
> -	adr	r4, 1f
> -	ldmia	r4, {r5, r6}
> -	sub	r4, r4, r5
> -	add	r6, r6, r4
> -pen:	ldr	r7, [r6]
> -	cmp	r7, r0
> -	bne	pen
> -
> -	/*
> -	 * we've been released from the holding pen: secondary_stack
> -	 * should now contain the SVC stack for this core
> -	 */
> -	b	secondary_startup
> -ENDPROC(exynos4_secondary_startup)
> -
> -	.align 2
> -1:	.long	.
> -	.long	pen_release
> diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
> index f93d820..bb758b2 100644
> --- a/arch/arm/mach-exynos/platsmp.c
> +++ b/arch/arm/mach-exynos/platsmp.c
> @@ -34,8 +34,6 @@
>  
>  #include "common.h"
>  
> -extern void exynos4_secondary_startup(void);
> -
>  #define CPU1_BOOT_REG		(samsung_rev() == EXYNOS4210_REV_1_1 ? \
>  				S5P_INFORM5 : S5P_VA_SYSRAM)
>  
> @@ -132,7 +130,7 @@ static int __cpuinit exynos_boot_secondary(unsigned int cpu, struct task_struct
>  	while (time_before(jiffies, timeout)) {
>  		smp_rmb();
>  
> -		__raw_writel(virt_to_phys(exynos4_secondary_startup),
> +		__raw_writel(virt_to_phys(smp_pen_secondary_startup),
>  			CPU1_BOOT_REG);
>  		gic_raise_softirq(cpumask_of(cpu), 0);
>  
> @@ -190,7 +188,7 @@ static void __init exynos_smp_prepare_cpus(unsigned int max_cpus)
>  	 * until it receives a soft interrupt, and then the
>  	 * secondary CPU branches to this address.
>  	 */
> -	__raw_writel(virt_to_phys(exynos4_secondary_startup),
> +	__raw_writel(virt_to_phys(smp_pen_secondary_startup),
>  			CPU1_BOOT_REG);
>  }
>  
> diff --git a/arch/arm/mach-msm/Makefile b/arch/arm/mach-msm/Makefile
> index 17519fa..4f1c61f 100644
> --- a/arch/arm/mach-msm/Makefile
> +++ b/arch/arm/mach-msm/Makefile
> @@ -18,7 +18,7 @@ obj-$(CONFIG_MSM_SCM) += scm.o scm-boot.o
>  CFLAGS_scm.o :=$(call as-instr,.arch_extension sec,-DREQUIRES_SEC=1)
>  
>  obj-$(CONFIG_HOTPLUG_CPU) += hotplug.o
> -obj-$(CONFIG_SMP) += headsmp.o platsmp.o
> +obj-$(CONFIG_SMP) += platsmp.o
>  
>  obj-$(CONFIG_MACH_TROUT) += board-trout.o board-trout-gpio.o board-trout-mmc.o devices-msm7x00.o
>  obj-$(CONFIG_MACH_TROUT) += board-trout.o board-trout-gpio.o board-trout-mmc.o board-trout-panel.o devices-msm7x00.o
> diff --git a/arch/arm/mach-msm/headsmp.S b/arch/arm/mach-msm/headsmp.S
> deleted file mode 100644
> index bcd5af2..0000000
> --- a/arch/arm/mach-msm/headsmp.S
> +++ /dev/null
> @@ -1,41 +0,0 @@
> -/*
> - *  linux/arch/arm/mach-realview/headsmp.S
> - *
> - *  Copyright (c) 2003 ARM Limited
> - *  All Rights Reserved
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - */
> -#include <linux/linkage.h>
> -#include <linux/init.h>
> -
> -	__CPUINIT
> -
> -/*
> - * MSM specific entry point for secondary CPUs.  This provides
> - * a "holding pen" into which all secondary cores are held until we're
> - * ready for them to initialise.
> - */
> -ENTRY(msm_secondary_startup)
> -	mrc	p15, 0, r0, c0, c0, 5
> -	and	r0, r0, #15
> -	adr	r4, 1f
> -	ldmia	r4, {r5, r6}
> -	sub	r4, r4, r5
> -	add	r6, r6, r4
> -pen:	ldr	r7, [r6]
> -	cmp	r7, r0
> -	bne	pen
> -
> -	/*
> -	 * we've been released from the holding pen: secondary_stack
> -	 * should now contain the SVC stack for this core
> -	 */
> -	b	secondary_startup
> -ENDPROC(msm_secondary_startup)
> -
> -	.align
> -1:	.long	.
> -	.long	pen_release
> diff --git a/arch/arm/mach-msm/platsmp.c b/arch/arm/mach-msm/platsmp.c
> index 7ed69b69..b58a0ed 100644
> --- a/arch/arm/mach-msm/platsmp.c
> +++ b/arch/arm/mach-msm/platsmp.c
> @@ -29,8 +29,6 @@
>  #define SCSS_CPU1CORE_RESET 0xD80
>  #define SCSS_DBG_STATUS_CORE_PWRDUP 0xE64
>  
> -extern void msm_secondary_startup(void);
> -
>  static DEFINE_SPINLOCK(boot_lock);
>  
>  static inline int get_core_count(void)
> @@ -65,7 +63,7 @@ static void __cpuinit msm_secondary_init(unsigned int cpu)
>  static __cpuinit void prepare_cold_cpu(unsigned int cpu)
>  {
>  	int ret;
> -	ret = scm_set_boot_addr(virt_to_phys(msm_secondary_startup),
> +	ret = scm_set_boot_addr(virt_to_phys(smp_pen_secondary_startup),
>  				SCM_FLAG_COLDBOOT_CPU1);
>  	if (ret == 0) {
>  		void __iomem *sc1_base_ptr;
> diff --git a/arch/arm/mach-realview/platsmp.c b/arch/arm/mach-realview/platsmp.c
> index 300f706..43a8e76 100644
> --- a/arch/arm/mach-realview/platsmp.c
> +++ b/arch/arm/mach-realview/platsmp.c
> @@ -74,7 +74,7 @@ static void __init realview_smp_prepare_cpus(unsigned int max_cpus)
>  	 * until it receives a soft interrupt, and then the
>  	 * secondary CPU branches to this address.
>  	 */
> -	__raw_writel(virt_to_phys(versatile_secondary_startup),
> +	__raw_writel(virt_to_phys(smp_pen_secondary_startup),
>  		     __io_address(REALVIEW_SYS_FLAGSSET));
>  }
>  
> diff --git a/arch/arm/mach-ux500/Makefile b/arch/arm/mach-ux500/Makefile
> index f24710d..7fb617b 100644
> --- a/arch/arm/mach-ux500/Makefile
> +++ b/arch/arm/mach-ux500/Makefile
> @@ -13,5 +13,5 @@ obj-$(CONFIG_MACH_MOP500)	+= board-mop500.o board-mop500-sdi.o \
>  				board-mop500-u8500uib.o \
>  				board-mop500-pins.o \
>  				board-mop500-audio.o
> -obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
> +obj-$(CONFIG_SMP)		+= platsmp.o
>  obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
> diff --git a/arch/arm/mach-ux500/headsmp.S b/arch/arm/mach-ux500/headsmp.S
> deleted file mode 100644
> index 08da5589..0000000
> --- a/arch/arm/mach-ux500/headsmp.S
> +++ /dev/null
> @@ -1,39 +0,0 @@
> -/*
> - *  Copyright (c) 2009 ST-Ericsson
> - *	This file is based  ARM Realview platform
> - *  Copyright (c) 2003 ARM Limited
> - *  All Rights Reserved
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - */
> -#include <linux/linkage.h>
> -#include <linux/init.h>
> -
> -	__INIT
> -
> -/*
> - * U8500 specific entry point for secondary CPUs.
> - */
> -ENTRY(u8500_secondary_startup)
> -	mrc	p15, 0, r0, c0, c0, 5
> -	and	r0, r0, #15
> -	adr	r4, 1f
> -	ldmia	r4, {r5, r6}
> -	sub	r4, r4, r5
> -	add	r6, r6, r4
> -pen:	ldr	r7, [r6]
> -	cmp	r7, r0
> -	bne	pen
> -
> -	/*
> -	 * we've been released from the holding pen: secondary_stack
> -	 * should now contain the SVC stack for this core
> -	 */
> -	b	secondary_startup
> -ENDPROC(u8500_secondary_startup)
> -
> -	.align 2
> -1:	.long	.
> -	.long	pen_release
> diff --git a/arch/arm/mach-ux500/platsmp.c b/arch/arm/mach-ux500/platsmp.c
> index 3db7782..3d946a6 100644
> --- a/arch/arm/mach-ux500/platsmp.c
> +++ b/arch/arm/mach-ux500/platsmp.c
> @@ -24,9 +24,6 @@
>  #include <mach/hardware.h>
>  #include <mach/setup.h>
>  
> -/* This is called from headsmp.S to wakeup the secondary core */
> -extern void u8500_secondary_startup(void);
> -
>  /*
>   * Write pen_release in a way that is guaranteed to be visible to all
>   * observers, irrespective of whether they're taking part in coherency
> @@ -124,7 +121,7 @@ static void __init wakeup_secondary(void)
>  	 * is waiting for. This would wake up the secondary core from WFE
>  	 */
>  #define UX500_CPU1_JUMPADDR_OFFSET 0x1FF4
> -	__raw_writel(virt_to_phys(u8500_secondary_startup),
> +	__raw_writel(virt_to_phys(smp_pen_secondary_startup),
>  		     backupram + UX500_CPU1_JUMPADDR_OFFSET);
>  
>  #define UX500_CPU1_WAKEMAGIC_OFFSET 0x1FF0
> diff --git a/arch/arm/mach-vexpress/platsmp.c b/arch/arm/mach-vexpress/platsmp.c
> index 7db27c8..d1b99a7 100644
> --- a/arch/arm/mach-vexpress/platsmp.c
> +++ b/arch/arm/mach-vexpress/platsmp.c
> @@ -193,7 +193,7 @@ static void __init vexpress_smp_prepare_cpus(unsigned int max_cpus)
>  	 * until it receives a soft interrupt, and then the
>  	 * secondary CPU branches to this address.
>  	 */
> -	v2m_flags_set(virt_to_phys(versatile_secondary_startup));
> +	v2m_flags_set(virt_to_phys(smp_pen_secondary_startup));
>  }
>  
>  struct smp_operations __initdata vexpress_smp_ops = {
> diff --git a/arch/arm/plat-versatile/Makefile b/arch/arm/plat-versatile/Makefile
> index 74cfd94..a0f987e 100644
> --- a/arch/arm/plat-versatile/Makefile
> +++ b/arch/arm/plat-versatile/Makefile
> @@ -5,4 +5,4 @@ obj-$(CONFIG_PLAT_VERSATILE_CLCD) += clcd.o
>  obj-$(CONFIG_PLAT_VERSATILE_FPGA_IRQ) += fpga-irq.o
>  obj-$(CONFIG_PLAT_VERSATILE_LEDS) += leds.o
>  obj-$(CONFIG_PLAT_VERSATILE_SCHED_CLOCK) += sched-clock.o
> -obj-$(CONFIG_SMP) += headsmp.o platsmp.o
> +obj-$(CONFIG_SMP) += platsmp.o
> diff --git a/arch/arm/plat-versatile/headsmp.S b/arch/arm/plat-versatile/headsmp.S
> deleted file mode 100644
> index dd703ef..0000000
> --- a/arch/arm/plat-versatile/headsmp.S
> +++ /dev/null
> @@ -1,41 +0,0 @@
> -/*
> - *  linux/arch/arm/plat-versatile/headsmp.S
> - *
> - *  Copyright (c) 2003 ARM Limited
> - *  All Rights Reserved
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - */
> -#include <linux/linkage.h>
> -#include <linux/init.h>
> -
> -	__INIT
> -
> -/*
> - * Realview/Versatile Express specific entry point for secondary CPUs.
> - * This provides a "holding pen" into which all secondary cores are held
> - * until we're ready for them to initialise.
> - */
> -ENTRY(versatile_secondary_startup)
> -	mrc	p15, 0, r0, c0, c0, 5
> -	and	r0, r0, #15
> -	adr	r4, 1f
> -	ldmia	r4, {r5, r6}
> -	sub	r4, r4, r5
> -	add	r6, r6, r4
> -pen:	ldr	r7, [r6]
> -	cmp	r7, r0
> -	bne	pen
> -
> -	/*
> -	 * we've been released from the holding pen: secondary_stack
> -	 * should now contain the SVC stack for this core
> -	 */
> -	b	secondary_startup
> -
> -	.align
> -1:	.long	.
> -	.long	pen_release
> -ENDPROC(versatile_secondary_startup)
> diff --git a/arch/arm/plat-versatile/include/plat/platsmp.h b/arch/arm/plat-versatile/include/plat/platsmp.h
> index 50fb830..cb893c2 100644
> --- a/arch/arm/plat-versatile/include/plat/platsmp.h
> +++ b/arch/arm/plat-versatile/include/plat/platsmp.h
> @@ -9,6 +9,5 @@
>   * published by the Free Software Foundation.
>   */
>  
> -extern void versatile_secondary_startup(void);
>  extern void versatile_secondary_init(unsigned int cpu);
>  extern int  versatile_boot_secondary(unsigned int cpu, struct task_struct *idle);
> -- 
> 1.7.12
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
