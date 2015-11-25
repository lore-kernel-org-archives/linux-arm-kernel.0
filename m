From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed, 25 Nov 2015 13:50:31 +0100
Subject: [PATCH] ARM: avoid SMP DT initialisation on UP-only capable
 systems
In-Reply-To: <20151125114908.GI8644@n2100.arm.linux.org.uk>
References: <E1a1XXS-00060O-GS@rmk-PC.arm.linux.org.uk>
 <20151125113538.GB12434@leverpostej>
 <20151125114908.GI8644@n2100.arm.linux.org.uk>
Message-ID: <1448455831.3689.55.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, den 25.11.2015, 11:49 +0000 schrieb Russell King - ARM
Linux:
> On Wed, Nov 25, 2015 at 11:35:38AM +0000, Mark Rutland wrote:
> > On Wed, Nov 25, 2015 at 10:43:02AM +0000, Russell King wrote:
> > > arm_dt_init_cpu_maps() initialises the CPU possible map even when the
> > > boot CPU indicates that it is not SMP capable.  This can happen with
> > > SoCs where the SoC may have a single UP-only CPU, or may have a pair of
> > > SMP CPUs - and this is the only difference.
> > > 
> > > One solution is to increase the number of DT files by forcing peopl to
> > > properly describe the hardware: this means all the iMX6DL DT files need
> > > to be duplicated for iMX6S and a whole raft of updates to boot loaders
> > > and the like.
> > >
> > > Another solution is to decide that it is inappropriate to initialise the
> > > cpu_possible map with anything but the boot CPU on non-SMP capable
> > > systems.  This is implemented by this patch.
> > > 
> > > The situation currently may provoke a warning on earlier kernels,
> > > printed during SMP bringup where we attempt to bring CPU1 online inspite
> > > of CPU0 being a UP-only CPU, and this only failing due to the lack of
> > > SMP operations.
> > 
> > I think that even if we work around this, we should have a warning
> > regarding the erroneous DT.
> > 
> > There are plenty of other things people may get wrong in their DT that
> > we may or may not be able to detect and/or workaround. We should
> > generally discourage relying on fixups and encourage people to do the
> > right thing.
> 
> Well, this is the problem with a static description of the hardware -
> it very quickly becomes unmanagable when you have lots of different
> combinations.  For the SR platforms, there are already the base vs
> pro Hummingboard, Cubox-i, Hummingboard edge, Hummingboard Edge,
> Hummingboard Gate, each the choice of iMX6S, DL, D, Q or more uSOMs.
> To cover these "properly" we're going to need 24 DT files rather
> than 12 if we're going to require the CPUs entries to correctly
> describe the hardware.
> 
> Given that CPUs are discoverable from the hardware, this is getting
> to be insane.  Yes, there's cases where we need the CPUs described
> in hardware, but to require the description for all platforms even
> where CPUs are discoverable is IMHO insane.
> 
> I think we need a better solution for this, rather than telling people
> their DT files need to fully describe the hardware, and at the same
> time, be correct.
> 
What we do in barebox is to look into the SCU to find out how many CPU
cores are actually present and fix up the DT passed to the kernel
accordingly by deleting any superfluous CPU nodes. This satisfies both
the need to keep the required DT source files to a minimum, while also
providing correct information to the kernel.

Regards,
Lucas
-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
