From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 17 Mar 2014 17:29:44 +0000
Subject: PL310 errata workarounds
In-Reply-To: <20140317153738.GB21483@n2100.arm.linux.org.uk>
References: <20140314144835.GP21483@n2100.arm.linux.org.uk>
 <20140314150110.GQ21483@n2100.arm.linux.org.uk>
 <CAL_JsqLuNz4EzGaQdb5eFSX5ip-spcDTFsNaFN094=XB_iPV3g@mail.gmail.com>
 <20140316115207.GW21483@n2100.arm.linux.org.uk>
 <CAL_Jsq+9Dm9S6rhQAt_umOM6T_x21O=Y_PPg0QyCH1zR_=yWoA@mail.gmail.com>
 <20140317153738.GB21483@n2100.arm.linux.org.uk>
Message-ID: <20140317172943.GI24070@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 17, 2014 at 03:37:38PM +0000, Russell King - ARM Linux wrote:
> On Mon, Mar 17, 2014 at 10:04:20AM -0500, Rob Herring wrote:
> > On Sun, Mar 16, 2014 at 6:52 AM, Russell King - ARM Linux
> > <linux@arm.linux.org.uk> wrote:
> > >    The MCPM stuff is another issue: what the conditions are there I've
> > >    no idea, but it looks like other CPUs will be running when it calls
> > >    outer_cache_flush().  MCPM commentry claims that this will be
> > >    "harmless" and I just had to laugh at that - even with this workaround
> > >    enabled, it doesn't fix the problem on L2C-310 R2P0 as the workaround
> > >    implementation only works on R3P0!
> > 
> > For MCPM, is there even a platform that has a PL310 used as an L3? I
> > suppose architecturally it is possible, but in reality it is probably
> > not something that's ever been tested.
> 
> I have no idea about MCPM

I assume that the MCPM comment about outer_cache_flush() being harmless
is because it is assumed to be a no-op. In the mach-vexpress/dcscb.c
file, there is a v7_exit_coherency_flush() prior to outer_flush_all().
While it looks like the right way, the comment for
v7_exit_coherency_flush() states that ldrex/strex no longer work after
the call.

You could do with a lock-less outer_flush_all(), even though it is a
background operation assuming there is no race (single CPU running). I
think your big clean-up series is already hiding outer_flush_all() under
the L2 disable function.

> > This would help with contention in readl/writel, but you still have
> > most all the overhead of a spinlock. I'm not sure which is the bigger
> > component: lock contention or all the loads, stores and dsb/dmbs
> > associated with the lock.
> 
> Using the arch r/w locks is not that heavy, and doesn't have the problem
> that interrupts are locked out during much of the L2 maintanence.  Even
> with arch r/w locks, the L2 cache ops don't show up much in perf, compared
> to the existing implementation where they show quite highly.
> 
> The only issue is we'd only be able to use this optimisation when we
> aren't running in IRQ context anyway, which I think isn't that great a
> restriction on it.

IIRC Will had a patch for this but I don't remember whether it showed
any improvements (I guess not since the patch hasn't been pushed).

> > Isn't using by way ops potentially broken if you are running a secure
> > OS? If linux is doing a by way operation and the secure OS does range
> > operations, someone is going to crash on an abort. I suppose no one
> > sees this due to the limited function of secure OSs.
> 
> Let's cover that should it happen - a secure OS should check the status
> of the L2 hardware before issuing any cache operation anyway for exactly
> this reason (you can always read from the L2 registers to check whether
> any operation is in progress.)

But between the secure OS check and the actual operation, Linux could
start a background one (the SMP case). If this happens, the hardware
generates an error signal, I guess this translates to an external abort
(I haven't tried it but it doesn't look to safe for the secure world).

-- 
Catalin
