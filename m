From: robherring2@gmail.com (Rob Herring)
Date: Wed, 27 Mar 2013 16:58:29 -0500
Subject: [PATCH v6 7/7] irqchip: s3c24xx: add devicetree support
In-Reply-To: <201303262310.35354.heiko@sntech.de>
References: <201303262305.49725.heiko@sntech.de>
 <201303262310.35354.heiko@sntech.de>
Message-ID: <51536B85.1070205@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/26/2013 05:10 PM, Heiko St?bner wrote:
> Add the necessary code to initialize the interrupt controller
> thru devicetree data using the irqchip infrastructure.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Acked-by: Rob Herring <rob.herring@calxeda.com>

> ---
>  .../interrupt-controller/samsung,s3c24xx-irq.txt   |   53 +++++
>  drivers/irqchip/irq-s3c24xx.c                      |  231 +++++++++++++++++++-
>  2 files changed, 278 insertions(+), 6 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/samsung,s3c24xx-irq.txt
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/samsung,s3c24xx-irq.txt b/Documentation/devicetree/bindings/interrupt-controller/samsung,s3c24xx-irq.txt
> new file mode 100644
> index 0000000..c54c5a9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/samsung,s3c24xx-irq.txt
> @@ -0,0 +1,53 @@
> +Samsung S3C24XX Interrupt Controllers
> +
> +The S3C24XX SoCs contain a custom set of interrupt controllers providing a
> +varying number of interrupt sources. The set consists of a main- and sub-
> +controller and on newer SoCs even a second main controller.
> +
> +Required properties:
> +- compatible: Compatible property value should be "samsung,s3c2410-irq"
> +  for machines before s3c2416 and "samsung,s3c2416-irq" for s3c2416 and later.
> +
> +- reg: Physical base address of the controller and length of memory mapped
> +  region.
> +
> +- interrupt-controller : Identifies the node as an interrupt controller
> +
> +- #interrupt-cells : Specifies the number of cells needed to encode an
> +  interrupt source. The value shall be 4 and interrupt descriptor shall
> +  have the following format:
> +      <ctrl_num parent_irq ctrl_irq type>
> +
> +  ctrl_num contains the controller to use:
> +      - 0 ... main controller
> +      - 1 ... sub controller
> +      - 2 ... second main controller on s3c2416 and s3c2450
> +  parent_irq contains the parent bit in the main controller and will be
> +             ignored in main controllers
> +  ctrl_irq contains the interrupt bit of the controller
> +  type contains the trigger type to use
> +
> +Example:
> +
> +	interrupt-controller at 4a000000 {
> +		compatible = "samsung,s3c2410-irq";
> +		reg = <0x4a000000 0x100>;
> +		interrupt-controller;
> +		#interrupt-cells=<4>;
> +	};
> +
> +	[...]
> +
> +	serial at 50000000 {
> +		compatible = "samsung,s3c2410-uart";
> +		reg = <0x50000000 0x4000>;
> +		interrupt-parent = <&subintc>;
> +		interrupts = <1 28 0 4>, <1 28 1 4>;
> +	};
> +
> +	rtc at 57000000 {
> +		compatible = "samsung,s3c2410-rtc";
> +		reg = <0x57000000 0x100>;
> +		interrupt-parent = <&intc>;
> +		interrupts = <0 30 0 3>, <0 8 0 3>;
> +	};
> diff --git a/drivers/irqchip/irq-s3c24xx.c b/drivers/irqchip/irq-s3c24xx.c
> index 02b82db..5e40b34 100644
> --- a/drivers/irqchip/irq-s3c24xx.c
> +++ b/drivers/irqchip/irq-s3c24xx.c
> @@ -25,6 +25,9 @@
>  #include <linux/ioport.h>
>  #include <linux/device.h>
>  #include <linux/irqdomain.h>
> +#include <linux/of.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_address.h>
>  
>  #include <asm/exception.h>
>  #include <asm/mach/irq.h>
> @@ -36,6 +39,8 @@
>  #include <plat/regs-irqtype.h>
>  #include <plat/pm.h>
>  
> +#include "irqchip.h"
> +
>  #define S3C_IRQTYPE_NONE	0
>  #define S3C_IRQTYPE_EINT	1
>  #define S3C_IRQTYPE_EDGE	2
> @@ -94,7 +99,10 @@ static void s3c_irq_mask(struct irq_data *data)
>  	if (parent_intc) {
>  		parent_data = &parent_intc->irqs[irq_data->parent_irq];
>  
> -		/* check to see if we need to mask the parent IRQ */
> +		/* check to see if we need to mask the parent IRQ
> +		 * The parent_irq is always in main_intc, so the hwirq
> +		 * for find_mapping does not need an offset in any case.
> +		 */
>  		if ((mask & parent_data->sub_bits) == parent_data->sub_bits) {
>  			irqno = irq_find_mapping(parent_intc->domain,
>  					 irq_data->parent_irq);
> @@ -294,10 +302,18 @@ static void s3c_irq_demux(unsigned int irq, struct irq_desc *desc)
>  {
>  	struct irq_chip *chip = irq_desc_get_chip(desc);
>  	struct s3c_irq_data *irq_data = irq_desc_get_chip_data(desc);
> +	struct s3c_irq_intc *intc = irq_data->intc;
>  	struct s3c_irq_intc *sub_intc = irq_data->sub_intc;
>  	unsigned long src;
>  	unsigned long msk;
>  	unsigned int n;
> +	unsigned int offset;
> +
> +	/* we're using individual domains for the non-dt case
> +	 * and one big domain for the dt case where the subintc
> +	 * starts at hwirq number 32.
> +	 */
> +	offset = (intc->domain->of_node) ? 32 : 0;
>  
>  	chained_irq_enter(chip, desc);
>  
> @@ -310,14 +326,15 @@ static void s3c_irq_demux(unsigned int irq, struct irq_desc *desc)
>  	while (src) {
>  		n = __ffs(src);
>  		src &= ~(1 << n);
> -		generic_handle_irq(irq_find_mapping(sub_intc->domain, n));
> +		irq = irq_find_mapping(sub_intc->domain, offset + n);
> +		generic_handle_irq(irq);
>  	}
>  
>  	chained_irq_exit(chip, desc);
>  }
>  
>  static inline int s3c24xx_handle_intc(struct s3c_irq_intc *intc,
> -				      struct pt_regs *regs)
> +				      struct pt_regs *regs, int intc_offset)
>  {
>  	int pnd;
>  	int offset;
> @@ -327,6 +344,10 @@ static inline int s3c24xx_handle_intc(struct s3c_irq_intc *intc,
>  	if (!pnd)
>  		return false;
>  
> +	/* non-dt machines use individual domains */
> +	if (!intc->domain->of_node)
> +		intc_offset = 0;
> +
>  	/* We have a problem that the INTOFFSET register does not always
>  	 * show one interrupt. Occasionally we get two interrupts through
>  	 * the prioritiser, and this causes the INTOFFSET register to show
> @@ -343,7 +364,7 @@ static inline int s3c24xx_handle_intc(struct s3c_irq_intc *intc,
>  	if (!(pnd & (1 << offset)))
>  		offset =  __ffs(pnd);
>  
> -	irq = irq_find_mapping(intc->domain, offset);
> +	irq = irq_find_mapping(intc->domain, intc_offset + offset);
>  	handle_IRQ(irq, regs);
>  	return true;
>  }
> @@ -352,11 +373,11 @@ asmlinkage void __exception_irq_entry s3c24xx_handle_irq(struct pt_regs *regs)
>  {
>  	do {
>  		if (likely(s3c_intc[0]))
> -			if (s3c24xx_handle_intc(s3c_intc[0], regs))
> +			if (s3c24xx_handle_intc(s3c_intc[0], regs, 0))
>  				continue;
>  
>  		if (s3c_intc[2])
> -			if (s3c24xx_handle_intc(s3c_intc[2], regs))
> +			if (s3c24xx_handle_intc(s3c_intc[2], regs, 64))
>  				continue;
>  
>  		break;
> @@ -1134,3 +1155,201 @@ void __init s3c2443_init_irq(void)
>  					s3c_intc[0], 0x4a000018);
>  }
>  #endif
> +
> +#ifdef CONFIG_OF
> +static int s3c24xx_irq_map_of(struct irq_domain *h, unsigned int virq,
> +							irq_hw_number_t hw)
> +{
> +	unsigned int ctrl_num = hw / 32;
> +	unsigned int intc_hw = hw % 32;
> +	struct s3c_irq_intc *intc = s3c_intc[ctrl_num];
> +	struct s3c_irq_intc *parent_intc = intc->parent;
> +	struct s3c_irq_data *irq_data = &intc->irqs[intc_hw];
> +
> +	/* attach controller pointer to irq_data */
> +	irq_data->intc = intc;
> +	irq_data->offset = intc_hw;
> +
> +	if (!parent_intc)
> +		irq_set_chip_and_handler(virq, &s3c_irq_chip, handle_edge_irq);
> +	else
> +		irq_set_chip_and_handler(virq, &s3c_irq_level_chip,
> +					 handle_edge_irq);
> +
> +	irq_set_chip_data(virq, irq_data);
> +
> +	set_irq_flags(virq, IRQF_VALID);
> +
> +	return 0;
> +}
> +
> +/* Translate our of irq notation
> + * format: <ctrl_num ctrl_irq parent_irq type>
> + */
> +static int s3c24xx_irq_xlate_of(struct irq_domain *d, struct device_node *n,
> +			const u32 *intspec, unsigned int intsize,
> +			irq_hw_number_t *out_hwirq, unsigned int *out_type)
> +{
> +	struct s3c_irq_intc *intc;
> +	struct s3c_irq_intc *parent_intc;
> +	struct s3c_irq_data *irq_data;
> +	struct s3c_irq_data *parent_irq_data;
> +	int irqno;
> +
> +	if (WARN_ON(intsize < 4))
> +		return -EINVAL;
> +
> +	if (intspec[0] > 2 || !s3c_intc[intspec[0]]) {
> +		pr_err("controller number %d invalid\n", intspec[0]);
> +		return -EINVAL;
> +	}
> +	intc = s3c_intc[intspec[0]];
> +
> +	*out_hwirq = intspec[0] * 32 + intspec[2];
> +	*out_type = intspec[3] & IRQ_TYPE_SENSE_MASK;
> +
> +	parent_intc = intc->parent;
> +	if (parent_intc) {
> +		irq_data = &intc->irqs[intspec[2]];
> +		irq_data->parent_irq = intspec[1];
> +		parent_irq_data = &parent_intc->irqs[irq_data->parent_irq];
> +		parent_irq_data->sub_intc = intc;
> +		parent_irq_data->sub_bits |= (1UL << intspec[2]);
> +
> +		/* parent_intc is always s3c_intc[0], so no offset */
> +		irqno = irq_create_mapping(parent_intc->domain, intspec[1]);
> +		if (irqno < 0) {
> +			pr_err("irq: could not map parent interrupt\n");
> +			return irqno;
> +		}
> +
> +		irq_set_chained_handler(irqno, s3c_irq_demux);
> +	}
> +
> +	return 0;
> +}
> +
> +static struct irq_domain_ops s3c24xx_irq_ops_of = {
> +	.map = s3c24xx_irq_map_of,
> +	.xlate = s3c24xx_irq_xlate_of,
> +};
> +
> +struct s3c24xx_irq_of_ctrl {
> +	char			*name;
> +	unsigned long		offset;
> +	struct s3c_irq_intc	**handle;
> +	struct s3c_irq_intc	**parent;
> +	struct irq_domain_ops	*ops;
> +};
> +
> +static int __init s3c_init_intc_of(struct device_node *np,
> +			struct device_node *interrupt_parent,
> +			struct s3c24xx_irq_of_ctrl *s3c_ctrl, int num_ctrl)
> +{
> +	struct s3c_irq_intc *intc;
> +	struct s3c24xx_irq_of_ctrl *ctrl;
> +	struct irq_domain *domain;
> +	void __iomem *reg_base;
> +	int i;
> +
> +	reg_base = of_iomap(np, 0);
> +	if (!reg_base) {
> +		pr_err("irq-s3c24xx: could not map irq registers\n");
> +		return -EINVAL;
> +	}
> +
> +	domain = irq_domain_add_linear(np, num_ctrl * 32,
> +						     &s3c24xx_irq_ops_of, NULL);
> +	if (!domain) {
> +		pr_err("irq: could not create irq-domain\n");
> +		return -EINVAL;
> +	}
> +
> +	for (i = 0; i < num_ctrl; i++) {
> +		ctrl = &s3c_ctrl[i];
> +
> +		pr_debug("irq: found controller %s\n", ctrl->name);
> +
> +		intc = kzalloc(sizeof(struct s3c_irq_intc), GFP_KERNEL);
> +		if (!intc)
> +			return -ENOMEM;
> +
> +		intc->domain = domain;
> +		intc->irqs = kzalloc(sizeof(struct s3c_irq_data) * 32,
> +				     GFP_KERNEL);
> +		if (!intc->irqs) {
> +			kfree(intc);
> +			return -ENOMEM;
> +		}
> +
> +		if (ctrl->parent) {
> +			intc->reg_pending = reg_base + ctrl->offset;
> +			intc->reg_mask = reg_base + ctrl->offset + 0x4;
> +
> +			if (*(ctrl->parent)) {
> +				intc->parent = *(ctrl->parent);
> +			} else {
> +				pr_warn("irq: parent of %s missing\n",
> +					ctrl->name);
> +				kfree(intc->irqs);
> +				kfree(intc);
> +				continue;
> +			}
> +		} else {
> +			intc->reg_pending = reg_base + ctrl->offset;
> +			intc->reg_mask = reg_base + ctrl->offset + 0x08;
> +			intc->reg_intpnd = reg_base + ctrl->offset + 0x10;
> +		}
> +
> +		s3c24xx_clear_intc(intc);
> +		s3c_intc[i] = intc;
> +	}
> +
> +	set_handle_irq(s3c24xx_handle_irq);
> +
> +	return 0;
> +}
> +
> +static struct s3c24xx_irq_of_ctrl s3c2410_ctrl[] = {
> +	{
> +		.name = "intc",
> +		.offset = 0,
> +	}, {
> +		.name = "subintc",
> +		.offset = 0x18,
> +		.parent = &s3c_intc[0],
> +	}
> +};
> +
> +int __init s3c2410_init_intc_of(struct device_node *np,
> +			struct device_node *interrupt_parent,
> +			struct s3c24xx_irq_of_ctrl *ctrl, int num_ctrl)
> +{
> +	return s3c_init_intc_of(np, interrupt_parent,
> +				s3c2410_ctrl, ARRAY_SIZE(s3c2410_ctrl));
> +}
> +IRQCHIP_DECLARE(s3c2410_irq, "samsung,s3c2410-irq", s3c2410_init_intc_of);
> +
> +static struct s3c24xx_irq_of_ctrl s3c2416_ctrl[] = {
> +	{
> +		.name = "intc",
> +		.offset = 0,
> +	}, {
> +		.name = "subintc",
> +		.offset = 0x18,
> +		.parent = &s3c_intc[0],
> +	}, {
> +		.name = "intc2",
> +		.offset = 0x40,
> +	}
> +};
> +
> +int __init s3c2416_init_intc_of(struct device_node *np,
> +			struct device_node *interrupt_parent,
> +			struct s3c24xx_irq_of_ctrl *ctrl, int num_ctrl)
> +{
> +	return s3c_init_intc_of(np, interrupt_parent,
> +				s3c2416_ctrl, ARRAY_SIZE(s3c2416_ctrl));
> +}
> +IRQCHIP_DECLARE(s3c2416_irq, "samsung,s3c2416-irq", s3c2416_init_intc_of);
> +#endif
> 
