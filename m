From: maz@misterjones.org (Marc Zyngier)
Date: Fri, 18 Dec 2009 14:53:47 +0100
Subject: [PATCH 3/7] ARM: S5P6440: Add IRQ support
In-Reply-To: <1261127996-30253-5-git-send-email-kgene.kim@samsung.com>
References: <1261127996-30253-1-git-send-email-kgene.kim@samsung.com>
	<1261127996-30253-2-git-send-email-kgene.kim@samsung.com>
	<1261127996-30253-3-git-send-email-kgene.kim@samsung.com>
	<1261127996-30253-4-git-send-email-kgene.kim@samsung.com>
	<1261127996-30253-5-git-send-email-kgene.kim@samsung.com>
Message-ID: <20091218145347.4ad08b97@life-in-the-fast-lane>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 18 Dec 2009 18:19:56 +0900
Kukjin Kim <kgene.kim@samsung.com> wrote:

> This patch adds IRQ support for S5P6440 CPU.
> 
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> Signed-off-by: Adityapratap Sharma <aditya.ps@samsung.com>
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> Signed-off-by: Atul Dahiya <atul.dahiya@samsung.com>
> ---
>  arch/arm/mach-s5p6440/include/mach/irqs.h     |  111 +++++++++++
>  arch/arm/mach-s5p6440/include/mach/regs-irq.h |   23 +++
>  arch/arm/plat-s5p/include/plat/irqs.h         |   80 ++++++++
>  arch/arm/plat-s5p/irq.c                       |  251 +++++++++++++++++++++++++
>  4 files changed, 465 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-s5p6440/include/mach/irqs.h
>  create mode 100644 arch/arm/mach-s5p6440/include/mach/regs-irq.h
>  create mode 100644 arch/arm/plat-s5p/include/plat/irqs.h
>  create mode 100644 arch/arm/plat-s5p/irq.c
> 
> diff --git a/arch/arm/mach-s5p6440/include/mach/irqs.h b/arch/arm/mach-s5p6440/include/mach/irqs.h
> new file mode 100644
> index 0000000..dd1b50b
> --- /dev/null
> +++ b/arch/arm/mach-s5p6440/include/mach/irqs.h
> @@ -0,0 +1,111 @@
> +/* linux/arch/arm/mach-s5p6440/include/mach/irqs.h
> + *
> + * Copyright 2009 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com/
> + *
> + * S5P6440 - IRQ definitions
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#ifndef __ASM_ARCH_S5P_IRQS_H
> +#define __ASM_ARCH_S5P_IRQS_H __FILE__
> +
> +#include <plat/irqs.h>
> +
> +/* VIC0 */
> +
> +#define IRQ_EINT0_3		S5P_IRQ_VIC0(0)
> +#define IRQ_EINT4_11		S5P_IRQ_VIC0(1)
> +#define IRQ_RTC_TIC		S5P_IRQ_VIC0(2)
> +#define IRQ_IIC1		S5P_IRQ_VIC0(5)
> +#define IRQ_I2SV40		S5P_IRQ_VIC0(6)
> +#define IRQ_GPS			S5P_IRQ_VIC0(7)
> +#define IRQ_POST0		S5P_IRQ_VIC0(9)
> +#define IRQ_2D			S5P_IRQ_VIC0(11)
> +#define IRQ_TIMER0_VIC		S5P_IRQ_VIC0(23)
> +#define IRQ_TIMER1_VIC		S5P_IRQ_VIC0(24)
> +#define IRQ_TIMER2_VIC		S5P_IRQ_VIC0(25)
> +#define IRQ_WDT			S5P_IRQ_VIC0(26)
> +#define IRQ_TIMER3_VIC		S5P_IRQ_VIC0(27)
> +#define IRQ_TIMER4_VIC		S5P_IRQ_VIC0(28)
> +#define IRQ_DISPCON0		S5P_IRQ_VIC0(29)
> +#define IRQ_DISPCON1		S5P_IRQ_VIC0(30)
> +#define IRQ_DISPCON2		S5P_IRQ_VIC0(31)
> +
> +/* VIC1 */
> +
> +#define IRQ_EINT12_15		S5P_IRQ_VIC1(0)
> +#define IRQ_PCM0		S5P_IRQ_VIC1(2)
> +#define IRQ_UART0		S5P_IRQ_VIC1(5)
> +#define IRQ_UART1		S5P_IRQ_VIC1(6)
> +#define IRQ_UART2		S5P_IRQ_VIC1(7)
> +#define IRQ_UART3		S5P_IRQ_VIC1(8)
> +#define IRQ_DMA0		S5P_IRQ_VIC1(9)
> +#define IRQ_NFC			S5P_IRQ_VIC1(13)
> +#define IRQ_SPI0		S5P_IRQ_VIC1(16)
> +#define IRQ_SPI1		S5P_IRQ_VIC1(17)
> +#define IRQ_IIC			S5P_IRQ_VIC1(18)
> +#define IRQ_DISPCON3		S5P_IRQ_VIC1(19)
> +#define IRQ_FIMGVG		S5P_IRQ_VIC1(20)
> +#define IRQ_EINTG1_G9		S5P_IRQ_VIC1(21)

The name of this entry is badly chosen, as 6440 only has groups 1, 2,
5, 6, and 8. What about IRQ_EINT_GROUPS? Or anything that would
represent the actual function...

> +#define IRQ_PMUIRQ		S5P_IRQ_VIC1(23)
> +#define IRQ_HSMMC0		S5P_IRQ_VIC1(24)
> +#define IRQ_HSMMC1		S5P_IRQ_VIC1(25)
> +#define IRQ_HSMMC2		IRQ_SPI1	/* shared with SPI1 */
> +#define IRQ_OTG			S5P_IRQ_VIC1(26)
> +#define IRQ_DSI			S5P_IRQ_VIC1(27)
> +#define IRQ_RTC_ALARM		S5P_IRQ_VIC1(28)
> +#define IRQ_TSI			S5P_IRQ_VIC1(29)
> +#define IRQ_PENDN		S5P_IRQ_VIC1(30)
> +#define IRQ_TC			IRQ_PENDN
> +#define IRQ_ADC			S5P_IRQ_VIC1(31)
> +
> +/*
> + * Since the IRQ_EINT(x) are a linear mapping on s5p6440 we just defined
> + * them as an IRQ_EINT(x) macro from S5P_IRQ_EINT_BASE which we place
> + * after the pair of VICs.
> + */
> +
> +#define S5P_IRQ_EINT_BASE	(S5P_IRQ_VIC1(31) + 6)
> +
> +#define S5P_EINT(x)		((x) + S5P_IRQ_EINT_BASE)
> +#define IRQ_EINT(x)		S5P_EINT(x)
> +
> +/*
> + * Next the external interrupt groups. These are similar to the IRQ_EINT(x)
> + * that they are sourced from the GPIO pins but with a different scheme for
> + * priority and source indication.
> + *
> + * The IRQ_EINT(x) can be thought of as 'group 0' of the available GPIO
> + * interrupts, but for historical reasons they are kept apart from these
> + * next interrupts.
> + *
> + * Use IRQ_EINT_GROUP(group, offset) to get the number for use in the
> + * machine specific support files.
> + */
> +
> +/* Actually, #6 and #7 are missing in the EINT_GROUP1 */
> +#define IRQ_EINT_GROUP1_NR	(15)
> +#define IRQ_EINT_GROUP2_NR	(8)
> +#define IRQ_EINT_GROUP5_NR	(7)
> +#define IRQ_EINT_GROUP6_NR	(10)
> +/* Actually, #0, #1 and #2 are missing in the EINT_GROUP8 */
> +#define IRQ_EINT_GROUP8_NR	(11)

Group 8 has interrupts numbered from 3 to 11, so this should read 12.

> +
> +#define IRQ_EINT_GROUP_BASE	S5P_EINT(16)
> +#define IRQ_EINT_GROUP1_BASE	(IRQ_EINT_GROUP_BASE + 0)
> +#define IRQ_EINT_GROUP2_BASE	(IRQ_EINT_GROUP1_BASE + IRQ_EINT_GROUP1_NR)
> +#define IRQ_EINT_GROUP5_BASE	(IRQ_EINT_GROUP2_BASE + IRQ_EINT_GROUP2_NR)
> +#define IRQ_EINT_GROUP6_BASE	(IRQ_EINT_GROUP5_BASE + IRQ_EINT_GROUP5_NR)
> +#define IRQ_EINT_GROUP8_BASE	(IRQ_EINT_GROUP6_BASE + IRQ_EINT_GROUP6_NR)
> +
> +#define IRQ_EINT_GROUP(grp, x)	(IRQ_EINT_GROUP##grp##__BASE + (x))
                                                             ^^^^^
One _ too many.

> +
> +/* Set the default NR_IRQS */
> +
> +#define NR_IRQS			(IRQ_EINT_GROUP8_BASE + IRQ_EINT_GROUP8_NR + 1)
> +
> +#endif /* __ASM_ARCH_S5P_IRQS_H */
> diff --git a/arch/arm/mach-s5p6440/include/mach/regs-irq.h b/arch/arm/mach-s5p6440/include/mach/regs-irq.h
> new file mode 100644
> index 0000000..b37af72
> --- /dev/null
> +++ b/arch/arm/mach-s5p6440/include/mach/regs-irq.h
> @@ -0,0 +1,23 @@
> +/* linux/arch/arm/mach-s5p6440/include/mach/regs-irq.h
> + *
> + * Copyright (c) 2009 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com/
> + *
> + * S5P6440 - IRQ register definitions
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#ifndef __ASM_ARCH_REGS_IRQ_H
> +#define __ASM_ARCH_REGS_IRQ_H __FILE__
> +
> +#include <asm/hardware/vic.h>
> +#include <mach/map.h>
> +
> +/* interrupt controller */
> +#define S5P_VIC0REG(x)		(S5P_VA_VIC0 + (x))
> +#define S5P_VIC1REG(x)		(S5P_VA_VIC1 + (x))
> +
> +#endif /* __ASM_ARCH_REGS_IRQ_H */
> diff --git a/arch/arm/plat-s5p/include/plat/irqs.h b/arch/arm/plat-s5p/include/plat/irqs.h
> new file mode 100644
> index 0000000..1bc4bac
> --- /dev/null
> +++ b/arch/arm/plat-s5p/include/plat/irqs.h
> @@ -0,0 +1,80 @@
> +/* linux/arch/arm/plat-s5p/include/plat/irqs.h
> + *
> + * Copyright (c) 2009 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com/
> + *
> + * S5P Common IRQ support
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#ifndef __ASM_PLAT_S5P_IRQS_H
> +#define __ASM_PLAT_S5P_IRQS_H __FILE__
> +
> +/* we keep the first set of CPU IRQs out of the range of
> + * the ISA space, so that the PC104 has them to itself
> + * and we don't end up having to do horrible things to the
> + * standard ISA drivers....
> + *
> + * note, since we're using the VICs, our start must be a
> + * mulitple of 32 to allow the common code to work
> + */
> +
> +#define S5P_IRQ_OFFSET		(32)
> +
> +#define S5P_IRQ(x)		((x) + S5P_IRQ_OFFSET)
> +
> +#define S5P_VIC0_BASE		S5P_IRQ(0)
> +#define S5P_VIC1_BASE		S5P_IRQ(32)
> +
> +/* UART interrupts, each UART has 4 intterupts per channel so
> + * use the space between the ISA and S3C main interrupts. Note, these
> + * are not in the same order as the S3C24XX series! */
> +
> +#define IRQ_S5P_UART_BASE0	(16)
> +#define IRQ_S5P_UART_BASE1	(20)
> +#define IRQ_S5P_UART_BASE2	(24)
> +#define IRQ_S5P_UART_BASE3	(28)
> +
> +#define UART_IRQ_RXD		(0)
> +#define UART_IRQ_ERR		(1)
> +#define UART_IRQ_TXD		(2)
> +
> +#define IRQ_S5P_UART_RX0	(IRQ_S5P_UART_BASE0 + UART_IRQ_RXD)
> +#define IRQ_S5P_UART_TX0	(IRQ_S5P_UART_BASE0 + UART_IRQ_TXD)
> +#define IRQ_S5P_UART_ERR0	(IRQ_S5P_UART_BASE0 + UART_IRQ_ERR)
> +
> +#define IRQ_S5P_UART_RX1	(IRQ_S5P_UART_BASE1 + UART_IRQ_RXD)
> +#define IRQ_S5P_UART_TX1	(IRQ_S5P_UART_BASE1 + UART_IRQ_TXD)
> +#define IRQ_S5P_UART_ERR1	(IRQ_S5P_UART_BASE1 + UART_IRQ_ERR)
> +
> +#define IRQ_S5P_UART_RX2	(IRQ_S5P_UART_BASE2 + UART_IRQ_RXD)
> +#define IRQ_S5P_UART_TX2	(IRQ_S5P_UART_BASE2 + UART_IRQ_TXD)
> +#define IRQ_S5P_UART_ERR2	(IRQ_S5P_UART_BASE2 + UART_IRQ_ERR)
> +
> +#define IRQ_S5P_UART_RX3	(IRQ_S5P_UART_BASE3 + UART_IRQ_RXD)
> +#define IRQ_S5P_UART_TX3	(IRQ_S5P_UART_BASE3 + UART_IRQ_TXD)
> +#define IRQ_S5P_UART_ERR3	(IRQ_S5P_UART_BASE3 + UART_IRQ_ERR)
> +
> +/* S3C compatibilty defines */
> +#define IRQ_S3CUART_RX0		IRQ_S5P_UART_RX0
> +#define IRQ_S3CUART_RX1		IRQ_S5P_UART_RX1
> +#define IRQ_S3CUART_RX2		IRQ_S5P_UART_RX2
> +#define IRQ_S3CUART_RX3		IRQ_S5P_UART_RX3
> +
> +/* VIC based IRQs */
> +
> +#define S5P_IRQ_VIC0(x)		(S5P_VIC0_BASE + (x))
> +#define S5P_IRQ_VIC1(x)		(S5P_VIC1_BASE + (x))
> +
> +#define S5P_TIMER_IRQ(x)	S5P_IRQ(64 + (x))
> +
> +#define IRQ_TIMER0		S5P_TIMER_IRQ(0)
> +#define IRQ_TIMER1		S5P_TIMER_IRQ(1)
> +#define IRQ_TIMER2		S5P_TIMER_IRQ(2)
> +#define IRQ_TIMER3		S5P_TIMER_IRQ(3)
> +#define IRQ_TIMER4		S5P_TIMER_IRQ(4)
> +
> +#endif /* __ASM_PLAT_S5P_IRQS_H */
> diff --git a/arch/arm/plat-s5p/irq.c b/arch/arm/plat-s5p/irq.c
> new file mode 100644
> index 0000000..00f0e0c
> --- /dev/null
> +++ b/arch/arm/plat-s5p/irq.c
> @@ -0,0 +1,251 @@
> +/* arch/arm/plat-s5p/irq.c
> + *
> + * Copyright (c) 2009 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com/
> + *
> + * S5P - Interrupt handling
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#include <linux/kernel.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/io.h>
> +
> +#include <asm/hardware/vic.h>
> +
> +#include <linux/serial_core.h>
> +#include <mach/map.h>
> +#include <plat/regs-timer.h>
> +#include <plat/regs-serial.h>
> +#include <plat/cpu.h>
> +
> +#define VIC_VAADDR(no)	(S5P_VA_VIC0   + ((no)*0x10000))
> +#define VIC_BASE(no)	(S5P_VIC0_BASE + ((no)*32))
> +
> +/* Timer interrupt handling */
> +
> +static void s5p_irq_demux_timer(unsigned int base_irq, unsigned int sub_irq)
> +{
> +	generic_handle_irq(sub_irq);
> +}
> +
> +static void s5p_irq_demux_timer0(unsigned int irq, struct irq_desc *desc)
> +{
> +	s5p_irq_demux_timer(irq, IRQ_TIMER0);
> +}
> +
> +static void s5p_irq_demux_timer1(unsigned int irq, struct irq_desc *desc)
> +{
> +	s5p_irq_demux_timer(irq, IRQ_TIMER1);
> +}
> +
> +static void s5p_irq_demux_timer2(unsigned int irq, struct irq_desc *desc)
> +{
> +	s5p_irq_demux_timer(irq, IRQ_TIMER2);
> +}
> +
> +static void s5p_irq_demux_timer3(unsigned int irq, struct irq_desc *desc)
> +{
> +	s5p_irq_demux_timer(irq, IRQ_TIMER3);
> +}
> +
> +static void s5p_irq_demux_timer4(unsigned int irq, struct irq_desc *desc)
> +{
> +	s5p_irq_demux_timer(irq, IRQ_TIMER4);
> +}
> +
> +/* We assume the IRQ_TIMER0..IRQ_TIMER4 range is continuous. */
> +
> +static void s5p_irq_timer_mask(unsigned int irq)
> +{
> +	u32 reg = __raw_readl(S3C64XX_TINT_CSTAT);
> +
> +	reg &= 0x1f;  /* mask out pending interrupts */
> +	reg &= ~(1 << (irq - IRQ_TIMER0));
> +	__raw_writel(reg, S3C64XX_TINT_CSTAT);
> +}
> +
> +static void s5p_irq_timer_unmask(unsigned int irq)
> +{
> +	u32 reg = __raw_readl(S3C64XX_TINT_CSTAT);
> +
> +	reg &= 0x1f;  /* mask out pending interrupts */
> +	reg |= 1 << (irq - IRQ_TIMER0);
> +	__raw_writel(reg, S3C64XX_TINT_CSTAT);
> +}
> +
> +static void s5p_irq_timer_ack(unsigned int irq)
> +{
> +	u32 reg = __raw_readl(S3C64XX_TINT_CSTAT);
> +
> +	reg &= 0x1f;
> +	reg |= (1 << 5) << (irq - IRQ_TIMER0);
> +	__raw_writel(reg, S3C64XX_TINT_CSTAT);
> +}
> +
> +static struct irq_chip s5p_irq_timer = {
> +	.name		= "s5p-timer",
> +	.mask		= s5p_irq_timer_mask,
> +	.unmask		= s5p_irq_timer_unmask,
> +	.ack		= s5p_irq_timer_ack,
> +};
> +
> +struct uart_irq {
> +	void __iomem	*regs;
> +	unsigned int	 base_irq;
> +	unsigned int	 parent_irq;
> +};
> +
> +/*
> + * Note, we make use of the fact that the parent IRQs, IRQ_UART[0..3]
> + * are consecutive when looking up the interrupt in the demux routines.
> + */
> +static struct uart_irq uart_irqs[] = {
> +	[0] = {
> +		.regs		= S5P_VA_UART0,
> +		.base_irq	= IRQ_S5P_UART_BASE0,
> +		.parent_irq	= IRQ_UART0,
> +	},
> +	[1] = {
> +		.regs		= S5P_VA_UART1,
> +		.base_irq	= IRQ_S5P_UART_BASE1,
> +		.parent_irq	= IRQ_UART1,
> +	},
> +	[2] = {
> +		.regs		= S5P_VA_UART2,
> +		.base_irq	= IRQ_S5P_UART_BASE2,
> +		.parent_irq	= IRQ_UART2,
> +	},
> +	[3] = {
> +		.regs		= S5P_VA_UART3,
> +		.base_irq	= IRQ_S5P_UART_BASE3,
> +		.parent_irq	= IRQ_UART3,
> +	},
> +};
> +
> +static inline void __iomem *s5p_irq_uart_base(unsigned int irq)
> +{
> +	struct uart_irq *uirq = get_irq_chip_data(irq);
> +	return uirq->regs;
> +}
> +
> +static inline unsigned int s5p_irq_uart_bit(unsigned int irq)
> +{
> +	return irq & 3;
> +}
> +
> +static void s5p_irq_uart_mask(unsigned int irq)
> +{
> +	void __iomem *regs = s5p_irq_uart_base(irq);
> +	unsigned int bit = s5p_irq_uart_bit(irq);
> +	u32 reg;
> +
> +	reg = __raw_readl(regs + S3C64XX_UINTM);
> +	reg |= (1 << bit);
> +	__raw_writel(reg, regs + S3C64XX_UINTM);
> +}
> +
> +static void s5p_irq_uart_maskack(unsigned int irq)
> +{
> +	void __iomem *regs = s5p_irq_uart_base(irq);
> +	unsigned int bit = s5p_irq_uart_bit(irq);
> +	u32 reg;
> +
> +	reg = __raw_readl(regs + S3C64XX_UINTM);
> +	reg |= (1 << bit);
> +	__raw_writel(reg, regs + S3C64XX_UINTM);
> +	__raw_writel(1 << bit, regs + S3C64XX_UINTP);
> +}
> +
> +static void s5p_irq_uart_unmask(unsigned int irq)
> +{
> +	void __iomem *regs = s5p_irq_uart_base(irq);
> +	unsigned int bit = s5p_irq_uart_bit(irq);
> +	u32 reg;
> +
> +	reg = __raw_readl(regs + S3C64XX_UINTM);
> +	reg &= ~(1 << bit);
> +	__raw_writel(reg, regs + S3C64XX_UINTM);
> +}
> +
> +static void s5p_irq_uart_ack(unsigned int irq)
> +{
> +	void __iomem *regs = s5p_irq_uart_base(irq);
> +	unsigned int bit = s5p_irq_uart_bit(irq);
> +
> +	__raw_writel(1 << bit, regs + S3C64XX_UINTP);
> +}
> +
> +static void s5p_irq_demux_uart(unsigned int irq, struct irq_desc *desc)
> +{
> +	struct uart_irq *uirq = &uart_irqs[irq - IRQ_UART0];
> +	u32 pend = __raw_readl(uirq->regs + S3C64XX_UINTP);
> +	int base = uirq->base_irq;
> +
> +	if (pend & (1 << 0))
> +		generic_handle_irq(base);
> +	if (pend & (1 << 1))
> +		generic_handle_irq(base + 1);
> +	if (pend & (1 << 2))
> +		generic_handle_irq(base + 2);
> +	if (pend & (1 << 3))
> +		generic_handle_irq(base + 3);
> +}
> +
> +static struct irq_chip s5p_irq_uart = {
> +	.name		= "s5p-uart",
> +	.mask		= s5p_irq_uart_mask,
> +	.unmask		= s5p_irq_uart_unmask,
> +	.mask_ack	= s5p_irq_uart_maskack,
> +	.ack		= s5p_irq_uart_ack,
> +};
> +
> +static void __init s5p_uart_irq(struct uart_irq *uirq)
> +{
> +	void __iomem *reg_base = uirq->regs;
> +	unsigned int irq;
> +	int offs;
> +
> +	/* mask all interrupts at the start. */
> +	__raw_writel(0xf, reg_base + S3C64XX_UINTM);
> +
> +	for (offs = 0; offs < 3; offs++) {
> +		irq = uirq->base_irq + offs;
> +
> +		set_irq_chip(irq, &s5p_irq_uart);
> +		set_irq_chip_data(irq, uirq);
> +		set_irq_handler(irq, handle_level_irq);
> +		set_irq_flags(irq, IRQF_VALID);
> +	}
> +
> +	set_irq_chained_handler(uirq->parent_irq, s5p_irq_demux_uart);
> +}
> +
> +void __init s5p_init_irq(u32 *vic, u32 num_vic)
> +{
> +	int uart, irq;
> +
> +	/* initialize the VICs */
> +	for (irq = 0; irq < num_vic; irq++)
> +		vic_init(VIC_VAADDR(irq), VIC_BASE(irq), vic[irq], 0);
> +
> +	/* add the timer sub-irqs */
> +	set_irq_chained_handler(IRQ_TIMER0_VIC, s5p_irq_demux_timer0);
> +	set_irq_chained_handler(IRQ_TIMER1_VIC, s5p_irq_demux_timer1);
> +	set_irq_chained_handler(IRQ_TIMER2_VIC, s5p_irq_demux_timer2);
> +	set_irq_chained_handler(IRQ_TIMER3_VIC, s5p_irq_demux_timer3);
> +	set_irq_chained_handler(IRQ_TIMER4_VIC, s5p_irq_demux_timer4);
> +
> +	for (irq = IRQ_TIMER0; irq <= IRQ_TIMER4; irq++) {
> +		set_irq_chip(irq, &s5p_irq_timer);
> +		set_irq_handler(irq, handle_level_irq);
> +		set_irq_flags(irq, IRQF_VALID);
> +	}
> +
> +	for (uart = 0; uart < ARRAY_SIZE(uart_irqs); uart++)
> +		s5p_uart_irq(&uart_irqs[uart]);
> +}


-- 
Fast. Cheap. Reliable. Pick two.
