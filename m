From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 20 Apr 2010 15:36:24 +0200
Subject: zaurus spitz suspend/resume issue
In-Reply-To: <i2pf17812d71004192358hd49d803nf82b44d5f3585212@mail.gmail.com>
References: <i2i1f96a3531004181200ve1f71c03ydb7b4328cbcc6e26@mail.gmail.com>
	<20100419133540.GA1191@ucw.cz>
	<i2pf17812d71004192358hd49d803nf82b44d5f3585212@mail.gmail.com>
Message-ID: <20100420133624.GA8670@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> >> ? ?Since resuming my spitz from a suspended state doesn't work in 2.6.34-rc3
> >> ? ?at the moment, I've tried to find out what the problem is with
> >> ? ?suspend/resume. Using CONFIG_PM_DEBUG I tried to test this by setting
> >> ? ?/sys/power/pm_test to "core" and switching the device off with the power
> >> ? ?button. This indeed suspends and resumes the device, but shows following
> >> ? ?in the system log:
> >
> > It works here.
> 
> Or maybe we should allow these GPIOs to wakeup the system when either
> configured as generic GPIOs or keypad GPIOs.

So... there's a bug in pxa-keypad driver -- it enables wakeup on one
line when it needs wakeup on all.

So we invented a workaround, in mfp-pxa2xx.c, where we change wakeup
on many lines when pxa-keypad wants to toggle wakeup on one.

But that workaround causes problems, so we

> diff --git a/arch/arm/mach-pxa/mfp-pxa2xx.c b/arch/arm/mach-pxa/mfp-pxa2xx.c
> index cf6b720..29301d2 100644
> --- a/arch/arm/mach-pxa/mfp-pxa2xx.c
> +++ b/arch/arm/mach-pxa/mfp-pxa2xx.c
> @@ -178,8 +178,17 @@ int gpio_set_wake(unsigned int gpio, unsigned int on)
> -	if (d->keypad_gpio)
> -		return -EINVAL;
> +	/* Allow keypad GPIOs to wakeup system when
> +	 * configured as generic GPIOs.
> +	 */
> +	if (d->keypad_gpio && (MFP_AF(d->config) == 0) &&
> +	    (d->config & MFP_LPM_CAN_WAKEUP)) {
> +		if (on)
> +			PKWR |= d->mask;
> +		else
> +			PKWR &= ~d->mask;
> +		return 0;
> +	}

Add more hacks on top.

What about simply fixing pxa-keypad? Then we can git of workaround,
and spitz will be fixed.

Fix should be as simple as replacing enable_irq_wakeup() with more
enable_irq_wakeup()s. 
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
