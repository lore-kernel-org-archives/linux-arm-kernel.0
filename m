From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Fri,  1 Dec 2017 14:44:41 +0100
Subject: [PATCH v4 00/10] add pinmuxing support for pins in AXP209 and AXP813
 PMICs
Message-ID: <cover.3ff63fdf302c6bda02ea7d160ad2aa5afee0899d.1512135804.git-series.quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The AXP209 and AXP813 PMICs have several pins (respectively 3 and 2) that can
be used either as GPIOs or for other purposes (ADC or LDO here).

We already have a GPIO driver for the GPIO use of those pins on the AXP209.
Let's "upgrade" this driver to support all the functions these pins can have.

Then we add support to this driver for the AXP813 which is slighlty different
(basically a different offset in two registers and one less pin).

I suggest patches 1 to 8 go through Linus's tree and 9 and 10 via Maxime or
Chen-Yu's tree.

v4:
  - separate dt-binding patch when adding pinctrl feature,
  - use - instead of _ in DT node name,
  - remove muxing operation from pinctrl driver when choosing LDO mux in order
  to not interfere with the regulator framework,
  - add adc_mux to specify specific mux value for ADC (different between AXP209
  and AXP813),
  - misc modifications (header include reordering, unsigned int -> u8,
  new line removal),

v3:
  - add defines for GPIO funcs,
  - use again get_regs function instead of drv_data (which was implemented in
  v2),
  - use of_device_id data for device specific data (gpio_status_offset and pins
  description),
  - change compatible from axp813-pctl to axp813-gpio,
  - use axp81x DT label instead of axp813 since AXP813 and AXP818 are similar,
  - add dtsi include for all boards embedding axp813/axp818,

v2:
  - add support for AXP813 pins,
  - split into more patches so it is easier to follow the modifications,
  - reorder of some patches,
  - register all pins within the same range instead of a range per pin,

Thanks,
Quentin

Quentin Schulz (10):
  pinctrl: move gpio-axp209 to pinctrl
  pinctrl: axp209: add pinctrl features
  dt-bindings: gpio: gpio-axp209: add pinctrl features
  pinctrl: axp209: rename everything from gpio to pctl
  pinctrl: axp209: add programmable gpio_status_offset
  pinctrl: axp209: add programmable ADC muxing value
  pinctrl: axp209: add support for AXP813 GPIOs
  mfd: axp20x: add pinctrl cell for AXP813
  ARM: dtsi: axp81x: add GPIO DT node
  ARM: dtsi: axp81x: set pinmux for GPIO0/1 when used as LDOs

 Documentation/devicetree/bindings/gpio/gpio-axp209.txt |  41 +-
 arch/arm/boot/dts/axp81x.dtsi                          |  20 +-
 drivers/gpio/Kconfig                                   |   6 +-
 drivers/gpio/Makefile                                  |   1 +-
 drivers/gpio/gpio-axp209.c                             | 188 +----
 drivers/mfd/axp20x.c                                   |   3 +-
 drivers/pinctrl/Kconfig                                |   6 +-
 drivers/pinctrl/Makefile                               |   1 +-
 drivers/pinctrl/pinctrl-axp209.c                       | 477 ++++++++++-
 9 files changed, 546 insertions(+), 197 deletions(-)
 delete mode 100644 drivers/gpio/gpio-axp209.c
 create mode 100644 drivers/pinctrl/pinctrl-axp209.c

base-commit: fb20eb9d798d2f4c1a75b7fe981d72dfa8d7270d
-- 
git-series 0.9.1
