From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 2 Sep 2013 11:25:18 +0100
Subject: [RFC PATCH 12/14] arm64: kernel: add cpu_{suspend}/{resume}
 build infrastructure
In-Reply-To: <20130830173230.GL4650@arm.com>
References: <1377689766-17642-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1377689766-17642-13-git-send-email-lorenzo.pieralisi@arm.com>
 <20130830173230.GL4650@arm.com>
Message-ID: <20130902102517.GE2500@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 30, 2013 at 06:32:30PM +0100, Catalin Marinas wrote:
> On Wed, Aug 28, 2013 at 12:36:04PM +0100, Lorenzo Pieralisi wrote:
> > To enable the suspend infrastructure for the ARM64 kernel the
> > corresponding Kconfig and Makefile entries must be updated.
> > 
> > This patch adds a menu entry for power management options and
> > entries to enable newly added suspend/resume implementation.
> > 
> > Makefile changes add appropriate entries to include corresponding
> > files in the kernel image.
> > 
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > ---
> >  arch/arm64/Kconfig         | 12 ++++++++++++
> >  arch/arm64/kernel/Makefile |  1 +
> >  2 files changed, 13 insertions(+)
> > 
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index 5855519..827d95e 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -272,6 +272,18 @@ config SYSVIPC_COMPAT
> >  
> >  endmenu
> >  
> > +menu "Power management options"
> > +
> > +source "kernel/power/Kconfig"
> > +
> > +config ARCH_SUSPEND_POSSIBLE
> > +	def_bool y
> > +
> > +config ARM_CPU_SUSPEND
> > +	def_bool y
> 
> I think we should call this ARM64_CPU_SUSPEND. The cpuidle drivers need
> to be modified anyway since things like set_cr(), scu_power_mode() etc.
> no longer apply. If a driver supports both, that's great, it can select
> both ARM and ARM64.

I think you are right, ARM and ARM64 implementations cannot simply cohexist,
given assembly dependency in the first place.

> Longer term, I would like a generic cpuidle driver for PSCI with DT
> bindings for describing the sleep states, target residency (not sure how
> this would look like yet).

Yes, that's planned but independent of this set, which is more related
to core functions on top of which idle and S2R drivers can be implemented.
True, we have to keep the code users (CPUidle and S2R) in mind while designing
the interface, to cater for all requirements (eg CPU idle C-state parameter
for PSCI).

Thanks a lot,
Lorenzo
