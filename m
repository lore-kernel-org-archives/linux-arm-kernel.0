From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 16 Nov 2010 22:31:16 +0000
Subject: [PATCH] nomadik: prevent sched_clock() wraparound
In-Reply-To: <AANLkTimvyo-2eHrvU=LNdBjrJfAxv9Jpza8Mh4iG4ts6@mail.gmail.com>
References: <1289898690-29910-1-git-send-email-linus.walleij@stericsson.com>
	<1289940829.3860.22.camel@localhost.localdomain>
	<AANLkTimvyo-2eHrvU=LNdBjrJfAxv9Jpza8Mh4iG4ts6@mail.gmail.com>
Message-ID: <20101116223116.GG21926@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 16, 2010 at 11:15:02PM +0100, Linus Walleij wrote:
> 2010/11/16 john stultz <johnstul@us.ibm.com>:
> > On Tue, 2010-11-16 at 10:11 +0100, Linus Walleij wrote:
> 
> > The cycle value being passed as v is likely to be large, and the
> > clocksource mult and shift are calculated to be as large as possible
> > without overflowing when given only a few seconds worth of cycles.
> >
> > So its very likely that after a few seconds of running (or even less,
> > with the 32_to_63 conversion), the cyc2ns function will overflow, as
> > v*mult will be greater then 64bits.
> 
> Darn you're right of course.
> 
> I'll attempt to use
> clocks_calc_mult_shift(&mult, &shift, rate, NSEC_PER_SEC, 3600*24*365);
> 
> For getting a somewhat more proper mult+shift for sched_clock().

What kind of mult are you expecting?  Let's look at the code again:

> +     /* The highest bit is not valid */
> +     v &= 0x7FFFFFFFFFFFFFFFLLU;
> +     return clocksource_cyc2ns(v, nmdk_clksrc.mult, nmdk_clksrc.shift);

v is 63-bit.  Any multiply greater than two will result in an overflow,
which means the best you can achieve with this is basically a divide by
a power of two.  So you've lost accuracy in the factor conversion.

You might be better off limiting the size of 'v' to a smaller number of
bits, and then use clocksource_cyc2ns() with a multiplier which guarantees
that it won't overflow 64-bit math, but putting up with it wrapping more
often than a 63-bit value would give you.

I think you have a trade-off to make here, between time between wraps
and conversion accuracy.
