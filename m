From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 17 Mar 2014 15:37:38 +0000
Subject: PL310 errata workarounds
In-Reply-To: <CAL_Jsq+9Dm9S6rhQAt_umOM6T_x21O=Y_PPg0QyCH1zR_=yWoA@mail.gmail.com>
References: <20140314144835.GP21483@n2100.arm.linux.org.uk>
 <20140314150110.GQ21483@n2100.arm.linux.org.uk>
 <CAL_JsqLuNz4EzGaQdb5eFSX5ip-spcDTFsNaFN094=XB_iPV3g@mail.gmail.com>
 <20140316115207.GW21483@n2100.arm.linux.org.uk>
 <CAL_Jsq+9Dm9S6rhQAt_umOM6T_x21O=Y_PPg0QyCH1zR_=yWoA@mail.gmail.com>
Message-ID: <20140317153738.GB21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 17, 2014 at 10:04:20AM -0500, Rob Herring wrote:
> On Sun, Mar 16, 2014 at 6:52 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> >    The MCPM stuff is another issue: what the conditions are there I've
> >    no idea, but it looks like other CPUs will be running when it calls
> >    outer_cache_flush().  MCPM commentry claims that this will be
> >    "harmless" and I just had to laugh at that - even with this workaround
> >    enabled, it doesn't fix the problem on L2C-310 R2P0 as the workaround
> >    implementation only works on R3P0!
> 
> For MCPM, is there even a platform that has a PL310 used as an L3? I
> suppose architecturally it is possible, but in reality it is probably
> not something that's ever been tested.

I have no idea about MCPM - it's something I've never used, even though
I in theory have hardware which supports it.  From what I can tell,
getting Linux running on the Versatile Express CA15 tile is something of
a black art, there's only a relatively small number of people who have
managed that feat.

> > 2. on large (>= cache size) coherent DMA allocations via outer_flush_range()
> >
> > Consider using CMA for framebuffers, and allocating a 1080p framebuffer.
> > That's going to be around 8MB in size, and that's going to need the L2
> > purged of any cache lines associated with it.  As the L2 cache is
> > normally around 512kB or maybe 1MB, walking every 32-byte cache line is
> > extremely wasteful (that's 259200 clean+invalidate by PA operations, of
> > which a maximum of 32768 could possibly hit a cache line), so we do want
> > to preserve the ability to use this operation.
> 
> Aren't CMA buffers mapped coherently so the flush is not needed?

Not initially, not when they're free, not when they're being re-used for
non-CMA purposes.  Hence, they can contain dirty cache lines which need
to be flushed out of their mappings to avoid interference with the
coherent mapping.

> This would help with contention in readl/writel, but you still have
> most all the overhead of a spinlock. I'm not sure which is the bigger
> component: lock contention or all the loads, stores and dsb/dmbs
> associated with the lock.

Using the arch r/w locks is not that heavy, and doesn't have the problem
that interrupts are locked out during much of the L2 maintanence.  Even
with arch r/w locks, the L2 cache ops don't show up much in perf, compared
to the existing implementation where they show quite highly.

The only issue is we'd only be able to use this optimisation when we
aren't running in IRQ context anyway, which I think isn't that great a
restriction on it.

> Isn't using by way ops potentially broken if you are running a secure
> OS? If linux is doing a by way operation and the secure OS does range
> operations, someone is going to crash on an abort. I suppose no one
> sees this due to the limited function of secure OSs.

Let's cover that should it happen - a secure OS should check the status
of the L2 hardware before issuing any cache operation anyway for exactly
this reason (you can always read from the L2 registers to check whether
any operation is in progress.)

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
