From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 23 Mar 2017 16:19:00 +0100
Subject: [PATCH v3 0/7] Add support for pinctrl/gpio on Armada 37xx
Message-ID: <cover.72ded2a212a37139db2a4193482b04a84a545a48.1490282185.git-series.gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

In this third version I finally managed to use gpio-ranges from the
device tree. For the record, this series adds support for the pin and
gpio controllers present on the Armada 37xx SoCs.

Each Armada 37xx SoC comes with 2 pin controllers: one on the south
bridge (managing 28 pins) and one on the north bridge (managing 36 pins).

At the hardware level the controller configure the pins by group and not
pin by pin.

The gpio controller is also capable to handle interrupt from gpio.

Changelog

v2 -> v3
 - use gpio-ranges (patch 4)

 - Document gpio-ranges usage (patch 1)

 - do not use anymore a global pin index (patch 3)

v1 -> v2:
- Update binding documentation making clear that mfd and syscon must
  be used (patch 1).

- Split the fist patch adding pin controller support for Armada 37xx
  in arm64 part (for kconfig) and pinctrl part (patch 2 and 3)

- Add MFD_SYSCON dependency (patch 3)

- Add kerneldoc for the armada_37xx_pin_group struct (patch 3)

- Rename _add_function() to armada_37xx_add_function() (patch 3)

- Use an inline function to update the reg offset (patch 4)

- Rename gpiolib_register to gpiochip_register (patch 4)

- Add a comment about the two registers limit (patch 4)

- Add explicit gpio node in the device tree (patch 4)

- Convert the driver to use GPIOLIB_IRQCHIP (patch 5)

- Add a critical section when accessing the hardware registers (patch 5)

- Use the gpio subnode (patch 5)

Thanks,

Gregory

Gregory CLEMENT (7):
  pinctrl: dt-bindings: Add documentation for Armada 37xx pin controllers
  arm64: marvell: enable the Armada 37xx pinctrl driver
  pinctrl: armada-37xx: Add pin controller support for Armada 37xx
  pinctrl: armada-37xx: Add gpio support
  pinctrl: aramda-37xx: Add irqchip support
  ARM64: dts: marvell: Add pinctrl nodes for Armada 3700
  ARM64: dts: marvell: armada37xx: add pinctrl definition

 Documentation/devicetree/bindings/clock/armada3700-xtal-clock.txt         |   7 +-
 Documentation/devicetree/bindings/pinctrl/marvell,armada-37xx-pinctrl.txt | 183 ++++++++++++++-
 arch/arm64/Kconfig.platforms                                              |   2 +-
 arch/arm64/boot/dts/marvell/armada-3720-db.dts                            |   8 +-
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi                              |  73 +++++-
 drivers/pinctrl/Makefile                                                  |   2 +-
 drivers/pinctrl/mvebu/Kconfig                                             |   7 +-
 drivers/pinctrl/mvebu/Makefile                                            |   3 +-
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c                               | 910 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 9 files changed, 1187 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/marvell,armada-37xx-pinctrl.txt
 create mode 100644 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c

base-commit: c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201
-- 
git-series 0.9.1
