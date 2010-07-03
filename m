From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 3 Jul 2010 21:28:45 +0100
Subject: Some benchmarks on ARM
In-Reply-To: <4C2F98BD.9020803@xenomai.org>
References: <20100702180257.GA8767@pengutronix.de>
	<4C2F98BD.9020803@xenomai.org>
Message-ID: <20100703202845.GA23954@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 03, 2010 at 10:08:29PM +0200, Gilles Chanteperdrix wrote:
> Robert Schwebel wrote:
> > Hi,
> > 
> > We have recently made some benchmarks, in order to get a little bit
> > better fealing about where ARM cpus are today, especially when it comes
> > to the "recent" ones, and in comparism to the Atom. So we collected a
> > few benchmarks (most from lmbench) and did some actual measurements.
> > 
> > Here is a little article:
> > http://www.pengutronix.de/development/kernel/arm-benchmarks-20100702_en.html
> > 
> > I'm pretty sure that there are quite a few things where people on ALKML
> > have good ideas where the effects come from or how to improve the
> > methodology - so I'd be glad to get some feedback from the community!
> > 
> > All measurements have been done on 2.6.34.
> 
> The context switch time for PXA270 looks really suspicious. The worst
> case context switch time of an AT91RM9200, an armv4 running at 180MHz,
> is less than 300us, so, I doubt that the context switch time of a PXA
> can be that worse.

The measurement is of the thread and MM switch time, which'll involve
cache flushes on <= ARMv5.

On PXA, we have to 'read' (via means of D cache line allocations) 32K
of data into the cache in order to cause the existing data to be written
out.  These are done from a range of addresses which don't exist in the
page tables, and so should not cause any bus activity other than the
write-outs.  However, the cache still has to interact with the MMU to
try to fetch the requested data - which probably consumes some cycles.

ARM920 on the other hand can walk through every cache line and clean+
invalidate it.  It has 64 lines in each segment, and 8 segments, each
line 32 bytes long, which gives a cache size of 16K.

I'd therefore expect ARM920's cache flushing to be quicker (in terms
of cycles consumed) than PXA.
