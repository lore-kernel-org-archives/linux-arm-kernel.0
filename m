From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 13 Jun 2011 10:53:16 -0600
Subject: [PATCH 2/3] ARM: gic: add OF based initialization
In-Reply-To: <1307456541-11026-3-git-send-email-robherring2@gmail.com>
References: <1307456541-11026-1-git-send-email-robherring2@gmail.com>
	<1307456541-11026-3-git-send-email-robherring2@gmail.com>
Message-ID: <20110613165316.GF18161@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 07, 2011 at 09:22:20AM -0500, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> This adds gic initialization using device tree data. An example device tree
> binding looks like this:
> 
> intc: interrupt-controller at fff11000 {
>         compatible = "arm,cortex-a9-gic";
>         #interrupt-cells = <1>;
>         interrupt-controller;
>         reg = <0xfff11000 0x1000>,
>               <0xfff10100 0x100>;
>         irq-start = <29>;
> };
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> ---
>  Documentation/devicetree/bindings/arm/gic.txt |   31 +++++++++++++++++++++
>  arch/arm/common/gic.c                         |   36 +++++++++++++++++++++++++
>  arch/arm/include/asm/hardware/gic.h           |    1 +
>  3 files changed, 68 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/gic.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/gic.txt b/Documentation/devicetree/bindings/arm/gic.txt
> new file mode 100644
> index 0000000..491a503
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/gic.txt
> @@ -0,0 +1,31 @@
> +* ARM Generic Interrupt Controller
> +
> +Some ARM cores have an interrupt controller called GIC. The ARM GIC
> +representation in the device tree should be done as under:-
> +
> +Required properties:
> +
> +- compatible : should be one of:
> +	"arm,cortex-a9-gic"
> +	"arm,arm11mp-gic"
> +	"nvidia,tegra250-gic"

This doesn't match the implementation in this patch.  The
implementation only matches against the cortex-a9 gic.

Also, I expect that the gic is different between the arm,cortex-a9-gic
and the arm,arm11-mp-gic.  Is the tegra also a different gic
implementation?  Or can it be expected that the tegra gic will simply
claim compatibility with the a9 gic?

> +- interrupt-controller : Identifies the node as an interrupt controller
> +- #interrupt-cells : Specifies the number of cells needed to encode an
> +  interrupt source.  The type shall be a <u32> and the value shall be 1.
> +- reg : Specifies base physical address(s) and size of the GIC registers. The
> +  first 2 values are the GIC distributor register base and size. The 2nd 2
> +  values are the GIC cpu interface register base and size.
> +- irq-start : The first actual interrupt that is connected to h/w.

Drop irq-start.  That's a Linux internal implementation detail, and
Linux can easily handle dynamic assignment of irq ranges.

If board support code still has special needs on specific platforms,
then we can manually override the assigned range for that specific
platform only as a short term workaround.

> +
> +Example:
> +
> +intc: interrupt-controller at fff11000 {
> +        compatible = "arm,cortex-a9-gic";
> +        #interrupt-cells = <1>;
> +        interrupt-controller;
> +        reg = <0xfff11000 0x1000>,
> +              <0xfff10100 0x100>;
> +        irq-start = <29>;
> +};
> +
> +
> diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
> index 4ddd0a6..024414d 100644
> --- a/arch/arm/common/gic.c
> +++ b/arch/arm/common/gic.c
> @@ -28,6 +28,8 @@
>  #include <linux/smp.h>
>  #include <linux/cpumask.h>
>  #include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
>  
>  #include <asm/irq.h>
>  #include <asm/mach/irq.h>
> @@ -401,3 +403,37 @@ void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
>  	writel_relaxed(map << 16 | irq, gic_data[0].dist_base + GIC_DIST_SOFTINT);
>  }
>  #endif
> +
> +#ifdef CONFIG_OF
> +static struct of_device_id gic_ids[] __initdata = {
> +	{ .compatible = "arm,cortex-a9-gic" },
> +};
> +
> +void __init gic_of_init(void)
> +{
> +	struct device_node *np;
> +	void __iomem *cpu_base;
> +	void __iomem *dist_base;
> +	__u32 irq_start = 16;
> +	const __be32 *val;
> +
> +	np = of_find_matching_node(NULL, gic_ids);
> +	if (!np)
> +		panic("unable to find compatible gic node in dtb\n");
> +
> +	dist_base = of_iomap(np, 0);
> +	if (!dist_base)
> +		panic("unable to map gic dist registers\n");
> +
> +	cpu_base = of_iomap(np, 1);
> +	if (!cpu_base)
> +		panic("unable to map gic cpu registers\n");
> +
> +	val = of_get_property(np, "irq-start", NULL);
> +	if (val != NULL)
> +		irq_start = of_read_ulong(val, 1);
> +	of_node_put(np);
> +
> +	gic_init(0, irq_start, dist_base, cpu_base);

This can only handle a single gic in a system.  This is a start, but
multiple interrupt controllers must be supported, like for the Samsung
socs.

I've been toying with writing some code that walks the interrupt
controller tree, finds the root controller, and then sets up each
child controller as a cascade.

> +}
> +#endif
> diff --git a/arch/arm/include/asm/hardware/gic.h b/arch/arm/include/asm/hardware/gic.h
> index 0691f9d..954a08e 100644
> --- a/arch/arm/include/asm/hardware/gic.h
> +++ b/arch/arm/include/asm/hardware/gic.h
> @@ -37,6 +37,7 @@ extern void __iomem *gic_cpu_base_addr;
>  extern struct irq_chip gic_arch_extn;
>  
>  void gic_init(unsigned int, unsigned int, void __iomem *, void __iomem *);
> +void gic_of_init(void);
>  void gic_secondary_init(unsigned int);
>  void gic_cascade_irq(unsigned int gic_nr, unsigned int irq);
>  void gic_raise_softirq(const struct cpumask *mask, unsigned int irq);
> -- 
> 1.7.4.1
> 
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss at lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
