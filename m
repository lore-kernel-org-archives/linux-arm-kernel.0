From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 08 Apr 2014 15:21:45 +0200
Subject: [PATCH V3 15/17] ARM: exynos: cpuidle: Disable cpuidle for 5440
In-Reply-To: <CAP245DUmBVeZqBYDc3mopvs_h5AkcTgjG2eO7z5VAQnUDJJogQ@mail.gmail.com>
References: <1396959579-18268-1-git-send-email-daniel.lezcano@linaro.org>	<1396959579-18268-16-git-send-email-daniel.lezcano@linaro.org>
 <CAP245DUmBVeZqBYDc3mopvs_h5AkcTgjG2eO7z5VAQnUDJJogQ@mail.gmail.com>
Message-ID: <5343F7E9.3010304@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/08/2014 02:51 PM, Amit Kucheria wrote:
> On Tue, Apr 8, 2014 at 5:49 PM, Daniel Lezcano
> <daniel.lezcano at linaro.org <mailto:daniel.lezcano@linaro.org>> wrote:
>
>     There is no point to register the cpuidle driver for the 5440 as it
>     has only
>     one WFI state which is the default idle function when the cpuidle
>     driver is
>     disabled.
>
>     By disabling cpuidle we prevent to enter to the governor computation for
>     nothing, thus saving a lot of processing time.
>
>     The only drawback is the statistic via sysfs on this state which is
>     lost but
>     it is meaningless and it could be retrieved from the ftrace easily.
>
>
> So for the future, you'll only merge platform drivers that enable
> something more than WFI?

Well, I already picked up a driver with only WFI because I knew the next 
idle states were in preparation. But adding a cpuidle driver just for 
WFI is no sense and if, for a reason I missed, it is really needed, I 
guess a generic WFI cpuidle driver for all platforms would be make much 
more sense.

>     Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org
>     <mailto:daniel.lezcano@linaro.org>>
>
>
> In that case, Acked-by: Amit Kucheria <amit.kucheria@linaro.org
> <mailto:amit.kucheria@linaro.org>>
>
>     ---
>       arch/arm/mach-exynos/cpuidle.c |    5 -----
>       arch/arm/mach-exynos/exynos.c  |    3 +++
>       2 files changed, 3 insertions(+), 5 deletions(-)
>
>     diff --git a/arch/arm/mach-exynos/cpuidle.c
>     b/arch/arm/mach-exynos/cpuidle.c
>     index 4b94181..a1f111e 100644
>     --- a/arch/arm/mach-exynos/cpuidle.c
>     +++ b/arch/arm/mach-exynos/cpuidle.c
>     @@ -16,8 +16,6 @@
>       #include <asm/suspend.h>
>       #include <asm/cpuidle.h>
>
>     -#include <plat/cpu.h>
>     -
>       #include "common.h"
>
>       static int idle_finisher(unsigned long flags)
>     @@ -77,9 +75,6 @@ static int exynos_cpuidle_probe(struct
>     platform_device *pdev)
>       {
>              int ret;
>
>     -       if (soc_is_exynos5440())
>     -               exynos_idle_driver.state_count = 1;
>     -
>              ret = cpuidle_register(&exynos_idle_driver, NULL);
>              if (ret) {
>                      dev_err(&pdev->dev, "failed to register cpuidle
>     driver\n");
>     diff --git a/arch/arm/mach-exynos/exynos.c
>     b/arch/arm/mach-exynos/exynos.c
>     index b567361..fe8dac8 100644
>     --- a/arch/arm/mach-exynos/exynos.c
>     +++ b/arch/arm/mach-exynos/exynos.c
>     @@ -227,6 +227,9 @@ static struct platform_device exynos_cpuidle = {
>
>       void __init exynos_cpuidle_init(void)
>       {
>     +       if (soc_is_exynos5440())
>     +               return;
>     +
>              platform_device_register(&exynos_cpuidle);
>       }
>
>     --
>     1.7.9.5
>
>
>     _______________________________________________
>     linaro-kernel mailing list
>     linaro-kernel at lists.linaro.org <mailto:linaro-kernel@lists.linaro.org>
>     http://lists.linaro.org/mailman/listinfo/linaro-kernel
>
>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
