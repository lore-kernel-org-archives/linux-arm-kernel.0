From: jg1.han@samsung.com (Jingoo Han)
Date: Mon, 10 Dec 2012 17:17:53 +0900
Subject: [PATCH v4] backlight: corgi_lcd: Use gpio_set_value_cansleep()	to
 avoid WARN_ON
In-Reply-To: <20121205192141.GQ14363@n2100.arm.linux.org.uk>
References: <000201cdd283$baf50160$30df0420$%han@samsung.com>
 <20121205093027.GK14363@n2100.arm.linux.org.uk>
 <CAHod+Gdb_LEnhx5cz9j=q9PyS4L=Yjxs303dHon9i-tgjJRtDA@mail.gmail.com>
 <20121205192141.GQ14363@n2100.arm.linux.org.uk>
Message-ID: <000801cdd6ae$da095270$8e1bf750$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, December 06, 2012 4:22 AM, Russell King - ARM Linux wrote
> On Wed, Dec 05, 2012 at 07:20:00PM +0100, Marko Kati? wrote:
> > On Wed, Dec 5, 2012 at 10:30 AM, Russell King - ARM Linux
> > <linux@arm.linux.org.uk> wrote:
> > > On Wed, Dec 05, 2012 at 09:59:07AM +0900, Jingoo Han wrote:
> > >> -     if (gpio_is_valid(lcd->gpio_backlight_cont))
> > >> -             gpio_set_value(lcd->gpio_backlight_cont, cont);
> > >> +     if (gpio_is_valid(lcd->gpio_backlight_cont)) {
> > >> +             if (gpio_cansleep(lcd->gpio_backlight_cont))
> > >> +                     gpio_set_value_cansleep(lcd->gpio_backlight_cont, cont);
> > >> +             else
> > >> +                     gpio_set_value(lcd->gpio_backlight_cont, cont);
> > >> +     }
> > >
> > > Why not simply:
> > >
> > > +       if (gpio_is_valid(lcd->gpio_backlight_cont))
> > > +               gpio_set_value_cansleep(lcd->gpio_backlight_cont, cont);
> >
> > My first patch did exactly this but there were complains about it's
> > commit message.
> 
> So that's a reason to drop the patch?  Err, forgive me for being thick
> as a medieval castle wall, but what does complaints about the commit
> message have to do with the contents of the patch?  Why can't you just
> fix the commit message?
> 
> > And i just found out that Marek Vasut posted the exact same patch more
> > than a year ago.
> >
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2011-April/046955.html
> >
> > It was not applied for various reasons.
> 
> Looking at that thread (which is corrupted btw, probably thanks to the
> crappy python based locking in mailman) - here's a better archiver:
> 
> http://lists.arm.linux.org.uk/lurker/thread/20110402.014316.74101499.en.html
> 
> it didn't go anywhere because the discussion was distracted by the loss
> of David Brownell.
> 
> Eric shares my opinion of the _cansleep() mess, but unfortunately it's
> what we have and no one's come up with any better solutions to it.  (I
> argued from the outset that the gpio_xxx_cansleep() should've been
> gpio_xxx() and the non-cansleep() version should be called
> gpio_xxx_atomic() so that by default people use the version which _can_
> sleep, but have to think about it when they want to manipulate GPIOs in
> non-task contexts.)

Hi Russell,

Thank you for your explanation. It is very helpful for getting hold of.
I have been confused by the current function name such as gpio_xxx_cansleep().
As you mentioned, gpio_xxx_cansleep()and gpio_xxx_atomic() would be better.

> 
> That's off-topic though.  Using just the _cansleep() version is far
> better than messing around with stuff like:
> 
> 	if (gpio_cansleep(gpio))
> 		gpio_xxx_cansleep(gpio);
> 	else
> 		gpio_xxx(gpio);
> 
> > > If you read the gpiolib code and documentation, what you will realise is
> > > that the two calls are identical except for the "might_sleep_if()" in
> > > gpio_set_value_cansleep().  You will also note that gpiolib itself _only_
> > > calls gpio_set_value_cansleep() without checking gpio_cansleep() in
> > > contexts where sleeping is possible.  So if it's good enough for gpiolib,
> > > it should be good enough here.
> >
> > The documentation tells which calls to use when you don't need to sleep
> > and which calls to use when you might sleep. And here we have a case
> > where the same call to gpio_set_value might sleep or doesn't have to,
> > depending on the model.
> > In this case, i'd rather use gpio_cansleep check as Andrew proposed.
> >
> > I will also say that the distinction between gpio_set_value and
> > gpio_set_value_cansleep.
> > is rather confusing at this point. Is it really necessary to have both ?
> 
> No.  You can call gpio_set_value_cansleep() from task contexts for any
> GPIO just fine, but you can't call it from atomic contexts (it will
> complain).  It doesn't matter whether the GPIO can sleep or not.
> 
> You can call gpio_set_value() from any context without it complaining,
> however, gpio_set_value() can't be used with a GPIO which sleeps.
> 
> Look, when it comes down to it, in _task_ context, where sleeps are
> permissible:
> 
> 	gpio_set_value(gpio, xxx);
> and
> 	gpio_set_value_cansleep(gpio, xxx);
> 
> are exactly the same thing; they will both set the value of a GPIO
> output, whether it be an atomic or a sleeping gpio to the requested
> value.
> 
> The difference between the two becomes important if you're not in task
> context, where only the non-_cansleep() versions can be used.  This is
> enforced by the _cansleep() versions issuing a WARN_ON() if they're
> used in non-task contexts.  And conversely, the non-_cansleep() versions
> will warn (as you've found) if you use that call with a GPIO which will
> sleep.

The former one, the _cansleep() versions issuing a WARN_ON(), would be
better than the latter one, current scheme. 

Best regards,
Jingoo Han

> 
> There is another solution to this mess:
> 
> void __gpio_set_value(unsigned gpio, int value)
> {
> 	struct gpio_chip	*chip;
> 
> 	chip = gpio_to_chip(gpio);
> 	/* Should be using gpio_set_value_cansleep() */
> -	WARN_ON(chip->can_sleep);
> +	might_sleep_if(chip->can_sleep);
> 	trace_gpio_value(gpio, 0, value);
> 	if (test_bit(FLAG_OPEN_DRAIN,  &gpio_desc[gpio].flags))
> 		_gpio_set_open_drain_value(gpio, chip, value);
> 	else if (test_bit(FLAG_OPEN_SOURCE,  &gpio_desc[gpio].flags))
> 		_gpio_set_open_source_value(gpio, chip, value);
> 	else
> 		chip->set(chip, gpio - chip->base, value);
> }
> EXPORT_SYMBOL_GPL(__gpio_set_value);
> 
> With the above change (and an equivalent change everywhere else), it means
> gpio_set_value() is callable from task contexts on GPIOs which can sleep.
> 
> However, it loses us some checking - we no longer have the cross-platform
> checking that we get with the existing API, and that's why it's undesirable.
> 
> As I say above, IMHO it would've been much better to rename these functions
> to be the other way around but David was always very dismissive of any
> comments I had against any code he'd written.
