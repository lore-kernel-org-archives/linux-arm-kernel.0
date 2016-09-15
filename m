From: will.deacon@arm.com (Will Deacon)
Date: Thu, 15 Sep 2016 11:15:35 +0100
Subject: [GIT PULL] arm64: X-Gene platforms DTS changes queued for 4.9 -
 part1
In-Reply-To: <5104796.MOduSCrlzf@wuerfel>
References: <CADaLNDkZdAipxx6cfLJ6yrzTrcLPS_Ciw8+T5EUFVcRRw+fjPw@mail.gmail.com>
 <CADaLNDmMEWEd4o-tf4Kcqy7PP-abBg=Q1-Qdvv5CoDdoLEvi=Q@mail.gmail.com>
 <20160915072709.GA3380@arm.com> <5104796.MOduSCrlzf@wuerfel>
Message-ID: <20160915101535.GC3380@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 15, 2016 at 09:57:52AM +0200, Arnd Bergmann wrote:
> On Thursday, September 15, 2016 8:30:30 AM CEST Will Deacon wrote:
> > On Wed, Sep 14, 2016 at 06:57:59PM -0700, Duc Dang wrote:
> > > On Wed, Sep 14, 2016 at 7:59 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > > > On Friday, September 2, 2016 11:46:31 AM CEST Duc Dang wrote:
> > > > Please send this again as two pull requests, one for the dts changes, and
> > > > one for the rest (pmu driver, binding and MAINTAINERS file). Please
> > > > also include an explanation in the tag description about why this gets
> > > > merged through arm-soc. I see that Will suggested doing it that way,
> > > > but I don't see what the reason is. We normally don't touch that directory.
> > > Hi Arnd,
> > > 
> > > I am not clear about the reason either. Probably we don't have a
> > > dedicated tree for SoC PMU?
> > 
> > That's right, there isn't a dedicated tree for SoC PMUs. I tend to handle
> > the architected PMUs (e.g. the ones in the CPUs), but other PMUs have
> > been ad-hoc in the past. That said, Mark and I do tend to review PMU
> > drivers, because the internal perf interface is pretty easy to get wrong.
> > 
> > Arnd -- what would you like to see here? I could collect SoC PMU patches
> > together and send you a pull request, or would you like me to take them via
> > the arm64 tree? It's worth noting that we have PMU drivers under drivers/bus
> > and drivers/hwtracing too, and I *think* arm-soc has handled those in the
> > past.
> 
> I (and I suspect the same of Olof) don't understand enough about PMU drivers
> to be a good gatekeeper for PMU drivers, so I've had to rely on platform
> maintainers to know what they are doing when they sent me a driver in
> the past. I had not realized  that we already have those drivers in multiple
> places, and that seems reason enough to get a maintainer for them who
> can review and apply the patches, as well as possibly consolidate them
> in once place.
> 
> I don't mind forwarding the drivers to Linus in the next/drivers branch
> of arm-soc, like we do for drivers/reset which also has its own maintainer
> who picks up the patches to forward them to us.
> 
> It would certainly help us if you can collect the changes and forward them,
> thanks a lot for the offer! Since I know you have a lot on your plate
> already, how about finding another co-maintainer who doesn't already
> own a subsystem but understands PMUs and could use some on-the-job
> training for this?

Well, I already have Mark as a Reviewer for the ARM perf stuff, so I could
change him to be a co-maintainer [patch below] and between us we'll send
pull requests your way. That also works out with the arm64 tree, where
Catalin and I take it in turns each release. Given that we're already
reviewing the PMU drivers, I don't think it should be too much extra work.
Of course, if somebody else starts reviewing on the list, then I'm more
than happy to get them involved too.

Finally, it would then be helpful if you keep an eye out for any PMU
patches coming in via other routes to arm-soc, so we can point people to
put their SoC PMU code under drivers/perf/ instead.

> For v4.9, I'd just take the pull request once Duc resends separate
> branches, and then we start a more formal procedure for v4.10 (or
> late if there are no PMU patches during that time).

Thanks,

Will

--->8

>From 436d3a7ad25517433fc8f563f44fdab3c4801666 Mon Sep 17 00:00:00 2001
From: Will Deacon <will.deacon@arm.com>
Date: Thu, 15 Sep 2016 10:14:41 +0100
Subject: [PATCH] MAINTAINERS: Update ARM PMU PROFILING AND DEBUGGING entry

There are an increasing number of ARM SoC PMU drivers appearing for
things like interconnects, memory controllers and cache controllers.
Rather than have these handled on an ad-hoc basis, where SoC maintainers
each send their PMU drivers directly to arm-soc, let's take these into
drivers/perf/ and send a single pull request to arm-soc instead, much
like other subsystems.

This patch amends the ARM PMU MAINTAINERS entry to include all of
drivers/perf/ (currently just the ARM CPU PMU), changes Mark Rutland
from Reviewer to Maintainer, so that he can help with the new tree and
adds the device-tree binding to the list of maintained files.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 MAINTAINERS | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6781a3febd59..090694e685ba 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -913,15 +913,16 @@ F:	arch/arm/include/asm/floppy.h
 
 ARM PMU PROFILING AND DEBUGGING
 M:	Will Deacon <will.deacon@arm.com>
-R:	Mark Rutland <mark.rutland@arm.com>
+M:	Mark Rutland <mark.rutland@arm.com>
 S:	Maintained
 F:	arch/arm*/kernel/perf_*
 F:	arch/arm/oprofile/common.c
 F:	arch/arm*/kernel/hw_breakpoint.c
 F:	arch/arm*/include/asm/hw_breakpoint.h
 F:	arch/arm*/include/asm/perf_event.h
-F:	drivers/perf/arm_pmu.c
+F:	drivers/perf/*
 F:	include/linux/perf/arm_pmu.h
+F:	Documentation/devicetree/bindings/arm/pmu.txt
 
 ARM PORT
 M:	Russell King <linux@armlinux.org.uk>
-- 
2.5.0
