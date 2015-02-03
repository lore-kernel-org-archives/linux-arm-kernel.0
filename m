From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 3 Feb 2015 11:58:55 +0000
Subject: [PATCH 2/2] coresight: Adding coresight support to arm64
In-Reply-To: <CANLsYky9_ptcvihnKNVvrAH_iB4wA57m4OSwVsYANX3q28gc0g@mail.gmail.com>
References: <1422658466-23984-1-git-send-email-mathieu.poirier@linaro.org>
 <1422658466-23984-3-git-send-email-mathieu.poirier@linaro.org>
 <20150202134512.GE31847@arm.com>
 <CANLsYky9_ptcvihnKNVvrAH_iB4wA57m4OSwVsYANX3q28gc0g@mail.gmail.com>
Message-ID: <20150203115855.GC3677@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 02, 2015 at 10:06:16PM +0000, Mathieu Poirier wrote:
> On 2 February 2015 at 06:45, Will Deacon <will.deacon@arm.com> wrote:
> > On Fri, Jan 30, 2015 at 10:54:26PM +0000, mathieu.poirier at linaro.org wrote:
> >> From: Mathieu Poirier <mathieu.poirier@linaro.org>
> >>
> >> Aside from tracers, all currently supported coresight IP blocks
> >> are 64 bit ready.  As such add the required symbol definition to
> >> compile the framework and drivers.
> >>
> >> Also fixing a couple of warnings picked up by the 64bit compiler.
> >>
> >> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> >> ---
> >>  arch/arm64/Kconfig.debug            | 48 +++++++++++++++++++++++++++++++++++++
> >>  drivers/coresight/coresight-etb10.c |  2 +-
> >>  drivers/coresight/coresight-tmc.c   |  2 +-
> >>  3 files changed, 50 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/arch/arm64/Kconfig.debug b/arch/arm64/Kconfig.debug
> >> index 5fdd6dce8061..77dfebbcbffe 100644
> >> --- a/arch/arm64/Kconfig.debug
> >> +++ b/arch/arm64/Kconfig.debug
> >> @@ -66,4 +66,52 @@ config DEBUG_SET_MODULE_RONX
> >>            against certain classes of kernel exploits.
> >>            If in doubt, say "N".
> >>
> >> +menuconfig CORESIGHT
> >> +     bool "CoreSight Tracing Support"
> >> +     select ARM_AMBA
> >> +     help
> >> +       This framework provides a kernel interface for the CoreSight debug
> >> +       and trace drivers to register themselves with. It's intended to build
> >> +       a topological view of the CoreSight components based on a DT
> >> +       specification and configure the right serie of components when a
> >> +       trace source gets enabled.
> >
> > Why does this need to be duplicated by each architecture wanting to make
> > use of coresight capabilities defined under drivers/coresight? Can't we
> > instead have this menuconfig and associated suboptions defined by a core
> > Kconfig file, then have HAVE_ARCH_CORESIGHT_TRACE or something which can
> > be selected by architectures wanting to make use of the framework?
> >
> > Will
> 
> "arch/arm/Kconfig.debug" and "arch/arm64/Kconfig.debug" already have a
> fair amount of duplication so I wasn't sure if this is the approach
> you guys wanted to take.  I agree that a common core Kconfig file
> would make much more sense and I see a couple of ways to do this:
> 
> 1) lib/Kconfig.debug being sourced by both arm/Kconfig.debug and
> arm64/Kconfig.debug.  We can add a lib/Kconfig.coresight or
> lib/Kconfig.arm and source them the same way.
> 
> 2) Adding coresight entries to the Kconfig.debug made sense a while
> back.  Maybe it is time to move them to drivers/coresight/Kconfig...
> That way it would be easily accessible by both arm and arm64.

Since the C files and Makefile are in drivers/coresight/, it makes sense
to add a drivers/coresight/Kconfig that could be sourced from
arch/arm*/Kconfig (we do this with PCI for example).

-- 
Catalin
