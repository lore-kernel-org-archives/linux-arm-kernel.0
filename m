From: david-b@pacbell.net (David Brownell)
Date: Thu, 17 Jun 2010 23:16:10 -0700 (PDT)
Subject: gpiolib and sleeping gpios
In-Reply-To: <4C1A980F.8080908@bluewatersys.com>
Message-ID: <514259.95052.qm@web180315.mail.gq1.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



--- On Thu, 6/17/10, Ryan Mallon <ryan@bluewatersys.com> wrote:
> Currently implementors of gpiolib must provide
> implementations for
> gpio_get_value, gpio_set_value and gpio_cansleep. 

Not true.  There is ONE implementation of gpiolib.

I think you mean "implementors of the GPIO calls".
many of those implementors will use gpiolib, to
make their lives easier.  They are not, however,
re-implementing gpiolib itself...

Most of
> the
> implementations just #define these to the double underscore
> prefixed
> versions in drivers/gpio/gpiolib.c. A few implementations
> have a simple
> wrapper function which provides a fast path for the SoC
> gpios, and calls
> gpiolib for the any additional gpios, such as those added
> by an io expander.

Right...


> Although gpio_chips know whether or not they may sleep,
> gpios which can
> sleep need to call gpio_[set/get]_value_cansleep. 

GPIOsare hardware, or maybe software abstractions;
either way,  can't call those.
  Driver level code does
when it accesses a GPIO.
for example,peripheral setup logic might.


The only
> difference
> between __gpio_(set/get)_value and
> gpio_(set/get)_value_cansleep is that


only the cansleep() versions may be used for
GPIOs whose operation requires use of sleeping
calls.  Most SoC GPIOs are safe to access with
IRQs disabled, spinlocks, held and so on.

That's why only the non-cansleep() versions
are documented as being spinlock-safe.


> the cansleep versions calls might_sleep_if. Most drivers


That's an implemenation detail, internal to the
gpiolib code.

Note that "can" sleep means exactly that...  It
doesn't mean "must sleep".  A valid way to
implement a cansleep() variant is to 

just call the spinlock-safe routine, so that
it never sleeps.

THe converse is not true; the spinlock-safe
routine must never call a cansleep() version.


>  Most drivers call > gpio_(get/set)_value, rather than the cansleep variants. I
> haven't done
> a full audit of all of the drivers (which is a reasonably
> involved
> task), but I would hazard a guess that some of these could
> be replaced
> by the cansleep versions.


One hopes that the runtime warnings have gotten
folk to fix bugs where the cansleep() version
should have been used, but wasn't...


Better IMO not to make that change except as
part
of a bugfix:  e.g. remove a runtime warning
that boils down to not using the cansleep()
version when it should have been used.
> 
> Would it not be simpler to combine the calls and have
> something like this:
> 
> void __gpio_get_value(unsigned gpio, int value)
> {
> ??? struct gpio_chip *chip;
> 
> ??? chip = gpio_to_chip(gpio);
> ??? might_sleep_if(extra_checks &&
> chip->can_sleep);
> ??? chip->set(chip, gpio - chip->base,

> value);

calling chip->set() when  chip->can_sleep
and the call context can't be preempted,
would be a bug.  So that code is wrong ...
it should at least warn about the error
made by the caller.  If we had error returns from gpio get/set calls 9sigh), it'd be right to
fail that call.

> }
> 
> Then all drivers can just call gpio_(set/get)_value


Bad idea.  Those calls are only for
use in non-sleeping contexts; don't
train developers to misuse calls.

 and any
> attempts to
> use sleeping gpios from an non-sleeping context will be
> caught by the
> might_sleep_if check. Is there something I am missing about
> this?

The fact that such attempts are errors
in the calling code, and should not be
swept under therug...


> 
> I can prepare a patch which combines the non-sleeping and
> sleeping
> variants, but I wanted to check that I'm not missing
> something
> fundamental first.
> 
> Thanks,
> ~Ryan
> 
> -- 
> Bluewater Systems Ltd - ARM Technology Solution Centre
> 
> Ryan Mallon? ? ?
> ?????? ??? 5
> Amuri Park, 404 Barbadoes St
> ryan at bluewatersys.com?
> ? ? ?????? PO Box 13
> 889, Christchurch 8013
> http://www.bluewatersys.com??? New
> Zealand
> Phone: +64 3 3779127??? ???
> Freecall: Australia 1800 148 751
> Fax:???+64 3 3779135???
> ??? ??? ? USA 1800 261
> 2934
> 
