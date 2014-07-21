From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Mon, 21 Jul 2014 12:38:28 +0200
Subject: [PATCH v2] ARM: EXYNOS: Fix build with PM_SLEEP=n
In-Reply-To: <53C978AA.9090603@samsung.com>
References: <1405323953-25954-1-git-send-email-k.kozlowski@samsung.com>
 <53C66924.3010303@samsung.com> <53C978AA.9090603@samsung.com>
Message-ID: <5864544.mJGdtT36g8@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Saturday, July 19, 2014 04:42:34 AM Kukjin Kim wrote:
> On 07/16/14 20:59, Tomasz Figa wrote:
> > Hi Krzysztof,
> >
> > On 14.07.2014 09:45, Krzysztof Kozlowski wrote:
> >> Fix building of exynos defconfig with disabled PM_SLEEP:
> >> CONFIG_PM_SLEEP=n
> >> CONFIG_PM_SLEEP_SMP=n
> >> CONFIG_SUSPEND=n
> >> by moving functions for power up/down of CPU and cluster to platsmp.c
> >>
> >> The build error messages:
> >> arch/arm/mach-exynos/built-in.o: In function `exynos_boot_secondary':
> >> arch/arm/mach-exynos/platsmp.c:111: undefined reference to `exynos_cpu_power_state'
> >> arch/arm/mach-exynos/platsmp.c:112: undefined reference to `exynos_cpu_power_up'
> >> arch/arm/mach-exynos/platsmp.c:116: undefined reference to `exynos_cpu_power_state'
> >> make: *** [vmlinux] Error 1
> >>
> >> Signed-off-by: Krzysztof Kozlowski<k.kozlowski@samsung.com>
> >>
> >> ---
> >> Changes since v1:
> >> 1. Use different solution - just move the power up/down functions to a
> >>     common place instead of adding stubs in common.h. Suggested by Tomasz
> >>     Figa.
> >> ---
> >>   arch/arm/mach-exynos/platsmp.c | 66 ++++++++++++++++++++++++++++++++++++++++++
> >>   arch/arm/mach-exynos/pm.c      | 66 ------------------------------------------
> >>   2 files changed, 66 insertions(+), 66 deletions(-)
> >>
> >
> + Bart,
> 
> > Reviewed-by: Tomasz Figa<t.figa@samsung.com>
> >
> Applied, thanks.
> 
> Bart, I think this is better at this moment to fix the build breakage 
> with disabling PM...if you have any comments, please let me know.

To fix PM_SLEEP=n build itself (with ARM_EXYNOS_CPUIDLE=n) Krzysztof's
patch is not enough and patch [1] is also needed (this patch is very
simple so I think that it is okay for v3.16).

For PM_SLEEP=n and ARM_EXYNOS_CPUIDLE=y config more changes are needed
and they are contained in patch [2] (please note that this patch depends
on patch [3] from Tomasz Figa which was redone recently into [4] so my
patch also needs to be refreshed).  However if you think that this would
result in too much changes for v3.16 kernel we can make ARM_EXYNOS_CPUIDLE
select (or depend on) PM_SLEEP for now and fix the issue completely later
in v3.17 kernel.

[1] "[PATCH 1/2] ARM: EXYNOS: Fix build with PM_SLEEP=n part #2"
http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg34080.html

[2] "[PATCH 2/2] ARM: EXYNOS: Fix build with PM_SLEEP=n and ARM_EXYNOS_CPUIDLE=y"
http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg34081.html

[3] "[PATCH 5/6] ARM: EXYNOS: Fix suspend/resume sequencies"
http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg32809.html

[4] "[PATCH v3] ARM: EXYNOS: Fix suspend/resume sequences"
http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg34150.html

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
