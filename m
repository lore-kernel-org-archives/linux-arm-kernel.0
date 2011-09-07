From: kesavan.abhilash@gmail.com (Abhilash Kesavan)
Date: Wed, 7 Sep 2011 12:03:52 +0530
Subject: [PATCH 5/5] ARM: S5P64X0: Add Power Management support
In-Reply-To: <000501cc6d23$a7730e00$f6592a00$%kim@samsung.com>
References: <1313144787-30666-1-git-send-email-a.kesavan@samsung.com>
	<1313144787-30666-6-git-send-email-a.kesavan@samsung.com>
	<000501cc6d23$a7730e00$f6592a00$%kim@samsung.com>
Message-ID: <CAM4voa=sRSNCwxvHs=RHzRabksA83iXfapKcBe_g7H=NatHs3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mr Kim,

On Wed, Sep 7, 2011 at 11:31 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Abhilash Kesavan wrote:
>>
>> Add suspend-to-ram support for SMDK6440/50
>>
>> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
>> ---
>> ?arch/arm/Kconfig ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?| ? ?2 +-
>> ?arch/arm/mach-s5p64x0/Kconfig ? ? ? ? ? ? ? ? ? | ? ?4 +
>> ?arch/arm/mach-s5p64x0/Makefile ? ? ? ? ? ? ? ? ?| ? ?1 +
>> ?arch/arm/mach-s5p64x0/include/mach/map.h ? ? ? ?| ? ?1 +
>> ?arch/arm/mach-s5p64x0/include/mach/pm-core.h ? ?| ?117 +++++++++++++
>> ?arch/arm/mach-s5p64x0/include/mach/regs-clock.h | ? 33 ++++
>> ?arch/arm/mach-s5p64x0/include/mach/regs-gpio.h ?| ? 19 ++
>> ?arch/arm/mach-s5p64x0/irq-eint.c ? ? ? ? ? ? ? ?| ? ?2 +
>> ?arch/arm/mach-s5p64x0/irq-pm.c ? ? ? ? ? ? ? ? ?| ? 92 ++++++++++
>> ?arch/arm/mach-s5p64x0/pm.c ? ? ? ? ? ? ? ? ? ? ?| ?204
>> +++++++++++++++++++++++
>> ?10 files changed, 474 insertions(+), 1 deletions(-)
>> ?create mode 100644 arch/arm/mach-s5p64x0/include/mach/pm-core.h
>> ?create mode 100644 arch/arm/mach-s5p64x0/irq-pm.c
>> ?create mode 100644 arch/arm/mach-s5p64x0/pm.c
>>
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index 2c71a8f..47aed0d 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -2071,7 +2071,7 @@ menu "Power management options"
>> ?source "kernel/power/Kconfig"
>>
>> ?config ARCH_SUSPEND_POSSIBLE
>> - ? ? depends on !ARCH_S5P64X0 && !ARCH_S5PC100
>> + ? ? depends on !ARCH_S5PC100
>> ? ? ? depends on CPU_ARM920T || CPU_ARM926T || CPU_SA1100 || \
>> ? ? ? ? ? ? ? CPU_V6 || CPU_V6K || CPU_V7 || CPU_XSC3 || CPU_XSCALE
>> ? ? ? def_bool y
>> diff --git a/arch/arm/mach-s5p64x0/Kconfig b/arch/arm/mach-s5p64x0/Kconfig
>> index 65c7518..d7f034a 100644
>> --- a/arch/arm/mach-s5p64x0/Kconfig
>> +++ b/arch/arm/mach-s5p64x0/Kconfig
>> @@ -11,6 +11,8 @@ config CPU_S5P6440
>> ? ? ? bool
>> ? ? ? select S3C_PL330_DMA
>> ? ? ? select S5P_HRT
>> + ? ? select SAMSUNG_SLEEP if PM
>> + ? ? select SAMSUNG_WAKEMASK if PM
>> ? ? ? help
>> ? ? ? ? Enable S5P6440 CPU support
>>
>> @@ -18,6 +20,8 @@ config CPU_S5P6450
>> ? ? ? bool
>> ? ? ? select S3C_PL330_DMA
>> ? ? ? select S5P_HRT
>> + ? ? select SAMSUNG_SLEEP if PM
>> + ? ? select SAMSUNG_WAKEMASK if PM
>> ? ? ? help
>> ? ? ? ? Enable S5P6450 CPU support
>>
>> diff --git a/arch/arm/mach-s5p64x0/Makefile
> b/arch/arm/mach-s5p64x0/Makefile
>> index 5f6afdf..acfebb7 100644
>> --- a/arch/arm/mach-s5p64x0/Makefile
>> +++ b/arch/arm/mach-s5p64x0/Makefile
>> @@ -16,6 +16,7 @@ obj-$(CONFIG_ARCH_S5P64X0) ?+= cpu.o init.o
>> clock.o dma.o gpiolib.o
>> ?obj-$(CONFIG_ARCH_S5P64X0) ? += setup-i2c0.o irq-eint.o
>> ?obj-$(CONFIG_CPU_S5P6440) ? ?+= clock-s5p6440.o
>> ?obj-$(CONFIG_CPU_S5P6450) ? ?+= clock-s5p6450.o
>> +obj-$(CONFIG_PM) ? ? ? ? ? ? += pm.o irq-pm.o
>>
>> ?# machine support
>>
>> diff --git a/arch/arm/mach-s5p64x0/include/mach/map.h b/arch/arm/mach-
>> s5p64x0/include/mach/map.h
>> index 95c9125..6138f7c 100644
>> --- a/arch/arm/mach-s5p64x0/include/mach/map.h
>> +++ b/arch/arm/mach-s5p64x0/include/mach/map.h
>> @@ -85,5 +85,6 @@
>> ?#define S5P_PA_UART5 ? ? ? ? S5P6450_PA_UART(5)
>>
>> ?#define S5P_SZ_UART ? ? ? ? ?SZ_256
>> +#define S3C_VA_UARTx(x) ? ? ? ? ? ? ?(S3C_VA_UART + ((x) *
>> S3C_UART_OFFSET))
>>
>> ?#endif /* __ASM_ARCH_MAP_H */
>> diff --git a/arch/arm/mach-s5p64x0/include/mach/pm-core.h b/arch/arm/mach-
>> s5p64x0/include/mach/pm-core.h
>> new file mode 100644
>> index 0000000..aee9d85
>> --- /dev/null
>> +++ b/arch/arm/mach-s5p64x0/include/mach/pm-core.h
>> @@ -0,0 +1,117 @@
>> +/* linux/arch/arm/mach-s5p64x0/include/mach/pm-core.h
>> + *
>> + * Copyright (c) 2011 Samsung Electronics Co., Ltd.
>> + * ? ? ? ? ? http://www.samsung.com
>> + *
>> + * S5P64X0 - PM core support for arch/arm/plat-samsung/pm.c
>> + *
>> + * Based on PM core support for S3C64XX by Ben Dooks
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#include <mach/regs-gpio.h>
>> +
>> +static inline void s3c_pm_debug_init_uart(void)
>> +{
>> + ? ? u32 tmp = __raw_readl(S5P64X0_CLK_GATE_PCLK);
>> +
>> + ? ? /*
>> + ? ? ?* As a note, since the S5P64X0 UARTs generally have multiple
>> + ? ? ?* clock sources, we simply enable PCLK at the moment and hope
>> + ? ? ?* that the resume settings for the UART are suitable for the
>> + ? ? ?* use with PCLK.
>> + ? ? ?*/
>> + ? ? tmp |= S5P64X0_CLKCON_PCLK_UART0;
>> + ? ? tmp |= S5P64X0_CLKCON_PCLK_UART1;
>> + ? ? tmp |= S5P64X0_CLKCON_PCLK_UART2;
>> + ? ? tmp |= S5P64X0_CLKCON_PCLK_UART3;
>> +
>> + ? ? __raw_writel(tmp, S5P64X0_CLK_GATE_PCLK);
>> + ? ? udelay(10);
>> +}
>> +
>> +static inline void s3c_pm_arch_prepare_irqs(void)
>> +{
>> + ? ? /* VIC should have already been taken care of */
>> +
>> + ? ? /* clear any pending EINT0 interrupts */
>> + ? ? __raw_writel(__raw_readl(S5P64X0_EINT0PEND), S5P64X0_EINT0PEND);
>> +}
>> +
>> +static inline void s3c_pm_arch_stop_clocks(void) { }
>> +static inline void s3c_pm_arch_show_resume_irqs(void) { }
>> +
>> +/*
>> + * make these defines, we currently do not have any need to change
>> + * the IRQ wake controls depending on the CPU we are running on
>> + */
>> +#define s3c_irqwake_eintallow ? ? ? ?((1 << 16) - 1)
>> +#define s3c_irqwake_intallow (~0)
>> +
>> +static inline void s3c_pm_arch_update_uart(void __iomem *regs,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct pm_uart_save *save)
>> +{
>> + ? ? u32 ucon = __raw_readl(regs + S3C2410_UCON);
>> + ? ? u32 ucon_clk = ucon & S3C6400_UCON_CLKMASK;
>> + ? ? u32 save_clk = save->ucon & S3C6400_UCON_CLKMASK;
>> + ? ? u32 new_ucon;
>> + ? ? u32 delta;
>> +
>> + ? ? /*
>> + ? ? ?* S5P64X0 UART blocks only support level interrupts, so ensure that
>> + ? ? ?* when we restore unused UART blocks we force the level interrupt
>> + ? ? ?* settings.
>> + ? ? ?*/
>> + ? ? save->ucon |= S3C2410_UCON_TXILEVEL | S3C2410_UCON_RXILEVEL;
>> +
>> + ? ? /*
>> + ? ? ?* We have a constraint on changing the clock type of the UART
>> + ? ? ?* between UCLKx and PCLK, so ensure that when we restore UCON
>> + ? ? ?* that the CLK field is correctly modified if the bootloader
>> + ? ? ?* has changed anything.
>> + ? ? ?*/
>> + ? ? if (ucon_clk != save_clk) {
>> + ? ? ? ? ? ? new_ucon = save->ucon;
>> + ? ? ? ? ? ? delta = ucon_clk ^ save_clk;
>> +
>> + ? ? ? ? ? ? /*
>> + ? ? ? ? ? ? ?* change from UCLKx => wrong PCLK,
>> + ? ? ? ? ? ? ?* either UCLK can be tested for by a bit-test
>> + ? ? ? ? ? ? ?* with UCLK0
>> + ? ? ? ? ? ? ?*/
>> + ? ? ? ? ? ? if (ucon_clk & S3C6400_UCON_UCLK0 &&
>> + ? ? ? ? ? ? !(save_clk & S3C6400_UCON_UCLK0) &&
>> + ? ? ? ? ? ? delta & S3C6400_UCON_PCLK2) {
>> + ? ? ? ? ? ? ? ? ? ? new_ucon &= ~S3C6400_UCON_UCLK0;
>> + ? ? ? ? ? ? } else if (delta == S3C6400_UCON_PCLK2) {
>> + ? ? ? ? ? ? ? ? ? ? /*
>> + ? ? ? ? ? ? ? ? ? ? ?* as a precaution, don't change from
>> + ? ? ? ? ? ? ? ? ? ? ?* PCLK2 => PCLK or vice-versa
>> + ? ? ? ? ? ? ? ? ? ? ?*/
>> + ? ? ? ? ? ? ? ? ? ? new_ucon ^= S3C6400_UCON_PCLK2;
>> + ? ? ? ? ? ? }
>> +
>> + ? ? ? ? ? ? S3C_PMDBG("ucon change %04x => %04x (save=%04x)\n",
>> + ? ? ? ? ? ? ? ? ? ? ucon, new_ucon, save->ucon);
>> + ? ? ? ? ? ? save->ucon = new_ucon;
>> + ? ? }
>> +}
>> +
>> +static inline void s3c_pm_restored_gpios(void)
>> +{
>> + ? ? /* ensure sleep mode has been cleared from the system */
>> + ? ? __raw_writel(0, S5P64X0_SLPEN);
>> +}
>> +
>> +static inline void s3c_pm_saved_gpios(void)
>> +{
>> + ? ? /*
>> + ? ? ?* turn on the sleep mode and keep it there, as it seems that during
>> + ? ? ?* suspend the xCON registers get re-set and thus you can end up
> with
>> + ? ? ?* problems between going to sleep and resuming.
>> + ? ? ?*/
>> + ? ? __raw_writel(S5P64X0_SLPEN_USE_xSLP, S5P64X0_SLPEN);
>> +}
>> diff --git a/arch/arm/mach-s5p64x0/include/mach/regs-clock.h
> b/arch/arm/mach-
>> s5p64x0/include/mach/regs-clock.h
>> index a133f22..75f66a9 100644
>> --- a/arch/arm/mach-s5p64x0/include/mach/regs-clock.h
>> +++ b/arch/arm/mach-s5p64x0/include/mach/regs-clock.h
>> @@ -41,17 +41,50 @@
>> ?#define S5P6450_DPLL_CON ? ? ? ? ? ? S5P_CLKREG(0x50)
>> ?#define S5P6450_DPLL_CON_K ? ? ? ? ? S5P_CLKREG(0x54)
>>
>> +#define S5P64X0_AHB_CON0 ? ? ? ? ? ? S5P_CLKREG(0x100)
>> ?#define S5P64X0_CLK_SRC1 ? ? ? ? ? ? S5P_CLKREG(0x10C)
>>
>> ?#define S5P64X0_SYS_ID ? ? ? ? ? ? ? ? ? ? ? S5P_CLKREG(0x118)
>> ?#define S5P64X0_SYS_OTHERS ? ? ? ? ? S5P_CLKREG(0x11C)
>>
>> ?#define S5P64X0_PWR_CFG ? ? ? ? ? ? ? ? ? ? ?S5P_CLKREG(0x804)
>> +#define S5P64X0_EINT_WAKEUP_MASK ? ? S5P_CLKREG(0x808)
>> +#define S5P64X0_SLEEP_CFG ? ? ? ? ? ?S5P_CLKREG(0x818)
>> +#define S5P64X0_PWR_STABLE ? ? ? ? ? S5P_CLKREG(0x828)
>> +
>> ?#define S5P64X0_OTHERS ? ? ? ? ? ? ? ? ? ? ? S5P_CLKREG(0x900)
>> +#define S5P64X0_WAKEUP_STAT ? ? ? ? ?S5P_CLKREG(0x908)
>> +
>> +#define S5P64X0_INFORM0 ? ? ? ? ? ? ? ? ? ? ?S5P_CLKREG(0xA00)
>>
>> ?#define S5P64X0_CLKDIV0_HCLK_SHIFT ? (8)
>> ?#define S5P64X0_CLKDIV0_HCLK_MASK ? ?(0xF <<
>> S5P64X0_CLKDIV0_HCLK_SHIFT)
>>
>> +/* HCLK GATE Registers */
>> +#define S5P64X0_CLKCON_HCLK1_FIMGVG ?(1<<2)
>
> Should be added blank around "<<" like (1 << 2).
> And if possible, the name should be same with datasheet like
> ...CLK_GATE_HCLK1_FIMGVG.
>
> Please don't make new name.
OK..will change
>
>> +#define S5P64X0_CLKCON_SCLK1_FIMGVG ?(1<<2)
>
> Same as above.
OK..will change
> ...CLK_GATE_SCLK1_FIMGVG
>
>> +
>> +/* PCLK GATE Registers */
>> +#define S5P64X0_CLKCON_PCLK_UART3 ? ?(1<<4)
>> +#define S5P64X0_CLKCON_PCLK_UART2 ? ?(1<<3)
>> +#define S5P64X0_CLKCON_PCLK_UART1 ? ?(1<<2)
>> +#define S5P64X0_CLKCON_PCLK_UART0 ? ?(1<<1)
>
> Same as above.
OK..will change
>
>> +
>> +#define S5P64X0_PWRCFG_MMC1_DISABLE ?(1 << 15)
>> +#define S5P64X0_PWRCFG_MMC0_DISABLE ?(1 << 14)
>> +#define S5P64X0_PWRCFG_RTC_TICK_DISABLE ? ? ?(1 << 11)
>> +#define S5P64X0_PWRCFG_RTC_ALRM_DISABLE ? ? ?(1 << 10)
>> +#define S5P64X0_PWRCFG_CFG_WFI_MASK ?(3 << 5)
>> +#define S5P64X0_PWRCFG_CFG_WFI_SLEEP (3 << 5)
>> +
>> +#define S5P64X0_SLEEP_CFG_OSC_EN ? ? (1 << 0)
>> +
>> +#define S5P64X0_PWR_STABLE_CNT_VAL_4 (4 << 0)
>
> Same...please use same name with datasheet.
would you like it to be PWR_STABLE_PWR_CNT_VAL_4 ?
>
>> +
>> +#define S5P6450_OTHERS_DISABLE_INT ? (1 << 31)
>> +#define S5P64X0_OTHERS_RET_UART ? ? ? ? ? ? ?(1 << 26)
>> +#define S5P64X0_OTHERS_RET_MMC1 ? ? ? ? ? ? ?(1 << 25)
>> +#define S5P64X0_OTHERS_RET_MMC0 ? ? ? ? ? ? ?(1 << 24)
>> ?#define S5P64X0_OTHERS_USB_SIG_MASK ?(1 << 16)
>>
>> ?/* Compatibility defines */
>> diff --git a/arch/arm/mach-s5p64x0/include/mach/regs-gpio.h
> b/arch/arm/mach-
>> s5p64x0/include/mach/regs-gpio.h
>> index 6ce2547..27a2230 100644
>> --- a/arch/arm/mach-s5p64x0/include/mach/regs-gpio.h
>> +++ b/arch/arm/mach-s5p64x0/include/mach/regs-gpio.h
>> @@ -34,14 +34,33 @@
>> ?#define S5P6450_GPQ_BASE ? ? ? ? ? ? (S5P_VA_GPIO + 0x0180)
>> ?#define S5P6450_GPS_BASE ? ? ? ? ? ? (S5P_VA_GPIO + 0x0300)
>>
>> +#define S5P64X0_SPCON0 ? ? ? ? ? ? ? ? ? ? ? (S5P_VA_GPIO + 0x1A0)
>> +#define S5P64X0_SPCON1 ? ? ? ? ? ? ? ? ? ? ? (S5P_VA_GPIO + 0x2B0)
>> +
>> +#define S5P64X0_MEM0CONSLP0 ? ? ? ? ?(S5P_VA_GPIO + 0x1C0)
>> +#define S5P64X0_MEM0CONSLP1 ? ? ? ? ?(S5P_VA_GPIO + 0x1C4)
>> +#define S5P64X0_MEM0DRVCON ? ? ? ? ? (S5P_VA_GPIO + 0x1D0)
>> +#define S5P64X0_MEM1DRVCON ? ? ? ? ? (S5P_VA_GPIO + 0x1D4)
>> +
>> +#define S5P64X0_EINT12CON ? ? ? ? ? ?(S5P_VA_GPIO + 0x200)
>> +#define S5P64X0_EINT12FLTCON ? ? ? ? (S5P_VA_GPIO + 0x220)
>> +#define S5P64X0_EINT12MASK ? ? ? ? ? (S5P_VA_GPIO + 0x240)
>> +
>> ?/* External interrupt control registers for group0 */
>>
>> ?#define EINT0CON0_OFFSET ? ? ? ? ? ? (0x900)
>> +#define EINT0FLTCON0_OFFSET ? ? ? ? ?(0x910)
>> +#define EINT0FLTCON1_OFFSET ? ? ? ? ?(0x914)
>> ?#define EINT0MASK_OFFSET ? ? ? ? ? ? (0x920)
>> ?#define EINT0PEND_OFFSET ? ? ? ? ? ? (0x924)
>>
>> ?#define S5P64X0_EINT0CON0 ? ? ? ? ? ?(S5P_VA_GPIO +
>> EINT0CON0_OFFSET)
>> +#define S5P64X0_EINT0FLTCON0 ? ? ? ? (S5P_VA_GPIO +
>> EINT0FLTCON0_OFFSET)
>> +#define S5P64X0_EINT0FLTCON1 ? ? ? ? (S5P_VA_GPIO +
>> EINT0FLTCON1_OFFSET)
>> ?#define S5P64X0_EINT0MASK ? ? ? ? ? ?(S5P_VA_GPIO +
>> EINT0MASK_OFFSET)
>> ?#define S5P64X0_EINT0PEND ? ? ? ? ? ?(S5P_VA_GPIO +
>> EINT0PEND_OFFSET)
>>
>> +#define S5P64X0_SLPEN ? ? ? ? ? ? ? ? ? ? ? ?(S5P_VA_GPIO + 0x930)
>> +#define S5P64X0_SLPEN_USE_xSLP ? ? ? ? ? ? ? (1 << 0)
>> +
>> ?#endif /* __ASM_ARCH_REGS_GPIO_H */
>> diff --git a/arch/arm/mach-s5p64x0/irq-eint.c
> b/arch/arm/mach-s5p64x0/irq-eint.c
>> index fe7380f..3b94c6c 100644
>> --- a/arch/arm/mach-s5p64x0/irq-eint.c
>> +++ b/arch/arm/mach-s5p64x0/irq-eint.c
>> @@ -19,6 +19,7 @@
>>
>> ?#include <plat/regs-irqtype.h>
>> ?#include <plat/gpio-cfg.h>
>> +#include <plat/pm.h>
>>
>> ?#include <mach/regs-gpio.h>
>> ?#include <mach/regs-clock.h>
>> @@ -133,6 +134,7 @@ static int s5p64x0_alloc_gc(void)
>> ? ? ? ct->chip.irq_mask = irq_gc_mask_set_bit;
>> ? ? ? ct->chip.irq_unmask = irq_gc_mask_clr_bit;
>> ? ? ? ct->chip.irq_set_type = s5p64x0_irq_eint_set_type;
>> + ? ? ct->chip.irq_set_wake = s3c_irqext_wake;
>> ? ? ? ct->regs.ack = EINT0PEND_OFFSET;
>> ? ? ? ct->regs.mask = EINT0MASK_OFFSET;
>> ? ? ? irq_setup_generic_chip(gc, IRQ_MSK(16), IRQ_GC_INIT_MASK_CACHE,
>> diff --git a/arch/arm/mach-s5p64x0/irq-pm.c
> b/arch/arm/mach-s5p64x0/irq-pm.c
>> new file mode 100644
>> index 0000000..3e6f245
>> --- /dev/null
>> +++ b/arch/arm/mach-s5p64x0/irq-pm.c
>> @@ -0,0 +1,92 @@
>> +/* linux/arch/arm/mach-s5p64x0/irq-pm.c
>> + *
>> + * Copyright (c) 2011 Samsung Electronics Co., Ltd.
>> + * ? ? ? ? ? http://www.samsung.com
>> + *
>> + * S5P64X0 - Interrupt handling Power Management
>> + *
>> + * Based on arch/arm/mach-s3c64xx/irq-pm.c by Ben Dooks
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#include <linux/syscore_ops.h>
>> +#include <linux/serial_core.h>
>> +#include <linux/io.h>
>> +
>> +#include <plat/regs-serial.h>
>> +#include <plat/pm.h>
>> +
>> +#include <mach/regs-gpio.h>
>> +
>> +static struct sleep_save irq_save[] = {
>> + ? ? SAVE_ITEM(S5P64X0_EINT0CON0),
>> + ? ? SAVE_ITEM(S5P64X0_EINT0FLTCON0),
>> + ? ? SAVE_ITEM(S5P64X0_EINT0FLTCON1),
>> + ? ? SAVE_ITEM(S5P64X0_EINT0MASK),
>> +};
>> +
>> +static struct irq_grp_save {
>> + ? ? u32 ? ? con;
>> + ? ? u32 ? ? fltcon;
>> + ? ? u32 ? ? mask;
>> +} eint_grp_save[4];
>> +
>> +static u32 irq_uart_mask[CONFIG_SERIAL_SAMSUNG_UARTS];
>> +
>> +static int s5p64x0_irq_pm_suspend(void)
>> +{
>> + ? ? struct irq_grp_save *grp = eint_grp_save;
>> + ? ? int i;
>> +
>> + ? ? S3C_PMDBG("%s: suspending IRQs\n", __func__);
>> +
>> + ? ? s3c_pm_do_save(irq_save, ARRAY_SIZE(irq_save));
>> +
>> + ? ? for (i = 0; i < CONFIG_SERIAL_SAMSUNG_UARTS; i++)
>> + ? ? ? ? ? ? irq_uart_mask[i] = __raw_readl(S3C_VA_UARTx(i) +
>> S3C64XX_UINTM);
>> +
>> + ? ? for (i = 0; i < ARRAY_SIZE(eint_grp_save); i++, grp++) {
>> + ? ? ? ? ? ? grp->con = __raw_readl(S5P64X0_EINT12CON + (i * 4));
>> + ? ? ? ? ? ? grp->mask = __raw_readl(S5P64X0_EINT12MASK + (i * 4));
>> + ? ? ? ? ? ? grp->fltcon = __raw_readl(S5P64X0_EINT12FLTCON + (i * 4));
>> + ? ? }
>> +
>> + ? ? return 0;
>> +}
>> +
>> +static void s5p64x0_irq_pm_resume(void)
>> +{
>> + ? ? struct irq_grp_save *grp = eint_grp_save;
>> + ? ? int i;
>> +
>> + ? ? S3C_PMDBG("%s: resuming IRQs\n", __func__);
>> +
>> + ? ? s3c_pm_do_restore(irq_save, ARRAY_SIZE(irq_save));
>> +
>> + ? ? for (i = 0; i < CONFIG_SERIAL_SAMSUNG_UARTS; i++)
>> + ? ? ? ? ? ? __raw_writel(irq_uart_mask[i], S3C_VA_UARTx(i) +
>> S3C64XX_UINTM);
>> +
>> + ? ? for (i = 0; i < ARRAY_SIZE(eint_grp_save); i++, grp++) {
>> + ? ? ? ? ? ? __raw_writel(grp->con, S5P64X0_EINT12CON + (i * 4));
>> + ? ? ? ? ? ? __raw_writel(grp->mask, S5P64X0_EINT12MASK + (i * 4));
>> + ? ? ? ? ? ? __raw_writel(grp->fltcon, S5P64X0_EINT12FLTCON + (i * 4));
>> + ? ? }
>> +
>> + ? ? S3C_PMDBG("%s: IRQ configuration restored\n", __func__);
>> +}
>> +
>> +static struct syscore_ops s5p64x0_irq_syscore_ops = {
>> + ? ? .suspend = s5p64x0_irq_pm_suspend,
>> + ? ? .resume ?= s5p64x0_irq_pm_resume,
>> +};
>> +
>> +static int __init s5p64x0_syscore_init(void)
>> +{
>> + ? ? register_syscore_ops(&s5p64x0_irq_syscore_ops);
>> +
>> + ? ? return 0;
>> +}
>> +core_initcall(s5p64x0_syscore_init);
>> diff --git a/arch/arm/mach-s5p64x0/pm.c b/arch/arm/mach-s5p64x0/pm.c
>> new file mode 100644
>> index 0000000..cced4fb
>> --- /dev/null
>> +++ b/arch/arm/mach-s5p64x0/pm.c
>> @@ -0,0 +1,204 @@
>> +/* linux/arch/arm/mach-s5p64x0/pm.c
>> + *
>> + * Copyright (c) 2011 Samsung Electronics Co., Ltd.
>> + * ? ? ? ? ? http://www.samsung.com
>> + *
>> + * S5P64X0 Power Management Support
>> + *
>> + * Based on arch/arm/mach-s3c64xx/pm.c by Ben Dooks
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> +*/
>> +
>> +#include <linux/suspend.h>
>> +#include <linux/syscore_ops.h>
>> +#include <linux/io.h>
>> +
>> +#include <plat/cpu.h>
>> +#include <plat/pm.h>
>> +#include <plat/regs-timer.h>
>> +#include <plat/wakeup-mask.h>
>> +
>> +#include <mach/regs-clock.h>
>> +#include <mach/regs-gpio.h>
>> +
>> +static struct sleep_save s5p64x0_core_save[] = {
>> + ? ? SAVE_ITEM(S5P64X0_APLL_CON),
>> + ? ? SAVE_ITEM(S5P64X0_MPLL_CON),
>> + ? ? SAVE_ITEM(S5P64X0_EPLL_CON),
>> + ? ? SAVE_ITEM(S5P64X0_EPLL_CON_K),
>> + ? ? SAVE_ITEM(S5P64X0_CLK_SRC0),
>> + ? ? SAVE_ITEM(S5P64X0_CLK_SRC1),
>> + ? ? SAVE_ITEM(S5P64X0_CLK_DIV0),
>> + ? ? SAVE_ITEM(S5P64X0_CLK_DIV1),
>> + ? ? SAVE_ITEM(S5P64X0_CLK_DIV2),
>> + ? ? SAVE_ITEM(S5P64X0_CLK_DIV3),
>> + ? ? SAVE_ITEM(S5P64X0_CLK_GATE_MEM0),
>> + ? ? SAVE_ITEM(S5P64X0_CLK_GATE_HCLK1),
>> + ? ? SAVE_ITEM(S5P64X0_CLK_GATE_SCLK1),
>> +};
>> +
>> +static struct sleep_save s5p64x0_misc_save[] = {
>> + ? ? SAVE_ITEM(S5P64X0_AHB_CON0),
>> + ? ? SAVE_ITEM(S5P64X0_SPCON0),
>> + ? ? SAVE_ITEM(S5P64X0_SPCON1),
>> + ? ? SAVE_ITEM(S5P64X0_MEM0CONSLP0),
>> + ? ? SAVE_ITEM(S5P64X0_MEM0CONSLP1),
>> + ? ? SAVE_ITEM(S5P64X0_MEM0DRVCON),
>> + ? ? SAVE_ITEM(S5P64X0_MEM1DRVCON),
>> +
>> + ? ? SAVE_ITEM(S3C64XX_TINT_CSTAT),
>> +};
>> +
>> +/* DPLL is present only in S5P6450 */
>> +static struct sleep_save s5p6450_core_save[] = {
>> + ? ? SAVE_ITEM(S5P6450_DPLL_CON),
>> + ? ? SAVE_ITEM(S5P6450_DPLL_CON_K),
>> +};
>> +
>> +void s3c_pm_configure_extint(void)
>> +{
>> + ? ? __raw_writel(s3c_irqwake_eintmask, S5P64X0_EINT_WAKEUP_MASK);
>> +}
>> +
>> +void s3c_pm_restore_core(void)
>> +{
>> + ? ? __raw_writel(0, S5P64X0_EINT_WAKEUP_MASK);
>> +
>> + ? ? s3c_pm_do_restore_core(s5p64x0_core_save,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ARRAY_SIZE(s5p64x0_core_save));
>> +
>> + ? ? if ((__raw_readl(S5P64X0_SYS_ID) & 0xFF000) == 0x50000)
>> + ? ? ? ? ? ? s3c_pm_do_restore_core(s5p6450_core_save,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ARRAY_SIZE(s5p6450_core_save));
>
> You can use soc_is_xxx() here.
Yep, wasn't there when I posted the series. Will change.
>
>> +
>> + ? ? s3c_pm_do_restore(s5p64x0_misc_save,
>> ARRAY_SIZE(s5p64x0_misc_save));
>> +}
>> +
>> +void s3c_pm_save_core(void)
>> +{
>> + ? ? s3c_pm_do_save(s5p64x0_misc_save,
>> ARRAY_SIZE(s5p64x0_misc_save));
>> +
>> + ? ? if ((__raw_readl(S5P64X0_SYS_ID) & 0xFF000) == 0x50000)
>> + ? ? ? ? ? ? s3c_pm_do_save(s5p6450_core_save,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ARRAY_SIZE(s5p6450_core_save));
>
> Same.
>
>> +
>> + ? ? s3c_pm_do_save(s5p64x0_core_save,
>> ARRAY_SIZE(s5p64x0_core_save));
>> +}
>> +
>> +static int s5p64x0_cpu_suspend(unsigned long arg)
>> +{
>> + ? ? unsigned long tmp = 0;
>> +
>> + ? ? /*
>> + ? ? ?* Issue the standby signal into the pm unit. Note, we
>> + ? ? ?* issue a write-buffer drain just in case.
>> + ? ? ?*/
>> + ? ? asm("b 1f\n\t"
>> + ? ? ? ? ".align 5\n\t"
>> + ? ? ? ? "1:\n\t"
>> + ? ? ? ? "mcr p15, 0, %0, c7, c10, 5\n\t"
>> + ? ? ? ? "mcr p15, 0, %0, c7, c10, 4\n\t"
>> + ? ? ? ? "mcr p15, 0, %0, c7, c0, 4" : : "r" (tmp));
>> +
>> + ? ? /* we should never get past here */
>> + ? ? panic("sleep resumed to originator?");
>> +}
>> +
>> +/* mapping of interrupts to parts of the wakeup mask */
>> +static struct samsung_wakeup_mask s5p64x0_wake_irqs[] = {
>> + ? ? { .irq = IRQ_RTC_ALARM, .bit =
>> S5P64X0_PWRCFG_RTC_ALRM_DISABLE, },
>> + ? ? { .irq = IRQ_RTC_TIC, ? .bit =
>> S5P64X0_PWRCFG_RTC_TICK_DISABLE, },
>> + ? ? { .irq = IRQ_HSMMC0, ? ?.bit = S5P64X0_PWRCFG_MMC0_DISABLE, },
>> + ? ? { .irq = IRQ_HSMMC1, ? ?.bit = S5P64X0_PWRCFG_MMC1_DISABLE, },
>> +};
>> +
>> +static void s5p64x0_pm_prepare(void)
>> +{
>> + ? ? u32 tmp;
>> +
>> + ? ? samsung_sync_wakemask(S5P64X0_PWR_CFG,
>> + ? ? ? ? ? ? ? ? ? ? s5p64x0_wake_irqs, ARRAY_SIZE(s5p64x0_wake_irqs));
>> +
>> + ? ? /* store the resume address in INFORM0 register */
>> + ? ? __raw_writel(virt_to_phys(s3c_cpu_resume), S5P64X0_INFORM0);
>> +
>> + ? ? /* setup clock gating for FIMGVG block */
>> + ? ? __raw_writel((__raw_readl(S5P64X0_CLK_GATE_HCLK1) | \
>> + ? ? ? ? ? ? (S5P64X0_CLKCON_HCLK1_FIMGVG)),
>> S5P64X0_CLK_GATE_HCLK1);
>> + ? ? __raw_writel((__raw_readl(S5P64X0_CLK_GATE_SCLK1) | \
>> + ? ? ? ? ? ? (S5P64X0_CLKCON_SCLK1_FIMGVG)),
>> S5P64X0_CLK_GATE_SCLK1);
>> +
>> + ? ? /* Configure the stabilization counter with wait time required */
>> + ? ? __raw_writel(S5P64X0_PWR_STABLE_CNT_VAL_4,
>> S5P64X0_PWR_STABLE);
>> +
>> + ? ? /* set WFI to SLEEP mode configuration */
>> + ? ? tmp = __raw_readl(S5P64X0_SLEEP_CFG);
>> + ? ? tmp &= ~(S5P64X0_SLEEP_CFG_OSC_EN);
>> + ? ? __raw_writel(tmp, S5P64X0_SLEEP_CFG);
>> +
>> + ? ? tmp = __raw_readl(S5P64X0_PWR_CFG);
>> + ? ? tmp &= ~(S5P64X0_PWRCFG_CFG_WFI_MASK);
>> + ? ? tmp |= S5P64X0_PWRCFG_CFG_WFI_SLEEP;
>> + ? ? __raw_writel(tmp, S5P64X0_PWR_CFG);
>> +
>> + ? ? /*
>> + ? ? ?* set OTHERS register to disable interrupt before going to
>> + ? ? ?* sleep. This bit is present only in S5P6450, it is reserved
>> + ? ? ?* in S5P6440.
>> + ? ? ?*/
>> + ? ? if ((__raw_readl(S5P64X0_SYS_ID) & 0xFF000) == 0x50000) {
>> + ? ? ? ? ? ? tmp = __raw_readl(S5P64X0_OTHERS);
>> + ? ? ? ? ? ? tmp |= S5P6450_OTHERS_DISABLE_INT;
>> + ? ? ? ? ? ? __raw_writel(tmp, S5P64X0_OTHERS);
>> + ? ? }
>> +
>> + ? ? /* ensure previous wakeup state is cleared before sleeping */
>> + ? ? __raw_writel(__raw_readl(S5P64X0_WAKEUP_STAT),
>> S5P64X0_WAKEUP_STAT);
>> +
>> +}
>> +
>> +static int s5p64x0_pm_add(struct sys_device *sysdev)
>> +{
>> + ? ? pm_cpu_prep = s5p64x0_pm_prepare;
>> + ? ? pm_cpu_sleep = s5p64x0_cpu_suspend;
>> + ? ? pm_uart_udivslot = 1;
>
> If pm_uart_udivslot has value, the UDIVSLOT3 is used...is this right on
> S5P64X0?
UDIVSLOT at an offset of 2C seems fine for 64X0.
>
>> +
>> + ? ? return 0;
>> +}
>> +
>> +static struct sysdev_driver s5p64x0_pm_driver = {
>> + ? ? .add ? ? ? ? ? ?= s5p64x0_pm_add,
>> +};
>> +
>> +static __init int s5p64x0_pm_drvinit(void)
>> +{
>> + ? ? s3c_pm_init();
>> +
>> + ? ? return sysdev_driver_register(&s5p64x0_sysclass,
> &s5p64x0_pm_driver);
>> +}
>> +arch_initcall(s5p64x0_pm_drvinit);
>> +
>> +static void s5p64x0_pm_resume(void)
>> +{
>> + ? ? u32 tmp;
>> +
>> + ? ? tmp = __raw_readl(S5P64X0_OTHERS);
>> + ? ? tmp |= (S5P64X0_OTHERS_RET_MMC0 |
>> S5P64X0_OTHERS_RET_MMC1 | \
>> + ? ? ? ? ? ? ? ? ? ? S5P64X0_OTHERS_RET_UART);
>> + ? ? __raw_writel(tmp , S5P64X0_OTHERS);
>> +}
>> +
>> +static struct syscore_ops s5p64x0_pm_syscore_ops = {
>> + ? ? .resume ? ? ? ? = s5p64x0_pm_resume,
>> +};
>> +
>> +static __init int s5p64x0_pm_syscore_init(void)
>> +{
>> + ? ? register_syscore_ops(&s5p64x0_pm_syscore_ops);
>> +
>> + ? ? return 0;
>> +}
>> +arch_initcall(s5p64x0_pm_syscore_init);
>> --
>> 1.7.4.1
>
> Basically, this codes need small fixing. I mean if this codes have been
> tested on board and it works fine, it's ok to me.
>
> But as you said, s5p64x0 pm is almost same with s3c64xx, so we need to clean
> them up next time :)
Has been tested for 6440 and 6450. Thanks for the review.
>
> Thanks.
>
> Best regards,
> Kgene.
Abhilash
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
