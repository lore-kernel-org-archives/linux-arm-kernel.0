From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 9 Jan 2012 18:39:17 +0100
Subject: [PATCH v4] ARM: at91: pit add DT support
In-Reply-To: <4F071799.3030200@gmail.com>
References: <1325784348-29481-1-git-send-email-nicolas.ferre@atmel.com>
 <1325866830-13259-1-git-send-email-nicolas.ferre@atmel.com>
 <4F071799.3030200@gmail.com>
Message-ID: <20120109173917.GO2854@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09:47 Fri 06 Jan     , Rob Herring wrote:
> On 01/06/2012 10:20 AM, Nicolas Ferre wrote:
> > From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> > 
> > Retreive registers address and IRQ from device tree entry. Fall back
> > to built-in values if an error occurs.
> > 
> > Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> > [nicolas.ferre at atmel.com: change error path and interrupts property handling]
> > Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> > Reviewed-by: Jamie Iles <jamie@jamieiles.com>
> > Acked-by: Rob Herring <rob.herring@calxeda.com>
> > ---
> > v4: - change of_at91sam926x_pit_init() return value usage logic as
> >       suggested by Rob Herring
> >     - irq_of_parse_and_map() returns 0 on error: change test according to 
> >       Grant Likely note.
> > 
> > v3: - use irq_of_parse_and_map() for handling irq numbers specified by DT.
> >       Correction proposed by Jamie Iles.
> > 
> > v2: - new specification of irq numbers in DT (due to modification of AIC code)
> >     - new error path in of_at91sam926x_pit_init()
> >     - fall back to built-in values if an error occurs
> >     - use of of_property_read_u32() to get irq property
> > 
> >  .../devicetree/bindings/arm/atmel-at91.txt         |    8 +++
> >  arch/arm/boot/dts/at91sam9g20.dtsi                 |    5 ++
> >  arch/arm/boot/dts/at91sam9g45.dtsi                 |    6 ++
> >  arch/arm/mach-at91/at91sam926x_time.c              |   60 ++++++++++++++++++--
> >  4 files changed, 73 insertions(+), 6 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/arm/atmel-at91.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.txt b/Documentation/devicetree/bindings/arm/atmel-at91.txt
> > new file mode 100644
> > index 0000000..380f711
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/atmel-at91.txt
> > @@ -0,0 +1,8 @@
> > +Atmel AT91 device tree bindings.
> > +================================
> > +
> > +PIT Timer required properties:
> > +- compatible: Should be "atmel,at91sam9260-pit"
> > +- reg: Should contain registers location and length
> > +- interrupts: Should contain interrupt for the PIT which is the IRQ line
> > +  shared across all System Controller members.
> > diff --git a/arch/arm/boot/dts/at91sam9g20.dtsi b/arch/arm/boot/dts/at91sam9g20.dtsi
> > index ea942b5..e10842a 100644
> > --- a/arch/arm/boot/dts/at91sam9g20.dtsi
> > +++ b/arch/arm/boot/dts/at91sam9g20.dtsi
> > @@ -57,6 +57,11 @@
> >  				reg = <0xfffff000 0x200>;
> >  			};
> >  
> > +			pit: timer at fffffd30 {
> > +				compatible = "atmel,at91sam9260-pit";
> > +				reg = <0xfffffd30 0xf>;
> > +				interrupts = <1 4>;
> > +			};
> >  
> >  			pioA: gpio at fffff400 {
> >  				compatible = "atmel,at91rm9200-gpio";
> > diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
> > index ebc9617..28a678f 100644
> > --- a/arch/arm/boot/dts/at91sam9g45.dtsi
> > +++ b/arch/arm/boot/dts/at91sam9g45.dtsi
> > @@ -58,6 +58,12 @@
> >  				reg = <0xfffff000 0x200>;
> >  			};
> >  
> > +			pit: timer at fffffd30 {
> > +				compatible = "atmel,at91sam9260-pit";
> > +				reg = <0xfffffd30 0xf>;
> > +				interrupts = <1 4>;
> > +			};
> > +
> >  			dma: dma-controller at ffffec00 {
> >  				compatible = "atmel,at91sam9g45-dma";
> >  				reg = <0xffffec00 0x200>;
> > diff --git a/arch/arm/mach-at91/at91sam926x_time.c b/arch/arm/mach-at91/at91sam926x_time.c
> > index d89ead7..802fea3 100644
> > --- a/arch/arm/mach-at91/at91sam926x_time.c
> > +++ b/arch/arm/mach-at91/at91sam926x_time.c
> > @@ -14,6 +14,9 @@
> >  #include <linux/kernel.h>
> >  #include <linux/clk.h>
> >  #include <linux/clockchips.h>
> > +#include <linux/of.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_irq.h>
> >  
> >  #include <asm/mach/time.h>
> >  
> > @@ -133,7 +136,8 @@ static irqreturn_t at91sam926x_pit_interrupt(int irq, void *dev_id)
> >  static struct irqaction at91sam926x_pit_irq = {
> >  	.name		= "at91_tick",
> >  	.flags		= IRQF_SHARED | IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
> > -	.handler	= at91sam926x_pit_interrupt
> > +	.handler	= at91sam926x_pit_interrupt,
> > +	.irq		= AT91_ID_SYS,
> >  };
> >  
> >  static void at91sam926x_pit_reset(void)
> > @@ -149,6 +153,49 @@ static void at91sam926x_pit_reset(void)
> >  	pit_write(AT91_PIT_MR, (pit_cycle - 1) | AT91_PIT_PITEN);
> >  }
> >  
> > +#ifdef CONFIG_OF
> > +static struct of_device_id timer_ids[] = {
> > +	{ .compatible = "atmel,at91sam9260-pit" },
> > +	{ /* sentinel */ }
> > +};
> > +
> > +static int __init of_at91sam926x_pit_init(void)
> > +{
> > +	struct device_node	*np;
> > +	int			ret;
> > +
> > +	np = of_find_matching_node(NULL, timer_ids);
> > +	if (!np)
> > +		goto err;
> > +
> > +	pit_base_addr = of_iomap(np, 0);
> > +	if (!pit_base_addr)
> > +		goto node_err;
> > +
> > +	/* Get the interrupts property */
> > +	ret = irq_of_parse_and_map(np, 0);
> > +	if (!ret)
> > +		goto ioremap_err;
> > +	at91sam926x_pit_irq.irq = ret;
> > +
> > +	of_node_put(np);
> > +
> > +	return 0;
> > +
> > +ioremap_err:
> > +	iounmap(pit_base_addr);
> > +node_err:
> > +	of_node_put(np);
> > +err:
> > +	return -EINVAL;
> > +}
> > +#else
> > +static int __init of_at91sam926x_pit_init(void)
> > +{
> > +	return -EINVAL;
> > +}
> > +#endif
> > +
> >  /*
> >   * Set up both clocksource and clockevent support.
> >   */
> > @@ -177,7 +224,7 @@ static void __init at91sam926x_pit_init(void)
> >  	clocksource_register_hz(&pit_clk, pit_rate);
> >  
> >  	/* Set up irq handler */
> > -	setup_irq(AT91_ID_SYS, &at91sam926x_pit_irq);
> > +	setup_irq(at91sam926x_pit_irq.irq, &at91sam926x_pit_irq);
> >  
> >  	/* Set up and register clockevents */
> >  	pit_clkevt.mult = div_sc(pit_rate, NSEC_PER_SEC, pit_clkevt.shift);
> > @@ -193,10 +240,11 @@ static void at91sam926x_pit_suspend(void)
> >  
> >  void __init at91sam926x_ioremap_pit(u32 addr)
> >  {
> > -	pit_base_addr = ioremap(addr, 16);
> > -
> > -	if (!pit_base_addr)
> > -		panic("Impossible to ioremap PIT\n");
> > +	if (of_at91sam926x_pit_init() < 0) {
> > +		pit_base_addr = ioremap(addr, 16);
> > +		if (!pit_base_addr)
> > +			panic("Impossible to ioremap PIT\n");
> > +	}
> 
> This is not what I meant. I meant call either at91sam926x_ioremap_pit or
> of_at91sam926x_pit_init. Don't nest the calls and keep the OF and non-OF
> init somewhat separate. The fact that you are passing in the physical
> address and then ignoring it for the OF case is what I have issue with.

the DT pure soc will pass NULL for soc that support both or only non of we
pass the PHY addr

Best Regards,
J.
