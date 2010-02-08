From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 08 Feb 2010 11:28:03 +0000
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <20100208105209.GA31671@atrey.karlin.mff.cuni.cz>
References: <20100208065519.GE1290@ucw.cz>
	<1265622676.4020.19.camel@pc1117.cambridge.arm.com>
	<20100208105209.GA31671@atrey.karlin.mff.cuni.cz>
Message-ID: <1265628483.4020.63.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-02-08 at 10:52 +0000, Pavel Machek wrote:
> > On Mon, 2010-02-08 at 06:55 +0000, Pavel Machek wrote:
> > > > > So, let's put this in the HCD drivers and be done with it.
> > > >
> > > > The patch below is what fixes the I-D cache incoherency issues on ARM. I
> > > > don't particularly like the solution but it seems to be the only one
> > > > available.
> > >
> > > Really? It looks like arm should just flush the caches when mapping
> > > executable page to the userspace.... you can't expect all the drivers
> > > to be modified like that...
> >
> > We could of course flush the caches every time we get a page fault but
> > that's far from optimal, especially since DMA-capable drivers to do
> > not
> 
> Maybe far for optimal, but it is something that should be done,
> _first_. Correctness is more important than performance, and you can't
> expect all drivers to behave like you want them.

I wouldn't call heavy cache flushing "correctness". We could as well
disable the caches so that it is fully coherent.

The arch code follows an API defined in cachetlb.txt but the PIO drivers
don't (some do, like mmci.c). It may be inconvenient to call
flush_dcache_page() in the driver, hence I started a discussion on
linux-arch on a PIO mapping API that x86 or other fully coherent
architectures can leave it as no-ops.

> Then you can add optimalizations not to do the flushes on drivers you
> audited and where you care...

Sorry but that's not really feasible (unless I don't fully understand
what you mean) - if we do the cache flushing on the fault handling path
in the arch code, there is no way for the arch code to know what driver
is doing, unless we make this conditionally compiled with something like
CONFIG_ARCH_NEEDS_HEAVY_FLUSHING.

-- 
Catalin
