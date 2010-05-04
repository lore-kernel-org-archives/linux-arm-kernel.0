From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 4 May 2010 06:26:43 +0100
Subject: [PATCH] ARM: S5PV210: Add Power Management Support
In-Reply-To: <1272949341-23264-1-git-send-email-kgene.kim@samsung.com>
References: <1272949341-23264-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <20100504052643.GP2589@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 04, 2010 at 02:02:21PM +0900, Kukjin Kim wrote:
> From: Jongpill Lee <boyko.lee@samsung.com>
> 
> This patch adds suspend-to-ram support for S5PV210.
> 
> Signed-off-by: Jongpill Lee <boyko.lee@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
>  arch/arm/mach-s5pv210/Kconfig                |    6 +
>  arch/arm/mach-s5pv210/Makefile               |    1 +
>  arch/arm/mach-s5pv210/include/mach/pm-core.h |   43 ++++++
>  arch/arm/mach-s5pv210/include/mach/pm.h      |   19 +++
>  arch/arm/mach-s5pv210/mach-smdkc110.c        |    8 ++
>  arch/arm/mach-s5pv210/mach-smdkv210.c        |    8 ++
>  arch/arm/mach-s5pv210/pm.c                   |  116 +++++++++++++++++
>  arch/arm/plat-s5p/Makefile                   |    4 +
>  arch/arm/plat-s5p/include/plat/pm-s5p.h      |   23 +++
>  arch/arm/plat-s5p/irq-pm.c                   |  113 +++++++++++++++
>  arch/arm/plat-s5p/pm.c                       |  149 +++++++++++++++++++++
>  arch/arm/plat-s5p/sleep.S                    |  188 ++++++++++++++++++++++++++
>  arch/arm/plat-samsung/pm-gpio.c              |    4 +-
>  13 files changed, 680 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm/mach-s5pv210/include/mach/pm-core.h
>  create mode 100644 arch/arm/mach-s5pv210/include/mach/pm.h
>  create mode 100644 arch/arm/mach-s5pv210/pm.c
>  create mode 100644 arch/arm/plat-s5p/include/plat/pm-s5p.h
>  create mode 100644 arch/arm/plat-s5p/irq-pm.c
>  create mode 100644 arch/arm/plat-s5p/pm.c
>  create mode 100644 arch/arm/plat-s5p/sleep.S
> 
> diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
> index f636113..be0a013 100644
> --- a/arch/arm/mach-s5pv210/Kconfig
> +++ b/arch/arm/mach-s5pv210/Kconfig
> @@ -12,6 +12,7 @@ if ARCH_S5PV210
>  config CPU_S5PV210
>  	bool
>  	select PLAT_S5P
> +	select S5PV210_PM if PM
>  	help
>  	  Enable S5PV210 CPU support
>  
> @@ -43,4 +44,9 @@ config MACH_VOGUEV210
>  
>  endchoice
>  
> +config S5PV210_PM
> +	bool
> +	help
> +	  Power Management code common to S5PV210
> +
>  endif
> diff --git a/arch/arm/mach-s5pv210/Makefile b/arch/arm/mach-s5pv210/Makefile
> index f1772ed..f31d6a4 100644
> --- a/arch/arm/mach-s5pv210/Makefile
> +++ b/arch/arm/mach-s5pv210/Makefile
> @@ -13,6 +13,7 @@ obj-				:=
>  # Core support for S5PV210 system
>  
>  obj-$(CONFIG_CPU_S5PV210)	+= cpu.o init.o clock.o gpio.o irq-eint-group.o
> +obj-$(CONFIG_S5PV210_PM)	+= pm.o
>  
>  # machine support
>  
> diff --git a/arch/arm/mach-s5pv210/include/mach/pm-core.h b/arch/arm/mach-s5pv210/include/mach/pm-core.h
> new file mode 100644
> index 0000000..52050e4
> --- /dev/null
> +++ b/arch/arm/mach-s5pv210/include/mach/pm-core.h
> @@ -0,0 +1,43 @@
> +/* linux/arch/arm/mach-s5pv210/include/mach/pm-core.h
> + *
> + * Copyright (c) 2010 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com/
> + *
> + * Based on arch/arm/mach-s3c2410/include/mach/pm-core.h,
> + * Copyright 2008 Simtec Electronics
> + *      Ben Dooks <ben@simtec.co.uk>
> + *      http://armlinux.simtec.co.uk/
> + *
> + * S5PV210 - PM core support for arch/arm/plat-s5p/pm.c
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +static inline void s3c_pm_debug_init_uart(void)
> +{
> +	/* nothing here yet */
> +}
> +
> +static inline void s3c_pm_arch_prepare_irqs(void)
> +{
> +	__raw_writel(s3c_irqwake_intmask, S5P_WAKEUP_MASK);
> +	__raw_writel(s3c_irqwake_eintmask, S5P_EINT_WAKEUP_MASK);
> +}
> +
> +static inline void s3c_pm_arch_stop_clocks(void)
> +{
> +	/* nothing here yet */
> +}
> +
> +static inline void s3c_pm_arch_show_resume_irqs(void)
> +{
> +	/* nothing here yet */
> +}
> +
> +static inline void s3c_pm_arch_update_uart(void __iomem *regs,
> +					   struct pm_uart_save *save)
> +{
> +	/* nothing here yet */
> +}
> diff --git a/arch/arm/mach-s5pv210/include/mach/pm.h b/arch/arm/mach-s5pv210/include/mach/pm.h
> new file mode 100644
> index 0000000..897444b
> --- /dev/null
> +++ b/arch/arm/mach-s5pv210/include/mach/pm.h
> @@ -0,0 +1,19 @@
> +/* linux/arch/arm/mach-s5pv210/include/mach/pm.h
> + *
> + * Copyright (c) 2010 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com/
> + *
> + * S5PV210 - Headers for Power Management
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#ifndef __ASM_ARCH_PM_H
> +#define __ASM_ARCH_PM_H __FILE__
> +
> +#include <plat/pm.h>
> +#include <plat/pm-s5p.h>
> +
> +#endif /* __ASM_ARCH_PM_H */
> diff --git a/arch/arm/mach-s5pv210/mach-smdkc110.c b/arch/arm/mach-s5pv210/mach-smdkc110.c
> index 9c9829c..7c54ba3 100644
> --- a/arch/arm/mach-s5pv210/mach-smdkc110.c
> +++ b/arch/arm/mach-s5pv210/mach-smdkc110.c
> @@ -26,6 +26,10 @@
>  #include <plat/devs.h>
>  #include <plat/cpu.h>
>  
> +#if defined(CONFIG_PM)
> +#include <mach/pm.h>
> +#endif
> +
>  /* Following are default values for UCON, ULCON and UFCON UART registers */
>  #define S5PV210_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
>  				 S3C2410_UCON_RXILEVEL |	\
> @@ -83,6 +83,10 @@ static void __init smdkc110_map_io(void)
>  
>  static void __init smdkc110_machine_init(void)
>  {
> +#if defined(CONFIG_PM)
> +	s3c_pm_init();
> +#endif
> +

I think we should make s3c_pm_init() a null inline call if !CONFIG_PM...
and if you look, it is.

>  	platform_add_devices(smdkc110_devices, ARRAY_SIZE(smdkc110_devices));
>  }
>  
> diff --git a/arch/arm/mach-s5pv210/mach-smdkv210.c b/arch/arm/mach-s5pv210/mach-smdkv210.c
> index 9c9829c..7c54ba3 100644
> --- a/arch/arm/mach-s5pv210/mach-smdkv210.c
> +++ b/arch/arm/mach-s5pv210/mach-smdkv210.c
> @@ -26,6 +26,10 @@
>  #include <plat/devs.h>
>  #include <plat/cpu.h>
>  
> +#if defined(CONFIG_PM)
> +#include <mach/pm.h>
> +#endif

IIRC, just include without checking CONFIG_PM

>  /* Following are default values for UCON, ULCON and UFCON UART registers */
>  #define S5PV210_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
>  				 S3C2410_UCON_RXILEVEL |	\
> @@ -83,6 +83,10 @@ static void __init smdkv210_map_io(void)
>  
>  static void __init smdkv210_machine_init(void)
>  {
> +#if defined(CONFIG_PM)
> +	s3c_pm_init();
> +#endif
> +
>  	platform_add_devices(smdkv210_devices, ARRAY_SIZE(smdkv210_devices));
>  }
>  
> diff --git a/arch/arm/mach-s5pv210/pm.c b/arch/arm/mach-s5pv210/pm.c
> new file mode 100644
> index 0000000..b446e87
> --- /dev/null
> +++ b/arch/arm/mach-s5pv210/pm.c
> @@ -0,0 +1,116 @@
> +/* linux/arch/arm/mach-s5pv210/pm.c
> + *
> + * Copyright (c) 2010 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com/
> + *
> + * S5PV210 - Power Management support
> + *
> + * Based on arch/arm/mach-s3c2410/pm.c
> + * Copyright (c) 2006 Simtec Electronics
> + *	Ben Dooks <ben@simtec.co.uk>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#include <linux/init.h>
> +#include <linux/suspend.h>
> +#include <linux/errno.h>
> +#include <linux/time.h>
> +#include <linux/sysdev.h>
> +#include <linux/io.h>
> +
> +#include <mach/hardware.h>
> +
> +#include <asm/mach-types.h>
> +
> +#include <mach/regs-gpio.h>
> +#include <plat/cpu.h>
> +#include <mach/pm.h>
> +
> +#include <mach/regs-irq.h>
> +#include <mach/regs-clock.h>
> +
> +void s5pv210_cpu_suspend(void)
> +{
> +	unsigned long tmp;
> +
> +	/* issue the standby signal into the pm unit. Note, we
> +	 * issue a write-buffer drain just in case */
> +
> +	tmp = 0;
> +
> +	asm("b 1f\n\t"
> +	    ".align 5\n\t"
> +	    "1:\n\t"
> +	    "mcr p15, 0, %0, c7, c10, 5\n\t"
> +	    "mcr p15, 0, %0, c7, c10, 4\n\t"
> +	    ".word 0xe320f003" : : "r" (tmp));
> +
> +	/* we should never get past here */
> +	panic("sleep resumed to originator?");
> +}
> +
> +static void s5pv210_pm_prepare(void)
> +{
> +	unsigned int tmp;
> +
> +	/* ensure at least INFORM0 has the resume address */
> +	__raw_writel(virt_to_phys(s3c_cpu_resume), S5P_INFORM0);
> +
> +	tmp = __raw_readl(S5P_SLEEP_CFG);
> +	tmp &= ~(S5P_SLEEP_CFG_OSC_EN | S5P_SLEEP_CFG_USBOSC_EN);
> +	__raw_writel(tmp, S5P_SLEEP_CFG);
> +
> +	/* WFI for SLEEP mode configuration by SYSCON */
> +	tmp = __raw_readl(S5P_PWR_CFG);
> +	tmp &= S5P_CFG_WFI_CLEAN;
> +	tmp |= S5P_CFG_WFI_SLEEP;
> +	__raw_writel(tmp, S5P_PWR_CFG);
> +
> +	/* SYSCON interrupt handling disable */
> +	tmp = __raw_readl(S5P_OTHERS);
> +	tmp |= S5P_OTHER_SYSC_INTOFF;
> +	__raw_writel(tmp, S5P_OTHERS);
> +
> +	__raw_writel(0xffffffff, (VA_VIC0 + VIC_INT_ENABLE_CLEAR));
> +	__raw_writel(0xffffffff, (VA_VIC1 + VIC_INT_ENABLE_CLEAR));
> +	__raw_writel(0xffffffff, (VA_VIC2 + VIC_INT_ENABLE_CLEAR));
> +	__raw_writel(0xffffffff, (VA_VIC3 + VIC_INT_ENABLE_CLEAR));
> +}
> +
> +static int s5pv210_pm_add(struct sys_device *sysdev)
> +{
> +	pm_cpu_prep = s5pv210_pm_prepare;
> +	pm_cpu_sleep = s5pv210_cpu_suspend;
> +
> +	return 0;
> +}
> +
> +static struct sleep_save s5pv210_sleep[] = {
> +	/* nothing here yet */
> +};
> +
> +static int s5pv210_pm_resume(struct sys_device *dev)
> +{
> +	u32 tmp;
> +
> +	tmp = __raw_readl(S5P_OTHERS);
> +	tmp |= (S5P_OTHERS_RET_IO | S5P_OTHERS_RET_MMC | S5P_OTHERS_RET_UART);
> +	__raw_writel(tmp , S5P_OTHERS);
> +
> +	s3c_pm_do_restore(s5pv210_sleep, ARRAY_SIZE(s5pv210_sleep));
> +	return 0;
> +}
> +
> +static struct sysdev_driver s5pv210_pm_driver = {
> +	.add		= s5pv210_pm_add,
> +	.resume		= s5pv210_pm_resume,
> +};
> +
> +static __init int s5pv210_pm_drvinit(void)
> +{
> +	return sysdev_driver_register(&s5pv210_sysclass, &s5pv210_pm_driver);
> +}
> +arch_initcall(s5pv210_pm_drvinit);
> diff --git a/arch/arm/plat-s5p/Makefile b/arch/arm/plat-s5p/Makefile
> index 00a7966..ac73bb1 100644
> --- a/arch/arm/plat-s5p/Makefile
> +++ b/arch/arm/plat-s5p/Makefile
> @@ -19,3 +19,7 @@ obj-y				+= cpu.o
>  obj-y				+= clock.o
>  obj-y				+= irq.o irq-eint.o
>  obj-y				+= setup-i2c0.o
> +
> +obj-$(CONFIG_PM)		+= pm.o
> +obj-$(CONFIG_PM)		+= irq-pm.o
> +obj-$(CONFIG_PM)		+= sleep.o
> diff --git a/arch/arm/plat-s5p/include/plat/pm-s5p.h b/arch/arm/plat-s5p/include/plat/pm-s5p.h
> new file mode 100644
> index 0000000..6bba23f
> --- /dev/null
> +++ b/arch/arm/plat-s5p/include/plat/pm-s5p.h
> @@ -0,0 +1,23 @@
> +/* linux/arch/arm/plat-s5p/include/plat/pm-s5p.h
> + *
> + * Copyright (c) 2010 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com/
> + *
> + * S5P - Definitions for Power Management
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +/* helper functions to save/restore lists of registers. */
> +
> +#ifdef CONFIG_PM
> +extern int s3c_irq_wake(unsigned int irqno, unsigned int state);
> +extern int s5p_irq_suspend(struct sys_device *dev, pm_message_t state);
> +extern int s5p_irq_resume(struct sys_device *dev);
> +#else
> +#define s3c_irq_wake NULL
> +#define s5p_irq_suspend NULL
> +#define s5p_irq_resume NULL
> +#endif
> diff --git a/arch/arm/plat-s5p/irq-pm.c b/arch/arm/plat-s5p/irq-pm.c
> new file mode 100644
> index 0000000..b6839d1
> --- /dev/null
> +++ b/arch/arm/plat-s5p/irq-pm.c
> @@ -0,0 +1,113 @@
> +/* linux/arch/arm/plat-s5p/irq-pm.c
> + *
> + * Copyright (c) 2010 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com/
> + *
> + * Based on arch/arm/plat-s3c24xx/irq-pm.c,
> + * Copyright (c) 2003,2004 Simtec Electronics
> + *	Ben Dooks <ben@simtec.co.uk>
> + *	http://armlinux.simtec.co.uk/
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/interrupt.h>
> +#include <linux/sysdev.h>
> +
> +#include <plat/cpu.h>
> +#include <plat/irqs.h>
> +#include <mach/pm.h>
> +#include <mach/map.h>
> +
> +#include <mach/regs-gpio.h>
> +#include <mach/regs-irq.h>
> +
> +/* state for IRQs over sleep */
> +
> +/* default is to allow for EINT0..EINT31, and IRQ_RTC_TIC, IRQ_RTC_ALARM,
> + * as wakeup sources
> + *
> + * set bit to 1 in allow bitfield to enable the wakeup settings on it
> +*/
> +
> +unsigned long s3c_irqwake_intallow	= 0x00000006L;
> +unsigned long s3c_irqwake_eintallow	= 0xffffffffL;
> +
> +int s3c_irq_wake(unsigned int irqno, unsigned int state)
> +{
> +	unsigned long irqbit;
> +
> +	switch (irqno) {
> +	case IRQ_RTC_TIC:
> +	case IRQ_RTC_ALARM:
> +		irqbit = 1 << (irqno + 1 - IRQ_RTC_ALARM);
> +		if (!state)
> +			s3c_irqwake_intmask |= irqbit;
> +		else
> +			s3c_irqwake_intmask &= ~irqbit;
> +		break;
> +	default:
> +		return -ENOENT;
> +	}
> +	return 0;
> +}
> +
> +/* this lot should be really saved by the IRQ code */
> +/* VICXADDRESSXX initilaization to be needed */
> +static struct sleep_save irq_save[] = {
> +	SAVE_ITEM(VA_VIC0 + VIC_INT_SELECT),
> +	SAVE_ITEM(VA_VIC1 + VIC_INT_SELECT),
> +	SAVE_ITEM(VA_VIC2 + VIC_INT_SELECT),
> +	SAVE_ITEM(VA_VIC3 + VIC_INT_SELECT),
> +
> +	SAVE_ITEM(VA_VIC0 + VIC_INT_ENABLE),
> +	SAVE_ITEM(VA_VIC1 + VIC_INT_ENABLE),
> +	SAVE_ITEM(VA_VIC2 + VIC_INT_ENABLE),
> +	SAVE_ITEM(VA_VIC3 + VIC_INT_ENABLE),
> +
> +	SAVE_ITEM(VA_VIC0 + VIC_INT_SOFT),
> +	SAVE_ITEM(VA_VIC1 + VIC_INT_SOFT),
> +	SAVE_ITEM(VA_VIC2 + VIC_INT_SOFT),
> +	SAVE_ITEM(VA_VIC3 + VIC_INT_SOFT),
> +};
> +
> +static struct sleep_save eint_save[] = {
> +	SAVE_ITEM(S5P_EINT30CON),
> +	SAVE_ITEM(S5P_EINT31CON),
> +	SAVE_ITEM(S5P_EINT32CON),
> +	SAVE_ITEM(S5P_EINT33CON),
> +
> +	SAVE_ITEM(S5P_EINT30FLTCON0),
> +	SAVE_ITEM(S5P_EINT30FLTCON1),
> +	SAVE_ITEM(S5P_EINT31FLTCON0),
> +	SAVE_ITEM(S5P_EINT31FLTCON1),
> +	SAVE_ITEM(S5P_EINT32FLTCON0),
> +	SAVE_ITEM(S5P_EINT32FLTCON1),
> +	SAVE_ITEM(S5P_EINT33FLTCON0),
> +	SAVE_ITEM(S5P_EINT33FLTCON1),
> +
> +	SAVE_ITEM(S5P_EINT30MASK),
> +	SAVE_ITEM(S5P_EINT31MASK),
> +	SAVE_ITEM(S5P_EINT32MASK),
> +	SAVE_ITEM(S5P_EINT33MASK),
> +};
> +
> +int s5p_irq_suspend(struct sys_device *dev, pm_message_t state)
> +{
> +	s3c_pm_do_save(eint_save, ARRAY_SIZE(eint_save));
> +	s3c_pm_do_save(irq_save, ARRAY_SIZE(irq_save));
> +
> +	return 0;
> +}
> +
> +int s5p_irq_resume(struct sys_device *dev)
> +{
> +	s3c_pm_do_restore(irq_save, ARRAY_SIZE(irq_save));
> +	s3c_pm_do_restore(eint_save, ARRAY_SIZE(eint_save));
> +
> +	return 0;
> +}
> diff --git a/arch/arm/plat-s5p/pm.c b/arch/arm/plat-s5p/pm.c
> new file mode 100644
> index 0000000..397b60a
> --- /dev/null
> +++ b/arch/arm/plat-s5p/pm.c
> @@ -0,0 +1,149 @@
> +/* linux/arch/arm/plat-s5p/pm.c
> + *
> + * Copyright (c) 2010 Samsung Electronics Co., Ltd.
> + *              http://www.samsung.com/
> + *
> + * S5P Power Manager (Suspend-To-RAM) support
> + *
> + * Based on arch/arm/plat-s3c24xx/pm.c
> + * Copyright (c) 2004,2006 Simtec Electronics
> + *	Ben Dooks <ben@simtec.co.uk>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#include <linux/init.h>
> +#include <linux/suspend.h>
> +#include <linux/errno.h>
> +#include <linux/time.h>
> +#include <linux/gpio.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/ioport.h>
> +#include <linux/delay.h>
> +#include <linux/serial_core.h>
> +#include <linux/io.h>
> +#include <linux/platform_device.h>
> +
> +#include <asm/cacheflush.h>
> +#include <mach/hardware.h>
> +
> +#include <mach/map.h>
> +#include <plat/gpio-cfg.h>
> +#include <plat/regs-serial.h>
> +#include <plat/regs-timer.h>
> +#include <mach/regs-clock.h>
> +#include <mach/regs-mem.h>
> +#include <mach/regs-irq.h>
> +
> +#include <asm/mach/time.h>
> +
> +#include <mach/pm.h>
> +
> +#define PFX "s5p pm: "
> +
> +static struct sleep_save core_save[] = {
> +	/* Clock source */
> +	SAVE_ITEM(S5P_CLK_SRC0),
> +	SAVE_ITEM(S5P_CLK_SRC1),
> +	SAVE_ITEM(S5P_CLK_SRC2),
> +	SAVE_ITEM(S5P_CLK_SRC3),
> +	SAVE_ITEM(S5P_CLK_SRC4),
> +	SAVE_ITEM(S5P_CLK_SRC5),
> +	SAVE_ITEM(S5P_CLK_SRC6),
> +
> +	/* Clock source Mask */
> +	SAVE_ITEM(S5P_CLK_SRC_MASK0),
> +	SAVE_ITEM(S5P_CLK_SRC_MASK1),
> +
> +	/* Clock Divider */
> +	SAVE_ITEM(S5P_CLK_DIV0),
> +	SAVE_ITEM(S5P_CLK_DIV1),
> +	SAVE_ITEM(S5P_CLK_DIV2),
> +	SAVE_ITEM(S5P_CLK_DIV3),
> +	SAVE_ITEM(S5P_CLK_DIV4),
> +	SAVE_ITEM(S5P_CLK_DIV5),
> +	SAVE_ITEM(S5P_CLK_DIV6),
> +	SAVE_ITEM(S5P_CLK_DIV7),
> +
> +	/* Clock Main Gate */
> +	SAVE_ITEM(S5P_CLKGATE_MAIN0),
> +	SAVE_ITEM(S5P_CLKGATE_MAIN1),
> +	SAVE_ITEM(S5P_CLKGATE_MAIN2),
> +
> +	/* Clock source Peri Gate */
> +	SAVE_ITEM(S5P_CLKGATE_PERI0),
> +	SAVE_ITEM(S5P_CLKGATE_PERI1),
> +
> +	/* Clock source SCLK Gate */
> +	SAVE_ITEM(S5P_CLKGATE_SCLK0),
> +	SAVE_ITEM(S5P_CLKGATE_SCLK1),
> +
> +	/* Clock IP Clock gate */
> +	SAVE_ITEM(S5P_CLKGATE_IP0),
> +	SAVE_ITEM(S5P_CLKGATE_IP1),
> +	SAVE_ITEM(S5P_CLKGATE_IP2),
> +	SAVE_ITEM(S5P_CLKGATE_IP3),
> +	SAVE_ITEM(S5P_CLKGATE_IP4),
> +
> +	/* Clock Blcok and Bus gate */
> +	SAVE_ITEM(S5P_CLKGATE_BLOCK),
> +	SAVE_ITEM(S5P_CLKGATE_BUS0),
> +
> +	/* Clock ETC */
> +	SAVE_ITEM(S5P_CLK_OUT),
> +
> +	/* PWM Register */
> +	SAVE_ITEM(S3C2410_TCFG0),
> +	SAVE_ITEM(S3C2410_TCFG1),
> +	SAVE_ITEM(S3C64XX_TINT_CSTAT),
> +	SAVE_ITEM(S3C2410_TCON),
> +	SAVE_ITEM(S3C2410_TCNTB(0)),
> +	SAVE_ITEM(S3C2410_TCMPB(0)),
> +	SAVE_ITEM(S3C2410_TCNTO(0)),
> +};
> +
> +static struct sleep_save sromc_save[] = {
> +	SAVE_ITEM(S5P_SROM_BW),
> +	SAVE_ITEM(S5P_SROM_BC0),
> +	SAVE_ITEM(S5P_SROM_BC1),
> +	SAVE_ITEM(S5P_SROM_BC2),
> +	SAVE_ITEM(S5P_SROM_BC3),
> +	SAVE_ITEM(S5P_SROM_BC4),
> +	SAVE_ITEM(S5P_SROM_BC5),
> +};
> +
> +/* s3c_pm_check_resume_pin
> + *
> + * check to see if the pin is configured correctly for sleep mode, and
> + * make any necessary adjustments if it is not
> +*/
> +
> +static void s3c_pm_check_resume_pin(unsigned int pin, unsigned int irqoffs)
> +{
> +	/* nothing here yet */
> +}
> +
> +/* s3c_pm_configure_extint
> + *
> + * configure all external interrupt pins
> +*/
> +
> +void s3c_pm_configure_extint(void)
> +{
> +	/* nothing here yet */
> +}
> +
> +void s3c_pm_restore_core(void)
> +{
> +	s3c_pm_do_restore_core(core_save, ARRAY_SIZE(core_save));
> +	s3c_pm_do_restore(sromc_save, ARRAY_SIZE(sromc_save));
> +}
> +
> +void s3c_pm_save_core(void)
> +{
> +	s3c_pm_do_save(sromc_save, ARRAY_SIZE(sromc_save));
> +	s3c_pm_do_save(core_save, ARRAY_SIZE(core_save));
> +}
> diff --git a/arch/arm/plat-s5p/sleep.S b/arch/arm/plat-s5p/sleep.S
> new file mode 100644
> index 0000000..ca9f08e
> --- /dev/null
> +++ b/arch/arm/plat-s5p/sleep.S
> @@ -0,0 +1,188 @@
> +/* linux/arch/arm/plat-s5p/sleep.S
> + *
> + * Copyright (c) 2010 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com/
> + *
> + * S5PV210 power Manager (Suspend-To-RAM) support
> + * Based on S3C2410 sleep code by:
> + * 	Ben Dooks, (c) 2004 Simtec Electronics
> + *
> + * Based on PXA/SA1100 sleep code by:
> + *	Nicolas Pitre, (c) 2002 Monta Vista Software Inc
> + *	Cliff Brake, (c) 2001
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> +*/
> +
> +#include <linux/linkage.h>
> +#include <asm/assembler.h>
> +#include <mach/hardware.h>
> +#include <mach/map.h>
> +#include <asm/asm-offsets.h>
> +#include <asm/memory.h>
> +#include <asm/system.h>
> +
> +#include <mach/regs-gpio.h>
> +#include <mach/regs-clock.h>
> +#include <mach/regs-mem.h>
> +#include <plat/regs-serial.h>
> +
> +/* CONFIG_DEBUG_RESUME is dangerous if your bootloader does not
> + * reset the UART configuration, only enable if you really need this!
> +*/
> +	.text
> +
> +	/* s3c_cpu_save
> +	 *
> +	 * entry:
> +	 *	r0 = save address (virtual addr of s3c_sleep_save_phys)
> +	*/
> +
> +ENTRY(s3c_cpu_save)
> +
> +	stmfd	sp!, { r3 - r12, lr }
> +
> +	mrc	p15, 0, r4, c13, c0, 0	@ FCSE/PID
> +	mrc	p15, 0, r5, c3, c0, 0	@ Domain ID
> +	mrc	p15, 0, r6, c2, c0, 0	@ Translation Table BASE0
> +	mrc	p15, 0, r7, c2, c0, 1	@ Translation Table BASE1
> +	mrc	p15, 0, r8, c2, c0, 2	@ Translation Table Control
> +	mrc	p15, 0, r9, c1, c0, 0	@ Control register
> +	mrc	p15, 0, r10, c1, c0, 1	@ Auxiliary control register
> +	mrc	p15, 0, r11, c1, c0, 2	@ Co-processor access controls
> +	mrc	p15, 0, r12, c10, c2, 0	@ Read PRRR
> +	mrc	p15, 0, r3, c10, c2, 1	@ READ NMRR
> +
> +	stmia	r0, { r3 - r13 }
> +
> +	@@ write our state back to RAM
> +	bl	s3c_pm_cb_flushcache
> +
> +	@@ jump to final code to send system to sleep
> +	ldr	r0, =pm_cpu_sleep
> +	@@ldr	pc, [ r0 ]
> +	ldr	r0, [ r0 ]
> +	mov	pc, r0
> +
> +	@@ return to the caller, after having the MMU
> +	@@ turned on, this restores the last bits from the
> +	@@ stack
> +resume_with_mmu:
> +	/* delete added mmu table list */
> +	ldr	r9 , =(PAGE_OFFSET - PHYS_OFFSET)

this looks like an utter hack...

please see comments abotu explaining why this is needed so we can think
if there is a better way to get this done.

> +	add	r4, r4, r9
> +	str	r12, [r4]
> +
> +	ldmfd	sp!, { r3 - r12, pc }
> +
> +	.ltorg
> +
> +	@@ the next bits sit in the .data segment, even though they
> +	@@ happen to be code... the s5pv210_sleep_save_phys needs to be

s5pv210_sleep_save_phys and then s3c_sleep_save_phys? do not match...

> +	@@ accessed by the resume code before it can restore the MMU.
> +	@@ This means that the variable has to be close enough for the
> +	@@ code to read it... since the .text segment needs to be RO,
> +	@@ the data segment can be the only place to put this code.
> +
> +	.data
> +
> +	.global	s3c_sleep_save_phys
> +s3c_sleep_save_phys:
> +	.word	0
> +
> +
> +	/* sleep magic, to allow the bootloader to check for an valid
> +	 * image to resume to. Must be the first word before the
> +	 * s5pv210_cpu_resume entry.
> +	*/
> +
> +	.word	0x2bedf00d
> +
> +	/* s3c_cpu_resume
> +	 *
> +	 * resume code entry for bootloader to call
> +	 *
> +	 * we must put this code here in the data segment as we have no
> +	 * other way of restoring the stack pointer after sleep, and we
> +	 * must not write to the code segment (code is read-only)
> +	*/
> +
> +ENTRY(s3c_cpu_resume)
> +	mov	r0, #PSR_I_BIT | PSR_F_BIT | SVC_MODE
> +	msr	cpsr_c, r0
> +
> +	@@ load UART to allow us to print the two characters for
> +	@@ resume debug
> +
> +	mov	r1, #0
> +	mcr	p15, 0, r1, c8, c7, 0		@@ invalidate TLBs
> +	mcr	p15, 0, r1, c7, c5, 0		@@ invalidate I Cache
> +
> +	ldr	r0, s3c_sleep_save_phys	@ address of restore block
> +	ldmia	r0, { r3 - r13 }
> +
> +	mcr	p15, 0, r4, c13, c0, 0	@ FCSE/PID
> +	mcr	p15, 0, r5, c3, c0, 0	@ Domain ID
> +
> +	mcr	p15, 0, r8, c2, c0, 2	@ Translation Table Control
> +	mcr	p15, 0, r7, c2, c0, 1	@ Translation Table BASE1
> +	mcr	p15, 0, r6, c2, c0, 0	@ Translation Table BASE0
> +
> +	mcr	p15, 0, r10, c1, c0, 1	@ Auxiliary control register
> +
> +	mov	r0, #0
> +	mcr	p15, 0, r0, c8, c7, 0	@ Invalidate I & D TLB
> +
> +	mov	r0, #0			@ restore copro access controls
> +	mcr	p15, 0, r11, c1, c0, 2	@ Co-processor access controls
> +	mcr 	p15, 0, r0, c7, c5, 4
> +
> +	mcr	p15, 0, r12, c10, c2, 0	@ write PRRR
> +	mcr	p15, 0, r3, c10, c2, 1	@ write NMRR
> +
> +	/* calculate first section address into r8 */

please add an explantation of why you feel the need to play about with
the MMU here, it is something I'm sure that other people would like to
find out about.

> +	mov	r4, r6
> +	ldr	r5, =0x3fff
> +	bic	r4, r4, r5

two shifts would have got this done more efficiently.

> +	ldr	r11, =0xe010f000
> +	ldr	r10, [r11, #0]
> +	mov	r10, r10 ,LSR #18
> +	bic	r10, r10, #0x3
> +	orr	r4, r4, r10
> +
> +	/* calculate mmu list value into r9 */
> +	mov 	r10, r10, LSL #18
> +	ldr	r5, =0x40e
> +	orr	r10, r10, r5
> +
> +	/* back up originally data */
  	   	   original

> +
> +	ldr	r12, [r4]
> +
> +	/* Added list about mmu */
> +	str	r10, [r4]
> +
> +	ldr	r2, =resume_with_mmu
> +	mcr	p15, 0, r9, c1, c0, 0		@ turn on MMU, etc
> +
> +        nop
> +        nop
> +        nop
> +        nop
> +        nop					@ second-to-last before mmu
> +
> +	mov	pc, r2				@ go back to virtual address
> +
> +	.ltorg
> diff --git a/arch/arm/plat-samsung/pm-gpio.c b/arch/arm/plat-samsung/pm-gpio.c
> index 69a4c7f..88ab73c 100644
> --- a/arch/arm/plat-samsung/pm-gpio.c
> +++ b/arch/arm/plat-samsung/pm-gpio.c
> @@ -192,7 +192,7 @@ struct s3c_gpio_pm s3c_gpio_pm_2bit = {
>  	.resume = s3c_gpio_pm_2bit_resume,
>  };
>  
> -#ifdef CONFIG_ARCH_S3C64XX
> +#if defined(CONFIG_ARCH_S3C64XX) || defined(CONFIG_PLAT_S5P)

looks like this probably wants its own kconfig variable. however not
going to get you to change that now.

>  static void s3c_gpio_pm_4bit_save(struct s3c_gpio_chip *chip)
>  {
>  	chip->pm_save[1] = __raw_readl(chip->base + OFFS_CON);
> @@ -302,7 +302,7 @@ struct s3c_gpio_pm s3c_gpio_pm_4bit = {
>  	.save	= s3c_gpio_pm_4bit_save,
>  	.resume = s3c_gpio_pm_4bit_resume,
>  };
> -#endif /* CONFIG_ARCH_S3C64XX */
> +#endif /* CONFIG_ARCH_S3C64XX || CONFIG_PLAT_S5P */
>  
>  /**
>   * s3c_pm_save_gpio() - save gpio chip data for suspend
> -- 


-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
