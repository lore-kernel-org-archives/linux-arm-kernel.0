From: b.galvani@gmail.com (Beniamino Galvani)
Date: Sun, 16 Nov 2014 21:14:13 +0100
Subject: [PATCH v3 0/3] Amlogic Meson pinctrl driver
Message-ID: <1416168856-12747-1-git-send-email-b.galvani@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this is the third version of the pinctrl driver for Amlogic Meson. It
provides a common infrastructure than can be used by all the SoCs of
the family and configuration data specific for Meson8. Adding support
for other SoCs should be only matter of defining new pins and banks.

The driver uses generic DT properties for the definition of mux and
configuration nodes; since there is an ongoing effort to centralize
the parsing to generic code, I've reused the patch "pinctrl:
pinconf-generic: Infer map type from DT property" [1] posted a few
days ago by Soren Brinkmann. I will update the series if that patch is
going to change after the mailing list discussion.

[1] https://lkml.org/lkml/2014/11/3/704

Changes since v2 [ https://lkml.org/lkml/2014/10/14/423 ]
 - move modifications to mach-meson Kconfig to a separate patch
 - use regmap_mmio
 - use generic gpio xlate function
 - don't hardcode gpio base number
 - use gpiochip_add_pin_range()
 - add kerneldoc documentation
 - use plain module_platform_driver() instead of postcore_initcall
 - avoid unneeded copies of platform data

Changes since v1 [ https://lkml.org/lkml/2014/10/7/712 ]
 - added missing checks of return values
 - indentation fixes
 - added missing definitions of groups and functions for Meson8

Beniamino Galvani (3):
  pinctrl: meson: add device tree bindings documentation
  pinctrl: add driver for Amlogic Meson SoCs
  ARM: meson: select PINCTRL_MESON and ARCH_REQUIRE_GPIOLIB

 .../devicetree/bindings/pinctrl/meson,pinctrl.txt  |   97 ++
 arch/arm/mach-meson/Kconfig                        |    3 +
 drivers/pinctrl/Kconfig                            |    8 +
 drivers/pinctrl/Makefile                           |    1 +
 drivers/pinctrl/meson/Makefile                     |    2 +
 drivers/pinctrl/meson/pinctrl-meson.c              |  761 ++++++++++++++
 drivers/pinctrl/meson/pinctrl-meson.h              |  209 ++++
 drivers/pinctrl/meson/pinctrl-meson8.c             | 1087 ++++++++++++++++++++
 include/dt-bindings/gpio/meson8-gpio.h             |  157 +++
 9 files changed, 2325 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
 create mode 100644 drivers/pinctrl/meson/Makefile
 create mode 100644 drivers/pinctrl/meson/pinctrl-meson.c
 create mode 100644 drivers/pinctrl/meson/pinctrl-meson.h
 create mode 100644 drivers/pinctrl/meson/pinctrl-meson8.c
 create mode 100644 include/dt-bindings/gpio/meson8-gpio.h

-- 
1.9.1
