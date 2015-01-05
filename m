From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 05 Jan 2015 12:48:40 +0100
Subject: [PATCH v5 0/5] regulator: Allow parsing custom DT properties with
 simplified DT parse
Message-ID: <1420458525-22576-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


The patchset adds:
1. a way of parsing custom DT properties by the driver when simplified
   DT parsing method is used,
2. GPIO enable control to the max77686 driver.


Rationale
=========
After converting drivers to simplified DT parsing method, the parsing
is done by regulator core. The driver cannot longer parse any custom
properties from Device Tree. Example of such special property is
GPIO for enable control.

Driver may want to rely on regulator core to parse most of the bindings
but still need to parse one custom stuff. Additionally driver may need
to perform some special activities depending on Device Tree.

This is solved by adding a callback called from the core when regulator
is matched from DT. The max77686 driver uses it for:
1. parsing "maxim,ena-gpios" property from regulator OF node,
2. enabling GPIO control for such regulator.


Changes since v4
================
1. Re-work idea. Give up generic ena-gpios binding and let driver
   parse any custom property.

Changes since v3
================
1. Regulator cleanup patches were applied by Mark, drop them.
2. Re-work idea by adding generic ena-gpios binding.

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


Best regards,
Krzysztof


Krzysztof Kozlowski (5):
  regulator: Copy config passed during registration
  regulator: Allow parsing custom properties when using simplified DT
    parsing
  regulator: max77686: Add GPIO control
  mfd/regulator: dt-bindings: max77686: Document gpio properties
  ARM: dts: exynos4412-trats: Switch max77686 regulators to GPIO control

 Documentation/devicetree/bindings/mfd/max77686.txt | 14 +++++
 arch/arm/boot/dts/exynos4412-trats2.dts            | 25 ++------
 drivers/regulator/core.c                           | 20 +++++--
 drivers/regulator/internal.h                       |  2 +
 drivers/regulator/max77686.c                       | 70 ++++++++++++++++++++--
 drivers/regulator/of_regulator.c                   | 11 ++++
 include/linux/regulator/driver.h                   | 13 ++++
 7 files changed, 126 insertions(+), 29 deletions(-)

-- 
1.9.1
