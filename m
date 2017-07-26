From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 26 Jul 2017 16:28:23 +0800
Subject: [PATCH v2 0/9] mfd: axp20x: Add basic support for AXP813
Message-ID: <20170726082832.16789-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This is v2 of my AXP813 support series. The device tree patches are
based on my A83T MMC support series. These will go through the sunxi
tree. The dt-binding and mfd patches are based on v4.13-rc1. These
will go through Lee's mfd tree.

Changes since v1:

  - Provided relative path for ac100.txt in dt-bindings/mfd/axp20x.txt

  - Added Rob's acks to dt-binding patches

  - Added Quentin's "mfd: axp20x: use correct platform device id for
    many PEK" patch to this series. This patch depends on mfd changes
    in this series. It is included so Lee can take them together in
    one go.

  - Added Lee's mfd-acks to mfd patches

  - Added axp818 compatible with axp813 fallback. The two chips are
    identical except for the markings. The added compatible matches
    what is actually on the board, to avoid confusing readers.

  - Fixed up device tree patches to mention which board is changed

  - Added device tree patches for the H8 homlet

Patch 1 adds AXP806 to the main list of supported chips, which was
missing.

Patch 2 adds bindings for the AXP813.

Patch 3 adds basic mfd driver support with PEK enabled for AXP813.

Patch 4 changes the PEK sub-device's platform ID for AXP22x and
later PMICs. This is included as it depends on the previous patch.

Patch 5 adds the device node and pinmux settings for the RSB controller
on the A83T. This is used to communicate with the PMIC.

Patch 6 adds a device node for the PMIC part of the chip for the
Cubietruck Plus.

Patch 7 adds a device node for the embedded AC100 part of the chip
for the Cubietruck Plus.

Patch 8 adds a device node for the PMIC part of the chip for the
H8 homlet board.

Patch 9 adds a device node for the embedded AC100 part of the chip
for the H8 homlet board.


Excerpt from original cover letter from v1:

This series adds basic device tree bindings and driver support for the
AXP813/818 PMICs. The two models are identical when comparing their
datasheets. These PMICs are actually two dies in one package: one being
the actual PMIC, the other being an AC100 codec/RTC combo chip. The
latter has its own device tree binding.

This series only adds the basic parts of the device tree binding and
driver. For the bindings, only the core and regulator bits are added.
Any sub-devices that have their own binding will be updated later on.
For the driver, only the mfd part with a basic power button (PEK) cell
is added, along with regulator IDs.


Regards
ChenYu

Chen-Yu Tsai (8):
  dt-bindings: mfd: axp20x: Add AXP806 to supported list of chips
  dt-bindings: mfd: axp20x: Introduce bindings for AXP813
  mfd: axp20x: Add support for AXP813 PMIC
  ARM: sun8i: a83t: Add device node and pinmux setting for RSB
    controller
  ARM: sun8i: a83t: cubietruck-plus: Enable PMIC part of AXP818 PMIC
  ARM: sun8i: a83t: cubietruck-plus: Enable AC100 combo chip in AXP818
    PMIC
  ARM: sun8i: a83t: h8homlet-v2: Enable PMIC part of AXP818 PMIC
  ARM: sun8i: a83t: h8homlet-v2: Enable AC100 combo chip in AXP818 PMIC

Quentin Schulz (1):
  mfd: axp20x: use correct platform device id for many PEK

 Documentation/devicetree/bindings/mfd/axp20x.txt   | 50 +++++++++++++++++++---
 .../boot/dts/sun8i-a83t-allwinner-h8homlet-v2.dts  | 35 +++++++++++++++
 arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts   | 35 +++++++++++++++
 arch/arm/boot/dts/sun8i-a83t.dtsi                  | 23 ++++++++++
 drivers/mfd/axp20x-rsb.c                           |  1 +
 drivers/mfd/axp20x.c                               | 32 +++++++++++---
 include/linux/mfd/axp20x.h                         | 29 +++++++++++++
 7 files changed, 195 insertions(+), 10 deletions(-)

-- 
2.13.3
