From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 17 Jul 2013 11:43:15 +0800
Subject: [PATCH v8] reset: Add driver for gpio-controlled reset pins
In-Reply-To: <51E56AF6.30506@wwwdotorg.org>
References: <1369904940-716-1-git-send-email-p.zabel@pengutronix.de>
 <20130716015038.GD28375@S2101-09.ap.freescale.net>
 <20130716065130.GB30067@S2101-09.ap.freescale.net>
 <51E56AF6.30506@wwwdotorg.org>
Message-ID: <20130717034314.GB4541@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 16, 2013 at 09:47:02AM -0600, Stephen Warren wrote:
> > diff --git a/drivers/reset/gpio-reset.c b/drivers/reset/gpio-reset.c
> 
> > -	gpio_set_value(drvdata->gpio, value);
> > +	if (gpio_cansleep(drvdata->gpio))
> > +		gpio_set_value_cansleep(drvdata->gpio, value);
> > +	else
> > +		gpio_set_value(drvdata->gpio, value);
> 
> That's not right. Calling gpio_set_value() v.s.
> gpio_set_value_cansleep() should be based on the properties of the
> calling context, not the GPIO being controlled. In other words, if it's
> permissible to call gpio_set_value_cansleep() at this point in the code,
> simply always call that, and remove the conditional logic.

Ah, yes.  I was confused by the API gpio_cansleep().  Which API we
should call depends on the calling context.  And the context should
come from the gpio-reset client device driver.  IOW, we have no idea
what the context is in gpio-reset driver.  To start with something
simple, we may want to define the gpio-reset as a sleepable interface
and always call gpio_set_value_cansleep() in there.

Shawn
