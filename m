From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 22 Feb 2013 15:26:39 +0000
Subject: too many timer retries happen when do local timer swtich with
 broadcast timer
In-Reply-To: <alpine.LFD.2.02.1302221558000.22263@ionos>
References: <alpine.LFD.2.02.1302211436300.22263@ionos> <51263975.20906@ti.com>
 <alpine.LFD.2.02.1302212214020.22263@ionos>
 <5127436E.4040100@ti.com>
 <alpine.LFD.2.02.1302221122290.22263@ionos>
 <20130222103149.GC12140@e102568-lin.cambridge.arm.com>
 <51275058.7010809@ti.com>
 <alpine.LFD.2.02.1302221212500.22263@ionos>
 <20130222144829.GG12140@e102568-lin.cambridge.arm.com>
 <alpine.LFD.2.02.1302221558000.22263@ionos>
Message-ID: <20130222152639.GH12140@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 22, 2013 at 03:03:02PM +0000, Thomas Gleixner wrote:
> On Fri, 22 Feb 2013, Lorenzo Pieralisi wrote:
> > On Fri, Feb 22, 2013 at 12:07:30PM +0000, Thomas Gleixner wrote:
> > > Now we could make use of that and avoid going deep idle just to come
> > > back right away via the IPI. Unfortunately the notification thingy has
> > > no return value, but we can fix that.
> > > 
> > > To confirm that theory, could you please try the hack below and add
> > > some instrumentation (trace_printk)?
> > 
> > Applied, and it looks like that's exactly why the warning triggers, at least
> > on the platform I am testing on which is a dual-cluster ARM testchip.
> > 
> > There is a still time window though where the CPU (the IPI target) can get
> > back to idle (tick_broadcast_pending still not set) before the CPU target of
> > the broadcast has a chance to run tick_handle_oneshot_broadcast (and set
> > tick_broadcast_pending), or am I missing something ?
> 
> Well, the tick_broadcast_pending bit is uninteresting if the
> force_broadcast bit is set. Because if that bit is set we know for
> sure, that we got woken with the cpu which gets the broadcast timer
> and raced back to idle before the broadcast handler managed to
> send the IPI.

Gah, my bad sorry, I mixed things up. I thought

tick_check_broadcast_pending()

was checking against the tick_broadcast_pending mask not

tick_force_broadcast_mask

as it correctly does.

All clear now.

Thanks a lot,
Lorenzo
