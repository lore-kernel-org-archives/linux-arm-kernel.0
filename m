From: johnstul@us.ibm.com (john stultz)
Date: Fri, 12 Nov 2010 12:22:42 -0800
Subject: [PATCH] RFC: nomadik: expand timesource to 63 bits
In-Reply-To: <4CDD18F9.5090005@stericsson.com>
References: <1289466356-16697-1-git-send-email-linus.walleij@stericsson.com>
	<AANLkTi=ysONhPQBTbVNRgTOx5PGEM=STaUYY6RnUpfES@mail.gmail.com>
	<20101112095739.GH18358@pengutronix.de>
	<4CDD120A.2050401@stericsson.com>
	<alpine.LFD.2.00.1011121130350.2900@localhost6.localdomain6>
	<4CDD18F9.5090005@stericsson.com>
Message-ID: <1289593362.3292.14.camel@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-11-12 at 11:37 +0100, Linus Walleij wrote:
> Incidentally the dual use of a single free-running timer as both
> single clocksource and sched_clock() baseline seem to creep up in
> a lot of embedded platforms...

And really, using the same underlying hardware for both isn't a bad
thing. The main issue is that the product of the clocksource code and
the sched_clock code have different requirements.

1) sched_clock needs to be a fast lightweight ns value, that wraps on
64bit boundaries. Performance is very critical. Transient consistency
errors are acceptable.

2) clocksources care most about correctness, so that the counter is
never mis-read, and that its is accumulated from once every wrap period.
Ideally fine adjustment granularity is desired as well (which
sched_clock doesn't require). Performance is important, but secondary to
correctness.

So there isn't a problem with the same hardware being used for both, but
there is an issue trying to base one implementation off of the other.

I do think a generic sched_clock implementation could be useful,
specifically if it added an accumulation hook so we can more easily and
generically deal with using 32bit counters. I don't think it should try
to re-use the clocksource infrastructure code, as I think that may
stretch that infrastructure too far (ie: having to deal with the
conflicting assumptions of both interfaces). 

But having arches register a similar read() and cyc2ns conversion hook
(or freq values to generate such conversion) would probably be a good
approach.

That said, I don't have the space on my plate to look at this in the
near term, but I'd be happy to review code.

thanks
-john
