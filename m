From: rjui@broadcom.com (Ray Jui)
Date: Mon, 9 Mar 2015 13:44:54 -0700
Subject: [PATCH v6 0/8] Add pinctrl support to Broadcom Cygnus SoC
Message-ID: <1425933902-20652-1-git-send-email-rjui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset contains the pinmux (IOMUX) and GPIO/PINCONF support for
Broadcom Cygnus SoC.

The Cygnus IOMUX controller supports group based mux
configuration and allows certain pins to be muxed to GPIO function
individually. The IOMUX controller is supported by the pinctrl-cygnus-mux.c
driver.

Cygnus has 3 GPIO controllers: 1) the ASIU GPIO; 2) the chipCommonG GPIO;
and 3) the ALWAYS-ON GPIO. All 3 Cygnus GPIO controllers support basic PINCONF
functions such as bias pull up, pull down, and drive strength configuration,
when pins are muxed to GPIO. GPIO/PINCONF support is in the
pinctrl-cygnus-gpio.c driver.

Note pins from the ASIU GPIO can be individually muxed to GPIO function,
through interaction with the Cygnus IOMUX controller.

Changes from v5:
 - Remove ngpios device tree property. Instead, determine the number of GPIO
   based on compaitble string in the driver
 - Remove all MODULE_* related macros in the driver since the driver will never
   be compiled as a kernel loadable module

Changes from v4:
 - Rebased to Linux 4.0-rc2
 - Switched to use the newly available pinconf_generic_dt_node_to_map_group
   function for mapping DT mux properties in the IOMUX driver. This helps
   to get rid of customized device tree parsing code in the driver
 - Consolidated the other Cygnus GPIO/PINCONF patchset into one single patchset
 - Tuned up the GPIO/PINCONF driver a bit more, based on code review comments
   from Linus Walleij

Changes from v3:
 - Fix the driver to have more proper use of "const" in various places
 - Other minor improvements

Changes from v2:
 - Consolidate all Broadcom pinctrl drivers into drivers/pinctrl/bcm/*
 - Change the Cygnus IOMUX driver to use standard Linux pinctrl subnode
properties such as "function" and "groups" for pinmux configuration, instead
of non-standard properties such as "brcm,function" and "brcm,group"
 - Use real function names like "spi0", "lcd", "key", and etc. instead of HW
specific mux names like "alt1", "alt2", "alt3", and etc.
 - Add suffix "grp" to all group names
 - Add support to allow individual pins to be muxed to GPIO function through
subsystem callbacks "gpio_request_enable" and "gpio_disable_free", and get rid
of all GPIO groups
 - Other minor improvements in the driver

Changes from v1:
 - Fix a typo in device tree binding document

Ray Jui (8):
  pinctrl: bcm: consolidate Broadcom pinctrl drivers
  pinctrl: Broadcom Cygnus pinctrl device tree binding
  pinctrl: cygnus: add initial IOMUX driver support
  ARM: dts: enable IOMUX for Broadcom Cygnus
  pinctrl: Cygnus: define Broadcom Cygnus GPIO/PINCONF binding
  pinctrl: cygnus: add gpio/pinconf driver
  ARM: dts: enable GPIO for Broadcom Cygnus
  ARM: dts: cygnus: enable GPIO based hook detection

 .../bindings/pinctrl/brcm,cygnus-gpio.txt          |   98 ++
 .../bindings/pinctrl/brcm,cygnus-pinmux.txt        |  132 +++
 arch/arm/boot/dts/bcm-cygnus.dtsi                  |   36 +
 arch/arm/boot/dts/bcm911360_entphn.dts             |   13 +
 drivers/pinctrl/Kconfig                            |   19 +-
 drivers/pinctrl/Makefile                           |    3 +-
 drivers/pinctrl/bcm/Kconfig                        |   56 ++
 drivers/pinctrl/bcm/Makefile                       |    6 +
 drivers/pinctrl/{ => bcm}/pinctrl-bcm281xx.c       |    4 +-
 drivers/pinctrl/{ => bcm}/pinctrl-bcm2835.c        |    0
 drivers/pinctrl/bcm/pinctrl-cygnus-gpio.c          |  907 +++++++++++++++++
 drivers/pinctrl/bcm/pinctrl-cygnus-mux.c           | 1017 ++++++++++++++++++++
 12 files changed, 2269 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/brcm,cygnus-gpio.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/brcm,cygnus-pinmux.txt
 create mode 100644 drivers/pinctrl/bcm/Kconfig
 create mode 100644 drivers/pinctrl/bcm/Makefile
 rename drivers/pinctrl/{ => bcm}/pinctrl-bcm281xx.c (99%)
 rename drivers/pinctrl/{ => bcm}/pinctrl-bcm2835.c (100%)
 create mode 100644 drivers/pinctrl/bcm/pinctrl-cygnus-gpio.c
 create mode 100644 drivers/pinctrl/bcm/pinctrl-cygnus-mux.c

-- 
1.7.9.5
