From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 22 Mar 2013 20:55:57 +0000
Subject: [PATCH v4 5/5] irqchip: s3c24xx: add devicetree support
In-Reply-To: <201303221846.46473.heiko@sntech.de>
References: <201303221843.37668.heiko@sntech.de>
 <201303221846.46473.heiko@sntech.de>
Message-ID: <201303222055.57400.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 22 March 2013, Heiko St?bner wrote:
> +	interrupt-controller at 4a000000 {
> +		compatible = "samsung,s3c24xx-irq";
> +		reg = <0x4a000000 0x100>;
> +		interrupt-controller;
> +
> +		intc:intc {
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +
> +		subintc:subintc {
> +			interrupt-controller;
> +			#interrupt-cells = <3>;
> +		};
> +	};

I think this is not a comformant binding because the parent node
is marked "interrupt-controller" but does not itself have a
#interrupt-cells property.

One way to resolve this would probably be to fold the sub-nodes into
the parent and always use #interrupt-cells = <3> or maybe <4>
so you can identify which sub-node the interrupt is meant for.

Also, I think you are missing a description of what the two or
three cells represent.

> +static int s3c_irq_xlate_subintc(struct irq_domain *d, struct device_node *n,
> +			const u32 *intspec, unsigned int intsize,
> +			irq_hw_number_t *out_hwirq, unsigned int *out_type)
> +{
> +	struct s3c_irq_intc *intc = d->host_data;
> +	struct s3c_irq_intc *parent_intc = intc->parent;
> +	struct s3c_irq_data *irq_data = &intc->irqs[intspec[0]];
> +	struct s3c_irq_data *parent_irq_data;
> +
> +	int irqno;
> +
> +	if (WARN_ON(intsize < 3))
> +		return -EINVAL;
> +
> +	*out_hwirq = intspec[0];
> +	*out_type = intspec[1] & IRQ_TYPE_SENSE_MASK;
> +
> +	irqno = irq_create_mapping(parent_intc->domain, intspec[2]);
> +	if (irqno < 0) {
> +		pr_err("irq: could not map parent interrupt\n");
> +		return irqno;
> +	}

So the third cell in this is the interrupt number of the main controller
that the irq cascades into, while the first cell is the number of the
cascaded controller, correct?

If you want to fold everything into one node, it's probably best to
put the irq number of the main controller into the first cell all the
time, and use the second cell to describe the number in the second cell.

The alternative would be to have three completely separate nodes,
and then you can describe the parent-child relationship like

intc: interrupt-controller at 4a000000 {
	compatible = "samsung,s3c2416-intc";
	reg = <0x4a000000 0x18>;
	interrupt-controller;
	#interrupt-cells = <2>;
};

subintc: interrupt-controller at 4a000018 {
	compatible = "samsung,s3c2416-subintc";
	reg = <0x4a000018 0x28>;
	interrupt-controller;
	#interrupt-cells = <3>;
	interrupt-parent = <&intc>;
	interrupts  = <28 0>, <23 0>, <15 0>, <31 0>, <16 0>, <17 0>, <18 0>, <9 0>;
};

       serial at 50000000 {
               compatible = "samsung,s3c2410-uart";
               reg = <0x50000000 0x4000>;
               interrupt-parent = <&subintc>;
               interrupts = <0 0 4>, /* first interrupt, first parent, level */
			    <1 0 4>; /* second interrupt, first parent, level */
       };

       serial at 51000000 {
               compatible = "samsung,s3c2410-uart";
               reg = <0x51000000 0x4000>;
               interrupt-parent = <&subintc>;
               interrupts = <0 1 4>, /* first interrupt, second parent, level */
			    <1 1 4>; /* second interrupt, second parent, level */
       };




	Arnd
