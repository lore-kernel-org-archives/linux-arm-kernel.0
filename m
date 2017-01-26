From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 26 Jan 2017 09:33:46 +0100
Subject: [PATCH v2 0/8] Pad retentions support for Exynos5433
References: <CGME20170126083401eucas1p20b4794fe46ccf2189bf734f0d8e3c536@eucas1p2.samsung.com>
Message-ID: <1485419634-28331-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patchset is a first step to add support for all power domains on
Exynos5433 SoCs. This patchset contains patches for Exynos pin control
driver and Exynos LPASS MFD driver, which are needed to make the
platform ready for adding power domains support.

Patches in this patchset depends on each other. They are order in such a
way to make the changes bisectable.

Patch #3 has runtime dependency on #1.
Patch #5 has runtime dependency on #3.
Patch #6 has runtime dependency on #4.

This patchset also directly depends on the "Move pad retention control to
Exynos pin controller driver" patchset:
https://www.spinics.net/lists/arm-kernel/msg556074.html

Patches have been generated on top of linux-next from 25th January 2017.

This is a part of a larger task, which goal is to add support for power
domains on Exynos5433 SoCs / TM2 boards. All patches needed to get it
working have been pushed to the following git repo:
https://git.linaro.org/people/marek.szyprowski/linux-srpol.git v4.10-next-tm2-pd

Best regards
Marek Szyprowski
Samsung R&D Institute Poland


Changelog:
v2:
- fixed issues pointed by Krzysztof Kozlowski:
  1. added more checks to Exynos PMU driver for NULL drvdata
  2. reused EXYNOS_WAKEUP_FROM_LOWPWR in retention data for Exynos5433
  3. converted lpass driver to devm_clk_get
  4. added missing ->remove callback to lpass driver

v1: https://lkml.org/lkml/2017/1/25/214
- initial version


Patch summary:

Marek Szyprowski (8):
  soc: samsung: pmu: Add dummy support for Exynos5433 SoC
  pinctrl: samsung: Ensure that pad retention is disabled on driver init
  pinctrl: samsung: Add support for pad retention control for Exynos5433
    SoCs
  arm64: dts: exynos: Add clocks to Exynos5433 LPASS module
  mfd: exynos-lpass: Remove pad retention control
  mfd: exynos-lpass: Add support for clocks
  mfd: exynos-lpass: Add missing remove() function
  mfd: exynos-lpass: Add runtime PM support

 .../bindings/mfd/samsung,exynos5433-lpass.txt      |  8 ++-
 arch/arm64/boot/dts/exynos/exynos5433.dtsi         |  2 +
 drivers/mfd/exynos-lpass.c                         | 48 ++++++++++-------
 drivers/pinctrl/samsung/pinctrl-exynos.c           | 63 ++++++++++++++++++++++
 drivers/soc/samsung/exynos-pmu.c                   |  6 ++-
 include/linux/mfd/syscon/exynos5-pmu.h             |  3 --
 include/linux/soc/samsung/exynos-regs-pmu.h        | 16 ++++++
 7 files changed, 121 insertions(+), 25 deletions(-)

-- 
1.9.1
