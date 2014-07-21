From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Mon, 21 Jul 2014 15:41:44 +0200
Subject: [PATCH v2] ARM: EXYNOS: Fix build with PM_SLEEP=n
In-Reply-To: <93736288.A8L2I1nMme@amdc1032>
References: <1405323953-25954-1-git-send-email-k.kozlowski@samsung.com>
 <1539661.ni665pgzAx@amdc1032> <93736288.A8L2I1nMme@amdc1032>
Message-ID: <19533549.DVV8hdLa08@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, July 21, 2014 02:55:52 PM Bartlomiej Zolnierkiewicz wrote:
> On Monday, July 21, 2014 01:11:14 PM Bartlomiej Zolnierkiewicz wrote:
> > On Monday, July 21, 2014 12:38:28 PM Bartlomiej Zolnierkiewicz wrote:
> > > 
> > > Hi,
> > > 
> > > On Saturday, July 19, 2014 04:42:34 AM Kukjin Kim wrote:
> > > > On 07/16/14 20:59, Tomasz Figa wrote:
> > > > > Hi Krzysztof,
> > > > >
> > > > > On 14.07.2014 09:45, Krzysztof Kozlowski wrote:
> > > > >> Fix building of exynos defconfig with disabled PM_SLEEP:
> > > > >> CONFIG_PM_SLEEP=n
> > > > >> CONFIG_PM_SLEEP_SMP=n
> > > > >> CONFIG_SUSPEND=n
> > > > >> by moving functions for power up/down of CPU and cluster to platsmp.c
> > > > >>
> > > > >> The build error messages:
> > > > >> arch/arm/mach-exynos/built-in.o: In function `exynos_boot_secondary':
> > > > >> arch/arm/mach-exynos/platsmp.c:111: undefined reference to `exynos_cpu_power_state'
> > > > >> arch/arm/mach-exynos/platsmp.c:112: undefined reference to `exynos_cpu_power_up'
> > > > >> arch/arm/mach-exynos/platsmp.c:116: undefined reference to `exynos_cpu_power_state'
> > > > >> make: *** [vmlinux] Error 1
> > > > >>
> > > > >> Signed-off-by: Krzysztof Kozlowski<k.kozlowski@samsung.com>
> > > > >>
> > > > >> ---
> > > > >> Changes since v1:
> > > > >> 1. Use different solution - just move the power up/down functions to a
> > > > >>     common place instead of adding stubs in common.h. Suggested by Tomasz
> > > > >>     Figa.
> > > > >> ---
> > > > >>   arch/arm/mach-exynos/platsmp.c | 66 ++++++++++++++++++++++++++++++++++++++++++
> > > > >>   arch/arm/mach-exynos/pm.c      | 66 ------------------------------------------
> > > > >>   2 files changed, 66 insertions(+), 66 deletions(-)
> > > > >>
> > > > >
> > > > + Bart,
> > > > 
> > > > > Reviewed-by: Tomasz Figa<t.figa@samsung.com>
> > > > >
> > > > Applied, thanks.
> > > > 
> > > > Bart, I think this is better at this moment to fix the build breakage 
> > > > with disabling PM...if you have any comments, please let me know.
> > > 
> > > To fix PM_SLEEP=n build itself (with ARM_EXYNOS_CPUIDLE=n) Krzysztof's
> > > patch is not enough and patch [1] is also needed (this patch is very
> > > simple so I think that it is okay for v3.16).
> > 
> > Hmmm, I now see that you've applied Krzysztof's patch for v3.17 not v3.16.
> > 
> > In that case how do you want to deal with PM_SLEEP=n build breakages for
> > v3.16 and what do you mean with "fix the build breakage with disabling PM"?
> 
> Just a bit of explanation:
> 
> The PM_SLEEP=n build breakages show up on automated build tests done by
> various people.  Minimal fixes for them (Krzysztof's patch + patch [1] +
> making ARM_EXYNOS_CPUIDLE depend on PM_SLEEP temporally) are really obvious
> and should be pretty safe so it would be great to have them in v3.16.
> 
> If that is not possible lets fix the issue completely early in v3.17 cycle.

Okay, so Krzysztof's patch was posted in pull request to Olof on Saturday
and merged already for v3.17.  In that case I will just refresh my patches
and resubmit later.  Sorry for all the noise.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
> 
> > Best regards,
> > --
> > Bartlomiej Zolnierkiewicz
> > Samsung R&D Institute Poland
> > Samsung Electronics
> > 
> > > For PM_SLEEP=n and ARM_EXYNOS_CPUIDLE=y config more changes are needed
> > > and they are contained in patch [2] (please note that this patch depends
> > > on patch [3] from Tomasz Figa which was redone recently into [4] so my
> > > patch also needs to be refreshed).  However if you think that this would
> > > result in too much changes for v3.16 kernel we can make ARM_EXYNOS_CPUIDLE
> > > select (or depend on) PM_SLEEP for now and fix the issue completely later
> > > in v3.17 kernel.
> > > 
> > > [1] "[PATCH 1/2] ARM: EXYNOS: Fix build with PM_SLEEP=n part #2"
> > > http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg34080.html
> > > 
> > > [2] "[PATCH 2/2] ARM: EXYNOS: Fix build with PM_SLEEP=n and ARM_EXYNOS_CPUIDLE=y"
> > > http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg34081.html
> > > 
> > > [3] "[PATCH 5/6] ARM: EXYNOS: Fix suspend/resume sequencies"
> > > http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg32809.html
> > > 
> > > [4] "[PATCH v3] ARM: EXYNOS: Fix suspend/resume sequences"
> > > http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg34150.html
> > > 
> > > Best regards,
> > > --
> > > Bartlomiej Zolnierkiewicz
> > > Samsung R&D Institute Poland
> > > Samsung Electronics
