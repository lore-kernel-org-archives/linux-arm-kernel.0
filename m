From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 12 Jun 2017 17:34:51 +0200
Subject: [PATCH v3 0/9] Add support for the pin and gpio controllers on the
 Marvell Armada 7K/8K
Message-ID: <cover.d003a5e862e6d732d901a61d1765a349c9a89eef.1497281623.git-series.gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This third version would allow to apply the series without any
conflict:

- This time the series is rebased on gpio/for-next to avoid conflict
  with already applied patches.

- The documentation part has been removed from this series and I will
  asked to Rob Herring to apply through the device tree subsystem.

Thanks to this there is no external dependencies except the dts part
that have to be merged through the mvebu tree.

The first patch is a fix that was already posted.

Then the first part of the series is adding the support for the pin
controllers found on the Marvell Armada 7K/8K.

These controllers are compatible with the ones found on the ARM32
mvebu SoCs. However, the pinctrl node in the device tree of theses
SoCs are child of a syscon. So for them we will reuse the regmap
support introduced by Russell King.

Each component of the Armada 7K and 8K comes with their own pin
controller, that's why we have 2 new drivers: one for the CP110 and
one for the AP806.

The second part of the series extends the mvebu gpio driver to support
the gpio controllers found on the Marvell Armada 7K/8K SoCs.

The gpio controllers used on the Marvell Armada 7K/8K SoCs are the
same that the ones used on the ARM32 mvebu SoCs. However, the pinctrl
node in the device tree of theses SoCs are child of a syscon.

Thanks,

Gregory

Changelog:
v2 -> v3

- Rebased on gpio/for-next.

- Added the fix "gpio: mvebu: fix regmap_update_bits usage" with the
  tested-by and reviewed-by flag

- Removed the binding documentation patch that will be applied through
  an other path.

v1 -> v2:

- Merged of the pinctrl and gpio series.

- Rebased on next-20170531 (which contains gpio and pinctrl commit
  already applied).

- Removed already applied patches.

- Remove the modular support of the drivers, suggested by Paul
  Gortmaker.

- Added tested-by from Thomas Petazzoni.

- Added acked-by from Rob Herring.

Gregory CLEMENT (6):
  gpio: mvebu: fix regmap_update_bits usage
  pinctrl: mvebu: remove the offset property for regmap
  arm64: marvell: enable the Armada 7K/8K pinctrl driver
  arm64: dts: marvell: add pinctrl support for Armada 7K/8K
  gpio: mvebu: Add support for the Armada 7K/8K SoCs
  arm64: dts: marvell: add gpio support for Armada 7K/8K

Hanna Hawa (2):
  pinctrl: mvebu: add driver for Armada AP806 pinctrl
  pinctrl: mvebu: add driver for Armada CP110 pinctrl

Russell King (1):
  pinctrl: avoid PLAT_ORION dependency

 arch/arm64/Kconfig.platforms                         |   2 +-
 arch/arm64/boot/dts/marvell/armada-7020.dtsi         |   2 +-
 arch/arm64/boot/dts/marvell/armada-7040.dtsi         |   2 +-
 arch/arm64/boot/dts/marvell/armada-70x0.dtsi         |  68 +-
 arch/arm64/boot/dts/marvell/armada-8020.dtsi         |   3 +-
 arch/arm64/boot/dts/marvell/armada-8040.dtsi         |   3 +-
 arch/arm64/boot/dts/marvell/armada-80x0.dtsi         |  76 +-
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi        |  14 +-
 arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi |  21 +-
 arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi  |  22 +-
 drivers/gpio/gpio-mvebu.c                            | 216 ++--
 drivers/pinctrl/mvebu/Kconfig                        |  12 +-
 drivers/pinctrl/mvebu/Makefile                       |   2 +-
 drivers/pinctrl/mvebu/pinctrl-armada-ap806.c         | 140 ++-
 drivers/pinctrl/mvebu/pinctrl-armada-cp110.c         | 687 ++++++++++++-
 drivers/pinctrl/mvebu/pinctrl-mvebu.c                |   6 +-
 drivers/pinctrl/mvebu/pinctrl-mvebu.h                |   2 +-
 17 files changed, 1189 insertions(+), 89 deletions(-)
 create mode 100644 arch/arm64/boot/dts/marvell/armada-70x0.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/armada-80x0.dtsi
 create mode 100644 drivers/pinctrl/mvebu/pinctrl-armada-ap806.c
 create mode 100644 drivers/pinctrl/mvebu/pinctrl-armada-cp110.c

base-commit: 77fd50d14eb4a48d00cee84a7beae174f8011157
-- 
git-series 0.9.1
