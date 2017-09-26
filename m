From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Tue, 26 Sep 2017 14:17:10 +0200
Subject: [PATCH v2 00/10] add pinmuxing support for pins in AXP209 and AXP813
 PMICs
Message-ID: <cover.1c314f4154a6d27354625f03d0a5269eee55a9c5.1506428208.git-series.quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The AXP209 and AXP813 PMICs have several pins (respectively 3 and 2) that can
be used either as GPIOs or for other purposes (ADC or LDO here).

We already have a GPIO driver for the GPIO use of those pins on the AXP209.
Let's "upgrade" this driver to support all the functions these pins can have.

Then we add support to this driver for the AXP813 which is slighlty different
(basically a different offset in a register and one less pin).

This is a v2 to a first version that was sent in November 2016.

v2:
  - add support for AXP813 pins,
  - split into more patches so it is easier to follow the modifications,
  - reorder of some patches,
  - register all pins within the same range instead of a range per pin,

Thanks,
Quentin

Maxime Ripard (1):
  ARM: dts: add dtsi for AXP813 PMIC

Quentin Schulz (9):
  pinctrl: move gpio-axp209 to pinctrl
  pinctrl: axp209: add pinctrl features
  pinctrl: axp209: use drv_data of pinctrl_pin_desc to store pin reg
  pinctrl: axp209: rename everything from gpio to pctl
  pinctrl: axp209: add programmable gpio_status_offset
  pinctrl: axp209: add support for AXP813 GPIOs
  mfd: axp20x: add pinctrl cell for AXP813
  ARM: dts: sun8i: a711: include axp813 dtsi
  ARM: dts: sun8i: bananapi-m3: include axp813 dtsi

 Documentation/devicetree/bindings/gpio/gpio-axp209.txt       |  30 +-
 Documentation/devicetree/bindings/pinctrl/pinctrl-axp209.txt |  67 +-
 arch/arm/boot/dts/axp813.dtsi                                |  58 +-
 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts                 |   4 +-
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts                    |   2 +-
 drivers/gpio/Kconfig                                         |   6 +-
 drivers/gpio/Makefile                                        |   1 +-
 drivers/gpio/gpio-axp209.c                                   | 188 +--
 drivers/mfd/axp20x.c                                         |   3 +-
 drivers/pinctrl/Kconfig                                      |   6 +-
 drivers/pinctrl/Makefile                                     |   1 +-
 drivers/pinctrl/pinctrl-axp209.c                             | 610 +++++++-
 12 files changed, 750 insertions(+), 226 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/gpio/gpio-axp209.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-axp209.txt
 create mode 100644 arch/arm/boot/dts/axp813.dtsi
 delete mode 100644 drivers/gpio/gpio-axp209.c
 create mode 100644 drivers/pinctrl/pinctrl-axp209.c

base-commit: 73527316e3fdde8a210b8ab66c1bf48538cf6b09
-- 
git-series 0.9.1
