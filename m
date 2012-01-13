From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 12 Jan 2012 19:29:32 -0700
Subject: [PATCH 1/2] versatile: sic: add device tree bindings
In-Reply-To: <1326415441-17695-2-git-send-email-jamie@jamieiles.com>
References: <1326415441-17695-1-git-send-email-jamie@jamieiles.com>
 <1326415441-17695-2-git-send-email-jamie@jamieiles.com>
Message-ID: <20120113022932.GB25999@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 13, 2012 at 12:44:00AM +0000, Jamie Iles wrote:
> Add a device tree binding for the FPGA SIC on versatile platforms.  This
> also requires the addition of irq domain support for mapping to Linux
> IRQs.
> 
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Jamie Iles <jamie@jamieiles.com>
> ---
>  .../devicetree/bindings/arm/versatile-sic.txt      |   27 ++++++++++
>  arch/arm/plat-versatile/Kconfig                    |    1 +
>  arch/arm/plat-versatile/fpga-irq.c                 |   51 +++++++++++++++++++-
>  arch/arm/plat-versatile/include/plat/fpga-irq.h    |    6 ++
>  4 files changed, 83 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/versatile-sic.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/versatile-sic.txt b/Documentation/devicetree/bindings/arm/versatile-sic.txt
> new file mode 100644
> index 0000000..971a42e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/versatile-sic.txt
> @@ -0,0 +1,27 @@
> +* ARM Versatile FPGA Secondary Interrupt Controller
> +
> +The SIC is an interrupt controller embedded in an FPGA found on ARM versatile
> +platforms.
> +
> +Required properties:
> +
> +- compatible : "arm,versatile-sic"
> +- interrupt-controller : Identifies the node as an interrupt controller
> +- #interrupt-cells : The number of cells to define the interrupts.  Must be 1 as
> +  the SIC has no configuration options for interrupt sources.  The cell is a u32
> +  and defines the interrupt number.
> +- reg : The register bank for the VIC.
> +- interrupt-parent : The interrupt controller that IRQ's are cascaded to.
> +- interrupts : Interrupt source for the interrupt that SIC IRQs are routed to
> +  in the primary interrupt controller.
> +
> +Example:
> +
> +	sic: intc at 10003000 {
> +		compatible = "arm,versatile-sic";
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +		reg = <0x10003000 0x1000>;
> +		interrupt-parent = <&vic>;
> +		interrupts = <31>;
> +	};
> diff --git a/arch/arm/plat-versatile/Kconfig b/arch/arm/plat-versatile/Kconfig
> index 52353be..a07ffe5 100644
> --- a/arch/arm/plat-versatile/Kconfig
> +++ b/arch/arm/plat-versatile/Kconfig
> @@ -4,6 +4,7 @@ config PLAT_VERSATILE_CLCD
>  	bool
>  
>  config PLAT_VERSATILE_FPGA_IRQ
> +	select IRQ_DOMAIN

My plan is to select this from CONFIG_ARM, and that is what is in the
irqdomain/next branch.

>  	bool
>  
>  config PLAT_VERSATILE_LEDS
> diff --git a/arch/arm/plat-versatile/fpga-irq.c b/arch/arm/plat-versatile/fpga-irq.c
> index f0cc8e1..fd87b06 100644
> --- a/arch/arm/plat-versatile/fpga-irq.c
> +++ b/arch/arm/plat-versatile/fpga-irq.c
> @@ -2,7 +2,13 @@
>   *  Support for Versatile FPGA-based IRQ controllers
>   */
>  #include <linux/irq.h>
> +#include <linux/irqdomain.h>
>  #include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/slab.h>
>  
>  #include <asm/mach/irq.h>
>  #include <plat/fpga-irq.h>
> @@ -15,7 +21,7 @@
>  static void fpga_irq_mask(struct irq_data *d)
>  {
>  	struct fpga_irq_data *f = irq_data_get_irq_chip_data(d);
> -	u32 mask = 1 << (d->irq - f->irq_start);
> +	u32 mask = 1 << d->hwirq;
>  
>  	writel(mask, f->base + IRQ_ENABLE_CLEAR);
>  }
> @@ -23,7 +29,7 @@ static void fpga_irq_mask(struct irq_data *d)
>  static void fpga_irq_unmask(struct irq_data *d)
>  {
>  	struct fpga_irq_data *f = irq_data_get_irq_chip_data(d);
> -	u32 mask = 1 << (d->irq - f->irq_start);
> +	u32 mask = 1 << d->hwirq;
>  
>  	writel(mask, f->base + IRQ_ENABLE_SET);
>  }

fpga_irq_handle() also needs to be modified to call irq_find_mapping()
to translate from the hwirq to the linux number.  There should be no
references to irq_start after migrating to use irq_domain.

> @@ -53,6 +59,10 @@ void __init fpga_irq_init(int parent_irq, u32 valid, struct fpga_irq_data *f)
>  	f->chip.irq_ack = fpga_irq_mask;
>  	f->chip.irq_mask = fpga_irq_mask;
>  	f->chip.irq_unmask = fpga_irq_unmask;
> +	f->domain.irq_base = f->irq_start;
> +	f->domain.nr_irq = 32;
> +	f->domain.ops = &irq_domain_simple_ops;
> +	irq_domain_add(&f->domain);
>  
>  	if (parent_irq != -1) {
>  		irq_set_handler_data(parent_irq, f);
> @@ -70,3 +80,40 @@ void __init fpga_irq_init(int parent_irq, u32 valid, struct fpga_irq_data *f)
>  		}
>  	}
>  }

There is a loop in fpga_irq_init() that sets up all the irqs, but with
the introduction of the full irq_domain, that can be moved out to the
.map irq_domain ops function.  The irq_domain will call it to set up
each irq when it is requested.

> +
> +#ifdef CONFIG_OF
> +int __init sic_of_init(struct device_node *np, struct device_node *parent)
> +{
> +	struct fpga_irq_data *sic_data = kzalloc(sizeof(*sic_data), GFP_KERNEL);
> +	int err = -ENOMEM, irq;
> +
> +	if (WARN_ON(!sic_data))
> +		return err;
> +
> +	sic_data->base = of_iomap(np, 0);
> +	if (WARN_ON(!sic_data->base))
> +		goto out_free_data;
> +
> +	irq = irq_of_parse_and_map(np, 0);
> +	if (irq < 0)
> +		goto out_free_data;
> +
> +	sic_data->irq_start = irq_alloc_descs(-1, 0, 32, numa_node_id());
> +	if (WARN_ON(sic_data->irq_start < 0)) {
> +		err = sic_data->irq_start;
> +		goto out_unmap;
> +	}
> +	sic_data->domain.of_node = of_node_get(np);
> +
> +	fpga_irq_init(irq, ~0, sic_data);
> +
> +	return 0;
> +
> +out_unmap:
> +	iounmap(sic_data->base);
> +out_free_data:
> +	kfree(sic_data);
> +
> +	return err;
> +}
> +#endif /* CONFIG_OF */
> diff --git a/arch/arm/plat-versatile/include/plat/fpga-irq.h b/arch/arm/plat-versatile/include/plat/fpga-irq.h
> index 627fafd..a1391f3 100644
> --- a/arch/arm/plat-versatile/include/plat/fpga-irq.h
> +++ b/arch/arm/plat-versatile/include/plat/fpga-irq.h
> @@ -1,12 +1,18 @@
>  #ifndef PLAT_FPGA_IRQ_H
>  #define PLAT_FPGA_IRQ_H
>  
> +#include <linux/irqdomain.h>
> +
> +struct device_node;
> +
>  struct fpga_irq_data {
>  	void __iomem *base;
>  	unsigned int irq_start;
>  	struct irq_chip chip;
> +	struct irq_domain domain;
>  };
>  
>  void fpga_irq_init(int, u32, struct fpga_irq_data *);
> +int sic_of_init(struct device_node *np, struct device_node *parent);
>  
>  #endif
> -- 
> 1.7.5.4
> 
