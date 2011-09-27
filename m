From: robherring2@gmail.com (Rob Herring)
Date: Tue, 27 Sep 2011 08:30:43 -0500
Subject: [PATCH 1/2] ARM: vic: device tree binding
In-Reply-To: <1317125802-14386-1-git-send-email-jamie@jamieiles.com>
References: <1317125802-14386-1-git-send-email-jamie@jamieiles.com>
Message-ID: <4E81D003.4040501@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/27/2011 07:16 AM, Jamie Iles wrote:
> This adds a device tree binding for the VIC based on the of_irq_init()
> support.
> 
> Cc: Rob Herring <robherring2@gmail.com>
> Signed-off-by: Jamie Iles <jamie@jamieiles.com>
> ---
>  Documentation/devicetree/bindings/arm/vic.txt |   29 ++++++
>  arch/arm/common/vic.c                         |  121 ++++++++++++++++++++-----
>  arch/arm/include/asm/hardware/vic.h           |   13 +++-
>  3 files changed, 137 insertions(+), 26 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/vic.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/vic.txt b/Documentation/devicetree/bindings/arm/vic.txt
> new file mode 100644
> index 0000000..266716b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/vic.txt
> @@ -0,0 +1,29 @@
> +* ARM Vectored Interrupt Controller
> +
> +One or more Vectored Interrupt Controllers (VIC's) can be connected in an ARM
> +system for interrupt routing.  For multiple controllers they can either be
> +nested or have the outputs wire-OR'd together.
> +
> +Required properties:
> +
> +- compatible : should be one of
> +	"arm,pl190-vic"
> +	"arm,pl192-vic"
> +- interrupt-controller : Identifies the node as an interrupt controller
> +- #interrupt-cells : The number of cells to define the interrupts.  Must be 1 as
> +  the VIC has no configuration options for interrupt sources.  The cell is a u32
> +  and defines the interrupt number.
> +- reg : The register bank for the VIC.
> +
> +Optional properties:
> +
> +- interrupts : Interrupt source for parent controllers if the VIC is nested.
> +
> +Example:
> +
> +	vic0: interrupt-controller at 60000 {
> +		compatible = "arm,pl192-vic";
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +		reg = <0x60000 0x1000>;
> +	};
> diff --git a/arch/arm/common/vic.c b/arch/arm/common/vic.c
> index 7aa4262..3658579 100644
> --- a/arch/arm/common/vic.c
> +++ b/arch/arm/common/vic.c
> @@ -22,6 +22,10 @@
>  #include <linux/init.h>
>  #include <linux/list.h>
>  #include <linux/io.h>
> +#include <linux/irqdomain.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
>  #include <linux/syscore_ops.h>
>  #include <linux/device.h>
>  #include <linux/amba/bus.h>
> @@ -29,7 +33,6 @@
>  #include <asm/mach/irq.h>
>  #include <asm/hardware/vic.h>
>  
> -#ifdef CONFIG_PM
>  /**
>   * struct vic_device - VIC PM device
>   * @irq: The IRQ number for the base of the VIC.
> @@ -50,13 +53,15 @@ struct vic_device {
>  	u32		int_enable;
>  	u32		soft_int;
>  	u32		protect;
> +#ifdef CONFIG_IRQ_DOMAIN
> +	struct irq_domain domain;
> +#endif /* CONFIG_IRQ_DOMAIN */
>  };
>  
>  /* we cannot allocate memory when VICs are initially registered */
>  static struct vic_device vic_devices[CONFIG_ARM_VIC_NR];
>  
>  static int vic_id;
> -#endif /* CONFIG_PM */
>  
>  /**
>   * vic_init2 - common initialisation code
> @@ -156,9 +161,10 @@ static int __init vic_pm_init(void)
>  	return 0;
>  }
>  late_initcall(vic_pm_init);
> +#endif /* CONFIG_PM */
>  
>  /**
> - * vic_pm_register - Register a VIC for later power management control
> + * vic_register - Register a VIC.
>   * @base: The base address of the VIC.
>   * @irq: The base IRQ for the VIC.
>   * @resume_sources: bitmask of interrupts allowed for resume sources.
> @@ -166,24 +172,28 @@ late_initcall(vic_pm_init);
>   * Register the VIC with the system device tree so that it can be notified
>   * of suspend and resume requests and ensure that the correct actions are
>   * taken to re-instate the settings on resume.
> + *
> + * We return the VIC so that it can be used for IRQ domain operations for
> + * device tree translation.
>   */
> -static void __init vic_pm_register(void __iomem *base, unsigned int irq, u32 resume_sources)
> +static struct vic_device * __init
> +vic_register(void __iomem *base, unsigned int irq, u32 resume_sources)
>  {
>  	struct vic_device *v;
>  
> -	if (vic_id >= ARRAY_SIZE(vic_devices))
> +	if (vic_id >= ARRAY_SIZE(vic_devices)) {
>  		printk(KERN_ERR "%s: too few VICs, increase CONFIG_ARM_VIC_NR\n", __func__);
> -	else {
> -		v = &vic_devices[vic_id];
> -		v->base = base;
> -		v->resume_sources = resume_sources;
> -		v->irq = irq;
> -		vic_id++;
> +		return NULL;
>  	}
> +
> +	v = &vic_devices[vic_id];
> +	v->base = base;
> +	v->resume_sources = resume_sources;
> +	v->irq = irq;
> +	vic_id++;
> +
> +	return v;
>  }
> -#else
> -static inline void vic_pm_register(void __iomem *base, unsigned int irq, u32 arg1) { }
> -#endif /* CONFIG_PM */
>  
>  static void vic_ack_irq(struct irq_data *d)
>  {
> @@ -331,15 +341,9 @@ static void __init vic_init_st(void __iomem *base, unsigned int irq_start,
>  	vic_set_irq_sources(base, irq_start, vic_sources);
>  }
>  
> -/**
> - * vic_init - initialise a vectored interrupt controller
> - * @base: iomem base address
> - * @irq_start: starting interrupt number, must be muliple of 32
> - * @vic_sources: bitmask of interrupt sources to allow
> - * @resume_sources: bitmask of interrupt sources to allow for resume
> - */
> -void __init vic_init(void __iomem *base, unsigned int irq_start,
> -		     u32 vic_sources, u32 resume_sources)
> +static struct vic_device * __init
> +__vic_init(void __iomem *base, unsigned int irq_start, u32 vic_sources,
> +	   u32 resume_sources)
>  {
>  	unsigned int i;
>  	u32 cellid = 0;
> @@ -357,7 +361,7 @@ void __init vic_init(void __iomem *base, unsigned int irq_start,
>  	switch(vendor) {
>  	case AMBA_VENDOR_ST:
>  		vic_init_st(base, irq_start, vic_sources);
> -		return;
> +		return NULL;
>  	default:
>  		printk(KERN_WARNING "VIC: unknown vendor, continuing anyways\n");
>  		/* fall through */
> @@ -375,5 +379,72 @@ void __init vic_init(void __iomem *base, unsigned int irq_start,
>  
>  	vic_set_irq_sources(base, irq_start, vic_sources);
>  
> -	vic_pm_register(base, irq_start, resume_sources);
> +	return vic_register(base, irq_start, resume_sources);
>  }
> +
> +/**
> + * vic_init - initialise a vectored interrupt controller
> + * @base: iomem base address
> + * @irq_start: starting interrupt number, must be muliple of 32
> + * @vic_sources: bitmask of interrupt sources to allow
> + * @resume_sources: bitmask of interrupt sources to allow for resume
> + */
> +void __init vic_init(void __iomem *base, unsigned int irq_start,
> +		     u32 vic_sources, u32 resume_sources)
> +{
> +	__vic_init(base, irq_start, vic_sources, resume_sources);
> +}
> +
> +#ifdef CONFIG_OF
> +static int
> +vic_irq_domain_dt_translate(struct irq_domain *d, struct device_node *np,
> +			    const u32 *intspec, unsigned int intsize,
> +			    unsigned long *out_hwirq, unsigned int *out_type)
> +{
> +	if (d->of_node != np)
> +		return -EINVAL;
> +	if (intsize < 1)
> +		return -EINVAL;
> +
> +	*out_hwirq = intspec[0];
> +	*out_type = IRQ_TYPE_NONE;
> +
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops vic_irq_domain_ops = {
> +	.dt_translate = vic_irq_domain_dt_translate,
> +};

You should be able to use the simple ops here. You'll need this patch if
you don't already have it:

https://lkml.org/lkml/2011/9/14/189

> +
> +int __init vic_of_init(struct device_node *node, struct device_node *parent)
> +{
> +	void __iomem *regs = of_iomap(node, 0);
> +	struct vic_device *vic;
> +	int irq_base;
> +
> +	if (WARN_ON(!regs))
> +		return -EIO;
> +
> +	irq_base = irq_alloc_descs(-1, 0, 32, numa_node_id());
> +	if (WARN_ON(irq_base < 0))
> +		goto out_unmap;
> +
> +	vic = __vic_init(regs, irq_base, ~0, ~0);
> +	if (WARN_ON(!vic))
> +		goto out_unmap;
> +
> +	vic->domain.irq_base = irq_base;
> +	vic->domain.nr_irq = 32;
> +	vic->domain.of_node = of_node_get(node);
> +	vic->domain.ops = &vic_irq_domain_ops;
> +	irq_domain_add(&vic->domain);
> +
> +	return 0;
> +
> +out_unmap:
> +	iounmap(regs);
> +
> +	return -EIO;
> +}
> +
> +#endif /* CONFIG OF */
> diff --git a/arch/arm/include/asm/hardware/vic.h b/arch/arm/include/asm/hardware/vic.h
> index 5d72550..df1d895 100644
> --- a/arch/arm/include/asm/hardware/vic.h
> +++ b/arch/arm/include/asm/hardware/vic.h
> @@ -41,7 +41,18 @@
>  #define VIC_PL192_VECT_ADDR		0xF00
>  
>  #ifndef __ASSEMBLY__
> +struct device_node;
>  void vic_init(void __iomem *base, unsigned int irq_start, u32 vic_sources, u32 resume_sources);
> -#endif
> +
> +#ifdef CONFIG_OF
> +int vic_of_init(struct device_node *node, struct device_node *parent);
> +#else /* CONFIG_OF */
> +static inline int vic_of_init(struct device_node *node,
> +			      struct device_node *parent)
> +{
> +	return -ENOSYS;

I'm doing ENODEV here for gic. We should be consistent. Which is right?

Rob
