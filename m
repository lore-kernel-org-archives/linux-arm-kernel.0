From: adharmap@codeaurora.org (Abhijeet Dharmapurikar)
Date: Thu, 21 Apr 2011 08:13:31 -0700
Subject: arm: msm: Convert sirc to generic irq chip
In-Reply-To: <20110416211308.265157277@linutronix.de>
References: <20110416211221.853079766@linutronix.de>
	<20110416211308.265157277@linutronix.de>
Message-ID: <4DB0499B.4030003@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/16/2011 02:14 PM, Thomas Gleixner wrote:
> Signed-off-by: Thomas Gleixner<tglx@linutronix.de>
> ---
>   arch/arm/mach-msm/include/mach/sirc.h |   43 +++-----
>   arch/arm/mach-msm/sirc.c              |  166 ++++++++++------------------------
>   2 files changed, 68 insertions(+), 141 deletions(-)
>
> Index: linux-2.6/arch/arm/mach-msm/include/mach/sirc.h
> ===================================================================
> --- linux-2.6.orig/arch/arm/mach-msm/include/mach/sirc.h
> +++ linux-2.6/arch/arm/mach-msm/include/mach/sirc.h
> @@ -13,18 +13,13 @@
>   #ifndef __ASM_ARCH_MSM_SIRC_H
>   #define __ASM_ARCH_MSM_SIRC_H
>
> -struct sirc_regs_t {
> -	void    *int_enable;
> -	void    *int_enable_clear;
> -	void    *int_enable_set;
> -	void    *int_type;
> -	void    *int_polarity;
> -	void    *int_clear;
> -};
> -
>   struct sirc_cascade_regs {
> -	void    *int_status;
> -	unsigned int    cascade_irq;
> +	void __iomem	*reg_base;
> +	unsigned long	int_status;
> +	u32		status_mask;
> +	unsigned int	irq_base;
> +	unsigned int	irq_cnt;
> +	unsigned int	cascade_irq;
>   };
>
>   void msm_init_sirc(void);
> @@ -78,20 +73,18 @@ void msm_sirc_exit_sleep(void);
>   #define SIRC_MASK                     0x007FFFFF
>   #endif
>
> -#define LAST_SIRC_IRQ                 (FIRST_SIRC_IRQ + NR_SIRC_IRQS - 1)
> -
> -#define SPSS_SIRC_INT_SELECT          (MSM_SIRC_BASE + 0x00)
> -#define SPSS_SIRC_INT_ENABLE          (MSM_SIRC_BASE + 0x04)
> -#define SPSS_SIRC_INT_ENABLE_CLEAR    (MSM_SIRC_BASE + 0x08)
> -#define SPSS_SIRC_INT_ENABLE_SET      (MSM_SIRC_BASE + 0x0C)
> -#define SPSS_SIRC_INT_TYPE            (MSM_SIRC_BASE + 0x10)
> -#define SPSS_SIRC_INT_POLARITY        (MSM_SIRC_BASE + 0x14)
> -#define SPSS_SIRC_SECURITY            (MSM_SIRC_BASE + 0x18)
> -#define SPSS_SIRC_IRQ_STATUS          (MSM_SIRC_BASE + 0x1C)
> -#define SPSS_SIRC_IRQ1_STATUS         (MSM_SIRC_BASE + 0x20)
> -#define SPSS_SIRC_RAW_STATUS          (MSM_SIRC_BASE + 0x24)
> -#define SPSS_SIRC_INT_CLEAR           (MSM_SIRC_BASE + 0x28)
> -#define SPSS_SIRC_SOFT_INT            (MSM_SIRC_BASE + 0x2C)
> +#define SPSS_SIRC_INT_SELECT          0x00
> +#define SPSS_SIRC_INT_ENABLE          0x04
> +#define SPSS_SIRC_INT_ENABLE_CLEAR    0x08
> +#define SPSS_SIRC_INT_ENABLE_SET      0x0C
> +#define SPSS_SIRC_INT_TYPE            0x10
> +#define SPSS_SIRC_INT_POLARITY        0x14
> +#define SPSS_SIRC_SECURITY            0x18
> +#define SPSS_SIRC_IRQ_STATUS          0x1C
> +#define SPSS_SIRC_IRQ1_STATUS         0x20
> +#define SPSS_SIRC_RAW_STATUS          0x24
> +#define SPSS_SIRC_INT_CLEAR           0x28
> +#define SPSS_SIRC_SOFT_INT            0x2C
>
>   #endif
>
> Index: linux-2.6/arch/arm/mach-msm/sirc.c
> ===================================================================
> --- linux-2.6.orig/arch/arm/mach-msm/sirc.c
> +++ linux-2.6/arch/arm/mach-msm/sirc.c
> @@ -15,158 +15,92 @@
>    * 02110-1301, USA.
>    *
>    */
> -
> -#include<linux/io.h>
> -#include<linux/irq.h>
>   #include<linux/interrupt.h>
> -#include<asm/irq.h>
> -
> -static unsigned int int_enable;
> -static unsigned int wake_enable;
> +#include<linux/irq.h>
> +#include<linux/io.h>
>
> -static struct sirc_regs_t sirc_regs = {
> -	.int_enable       = SPSS_SIRC_INT_ENABLE,
> -	.int_enable_clear = SPSS_SIRC_INT_ENABLE_CLEAR,
> -	.int_enable_set   = SPSS_SIRC_INT_ENABLE_SET,
> -	.int_type         = SPSS_SIRC_INT_TYPE,
> -	.int_polarity     = SPSS_SIRC_INT_POLARITY,
> -	.int_clear        = SPSS_SIRC_INT_CLEAR,
> -};
> +#include<asm/irq.h>
>
>   static struct sirc_cascade_regs sirc_reg_table[] = {
>   	{
> +		.reg_base    = MSM_SIRC_BASE,
>   		.int_status  = SPSS_SIRC_IRQ_STATUS,
> +		.status_mask = SIRC_MASK,
> +		.irq_base    = FIRST_SIRC_IRQ,
> +		.irq_cnt     = NR_SIRC_IRQS,
>   		.cascade_irq = INT_SIRC_0,
>   	}
>   };
>
> -/* Mask off the given interrupt. Keep the int_enable mask in sync with
> -   the enable reg, so it can be restored after power collapse. */
> -static void sirc_irq_mask(struct irq_data *d)
> -{
> -	unsigned int mask;
> -
> -	mask = 1<<  (d->irq - FIRST_SIRC_IRQ);
> -	writel(mask, sirc_regs.int_enable_clear);
> -	int_enable&= ~mask;
> -	return;
> -}
> -
> -/* Unmask the given interrupt. Keep the int_enable mask in sync with
> -   the enable reg, so it can be restored after power collapse. */
> -static void sirc_irq_unmask(struct irq_data *d)
> -{
> -	unsigned int mask;
> -
> -	mask = 1<<  (d->irq - FIRST_SIRC_IRQ);
> -	writel(mask, sirc_regs.int_enable_set);
> -	int_enable |= mask;
> -	return;
> -}
> -
> -static void sirc_irq_ack(struct irq_data *d)
> -{
> -	unsigned int mask;
> -
> -	mask = 1<<  (d->irq - FIRST_SIRC_IRQ);
> -	writel(mask, sirc_regs.int_clear);
> -	return;
> -}
> -
> -static int sirc_irq_set_wake(struct irq_data *d, unsigned int on)
> -{
> -	unsigned int mask;
> -
> -	/* Used to set the interrupt enable mask during power collapse. */
> -	mask = 1<<  (d->irq - FIRST_SIRC_IRQ);
> -	if (on)
> -		wake_enable |= mask;
> -	else
> -		wake_enable&= ~mask;
> -
> -	return 0;
> -}
> -
>   static int sirc_irq_set_type(struct irq_data *d, unsigned int flow_type)
>   {
> -	unsigned int mask;
> -	unsigned int val;
> -
> -	mask = 1<<  (d->irq - FIRST_SIRC_IRQ);
> -	val = readl(sirc_regs.int_polarity);
> +	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
> +	u32 mask = 1<<  (d->irq - gc->irq_base);
>
>   	if (flow_type&  (IRQF_TRIGGER_LOW | IRQF_TRIGGER_FALLING))
> -		val |= mask;
> +		gc->polarity_cache |= mask;
>   	else
> -		val&= ~mask;
> -
> -	writel(val, sirc_regs.int_polarity);
> +		gc->polarity_cache&= ~mask;
> +	writel(gc->polarity_cache, gc->reg_base + gc->chip_types->regs.type);
>
> -	val = readl(sirc_regs.int_type);
>   	if (flow_type&  (IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING)) {
> -		val |= mask;
> +		gc->type_cache |= mask;
>   		__irq_set_handler_locked(d->irq, handle_edge_irq);
>   	} else {
> -		val&= ~mask;
> +		gc->type_cache&= ~mask;
>   		__irq_set_handler_locked(d->irq, handle_level_irq);
>   	}
> -
> -	writel(val, sirc_regs.int_type);
> -
> +	writel(gc->type_cache, gc->reg_base + gc->chip_types->regs.polarity);
>   	return 0;
>   }
>
>   /* Finds the pending interrupt on the passed cascade irq and redrives it */
>   static void sirc_irq_handler(unsigned int irq, struct irq_desc *desc)
>   {
> -	unsigned int reg = 0;
> -	unsigned int sirq;
> -	unsigned int status;
> -
> -	while ((reg<  ARRAY_SIZE(sirc_reg_table))&&
> -		(sirc_reg_table[reg].cascade_irq != irq))
> -		reg++;
> -
> -	status = readl(sirc_reg_table[reg].int_status);
> -	status&= SIRC_MASK;
> -	if (status == 0)
> +	struct sirc_cascade_regs *cr = irq_desc_get_handler_data(desc);
> +	u32 status;
> +
> +	status = readl(cr->reg_base + cr->int_status);
> +	status&= cr->status_mask;
> +	if (!status)
>   		return;
>
> -	for (sirq = 0;
> -	     (sirq<  NR_SIRC_IRQS)&&  ((status&  (1U<<  sirq)) == 0);
> -	     sirq++)
> -		;
> -	generic_handle_irq(sirq+FIRST_SIRC_IRQ);
> +	generic_handle_irq(cr->irq_base + __ffs(status));
>
>   	desc->irq_data.chip->irq_ack(&desc->irq_data);
>   }
>
> -static struct irq_chip sirc_irq_chip = {
> -	.name          = "sirc",
> -	.irq_ack       = sirc_irq_ack,
> -	.irq_mask      = sirc_irq_mask,
> -	.irq_unmask    = sirc_irq_unmask,
> -	.irq_set_wake  = sirc_irq_set_wake,
> -	.irq_set_type  = sirc_irq_set_type,
> -};
> +static void msm_init_one_sirc(struct sirc_cascade_regs *cr)
> +{
> +	struct irq_chip_generic *gc;
> +	struct irq_chip_type *ct;
> +
> +	gc = irq_alloc_generic_chip("sirc", 1, cr->irq_base, cr->reg_base,
> +				    handle_level_irq);
> +	ct = gc->chip_types;
> +	ct->chip.irq_ack = irq_gc_ack;
> +	ct->chip.irq_mask = irq_gc_mask_disable_reg;
> +	ct->chip.irq_unmask = irq_gc_unmask_enable_reg;
> +	ct->chip.irq_set_wake = irq_gc_set_wake;
> +	ct->chip.irq_set_type = sirc_irq_set_type;
> +	ct->regs.ack = SPSS_SIRC_INT_CLEAR;
> +	ct->regs.disable = SPSS_SIRC_INT_ENABLE_CLEAR;
> +	ct->regs.enable = SPSS_SIRC_INT_ENABLE_SET;
> +	ct->regs.type = SPSS_SIRC_INT_TYPE;
> +	ct->regs.polarity = SPSS_SIRC_INT_POLARITY;
> +
> +	irq_setup_generic_chip(gc, IRQ_MSK(sirc->irq_cnt),
> +			       IRQ_NOREQUEST | IRQ_NOPROBE, 0);
> +
> +	irq_set_chained_handler(cr->cascade_irq, sirc_irq_handler);
> +	irq_set_handler_data(cr->cascade_irq, cr);
> +	irq_set_irq_wake(cr->cascade_irq, 1);
> +}
>
>   void __init msm_init_sirc(void)
>   {
>   	int i;
>
> -	int_enable = 0;
> -	wake_enable = 0;
> -
> -	for (i = FIRST_SIRC_IRQ; i<  LAST_SIRC_IRQ; i++) {
> -		irq_set_chip_and_handler(i,&sirc_irq_chip, handle_edge_irq);
> -		set_irq_flags(i, IRQF_VALID);
> -	}
> -
> -	for (i = 0; i<  ARRAY_SIZE(sirc_reg_table); i++) {
> -		irq_set_chained_handler(sirc_reg_table[i].cascade_irq,
> -					sirc_irq_handler);
> -		irq_set_irq_wake(sirc_reg_table[i].cascade_irq, 1);
> -	}
> -	return;
> +	for (i = 0; i<  ARRAY_SIZE(sirc_reg_table); i++)
> +		msm_init_one_sirc(sirc_reg_table + i);
>   }

This looks good to me. Thanks a ton for cleaning it up.

Abhijeet
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
