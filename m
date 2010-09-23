From: cl@linux.com (Christoph Lameter)
Date: Thu, 23 Sep 2010 14:15:09 -0500 (CDT)
Subject: [PATCH v6 0/8] ptp: IEEE 1588 hardware clock support
In-Reply-To: <1285268380.2587.11.camel@localhost.localdomain>
References: <cover.1285261533.git.richard.cochran@omicron.at>
	<alpine.DEB.2.00.1009231238170.2962@router.home>
	<1285268380.2587.11.camel@localhost.localdomain>
Message-ID: <alpine.DEB.2.00.1009231402420.2962@router.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 23 Sep 2010, john stultz wrote:

> This was my initial gut reaction as well, but in the end, I agree with
> Richard that in the case of one or multiple PTP hardware clocks, we
> really can't abstract over the different time domains.

My (arguably still superficial) review of the source does not show
anything that would make me reach that conclusion.

> I really don't think the PTP clock can be used as a clocksource sanely.
>
> First, the hardware access is much to slow for system timekeeping.

The HPET or pit timesource are also quite slow these days. You only need
access periodically to essentially tune the TSC ratio.

> Second, there is the problem that the system time is a software clock,
> and adjustments made (like freq) are made in the layer that interprets
> the underlying hardware cycle counter. Adjustments made in PTP (in order
> to sync the network timestamps) are made at the hardware level.


>From bogus@does.not.exist.com  Sat Sep 18 23:17:21 2010
From: bogus@does.not.exist.com ()
Date: Sun, 19 Sep 2010 03:17:21 -0000
Subject: No subject
Message-ID: <mailman.5.1285271044.1886.linux-arm-kernel@lists.infradead.org>

like any other clock that we currently support. If its configurable enough
then setup a hardware cycle counter that mimics nanoseconds since the
epoch as closely as possible and use that to sync the TSC rate to. Makes
it very easy.

> This would cause a disconnect between the hardware freq understood by
> the system time management code and the actual hardware freq.

We can switch underlying clocks for system time already. We can adapt to a
different hw frequency. But then I do not know why adjust the freq? I
thought the point was that the periodic clock was network synchronized and
can be used as "the" master clock for multiple machines?

> Richard, I'd actually strike this paragraph from the rational, as I feel
> it has the tendency to confuse as it suggests having the PHC as a
> clocksource is feasible when really it isn't. Or alternatively, maybe
> express more clearly why its not feasible, so it doesn't just seem like
> a minor design choice.

Sorry but I still feel that this is pretty much a misguided approach that
creates unnecessary layers in the kernel. The trivial easy approach was
not done (copy a driver from drivers/clocksource, modify so that it
programs access to a centralized periodic ptp signal and uses it for
system sync).
