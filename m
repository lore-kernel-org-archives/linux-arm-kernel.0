From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 14 Jun 2016 14:01:52 +0200
Subject: [PATCH] gpio: omap: make gpio numbering deterministical by using
 of aliases
In-Reply-To: <575FE7F0.6090200@ti.com>
References: <1465898604-16294-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <575FE7F0.6090200@ti.com>
Message-ID: <20160614120152.GW26768@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Grygorii,

On Tue, Jun 14, 2016 at 02:18:08PM +0300, Grygorii Strashko wrote:
> On 06/14/2016 01:03 PM, Uwe Kleine-K?nig wrote:
> > diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> > index b98ede78c9d8..6814245a54aa 100644
> > --- a/drivers/gpio/gpio-omap.c
> > +++ b/drivers/gpio/gpio-omap.c
> > @@ -1034,6 +1034,7 @@ static int omap_gpio_chip_init(struct gpio_bank *bank, struct irq_chip *irqc)
> >   	static int gpio;
> >   	int irq_base = 0;
> >   	int ret;
> > +	int gpio_alias_id;
> >   
> >   	/*
> >   	 * REVISIT eventually switch from OMAP-specific gpio structs
> > @@ -1056,6 +1057,17 @@ static int omap_gpio_chip_init(struct gpio_bank *bank, struct irq_chip *irqc)
> >   		bank->chip.label = "gpio";
> >   		bank->chip.base = gpio;
> 
> I think, the gpio base correction should be done here

What is the upside of doing it here? It has the downside that it needs
one more indention level. The only difference I see is that it doesn't
apply for mpuio devices then and wonder if that is relevant.
 
> >   	}
> > +
> > +	/*
> > +	 * Traditionally the base is given out in first-come-first-serve order.
> > +	 * This might shuffle the numbering of gpios if the probe order changes.
> > +	 * So make the base deterministical if the device tree specifies alias
> > +	 * ids.
> > +	 */
> > +	gpio_alias_id = of_alias_get_id(bank->chip.of_node, "gpio");
> > +	if (gpio_alias_id >= 0)
> > +		bank->chip.base = bank->width * gpio_alias_id;
> > +
> 
> Unfortunately, this driver is still used by non-DT platforms, so above code will
>  break build if !OF && !OF_GPIO

Without CONFIG_OF of_alias_get_id still exists and returns -ENOSYS which
should make the added code a nop. Does your compiler agree with you that
my patch breaks building the driver?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
