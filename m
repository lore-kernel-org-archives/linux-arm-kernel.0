From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 24 Jun 2014 17:11:14 +0100
Subject: [PATCH] arm: exynos: Modify pm code to check for cortex A9
 rather than the SoC
In-Reply-To: <CAM4voa=3zzo-2KbjDtBOca+uJeSxT2OYpi+rJuSGsDg-vo7GYA@mail.gmail.com>
References: <1400814061-12813-1-git-send-email-a.kesavan@samsung.com>
 <CAM4voa=3zzo-2KbjDtBOca+uJeSxT2OYpi+rJuSGsDg-vo7GYA@mail.gmail.com>
Message-ID: <20140624161114.GW32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 16, 2014 at 09:37:14AM +0530, Abhilash Kesavan wrote:
> Hi Kukjin,
> 
> On Fri, May 23, 2014 at 8:31 AM, Abhilash Kesavan <a.kesavan@samsung.com> wrote:
> > Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> 
> Do you have any comments on this patch ?

I do.

> > diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
> > index d10c351..6dd4a11 100644
> > --- a/arch/arm/mach-exynos/pm.c
> > +++ b/arch/arm/mach-exynos/pm.c
> > @@ -300,7 +300,7 @@ static int exynos_pm_suspend(void)
> >         tmp = (S5P_USE_STANDBY_WFI0 | S5P_USE_STANDBY_WFE0);
> >         __raw_writel(tmp, S5P_CENTRAL_SEQ_OPTION);
> >
> > -       if (!soc_is_exynos5250())
> > +       if (read_cpuid_part_number() == ARM_CPU_PART_CORTEX_A9)
> >                 exynos_cpu_save_register();
...
> > @@ -334,7 +334,7 @@ static void exynos_pm_resume(void)
> >         if (exynos_pm_central_resume())
> >                 goto early_wakeup;
> >
> > -       if (!soc_is_exynos5250())
> > +       if (read_cpuid_part_number() == ARM_CPU_PART_CORTEX_A9)
> >                 exynos_cpu_restore_register();

It is invalid to check just the part number.  The part number on its
own is meaningless without taking account of the implementor.  Both
the implementor and the part number should be checked at each of these
sites.

Another point: exynos have taken it upon themselves to add code which
saves various ARM core registers.  This is a bad idea, it brings us
back to the days where every platform did their own suspend implementations.

CPU level registers should be handled by CPU level code, not by platform
code.  Is there a reason why this can't be added to the Cortex-A9
support code in proc-v7.S ?

> > @@ -353,7 +353,7 @@ static void exynos_pm_resume(void)
> >
> >         s3c_pm_do_restore_core(exynos_core_save, ARRAY_SIZE(exynos_core_save));
> >
> > -       if (!soc_is_exynos5250())
> > +       if (read_cpuid_part_number() == ARM_CPU_PART_CORTEX_A9)
> >                 scu_enable(S5P_VA_SCU);
> >
> >  early_wakeup:
> > @@ -440,15 +440,18 @@ static int exynos_cpu_pm_notifier(struct notifier_block *self,
> >         case CPU_PM_ENTER:
> >                 if (cpu == 0) {
> >                         exynos_pm_central_suspend();
> > -                       exynos_cpu_save_register();
> > +                       if (read_cpuid_part_number() == ARM_CPU_PART_CORTEX_A9)
> > +                               exynos_cpu_save_register();
> >                 }
> >                 break;
> >
> >         case CPU_PM_EXIT:
> >                 if (cpu == 0) {
> > -                       if (!soc_is_exynos5250())
> > +                       if (read_cpuid_part_number() ==
> > +                                       ARM_CPU_PART_CORTEX_A9) {
> >                                 scu_enable(S5P_VA_SCU);
> > -                       exynos_cpu_restore_register();
> > +                               exynos_cpu_restore_register();
> > +                       }
> >                         exynos_pm_central_resume();
> >                 }
> >                 break;

And presumably with the CPU level code dealing with those registers,
you don't need the calls to save and restore these registers in this
notifier.

Which, by the way, is probably illegal to run as it runs in a read-
lock code path and with the SCU disabled.  As you're calling
scu_enable() that means you're non-coherent with the other CPUs,
and therefore locks don't work.

I think this code is very broken and wrongly architected, and shows
that we're continuing to make the same mistakes that we made all
through the 2000s with platforms doing their own crap rather than
properly thinking about this stuff.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
