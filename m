From: robherring2@gmail.com (Rob Herring)
Date: Thu, 11 Aug 2011 22:02:31 -0500
Subject: [RFC PATCH] ARM: gic: add OF based initialization
In-Reply-To: <4E438B17.10907@arm.com>
References: <1313007324-23194-1-git-send-email-robherring2@gmail.com>
	<4E438B17.10907@arm.com>
Message-ID: <4E4497C7.2010304@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc,

On 08/11/2011 02:56 AM, Marc Zyngier wrote:
> Hi Rob,
> 
> Thanks for looking at this.
> 
> On 10/08/11 21:15, Rob Herring wrote:
>> From: Rob Herring <rob.herring@calxeda.com>
>>
>> This adds gic initialization using device tree data. An example device tree
>> binding looks like this:
>>
>> intc: interrupt-controller at fff11000 {
>>         compatible = "arm,cortex-a9-gic";
>>         #interrupt-cells = <1>;
> 
> The SPI interrupt can either be level-high or edge-rising. So you
> probably want #interrupt-cells to be equal to 2...
> 
>> 	#size-cells = <0>;
>> 	#address-cells = <1>;
>>
>>         interrupt-controller;
>>         reg = <0xfff11000 0x1000>,
>>               <0xfff10100 0x100>;
>>
>> 	gicppi0: gic-ppi at 0 {
>> 		compatible = "arm,cortex-a9-gic-ppi";
>> 		#interrupt-cells = <1>;
>> 		interrupt-controller;
>> 		reg = <0>;
>> 	};
>> 	gicppi1: gic-ppi at 1 {
>> 		compatible = "arm,cortex-a9-gic-ppi";
>> 		#interrupt-cells = <1>;
>> 		interrupt-controller;
>> 		reg = <1>;
>> 	};
>> };
>>
>> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
>> ---
>>
>> Marc,
>>
>> This adds PPI handling. I took your binding and modified it a bit to make
>> things a bit simpler for the linux side. Rather than having SPIs as a 
>> child node, I kept them at the parent node. Then PPIs are optional child
>> nodes. This way, a secondary GIC is no more complex than a simple
>> interrupt controller.
> 
> Maybe it's not a real problem, but this makes PPIs a sort of "cascaded"
> interrupt controller, which I find rather misleading. In reality, there
> is no hierarchy between SPIs and PPIs.

It's only the DT nodes that are cascaded. The interrupts are not.

> 
> Is it legal for an interrupt controller to have an interrupt controller
> as a parent, without an interrupt number? How will irq_of_parse_and_map
> react to this? I'm quite sure of_irq_find_parent(ppi) will return the
> wrong thing (the SPI controller).

I wondered this a bit at first, but it seems to work. I did some more
testing and in fact of_irq_find_parent behaves fine. It looks for either
a phandle or parent node with #interrupt-cells property. I'm not quite
sure why the #interrupt-cells property is not found in this case.

This code plus printk's added to of_irq_find_parent:

	desc.controller = of_find_compatible_node(NULL, NULL, "arm,cortex-a9-gic");
	gic_of_init(&desc);
	node = desc.controller;
	printk("interrupt-parent = %p\n", of_irq_find_parent(node));
	for_each_child_of_node(node, desc.controller) {
		printk("interrupt-parent = %p\n", of_irq_find_parent(node));
		gic_of_ppi_init(&desc);
	}

produces this:

[    0.000000] p = c1b2007c, get_prop=  (null)
[    0.000000] p =   (null), get_prop=  (null)
[    0.000000] interrupt-parent =   (null)
[    0.000000] p = c1b2007c, get_prop=  (null)
[    0.000000] p =   (null), get_prop=  (null)
[    0.000000] interrupt-parent =   (null)
[    0.000000] p = c1b2007c, get_prop=  (null)
[    0.000000] p =   (null), get_prop=  (null)
[    0.000000] interrupt-parent =   (null)

So of_irq_find_parent is returning null in all 3 cases which is what is
desired.

Rob

> 
>> The PPI init simply creates an irqdomain for each cpu interface. By using 
>> a domain per PPI and SPI, the translation is simple. The domain irq_base
>> is always 0, so PPI # is always equal to linux irq number. This can be
>> changed if the linux irq numbering of PPI's changes, but that should not
>> affect the binding.
>>
>> The documentation still needs updating.
>>
>> Rob
>>
>>  Documentation/devicetree/bindings/arm/gic.txt |   28 +++++++++++++++++
>>  arch/arm/common/gic.c                         |   40 +++++++++++++++++++++++++
>>  arch/arm/include/asm/hardware/gic.h           |    3 ++
>>  3 files changed, 71 insertions(+), 0 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/arm/gic.txt
>>
>> diff --git a/Documentation/devicetree/bindings/arm/gic.txt b/Documentation/devicetree/bindings/arm/gic.txt
>> new file mode 100644
>> index 0000000..78012e3
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/gic.txt
>> @@ -0,0 +1,28 @@
>> +* ARM Generic Interrupt Controller
>> +
>> +Some ARM cores have an interrupt controller called GIC. The ARM GIC
>> +representation in the device tree should be done as under:-
>> +
>> +Required properties:
>> +
>> +- compatible : should be one of:
>> +	"arm,cortex-a9-gic"
>> +	"arm,arm11mp-gic"
>> +- interrupt-controller : Identifies the node as an interrupt controller
>> +- #interrupt-cells : Specifies the number of cells needed to encode an
>> +  interrupt source.  The type shall be a <u32> and the value shall be 1.
>> +- reg : Specifies base physical address(s) and size of the GIC registers. The
>> +  first 2 values are the GIC distributor register base and size. The 2nd 2
>> +  values are the GIC cpu interface register base and size.
>> +
>> +Example:
>> +
>> +intc: interrupt-controller at fff11000 {
>> +        compatible = "arm,cortex-a9-gic";
>> +        #interrupt-cells = <1>;
>> +        interrupt-controller;
>> +        reg = <0xfff11000 0x1000>,
>> +              <0xfff10100 0x100>;
>> +};
>> +
>> +
>> diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
>> index f13298e..b0f11b3 100644
>> --- a/arch/arm/common/gic.c
>> +++ b/arch/arm/common/gic.c
>> @@ -28,6 +28,10 @@
>>  #include <linux/smp.h>
>>  #include <linux/cpumask.h>
>>  #include <linux/io.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_irq.h>
>> +#include <linux/irqdomain.h>
>>  
>>  #include <asm/irq.h>
>>  #include <asm/mach/irq.h>
>> @@ -394,3 +398,39 @@ void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
>>  	writel_relaxed(map << 16 | irq, gic_data[0].dist_base + GIC_DIST_SOFTINT);
>>  }
>>  #endif
>> +
>> +#ifdef CONFIG_OF
>> +static int gic_cnt __initdata = 0;
>> +
>> +void __init gic_of_init(struct of_intc_desc *d)
>> +{
>> +	struct device_node *np = d->controller;
>> +	void __iomem *cpu_base;
>> +	void __iomem *dist_base;
>> +	int irq;
>> +
>> +	if (WARN_ON(!d || !d->controller))
>> +		return;
>> +
>> +	dist_base = of_iomap(np, 0);
>> +	WARN(!dist_base, "unable to map gic dist registers\n");
>> +
>> +	cpu_base = of_iomap(np, 1);
>> +	WARN(!cpu_base, "unable to map gic cpu registers\n");
>> +
>> +	gic_init(gic_cnt, d->irq_base, dist_base, cpu_base);
>> +	irq_domain_add_simple(d->controller, d->irq_base);
>> +
>> +	if (d->parent) {
>> +		irq = irq_of_parse_and_map(np, 0);
>> +		gic_cascade_irq(gic_cnt, irq);
>> +	}
>> +	gic_cnt++;
>> +}
>> +
>> +void __init gic_of_ppi_init(struct of_intc_desc *d)
>> +{
>> +	irq_domain_add_simple(d->controller, d->irq_base);
>> +}
>> +
>> +#endif
>> diff --git a/arch/arm/include/asm/hardware/gic.h b/arch/arm/include/asm/hardware/gic.h
>> index 435d3f8..a6594d4 100644
>> --- a/arch/arm/include/asm/hardware/gic.h
>> +++ b/arch/arm/include/asm/hardware/gic.h
>> @@ -37,6 +37,9 @@ extern void __iomem *gic_cpu_base_addr;
>>  extern struct irq_chip gic_arch_extn;
>>  
>>  void gic_init(unsigned int, unsigned int, void __iomem *, void __iomem *);
>> +struct of_intc_desc;
>> +void gic_of_init(struct of_intc_desc *d);
>> +void gic_of_ppi_init(struct of_intc_desc *d);
>>  void gic_secondary_init(unsigned int);
>>  void gic_cascade_irq(unsigned int gic_nr, unsigned int irq);
>>  void gic_raise_softirq(const struct cpumask *mask, unsigned int irq);
> 
> 
