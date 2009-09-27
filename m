From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Sun, 27 Sep 2009 10:10:29 +0300
Subject: [PATCH v2 2/5] Add basic HP iPAQ rx1950 support
In-Reply-To: <20090927061802.GL31920@trinity.fluff.org>
References: <4abe82e2.0405560a.5ebe.428d@mx.google.com>
	<20090927061802.GL31920@trinity.fluff.org>
Message-ID: <200909271010.43474.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? ????????? ?? 27 ???????? 2009 09:18:02 ????? Ben Dooks ???????:
 
> > +static int rx1950_backlight_notify(int brightness)
> > +{
> > +	static int disabled = 1;
> > +	if (!brightness) {
> > +		if (!disabled) {
> > +			s3c2410_gpio_setpin(S3C2410_GPB(0), 0);
> > +			s3c2410_gpio_pullup(S3C2410_GPB(0), 0);
> > +			s3c2410_gpio_cfgpin(S3C2410_GPB(0),
> > +				S3C2410_GPIO_OUTPUT);
> > +		}
> > +		disabled = 1;
> > +	} else {
> > +		if (disabled) {
> > +			/* LED driver need a "push" to power on */
> > +			s3c2410_gpio_setpin(S3C2410_GPB(0), 1);
> > +			s3c2410_gpio_pullup(S3C2410_GPB(0), 1);
> > +			/* Warm up backlight for one period of PWM.
> > +			 * Without this trick its almost impossible to
> > +			 * enable backlight
> > +			 */
> > +			ndelay(48000);
> > +			s3c2410_gpio_cfgpin(S3C2410_GPB(0),
> > +				S3C2410_GPB0_TOUT0);
> > +		}
> > +		disabled = 0;
> > +	}
> > +	return brightness;
> > +}
> 
> Maybe this is something that should be done in the pwm-bl driver?

Nope, it's device specific. Btw, all this code will be moved into platform 
driver that controls LCD and backlight power in future.

> > +	/* Configuring udc pullup */
> > +	s3c2410_gpio_cfgpin(S3C2440_GPJ5, S3C2410_GPIO_OUTPUT);
> 
> please use gpiolib interface, we're moving away from specific gpio set
> interface.

I'd like to, but gpiolib interface doesn't support GPJ port :(
  
Thanks for review!

Regards
Vasily
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20090927/b16a0b10/attachment.sig>
