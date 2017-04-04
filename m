From: icenowy@aosc.io (Icenowy Zheng)
Date: Wed,  5 Apr 2017 02:01:34 +0800
Subject: [PATCH 00/11] AXP803 PMIC support for Pine64
Message-ID: <20170404180145.12897-1-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Pine64 (including Pine64+) boards have an AXP803 PMIC, which is a PMIC
similar to AXP288, but tweaked to use with Allwinner SoCs rather than Intel
tablets (with DCIN and Vbus re-splitted like other AXP PMICs, and RSB bus
support added).

This patchset adds support for it and enabled it in Pine64 device tree.

This patchset can be splitted into two big parts:

- Part1: PATCH 1/11 to PATCH 5/11, which are enabling the MFD (and the
  power key functionality) of AXP803.

- Part2: PATCH 6/11 to PATCH 11/11, which are enabling the regulator
  function of the AXP803 PMIC. Finally Wi-Fi function is added
  as a usage of regulators function.

PATCH 1 and 2 added RSB and NMI device nodes, which are used for the
communication between A64 and AXP803.

PATCH 3 adds basical devicetree binding for AXP803.

PATCH 4 adds support for the AXP803 variant in axp20x-rsb mfd driver.

PATCH 5 enabled the AXP803 MFD in Pine64 device tree.

PATCH 6 adds devicetree binding for the regulators in AXP803.

PATCH 7 adds support for the regulators in AXP803 in the axp20x-regulator
driver.

PATCH 8 enabled the regulator MFD cell in AXP803.

PATCH 9 adds a DTSI file for AXP803, just like what have been done for other
AXPs.

PATCH 10 enabled the regulators on Pine64.

PATCH 11 enabled Wi-Fi support on Pine64, which required DLDO4 and ELDO1
regulators.

Icenowy Zheng (11):
  arm64: allwinner: a64: enable RSB on A64
  arm64: allwinner: a64: add NMI controller on A64
  dt-bindings: add device tree binding for X-Powers AXP803 PMIC
  mfd: axp20x: support AXP803 variant
  arm64: allwinner: a64: add AXP803 node to Pine64 device tree
  dt-bindings: add AXP803's regulator info
  regulator: axp20x-regulator: add support for AXP803
  mfd: axp20x: add axp20x-regulator cell for AXP803
  arm64: allwinner: a64: add DTSI file for AXP803 PMIC
  arm64: allwinner: a64: enable AXP803 regulators for Pine64
  arm64: allwinner: a64: enable Wi-Fi for Pine64

 Documentation/devicetree/bindings/mfd/axp20x.txt   |  30 ++++-
 arch/arm64/boot/dts/allwinner/axp803.dtsi          | 150 +++++++++++++++++++++
 .../arm64/boot/dts/allwinner/sun50i-a64-pine64.dts | 136 +++++++++++++++++++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi      |  29 ++++
 drivers/mfd/axp20x-rsb.c                           |   1 +
 drivers/mfd/axp20x.c                               | 115 ++++++++++++++++
 drivers/regulator/axp20x-regulator.c               | 135 +++++++++++++++++--
 include/linux/mfd/axp20x.h                         |  77 ++++++++++-
 8 files changed, 657 insertions(+), 16 deletions(-)
 create mode 100644 arch/arm64/boot/dts/allwinner/axp803.dtsi

-- 
2.12.2
