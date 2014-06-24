From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 24 Jun 2014 17:30:30 +0100
Subject: [PATCH] arm: exynos: Modify pm code to check for cortex A9
 rather than the SoC
In-Reply-To: <53A9A568.6060108@samsung.com>
References: <1400814061-12813-1-git-send-email-a.kesavan@samsung.com>
 <CAM4voa=3zzo-2KbjDtBOca+uJeSxT2OYpi+rJuSGsDg-vo7GYA@mail.gmail.com>
 <20140624161114.GW32514@n2100.arm.linux.org.uk>
 <53A9A568.6060108@samsung.com>
Message-ID: <20140624163030.GY32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 24, 2014 at 06:20:56PM +0200, Tomasz Figa wrote:
> Hi Russell,
> 
> On 24.06.2014 18:11, Russell King - ARM Linux wrote:
> > On Mon, Jun 16, 2014 at 09:37:14AM +0530, Abhilash Kesavan wrote:
> >> Hi Kukjin,
> >>
> >> On Fri, May 23, 2014 at 8:31 AM, Abhilash Kesavan <a.kesavan@samsung.com> wrote:
> >>> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> >>
> >> Do you have any comments on this patch ?
> > 
> > I do.
> > 
> >>> diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
> >>> index d10c351..6dd4a11 100644
> >>> --- a/arch/arm/mach-exynos/pm.c
> >>> +++ b/arch/arm/mach-exynos/pm.c
> >>> @@ -300,7 +300,7 @@ static int exynos_pm_suspend(void)
> >>>         tmp = (S5P_USE_STANDBY_WFI0 | S5P_USE_STANDBY_WFE0);
> >>>         __raw_writel(tmp, S5P_CENTRAL_SEQ_OPTION);
> >>>
> >>> -       if (!soc_is_exynos5250())
> >>> +       if (read_cpuid_part_number() == ARM_CPU_PART_CORTEX_A9)
> >>>                 exynos_cpu_save_register();
> > ...
> >>> @@ -334,7 +334,7 @@ static void exynos_pm_resume(void)
> >>>         if (exynos_pm_central_resume())
> >>>                 goto early_wakeup;
> >>>
> >>> -       if (!soc_is_exynos5250())
> >>> +       if (read_cpuid_part_number() == ARM_CPU_PART_CORTEX_A9)
> >>>                 exynos_cpu_restore_register();
> > 
> > It is invalid to check just the part number.  The part number on its
> > own is meaningless without taking account of the implementor.  Both
> > the implementor and the part number should be checked at each of these
> > sites.
> 
> Just out of curiosity, are you aware of more than one implementor of
> Cortex A9 on Exynos SoCs that would differ in having the need for save
> and restore of those registers?

That doesn't stop stuff changing in the future.  We've been here before.
Let's do the job properly if we're going to do the job at all.

If people still whine about this, I will force a change to make it
harder to do the wrong thing - I will get rid of the _part_number
interface replacing it with one which always returns the implementor
as well as the part number so both have to be checked.

> > Another point: exynos have taken it upon themselves to add code which
> > saves various ARM core registers.  This is a bad idea, it brings us
> > back to the days where every platform did their own suspend implementations.
> > 
> > CPU level registers should be handled by CPU level code, not by platform
> > code.  Is there a reason why this can't be added to the Cortex-A9
> > support code in proc-v7.S ?
> 
> I agree that there is nothing platform specific in saving and restoring
> those registers and that this should be probably handled by generic code.
> 
> However, when running in non-secure world, the only way to restore this
> is to call a firmware operation, which is platform specific. Is there a
> way to do something like this from proc-v7.S?

We never call firmware operations from assembly code.  However, in exynos'
case, it's not running in non-secure mode because it's happily reading
and writing these registers with no issue.

Platforms running in non-secure mode already have to ensure that various
work-arounds are implemented in their firmware/boot loader, and this
really is no different (we wouldn't need this code in the kernel in the
first place if the firmware/boot loader would get its act together.)

> > And presumably with the CPU level code dealing with those registers,
> > you don't need the calls to save and restore these registers in this
> > notifier.
> > 
> > Which, by the way, is probably illegal to run as it runs in a read-
> > lock code path and with the SCU disabled.  As you're calling
> > scu_enable() that means you're non-coherent with the other CPUs,
> > and therefore locks don't work.
> 
> I don't see the read lock code path you mention. Could you elaborate on
> this? By the way, other CPUs are still offline at this point.

We get there from kernel/cpu_pm.c, when the notifier chain is called.
The notifier chain is called while taking a read lock on
cpu_pm_notifier_lock.

If this is about the last CPU going down, then why the notifier?  Why
not put the code in exynos_suspend_enter() ?  Why add this needless
complexity?

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
