From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 25 Jul 2011 14:04:34 -0600
Subject: [PATCH 1/3] vic: add device tree bindings
In-Reply-To: <1311610200-12408-2-git-send-email-jamie@jamieiles.com>
References: <1311610200-12408-1-git-send-email-jamie@jamieiles.com>
	<1311610200-12408-2-git-send-email-jamie@jamieiles.com>
Message-ID: <20110725200434.GB26735@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 25, 2011 at 05:09:58PM +0100, Jamie Iles wrote:
> Allow the VIC to be used from device tree.  This adds vic_of_init() that
> finds all compatible controllers in the device tree creating irq domains
> and initialising the VIC.
> 
> We use of_iomap() for the IO mapping, but allow the entry functions in
> arch/arm/include/asm/entry-macro-vic2.S to be used, this requires that a
> static mapping is configured on the platform.
> 
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: devicetree-discuss at lists.ozlabs.org
> Signed-off-by: Jamie Iles <jamie@jamieiles.com>
> ---
>  Documentation/devicetree/bindings/arm/vic.txt |   21 +++++++++++++++

Yay!  Thanks for documenting!

>  arch/arm/common/vic.c                         |   35 +++++++++++++++++++++++++
>  arch/arm/include/asm/hardware/vic.h           |    5 +++
>  3 files changed, 61 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/vic.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/vic.txt b/Documentation/devicetree/bindings/arm/vic.txt
> new file mode 100644
> index 0000000..be5abc9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/vic.txt
> @@ -0,0 +1,21 @@
> +ARM Vectored Interrupt Controller
> +
> +Some ARM cores may contain a vectored interrupt controller (VIC).  This
> +controller is represented in the device tree with:
> +
> +Required properties:
> +  - #interrupt-cells : <1> (32 interrupt sources supported)

Does the vic have any configuration for level/edge or polarity?

> +  - compatible : "arm,pl190-vic", "arm,pl192-vic", "arm-vic"

drop "arm-vic".  Compatible values should always be specific to an
implementation, preferably to a specific version of hardware, although
I'm also okay with an IP core name if the version if the core is
provided.

> +  - reg : Offset and length of the register set for this device
> +  - interrupt-controller
> +  - irq-start : The first interrupt number that the VIC services

Drop irq-start, it should not be needed.  The interrupt controller
should allocate its own range of irq numbers when it is set up.

> +
> +Example ARM VIC node:
> +
> +vic0 at 60000 {
> +	compatible = "arm,pl192-vic";
> +	interrupt-controller;
> +	reg = <0x60000 0x1000>;
> +	irq-start = <32>;
> +	#interrupt-cells = <1>;
> +};
> diff --git a/arch/arm/common/vic.c b/arch/arm/common/vic.c
> index 7aa4262..5838b9f 100644
> --- a/arch/arm/common/vic.c
> +++ b/arch/arm/common/vic.c
> @@ -25,6 +25,9 @@
>  #include <linux/syscore_ops.h>
>  #include <linux/device.h>
>  #include <linux/amba/bus.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
>  
>  #include <asm/mach/irq.h>
>  #include <asm/hardware/vic.h>
> @@ -377,3 +380,35 @@ void __init vic_init(void __iomem *base, unsigned int irq_start,
>  
>  	vic_pm_register(base, irq_start, resume_sources);
>  }
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id arm_vic_ids[] __initconst = {
> +	{ .compatible = "arm,pl190-vic" },
> +	{ .compatible = "arm,pl192-vic" },
> +	{ .compatible = "arm,vic" },
> +	{},
> +};
> +
> +void __init vic_of_init(void)
> +{
> +	struct device_node *np;
> +
> +	for_each_matching_node(np, arm_vic_ids) {
> +		void __iomem *iobase;
> +		u32 base_irq;
> +
> +		iobase = of_iomap(np, 0);
> +
> +		if (!iobase)
> +			panic("Unable to map VIC");

If you WARN here instead, then there is a much greater chance of
actually getting output to the user.

> +
> +		if (of_property_read_u32(np, "irq-start", &base_irq))
> +			panic("No irq-start property defined");
> +
> +		of_node_put(np);
> +
> +		vic_init(iobase, base_irq, ~0, 0);
> +		irq_domain_add_simple(np, base_irq);

irq_domain_add_simple() is a stop-gap shortcut for interrupt
controllers that don't use irq_domain directly.  I'm okay with doing
this in the short term, but I imagine it will want to change in the
near future to take advantage of hw->linux irq translation provided by
irq_domain when it matures.

> +	}

I think that rather than writing a interrupt-controller-specific
parse route like this one, it would be much better to have a generic
helper that finds and sorts all the interrupt controllers before
calling a setup callback for each one.

> +}
> +#endif /* CONFIG_OF */
> diff --git a/arch/arm/include/asm/hardware/vic.h b/arch/arm/include/asm/hardware/vic.h
> index 5d72550..dbda2d1 100644
> --- a/arch/arm/include/asm/hardware/vic.h
> +++ b/arch/arm/include/asm/hardware/vic.h
> @@ -42,6 +42,11 @@
>  
>  #ifndef __ASSEMBLY__
>  void vic_init(void __iomem *base, unsigned int irq_start, u32 vic_sources, u32 resume_sources);
> +#ifdef CONFIG_OF
> +void vic_of_init(void);
> +#else /* CONFIG_OF */
> +static inline void vic_of_init(void) {}
> +#endif /* CONFIG_OF */
>  #endif
>  
>  #endif
> -- 
> 1.7.4.1
> 
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss at lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
