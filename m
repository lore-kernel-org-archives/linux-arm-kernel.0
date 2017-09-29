From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 29 Sep 2017 11:25:07 +0800
Subject: [PATCH 0/7] regulator: axp20x: Add support for AXP813/818 regulators
Message-ID: <20170929032514.31727-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This series adds support for the X-Powers AXP813/818 [1] PMICs'
regulators. The series is quite straightforward. There are no compile
time dependencies between the driver patches, so each can go through
their respective (mfd and regulator) trees.

Patch 1 fixes a wrong bit offset for the AXP803 DCDC5/6 poly-phase
detection code. This code path is not exercised as we don't have any
boards that tie these two outputs together.

Patch 2 adds driver support for the AXP813 regulators. The DT binding
part was merged together with the PMIC compatible string and basic
descriptions.

Patch 3 adds a axp20x-regulator cell for AXP813, thereby enabling the
regulators.

Patch 4 adds a shared dtsi file for the PMIC. This currently contains
a list of regulator nodes, but will be expanded with Quentin's power
supply work.

Patches 5 through 7 add regulator nodes to board dts files for the A83T
boards that I have. They are not squashed together as each file has
substantial additions.

Originally my work also included enabling SDIO WiFi and Ethernet. But
the Ethernet bindings were reverted, and SDIO probing somehow didn't
work after v4.14-rc1. Everything can be found here:

    https://github.com/wens/linux/tree/a83t-regulator-wifi-eth

Please have a look and merge if everything looks OK.


Regards
ChenYu


[1] AXP813 and AXP818 are functionally identical. They have different
    labels and are bundled with different SoCs (A83T and H8), as a sort
    of product or market segmentation.


Chen-Yu Tsai (7):
  regulator: axp20x: Fix poly-phase bit offset for AXP803 DCDC5/6
  regulator: axp20x: Add support for AXP813 regulators
  mfd: axp20x: Add axp20x-regulator cell for AXP813
  ARM: dts: sunxi: Add dtsi for AXP81x PMIC
  ARM: dts: sun8i: a83t: cubietruck-plus: Add AXP818 regulator nodes
  ARM: dts: sun8i: a83t: bananapi-m3: Add AXP813 regulator nodes
  ARM: dts: sun8i: a83t: allwinner-h8homlet-v2: Add AXP818 regulator
    nodes

 .../{sun8i-a83t-bananapi-m3.dts => axp81x.dtsi}    | 157 ++++++++++-----------
 .../boot/dts/sun8i-a83t-allwinner-h8homlet-v2.dts  | 126 ++++++++++++++++-
 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts       | 134 +++++++++++++++++-
 arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts   | 150 +++++++++++++++++++-
 drivers/mfd/axp20x.c                               |   2 +
 drivers/regulator/axp20x-regulator.c               | 104 +++++++++++++-
 include/linux/mfd/axp20x.h                         |   3 +
 7 files changed, 582 insertions(+), 94 deletions(-)
 copy arch/arm/boot/dts/{sun8i-a83t-bananapi-m3.dts => axp81x.dtsi} (52%)

-- 
2.14.2
