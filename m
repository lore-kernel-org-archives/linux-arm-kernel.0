From: John.Linn@xilinx.com (John Linn)
Date: Sun, 3 Apr 2011 15:15:27 -0600
Subject: RFC, GIC based smp_cross_call cleanup suggestion
In-Reply-To: <20110403103730.GB4213@n2100.arm.linux.org.uk>
References: <10921831-0170-4106-bb3a-a52515a32c3e@VA3EHSMHS002.ehs.local>
	<BANLkTimY+mRXqT7NwUQ86SxnfKw0HX-pTQ@mail.gmail.com>
	<20110402085133.GE8482@n2100.arm.linux.org.uk>
	<BANLkTim+bco_90iPLrc1ioV4bdSw+LRzQQ@mail.gmail.com>
	<BANLkTimjyBzh3Kc+1njcBBYCouKdSWhgng@mail.gmail.com>
	<20110403103730.GB4213@n2100.arm.linux.org.uk>
Message-ID: <89732ceb-5e61-4601-83dc-f6a315a7c9aa@VA3EHSMHS023.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Sunday, April 03, 2011 4:38 AM
> To: grant.likely at secretlab.ca
> Cc: Colin Cross; Paul Mundt; Magnus Damm; John Linn; linux-arm-
> kernel at lists.infradead.org; Santosh Shilimkar
> Subject: Re: RFC, GIC based smp_cross_call cleanup suggestion
> 
> On Sat, Apr 02, 2011 at 10:47:57PM -0600, Grant Likely wrote:
> > On Sat, Apr 2, 2011 at 3:10 AM, Colin Cross <ccross@google.com>
> wrote:
> > > On Sat, Apr 2, 2011 at 1:51 AM, Russell King - ARM Linux
> > > <linux@arm.linux.org.uk> wrote:
> > >> On Fri, Apr 01, 2011 at 04:55:02PM -0600, Grant Likely wrote:
> > >>> On Fri, Apr 1, 2011 at 4:26 PM, John Linn <John.Linn@xilinx.com>
> wrote:
> > >>> > I?m getting ready to submit a patch to add SMP to Xilinx code.
> I notice that
> > >>> > smp_cross_call for all GIC based platforms is duplicated across
> each
> > >>> > platform in smp.h.
> > >>> >
> > >>> >
> > >>> >
> > >>> > I thought I?d try to jump in to help with some cleanup,
> although I realize
> > >>> > it?s minimal, I have to start somewhere.
> > >>> >
> > >>> >
> > >>> >
> > >>> > What about moving the smp_cross_call for GIC based designs into
> gic.h?
> > >>>
> > >>> Go for it. ?It's an obvious cleanup.
> > >>
> > >> That assumes that all SMP implementations will always have a GIC.
> ?It
> > >> looks to me like this is conditional on shmobile, and so I don't
> think
> > >> its that trivial - maybe Paul or Magnus can first indicate why
> this is.
> > >
> > > OMAP4 may also require a custom smp_cross_call implementation if
> CPU
> > > idle is going to be supported in SMP - in CPU off idle modes, a GIC
> > > SGI will not wake the CPU, and a write directly to the CPU's power
> > > management controller or an external interrupt source would be
> > > required.
> >
> > What John proposes appears to be a pretty sane default though.  It
> > would make sense to move it to common code, and require explicit
> > action on the part of the subarch to compile it out for a different
> > behaviour.  Requiring each subarch to define it explicitly doesn't
> > seem optimal.
> 
> Bear in mind that the GIC doesn't do any PM support, so the hardware
> folk are inventing their own IRQ controller to sit along side the GIC
> to provide that missing functionality.  What I expect will happen is
> that the GIC will be obsoleted and replaced by something integrating
> PM support.
> 
> So we could end up in the situation where we need both GIC and
> something
> else in the kernel at the same time - especially if we persue the
> single
> kernel image thing.  Moving smp_cross_call() into gic.h would add an
> additional bar to that happening.
> 
> A better solution may be to make smp_cross_call() be a function pointer
> which must be initialized as part of the platforms SMP initialization.
> That'd get rid of mach/smp.h entirely.
> 
> Oh, and while looking at that, guess what annoyingly stands in the way
> of eliminating mach/smp.h ?  Yes, it's OMAP, because they've bunged
> some
> function prototypes into plat/smp.h.  (I've not cared about that in the
> patch below; I've deleted the entire thing, so it probably breaks
> OMAP.)
> 
>  arch/arm/include/asm/smp.h                |    6 +----
>  arch/arm/kernel/smp.c                     |    7 +++++
>  arch/arm/mach-exynos4/include/mach/smp.h  |   19 ---------------
>  arch/arm/mach-exynos4/platsmp.c           |    5 +++-
>  arch/arm/mach-msm/include/mach/smp.h      |   23 -------------------
>  arch/arm/mach-msm/platsmp.c               |    4 ++-
>  arch/arm/mach-omap2/omap-smp.c            |    5 +++-
>  arch/arm/mach-realview/include/mach/smp.h |   14 -----------
>  arch/arm/mach-realview/platsmp.c          |    3 ++
>  arch/arm/mach-shmobile/include/mach/smp.h |   16 -------------
>  arch/arm/mach-shmobile/platsmp.c          |    3 ++
>  arch/arm/mach-tegra/include/mach/smp.h    |   14 -----------
>  arch/arm/mach-tegra/platsmp.c             |    3 ++
>  arch/arm/mach-ux500/include/mach/smp.h    |   24 --------------------
>  arch/arm/mach-ux500/platsmp.c             |    5 +++-
>  arch/arm/mach-vexpress/ct-ca9x4.c         |    2 +
>  arch/arm/mach-vexpress/include/mach/smp.h |   13 ----------
>  arch/arm/plat-omap/include/plat/smp.h     |   36 ---------------------
> ---------
>  arch/arm/plat-versatile/platsmp.c         |    3 +-
>  19 files changed, 37 insertions(+), 168 deletions(-)
> 

Hi Russell,

I realize my SMP patch set I just sent out doesn't take this into account yet.  

I thought I needed to get it out for review since there's likely to be changes.

I can make this change to my patch set easily if it's the direction you go.

Thanks,
John

This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
