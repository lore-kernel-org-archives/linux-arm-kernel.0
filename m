From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 12 Feb 2016 10:02:37 +0800
Subject: [PATCH v8 00/10] mfd: axp20x: Add support for RSB based AXP223
Message-ID: <1455242567-17880-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This is v8 of the AXP223 PMIC series. All the driver bits are acked.
Lee, please merge the first 8 patches. Once they're in, Maxime can take
the DTS patches.

Changes since v7:

  - Shortened commit message of "mfd: axp20x: Add missing copyright notice"

Changes since v6:

  - Add copyright notice to axp20x-rsb.c

  - Correct order of header files in axp20x-rsb.c

  - Use generic dev_set_drvdata() instead of sunxi_rsb_device_set_drvdata()

  - Drop file name from file headers

  - Add patch adding missing copyright notice for original axp20x author

Changes since v5:

  - Correct AXP223 address to 0x3a3.

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

Patch 2 gets rid of the extra "struct device *" parameter from
axp20x_match_device().

Patch 3 makes axp20x_match_device() use dev->driver->of_match_table,
so the function can be library-ized without modification.

Patch 4 adds the missing copyright notice for axp20x's original author.

Patch 5 splits the axp20x mfd driver into 2 parts, a core library, and
an I2C driver.

Patch 6 cleans up some leftover whitespace issues in axp20x core.

Patch 7 adds an RSB based driver for the AXP223.

Patch 8 adds support for the AXP223 regulators

Patch 9 enables the AXP223 PMIC and its regulators for the Sinlinx
SinA33.

Patch 10 enables the AXP223 PMIC and its regulators for A23/A33 based
Q8 tablet devices.


Regards
ChenYu


Chen-Yu Tsai (10):
  mfd: axp20x: Add AXP223 to list of supported PMICs in DT bindings
  mfd: axp20x: Remove second struct device * parameter for
    axp20x_match_device()
  mfd: axp20x: use dev->driver->of_match_table in axp20x_match_device()
  mfd: axp20x: Add missing copyright notice
  mfd: axp20x: Split the driver into core and i2c bits
  mfd: axp20x: Whitespace, open parenthesis alignment code style fixes
  mfd: axp20x: Add support for RSB based AXP223 PMIC
  regulator: axp20x: Support new AXP223 PMIC
  ARM: dts: sun8i: sinlinx-sina33: Add AXP223 PMIC device and regulator
    nodes
  ARM: dts: sun8i: q8-common: Add AXP223 PMIC device and regulator nodes

 Documentation/devicetree/bindings/mfd/axp20x.txt |   7 +-
 arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts   |  76 +++++++++++++++-
 arch/arm/boot/dts/sun8i-q8-common.dtsi           |  83 +++++++++++++++++-
 drivers/mfd/Kconfig                              |  25 ++++--
 drivers/mfd/Makefile                             |   2 +
 drivers/mfd/axp20x-i2c.c                         | 104 ++++++++++++++++++++++
 drivers/mfd/axp20x-rsb.c                         |  80 +++++++++++++++++
 drivers/mfd/axp20x.c                             | 105 ++++++-----------------
 drivers/regulator/axp20x-regulator.c             |   3 +
 include/linux/mfd/axp20x.h                       |  34 +++++++-
 10 files changed, 425 insertions(+), 94 deletions(-)
 create mode 100644 drivers/mfd/axp20x-i2c.c
 create mode 100644 drivers/mfd/axp20x-rsb.c

-- 
2.7.0
