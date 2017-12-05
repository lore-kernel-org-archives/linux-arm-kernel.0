From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Tue,  5 Dec 2017 15:46:38 +0100
Subject: [PATCH v5 00/11] add pinmuxing support for pins in AXP209 and AXP813
 PMICs
Message-ID: <20171205144647.17594-1-quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The AXP209 and AXP813 PMICs have several pins (respectively 3 and 2) that can
be used either as GPIOs or for other purposes (ADC or LDO here).

We already have a GPIO driver for the GPIO use of those pins on the AXP209.
Let's "upgrade" this driver to support all the functions these pins can have.

Then we add support to this driver for the AXP813 which is slighlty different
(basically a different offset in two registers and one less pin).

I suggest patches 1 to 8 go through Linus's tree and 9 via Lee's.

v5:
  - add reference to pinctrl dt-bindings in driver's dt-binding,
  - add statement that this driver employs per-pin muxing pattern,
  - add a patch on top of the patch series to fix checkpatch warnings,
  - add a few information to the Kconfig to make checkpatch happy,

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

Quentin Schulz (9):
  gpio: axp209: switch unsigned variables to unsigned int
  pinctrl: move gpio-axp209 to pinctrl
  pinctrl: axp209: add pinctrl features
  dt-bindings: gpio: gpio-axp209: add pinctrl features
  pinctrl: axp209: rename everything from gpio to pctl
  pinctrl: axp209: add programmable gpio_status_offset
  pinctrl: axp209: add programmable ADC muxing value
  pinctrl: axp209: add support for AXP813 GPIOs
  mfd: axp20x: add pinctrl cell for AXP813

 .../devicetree/bindings/gpio/gpio-axp209.txt       |  49 ++-
 drivers/gpio/Kconfig                               |   6 -
 drivers/gpio/Makefile                              |   1 -
 drivers/gpio/gpio-axp209.c                         | 188 --------
 drivers/mfd/axp20x.c                               |   3 +
 drivers/pinctrl/Kconfig                            |  10 +
 drivers/pinctrl/Makefile                           |   1 +
 drivers/pinctrl/pinctrl-axp209.c                   | 476 +++++++++++++++++++++
 8 files changed, 537 insertions(+), 197 deletions(-)
 delete mode 100644 drivers/gpio/gpio-axp209.c
 create mode 100644 drivers/pinctrl/pinctrl-axp209.c

-- 
2.14.1
