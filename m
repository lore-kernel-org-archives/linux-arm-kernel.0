From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 19 Jan 2017 14:48:40 +0100
Subject: [PATCH v3 00/13] Move pad retention control to Exynos pin controller
 driver
References: <CGME20170119134902eucas1p24c04dc33bab06bd3d564f6aec2180b3b@eucas1p2.samsung.com>
Message-ID: <1484833733-16082-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patchset is a follow-up of my work on adding runtime PM support
to Exynos pin controller driver:
http://www.spinics.net/lists/arm-kernel/msg550161.html

Runtime PM support itself needs a bit more discussion, so lets first focus on
the prerequisites.

In case of Exynos pin controller driver it is a pad retention control. In
current code it was handled by machine and PMU code and had no relation to
what pin controller driver does. This patch series moves pad retention
control to pin controller driver. While implementing it, I also did a little
cleanup of both Exynos PMU and pin controller drivers. Exynos PMU driver
now provides a convenient function to get PMU regmap from other Exynos drivers.

Patch #1 provides a new interface to get Exynos PMU regmap, which is used
by the patch #11. Patches 2-10 are additional cleanups to the code I was
modyfying. Patches 10-12 implements the move of the retention control and
patch #13 is another cleanup, which is possible after removing dependency
to platform PM code.

Patches are based on linux-next from 2017.01.19 with Exynos4415 support
removal patch applied: https://lkml.org/lkml/2017/1/14/137


Changelog:

v3:
- fixed return value from exynos_get_pmu_regmap stub (pointed by Tomasz Figa)
- removed unnecessary regmap include in pmu.h
- fixed comments in retention control structure description
- simplified exynos_retention_disable function by moving samsung_retention_ctrl
  structure to separate variable
- collected Acks

v2: https://www.spinics.net/lists/arm-kernel/msg555048.html
- reworked exynos_get_pmu_regmap() function and moved to Exynos PMU driver,
  now it doesn't depend on driver probe order thus doesn't need to defer probing
  of pinctrl driver if PMU has not yet been probed
- collected Acks, minor fixes according to review comments

v1: https://www.spinics.net/lists/arm-kernel/msg554487.html
- removed the need to add PMU phandles to all pin controller nodes, so old DTBs
  are properly supported. This has been achieved by getting PMU regmap from
  the "exynos-pmu" device of fixed name.
- more cleanup in Exynos pin controller driver: added missing entries in DT
  documentation, removed "memory allocation failed" messages and added
  initconst annotations.
- added support for s5pv210.
- reworked retention control code to be simpler and ready for adding Exynos5433
  support.

v0: http://www.spinics.net/lists/arm-kernel/msg550161.html
- initial version
- part of "Runtime PM for Exynos pin controller driver" patchset


Patch summary:

Marek Szyprowski (13):
  soc: samsung: pmu: Provide global function to get PMU regmap
  soc: samsung: pmu: Use of_device_get_match_data helper
  soc: samsung: pmu: Remove messages for failed memory allocation
  pinctrl: samsung: Document Exynos3250 SoC support
  pinctrl: samsung: Remove messages for failed memory allocation
  pinctrl: samsung: Fix samsung_pinctrl_create_functions return value
  pinctrl: samsung: Add missing initconst annotation
  pinctrl: samsung: Remove dead code
  pinctrl: samsung: Use generic of_device_get_match_data helper
  pinctrl: samsung: Add infrastructure for pin-bank retention control
  pinctrl: samsung: Move retention control from mach-exynos to the
    pinctrl driver
  pinctrl: samsung: Move retention control from mach-s5pv210 to the
    pinctrl driver
  pinctrl: samsung: Replace syscore ops with standard platform device
    pm_ops

 .../bindings/pinctrl/samsung-pinctrl.txt           |   1 +
 arch/arm/mach-exynos/suspend.c                     |  64 ------
 arch/arm/mach-s5pv210/pm.c                         |   7 -
 arch/arm/mach-s5pv210/regs-clock.h                 |   4 -
 drivers/pinctrl/samsung/pinctrl-exynos.c           | 231 +++++++++++++++++++--
 drivers/pinctrl/samsung/pinctrl-s3c64xx.c          |  12 +-
 drivers/pinctrl/samsung/pinctrl-samsung.c          | 123 ++++-------
 drivers/pinctrl/samsung/pinctrl-samsung.h          |  42 ++++
 drivers/soc/samsung/exynos-pmu.c                   |  22 +-
 include/linux/soc/samsung/exynos-pmu.h             |  10 +
 10 files changed, 322 insertions(+), 194 deletions(-)

-- 
1.9.1
