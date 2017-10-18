From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 18 Oct 2017 16:31:30 +0800
Subject: [PATCH v2 0/8] ARM: sun8i: a83t: Enable AXP813/AXP818 regulators
Message-ID: <20171018083138.14517-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This series was originally name "regulator: axp20x: Add support for
AXP813/818 regulators". It adds support for the X-Powers AXP813/818 [1]
PMICs' regulators. The series is quite straightforward.

Changes since v1:

  - Regulator driver patches were merged and now dropped from the series

  - Chose simpler names for the regulators

  - Added SDIO WiFi enablement patches

Patch 1 adds a axp20x-regulator cell for AXP813, thereby enabling the
regulators.

Patch 2 adds a shared dtsi file for the PMIC. This currently contains
a list of regulator nodes, but will be expanded with Quentin's power
supply work.

Patches 3 through 5 add regulator nodes to board dts files for the A83T
boards that I have. They are not squashed together as each file has
substantial additions.

Patch 6 moves the mmc1 pinmux setting over to the dtsi, and sets it by
default.

Patches 7 & 8 enable SDIO-based WiFi on the Cubietruck Plus and Banana
Pi M3.

Originally my work also included enabling Ethernet. But the Ethernet
bindings were reverted. Everything can be found here:

    https://github.com/wens/linux/tree/a83t-regulator-wifi-eth

Please have a look.

Lee, we need the mfd changes merged in before merging the dts changes.
Otherwise, mmc would break as vmmc/vqmmc is tied to the PMIC regulators.


Regards
ChenYu


[1] AXP813 and AXP818 are functionally identical. They have different
    labels and are bundled with different SoCs (A83T and H8), as a sort
    of product or market segmentation.



Chen-Yu Tsai (8):
  mfd: axp20x: Add axp20x-regulator cell for AXP813
  ARM: dts: sunxi: Add dtsi for AXP81x PMIC
  ARM: dts: sun8i: a83t: cubietruck-plus: Add AXP818 regulator nodes
  ARM: dts: sun8i: a83t: bananapi-m3: Add AXP813 regulator nodes
  ARM: dts: sun8i: a83t: allwinner-h8homlet-v2: Add AXP818 regulator
    nodes
  ARM: dts: sun8i: a83t: Move mmc1 pinctrl setting to dtsi file
  ARM: dts: sun8i: a83t: cubietruck-plus: Enable AP6330 WiFi on mmc1
  ARM: dts: sun8i: a83t: bananapi-m3: Enable AP6212 WiFi on mmc1

 .../{sun8i-a83t-bananapi-m3.dts => axp81x.dtsi}    | 157 ++++++++---------
 .../boot/dts/sun8i-a83t-allwinner-h8homlet-v2.dts  | 147 ++++++++++++++--
 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts       | 169 ++++++++++++++++++-
 arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts   | 187 +++++++++++++++++++--
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts          |   2 -
 arch/arm/boot/dts/sun8i-a83t.dtsi                  |   2 +
 drivers/mfd/axp20x.c                               |   2 +
 7 files changed, 547 insertions(+), 119 deletions(-)
 copy arch/arm/boot/dts/{sun8i-a83t-bananapi-m3.dts => axp81x.dtsi} (52%)

-- 
2.14.2
