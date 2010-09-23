From: johnstul@us.ibm.com (john stultz)
Date: Thu, 23 Sep 2010 11:59:40 -0700
Subject: [PATCH v6 0/8] ptp: IEEE 1588 hardware clock support
In-Reply-To: <alpine.DEB.2.00.1009231238170.2962@router.home>
References: <cover.1285261533.git.richard.cochran@omicron.at>
	<alpine.DEB.2.00.1009231238170.2962@router.home>
Message-ID: <1285268380.2587.11.camel@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-09-23 at 12:53 -0500, Christoph Lameter wrote:
> On Thu, 23 Sep 2010, Richard Cochran wrote:
> >     In contrast to the standard Linux system clock, a PHC is
> >     adjustable in hardware, for example using frequency compensation
> >     registers or a VCO. The ability to directly tune the PHC is
> >     essential to reap the benefit of hardware timestamping.
> 
> There is a reason for not being able to shift posix clocks: The system has
> one time base. The various clocks are contributing to maintaining that
> sytem wide time.
> 
> I do not understand why you want to maintain different clocks running at
> different speeds. Certainly interesting for some uses I guess that I
> do not have the energy to imagine right now. But can we get the PTP killer
> feature of synchronized accurate system time first?

This was my initial gut reaction as well, but in the end, I agree with
Richard that in the case of one or multiple PTP hardware clocks, we
really can't abstract over the different time domains.



> > 3.3 Synchronizing the Linux System Time
> > ========================================
> >
> >    One could offer a PHC as a combined clock source and clock event
> >    device. The advantage of this approach would be that it obviates
> >    the need for synchronization when the PHC is selected as the system
> >    timer. However, some PHCs, namely the PHY based clocks, cannot be
> >    used in this way.
> 
> Why not? Do PHY based clock not at least provide a counter that increments
> in synchronized intervals throughout the network?

I really don't think the PTP clock can be used as a clocksource sanely.

First, the hardware access is much to slow for system timekeeping.

Second, there is the problem that the system time is a software clock,
and adjustments made (like freq) are made in the layer that interprets
the underlying hardware cycle counter. Adjustments made in PTP (in order
to sync the network timestamps) are made at the hardware level. 

This would cause a disconnect between the hardware freq understood by
the system time management code and the actual hardware freq.

Richard, I'd actually strike this paragraph from the rational, as I feel
it has the tendency to confuse as it suggests having the PHC as a
clocksource is feasible when really it isn't. Or alternatively, maybe
express more clearly why its not feasible, so it doesn't just seem like
a minor design choice.

thanks
-john
