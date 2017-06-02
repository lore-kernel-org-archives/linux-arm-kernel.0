From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri,  2 Jun 2017 16:23:07 +0200
Subject: [PATCH v2 00/11] Add support for the pin and gpio controllers on the
 Marvell Armada 7K/8K
Message-ID: <cover.8fe5f7c62a787452878ca071fa00b953e96988ef.1496413293.git-series.gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

As requested by Linus Walleij this series is a merge between the series
"Add support for the pin controllers on the Marvell Armada 7K/8K" [1]
and "Extend mvebu gpio driver to support the controllers of the
Marvell Armada 7K/8K" [2].

The first part of the series is adding the support for the pin
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

The patch modifying the documentation still depend on the ones of the
clk series. For the ap806 a first stable branch is already available:
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/log/?h=clk-ap806

Also note that the dts patch have to be merged through the mvebu tree
to avoid merge conflict expected with the ICU series sent a few days
ago.

Thanks,

Gregory

Changelog:
v1 -> v2:

- Merged of the pinctrl and gpio series.

- Rebased on next-20170531 (which contains gpio and pinctrl commit
  already applied).

- Removed already applied patches.

- Remove the modular support of the drivers, suggested by Paul
  Gortmaker.

- Added tested-by from Thomas Petazzoni.

- Added acked-by from Rob Herring.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-May/507396.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-May/507405.html

Gregory CLEMENT (8):
  pinctrl: dt-bindings: add documentation for AP806 pin controllers
  pinctrl: dt-bindings: add documentation for CP110 pin controllers
  pinctrl: mvebu: remove the offset property for regmap
  arm64: marvell: enable the Armada 7K/8K pinctrl driver
  arm64: dts: marvell: add pinctrl support for Armada 7K/8K
  gpio: dt-bindings: Add documentation for gpio controllers on Armada 7K/8K
  gpio: mvebu: Add support for the Armada 7K/8K SoCs
  arm64: dts: marvell: add gpio support for Armada 7K/8K

Hanna Hawa (2):
  pinctrl: mvebu: add driver for Armada AP806 pinctrl
  pinctrl: mvebu: add driver for Armada CP110 pinctrl

Russell King (1):
  pinctrl: avoid PLAT_ORION dependency

 Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt  |  73 +++++++-
 Documentation/devicetree/bindings/arm/marvell/cp110-system-controller0.txt | 123 ++++++++++++-
 Documentation/devicetree/bindings/gpio/gpio-mvebu.txt                      |  24 ++-
 arch/arm64/Kconfig.platforms                                               |   2 +-
 arch/arm64/boot/dts/marvell/armada-7020.dtsi                               |   2 +-
 arch/arm64/boot/dts/marvell/armada-7040.dtsi                               |   2 +-
 arch/arm64/boot/dts/marvell/armada-70x0.dtsi                               |  68 +++++++-
 arch/arm64/boot/dts/marvell/armada-8020.dtsi                               |   3 +-
 arch/arm64/boot/dts/marvell/armada-8040.dtsi                               |   3 +-
 arch/arm64/boot/dts/marvell/armada-80x0.dtsi                               |  76 ++++++++-
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi                              |  14 +-
 arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi                       |  21 ++-
 arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi                        |  22 ++-
 drivers/gpio/gpio-mvebu.c                                                  | 212 ++++++++++++++--------
 drivers/pinctrl/mvebu/Kconfig                                              |  12 +-
 drivers/pinctrl/mvebu/Makefile                                             |   2 +-
 drivers/pinctrl/mvebu/pinctrl-armada-ap806.c                               | 140 +++++++++++++++-
 drivers/pinctrl/mvebu/pinctrl-armada-cp110.c                               | 687 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/pinctrl/mvebu/pinctrl-mvebu.c                                      |   6 +-
 drivers/pinctrl/mvebu/pinctrl-mvebu.h                                      |   2 +-
 20 files changed, 1386 insertions(+), 108 deletions(-)
 create mode 100644 arch/arm64/boot/dts/marvell/armada-70x0.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/armada-80x0.dtsi
 create mode 100644 drivers/pinctrl/mvebu/pinctrl-armada-ap806.c
 create mode 100644 drivers/pinctrl/mvebu/pinctrl-armada-cp110.c

base-commit: 342db02d4f2e08aed46ecae7c1572582049685d6
-- 
git-series 0.9.1
