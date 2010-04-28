From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 28 Apr 2010 03:17:32 +0100
Subject: [PATCH 1/5] S3C2416: Add S3C2416-specific registers definitions
In-Reply-To: <1250688667-15639-2-git-send-email-jekhor@gmail.com>
References: <1250688667-15639-1-git-send-email-jekhor@gmail.com>
	<1250688667-15639-2-git-send-email-jekhor@gmail.com>
Message-ID: <20100428021732.GL6684@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 19, 2009 at 04:31:03PM +0300, Yauhen Kharuzhy wrote:
> Add macroses for S3C2416 SoC support.

macros.
 
> Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
> ---
>  arch/arm/mach-s3c2410/include/mach/dma.h           |    2 +-
>  arch/arm/mach-s3c2410/include/mach/irqs.h          |   22 ++-
>  arch/arm/mach-s3c2410/include/mach/map.h           |   14 +
>  arch/arm/mach-s3c2410/include/mach/regs-dsc.h      |   36 +++
>  arch/arm/mach-s3c2410/include/mach/regs-gpio.h     |   28 ++
>  arch/arm/mach-s3c2410/include/mach/regs-irq.h      |   10 +
>  .../mach-s3c2410/include/mach/regs-s3c2416-clock.h |  285 ++++++++++++++++++++
>  .../mach-s3c2410/include/mach/regs-s3c2416-mem.h   |   30 ++
>  arch/arm/mach-s3c2410/include/mach/regs-s3c2416.h  |   24 ++
>  9 files changed, 449 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm/mach-s3c2410/include/mach/regs-s3c2416-clock.h
>  create mode 100644 arch/arm/mach-s3c2410/include/mach/regs-s3c2416-mem.h
>  create mode 100644 arch/arm/mach-s3c2410/include/mach/regs-s3c2416.h
> 
> diff --git a/arch/arm/mach-s3c2410/include/mach/dma.h b/arch/arm/mach-s3c2410/include/mach/dma.h
> index c3a2629..da3d81f 100644
> --- a/arch/arm/mach-s3c2410/include/mach/dma.h
> +++ b/arch/arm/mach-s3c2410/include/mach/dma.h
> @@ -54,7 +54,7 @@ enum dma_ch {
>  #define DMACH_LOW_LEVEL	(1<<28)	/* use this to specifiy hardware ch no */
>  
>  /* we have 4 dma channels */
> -#ifndef CONFIG_CPU_S3C2443
> +#if !defined(CONFIG_CPU_S3C2443) && !defined(CONFIG_CPU_S3C2416)
>  #define S3C_DMA_CHANNELS		(4)
>  #else
>  #define S3C_DMA_CHANNELS		(6)
> diff --git a/arch/arm/mach-s3c2410/include/mach/irqs.h b/arch/arm/mach-s3c2410/include/mach/irqs.h
> index 2a2384f..5c55340 100644
> --- a/arch/arm/mach-s3c2410/include/mach/irqs.h
> +++ b/arch/arm/mach-s3c2410/include/mach/irqs.h
> @@ -115,6 +115,26 @@
>  #define IRQ_S3C2412_SDI		S3C2410_IRQSUB(13)
>  #define IRQ_S3C2412_CF		S3C2410_IRQSUB(14)
>  
> +
> +#define IRQ_S3C2416_EINT8t15	S3C2410_IRQ(5)
> +#define IRQ_S3C2416_DMA		S3C2410_IRQ(17)
> +#define IRQ_S3C2416_UART3	S3C2410_IRQ(18)
> +#define IRQ_S3C2416_SDI1	S3C2410_IRQ(20)
> +#define IRQ_S3C2416_SDI0	S3C2410_IRQ(21)
> +
> +#define IRQ_S3C2416_LCD2	S3C2410_IRQSUB(15)
> +#define IRQ_S3C2416_LCD3	S3C2410_IRQSUB(16)
> +#define IRQ_S3C2416_LCD4	S3C2410_IRQSUB(17)
> +#define IRQ_S3C2416_DMA0	S3C2410_IRQSUB(18)
> +#define IRQ_S3C2416_DMA1	S3C2410_IRQSUB(19)
> +#define IRQ_S3C2416_DMA2	S3C2410_IRQSUB(20)
> +#define IRQ_S3C2416_DMA3	S3C2410_IRQSUB(21)
> +#define IRQ_S3C2416_DMA4	S3C2410_IRQSUB(22)
> +#define IRQ_S3C2416_DMA5	S3C2410_IRQSUB(23)
> +#define IRQ_S32416_WDT		S3C2410_IRQSUB(27)
> +#define IRQ_S32416_AC97		S3C2410_IRQSUB(28)
> +
> +
>  /* extra irqs for s3c2440 */
>  
>  #define IRQ_S3C2440_CAM_C	S3C2410_IRQSUB(11)	/* S3C2443 too */
> @@ -152,7 +172,7 @@
>  #define IRQ_S3C2443_WDT		S3C2410_IRQSUB(27)
>  #define IRQ_S3C2443_AC97	S3C2410_IRQSUB(28)
>  
> -#ifdef CONFIG_CPU_S3C2443
> +#if defined(CONFIG_CPU_S3C2443) || defined(CONFIG_CPU_S3C2416)
>  #define NR_IRQS (IRQ_S3C2443_AC97+1)
>  #else
>  #define NR_IRQS (IRQ_S3C2440_AC97+1)

ok, although it may be worth changing this to CONFIG_CPU_S3C2443_COMPAT
and having a kconfig for these s3c2443-alikes.

> diff --git a/arch/arm/mach-s3c2410/include/mach/map.h b/arch/arm/mach-s3c2410/include/mach/map.h
> index e99b212..b3ae83e 100644
> --- a/arch/arm/mach-s3c2410/include/mach/map.h
> +++ b/arch/arm/mach-s3c2410/include/mach/map.h
> @@ -21,6 +21,10 @@
>  /* USB host controller */
>  #define S3C2410_PA_USBHOST (0x49000000)
>  
> +/* USB 2.0 device controller */
> +#define S3C24XX_PA_USB2DEV (0x49800000)
> +#define S3C24XX_SZ_USB2DEV SZ_1M
> +

ok

>  /* DMA controller */
>  #define S3C2410_PA_DMA	   (0x4B000000)
>  #define S3C24XX_SZ_DMA	   SZ_1M
> @@ -67,6 +71,11 @@
>  #define S3C2443_PA_HSMMC   (0x4A800000)
>  #define S3C2443_SZ_HSMMC   (256)
>  
> +/* S3C2416 HSMMC */
> +#define S3C2416_PA_HSMMC0  (0x4AC00000)
> +#define S3C2416_PA_HSMMC1  (0x4A800000)
> +#define S3C2416_SZ_HSMMC   (256)
> +
>  /* physical addresses of all the chip-select areas */
>  
>  #define S3C2410_CS0 (0x00000000)
> @@ -102,6 +111,11 @@
>  #define S3C_PA_IIC          S3C2410_PA_IIC
>  #define S3C_PA_UART	    S3C24XX_PA_UART
>  #define S3C_PA_USBHOST	S3C2410_PA_USBHOST
> +#ifdef CONFIG_CPU_S3C2416
> +#define S3C_PA_HSMMC0	    S3C2416_PA_HSMMC0
> +#define S3C_PA_HSMMC1	    S3C2416_PA_HSMMC1
> +#else
>  #define S3C_PA_HSMMC0	    S3C2443_PA_HSMMC
> +#endif

I'd prefer to see these changed by the cpu init code.

I think S3C2416_PA_HSMMC1 is S3C2443_PA_HSMMC, so we could simply
re-define the platform id number in the s3c2416 case.
  
>  #endif /* __ASM_ARCH_MAP_H */
> diff --git a/arch/arm/mach-s3c2410/include/mach/regs-dsc.h b/arch/arm/mach-s3c2410/include/mach/regs-dsc.h
> index 3c3853c..98fd4a0 100644
> --- a/arch/arm/mach-s3c2410/include/mach/regs-dsc.h
> +++ b/arch/arm/mach-s3c2410/include/mach/regs-dsc.h
> @@ -19,6 +19,42 @@
>  #define S3C2412_DSC1	   S3C2410_GPIOREG(0xe0)
>  #endif
>  
> +#if defined(CONFIG_CPU_S3C2416)
> +#define S3C2416_DSC0	   S3C2410_GPIOREG(0xc0)
> +#define S3C2416_DSC1	   S3C2410_GPIOREG(0xc4)
> +#define S3C2416_DSC2	   S3C2410_GPIOREG(0xc8)
> +#define S3C2416_DSC3	   S3C2410_GPIOREG(0x110)
> +
> +#define S3C2416_SELECT_DSC0	(0 << 30)
> +#define S3C2416_SELECT_DSC1	(1 << 30)
> +#define S3C2416_SELECT_DSC2	(2 << 30)
> +#define S3C2416_SELECT_DSC3	(3 << 30)
> +
> +#define S3C2416_DSC_GETSHIFT(x)	(x & 30)
> +
> +#define S3C2416_DSC0_CF		(S3C2416_SELECT_DSC0 | 28)
> +#define	S3C2416_DSC0_CF_5mA	(0 << 28)
> +#define	S3C2416_DSC0_CF_10mA	(1 << 28)
> +#define	S3C2416_DSC0_CF_15mA	(2 << 28)
> +#define	S3C2416_DSC0_CF_21mA	(3 << 28)
> +#define	S3C2416_DSC0_CF_MASK	(3 << 28)
> +
> +#define S3C2416_DSC0_nRBE	(S3C2416_SELECT_DSC0 | 26)
> +#define	S3C2416_DSC0_nRBE_5mA	(0 << 26)
> +#define	S3C2416_DSC0_nRBE_10mA	(1 << 26)
> +#define	S3C2416_DSC0_nRBE_15mA	(2 << 26)
> +#define	S3C2416_DSC0_nRBE_21mA	(3 << 26)
> +#define	S3C2416_DSC0_nRBE_MASK	(3 << 26)
> +
> +#define S3C2416_DSC0_nROE	(S3C2416_SELECT_DSC0 | 24)
> +#define	S3C2416_DSC0_nROE_5mA	(0 << 24)
> +#define	S3C2416_DSC0_nROE_10mA	(1 << 24)
> +#define	S3C2416_DSC0_nROE_15mA	(2 << 24)
> +#define	S3C2416_DSC0_nROE_21mA	(3 << 24)
> +#define	S3C2416_DSC0_nROE_MASK	(3 << 24)
> +
> +#endif
> +
>  #if defined(CONFIG_CPU_S3C244X)
>  
>  #define S3C2440_DSC0	   S3C2410_GPIOREG(0xc4)
> diff --git a/arch/arm/mach-s3c2410/include/mach/regs-gpio.h b/arch/arm/mach-s3c2410/include/mach/regs-gpio.h
> index b278d0c..582067c 100644
> --- a/arch/arm/mach-s3c2410/include/mach/regs-gpio.h
> +++ b/arch/arm/mach-s3c2410/include/mach/regs-gpio.h
> @@ -608,29 +608,50 @@
>  #define S3C2410_GPHUP	   S3C2410_GPIOREG(0x78)
>  
>  #define S3C2410_GPH0_nCTS0  (0x02 << 0)
> +#define S3C2416_GPH0_TXD00  (0x02 << 0)
>  
>  #define S3C2410_GPH1_nRTS0  (0x02 << 2)
> +#define S3C2416_GPH1_RXD0  (0x02 << 2)
>  
>  #define S3C2410_GPH2_TXD0   (0x02 << 4)
> +#define S3C2416_GPH2_TXD1   (0x02 << 4)
>  
>  #define S3C2410_GPH3_RXD0   (0x02 << 6)
> +#define S3C2416_GPH3_RXD1   (0x02 << 6)
>  
>  #define S3C2410_GPH4_TXD1   (0x02 << 8)
> +#define S3C2416_GPH4_TXD2   (0x02 << 8)
>  
>  #define S3C2410_GPH5_RXD1   (0x02 << 10)
> +#define S3C2416_GPH5_RXD2   (0x02 << 10)
>  
>  #define S3C2410_GPH6_TXD2   (0x02 << 12)
> +#define S3C2416_GPH6_TXD3   (0x02 << 12)
>  #define S3C2410_GPH6_nRTS1  (0x03 << 12)
> +#define S3C2416_GPH6_nRTS2  (0x03 << 12)
>  
>  #define S3C2410_GPH7_RXD2   (0x02 << 14)
> +#define S3C2416_GPH7_RXD3   (0x02 << 14)
>  #define S3C2410_GPH7_nCTS1  (0x03 << 14)
> +#define S3C2416_GPH7_nCTS2  (0x03 << 14)
>  
>  #define S3C2410_GPH8_UCLK   (0x02 << 16)
> +#define S3C2416_GPH8_nCTS0  (0x02 << 16)
>  
>  #define S3C2410_GPH9_CLKOUT0  (0x02 << 18)
>  #define S3C2442_GPH9_nSPICS0  (0x03 << 18)
> +#define S3C2416_GPH9_nRTS0    (0x02 << 18)
>  
>  #define S3C2410_GPH10_CLKOUT1 (0x02 << 20)
> +#define S3C2416_GPH10_nCTS1   (0x02 << 20)
> +
> +#define S3C2416_GPH11_nRTS1   (0x02 << 22)
> +
> +#define S3C2416_GPH12_EXTUARTCLK (0x02 << 24)
> +
> +#define S3C2416_GPH13_CLKOUT0 (0x02 << 26)
> +
> +#define S3C2416_GPH14_CLKOUT1 (0x02 << 28)
>  
>  /* The S3C2412 and S3C2413 move the GPJ register set to after
>   * GPH, which means all registers after 0x80 are now offset by 0x10
> @@ -684,6 +705,7 @@
>  #define S3C2412_MISCCR_CLK1_CLKsrc  (0<<8)
>  
>  #define S3C2410_MISCCR_USBSUSPND0   (1<<12)
> +#define S3C2416_MISCCR_SEL_SUSPND   (1<<12)
>  #define S3C2410_MISCCR_USBSUSPND1   (1<<13)
>  
>  #define S3C2410_MISCCR_nRSTCON	    (1<<16)
> @@ -693,6 +715,9 @@
>  #define S3C2410_MISCCR_nEN_SCLKE    (1<<19)	/* not 2412 */
>  #define S3C2410_MISCCR_SDSLEEP	    (7<<17)
>  
> +#define S3C2416_MISCCR_FLT_I2C      (1<<24)
> +#define S3C2416_MISCCR_HSSPI_EN2    (1<<31)
> +
>  /* external interrupt control... */
>  /* S3C2410_EXTINT0 -> irq sense control for EINT0..EINT7
>   * S3C2410_EXTINT1 -> irq sense control for EINT8..EINT15
> @@ -760,8 +785,11 @@
>  #define S3C2410_GSTATUS1_IDMASK	   (0xffff0000)
>  #define S3C2410_GSTATUS1_2410	   (0x32410000)
>  #define S3C2410_GSTATUS1_2412	   (0x32412001)
> +#define S3C2410_GSTATUS1_2416	   (0x32416003)
>  #define S3C2410_GSTATUS1_2440	   (0x32440000)
>  #define S3C2410_GSTATUS1_2442	   (0x32440aaa)
> +/* some 2416 CPUs report this value also */
> +#define S3C2410_GSTATUS1_2450	   (0x32450003)
>  
>  #define S3C2410_GSTATUS2_WTRESET   (1<<2)
>  #define S3C2410_GSTATUS2_OFFRESET  (1<<1)
> diff --git a/arch/arm/mach-s3c2410/include/mach/regs-irq.h b/arch/arm/mach-s3c2410/include/mach/regs-irq.h
> index de86ee8..0f07ba3 100644
> --- a/arch/arm/mach-s3c2410/include/mach/regs-irq.h
> +++ b/arch/arm/mach-s3c2410/include/mach/regs-irq.h
> @@ -27,6 +27,16 @@
>  #define S3C2410_SUBSRCPND      S3C2410_IRQREG(0x018)
>  #define S3C2410_INTSUBMSK      S3C2410_IRQREG(0x01C)
>  
> +#define S3C2416_PRIORITY_MODE1		S3C2410_IRQREG(0x030)
> +#define S3C2416_PRIORITY_UPDATE1	S3C2410_IRQREG(0x034)
> +#define S3C2416_SRCPND2			S3C2410_IRQREG(0x040)
> +#define S3C2416_INTMOD2			S3C2410_IRQREG(0x044)
> +#define S3C2416_INTMSK2			S3C2410_IRQREG(0x048)
> +#define S3C2416_INTPND2			S3C2410_IRQREG(0x050)
> +#define S3C2416_INTOFFSET2		S3C2410_IRQREG(0x054)
> +#define S3C2416_PRIORITY_MODE2		S3C2410_IRQREG(0x070)
> +#define S3C2416_PRIORITY_UPDATE2	S3C2410_IRQREG(0x074)
> +

ok.

>  /* mask: 0=enable, 1=disable
>   * 1 bit EINT, 4=EINT4, 23=EINT23
>   * EINT0,1,2,3 are not handled here.
> diff --git a/arch/arm/mach-s3c2410/include/mach/regs-s3c2416-clock.h b/arch/arm/mach-s3c2410/include/mach/regs-s3c2416-clock.h
> new file mode 100644
> index 0000000..e5a5d2f
> --- /dev/null
> +++ b/arch/arm/mach-s3c2410/include/mach/regs-s3c2416-clock.h
> @@ -0,0 +1,285 @@
> +/* arch/arm/mach-s3c2410/include/mach/regs-s3c2416-clock.h
> + *
> + * Copyright (c) 2009 Yauhen Kharuzhy <jekhor@gmail.com>,
> + *	as part of OpenInkpot project
> + * Copyright (c) 2009 Promwad Innovation Company
> + *	Yauhen Kharuzhy <yauhen.kharuzhy@promwad.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * S3C2416 clock register definitions
> +*/
> +
> +#ifndef __ASM_ARM_REGS_S3C2416_CLOCK
> +#define __ASM_ARM_REGS_S3C2416_CLOCK
> +
> +#define S3C2416_CLKREG(x)		((x) + S3C24XX_VA_CLKPWR)
> +
> +#define S3C2416_PLLCON_MDIVSHIFT	14
> +#define S3C2416_PLLCON_PDIVSHIFT	5
> +#define S3C2416_PLLCON_SDIVSHIFT	0
> +#define S3C2416_PLLCON_MDIVMASK		((1<<(1+(23-14)))-1)
> +#define S3C2416_PLLCON_PDIVMASK		((1<<(1+(10-5)))-1)
> +#define S3C2416_PLLCON_SDIVMASK		(7)
> +
> +#define S3C2416_EPLLCON_MDIVSHIFT       16
> +#define S3C2416_EPLLCON_PDIVSHIFT       8
> +#define S3C2416_EPLLCON_SDIVSHIFT       0
> +#define S3C2416_EPLLCON_MDIVMASK        ((1<<(1+(23-16)))-1)
> +#define S3C2416_EPLLCON_PDIVMASK        ((1<<(1+(13-8)))-1)
> +#define S3C2416_EPLLCON_SDIVMASK        (7)
> +
> +#define S3C2416_MPLLCON			S3C2416_CLKREG(0x10)
> +#define S3C2416_EPLLCON			S3C2416_CLKREG(0x18)
> +#define S3C2416_EPLLCON_K		S3C2416_CLKREG(0x1C)
> +#define S3C2416_CLKSRC			S3C2416_CLKREG(0x20)
> +#define S3C2416_CLKDIV0			S3C2416_CLKREG(0x24)
> +#define S3C2416_CLKDIV1			S3C2416_CLKREG(0x28)
> +#define S3C2416_CLKDIV2			S3C2416_CLKREG(0x2C)
> +#define S3C2416_HCLKCON			S3C2416_CLKREG(0x30)
> +#define S3C2416_PCLKCON			S3C2416_CLKREG(0x34)
> +#define S3C2416_SCLKCON			S3C2416_CLKREG(0x38)
> +#define S3C2416_PWRMODE			S3C2416_CLKREG(0x40)
> +#define S3C2416_SWRST			S3C2416_CLKREG(0x44)
> +#define S3C2416_BUSPRI0			S3C2416_CLKREG(0x50)
> +#define S3C2416_SYSID			S3C2416_CLKREG(0x5C)
> +#define S3C2416_PWRCFG			S3C2416_CLKREG(0x60)
> +#define S3C2416_RSTCON			S3C2416_CLKREG(0x64)
> +#define S3C2416_RSTSTAT			S3C2416_CLKREG(0x68)
> +#define S3C2416_WKUPSTAT		S3C2416_CLKREG(0x6C)
> +#define S3C2416_INFORM0			S3C2416_CLKREG(0x70)
> +#define S3C2416_INFORM1			S3C2416_CLKREG(0x74)
> +#define S3C2416_INFORM2			S3C2416_CLKREG(0x78)
> +#define S3C2416_INFORM3			S3C2416_CLKREG(0x7C)
> +#define S3C2416_USB_PHYCTRL		S3C2416_CLKREG(0x80)
> +#define S3C2416_USB_PHYPWR		S3C2416_CLKREG(0x84)
> +#define S3C2416_USB_RSTCON		S3C2416_CLKREG(0x88)
> +#define S3C2416_USB_CLKCON		S3C2416_CLKREG(0x8C)
> +
> +#define S3C2416_SWRST_RESET		(0x533c2416)
> +
> +#define S3C2416_PLLCON_OFF		(1<<24)
> +
> +#define S3C2416_CLKSRC_SELHSSPI0_MPLL	(1<<18)
> +#define S3C2416_CLKSRC_SELHSMMC1_EXTCLK	(1<<17)
> +#define S3C2416_CLKSRC_SELHSMMC0_EXTCLK	(1<<16)
> +
> +#define S3C2416_CLKSRC_I2S_EXT		(1<<14)
> +#define S3C2416_CLKSRC_I2S_EPLLDIV	(0<<14)
> +#define S3C2416_CLKSRC_I2S_EPLLREF	(2<<14)
> +#define S3C2416_CLKSRC_I2S_EPLLREF3	(3<<14)
> +#define S3C2416_CLKSRC_I2S_MASK		(3<<14)
> +
> +#define S3C2416_CLKSRC_EPLLREF_XTAL	(2<<7)
> +#define S3C2416_CLKSRC_EPLLREF_EXTCLK	(3<<7)
> +#define S3C2416_CLKSRC_EPLLREF_MPLLREF	(0<<7)
> +#define S3C2416_CLKSRC_EPLLREF_MPLLREF2	(1<<7)
> +#define S3C2416_CLKSRC_EPLLREF_MASK	(3<<7)
> +
> +#define S3C2416_CLKSRC_ESYSCLK_EPLL	(1<<6)
> +#define S3C2416_CLKSRC_MSYSCLK_MPLL	(1<<4)
> +#define S3C2416_CLKSRC_EXTCLK_DIV	(1<<3)
> +
> +#define S3C2416_CLKDIV0_DVS		(1<<13)
> +#define S3C2416_CLKDIV0_HALF_HCLK	(1<<3)
> +#define S3C2416_CLKDIV0_HALF_PCLK	(1<<2)
> +
> +#define S3C2416_CLKDIV0_HCLKDIV_MASK	(3<<0)
> +
> +#define S3C2416_CLKDIV0_EXTDIV_MASK	(3<<6)
> +#define S3C2416_CLKDIV0_EXTDIV_SHIFT	(6)
> +
> +#define S3C2416_CLKDIV0_PREDIV_MASK	(3<<4)
> +#define S3C2416_CLKDIV0_PREDIV_SHIFT	(4)
> +
> +#define S3C2416_CLKDIV0_ARMDIV_MASK	(7<<9)
> +#define S3C2416_CLKDIV0_ARMDIV_SHIFT	(9)
> +#define S3C2416_CLKDIV0_ARMDIV_1	(0<<9)
> +#define S3C2416_CLKDIV0_ARMDIV_2	(1<<9)
> +#define S3C2416_CLKDIV0_ARMDIV_3	(2<<9)
> +#define S3C2416_CLKDIV0_ARMDIV_4	(3<<9)
> +#define S3C2416_CLKDIV0_ARMDIV_6	(5<<9)
> +#define S3C2416_CLKDIV0_ARMDIV_8	(7<<9)
> +
> +/* S3C2416_CLKDIV1 */
> +
> +#define S3C2416_CLKDIV1_CAMDIV_MASK	(15<<26)
> +#define S3C2416_CLKDIV1_CAMDIV_SHIFT	(26)
> +
> +#define S3C2416_CLKDIV1_HSSPIDIV_MASK	(3<<24)
> +#define S3C2416_CLKDIV1_HSSPIDIV_SHIFT	(24)
> +
> +#define S3C2416_CLKDIV1_DISPDIV_MASK	(0xff<<16)
> +#define S3C2416_CLKDIV1_DISPDIV_SHIFT	(16)
> +
> +#define S3C2416_CLKDIV1_I2SDIV_MASK	(15<<12)
> +#define S3C2416_CLKDIV1_I2SDIV_SHIFT	(12)
> +
> +#define S3C2416_CLKDIV1_UARTDIV_MASK	(15<<8)
> +#define S3C2416_CLKDIV1_UARTDIV_SHIFT	(8)
> +
> +#define S3C2416_CLKDIV1_HSMMCDIV1_MASK	(3<<6)
> +#define S3C2416_CLKDIV1_HSMMCDIV1_SHIFT	(6)
> +
> +#define S3C2416_CLKDIV1_USBHOSTDIV_MASK	(3<<4)
> +#define S3C2416_CLKDIV1_USBHOSTDIV_SHIFT (4)
> +
> +/* S3C2416 CLKDIV2 */
> +
> +#define S3C2416_CLKDIV2_HSMMCDIV0_MASK	(3<<6)
> +#define S3C2416_CLKDIV2_HSMMCDIV0_SHIFT	(6)
> +
> +#define S3C2416_CLKDIV2_SPIDIV0_MPLL_MASK	(0x1f<<6)
> +#define S3C2416_CLKDIV2_SPIDIV0_MPLL_SHIFT	(0)
> +
> +
> +
> +#define S3C2416_CLKCON_NAND
> +
> +#define S3C2416_HCLKCON_DMA0		(1<<0)
> +#define S3C2416_HCLKCON_DMA1		(1<<1)
> +#define S3C2416_HCLKCON_DMA2		(1<<2)
> +#define S3C2416_HCLKCON_DMA3		(1<<3)
> +#define S3C2416_HCLKCON_DMA4		(1<<4)
> +#define S3C2416_HCLKCON_DMA5		(1<<5)
> +#define S3C2416_HCLKCON_DISP		(1<<9)
> +#define S3C2416_HCLKCON_USBH		(1<<11)
> +#define S3C2416_HCLKCON_USBD		(1<<12)
> +#define S3C2416_HCLKCON_IROM		(1<<12)
> +#define S3C2416_HCLKCON_HSMMC0		(1<<15)
> +#define S3C2416_HCLKCON_HSMMC1		(1<<16)
> +#define S3C2416_HCLKCON_SSMC		(1<<18)
> +#define S3C2416_HCLKCON_DRAMC		(1<<19)
> +#define S3C2416_HCLKCON_2D		(1<<20)
> +
> +#define S3C2416_PCLKCON_UART0		(1<<0)
> +#define S3C2416_PCLKCON_UART1		(1<<1)
> +#define S3C2416_PCLKCON_UART2		(1<<2)
> +#define S3C2416_PCLKCON_UART3		(1<<3)
> +#define S3C2416_PCLKCON_IIC		(1<<4)
> +#define S3C2416_PCLKCON_SPI_HS0		(1<<14)
> +#define S3C2416_PCLKCON_ADC		(1<<7)
> +#define S3C2416_PCLKCON_AC97		(1<<8)
> +#define S3C2416_PCLKCON_I2S0		(1<<9)
> +#define S3C2416_PCLKCON_PWMT		(1<<10)
> +#define S3C2416_PCLKCON_WDT		(1<<11)
> +#define S3C2416_PCLKCON_RTC		(1<<12)
> +#define S3C2416_PCLKCON_GPIO		(1<<13)
> +#define S3C2416_PCLKCON_PCM		(1<<13)
> +
> +#define S3C2416_SCLKCON_HSSPICLK_MPLL	(1<<19)
> +#define S3C2416_SCLKCON_PCM0_EXT	(1<<17)
> +#define S3C2416_SCLKCON_DDRCLK		(1<<16)
> +#define S3C2416_SCLKCON_SSMCCLK		(1<<15)
> +#define S3C2416_SCLKCON_HSSPICLK	(1<<14)
> +#define S3C2416_SCLKCON_HSMMCCLK_EXT	(1<<13)
> +#define S3C2416_SCLKCON_HSMMCCLK1_EPLL	(1<<12)
> +#define S3C2416_SCLKCON_CAMCLK		(1<<11)
> +#define S3C2416_SCLKCON_DISPCLK		(1<<10)
> +#define S3C2416_SCLKCON_I2SCLK		(1<<9)
> +#define S3C2416_SCLKCON_UARTCLK		(1<<8)
> +#define S3C2416_SCLKCON_HSMMCCLK0_EPLL	(1<<6)
> +#define S3C2416_SCLKCON_USBHOST		(1<<1)
> +
> +#define S3C2416_PWRCFG_STANDBYWFI_EN		(1<<17)
> +#define S3C2416_PWRCFG_DEEP_STOP		(1<<16)
> +#define S3C2416_PWRCFG_SLEEP_CFG		(1<<15)
> +#define S3C2416_PWRCFG_NFRESET_CFG		(1<<9)
> +#define S3C2416_PWRCFG_RTC_CFG			(1<<8)
> +#define S3C2416_PWRCFG_RTCTICK_CFG		(1<<7)
> +#define S3C2416_PWRCFG_nSW_PHY_OFF_USB		(1<<4)
> +#define S3C2416_PWRCFG_OSC_EN_SLP		(1<<3)
> +#define S3C2416_PWRCFG_OSC_EN_STOP		(1<<2)
> +#define S3C2416_PWRCFG_BATF_CFG_MASK		(3<<0)
> +#define S3C2416_PWRCFG_BATF_CFG_IGNORE1		(0<<0)
> +#define S3C2416_PWRCFG_BATF_CFG_INT		(1<<0)
> +#define S3C2416_PWRCFG_BATF_CFG_IGNORE2		(2<<0)
> +#define S3C2416_PWRCFG_BATF_CFG_SHIFT		(0)
> +
> +
> +#define S3C2416_RSTCON_PWROFF_SLP		(1<<16)
> +#define S3C2416_RSTCON_RSTCNT_MASK		(0xff<<8)
> +#define S3C2416_RSTCON_RSTCNT_SHIFT		(8)
> +#define S3C2416_RSTCON_PWRSETCNT_MASK		(0xff<<0)
> +#define S3C2416_RSTCON_PWRSETCNT_SHIFT		(0)
> +
> +
> +#define S3C2416_RSTSAT_SWRST			(1<<5)
> +#define S3C2416_RSTSAT_DEEPSTOP			(1<<4)
> +#define S3C2416_RSTSAT_SLEEP			(1<<3)
> +#define S3C2416_RSTSAT_WDTRST			(1<<2)
> +#define S3C2416_RSTSAT_EXTRST			(1<<0)
> +
> +
> +#define S3C2416_USB_PHYCTRL_CLK_ON_OFF		(1<<5)
> +#define S3C2416_USB_PHYCTRL_CLK_SEL_MASK	(3<<3)
> +#define S3C2416_USB_PHYCTRL_CLK_SEL_48MHZ	(0<<3)
> +#define S3C2416_USB_PHYCTRL_CLK_SEL_12MHZ	(2<<3)
> +#define S3C2416_USB_PHYCTRL_CLK_SEL_24MHZ	(3<<3)
> +#define S3C2416_USB_PHYCTRL_CLK_SEL_SHIFT	(3)
> +#define S3C2416_USB_PHYCTRL_EXT_CLK		(1<<2)
> +#define S3C2416_USB_PHYCTRL_INT_PLL_SEL		(1<<1)
> +#define S3C2416_USB_PHYCTRL_DOWNSTREAM_PORT	(1<<0)
> +
> +
> +#define S3C2416_USB_PHYPWR_RESERVED_DEFAULTS	(3<<4)
> +#define S3C2416_USB_PHYPWR_FORCE_SUSPEND	(1<<0)
> +
> +#define S3C2416_USB_RSTCON_FUNC_RESET		(1<<2)
> +#define S3C2416_USB_RSTCON_HOST_RESET		(1<<1)
> +#define S3C2416_USB_RSTCON_PHY_RESET		(1<<0)
> +
> +
> +#define S3C2416_USB_CLKCON_DETECT_VBUS		(1<<31)
> +#define S3C2416_USB_CLKCON_FUNC_CLK_EN		(1<<2)
> +#define S3C2416_USB_CLKCON_HOST_CLK_EN		(1<<1)

I think these are broadly compatible with the s3c2443 implementation.

> +#include <asm/div64.h>
> +
> +static inline unsigned int
> +s3c2416_get_mpll(unsigned int pllval, unsigned int baseclk)
> +{
> +	unsigned int mdiv, pdiv, sdiv;
> +	uint64_t fout;
> +
> +	mdiv = pllval >> S3C2416_PLLCON_MDIVSHIFT;
> +	pdiv = pllval >> S3C2416_PLLCON_PDIVSHIFT;
> +	sdiv = pllval >> S3C2416_PLLCON_SDIVSHIFT;
> +
> +	mdiv &= S3C2416_PLLCON_MDIVMASK;
> +	pdiv &= S3C2416_PLLCON_PDIVMASK;
> +	sdiv &= S3C2416_PLLCON_SDIVMASK;
> +
> +	fout = (uint64_t)baseclk * mdiv;
> +	do_div(fout, pdiv << sdiv);
> +
> +	return (unsigned int)fout;
> +}
> +
> +static inline unsigned int
> +s3c2416_get_epll(unsigned int pllval, unsigned int baseclk)
> +{
> +	unsigned int mdiv, pdiv, sdiv;
> +	uint64_t fout;
> +
> +	mdiv = pllval >> S3C2416_EPLLCON_MDIVSHIFT;
> +	pdiv = pllval >> S3C2416_EPLLCON_PDIVSHIFT;
> +	sdiv = pllval >> S3C2416_EPLLCON_SDIVSHIFT;
> +
> +	mdiv &= S3C2416_EPLLCON_MDIVMASK;
> +	pdiv &= S3C2416_EPLLCON_PDIVMASK;
> +	sdiv &= S3C2416_EPLLCON_SDIVMASK;
> +
> +	/* FIXME: we don't see to KDIV (fractional part) */
> +	fout = (uint64_t)baseclk * mdiv;
> +	do_div(fout, pdiv << sdiv);
> +
> +	return (unsigned int)fout;
> +}
> +
> +#endif /*  __ASM_ARM_REGS_S3C2416_CLOCK */

similar to the s3c2443.

> diff --git a/arch/arm/mach-s3c2410/include/mach/regs-s3c2416-mem.h b/arch/arm/mach-s3c2410/include/mach/regs-s3c2416-mem.h
> new file mode 100644
> index 0000000..2f31b74
> --- /dev/null
> +++ b/arch/arm/mach-s3c2410/include/mach/regs-s3c2416-mem.h
> @@ -0,0 +1,30 @@
> +/* arch/arm/mach-s3c2410/include/mach/regs-s3c2416-mem.h
> + *
> + * Copyright (c) 2009 Yauhen Kharuzhy <jekhor@gmail.com>,
> + *	as part of OpenInkpot project
> + * Copyright (c) 2009 Promwad Innovation Company
> + *	Yauhen Kharuzhy <yauhen.kharuzhy@promwad.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * S3C2416 memory register definitions
> +*/
> +
> +#ifndef __ASM_ARM_REGS_S3C2416_MEM
> +#define __ASM_ARM_REGS_S3C2416_MEM
> +
> +#ifndef S3C2416_MEMREG
> +#define S3C2416_MEMREG(x) (S3C24XX_VA_MEMCTRL + (x))
> +#endif
> +
> +#define S3C2416_BANKCFG			S3C2416_MEMREG(0x00)
> +#define S3C2416_BANKCON1		S3C2416_MEMREG(0x04)
> +#define S3C2416_BANKCON2		S3C2416_MEMREG(0x08)
> +#define S3C2416_BANKCON3		S3C2416_MEMREG(0x0C)
> +
> +#define S3C2416_REFRESH			S3C2416_MEMREG(0x10)
> +#define S3C2416_TIMEOUT			S3C2416_MEMREG(0x14)
> +
> +#endif /*  __ASM_ARM_REGS_S3C2416_MEM */
> diff --git a/arch/arm/mach-s3c2410/include/mach/regs-s3c2416.h b/arch/arm/mach-s3c2410/include/mach/regs-s3c2416.h
> new file mode 100644
> index 0000000..e443167
> --- /dev/null
> +++ b/arch/arm/mach-s3c2410/include/mach/regs-s3c2416.h
> @@ -0,0 +1,24 @@
> +/* arch/arm/mach-s3c2410/include/mach/regs-s3c2416.h
> + *
> + * Copyright (c) 2009 Yauhen Kharuzhy <jekhor@gmail.com>,
> + *	as part of OpenInkpot project
> + * Copyright (c) 2009 Promwad Innovation Company
> + *	Yauhen Kharuzhy <yauhen.kharuzhy@promwad.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * S3C2416 specific register definitions
> +*/
> +
> +#ifndef __ASM_ARCH_REGS_S3C2416_H
> +#define __ASM_ARCH_REGS_S3C2416_H "s3c2416"
> +
> +#define S3C2416_SWRST		(S3C24XX_VA_CLKPWR + 0x44)
> +#define S3C2416_SWRST_RESET	(0x533C2416)
> +
> +/* see regs-power.h for the other registers in the power block. */
> +
> +#endif	/* __ASM_ARCH_REGS_S3C2416_H */
> +

think this can be simply added to the relevant .c file.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
