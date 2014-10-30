From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 30 Oct 2014 12:20:39 +0100
Subject: [PATCH v3 00/14] regulator: max77686: Add GPIO control
Message-ID: <1414668053-31370-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


Patches touching max77802 were not tested on hardware.
I am kindly asking for testing it because I don't have the board
with Maxim 77802.

Changes since v2
================
Re-work the board file support removal after Javier's comments: use
new DT style parsing. This imposes a lot of changes.
1. Add "of_compatible" for regulator drivers.
2. Provide backward compatibility if such "of_compatible" is not present.
   The driver will search for regulators node and use it as dev->of_node.
   Everything should be bisect-friendly.
3. New patches: 1, 2, 3, 5, 13 and 14.
4. Because of new style DT parsing it is much easier to put "gpio"
   properties in regulators top node (not in each regulator).
   This will be also new-gpio-lib friendly.

Changes since v1
================
1. Add patch: 1/8 "regulator: max77686: Consistently index opmode
   array by rdev id".
2. Remove patch "regulator: max77686: Make regulator_desc array
   const" (applied).
3. Re-work patches removing from regulators board file support (2/8
   and 3/8). Parse regulators with of_regulator_match() at once, remove
   num_regulators.
4. Patch 4/8: Add depends on OF to mfd/Kconfig. Add Javier's
   reviewed-by.
5. Patch 5/8: Add Javier's reviewed-by.
6. Patch 6/8: Add depends on GPIOLIB to regulator/Kconfig. Rename
   "external control" to "GPIO control" and "ext_control_gpios" to
   simpler "gpios".
   I tried to use new GPIO API but it ended with more problems
   https://lkml.org/lkml/2014/10/29/239


Description
===========
This patch helps in proper description of max77686 regulators in DTS by
allowing to control them over GPIO. This allows removal of
fixed regulators from DTS which duplicate the description of hardware.

The first five patches are cleanups, including board support removal.

The whole patchset should be taken at once.

Patchset is rebased on next-20141023 AND:
1. ARM: EXYNOS: Call regulator suspend prepare/finish
   https://lkml.org/lkml/2014/10/20/545
2. regulator: max77686/trats2: Disable some regulators in suspend
   https://lkml.org/lkml/2014/10/27/280


Best regards,
Krzysztof

*** BLURB HERE ***

Krzysztof Kozlowski (14):
  mfd: max77686/802: Map regulator driver to its own of_node
  mfd/regulator: dt-bindings: max77686: Document of_compatible for
    regulator
  regulator: dt-bindings: max77802: Document of_compatible for regulator
  regulator: max77686: Consistently index opmode array by rdev id
  regulator: max77802: Don't ignore return value of current opmode
  regulator: max77802: Remove support for board files
  regulator: max77686: Remove support for board files
  mfd: max77686/802: Remove support for board files
  regulator: max77686: Initialize opmode explicitly to normal mode
  regulator: max77686: Add GPIO control
  mfd/regulator: dt-bindings: max77686: Document gpio properties
  ARM: dts: exynos4412-trats: Switch max77686 regulators to GPIO control
  ARM: dts: exynos5420-peach: Update to new max77802 regulator
    compatible
  ARM: dts: exynos5800-peach: Update to new max77802 regulator
    compatible

 Documentation/devicetree/bindings/mfd/max77686.txt |  16 +-
 .../devicetree/bindings/regulator/max77802.txt     |   8 +-
 arch/arm/boot/dts/exynos4412-trats2.dts            |  28 +---
 arch/arm/boot/dts/exynos5420-peach-pit.dts         |   2 +
 arch/arm/boot/dts/exynos5800-peach-pi.dts          |   2 +
 drivers/mfd/Kconfig                                |   1 +
 drivers/mfd/max77686.c                             |  33 +---
 drivers/regulator/max77686.c                       | 186 +++++++++++++--------
 drivers/regulator/max77802.c                       | 116 +++++--------
 include/linux/mfd/max77686-private.h               |   1 -
 include/linux/mfd/max77686.h                       |  28 ----
 11 files changed, 200 insertions(+), 221 deletions(-)

-- 
1.9.1
