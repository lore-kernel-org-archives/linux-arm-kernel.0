From: jg1.han@samsung.com (Jingoo Han)
Date: Wed, 05 Dec 2012 10:17:58 +0900
Subject: [PATCH v3] backlight: corgi_lcd: Use gpio_set_value_cansleep() to
 avoid WARN_ON
In-Reply-To: <20121204145822.056b6cf6.akpm@linux-foundation.org>
References: <000b01cdd1e0$293f0d90$7bbd28b0$%han@samsung.com>
 <20121204145822.056b6cf6.akpm@linux-foundation.org>
Message-ID: <000501cdd286$5c8f7ad0$15ae7070$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, December 05, 2012 7:58 AM, Andrew Morton wrote
> On Tue, 04 Dec 2012 14:28:15 +0900
> Jingoo Han <jg1.han@samsung.com> wrote:
> 
> > From: Marko Katic <dromede@gmail.com>
> >
> > Changing backlight intensity on an Akita (Sharp Zaurus C-1000)
> > triggers WARN_ON message:
> 
> Well, I queued it up.
> 
> > ...
> >
> > --- a/drivers/video/backlight/corgi_lcd.c
> > +++ b/drivers/video/backlight/corgi_lcd.c
> > @@ -408,11 +408,20 @@ static int corgi_bl_set_intensity(struct corgi_lcd *lcd, int intensity)
> >  	/* Bit 5 via GPIO_BACKLIGHT_CONT */
> >  	cont = !!(intensity & 0x20) ^ lcd->gpio_backlight_cont_inverted;
> >
> > -	if (gpio_is_valid(lcd->gpio_backlight_cont))
> > -		gpio_set_value(lcd->gpio_backlight_cont, cont);
> > +	if (gpio_is_valid(lcd->gpio_backlight_cont)) {
> > +		if (gpio_cansleep(lcd->gpio_backlight_cont))
> > +			gpio_set_value_cansleep(lcd->gpio_backlight_cont, cont);
> > +		else
> > +			gpio_set_value(lcd->gpio_backlight_cont, cont);
> > +	}
> 
> But this looks utterly daft.  Grant, these two things are the same - do
> we need both of them?

Hi Andrew,

There is another difference, except for warning message.
There is might_sleep_if(extra_checks) in gpio_set_value_cansleep().

Also, I saw the Documentation/gpio.txt as below:

172         /* GPIO OUTPUT */
173         void gpio_set_value(unsigned gpio, int value);
...
213         /* GPIO OUTPUT, might sleep */
214         void gpio_set_value_cansleep(unsigned gpio, int value);


Best regards,
Jingoo Han
