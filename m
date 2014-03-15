From: carlo@caione.org (Carlo Caione)
Date: Sat, 15 Mar 2014 16:43:37 +0100
Subject: [PATCH v2 0/8] mfd: AXP20x: Add support for AXP202 and AXP209
Message-ID: <1394898225-28452-1-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AXP209 and AXP202 are the PMUs (Power Management Unit) used by A10, A13
and A20 SoCs and developed by X-Powers, a sister company of Allwinner.
AXP20x comprises an adaptive USB-Compatible PWM charger, 2 BUCK DC-DC
converters, 5 LDOs, multiple 12-bit ADCs of voltage, current and temperature
as well as 4 configurable GPIOs. 

This set of patches introduces the core driver and support for two different
subsystems:
	- Regulators
	- PEK (Power Enable Key)

This patchset depends on patchsets:
	irq: sun4i IRQ 0 / ENMI fixes (Hans de Goede)
	ARM: sun7i/sun6i: irqchip: Irqchip driver for NMI controller (Carlo Caione)

Changes since v1:
	- Added a new standalone patch for defconfig

	- MFD core:
	  * Removed axp,system-power-controller property

	- Bindings documentation:
	  * Corrected description for dcdc-workmode property
	  * Removed unused axp20x-pek compatible

	- Input misc PEK driver:
	  * Fixed seconds in lower case

	- Regulators subsystem:
	  * Fixed axp20x_set_suspend_voltage()
	  * Switched to using multi-bit control for regulators
	  * When "regulators" node is not found driver doesn't quit
	  * Driver is now using devm_regulator_register()
	  * Added module_platform_driver() instead of subsys_initcall()

	- DT:
	  * Added new DTSI for AXP209
	  * Added support for cubietruck and olinuxino-micro

Carlo Caione (8):
  mfd: AXP20x: Add mfd driver for AXP20x PMIC
  mfd: AXP20x: Add bindings documentation
  input: misc: Add driver for AXP20x Power Enable Key
  input: misc: Add ABI docs for AXP20x PEK
  regulator: AXP20x: Add support for regulators subsystem
  ARM: sunxi: dt: Add x-powers-axp209.dtsi file
  ARM: sun7i: dt: Add AXP209 support to various boards
  ARM: sunxi: Add AXP20x support in defconfig

 .../ABI/testing/sysfs-driver-input-axp-pek         |  11 +
 Documentation/devicetree/bindings/mfd/axp20x.txt   |  83 ++++++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts        |  12 +
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts         |  13 +
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts    |  12 +
 arch/arm/boot/dts/x-powers-axp209.dtsi             |  60 +++++
 arch/arm/configs/sunxi_defconfig                   |   4 +
 drivers/input/misc/Kconfig                         |  11 +
 drivers/input/misc/Makefile                        |   1 +
 drivers/input/misc/axp20x-pek.c                    | 267 +++++++++++++++++++
 drivers/mfd/Kconfig                                |  12 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/axp20x.c                               | 247 +++++++++++++++++
 drivers/regulator/Kconfig                          |   7 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/axp20x-regulator.c               | 293 +++++++++++++++++++++
 include/linux/mfd/axp20x.h                         | 179 +++++++++++++
 18 files changed, 1215 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-input-axp-pek
 create mode 100644 Documentation/devicetree/bindings/mfd/axp20x.txt
 create mode 100644 arch/arm/boot/dts/x-powers-axp209.dtsi
 create mode 100644 drivers/input/misc/axp20x-pek.c
 create mode 100644 drivers/mfd/axp20x.c
 create mode 100644 drivers/regulator/axp20x-regulator.c
 create mode 100644 include/linux/mfd/axp20x.h

-- 
1.8.3.2
