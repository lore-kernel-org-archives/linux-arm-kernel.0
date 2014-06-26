From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 26 Jun 2014 18:11:10 +0100
Subject: [PATCH] ARM: make it easier to check the CPU part number correctly
In-Reply-To: <20140626163501.GY32514@n2100.arm.linux.org.uk>
References: <20140624183908.GB32514@n2100.arm.linux.org.uk>
 <20140626162618.GO15240@leverpostej>
 <20140626163501.GY32514@n2100.arm.linux.org.uk>
Message-ID: <20140626171110.GE27364@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Thu, Jun 26, 2014 at 05:35:02PM +0100, Russell King - ARM Linux wrote:
> On Thu, Jun 26, 2014 at 05:26:18PM +0100, Mark Rutland wrote:
> > Hi Russell,
> > 
> > On Tue, Jun 24, 2014 at 07:39:08PM +0100, Russell King - ARM Linux wrote:
> > > Ensure that platform maintainers check the CPU part number in the right
> > > manner: the CPU part number is meaningless without also checking the
> > > CPU implement(e|o)r (choose your preferred spelling!)  Provide an
> > > interface which returns both the implementer and part number together,
> > > and update the definitions to include the implementer.
> > > 
> > > Mark the old function as being deprecated... indeed, using the old
> > > function with the definitions will now always evaluate as false, so
> > > people must update their un-merged code to the new function.  While
> > > this could be avoided by adding new definitions, we'd also have to
> > > create new names for them which would be awkward.
> > > 
> > > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > > ---
> > >  arch/arm/include/asm/cputype.h         | 37 +++++++++++++++--------
> > >  arch/arm/include/asm/smp_scu.h         |  2 +-
> > >  arch/arm/kernel/perf_event_cpu.c       | 55 +++++++++++++++++-----------------
> > >  arch/arm/kvm/guest.c                   |  8 +----
> > >  arch/arm/mach-exynos/mcpm-exynos.c     |  2 +-
> > >  arch/arm/mach-exynos/platsmp.c         |  4 +--
> > >  arch/arm/mach-vexpress/tc2_pm.c        |  2 +-
> > >  arch/arm/mm/cache-l2x0.c               |  2 +-
> > >  arch/arm64/include/asm/cputype.h       |  5 ++++
> > >  drivers/clocksource/arm_global_timer.c |  2 +-
> > >  10 files changed, 64 insertions(+), 55 deletions(-)
> > 
> > It looks like you missed drivers/cpuidle/cpuidle-big_little.c, which has
> > a homebrew comparison in bl_idle_driver_init.
> > 
> > I'm slightly confused by the diffstat -- it shows changes to
> > arch/arm64/include/asm/cputype.h, for which I can't see the
> > corresponding diff. Did you mean to drop that?
> 
> Yes, I don't think arm_global_timer.c is used by ARM64, so I dropped that
> change.
> 
> Yes, it looks like I missed cpuidle-big_little.c, but now that you point
> it out, I have to ask whether this is really coded in an easy to understand
> way:
> 
>                 /* read cpu id part number */
>                 if ((cpuid & 0xFFF0) == cpu_id)
>                         cpumask_set_cpu(cpu, cpumask);
> 
> It is /very/ easy to read that as (cpuid & 0xfff0) == cpuid dropping the
> additional underscore.  It may make sense to rename cpu_id to be
> desired_id.  I'd also suggest that this test becomes:
> 
> 		if (((cpuid ^ desired_id) & 0xff00fff0) == 0)
>                         cpumask_set_cpu(cpu, cpumask);
> 
> or:
> 
> 		if ((cpuid & 0xff00fff0) == (desired_id & 0xff00fff0))
>                         cpumask_set_cpu(cpu, cpumask);

Both are fine to me, maybe you can s/cpu_id/match_id/ or something like
that as you mentioned. I will test when you repost it or I can write the
fix myself, as you prefer.

Thank you very much,
Lorenzo
