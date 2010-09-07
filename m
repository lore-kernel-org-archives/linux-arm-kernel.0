From: david-b@pacbell.net (David Brownell)
Date: Mon, 6 Sep 2010 23:33:43 -0700 (PDT)
Subject: [PATCH] pio: add arch specific gpio_is_valid() function
In-Reply-To: <4C85A71F.3010402@bluewatersys.com>
Message-ID: <159882.19856.qm@web180315.mail.gq1.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



--- On Mon, 9/6/10, Ryan Mallon <ryan@bluewatersys.com> wrote:


> How about this approach instead?

Still don't like it, sorry.  gpio_is_valid()
is not intended as a fine-grained call, there is
a call which is fine grained; use that instead.

> ----
> On some architectures gpio numbering does not start from zero.

But on all of them, zero is a valid GPIO number.
It could get dynamically allocated someday...

 Allow for
> correct behaviour of gpio_is_valid

I'd say it's already correct ... what's not
correct is expecting to validate the *active* set
of GPIOs (some dynamically allocated) through
that, instead of one of the GPIO setup calls
like gpio_request, which have explicit guarantees
of reporting errors for GPIO numbers which are
not usable on the target board.


 on values below the
> first gpio by
> adding the architecture overrideable ARCH_FIRST_GPIO.

What are you (?) doing that it even matters
to a driver  which GPIOs are built into the SOC
versus external?  Caring about arch-specific
stuff at this level is a big thought-bug...

And  I'd ask why you're ignoring or bypassing
the error reporting from gpio_request() ...

That is, just what are you doing that makes
you want gpio_is_valid() to include error checks
you are supposed to get via gpio_request as part
of GPIO configuration?
