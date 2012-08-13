From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 13 Aug 2012 19:34:41 +0200
Subject: [PATCH 1/5] gpio: introduce gpio-mvebu driver for Marvell SoCs
In-Reply-To: <20120813051809.GA8836@game.jcrosoft.org>
References: <1344705034-18173-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1344705034-18173-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <20120813051809.GA8836@game.jcrosoft.org>
Message-ID: <20120813193441.16abed76@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Thanks Jean-Christophe for this review!

Le Mon, 13 Aug 2012 07:18:09 +0200,
Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com> a ?crit :

> > +/*
> > + * Common functions to all SoCs
> > + */
> > +static void __iomem *GPIO_OUT(struct mvebu_gpio_chip *mvchip)
> please use inline and do not use upper case for function

Yes agreed. Those upper-case functions come directly from the previous
driver in plat-orion/gpio.c, but I was also not really happy with them.
Will change it for the next version.

> in the code pelease use relaxed readl/writel

Ok.

> > +	/* Check with the pinctrl driver whether this pin is usable as
> > +	 * an input GPIO */
> > +	ret = pinctrl_gpio_direction_input(chip->base + pin);
> this will de the configuration

No, it will not do the configuration. On Marvell SoCs:

 * The MPP unit allows to configure the pin muxing only. This unit is
   managed by the pinctrl driver.

 * The GPIO unit allows to configure whether a GPIO is input/output,
   set the level, configure GPIO interrupts. This unit is managed by
   the GPIO driver.

Those two units have distinct register ranges, so we cannot easily
migrate the GPIO direction configuration to the pinctrl driver without
doing some ugly things.

So, in terms of GPIO direction, the pinctrl driver is only responsible
for telling the GPIO driver whether a particular pin *can* be
configured as input or output (because this is something we encode in
the pinctrl driver in the pins list). However, *configuring* the
direction must be done by the GPIO driver.

> > +	if (ret)
> > +		return ret;
> > +
> > +	spin_lock_irqsave(&mvchip->lock, flags);
> > +	u = readl(GPIO_IO_CONF(mvchip));
> > +	u |= 1 << pin;
> > +	writel(u, GPIO_IO_CONF(mvchip));
> why this?

See above, it configures the GPIO direction.

> > +	/*
> > +	 * Configure interrupt polarity.
> > +	 */
> > +	if (type == IRQ_TYPE_EDGE_RISING || type == IRQ_TYPE_LEVEL_HIGH) {
> > +		u = readl(GPIO_IN_POL(mvchip));
> > +		u &= ~(1 << pin);
> > +		writel(u, GPIO_IN_POL(mvchip));
> > +	} else if (type == IRQ_TYPE_EDGE_FALLING || type == IRQ_TYPE_LEVEL_LOW) {
> > +		u = readl(GPIO_IN_POL(mvchip));
> > +		u |= 1 << pin;
> > +		writel(u, GPIO_IN_POL(mvchip));
> > +	} else if (type == IRQ_TYPE_EDGE_BOTH) {
> > +		u32 v;
> switch will make the code cleaner

Agreed, will change.

> > +static struct platform_device_id mvebu_gpio_ids[] = {
> > +	{
> > +		.name = "orion-gpio",
> > +	}, {
> > +		.name = "mv78200-gpio",
> > +	}, {
> > +		.name = "armadaxp-gpio",
> why here to0?

to0 ?

> you already detect it via DT

Hmm, not sure what you mean here. Can you expand a bit your comment?

> > +	mvchip->chip.to_irq = mvebu_gpio_to_irq;
> > +	mvchip->chip.base = mvebu_gpio_chip_count * 32;
> why you don't use the auto allocated gpio number?

Ah, didn't know there was one. Will look into this!

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
