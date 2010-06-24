From: david-b@pacbell.net (David Brownell)
Date: Thu, 24 Jun 2010 03:36:18 -0700 (PDT)
Subject: [RFC PATCH] Rework gpio cansleep (was Re: gpiolib and
	sleepinggpios)
Message-ID: <924139.5848.qm@web180311.mail.gq1.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


--- On Wed, 6/23/10, Jon Povey <Jon.Povey@racelogic.co.uk> wrote:
>
> Date: Wednesday, June 23, 2010, 9:46 PM
> Ryan Mallon wrote:
> 
> > If we strip my patch back to just introducing
> gpio_request_cansleep,
> > which would be used in any driver where all of the
> calls are
> > gpio_(set/get)_cansleep, and make gpio_request only
> allow non-sleeping
> > gpios then incorrect use of gpios would be caught at
> request time and
> > returned to the caller as an error.
> 
> It seems like a good idea to catch these at request time.
> There is support in the API for this already
> (gpio_cansleep), but driver writers are not steered towards
> checking and thinking in these ways by the current API or
> 
> gpio_request_cansleep would be the same as current
> gpio_request

I wonder if, by the time I catch up on this
ever-extending email thread

... someone else will have noted that
because gpio_request() can now poke the GPIO
chip, that call might actually need to sleep.
So there'd be a difference between the two
calls:? one would *NEED* to be called in a
sleepable thread context, vs. that just being
well advised (e.g. as part of board setup in
arch init code after tasking is working)...

So that couldn't work quite that way.
