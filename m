From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 27 Nov 2015 14:43:21 +0800
Subject: [PATCH v5 0/9] mfd: axp20x: Add support for RSB based AXP223
Message-ID: <1448606610-32647-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This is v5 of the AXP223 PMIC series. v5 cleans up the code before and
after the axp20x split, as suggested by Andy.

Changes since v4:

  - Get rid of second parameter of axp20x_match_device() (new patch 2)

  - Match against dev->driver->of_match_table, so the entirety of
    axp20x_match_device() can be kept in the core. (new patch 3)

  - Move *_device_id tables to bottom of the driver, right above driver
    declaration. (patch 4 & 6)

  - Remove extra whitespaces while moving i2c specific code (patch 4)

  - Remove leftover whitespace and code style issues in axp20x core
    (new patch 5)

  - Remove extra whitespaces in rsb specific code (patch 6)

Changes since v3:

  - Removed settings for axp223 reg_rtc_ldo from board dts files that
    are already in axp22x.dtsi. The name is kept.

  - Dropped simplefb label and defconfig patches, as they are merged.

Changes since v2:

  - s/It's/Its/ for the commit messages of patches 5 and 7

  - Add Rob's Acked-by for patch 1

Changes since v1:

  - Dropped NMI interrupt controller dts patch (Merged)

  - Change MFD_AXP20X to represent the axp20x core, and drop MFD_AXP20X_CORE
  
  - Keep the axp20x core bits named axp20x.c

  - Add patch 7 to add AXP223 to sun8i-q8-common.dtsi

  - Add patch 8 & 9 to update defconfigs

  - Make axp20x drivers tristate and buildable as modules

  - Drop "_sunxi" substring from identifiers in axp20x-rsb driver


This series adds support for the Reduced Serial Bus based AXP223 PMIC.
The AXP223 is functionally identical to the AXP221, which we already
support. Only some default values for the regulators are different.
The defaults fit their recommended application, paired with different
SoCs.

Patch 1 adds AXP223 to the list of supported chips in the DT binding.

Patch 2 splits the axp20x mfd driver into 2 parts, a core library, and
an I2C driver.

Patch 3 adds an RSB based driver for the AXP223.

Patch 4 adds support for the AXP223 regulators

Patch 5 enables the AXP223 PMIC and its regulators for the Sinlinx
SinA33.

Patch 6 enables the AXP223 PMIC and its regulators for A23/A33 based
Q8 devices.


Regards
ChenYu


Chen-Yu Tsai (9):
  mfd: axp20x: Add AXP223 to list of supported PMICs in DT bindings
  mfd: axp20x: Remove second struct device * parameter for
    axp20x_match_device()
  mfd: axp20x: use dev->driver->of_match_table in axp20x_match_device()
  mfd: axp20x: Split the driver into core and i2c bits
  mfd: axp20x: Whitespace, open parenthesis alignment code style fixes
  mfd: axp20x: Add support for RSB based AXP223 PMIC
  regulator: axp20x: Support new AXP223 PMIC
  ARM: dts: sun8i: sinlinx-sina33: Add AXP223 PMIC device and regulator
    nodes
  ARM: dts: sun8i: q8-common: Add AXP223 PMIC device and regulator nodes

 Documentation/devicetree/bindings/mfd/axp20x.txt |   7 +-
 arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts   |  76 ++++++++++++++++-
 arch/arm/boot/dts/sun8i-q8-common.dtsi           |  83 +++++++++++++++++-
 drivers/mfd/Kconfig                              |  25 ++++--
 drivers/mfd/Makefile                             |   2 +
 drivers/mfd/axp20x-i2c.c                         | 102 +++++++++++++++++++++++
 drivers/mfd/axp20x-rsb.c                         |  78 +++++++++++++++++
 drivers/mfd/axp20x.c                             | 101 +++++-----------------
 drivers/regulator/axp20x-regulator.c             |   3 +
 include/linux/mfd/axp20x.h                       |  34 +++++++-
 10 files changed, 418 insertions(+), 93 deletions(-)
 create mode 100644 drivers/mfd/axp20x-i2c.c
 create mode 100644 drivers/mfd/axp20x-rsb.c

-- 
2.6.2
