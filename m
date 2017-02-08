From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 8 Feb 2017 11:46:15 +0000
Subject: [PATCH v3 0/7] Pad retentions support for Exynos5433
In-Reply-To: <1485779908-32147-1-git-send-email-m.szyprowski@samsung.com>
References: <CGME20170130123837eucas1p13c607f81a1775a805740dccc87fe8b87@eucas1p1.samsung.com>
 <1485779908-32147-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20170208114615.c4wszjmnuackgzvx@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 30 Jan 2017, Marek Szyprowski wrote:

> Hello,
> 
> This patchset is a first step to add support for all power domains on
> Exynos5433 SoCs. This patchset contains patches for Exynos pin control
> driver and Exynos LPASS MFD driver, which are needed to make the
> platform ready for adding power domains support.
> 
> Patches in this patchset depends on each other. They are order in such a
> way to make the changes bisectable.
> 
> Patch #2 has compile dependency on #1.
> Patch #3 has runtime dependency on commit fa59aa70907b2 ("soc: samsung:
> 	pmu: Add dummy support for Exynos5433 SoC",
> 	for-v4.11/drivers-soc-exynos-pmu-the-joy-never-ends branch).
> Patch #4 has runtime dependency on #3.
> Patch #5 has runtime dependency on commit 7547162ac3514 ("arm64: dts:
> 	exynos: Add clocks to Exynos5433 LPASS module, next/dt64 branch).
> 
> This patchset also directly depends on the "Move pad retention control to
> Exynos pin controller driver" patchset:
> https://www.spinics.net/lists/arm-kernel/msg556074.html
> 
> Patches have been generated on top of linux-next from 30th January 2017
> with the above mentioned patchset applied.
> 
> This is a part of a larger task, which goal is to add support for power
> domains on Exynos5433 SoCs / TM2 boards. First version of the all patches
> needed to get it working have been pushed to the following git repo:
> https://git.linaro.org/people/marek.szyprowski/linux-srpol.git v4.10-next-tm2-pd
> 
> Best regards
> Marek Szyprowski
> Samsung R&D Institute Poland

Looks like I reviewed v2.

If the patches haven't changed that much, please apply my Acks to this
set instead.  Anything that has changed, please leave them off and
repost.

> Changelog:
> v3:
> - moved adding new PMU register defines to separate patch (requested by
>   Krzysztof Kozlowski)
> - rebased onto Linux next-20170130 (removed "soc: samsung: pmu: Add dummy
>   support for Exynos5433 SoC" and "arm64: dts: exynos: Add clocks to
>   Exynos5433 LPASS module" patches, which are already merged)
> 
> v2:
> - fixed issues pointed by Krzysztof Kozlowski:
>   1. added more checks to Exynos PMU driver for NULL drvdata
>   2. reused EXYNOS_WAKEUP_FROM_LOWPWR in retention data for Exynos5433
>   3. converted lpass driver to devm_clk_get
>   4. added missing ->remove callback to lpass driver
> 
> v1: https://lkml.org/lkml/2017/1/25/214
> - initial version
> 
> 
> Patch summary:
> 
> Marek Szyprowski (7):
>   soc: smasung: pmu: Add register defines for pad retention control
>   pinctrl: samsung: Ensure that pad retention is disabled on driver init
>   pinctrl: samsung: Add support for pad retention control for Exynos5433
>     SoCs
>   mfd: exynos-lpass: Remove pad retention control
>   mfd: exynos-lpass: Add support for clocks
>   mfd: exynos-lpass: Add missing remove() function
>   mfd: exynos-lpass: Add runtime PM support
> 
>  .../bindings/mfd/samsung,exynos5433-lpass.txt      |  8 ++-
>  drivers/mfd/exynos-lpass.c                         | 48 ++++++++++-------
>  drivers/pinctrl/samsung/pinctrl-exynos.c           | 63 ++++++++++++++++++++++
>  include/linux/mfd/syscon/exynos5-pmu.h             |  3 --
>  include/linux/soc/samsung/exynos-regs-pmu.h        | 16 ++++++
>  5 files changed, 115 insertions(+), 23 deletions(-)
> 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
