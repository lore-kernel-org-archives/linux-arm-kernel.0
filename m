From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 10 Mar 2010 08:07:49 -0500
Subject: [PATCH 1/4] From 75fe4b02234f6476e72827508f11f1035d7aaf68 Mon Sep
	17 00:00:00 2001 From: Haojian Zhuang <haojian.zhuang@marvell.com>
	Date: Wed,
	10 Mar 2010 06:32:43 -0500 Subject: [PATCH] [ARM] mmp: support ssp in
	pxa168 Support ssp in pxa168. Th
Message-ID: <771cded01003100507r59d9f46m5334a53d81e0b690@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Discard this patch. I'm sorry on it.

Thanks
Haojian

On Wed, Mar 10, 2010 at 8:05 AM, Haojian Zhuang
<haojian.zhuang@gmail.com> wrote:
> From 75fe4b02234f6476e72827508f11f1035d7aaf68 Mon Sep 17 00:00:00 2001
> From: Haojian Zhuang <haojian.zhuang@marvell.com>
> Date: Wed, 10 Mar 2010 06:32:43 -0500
> Subject: [PATCH] [ARM] mmp: support ssp in pxa168
>
> Support ssp in pxa168. The basic function of SSP is same as pxa, but clock
> source and IRQ is changed.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> ---
> ?arch/arm/mach-mmp/include/mach/irqs.h ? ? ?| ? 10 +-
> ?arch/arm/mach-mmp/include/mach/pxa168.h ? ?| ? 21 ++++
> ?arch/arm/mach-mmp/include/mach/regs-apbc.h | ? 10 +-
> ?arch/arm/mach-mmp/include/mach/regs-mpmu.h | ? 48 ++++++++++
> ?arch/arm/mach-mmp/include/mach/regs-ssp.h ?| ?141 ++++++++++++++++++++++++++++
> ?arch/arm/mach-mmp/pxa168.c ? ? ? ? ? ? ? ? | ? 15 +++
> ?arch/arm/plat-pxa/include/plat/ssp.h ? ? ? | ? ?2 +
> ?arch/arm/plat-pxa/ssp.c ? ? ? ? ? ? ? ? ? ?| ? ?1 +
> ?8 files changed, 238 insertions(+), 10 deletions(-)
> ?create mode 100644 arch/arm/mach-mmp/include/mach/regs-mpmu.h
> ?create mode 100644 arch/arm/mach-mmp/include/mach/regs-ssp.h
>
> diff --git a/arch/arm/mach-mmp/include/mach/irqs.h
> b/arch/arm/mach-mmp/include/mach/irqs.h
> index 0270119..b379cde 100644
> --- a/arch/arm/mach-mmp/include/mach/irqs.h
> +++ b/arch/arm/mach-mmp/include/mach/irqs.h
> @@ -5,10 +5,10 @@
> ?* Interrupt numbers for PXA168
> ?*/
> ?#define IRQ_PXA168_NONE ? ? ? ? ? ? ? ? ? ? ? ?(-1)
> -#define IRQ_PXA168_SSP3 ? ? ? ? ? ? ? ? ? ? ? ?0
> -#define IRQ_PXA168_SSP2 ? ? ? ? ? ? ? ? ? ? ? ?1
> -#define IRQ_PXA168_SSP1 ? ? ? ? ? ? ? ? ? ? ? ?2
> -#define IRQ_PXA168_SSP0 ? ? ? ? ? ? ? ? ? ? ? ?3
> +#define IRQ_PXA168_SSP4 ? ? ? ? ? ? ? ? ? ? ? ?0
> +#define IRQ_PXA168_SSP3 ? ? ? ? ? ? ? ? ? ? ? ?1
> +#define IRQ_PXA168_SSP2 ? ? ? ? ? ? ? ? ? ? ? ?2
> +#define IRQ_PXA168_SSP1 ? ? ? ? ? ? ? ? ? ? ? ?3
> ?#define IRQ_PXA168_PMIC_INT ? ? ? ? ? ?4
> ?#define IRQ_PXA168_RTC_INT ? ? ? ? ? ? 5
> ?#define IRQ_PXA168_RTC_ALARM ? ? ? ? ? 6
> @@ -20,7 +20,7 @@
> ?#define IRQ_PXA168_TIMER2 ? ? ? ? ? ? ?14
> ?#define IRQ_PXA168_TIMER3 ? ? ? ? ? ? ?15
> ?#define IRQ_PXA168_CMU ? ? ? ? ? ? ? ? 16
> -#define IRQ_PXA168_SSP4 ? ? ? ? ? ? ? ? ? ? ? ?17
> +#define IRQ_PXA168_SSP5 ? ? ? ? ? ? ? ? ? ? ? ?17
> ?#define IRQ_PXA168_MSP_WAKEUP ? ? ? ? ?19
> ?#define IRQ_PXA168_CF_WAKEUP ? ? ? ? ? 20
> ?#define IRQ_PXA168_XD_WAKEUP ? ? ? ? ? 21
> diff --git a/arch/arm/mach-mmp/include/mach/pxa168.h
> b/arch/arm/mach-mmp/include/mach/pxa168.h
> index 3ad612c..3b2bd5d 100644
> --- a/arch/arm/mach-mmp/include/mach/pxa168.h
> +++ b/arch/arm/mach-mmp/include/mach/pxa168.h
> @@ -14,6 +14,11 @@ extern struct pxa_device_desc pxa168_device_pwm1;
> ?extern struct pxa_device_desc pxa168_device_pwm2;
> ?extern struct pxa_device_desc pxa168_device_pwm3;
> ?extern struct pxa_device_desc pxa168_device_pwm4;
> +extern struct pxa_device_desc pxa168_device_ssp1;
> +extern struct pxa_device_desc pxa168_device_ssp2;
> +extern struct pxa_device_desc pxa168_device_ssp3;
> +extern struct pxa_device_desc pxa168_device_ssp4;
> +extern struct pxa_device_desc pxa168_device_ssp5;
> ?extern struct pxa_device_desc pxa168_device_nand;
>
> ?static inline int pxa168_add_uart(int id)
> @@ -67,6 +72,22 @@ static inline int pxa168_add_pwm(int id)
> ? ? ? ?return pxa_register_device(d, NULL, 0);
> ?}
>
> +static inline int pxa168_add_ssp(int id)
> +{
> + ? ? ? struct pxa_device_desc *d = NULL;
> +
> + ? ? ? switch (id) {
> + ? ? ? case 1: d = &pxa168_device_ssp1; break;
> + ? ? ? case 2: d = &pxa168_device_ssp2; break;
> + ? ? ? case 3: d = &pxa168_device_ssp3; break;
> + ? ? ? case 4: d = &pxa168_device_ssp4; break;
> + ? ? ? case 5: d = &pxa168_device_ssp5; break;
> + ? ? ? default:
> + ? ? ? ? ? ? ? return -EINVAL;
> + ? ? ? }
> + ? ? ? return pxa_register_device(d, NULL, 0);
> +}
> +
> ?static inline int pxa168_add_nand(struct pxa3xx_nand_platform_data *info)
> ?{
> ? ? ? ?return pxa_register_device(&pxa168_device_nand, info, sizeof(*info));
> diff --git a/arch/arm/mach-mmp/include/mach/regs-apbc.h
> b/arch/arm/mach-mmp/include/mach/regs-apbc.h
> index 712af03..1a96585 100644
> --- a/arch/arm/mach-mmp/include/mach/regs-apbc.h
> +++ b/arch/arm/mach-mmp/include/mach/regs-apbc.h
> @@ -26,8 +26,6 @@
> ?#define APBC_PXA168_PWM2 ? ? ? APBC_REG(0x010)
> ?#define APBC_PXA168_PWM3 ? ? ? APBC_REG(0x014)
> ?#define APBC_PXA168_PWM4 ? ? ? APBC_REG(0x018)
> -#define APBC_PXA168_SSP1 ? ? ? APBC_REG(0x01c)
> -#define APBC_PXA168_SSP2 ? ? ? APBC_REG(0x020)
> ?#define APBC_PXA168_RTC ? ? ? ? ? ? ? ?APBC_REG(0x028)
> ?#define APBC_PXA168_TWSI0 ? ? ?APBC_REG(0x02c)
> ?#define APBC_PXA168_KPC ? ? ? ? ? ? ? ?APBC_REG(0x030)
> @@ -35,14 +33,16 @@
> ?#define APBC_PXA168_AIB ? ? ? ? ? ? ? ?APBC_REG(0x03c)
> ?#define APBC_PXA168_SW_JTAG ? ?APBC_REG(0x040)
> ?#define APBC_PXA168_ONEWIRE ? ?APBC_REG(0x048)
> -#define APBC_PXA168_SSP3 ? ? ? APBC_REG(0x04c)
> ?#define APBC_PXA168_ASFAR ? ? ?APBC_REG(0x050)
> ?#define APBC_PXA168_ASSAR ? ? ?APBC_REG(0x054)
> -#define APBC_PXA168_SSP4 ? ? ? APBC_REG(0x058)
> -#define APBC_PXA168_SSP5 ? ? ? APBC_REG(0x05c)
> ?#define APBC_PXA168_TWSI1 ? ? ?APBC_REG(0x06c)
> ?#define APBC_PXA168_UART3 ? ? ?APBC_REG(0x070)
> ?#define APBC_PXA168_AC97 ? ? ? APBC_REG(0x084)
> +#define APBC_PXA168_SSP1 ? ? ? APBC_REG(0x81c)
> +#define APBC_PXA168_SSP2 ? ? ? APBC_REG(0x820)
> +#define APBC_PXA168_SSP3 ? ? ? APBC_REG(0x84c)
> +#define APBC_PXA168_SSP4 ? ? ? APBC_REG(0x858)
> +#define APBC_PXA168_SSP5 ? ? ? APBC_REG(0x85c)
>
> ?/*
> ?* APB Clock register offsets for PXA910
> diff --git a/arch/arm/mach-mmp/include/mach/regs-mpmu.h
> b/arch/arm/mach-mmp/include/mach/regs-mpmu.h
> new file mode 100644
> index 0000000..0d57236
> --- /dev/null
> +++ b/arch/arm/mach-mmp/include/mach/regs-mpmu.h
> @@ -0,0 +1,48 @@
> +/*
> + * linux/arch/arm/mach-mmp/include/mach/regs-mpmu.h
> + *
> + * ? Main Power Management Unit
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef __ASM_MACH_REGS_MPMU_H
> +#define __ASM_MACH_REGS_MPMU_H
> +
> +#include <mach/addr-map.h>
> +
> +#define MPMU_VIRT_BASE (APB_VIRT_BASE + 0x50000)
> +#define MPMU_REG(off) ?(MPMU_VIRT_BASE + (off))
> +
> +#define MPMU_CPCR ? ? ?MPMU_REG(0x0000)
> +#define MPMU_FCCR ? ? ?MPMU_REG(0x0008)
> +#define MPMU_POCR ? ? ?MPMU_REG(0x000c)
> +#define MPMU_POSR ? ? ?MPMU_REG(0x0010)
> +#define MPMU_SUCCR ? ? MPMU_REG(0x0014)
> +#define MPMU_VRCR ? ? ?MPMU_REG(0x0018)
> +#define MPMU_OHCR ? ? ?MPMU_REG(0x001c)
> +#define MPMU_GPCR ? ? ?MPMU_REG(0x0030)
> +#define MPMU_PLL2CR ? ?MPMU_REG(0x0034)
> +#define MPMU_SCCR ? ? ?MPMU_REG(0x0038)
> +#define MPMU_CWUCRM ? ?MPMU_REG(0x004c)
> +#define MPMU_PLL1_REG1 MPMU_REG(0x0050)
> +#define MPMU_PLL1_REG2 MPMU_REG(0x0054)
> +#define MPMU_PLL1_SSC ?MPMU_REG(0x0058)
> +#define MPMU_PLL2_REG1 MPMU_REG(0x0060)
> +#define MPMU_PLL2_REG2 MPMU_REG(0x0064)
> +#define MPMU_PLL2_SSC ?MPMU_REG(0x0068)
> +#define MPMU_TS ? ? ? ? ? ? ? ?MPMU_REG(0x0080)
> +#define MPMU_WDTPCR ? ?MPMU_REG(0x0200)
> +#define MPMU_APCR ? ? ?MPMU_REG(0x1000)
> +#define MPMU_APSR ? ? ?MPMU_REG(0x1004)
> +#define MPMU_APRR ? ? ?MPMU_REG(0x1020)
> +#define MPMU_ACGR ? ? ?MPMU_REG(0x1024)
> +#define MPMU_ARSR ? ? ?MPMU_REG(0x1028)
> +#define MPMU_AWUCRS ? ?MPMU_REG(0x1048)
> +#define MPMU_AWUCRM ? ?MPMU_REG(0x104c)
> +#define MPMU_ASYSDR ? ?MPMU_REG(0x1050)
> +#define MPMU_ASSPDR ? ?MPMU_REG(0x1054)
> +
> +#endif /* __ASM_MACH_REGS_APMU_H */
> diff --git a/arch/arm/mach-mmp/include/mach/regs-ssp.h
> b/arch/arm/mach-mmp/include/mach/regs-ssp.h
> new file mode 100644
> index 0000000..7e16eeb
> --- /dev/null
> +++ b/arch/arm/mach-mmp/include/mach/regs-ssp.h
> @@ -0,0 +1,141 @@
> +#ifndef __ASM_ARCH_REGS_SSP_H
> +#define __ASM_ARCH_REGS_SSP_H
> +
> +/*
> + * SSP Serial Port Registers
> + */
> +
> +#define SSCR0 ? ? ? ? ?(0x00) ?/* SSP Control Register 0 */
> +#define SSCR1 ? ? ? ? ?(0x04) ?/* SSP Control Register 1 */
> +#define SSSR ? ? ? ? ? (0x08) ?/* SSP Status Register */
> +#define SSITR ? ? ? ? ?(0x0C) ?/* SSP Interrupt Test Register */
> +#define SSDR ? ? ? ? ? (0x10) ?/* SSP Data Write/Data Read Register */
> +
> +#define SSTO ? ? ? ? ? (0x28) ?/* SSP Time Out Register */
> +#define SSPSP ? ? ? ? ?(0x2C) ?/* SSP Programmable Serial Protocol */
> +#define SSTSA ? ? ? ? ?(0x30) ?/* SSP Tx Timeslot Active */
> +#define SSRSA ? ? ? ? ?(0x34) ?/* SSP Rx Timeslot Active */
> +#define SSTSS ? ? ? ? ?(0x38) ?/* SSP Timeslot Status */
> +
> +#if defined(CONFIG_CPU_PXA910)
> +#define SSACD ? ? ? ? ?(0x3C) ?/* SSP Audio Clock Divider */
> +#define SSACDD ? ? ? ? (0x40) ?/* SSP Audio Clock Dither Divider */
> +#endif
> +
> +/* Common bits first */
> +#define SSCR0_DSS_MASK (0x0000000f) ? ?/* Data Size Select (mask) */
> +#define SSCR0_DSS(x) ?((x) - 1) ? ? ? ?/* Data Size Select [4..16] */
> +#define SSCR0_FRF ? ? ?(0x3 << 4) ? ? ?/* FRame Format (mask) */
> +#define SSCR0_Motorola (0x0 << 4) ? ? ?/* Motorola's Serial Peripheral
> Interface (SPI) */
> +#define SSCR0_TI ? ? ? (0x1 << 4) ? ? ?/* Texas Instruments' Synchronous Serial
> Protocol (SSP) */
> +#define SSCR0_National (0x2 << 4) ? ? ?/* National Microwire */
> +#define SSCR0_PSP ? ? ?(0x3 << 4) ? ? ?/* Programmable Serial Protocol (PSP) */
> +#define SSCR0_ECS ? ? ?(1 << 6) ? ? ? ?/* External clock select */
> +#define SSCR0_SSE ? ? ?(1 << 7) ? ? ? ?/* Synchronous Serial Port Enable */
> +
> +#define SSCR0_SCR ? ? ?(0xfff << 8) ? ?/* Serial Clock Rate (mask) */
> +#define SSCR0_SerClkDiv(x) (((x) - 1) << 8) /* Divisor [1..4096] */
> +
> +#define SSCR0_EDSS ? ? (1 << 20) ? ? ? /* Extended data size select */
> +#define SSCR0_NCS ? ? ?(1 << 21) ? ? ? /* Network clock select */
> +#define SSCR0_RIM ? ? ?(1 << 22) ? ? ? /* Receive FIFO overrrun interrupt mask */
> +#define SSCR0_TIM ? ? ?(1 << 23) ? ? ? /* Transmit FIFO underrun interrupt mask */
> +#define SSCR0_FRDC ? ? (0x7 << 24) ? ? /* Frame rate divider control (mask) */
> +#define SSCR0_SlotsPerFrm(x) (((x) - 1) << 24) /* Time slots per
> frame [1..8] */
> +#define SSCR0_FPCKE ? ?(1 << 29) ? ? ? /* FIFO packing enable */
> +#define SSCR0_ACS ? ? ?(1 << 30) ? ? ? /* Audio clock select */
> +#define SSCR0_MOD ? ? ?(1 << 31) ? ? ? /* Mode (normal or network) */
> +
> +#if defined(CONFIG_CPU_PXA168) || defined(CONFIG_CPU_PXA910)
> +#define SSCR0_MODE_52M (1 << 27) ? ? ? /* 52Mbps Mode */
> +#endif
> +
> +#define SSCR1_RIE ? ? ?(1 << 0) ? ? ? ?/* Receive FIFO Interrupt Enable */
> +#define SSCR1_TIE ? ? ?(1 << 1) ? ? ? ?/* Transmit FIFO Interrupt Enable */
> +#define SSCR1_LBM ? ? ?(1 << 2) ? ? ? ?/* Loop-Back Mode */
> +#define SSCR1_SPO ? ? ?(1 << 3) ? ? ? ?/* Motorola SPI SSPSCLK polarity setting */
> +#define SSCR1_SPH ? ? ?(1 << 4) ? ? ? ?/* Motorola SPI SSPSCLK phase setting */
> +#define SSCR1_TFT_MASK (0xf << 6) ? ? ?/* Transmit FIFO Threshold (mask) */
> +#define SSCR1_TFT(x) ? (((x) - 1) << 6) /* level [1..16] */
> +#define SSCR1_RFT_MASK (0xf << 10) ? ? /* Receive FIFO Threshold (mask) */
> +#define SSCR1_RFT(x) ? (((x) - 1) << 10) /* level [1..16] */
> +#define SSCR1_EFWR ? ? (1 << 14) ? ? ? /* Enable FIFO Write/read */
> +#define SSCR1_STRF ? ? (1 << 15) ? ? ? /* Select FIFO for EFWR */
> +#define SSCR1_IFS ? ? ?(1 << 16) ? ? ? /* Invert Frame Signal */
> +#define SSCR1_PINTE ? ?(1 << 18) ? ? ? /* Peripheral Trailing Byte Interrupt Enable */
> +#define SSCR1_TINTE ? ?(1 << 19) ? ? ? /* Receiver Timeout Interrupt Enable */
> +#define SSCR1_RSRE ? ? (1 << 20) ? ? ? /* Receive Service Request Enable */
> +#define SSCR1_TSRE ? ? (1 << 21) ? ? ? /* Transmit Service Request Enable */
> +#define SSCR1_TRAIL ? ?(1 << 22) ? ? ? /* Trailing Byte */
> +#define SSCR1_RWOT ? ? (1 << 23) ? ? ? /* Receive Without Transmit */
> +#define SSCR1_SFRMDIR ?(1 << 24) ? ? ? /* SSP Frame (SSPSFRMx) Direction */
> +#define SSCR1_SCLKDIR ?(1 << 25) ? ? ? /* SSP Serial Bit Rate Clock
> (SSPSCLKx) Direction */
> +#define SSCR1_ECRB ? ? (1 << 26) ? ? ? /* Enable Clock Request B */
> +#define SSCR1_ECRA ? ? (1 << 27) ? ? ? /* Enable Clock Request A */
> +#define SSCR1_SCFR ? ? (1 << 28) ? ? ? /* Slave Clock Free Running */
> +#define SSCR1_EBCEI ? ?(1 << 29) ? ? ? /* Enable Bit Count Error Interrupt */
> +#define SSCR1_TTE ? ? ?(1 << 30) ? ? ? /* TxD Three-state Enable */
> +#define SSCR1_TTELP ? ?(1 << 31) ? ? ? /* TxD Three-state Enable On Last Phase */
> +
> +#if defined(CONFIG_CPU_PXA910)
> +#define SSCR1_MWDS ? ? (1 << 5) ? ? ? ?/* Microwire Transmit Data Size */
> +#endif
> +
> +#define SSSR_TNF ? ? ? (1 << 2) ? ? ? ?/* Transmit FIFO Not Full */
> +#define SSSR_RNE ? ? ? (1 << 3) ? ? ? ?/* Receive FIFO Not Empty */
> +#define SSSR_BSY ? ? ? (1 << 4) ? ? ? ?/* SSP Busy */
> +#define SSSR_TFS ? ? ? (1 << 5) ? ? ? ?/* Transmit FIFO Service Request */
> +#define SSSR_RFS ? ? ? (1 << 6) ? ? ? ?/* Receive FIFO Service Request */
> +#define SSSR_ROR ? ? ? (1 << 7) ? ? ? ?/* Receive FIFO Overrun */
> +#define SSSR_TFL_MASK ?(0xf << 8) ? ? ?/* Transmit FIFO Level (mask) */
> +#define SSSR_TFL(x) ? ?((x) << 8)
> +#define SSSR_RFL_MASK ?(0xf << 12) ? ? /* Receive FIFO Level */
> +#define SSSR_RFL(x) ? ?((x) << 12)
> +#define SSSR_PINT ? ? ?(1 << 18) ? ? ? /* Peripheral Trailing Byte Interrupt */
> +#define SSSR_TINT ? ? ?(1 << 19) ? ? ? /* Receiver Timeout Interrupt */
> +#define SSSR_EOC ? ? ? (1 << 20) ? ? ? /* End of Chain */
> +#define SSSR_TUR ? ? ? (1 << 21) ? ? ? /* Transmit FIFO Underrun */
> +#define SSSR_CSS ? ? ? (1 << 22) ? ? ? /* Clock Synchronisation Status */
> +#define SSSR_BCE ? ? ? (1 << 23) ? ? ? /* Bit Count Error */
> +#define SSSR_TX_OSS ? ?(1 << 30) ? ? ? /* Tx FIFO Odd Sample Status */
> +#define SSSR_OSS ? ? ? (1 << 31) ? ? ? /* Odd Sample Status */
> +
> +#define SSITR_TTFS ? ? (1 << 5) ? ? ? ?/* Test Tx FIFO Service Request */
> +#define SSITR_TRFS ? ? (1 << 6) ? ? ? ?/* Test Rx FIFO Service Request */
> +#define SSITR_TROR ? ? (1 << 7) ? ? ? ?/* Test Rx FIFO Overrun */
> +
> +#define SSPSP_SCMODE_MASK ? ? ?(0x3) ? ? ? ? ? /* Serial Bit Rate Clock Mode */
> +#define SSPSP_SCMODE(x) ? ? ? ? ? ? ? ?((x) << 0)
> +#define SSPSP_SFRMP ? ? ? ? ? ?(1 << 2) ? ? ? ?/* Serial Frame Polarity */
> +#define SSPSP_ETDS ? ? ? ? ? ? (1 << 3) ? ? ? ?/* End of Transfer data State */
> +#define SSPSP_STRTDLY_MASK ? ? (0x7 << 4) ? ? ?/* Start Delay */
> +#define SSPSP_STRTDLY(x) ? ? ? ((x) << 4)
> +#define SSPSP_DMYSTRT_MASK ? ? (0x3 << 7) ? ? ?/* Dummy Start */
> +#define SSPSP_DMYSTRT(x) ? ? ? ((x) << 7)
> +#define SSPSP_SFRMDLY_MASK ? ? (0x7f << 9) ? ? /* Serial Frame Delay */
> +#define SSPSP_SFRMDLY(x) ? ? ? ((x) << 9)
> +#define SSPSP_SFRMWDTH_MASK ? ?(0x3f << 16) ? ?/* Serial Frame Width */
> +#define SSPSP_SFRMWDTH(x) ? ? ?((x) << 16)
> +#define SSPSP_DMYSTOP_MASK ? ? (0x3 << 23) ? ? /* Dummy Stop */
> +#define SSPSP_DMYSTOP(x) ? ? ? ((x) << 23)
> +#define SSPSP_FSRT ? ? ? ? ? ? (1 << 25) ? ? ? /* Frame Sync Relative Timing */
> +#define SSPSP_EDMYSTRT_MASK ? ?(0x3 << 26) ? ? /* Extended Dummy Start */
> +#define SSPSP_EDMYSTRT(x) ? ? ?((x) << 26)
> +#define SSPSP_EDMYSTOP_MASK ? ?(0x7 << 28) ? ? /* Extended Dummy Stop */
> +#define SSPSP_EDMYSTOP(x) ? ? ?((x) << 28)
> +#define SSPSP_TIMING_MASK ? ? ?(SSPSP_STRTDLY_MASK | SSPSP_DMYSTRT_MASK \
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? | SSPSP_SFRMDLY_MASK | SSPSP_SFRMWDTH_MASK \
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? | SSPSP_DMYSTOP_MASK | SSPSP_EDMYSTRT_MASK \
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? | SSPSP_EDMYSTOP_MASK | SSPSP_FSRT)
> +
> +
> +#if defined(CONFIG_CPU_PXA910)
> +#define SSACD_SCDB ? ? ? ? ? ? (1 << 3) ? ? ? ?/* SSPSYSCLK Divider Bypass */
> +#define SSACD_ACPS(x) ? ? ? ? ?((x) << 4) ? ? ?/* Audio clock PLL select */
> +#define SSACD_ACDS(x) ? ? ? ? ?((x) << 0) ? ? ?/* Audio clock divider select */
> +#define SSACD_SCDX8 ? ? ? ? ? ?(1 << 7) ? ? ? ?/* SYSCLK division ratio select */
> +#endif
> +
> +
> +#endif /* __ASM_ARCH_REGS_SSP_H */
> +
> diff --git a/arch/arm/mach-mmp/pxa168.c b/arch/arm/mach-mmp/pxa168.c
> index 37dbdde..5f1a4dd 100644
> --- a/arch/arm/mach-mmp/pxa168.c
> +++ b/arch/arm/mach-mmp/pxa168.c
> @@ -72,6 +72,11 @@ static APBC_CLK(pwm1, PXA168_PWM1, 1, 13000000);
> ?static APBC_CLK(pwm2, PXA168_PWM2, 1, 13000000);
> ?static APBC_CLK(pwm3, PXA168_PWM3, 1, 13000000);
> ?static APBC_CLK(pwm4, PXA168_PWM4, 1, 13000000);
> +static APBC_CLK(ssp1, PXA168_SSP1, 4, 0);
> +static APBC_CLK(ssp2, PXA168_SSP2, 4, 0);
> +static APBC_CLK(ssp3, PXA168_SSP3, 4, 0);
> +static APBC_CLK(ssp4, PXA168_SSP4, 4, 0);
> +static APBC_CLK(ssp5, PXA168_SSP5, 4, 0);
>
> ?static APMU_CLK(nand, NAND, 0x01db, 208000000);
>
> @@ -85,6 +90,11 @@ static struct clk_lookup pxa168_clkregs[] = {
> ? ? ? ?INIT_CLKREG(&clk_pwm2, "pxa168-pwm.1", NULL),
> ? ? ? ?INIT_CLKREG(&clk_pwm3, "pxa168-pwm.2", NULL),
> ? ? ? ?INIT_CLKREG(&clk_pwm4, "pxa168-pwm.3", NULL),
> + ? ? ? INIT_CLKREG(&clk_ssp1, "pxa168-ssp.0", NULL),
> + ? ? ? INIT_CLKREG(&clk_ssp2, "pxa168-ssp.1", NULL),
> + ? ? ? INIT_CLKREG(&clk_ssp3, "pxa168-ssp.2", NULL),
> + ? ? ? INIT_CLKREG(&clk_ssp4, "pxa168-ssp.3", NULL),
> + ? ? ? INIT_CLKREG(&clk_ssp5, "pxa168-ssp.4", NULL),
> ? ? ? ?INIT_CLKREG(&clk_nand, "pxa3xx-nand", NULL),
> ?};
>
> @@ -132,3 +142,8 @@ PXA168_DEVICE(pwm2, "pxa168-pwm", 1, NONE,
> 0xd401a400, 0x10);
> ?PXA168_DEVICE(pwm3, "pxa168-pwm", 2, NONE, 0xd401a800, 0x10);
> ?PXA168_DEVICE(pwm4, "pxa168-pwm", 3, NONE, 0xd401ac00, 0x10);
> ?PXA168_DEVICE(nand, "pxa3xx-nand", -1, NAND, 0xd4283000, 0x80, 97, 99);
> +PXA168_DEVICE(ssp1, "pxa168-ssp", 0, SSP1, 0xd401b000, 0x40, 52, 53);
> +PXA168_DEVICE(ssp2, "pxa168-ssp", 1, SSP2, 0xd401c000, 0x40, 54, 55);
> +PXA168_DEVICE(ssp3, "pxa168-ssp", 2, SSP3, 0xd401f000, 0x40, 56, 57);
> +PXA168_DEVICE(ssp4, "pxa168-ssp", 3, SSP4, 0xd4020000, 0x40, 58, 59);
> +PXA168_DEVICE(ssp5, "pxa168-ssp", 4, SSP5, 0xd4021000, 0x40, 60, 61);
> diff --git a/arch/arm/plat-pxa/include/plat/ssp.h
> b/arch/arm/plat-pxa/include/plat/ssp.h
> index fc83ba7..06cffae 100644
> --- a/arch/arm/plat-pxa/include/plat/ssp.h
> +++ b/arch/arm/plat-pxa/include/plat/ssp.h
> @@ -14,6 +14,7 @@
> ?* ? ? ? PXA26x ? ? SSP, NSSP, ASSP
> ?* ? ? ? PXA27x ? ? SSP1, SSP2, SSP3
> ?* ? ? ? PXA3xx ? ? SSP1, SSP2, SSP3, SSP4
> + * ? ? ? PXA168 ? ? SSP1, SSP2, SSP3, SSP4, SSP5
> ?*/
>
> ?#ifndef __ASM_PLAT_SSP_H
> @@ -27,6 +28,7 @@ enum pxa_ssp_type {
> ? ? ? ?PXA25x_SSP, ?/* pxa 210, 250, 255, 26x */
> ? ? ? ?PXA25x_NSSP, /* pxa 255, 26x (including ASSP) */
> ? ? ? ?PXA27x_SSP,
> + ? ? ? PXA168_SSP,
> ?};
>
> ?struct ssp_device {
> diff --git a/arch/arm/plat-pxa/ssp.c b/arch/arm/plat-pxa/ssp.c
> index d4a7673..4dc2ee6 100644
> --- a/arch/arm/plat-pxa/ssp.c
> +++ b/arch/arm/plat-pxa/ssp.c
> @@ -465,6 +465,7 @@ static const struct platform_device_id ssp_id_table[] = {
> ? ? ? ?{ "pxa25x-ssp", ? ? ? ? PXA25x_SSP },
> ? ? ? ?{ "pxa25x-nssp", ? ? ? ?PXA25x_NSSP },
> ? ? ? ?{ "pxa27x-ssp", ? ? ? ? PXA27x_SSP },
> + ? ? ? { "pxa168-ssp", ? ? ? ? PXA168_SSP },
> ? ? ? ?{ },
> ?};
>
> --
> 1.5.6.5
>
