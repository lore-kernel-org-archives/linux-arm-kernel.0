From: david-b@pacbell.net (David Brownell)
Date: Fri, 18 Jun 2010 23:21:55 -0700 (PDT)
Subject: gpiolib and sleeping gpios
In-Reply-To: <4C1BECC9.7000805@bluewatersys.com>
Message-ID: <386783.17931.qm@web180310.mail.gq1.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> 
> The runtime warnings will only show instances where the
> non-sleeping
> versions where called instead of the sleeping versions.

... *AND* the GPIO requires the cansleep() version...

Right; such calls are errors.  We issue
warnings since fault returns are inapplicable. 

> There is no
> warning to say that we are calling the spinlock safe
> version, where it is possible to sleep.

The call context isn't what controls whether
gpio_get_value() or gpio_get_value_cansleep()
is appropriate ... it's the GPIO itself, and
how its implementation works.

"possible to sleep" is a GPIO attribute,
exposed by a predicate.  If spinlock-safe
calls are used on GPIOs with that attribute,
 a warning *IS* issued.




> 
> The point I was trying to make is that there are lots of
> drivers which
> will not work with gpios on sleeping io expanders because
> they call the
> spinlock safe gpio calls.

And they will trigger runtime warnings, and
thus eventually get fixed.  The way to do that
is to check if the GPIO needs the cansleep()
call


That's the first category above:  the driver
should have used the cansleep() variant, and
sotriggers a runtime warning.
