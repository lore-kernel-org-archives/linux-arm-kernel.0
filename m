From: rjui@broadcom.com (Ray Jui)
Date: Wed, 4 Feb 2015 09:20:59 -0800
Subject: [PATCH v8 0/4] Add gpio/pinconf support to Broadcom Cygnus SoC
In-Reply-To: <Ray Jui <rjui@broadcom.com>
References: <Ray Jui <rjui@broadcom.com>
Message-ID: <1423070463-24483-1-git-send-email-rjui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset contains the initial GPIO/PINCONF support for the Broadcom
Cygnus SoC.

Cygnus has 3 GPIO controllers: 1) the ASIU GPIO; 2) the chipCommonG GPIO;
and 3) the ALWAYS-ON GPIO. All 3 types of GPIO controllers are supported by
the this driver.

All 3 Cygnus GPIO controllers support basic PINCONF functions such as bias
pull up, pull down, and drive strength configurations, when these pins are
muxed to GPIO.

Pins from the ASIU GPIO can be individually muxed to GPIO function, through
interaction with the Cygnus IOMUX controller.

Note this patchset has a dependency on the other patchset "Add pinctrl support
to Broadcom Cygnus SoC" that is also under review

Changes from v7:
 - Use 'bool' instead of 'int' for flag that indicates pinmux support in the
   driver
 - Call put_device to drop reference to the pinmux dev after call to
   of_find_device_by_node
 - Replace kasprintf with devm_kasprintf and remove memory deallocation logic
   in the driver
 - Set suppress_bind_attrs to true for the driver

Changes from v6:
 - Move the driver from drivers/gpio/* to drivers/pinctrl/* since this driver
   supports both GPIO and some basic PINCONF features
 - Support PINCONF features through standard DT subnodes properties including
   "bias-disable", "bias-pull-up", "bias-pull-down", and "drive-strength", by
   creating local PINCONF controller
 - Add support to allow individual ASIU GPIO pins to be muxed as GPIO, through
   interactions with the Cygnus IOMUX driver
 - Convert the driver to use standard GPIOCHIP_IRQ APIs. This helps to reduce
   customized code in the driver
 - Other miscellaneous imrpovements in the driver
 - Enable GPIO based phone hook detection support for BCM911360 phone factor
   board

Changes from v5:
 - Get rid of DT property "linux,gpio-base". Use dynamic allocation for GPIO base
   number

Changes from v4:
 - Use DT property "linux,gpio-base" to define GPIO base number
 - factorize common code to improve code readability and reduce code size
 - remove "bcm_" prefix on function and struct names
 - improve debugging prints
 - default GPIO_BCM_CYGNUS to y in Kconfig (it still depends on
   ARCH_BCM_CYGNUS). This way we do not need to select it from the
   arch/arm/mach-bcm/Kconfig
 - Get rid of redundant MAINTAINER entry for this driver. It will be maintained
   by Broadcom iProc/Cygnus maintainers
 - Update device tree document based on driver changes

Changes from v3:
 - Fix dt property tpyo
 - Fix incorrect GPIO compatible ID in device tree binding document example

Changes from v2:
 - Consolidate different compatible IDs into "brcm,cygnus-gpio"
 - Get rid of redundant "no-interrupt" property

Changes from v1:
 - Get rid of inline qualifier
 - Get rid of redundant check in the ISR
 - Other minor fixes to imrove code readability

Ray Jui (4):
  pinctrl: Cygnus: define Broadcom Cygnus GPIO/PINCONF binding
  pinctrl: cygnus: add gpio/pinconf driver
  ARM: dts: enable GPIO for Broadcom Cygnus
  ARM: dts: cygnus: enable GPIO based hook detection

 .../bindings/pinctrl/brcm,cygnus-gpio.txt          |  102 +++
 arch/arm/boot/dts/bcm-cygnus.dtsi                  |   33 +
 arch/arm/boot/dts/bcm911360_entphn.dts             |   13 +
 drivers/pinctrl/bcm/Kconfig                        |   22 +
 drivers/pinctrl/bcm/Makefile                       |    1 +
 drivers/pinctrl/bcm/pinctrl-cygnus-gpio.c          |  907 ++++++++++++++++++++
 6 files changed, 1078 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/brcm,cygnus-gpio.txt
 create mode 100644 drivers/pinctrl/bcm/pinctrl-cygnus-gpio.c

-- 
1.7.9.5
