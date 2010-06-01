From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 1 Jun 2010 06:32:55 +0100
Subject: [PATCH v2] ARM: S5PV210: Add Power Management Support
In-Reply-To: <AANLkTikdkOvvdsQvwuqS9QFv6yIM7LQJb24NrTi-RA-s@mail.gmail.com>
References: <1275356164-7896-1-git-send-email-kgene.kim@samsung.com>
	<20100601020329.GT4720@trinity.fluff.org>
	<AANLkTikdkOvvdsQvwuqS9QFv6yIM7LQJb24NrTi-RA-s@mail.gmail.com>
Message-ID: <20100601053255.GP7248@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 01, 2010 at 02:13:18PM +0900, MyungJoo Ham wrote:
> On Tue, Jun 1, 2010 at 11:03 AM, Ben Dooks <ben-linux@fluff.org> wrote:
> >
> > On Tue, Jun 01, 2010 at 10:36:04AM +0900, Kukjin Kim wrote:
> >> From: Jongpill Lee <boyko.lee@samsung.com>
> >>
> >> This patch adds suspend-to-ram support for S5PV210.
> >>
> >> Signed-off-by: Jongpill Lee <boyko.lee@samsung.com>
> >> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> >> ---
> >> Changes since v1:
> >>
> >> 1. Fixed comments as per comments from Ben Dooks
> >> 2. Removed redunt #if defined(CONFIG_PM)
> >> 3. Removed redunt including header files
> >> 4. Removed <mach/pm.h> and <plat/pm-s5p.h>
> >> 5. Moved 's5pv210_core_save' into machine directory
> >> 6. Moved sleep.S into machine directory for S5P SoCs compatibility
> >> 7. Added CF retension configuration when wake-up
> >>
> >> This patch is based on Linus' master (2.6.35-rc1)
> >>
> >> ?arch/arm/mach-s5pv210/Kconfig ? ? ? ? ? ? ? ? ? | ? ?6 +
> >> ?arch/arm/mach-s5pv210/Makefile ? ? ? ? ? ? ? ? ?| ? ?1 +
> >> ?arch/arm/mach-s5pv210/include/mach/pm-core.h ? ?| ? 44 ++++++
> >> ?arch/arm/mach-s5pv210/include/mach/regs-clock.h | ? ?5 +-
> >> ?arch/arm/mach-s5pv210/mach-smdkc110.c ? ? ? ? ? | ? ?2 +
> >> ?arch/arm/mach-s5pv210/mach-smdkv210.c ? ? ? ? ? | ? ?3 +
> >> ?arch/arm/mach-s5pv210/pm.c ? ? ? ? ? ? ? ? ? ? ?| ?180 +++++++++++++++++++++++
> >> ?arch/arm/mach-s5pv210/sleep.S ? ? ? ? ? ? ? ? ? | ?166 +++++++++++++++++++++
> >> ?arch/arm/plat-s5p/Makefile ? ? ? ? ? ? ? ? ? ? ?| ? ?2 +
> >> ?arch/arm/plat-s5p/include/plat/irqs.h ? ? ? ? ? | ? ?2 +
> >> ?arch/arm/plat-s5p/irq-pm.c ? ? ? ? ? ? ? ? ? ? ?| ?108 ++++++++++++++
> >> ?arch/arm/plat-s5p/pm.c ? ? ? ? ? ? ? ? ? ? ? ? ?| ? 52 +++++++
> >> ?arch/arm/plat-samsung/pm-gpio.c ? ? ? ? ? ? ? ? | ? ?4 +-
> >> ?13 files changed, 572 insertions(+), 3 deletions(-)
> >> ?create mode 100644 arch/arm/mach-s5pv210/include/mach/pm-core.h
> >> ?create mode 100644 arch/arm/mach-s5pv210/pm.c
> >> ?create mode 100644 arch/arm/mach-s5pv210/sleep.S
> >> ?create mode 100644 arch/arm/plat-s5p/irq-pm.c
> >> ?create mode 100644 arch/arm/plat-s5p/pm.c
> >>
> >> diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
> >> index 0761eac..86cca1b 100644
> >> --- a/arch/arm/mach-s5pv210/Kconfig
> >> +++ b/arch/arm/mach-s5pv210/Kconfig
> >> @@ -14,6 +14,7 @@ config CPU_S5PV210
> >> ? ? ? select PLAT_S5P
> >> ? ? ? select S3C_PL330_DMA
> >> ? ? ? select S5P_EXT_INT
> >> + ? ? select S5PV210_PM if PM
> >> ? ? ? help
> >> ? ? ? ? Enable S5PV210 CPU support
> >>
> >> @@ -88,4 +89,9 @@ config MACH_SMDKC110
> >> ? ? ? ? Machine support for Samsung SMDKC110
> >> ? ? ? ? S5PC110(MCP) is one of package option of S5PV210
> >>
> >> +config S5PV210_PM
> >> + ? ? bool
> >> + ? ? help
> >> + ? ? ? Power Management code common to S5PV210
> >> +
> >> ?endif
> >> diff --git a/arch/arm/mach-s5pv210/Makefile b/arch/arm/mach-s5pv210/Makefile
> >> index 30be9a6..59382ec 100644
> >> --- a/arch/arm/mach-s5pv210/Makefile
> >> +++ b/arch/arm/mach-s5pv210/Makefile
> >> @@ -14,6 +14,7 @@ obj- ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?:=
> >>
> >> ?obj-$(CONFIG_CPU_S5PV210) ? ?+= cpu.o init.o clock.o dma.o gpiolib.o
> >> ?obj-$(CONFIG_CPU_S5PV210) ? ?+= setup-i2c0.o
> >> +obj-$(CONFIG_S5PV210_PM) ? ? += pm.o sleep.o
> >>
> >> ?# machine support
> >>
> >> diff --git a/arch/arm/mach-s5pv210/include/mach/pm-core.h b/arch/arm/mach-s5pv210/include/mach/pm-core.h
> >> new file mode 100644
> >> index 0000000..ca3f827
> >> --- /dev/null
> >> +++ b/arch/arm/mach-s5pv210/include/mach/pm-core.h
> >> @@ -0,0 +1,44 @@
> >> +/* linux/arch/arm/mach-s5pv210/include/mach/pm-core.h
> >> + *
> >> + * Copyright (c) 2010 Samsung Electronics Co., Ltd.
> >> + * ? ? ? ? ? http://www.samsung.com
> >> + *
> >> + * Based on arch/arm/mach-s3c2410/include/mach/pm-core.h,
> >> + * Copyright 2008 Simtec Electronics
> >> + * ? ? ?Ben Dooks <ben@simtec.co.uk>
> >> + * ? ? ?http://armlinux.simtec.co.uk/
> >> + *
> >> + * S5PV210 - PM core support for arch/arm/plat-s5p/pm.c
> >> + *
> >> + * This program is free software; you can redistribute it and/or modify
> >> + * it under the terms of the GNU General Public License version 2 as
> >> + * published by the Free Software Foundation.
> >> +*/
> >> +
> >> +static inline void s3c_pm_debug_init_uart(void)
> >> +{
> >> + ? ? /* nothing here yet */
> >> +}
> >> +
> >> +static inline void s3c_pm_arch_prepare_irqs(void)
> >> +{
> >> + ? ? __raw_writel(s3c_irqwake_intmask, S5P_WAKEUP_MASK);
> >> + ? ? __raw_writel(s3c_irqwake_eintmask, S5P_EINT_WAKEUP_MASK);
> >> +}
> >> +
> >> +static inline void s3c_pm_arch_stop_clocks(void)
> >> +{
> >> + ? ? /* nothing here yet */
> >> +}
> >> +
> >> +static inline void s3c_pm_arch_show_resume_irqs(void)
> >> +{
> >> + ? ? /* nothing here yet */
> >> +}
> >> +
> >> +static inline void s3c_pm_arch_update_uart(void __iomem *regs,
> >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?struct pm_uart_save *save)
> >> +{
> >> + ? ? /* nothing here yet */
> >> +}
> >> +
> >> diff --git a/arch/arm/mach-s5pv210/include/mach/regs-clock.h b/arch/arm/mach-s5pv210/include/mach/regs-clock.h
> >> index 2a25ab4..f4a443a 100644
> >> --- a/arch/arm/mach-s5pv210/include/mach/regs-clock.h
> >> +++ b/arch/arm/mach-s5pv210/include/mach/regs-clock.h
> >> @@ -157,8 +157,11 @@
> >> ?#define S5P_SLEEP_CFG_USBOSC_EN ? ? ? ? ? ? ?(1 << 1)
> >>
> >> ?/* OTHERS Resgister */
> >> +#define S5P_OTHERS_RET_IO ? ? ? ? ? ?(1 << 31)
> >> +#define S5P_OTHERS_RET_CF ? ? ? ? ? ?(1 << 30)
> >> +#define S5P_OTHERS_RET_MMC ? ? ? ? ? (1 << 29)
> >> +#define S5P_OTHERS_RET_UART ? ? ? ? ?(1 << 28)
> >> ?#define S5P_OTHERS_USB_SIG_MASK ? ? ? ? ? ? ?(1 << 16)
> >> -#define S5P_OTHERS_MIPI_DPHY_EN ? ? ? ? ? ? ?(1 << 28)
> >>
> >> ?/* MIPI */
> >> ?#define S5P_MIPI_DPHY_EN ? ? ? ? ? ? (3)
> >> diff --git a/arch/arm/mach-s5pv210/mach-smdkc110.c b/arch/arm/mach-s5pv210/mach-smdkc110.c
> >> index 4c8903c..ebb4832 100644
> >> --- a/arch/arm/mach-s5pv210/mach-smdkc110.c
> >> +++ b/arch/arm/mach-s5pv210/mach-smdkc110.c
> >> @@ -25,6 +25,7 @@
> >> ?#include <plat/s5pv210.h>
> >> ?#include <plat/devs.h>
> >> ?#include <plat/cpu.h>
> >> +#include <plat/pm.h>
> >>
> >> ?/* Following are default values for UCON, ULCON and UFCON UART registers */
> >> ?#define S5PV210_UCON_DEFAULT (S3C2410_UCON_TXILEVEL | ? ? ? ?\
> >> @@ -86,6 +87,7 @@ static void __init smdkc110_map_io(void)
> >>
> >> ?static void __init smdkc110_machine_init(void)
> >> ?{
> >> + ? ? s3c_pm_init();
> >> ? ? ? platform_add_devices(smdkc110_devices, ARRAY_SIZE(smdkc110_devices));
> >> ?}
> >>
> >> diff --git a/arch/arm/mach-s5pv210/mach-smdkv210.c b/arch/arm/mach-s5pv210/mach-smdkv210.c
> >> index 0d46279..ba30b5d 100644
> >> --- a/arch/arm/mach-s5pv210/mach-smdkv210.c
> >> +++ b/arch/arm/mach-s5pv210/mach-smdkv210.c
> >> @@ -27,6 +27,7 @@
> >> ?#include <plat/cpu.h>
> >> ?#include <plat/adc.h>
> >> ?#include <plat/ts.h>
> >> +#include <plat/pm.h>
> >>
> >> ?/* Following are default values for UCON, ULCON and UFCON UART registers */
> >> ?#define S5PV210_UCON_DEFAULT (S3C2410_UCON_TXILEVEL | ? ? ? ?\
> >> @@ -96,6 +97,8 @@ static void __init smdkv210_map_io(void)
> >>
> >> ?static void __init smdkv210_machine_init(void)
> >> ?{
> >> + ? ? s3c_pm_init();
> >> +
> >> ? ? ? s3c24xx_ts_set_platdata(&s3c_ts_platform);
> >> ? ? ? platform_add_devices(smdkv210_devices, ARRAY_SIZE(smdkv210_devices));
> >> ?}
> >> diff --git a/arch/arm/mach-s5pv210/pm.c b/arch/arm/mach-s5pv210/pm.c
> >> new file mode 100644
> >> index 0000000..0690332
> >> --- /dev/null
> >> +++ b/arch/arm/mach-s5pv210/pm.c
> >> @@ -0,0 +1,180 @@
> >> +/* linux/arch/arm/mach-s5pv210/pm.c
> >> + *
> >> + * Copyright (c) 2010 Samsung Electronics Co., Ltd.
> >> + * ? ? ? ? ? http://www.samsung.com
> >> + *
> >> + * S5PV210 - Power Management support
> >> + *
> >> + * Based on arch/arm/mach-s3c2410/pm.c
> >> + * Copyright (c) 2006 Simtec Electronics
> >> + * ? Ben Dooks <ben@simtec.co.uk>
> >> + *
> >> + * This program is free software; you can redistribute it and/or modify
> >> + * it under the terms of the GNU General Public License version 2 as
> >> + * published by the Free Software Foundation.
> >> +*/
> >> +
> >> +#include <linux/init.h>
> >> +#include <linux/suspend.h>
> >> +#include <linux/io.h>
> >> +
> >> +#include <plat/cpu.h>
> >> +#include <plat/pm.h>
> >> +#include <plat/regs-timer.h>
> >> +
> >> +#include <mach/regs-irq.h>
> >> +#include <mach/regs-clock.h>
> >> +
> >> +static struct sleep_save s5pv210_core_save[] = {
> >> + ? ? /* Clock source */
> >> + ? ? SAVE_ITEM(S5P_CLK_SRC0),
> >> + ? ? SAVE_ITEM(S5P_CLK_SRC1),
> >> + ? ? SAVE_ITEM(S5P_CLK_SRC2),
> >> + ? ? SAVE_ITEM(S5P_CLK_SRC3),
> >> + ? ? SAVE_ITEM(S5P_CLK_SRC4),
> >> + ? ? SAVE_ITEM(S5P_CLK_SRC5),
> >> + ? ? SAVE_ITEM(S5P_CLK_SRC6),
> >> +
> >> + ? ? /* Clock source Mask */
> >> + ? ? SAVE_ITEM(S5P_CLK_SRC_MASK0),
> >> + ? ? SAVE_ITEM(S5P_CLK_SRC_MASK1),
> >> +
> >> + ? ? /* Clock Divider */
> >> + ? ? SAVE_ITEM(S5P_CLK_DIV0),
> >> + ? ? SAVE_ITEM(S5P_CLK_DIV1),
> >> + ? ? SAVE_ITEM(S5P_CLK_DIV2),
> >> + ? ? SAVE_ITEM(S5P_CLK_DIV3),
> >> + ? ? SAVE_ITEM(S5P_CLK_DIV4),
> >> + ? ? SAVE_ITEM(S5P_CLK_DIV5),
> >> + ? ? SAVE_ITEM(S5P_CLK_DIV6),
> >> + ? ? SAVE_ITEM(S5P_CLK_DIV7),
> >> +
> >> + ? ? /* Clock Main Gate */
> >> + ? ? SAVE_ITEM(S5P_CLKGATE_MAIN0),
> >> + ? ? SAVE_ITEM(S5P_CLKGATE_MAIN1),
> >> + ? ? SAVE_ITEM(S5P_CLKGATE_MAIN2),
> >> +
> >> + ? ? /* Clock source Peri Gate */
> >> + ? ? SAVE_ITEM(S5P_CLKGATE_PERI0),
> >> + ? ? SAVE_ITEM(S5P_CLKGATE_PERI1),
> >> +
> >> + ? ? /* Clock source SCLK Gate */
> >> + ? ? SAVE_ITEM(S5P_CLKGATE_SCLK0),
> >> + ? ? SAVE_ITEM(S5P_CLKGATE_SCLK1),
> >> +
> >> + ? ? /* Clock IP Clock gate */
> >> + ? ? SAVE_ITEM(S5P_CLKGATE_IP0),
> >> + ? ? SAVE_ITEM(S5P_CLKGATE_IP1),
> >> + ? ? SAVE_ITEM(S5P_CLKGATE_IP2),
> >> + ? ? SAVE_ITEM(S5P_CLKGATE_IP3),
> >> + ? ? SAVE_ITEM(S5P_CLKGATE_IP4),
> >> +
> >> + ? ? /* Clock Blcok and Bus gate */
> >> + ? ? SAVE_ITEM(S5P_CLKGATE_BLOCK),
> >> + ? ? SAVE_ITEM(S5P_CLKGATE_BUS0),
> >> +
> >> + ? ? /* Clock ETC */
> >> + ? ? SAVE_ITEM(S5P_CLK_OUT),
> >> + ? ? SAVE_ITEM(S5P_MDNIE_SEL),
> >> +
> >> + ? ? /* PWM Register */
> >> + ? ? SAVE_ITEM(S3C2410_TCFG0),
> >> + ? ? SAVE_ITEM(S3C2410_TCFG1),
> >> + ? ? SAVE_ITEM(S3C64XX_TINT_CSTAT),
> >> + ? ? SAVE_ITEM(S3C2410_TCON),
> >> + ? ? SAVE_ITEM(S3C2410_TCNTB(0)),
> >> + ? ? SAVE_ITEM(S3C2410_TCMPB(0)),
> >> + ? ? SAVE_ITEM(S3C2410_TCNTO(0)),
> >> +
> >> + ? ? /* VIC 2 and 3*/
> >> + ? ? SAVE_ITEM(VA_VIC2 + VIC_INT_SELECT),
> >> + ? ? SAVE_ITEM(VA_VIC3 + VIC_INT_SELECT),
> >> + ? ? SAVE_ITEM(VA_VIC2 + VIC_INT_ENABLE),
> >> + ? ? SAVE_ITEM(VA_VIC3 + VIC_INT_ENABLE),
> >> + ? ? SAVE_ITEM(VA_VIC2 + VIC_INT_SOFT),
> >> + ? ? SAVE_ITEM(VA_VIC3 + VIC_INT_SOFT),
> >
> > doesn't the vic driver do this for you? if not, then would be better
> > to change the vic to fix this.
> 
> The VIC driver does only for VIC0 and VIC1; thus, moving VIC2/3 from
> pm.c to irq-pm.c should be fine.
> Probably, a few machines supposed to be supported by this irq-pm
> driver has only VIC0 and VIC1.
> However, it'd be better if irq-pm supports both machines with VIC0/1 and VIC0-3.

The _correct_ thing to do would be to have defined CONFIG_ARM_VIC_NR to
be bigger than 2, thus the core driver would have been correctly suspending
and resuming all the vics in the system.

Maybe we should change to using the initial memory allocator and getting
rid of the CONFIG_ARM_VIC_NR.

However, how on earth did no-one notice and not do anything about the
hughe KERN_ERR notice about there being two few VICs configured???

looking at arch/arm/common/vic.c:

   193          if (vic_id >= ARRAY_SIZE(vic_devices))
   194                  printk(KERN_ERR "%s: too few VICs, increase CONFIG_ARM_VIC_NR\n", __func__);
   195          else {

it isn't as if it fails silently..


> >
> >> +};
> >> +
> >> +void s5pv210_cpu_suspend(void)
> >> +{
> >> + ? ? unsigned long tmp;
> >> +
> >> + ? ? /* issue the standby signal into the pm unit. Note, we
> >> + ? ? ?* issue a write-buffer drain just in case */
> >> +
> >> + ? ? tmp = 0;
> >> +
> >> + ? ? asm("b 1f\n\t"
> >> + ? ? ? ? ".align 5\n\t"
> >> + ? ? ? ? "1:\n\t"
> >> + ? ? ? ? "mcr p15, 0, %0, c7, c10, 5\n\t"
> >> + ? ? ? ? "mcr p15, 0, %0, c7, c10, 4\n\t"
> >> + ? ? ? ? ".word 0xe320f003" : : "r" (tmp));
> >
> > why .word? if there's a compiler problem then make a comment about
> > what instruction is being synthesised and why.
> 
> ".word 0xe320f003" may be replaced by "wfi". (wait-for-interrupt)
> 
> >
> >> + ? ? /* we should never get past here */
> >> + ? ? panic("sleep resumed to originator?");
> >> +}
> >> +
> >> +static void s5pv210_pm_prepare(void)
> >> +{
> >> + ? ? unsigned int tmp;
> >> +
> >> + ? ? /* ensure at least INFORM0 has the resume address */
> >> + ? ? __raw_writel(virt_to_phys(s3c_cpu_resume), S5P_INFORM0);
> >> +
> >> + ? ? tmp = __raw_readl(S5P_SLEEP_CFG);
> >> + ? ? tmp &= ~(S5P_SLEEP_CFG_OSC_EN | S5P_SLEEP_CFG_USBOSC_EN);
> >> + ? ? __raw_writel(tmp, S5P_SLEEP_CFG);
> >> +
> >> + ? ? /* WFI for SLEEP mode configuration by SYSCON */
> >> + ? ? tmp = __raw_readl(S5P_PWR_CFG);
> >> + ? ? tmp &= S5P_CFG_WFI_CLEAN;
> >> + ? ? tmp |= S5P_CFG_WFI_SLEEP;
> >> + ? ? __raw_writel(tmp, S5P_PWR_CFG);
> >> +
> >> + ? ? /* SYSCON interrupt handling disable */
> >> + ? ? tmp = __raw_readl(S5P_OTHERS);
> >> + ? ? tmp |= S5P_OTHER_SYSC_INTOFF;
> >> + ? ? __raw_writel(tmp, S5P_OTHERS);
> >> +
> >> + ? ? __raw_writel(0xffffffff, (VA_VIC0 + VIC_INT_ENABLE_CLEAR));
> >> + ? ? __raw_writel(0xffffffff, (VA_VIC1 + VIC_INT_ENABLE_CLEAR));
> >> + ? ? __raw_writel(0xffffffff, (VA_VIC2 + VIC_INT_ENABLE_CLEAR));
> >> + ? ? __raw_writel(0xffffffff, (VA_VIC3 + VIC_INT_ENABLE_CLEAR));
> 
> It appears to be omitting VIC_INT_SOFT_CLEAR. I'm not sure whether
> this is also required as VIC_INT_ENABLE_CLEAR does; however, we've
> been doing __raw_writel(0xffffffff, (VA_VICx + VIC_INT_SOFT_CLEAR) as
> well.
> 
> Clearing pending external interrupt when entering a suspend may be
> added here. Sometimes, uncleared pending external interrupts may be
> problematic for a sleep; i.e., having waking-up interrupts pending
> while entering a sleep may be not too pleasant. "writel(0xff,
> S5P_WKUP_INT_PEND**_**);" will do the work. I don't sure whether this
> is really "required" for recent S5PV210/S5PC110; however, clearing
> pending interrupts improved the stability for the old release of
> S5PC110.
> 
> >> +
> >> + ? ? s3c_pm_do_save(s5pv210_core_save, ARRAY_SIZE(s5pv210_core_save));
> >> +}
> >> +
> >> +static int s5pv210_pm_add(struct sys_device *sysdev)
> >> +{
> >> + ? ? pm_cpu_prep = s5pv210_pm_prepare;
> >> + ? ? pm_cpu_sleep = s5pv210_cpu_suspend;
> >> +
> >> + ? ? return 0;
> >> +}
> >> +
> >> +static int s5pv210_pm_resume(struct sys_device *dev)
> >> +{
> >> + ? ? u32 tmp;
> >> +
> >> + ? ? tmp = __raw_readl(S5P_OTHERS);
> >> + ? ? tmp |= (S5P_OTHERS_RET_IO | S5P_OTHERS_RET_CF | \
> >> + ? ? ? ? ? ? S5P_OTHERS_RET_MMC | S5P_OTHERS_RET_UART);
> >> + ? ? __raw_writel(tmp , S5P_OTHERS);
> >> +
> >> + ? ? s3c_pm_do_restore_core(s5pv210_core_save, ARRAY_SIZE(s5pv210_core_save));
> >> +
> >> + ? ? return 0;
> >> +}
> 
> I don't know how may "printk"s exist after s3c_pm_enter is returned
> and before this resume function is called. However, printk's (and
> debug messages) between these two often generate broken characters on
> UART terminal. It may be better if S5P_OTHERS setting is done much
> earlier; e.g., at arch/arm/plat-samsung/pm.c:s3c_pm_enter.
> 
> However, this operation may be done at the boot-loader; in such a
> case, this doesn't matter at all.
> 
> >> +
> >> +static struct sysdev_driver s5pv210_pm_driver = {
> >> + ? ? .add ? ? ? ? ? ?= s5pv210_pm_add,
> >> + ? ? .resume ? ? ? ? = s5pv210_pm_resume,
> >> +};
> >> +
> >> +static __init int s5pv210_pm_drvinit(void)
> >> +{
> >> + ? ? return sysdev_driver_register(&s5pv210_sysclass, &s5pv210_pm_driver);
> >> +}
> >> +arch_initcall(s5pv210_pm_drvinit);
> >> diff --git a/arch/arm/mach-s5pv210/sleep.S b/arch/arm/mach-s5pv210/sleep.S
> >> new file mode 100644
> >> index 0000000..b7f8272
> >> --- /dev/null
> >> +++ b/arch/arm/mach-s5pv210/sleep.S
> >> @@ -0,0 +1,166 @@
> >> +/* linux/arch/arm/mach-s5pv210/sleep.S
> >> + *
> >> + * Copyright (c) 2010 Samsung Electronics Co., Ltd.
> >> + * ? ? ? ? ? http://www.samsung.com
> >> + *
> >> + * S5PV210 power Manager (Suspend-To-RAM) support
> >> + *
> >> + * Based on S3C2410 sleep code by:
> >> + * ? Ben Dooks, (c) 2004 Simtec Electronics
> >> + *
> >> + * Based on PXA/SA1100 sleep code by:
> >> + * ? Nicolas Pitre, (c) 2002 Monta Vista Software Inc
> >> + * ? Cliff Brake, (c) 2001
> >> + *
> >> + * This program is free software; you can redistribute it and/or modify
> >> + * it under the terms of the GNU General Public License as published by
> >> + * the Free Software Foundation; either version 2 of the License, or
> >> + * (at your option) any later version.
> >> + *
> >> + * This program is distributed in the hope that it will be useful,
> >> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> >> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. ?See the
> >> + * GNU General Public License for more details.
> >> + *
> >> + * You should have received a copy of the GNU General Public License
> >> + * along with this program; if not, write to the Free Software
> >> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA ?02111-1307 ?USA
> >> +*/
> >> +
> >> +#include <linux/linkage.h>
> >> +#include <asm/assembler.h>
> >> +#include <asm/memory.h>
> >> +
> >> + ? ? .text
> >> +
> >> + ? ? /* s3c_cpu_save
> >> + ? ? ?*
> >> + ? ? ?* entry:
> >> + ? ? ?* ? ? ?r0 = save address (virtual addr of s3c_sleep_save_phys)
> >> + ? ? */
> >> +
> >> +ENTRY(s3c_cpu_save)
> >> +
> >> + ? ? stmfd ? sp!, { r3 - r12, lr }
> >> +
> >> + ? ? mrc ? ? p15, 0, r4, c13, c0, 0 ?@ FCSE/PID
> >> + ? ? mrc ? ? p15, 0, r5, c3, c0, 0 ? @ Domain ID
> >> + ? ? mrc ? ? p15, 0, r6, c2, c0, 0 ? @ Translation Table BASE0
> >> + ? ? mrc ? ? p15, 0, r7, c2, c0, 1 ? @ Translation Table BASE1
> >> + ? ? mrc ? ? p15, 0, r8, c2, c0, 2 ? @ Translation Table Control
> >> + ? ? mrc ? ? p15, 0, r9, c1, c0, 0 ? @ Control register
> >> + ? ? mrc ? ? p15, 0, r10, c1, c0, 1 ?@ Auxiliary control register
> >> + ? ? mrc ? ? p15, 0, r11, c1, c0, 2 ?@ Co-processor access controls
> >> + ? ? mrc ? ? p15, 0, r12, c10, c2, 0 @ Read PRRR
> >> + ? ? mrc ? ? p15, 0, r3, c10, c2, 1 ?@ READ NMRR
> >> +
> >> + ? ? stmia ? r0, { r3 - r13 }
> >> +
> >> + ? ? bl ? ? ?s3c_pm_cb_flushcache
> >> +
> >> + ? ? ldr ? ? r0, =pm_cpu_sleep
> >> + ? ? ldr ? ? r0, [ r0 ]
> >> + ? ? mov ? ? pc, r0
> >> +
> >> +resume_with_mmu:
> >> + ? ? /* delete added mmu table list */
> >
> > hmm, where is this being added?
> > also, a better description on what it is doing would be better.
> >
> >> + ? ? ldr ? ? r9 , =(PAGE_OFFSET - PHYS_OFFSET)
> >> + ? ? add ? ? r4, r4, r9
> >> + ? ? str ? ? r12, [r4]
> >> +
> >> + ? ? ldmfd ? sp!, { r3 - r12, pc }
> >> +
> >> + ? ? .ltorg
> >> +
> >> + ? ? .data
> >> +
> >> + ? ? .global s3c_sleep_save_phys
> >> +s3c_sleep_save_phys:
> >> + ? ? .word ? 0
> >> +
> >> + ? ? /* sleep magic, to allow the bootloader to check for an valid
> >> + ? ? ?* image to resume to. Must be the first word before the
> >> + ? ? ?* s3c_cpu_resume entry.
> >> + ? ? */
> >> +
> >> + ? ? .word ? 0x2bedf00d
> >> +
> >> + ? ? /* s3c_cpu_resume
> >> + ? ? ?*
> >> + ? ? ?* resume code entry for bootloader to call
> >> + ? ? ?*
> >> + ? ? ?* we must put this code here in the data segment as we have no
> >> + ? ? ?* other way of restoring the stack pointer after sleep, and we
> >> + ? ? ?* must not write to the code segment (code is read-only)
> >> + ? ? */
> >> +
> >> +ENTRY(s3c_cpu_resume)
> >> + ? ? mov ? ? r0, #PSR_I_BIT | PSR_F_BIT | SVC_MODE
> >> + ? ? msr ? ? cpsr_c, r0
> >> +
> >> + ? ? mov ? ? r1, #0
> >> + ? ? mcr ? ? p15, 0, r1, c8, c7, 0 ? ? ? ? ? @@ invalidate TLBs
> >> + ? ? mcr ? ? p15, 0, r1, c7, c5, 0 ? ? ? ? ? @@ invalidate I Cache
> >> +
> >> + ? ? ldr ? ? r0, s3c_sleep_save_phys ? ? ? ? @ address of restore block
> >> + ? ? ldmia ? r0, { r3 - r13 }
> >> +
> >> + ? ? mcr ? ? p15, 0, r4, c13, c0, 0 ? ? ? ? ?@ FCSE/PID
> >> + ? ? mcr ? ? p15, 0, r5, c3, c0, 0 ? ? ? ? ? @ Domain ID
> >> +
> >> + ? ? mcr ? ? p15, 0, r8, c2, c0, 2 ? ? ? ? ? @ Translation Table Control
> >> + ? ? mcr ? ? p15, 0, r7, c2, c0, 1 ? ? ? ? ? @ Translation Table BASE1
> >> + ? ? mcr ? ? p15, 0, r6, c2, c0, 0 ? ? ? ? ? @ Translation Table BASE0
> >> +
> >> + ? ? mcr ? ? p15, 0, r10, c1, c0, 1 ? ? ? ? ?@ Auxiliary control register
> >> +
> >> + ? ? mov ? ? r0, #0
> >> + ? ? mcr ? ? p15, 0, r0, c8, c7, 0 ? ? ? ? ? @ Invalidate I & D TLB
> >> +
> >> + ? ? mov ? ? r0, #0 ? ? ? ? ? ? ? ? ? ? ? ? ?@ restore copro access
> >> + ? ? mcr ? ? p15, 0, r11, c1, c0, 2 ? ? ? ? ?@ Co-processor access
> >> + ? ? mcr ? ? p15, 0, r0, c7, c5, 4
> >> +
> >> + ? ? mcr ? ? p15, 0, r12, c10, c2, 0 ? ? ? ? @ write PRRR
> >> + ? ? mcr ? ? p15, 0, r3, c10, c2, 1 ? ? ? ? ?@ write NMRR
> >> +
> >> + ? ? /* Calculate first section address into r8
> >> + ? ? ?* In Cotex-A8 case, When MMU turn on, MMU is reseted.
> >
> > i'd fix this typo.
> >
> >> + ? ? ?* So, before call resume_with_mmu, backup originally data.
> >> + ? ? */
> >> +
> >> + ? ? mov ? ? r4, r6
> >> + ? ? mov ? ? r4, r4, LSR #14
> >> + ? ? mov ? ? r4, r4, LSL #14
> >> +
> >> + ? ? /* Load TLB Base address from INFORM0 */
> >
> > do you mean mmu page table?
> >
> >> + ? ? ldr ? ? r11, =0xe010f000
> >> + ? ? ldr ? ? r10, [r11, #0]
> >> + ? ? mov ? ? r10, r10, LSR #18
> >> + ? ? bic ? ? r10, r10, #0x3
> >> + ? ? orr ? ? r4, r4, r10
> >> +
> >> + ? ? /* calculate mmu list value into r9 */
> >> + ? ? mov ? ? r10, r10, LSL #18
> >> + ? ? ldr ? ? r5, =0x40e
> >> + ? ? orr ? ? r10, r10, r5
> >> +
> >> + ? ? /* back up originally data */
> >> +
> >> + ? ? ldr ? ? r12, [r4]
> >> +
> >> + ? ? /* Added list about mmu */
> >> + ? ? str ? ? r10, [r4]
> >
> >
> >
> >> + ? ? ldr ? ? r2, =resume_with_mmu
> >> + ? ? mcr ? ? p15, 0, r9, c1, c0, 0 ? ? ? ? ? @ turn on MMU, etc
> >> +
> >> + ? ? nop
> >> + ? ? nop
> >> + ? ? nop
> >> + ? ? nop
> >> + ? ? nop ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? @ second-to-last before mmu
> >> +
> >> + ? ? mov ? ? pc, r2 ? ? ? ? ? ? ? ? ? ? ? ? ?@ go back to virtual address
> >> +
> >> + ? ? .ltorg
> >> diff --git a/arch/arm/plat-s5p/Makefile b/arch/arm/plat-s5p/Makefile
> >> index 39c242b..d04ae49 100644
> >> --- a/arch/arm/plat-s5p/Makefile
> >> +++ b/arch/arm/plat-s5p/Makefile
> >> @@ -18,3 +18,5 @@ obj-y ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? += clock.o
> >> ?obj-y ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?+= irq.o
> >> ?obj-$(CONFIG_S5P_EXT_INT) ? ?+= irq-eint.o
> >>
> >> +obj-$(CONFIG_PM) ? ? ? ? ? ? += pm.o
> >> +obj-$(CONFIG_PM) ? ? ? ? ? ? += irq-pm.o
> >> diff --git a/arch/arm/plat-s5p/include/plat/irqs.h b/arch/arm/plat-s5p/include/plat/irqs.h
> >> index 3fb3a3a..9ffdd62 100644
> >> --- a/arch/arm/plat-s5p/include/plat/irqs.h
> >> +++ b/arch/arm/plat-s5p/include/plat/irqs.h
> >> @@ -94,4 +94,6 @@
> >> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ((irq) - S5P_EINT_BASE1) : \
> >> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ((irq) + 16 - S5P_EINT_BASE2))
> >>
> >> +#define IRQ_EINT_BIT(x) ? ? ? ? ? ? ?EINT_OFFSET(x)
> >> +
> >> ?#endif /* __ASM_PLAT_S5P_IRQS_H */
> >> diff --git a/arch/arm/plat-s5p/irq-pm.c b/arch/arm/plat-s5p/irq-pm.c
> >> new file mode 100644
> >> index 0000000..03e83a3
> >> --- /dev/null
> >> +++ b/arch/arm/plat-s5p/irq-pm.c
> >> @@ -0,0 +1,108 @@
> >> +/* linux/arch/arm/plat-s5p/irq-pm.c
> >> + *
> >> + * Copyright (c) 2010 Samsung Electronics Co., Ltd.
> >> + * ? ? ? ? ? http://www.samsung.com
> >> + *
> >> + * Based on arch/arm/plat-s3c24xx/irq-pm.c,
> >> + * Copyright (c) 2003,2004 Simtec Electronics
> >> + * ? Ben Dooks <ben@simtec.co.uk>
> >> + * ? http://armlinux.simtec.co.uk/
> >> + *
> >> + * This program is free software; you can redistribute it and/or modify
> >> + * it under the terms of the GNU General Public License version 2 as
> >> + * published by the Free Software Foundation.
> >> +*/
> >> +
> >> +#include <linux/init.h>
> >> +#include <linux/module.h>
> >> +#include <linux/interrupt.h>
> >> +#include <linux/sysdev.h>
> >> +
> >> +#include <plat/cpu.h>
> >> +#include <plat/irqs.h>
> >> +#include <plat/pm.h>
> >> +#include <mach/map.h>
> >> +
> >> +#include <mach/regs-gpio.h>
> >> +#include <mach/regs-irq.h>
> >> +
> >> +/* state for IRQs over sleep */
> >> +
> >> +/* default is to allow for EINT0..EINT31, and IRQ_RTC_TIC, IRQ_RTC_ALARM,
> >> + * as wakeup sources
> >> + *
> >> + * set bit to 1 in allow bitfield to enable the wakeup settings on it
> >> +*/
> >> +
> >> +unsigned long s3c_irqwake_intallow ? = 0x00000006L;
> >> +unsigned long s3c_irqwake_eintallow ?= 0xffffffffL;
> >> +
> >> +int s3c_irq_wake(unsigned int irqno, unsigned int state)
> >> +{
> >> + ? ? unsigned long irqbit;
> >> +
> >> + ? ? switch (irqno) {
> >> + ? ? case IRQ_RTC_TIC:
> >> + ? ? case IRQ_RTC_ALARM:
> >> + ? ? ? ? ? ? irqbit = 1 << (irqno + 1 - IRQ_RTC_ALARM);
> >> + ? ? ? ? ? ? if (!state)
> >> + ? ? ? ? ? ? ? ? ? ? s3c_irqwake_intmask |= irqbit;
> >> + ? ? ? ? ? ? else
> >> + ? ? ? ? ? ? ? ? ? ? s3c_irqwake_intmask &= ~irqbit;
> >> + ? ? ? ? ? ? break;
> >> + ? ? default:
> >> + ? ? ? ? ? ? return -ENOENT;
> >> + ? ? }
> >> + ? ? return 0;
> >> +}
> >> +
> >> +/* this lot should be really saved by the IRQ code */
> >> +/* VICXADDRESSXX initilaization to be needed */
> >> +static struct sleep_save irq_save[] = {
> >> + ? ? SAVE_ITEM(VA_VIC0 + VIC_INT_SELECT),
> >> + ? ? SAVE_ITEM(VA_VIC1 + VIC_INT_SELECT),
> >> +
> >> + ? ? SAVE_ITEM(VA_VIC0 + VIC_INT_ENABLE),
> >> + ? ? SAVE_ITEM(VA_VIC1 + VIC_INT_ENABLE),
> >> +
> >> + ? ? SAVE_ITEM(VA_VIC0 + VIC_INT_SOFT),
> >> + ? ? SAVE_ITEM(VA_VIC1 + VIC_INT_SOFT),
> 
> S5PV210 has VIC2,3 as well. Maybe those can be moved from pm.c to here.
> 
> >> +};
> >> +
> >> +static struct sleep_save eint_save[] = {
> >> + ? ? SAVE_ITEM(S5P_EINT_CON(0)),
> >> + ? ? SAVE_ITEM(S5P_EINT_CON(1)),
> >> + ? ? SAVE_ITEM(S5P_EINT_CON(2)),
> >> + ? ? SAVE_ITEM(S5P_EINT_CON(3)),
> >> +
> >> + ? ? SAVE_ITEM(S5P_EINT_FLTCON(0)),
> >> + ? ? SAVE_ITEM(S5P_EINT_FLTCON(1)),
> >> + ? ? SAVE_ITEM(S5P_EINT_FLTCON(2)),
> >> + ? ? SAVE_ITEM(S5P_EINT_FLTCON(3)),
> >> + ? ? SAVE_ITEM(S5P_EINT_FLTCON(4)),
> >> + ? ? SAVE_ITEM(S5P_EINT_FLTCON(5)),
> >> + ? ? SAVE_ITEM(S5P_EINT_FLTCON(6)),
> >> + ? ? SAVE_ITEM(S5P_EINT_FLTCON(7)),
> >> +
> >> + ? ? SAVE_ITEM(S5P_EINT_MASK(0)),
> >> + ? ? SAVE_ITEM(S5P_EINT_MASK(1)),
> >> + ? ? SAVE_ITEM(S5P_EINT_MASK(2)),
> >> + ? ? SAVE_ITEM(S5P_EINT_MASK(3)),
> >> +};
> >> +
> >> +int s3c24xx_irq_suspend(struct sys_device *dev, pm_message_t state)
> >> +{
> >> + ? ? s3c_pm_do_save(eint_save, ARRAY_SIZE(eint_save));
> >> + ? ? s3c_pm_do_save(irq_save, ARRAY_SIZE(irq_save));
> >> +
> >> + ? ? return 0;
> >> +}
> >> +
> >> +int s3c24xx_irq_resume(struct sys_device *dev)
> >> +{
> >> + ? ? s3c_pm_do_restore(irq_save, ARRAY_SIZE(irq_save));
> >> + ? ? s3c_pm_do_restore(eint_save, ARRAY_SIZE(eint_save));
> >> +
> >> + ? ? return 0;
> >> +}
> >> +
> >> diff --git a/arch/arm/plat-s5p/pm.c b/arch/arm/plat-s5p/pm.c
> >> new file mode 100644
> >> index 0000000..d592b63
> >> --- /dev/null
> >> +++ b/arch/arm/plat-s5p/pm.c
> >> @@ -0,0 +1,52 @@
> >> +/* linux/arch/arm/plat-s5p/pm.c
> >> + *
> >> + * Copyright (c) 2010 Samsung Electronics Co., Ltd.
> >> + * ? ? ? ? ? http://www.samsung.com
> >> + *
> >> + * S5P Power Manager (Suspend-To-RAM) support
> >> + *
> >> + * Based on arch/arm/plat-s3c24xx/pm.c
> >> + * Copyright (c) 2004,2006 Simtec Electronics
> >> + * ? Ben Dooks <ben@simtec.co.uk>
> >> + *
> >> + * This program is free software; you can redistribute it and/or modify
> >> + * it under the terms of the GNU General Public License version 2 as
> >> + * published by the Free Software Foundation.
> >> +*/
> >> +
> >> +#include <linux/suspend.h>
> >> +#include <plat/pm.h>
> >> +
> >> +#define PFX "s5p pm: "
> >> +
> >> +/* s3c_pm_check_resume_pin
> >> + *
> >> + * check to see if the pin is configured correctly for sleep mode, and
> >> + * make any necessary adjustments if it is not
> >> +*/
> >> +
> >> +static void s3c_pm_check_resume_pin(unsigned int pin, unsigned int irqoffs)
> >> +{
> >> + ? ? /* nothing here yet */
> >> +}
> >> +
> >> +/* s3c_pm_configure_extint
> >> + *
> >> + * configure all external interrupt pins
> >> +*/
> >> +
> >> +void s3c_pm_configure_extint(void)
> >> +{
> >> + ? ? /* nothing here yet */
> >> +}
> >> +
> >> +void s3c_pm_restore_core(void)
> >> +{
> >> + ? ? /* nothing here yet */
> >> +}
> >> +
> >> +void s3c_pm_save_core(void)
> >> +{
> >> + ? ? /* nothing here yet */
> >> +}
> >> +
> >> diff --git a/arch/arm/plat-samsung/pm-gpio.c b/arch/arm/plat-samsung/pm-gpio.c
> >> index 7df03f8..9652820 100644
> >> --- a/arch/arm/plat-samsung/pm-gpio.c
> >> +++ b/arch/arm/plat-samsung/pm-gpio.c
> >> @@ -192,7 +192,7 @@ struct s3c_gpio_pm s3c_gpio_pm_2bit = {
> >> ? ? ? .resume = s3c_gpio_pm_2bit_resume,
> >> ?};
> >>
> >> -#ifdef CONFIG_ARCH_S3C64XX
> >> +#if defined(CONFIG_ARCH_S3C64XX) || defined(CONFIG_PLAT_S5P)
> >> ?static void s3c_gpio_pm_4bit_save(struct s3c_gpio_chip *chip)
> >> ?{
> >> ? ? ? chip->pm_save[1] = __raw_readl(chip->base + OFFS_CON);
> >> @@ -302,7 +302,7 @@ struct s3c_gpio_pm s3c_gpio_pm_4bit = {
> >> ? ? ? .save ? = s3c_gpio_pm_4bit_save,
> >> ? ? ? .resume = s3c_gpio_pm_4bit_resume,
> >> ?};
> >> -#endif /* CONFIG_ARCH_S3C64XX */
> >> +#endif /* CONFIG_ARCH_S3C64XX || CONFIG_PLAT_S5P */
> >>
> >> ?/**
> >> ? * s3c_pm_save_gpio() - save gpio chip data for suspend
> >> --
> >> 1.6.2.5
> >>
> >
> >
> > --
> > --
> > Ben
> >
> > Q: ? ? ?What's a light-year?
> > A: ? ? ?One-third less calories than a regular year.
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >
> 
> 
> 
> -- 
> MyungJoo Ham (?????????), Ph.D.
> Mobile Software Platform Lab,
> Digital Media and Communications (DMC) Business
> Samsung Electronics
> cell: 82-10-6714-2858
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
