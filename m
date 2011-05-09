From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 9 May 2011 23:17:19 +0100
Subject: [PATCH v3] leds: provide helper to register "leds-gpio" devices
In-Reply-To: <20110509150254.e7da059f.akpm@linux-foundation.org>
References: <1302097097.22904.41.camel@rex>
	<1302554157-24145-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20110509150254.e7da059f.akpm@linux-foundation.org>
Message-ID: <20110509221719.GE16919@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 09, 2011 at 03:02:54PM -0700, Andrew Morton wrote:
> On Mon, 11 Apr 2011 22:35:57 +0200
> Uwe Kleine-K__nig  <u.kleine-koenig@pengutronix.de> wrote:
> > +#if defined(CONFIG_LED_REGISTER_GPIO)
> > +struct platform_device *__init gpio_led_register_device(
> > +		int id, const struct gpio_led_platform_data *pdata)
> > +{
> > +	struct platform_device *ret;
> > +	struct gpio_led_platform_data _pdata = *pdata;
> > +
> > +	_pdata.leds = kmemdup(pdata->leds,
> > +			pdata->num_leds * sizeof(*pdata->leds), GFP_KERNEL);
> > +	if (!_pdata.leds)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	ret = platform_device_register_resndata(NULL, "leds-gpio", id,
> > +			NULL, 0, &_pdata, sizeof(_pdata));
> > +	if (IS_ERR(ret))
> > +		kfree(_pdata.leds);
> > +
> > +	return ret;
> > +}
> > +#endif
...
> The comment doesn't document return values.

Two further comments.

1. Why is this .c file always built, but _all_ the containing code is
wrapped up in an ifdef?  It seems a waste of resources to compile a .c
file with all code #ifdef'd out.

2. What is the point of returning the platform device structure?  You've
already registered it, so you must _not_ modify any data in that structure
which may be used by the driver.  The only thing which you can safely do
with it is unregister it.
