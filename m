From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 17 Mar 2014 19:44:40 +0000
Subject: PL310 errata workarounds
In-Reply-To: <20140317172943.GI24070@arm.com>
References: <20140314144835.GP21483@n2100.arm.linux.org.uk>
 <20140314150110.GQ21483@n2100.arm.linux.org.uk>
 <CAL_JsqLuNz4EzGaQdb5eFSX5ip-spcDTFsNaFN094=XB_iPV3g@mail.gmail.com>
 <20140316115207.GW21483@n2100.arm.linux.org.uk>
 <CAL_Jsq+9Dm9S6rhQAt_umOM6T_x21O=Y_PPg0QyCH1zR_=yWoA@mail.gmail.com>
 <20140317153738.GB21483@n2100.arm.linux.org.uk>
 <20140317172943.GI24070@arm.com>
Message-ID: <20140317194440.GG21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 17, 2014 at 05:29:44PM +0000, Catalin Marinas wrote:
> On Mon, Mar 17, 2014 at 03:37:38PM +0000, Russell King - ARM Linux wrote:
> > On Mon, Mar 17, 2014 at 10:04:20AM -0500, Rob Herring wrote:
> > > On Sun, Mar 16, 2014 at 6:52 AM, Russell King - ARM Linux
> > > <linux@arm.linux.org.uk> wrote:
> > > >    The MCPM stuff is another issue: what the conditions are there I've
> > > >    no idea, but it looks like other CPUs will be running when it calls
> > > >    outer_cache_flush().  MCPM commentry claims that this will be
> > > >    "harmless" and I just had to laugh at that - even with this workaround
> > > >    enabled, it doesn't fix the problem on L2C-310 R2P0 as the workaround
> > > >    implementation only works on R3P0!
> > > 
> > > For MCPM, is there even a platform that has a PL310 used as an L3? I
> > > suppose architecturally it is possible, but in reality it is probably
> > > not something that's ever been tested.
> > 
> > I have no idea about MCPM
> 
> I assume that the MCPM comment about outer_cache_flush() being harmless
> is because it is assumed to be a no-op. In the mach-vexpress/dcscb.c
> file, there is a v7_exit_coherency_flush() prior to outer_flush_all().
> While it looks like the right way, the comment for
> v7_exit_coherency_flush() states that ldrex/strex no longer work after
> the call.
> 
> You could do with a lock-less outer_flush_all(), even though it is a
> background operation assuming there is no race (single CPU running). I
> think your big clean-up series is already hiding outer_flush_all() under
> the L2 disable function.

Almost but not quite - here's the last matches by git grep:

$ git grep outer_flush_all
arch/arm/include/asm/outercache.h: * outer_flush_all: clean and invalidate all c
arch/arm/include/asm/outercache.h:static inline void outer_flush_all(void)
arch/arm/include/asm/outercache.h: * conditions above concerning outer_flush_all
arch/arm/include/asm/outercache.h:static inline void outer_flush_all(void) { }
arch/arm/mach-exynos/pm.c:      outer_flush_all();
arch/arm/mach-vexpress/dcscb.c:         outer_flush_all();

My worry about MCPM is that it talks about the function containing the
outer_flush_all() potentially racing with a different CPU coming online.
It's not clear to me whether that other CPU would be using the same L2
controller or not:

/*
 * We can't use regular spinlocks. In the switcher case, it is possible
 * for an outbound CPU to call power_down() while its inbound counterpart
 * is already live using the same logical CPU number which trips lockdep
 * debugging.
 */

Since this is Nicocode, I think Nicolas has to be the one to sort this
out.  (Added Nico.)

> But between the secure OS check and the actual operation, Linux could
> start a background one (the SMP case). If this happens, the hardware
> generates an error signal, I guess this translates to an external abort
> (I haven't tried it but it doesn't look to safe for the secure world).

Yes, that's true.  However, the only way to be safe from that would be
for the non-secure world to totally avoid the background operations
altogether.  In the case of PL310, that means flushing by set/way or
by PA line, which can get very expensive if you need to flush the
entire cache (eg, because it's going to be powered down.)

The more I think about it, the more I come to the conclusion that the
maintainence side of the L2 cache hasn't been properly thought out in
trustzone context at hardware design stage.

Even so, we've been performing these background operations for years
from Linux already, so I'm not about to try and "fix" this problem
when we haven't had any reports of issues.  Yes, it makes sense to
drop it from the invalidate/clean functions, because these will only
ever be used with the streaming DMA APIs, but the flush function can
be called on some very big areas.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
