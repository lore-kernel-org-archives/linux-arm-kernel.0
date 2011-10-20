From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 20 Oct 2011 09:21:52 +0100
Subject: [PATCH v4 0/4] genirq: handling GIC per-cpu interrupts
In-Reply-To: <4E9D7364.2020209@arm.com>
References: <1317661446-2876-1-git-send-email-marc.zyngier@arm.com>
	<20111013181415.GM21648@n2100.arm.linux.org.uk>
	<4E9D7364.2020209@arm.com>
Message-ID: <20111020082152.GX21648@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 18, 2011 at 01:39:00PM +0100, Marc Zyngier wrote:
> On 13/10/11 19:14, Russell King - ARM Linux wrote:
> > On Mon, Oct 03, 2011 at 06:04:02PM +0100, Marc Zyngier wrote:
> >> The current GIC per-cpu interrupts (aka PPIs) suffer from a number of
> >> problems:
> >>
> >> - They use a completely separate scheme to handle the interrupts,
> >>   mostly because the PPI concept doesn't really match the kernel view
> >>   of an interrupt.
> >> - PPIs can only be used by the timer code, unless we add more low-level
> >>   assembly code.
> >> - The local timer code can only be used by devices generating PPIs,
> >>   and not SPIs.
> >> - At least one platform (msm) has started implementing its own
> >>   alternative scheme.
> >> - Some low-level code gets duplicated, as usual...
> >>
> >> The proposed solution is to handle the PPIs using the same path as
> >> SPIs. A new core API is added to deal with per-cpu interrupts in a
> >> less awkward way. The local timer code is updated to reflect these
> >> changes.
> >>
> >> The core API changes are based on an initial idea by Thomas Gleixner.
> >>
> >> Tested on ARM Versatile Express (Cortex A15), ARM RealView PB11MP,
> >> OMAP4 (Panda) and Tegra (Harmony). Patch series against next-20110930.
> >>
> >> The two first patches can also be found in Thomas' tree:
> >>
> >> 	git://tesla.tglx.de/git/linux-2.6-tip irq/core
> > 
> > So, how do we deal with merging this without ending up with some
> > problematical inter-tree dependencies?
> > 
> > It looks like I'll see conflicts with:
> > arch/arm/common/gic.c
> > arch/arm/kernel/smp.c
> > arch/arm/include/asm/localtimer.h
> > 
> > and possibly:
> > arch/arm/include/asm/smp.h
> > arch/arm/kernel/irq.c
> > 
> > as well.  I've not checked with patch 4, so there may be some more too.
> > 
> > Some of this is probably because of 7123/1 and 7124/1.
> 
> I've set up a branch based on your "smp" branch, resolving the above
> conflicts:
> 
> git://github.com/mzyngier/arm-platforms.git ppi-for-rmk

Please send me a proper pull request - and this almost got lost because it
doesn't have a PULL tag in the subject line (and would've if Shawn Guo
hadn't replied to this).
