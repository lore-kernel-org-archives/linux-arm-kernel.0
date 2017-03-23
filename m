From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 23 Mar 2017 09:03:21 +0100
Subject: [PATCH v4 0/6] Pad retentions support for Exynos5433
References: <CGME20170323080346eucas1p216eec41325d220774ecec05b397e83a6@eucas1p2.samsung.com>
Message-ID: <1490256207-10061-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patchset is a next step to add support for all power domains on
Exynos5433 SoCs. This patchset contains patches for Exynos pin control
driver and Exynos LPASS MFD driver, which are needed to make the
platform ready for adding power domains support.

Patches in this patchset have runtime dependency. They are order in such
a way to make the changes bisectable (mfd lpass changes should be applied
after pinctrl patches). Other dependencies mentioned previously in v3 of
this patchset has been finally merged to v4.11-rc1.

Patches have been rebased on top of linux v4.11-rc3.

Best regards
Marek Szyprowski
Samsung R&D Institute Poland


Changelog:
v4:
- rebased onto v4.11-rc3
- added missing Acks from Lee Jones and Rob Herring

v3: https://lkml.org/lkml/2017/1/30/358
- moved adding new PMU register defines to separate patch (requested by
  Krzysztof Kozlowski)
- rebased onto Linux next-20170130 (removed "soc: samsung: pmu: Add dummy
  support for Exynos5433 SoC" and "arm64: dts: exynos: Add clocks to
  Exynos5433 LPASS module" patches, which are already merged)

v2: https://lkml.org/lkml/2017/1/26/57
- fixed issues pointed by Krzysztof Kozlowski:
  1. added more checks to Exynos PMU driver for NULL drvdata
  2. reused EXYNOS_WAKEUP_FROM_LOWPWR in retention data for Exynos5433
  3. converted lpass driver to devm_clk_get
  4. added missing ->remove callback to lpass driver

v1: https://lkml.org/lkml/2017/1/25/214
- initial version


Patch summary:

Marek Szyprowski (6):
  pinctrl: samsung: Ensure that pad retention is disabled on driver init
  pinctrl: samsung: Add support for pad retention control for Exynos5433
    SoCs
  mfd: exynos-lpass: Remove pad retention control
  mfd: exynos-lpass: Add support for clocks
  mfd: exynos-lpass: Add missing remove() function
  mfd: exynos-lpass: Add runtime PM support

 .../bindings/mfd/samsung,exynos5433-lpass.txt      |  8 ++-
 drivers/mfd/exynos-lpass.c                         | 48 ++++++++++-------
 drivers/pinctrl/samsung/pinctrl-exynos.c           | 63 ++++++++++++++++++++++
 include/linux/mfd/syscon/exynos5-pmu.h             |  3 --
 4 files changed, 99 insertions(+), 23 deletions(-)

-- 
1.9.1
