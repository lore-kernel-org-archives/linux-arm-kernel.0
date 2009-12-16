From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 16 Dec 2009 10:54:03 +0000
Subject: [PATCH 5/5] arm/perfevents: implement perf event support for ARMv6
In-Reply-To: <20091215153627.GQ4141@wear.picochip.com>
References: <1260875712-29712-1-git-send-email-jamie.iles@picochip.com>
	<1260875712-29712-2-git-send-email-jamie.iles@picochip.com>
	<1260875712-29712-3-git-send-email-jamie.iles@picochip.com>
	<1260875712-29712-4-git-send-email-jamie.iles@picochip.com>
	<1260875712-29712-5-git-send-email-jamie.iles@picochip.com>
	<1260875712-29712-6-git-send-email-jamie.iles@picochip.com>
	<20091215150205.GO4141@wear.picochip.com>
	<20091215151903.GP4141@wear.picochip.com>
	<1260891013.4165.466.camel@twins>
	<20091215153627.GQ4141@wear.picochip.com>
Message-ID: <20091216105403.GX4141@wear.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 15, 2009 at 03:36:27PM +0000, Jamie Iles wrote:
> On Tue, Dec 15, 2009 at 04:30:13PM +0100, Peter Zijlstra wrote:
> > On Tue, 2009-12-15 at 15:19 +0000, Jamie Iles wrote:
> > > Another problem with mpcore support is that
> > > with the v6 performance counters, you can't disable a single event
> > > counter. 
> > 
> > Can you program them with a non-counting event?
> > 
> > On x86 there's various ways of doing that, either by selecting an event
> > that simply doesn't count (cache-misses with 0 MESI mask), or by telling
> > it to mask both user and kernel event.
> That's exactly what I do for single core ARMv6. However, in the list of events
> for mpcore I can't see any that wouldn't count. There's plenty of reserved
> identifiers though so hopefully one of those will do the job. Also, ARM
> counters can't be set to exclude any modes.
Thinking about this a bit more, although we can't disable the counters, we can
disable their interrupt reporting. So, when the generic perf events layer
calls pmu->disable(event), we do the update of the event then turn off the
IRQ. When we come to unthrottling, the counter will have carried on counting,
but if we set the period again, the counter gets set with the correct restart
value and then reenabled.

I think this should work for mpcore and is also required for the cycle counter
on all v6 cores. I've given this a go using an artificially low period on a
cycle counter and it does appear to do the job.

Thanks,

Jamie
