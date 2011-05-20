From: marvin24@gmx.de (Marc Dietich)
Date: Fri, 20 May 2011 09:50:33 +0200
Subject: [PATCH 6/6] ARM: tegra: paz00: enable wifi card
In-Reply-To: <20110519200611.GA20596@rainbow>
References: <1305806910-3903-1-git-send-email-marvin24@gmx.de>
	<1305806910-3903-7-git-send-email-marvin24@gmx.de>
	<20110519200611.GA20596@rainbow>
Message-ID: <201105200950.33623.marvin24@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Dmitry,

> On 14:08 Thu 19 May     , Marc Dietrich wrote:
> > The Wifi card attached to one usb port needs to be unkilled. The
> > corresponding gpio and also the gpio for the LED are exported to be
> > controlled by userspace later on.
> > 
> > Signed-off-by: Marc Dietrich <marvin24@gmx.de>
> 
> [snip]
> 
> > +static void __init paz00_wifi_init(void)
> > +{
> > +	int ret;
> > +
> > +	/* unlock hw rfkill */
> > +	ret = gpio_request_one(TEGRA_WIFI_PWRN, GPIOF_OUT_INIT_HIGH,
> > +			"wifi_pwrn");
> > +	if(ret) {
> > +		pr_warning("WIFI: could not request PWRN gpio!\n");
> > +		return;
> > +	}
> > +	gpio_export(TEGRA_WIFI_PWRN, 0);
> 
> Although enabling wifi on boot may be OK for now, I think in long term
> it would be better and more proper to use rfkill infrastructure for this
> instead of just exporting gpio to userspace. There were some patches for
> gpio-based rfkill switch floating around lately. This is one the versions:
> https://lkml.org/lkml/2011/5/6/372
> Not sure about their status and if they are directly suitable for PAZ00,
> but you may have a look. Btw, there's also another mostly generic
> gpio-rfkill driver in the tree I'm aware of - see
> arch/arm/mach-pxa/tosa-bt.c

yes, proper rfkill support is on my ToDo list. As it seems, the rt2x00 driver 
which we are using also has some initial support for gpio based rfkill. I guess 
I need some more time to sort this out.

> > +
> > +	/* export wifi led */
> > +	ret = gpio_request_one(TEGRA_WIFI_LED, GPIOF_OUT_INIT_HIGH,
> > +			"wifi_led");
> > +	if(ret)
> > +		pr_warning("WIFI: could not request LED gpio!\n");
> > +	gpio_export(TEGRA_WIFI_LED, 0);
> 
> For LED I think it's better to register gpio-leds platform device with
> something like 'rfkill.0' or 'wifi-rx' or whatever as a default trigger
> (not sure about exact names of triggers - you'll need to look up them).
> That way you will get a wide choice of led triggers for free, and still
> retain possibility of manual driving leds from userspace.

There are surely better ways to do this. Luckily, we got some more time to 
rework this because the tegra board changes were put to "hold" status. Expect 
some new version in a few weeks.

Colin, first sorry that I misspelled your name serveral times. I swear it will 
not happen again. 

Second, please don't apply this patch to the for-next tree. I will resend a new 
version which better integrates into the kernel subsystem.

Thanks for your comments!

Marc
