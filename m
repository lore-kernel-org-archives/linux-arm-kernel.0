From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 11 May 2012 21:41:31 +0200
Subject: [RFC PATCH] ARM: imx: add PM support to i.MX25
In-Reply-To: <1336489554-29393-1-git-send-email-eric@eukrea.com>
References: <1336489554-29393-1-git-send-email-eric@eukrea.com>
Message-ID: <20120511194131.GQ27341@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

On Tue, May 08, 2012 at 05:05:54PM +0200, Eric B?nard wrote:
> this patch adds PM support to i.MX25 CPU and is tested on an i.MX257.
> A hook in avic.c is needed as the irq which can wake the CPU must be
> masked in the MXC_CCM_LPIMRx registers.

Generally please have a look at other i.MX pm implementations. It may be
that there is some code to share. Robert Lee has recently worked in the
pm area.

> +#include <mach/hardware.h>
> +#include <mach/crm-regs-imx25.h>
> +
> +enum mx25_low_pwr_mode {
> +	MX25_RUN_MODE,
> +	MX25_WAIT_MODE,
> +	MX25_DOZE_MODE,
> +	MX25_STOP_MODE
> +};

This enum seems to be used only to set the 'lpm' variable which is never
read.

> +
> +static unsigned int cgcr0, cgcr1, cgcr2;
> +
> +void mxc_cpu_lp_set(enum mxc_cpu_pwr_mode mode)

As a global function which is mx25 specific this should not have a mxc_
prefix.

> +
> +static int mx25_suspend_enter(suspend_state_t state)
> +{
> +	unsigned int reg;
> +
> +	switch (state) {
> +	case PM_SUSPEND_MEM:
> +		mxc_cpu_lp_set(STOP_POWER_OFF);
> +		break;
> +	case PM_SUSPEND_STANDBY:
> +		mxc_cpu_lp_set(WAIT_UNCLOCKED_POWER_OFF);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	/* Executing CP15 (Wait-for-Interrupt) Instruction */
> +	cpu_do_idle();
> +	/* Back to wait mode */
> +	mxc_cpu_lp_set(WAIT_CLOCKED);
> +
> +	reg = (__raw_readl(MXC_CCM_CGCR0) & ~MXC_CCM_CGCR0_STOP_MODE_MASK) |
> +		cgcr0;
> +	__raw_writel(reg, MXC_CCM_CGCR0);
> +	reg = (__raw_readl(MXC_CCM_CGCR1) & ~MXC_CCM_CGCR1_STOP_MODE_MASK) |
> +		cgcr1;
> +	__raw_writel(reg, MXC_CCM_CGCR1);
> +	reg = (__raw_readl(MXC_CCM_CGCR2) & ~MXC_CCM_CGCR2_STOP_MODE_MASK) |
> +		cgcr2;
> +	__raw_writel(reg, MXC_CCM_CGCR2);
> +
> +	return 0;
> +}
> +
> +static int mx25_suspend_prepare(void)
> +{
> +	cgcr0 = __raw_readl(MXC_CCM_CGCR0) & MXC_CCM_CGCR0_STOP_MODE_MASK;
> +	cgcr1 = __raw_readl(MXC_CCM_CGCR1) & MXC_CCM_CGCR1_STOP_MODE_MASK;
> +	cgcr2 = __raw_readl(MXC_CCM_CGCR2) & MXC_CCM_CGCR2_STOP_MODE_MASK;

Do you need to do this here? When you read the values in
mx25_suspend_enter you do not need global static variables for cgcr* and
can just write the values back without having to mask something.

> +
> +static int __init mx25_pm_init(void)
> +{
> +	if (!cpu_is_mx25())
> +		return 0;
> +
> +	suspend_set_ops(&mx25_suspend_ops);
> +	return 0;
> +}
> +
> +device_initcall(mx25_pm_init);

We now have machine specific late initcalls in the machine descriptor
which could be used for this.

> diff --git a/arch/arm/plat-mxc/avic.c b/arch/arm/plat-mxc/avic.c
> index 689f81f..ab94d2e 100644
> --- a/arch/arm/plat-mxc/avic.c
> +++ b/arch/arm/plat-mxc/avic.c
> @@ -24,6 +24,7 @@
>  #include <asm/mach/irq.h>
>  #include <asm/exception.h>
>  #include <mach/hardware.h>
> +#include <mach/crm-regs-imx25.h>
>  
>  #include "irq-common.h"
>  
> @@ -52,6 +53,7 @@
>  void __iomem *avic_base;
>  
>  static u32 avic_saved_mask_reg[2];
> +static u32 avic_imx25_lpimr[2];
>  
>  #ifdef CONFIG_MXC_IRQ_PRIOR
>  static int avic_irq_set_priority(unsigned char irq, unsigned char prio)
> @@ -128,6 +130,27 @@ static void avic_irq_resume(struct irq_data *d)
>  #define avic_irq_resume NULL
>  #endif
>  
> +int imx25_gc_set_wake(struct irq_data *d, unsigned int on)
> +{
> +	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
> +
> +	if (on)
> +		if ((d->irq) < 32)
> +			avic_imx25_lpimr[0] &= ~(1 << (d->irq - gc->irq_base));
> +		else
> +			avic_imx25_lpimr[1] &= ~(1 << (d->irq - gc->irq_base));
> +	else
> +		if ((d->irq) < 32)
> +			avic_imx25_lpimr[0] |= (1 << (d->irq - gc->irq_base));
> +		else
> +			avic_imx25_lpimr[1] |= (1 << (d->irq - gc->irq_base));
> +
> +	__raw_writel(avic_imx25_lpimr[0], MXC_CCM_LPIMR0);
> +	__raw_writel(avic_imx25_lpimr[1], MXC_CCM_LPIMR1);
> +
> +	return irq_gc_set_wake(d, on);
> +}
> +
>  static __init void avic_init_gc(unsigned int irq_start)
>  {
>  	struct irq_chip_generic *gc;
> @@ -148,7 +171,16 @@ static __init void avic_init_gc(unsigned int irq_start)
>  	ct->chip.irq_resume = avic_irq_resume;
>  	ct->regs.mask = !idx ? AVIC_INTENABLEL : AVIC_INTENABLEH;
>  	ct->regs.ack = ct->regs.mask;
> -
> +	if (cpu_is_mx25()) {
> +		ct->chip.irq_set_wake = imx25_gc_set_wake;
> +		if (irq_start == 0) {
> +			avic_imx25_lpimr[0] = 0xFFFFFFFF;
> +			__raw_writel(avic_imx25_lpimr[0], MXC_CCM_LPIMR0);
> +		} else {
> +			avic_imx25_lpimr[1] = 0xFFFFFFFF;
> +			__raw_writel(avic_imx25_lpimr[1], MXC_CCM_LPIMR1);
> +		}
> +	}

Do you really have to overwrite irq_set_wake? The generic
irq_gc_set_wake just collects the bits in wake_active until they are
used in suspend/resume, so I think you should hook into suspend/resume
instead.

> + * Copyright (C) 2008-2010 Freescale Semiconductor, Inc. All Rights Reserved.
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +#ifndef __ARCH_ARM_MACH_MX25_CRM_REGS_H__
> +#define __ARCH_ARM_MACH_MX25_CRM_REGS_H__
> +
> +#define MX25_CCM_BASE			MX25_IO_ADDRESS(MX25_CRM_BASE_ADDR)
> +/* Register offsets */
> +#define MXC_CCM_MPCTL		(MX25_CCM_BASE + 0x00)

You shouldn't define the registers directly but instead only the offsets
to the CCM_BASE which is more flexible. Also, please use a MX25_ prefix
rather than a MXC_ prefix.

> +
> +#define MXC_CCM_MPCTL_BRMO		(1 << 31)
> +#define MXC_CCM_MPCTL_PD_OFFSET		26
> +#define MXC_CCM_MPCTL_PD_MASK		(0xf << 26)
> +#define MXC_CCM_MPCTL_MFD_OFFSET	16
> +#define MXC_CCM_MPCTL_MFD_MASK		(0x3ff << 16)
> +#define MXC_CCM_MPCTL_MFI_OFFSET	10
> +#define MXC_CCM_MPCTL_MFI_MASK		(0xf << 10)
> +#define MXC_CCM_MPCTL_MFN_OFFSET	0
> +#define MXC_CCM_MPCTL_MFN_MASK		0x3ff
> +#define MXC_CCM_MPCTL_LF		(1 << 15)

We do not need most of the bit defines here. The divider, mux and gate
bits are used as numbers directly in the new clock framework as they are
used only once.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
