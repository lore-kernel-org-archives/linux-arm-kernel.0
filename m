From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 22 Jul 2015 08:45:26 +0900
Subject: [GIT PULL] ARM: EXYNOS: mach: Improvements for 4.3
In-Reply-To: <CAJKOXPeJyoG1sw_Oxznx75WPrk2CcQMxtXrq_MiPHm15E7k+8g@mail.gmail.com>
References: <1437014519-19571-1-git-send-email-k.kozlowski@samsung.com>
 <1437014519-19571-2-git-send-email-k.kozlowski@samsung.com>
 <06bb01d0c372$756f2250$604d66f0$@kernel.org>
 <CAJKOXPeHu7WB7ZJJsjMSPXgiB24ryqufSuPDhFxiXoYDMjLHcg@mail.gmail.com>
 <CAJKOXPeJyoG1sw_Oxznx75WPrk2CcQMxtXrq_MiPHm15E7k+8g@mail.gmail.com>
Message-ID: <55AED996.9090208@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21.07.2015 14:21, Krzysztof Kozlowski wrote:
> 2015-07-21 14:13 GMT+09:00 Krzysztof Kozlowski <k.kozlowski@samsung.com>:
>> 2015-07-21 14:02 GMT+09:00 Kukjin Kim <kgene@kernel.org>:
>>> Krzysztof Kozlowski wrote:
>>>>
>>>> Dear Kukjin,
>>>>
>>>> Exynos mach-code related improvements. Description along with a tag.
>>>> You can find them also on the lists with my reviewed-by.
>>>>
>>>> Best regards,
>>>> Krzysztof
>>>>
>>>>
>>>> The following changes since commit 1c4c7159ed2468f3ac4ce5a7f08d79663d381a93:
>>>>
>>>>   Merge tag 'ext4_for_linus_stable' of git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4 (2015-
>>>> 07-05 16:24:54 -0700)
>>>>
>>>> are available in the git repository at:
>>>>
>>>>
>>>>   https://github.com/krzk/linux.git tags/samsung-mach-4.3
>>>>
>>>> for you to fetch changes up to 70f83b6716ea0e5944071c12ff1716f93a9c2d8d:
>>>>
>>>>   cpufreq: exynos: remove Exynos5250 specific cpufreq driver support (2015-07-16 10:39:56 +0900)
>>>>
>>>> ----------------------------------------------------------------
>>>> Improvements for Exynos based boards:
>>>> 1. Switch to generic cpufreq-dt driver for Exynos5250. The old driver
>>>>    is removed.
>>>> 2. Fix memory leak in cpufreq error path.
>>>> 3. Cleanups: remove duplicated define with bootloader's sleep magic
>>>>    constant, staticize local function, drop 'owner' from
>>>>    platform driver, fix cast of iomem to ERR_PTR.
>>>>
>>>> ----------------------------------------------------------------
>>>> Bartlomiej Zolnierkiewicz (1):
>>>>       cpufreq: exynos: remove Exynos5250 specific cpufreq driver support
>>>>
>>>> Krzysztof Kozlowski (4):
>>>>       ARM: EXYNOS: pmu: Make local function static
>>>>       ARM: EXYNOS: Remove duplicated define of SLEEP_MAGIC
>>>>       ARM: EXYNOS: pmu: Drop owner assignment
>>>>       ARM: EXYNOS: Use IOMEM_ERR_PTR when function returns iomem
>>>>
>>>> Shailendra Verma (1):
>>>>       cpufreq: exynos: Fix for memory leak in case SOC name does not match
>>>>
>>>> Thomas Abraham (3):
>>>>       clk: samsung: exynos5250: add cpu clock configuration data and instantiate cpu clock
>>>>       ARM: dts: Exynos5250: add CPU OPP and regulator supply property
>>>>       ARM: Exynos: switch to using generic cpufreq driver for Exynos5250
>>>>
>>>>  arch/arm/boot/dts/exynos5250-arndale.dts  |   4 +
>>>>  arch/arm/boot/dts/exynos5250-smdk5250.dts |   4 +
>>>>  arch/arm/boot/dts/exynos5250-snow.dts     |   4 +
>>>>  arch/arm/boot/dts/exynos5250-spring.dts   |   4 +
>>>>  arch/arm/boot/dts/exynos5250.dtsi         |  22 ++++
>>>>  arch/arm/mach-exynos/common.h             |   6 +
>>>>  arch/arm/mach-exynos/exynos.c             |   1 +
>>>>  arch/arm/mach-exynos/firmware.c           |   2 -
>>>>  arch/arm/mach-exynos/platsmp.c            |   2 +-
>>>>  arch/arm/mach-exynos/pmu.c                |   3 +-
>>>>  arch/arm/mach-exynos/suspend.c            |   4 +-
>>>>  drivers/clk/samsung/clk-exynos5250.c      |  31 +++++
>>>>  drivers/cpufreq/Kconfig.arm               |  11 --
>>>>  drivers/cpufreq/Makefile                  |   1 -
>>>>  drivers/cpufreq/exynos-cpufreq.c          |   9 +-
>>>>  drivers/cpufreq/exynos-cpufreq.h          |  17 ---
>>>>  drivers/cpufreq/exynos5250-cpufreq.c      | 210 ------------------------------
>>>>  include/dt-bindings/clock/exynos5250.h    |   1 +
>>>>  18 files changed, 84 insertions(+), 252 deletions(-)
>>>>  delete mode 100644 drivers/cpufreq/exynos5250-cpufreq.c
>>>> --
>>>
>>> Applied above changes into fixes/non-critical, next/cleanup-samsung,
>>> next/dt-samsung and next/cpufreq-clk-samsung according to the change.
> 
> Cc-ed Bartlomiej,
> 
> One issue found: splitting DTS change for Exynos 5250 cpufreq to
> separate branch will break bisectability. The commit "ARM: dts:
> Exynos5250: add CPU OPP and regulator supply property":
> 1. MUST be put after "clk: samsung: exynos5250: add cpu clock
> configuration data and instantiate cpu clock" to prevent build
> failures,
> 2. should be put before "ARM: Exynos: switch to using generic cpufreq
> driver for Exynos5250" to prevent lost cpufreq functionality.
> 
> Doing otherwise would lose bisectability which is really unfortunate
> when you can simply avoid it. This should remain in the same branch -
> next/cpufreq-clk-samsung.

Dear Kukjin,

Nothing changed since yesterday... so let me point this in a more clear
way. The way you divided the patchset causes build errors:

--------------
HEAD is now at 565872a601c4... ARM: dts: add CPU OPP and regulator
supply property for exynos5250

ERROR: Failed build: -A arm -c exynos on
565872a601c4d91a75b917b1fb40ff27ad7ebb08

LOGS:
Error: ../arch/arm/boot/dts/exynos5250.dtsi:65.21-22 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [arch/arm/boot/dts/exynos5250-arndale.dtb] Error 1
make[1]: *** [dtbs] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [sub-make] Error 2
--------------

This breaks bisectability without any special valid reason.

Best regards,
Krzysztof
