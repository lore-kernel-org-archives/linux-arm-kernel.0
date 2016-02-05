From: marcel.ziswiler@toradex.com (Marcel Ziswiler)
Date: Fri,  5 Feb 2016 17:12:19 +0100
Subject: [PATCH v5 0/2] ARM: dts: imx6: Add support for Toradex Apalis iMX6Q/D
 SoM/Ixora carrier board
Message-ID: <1454688741-4238-1-git-send-email-marcel.ziswiler@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This patch series adds support for Toradex Apalis iMX6Q/D SoM module [1] and
Ixora carrier board [2].

Petr ?tetiar has simply taken content of DTSes from Toradex's Git tree [3],
removed not mainlined stuff and fixed all errors returned by checkpatch script.

Please note that RESET_MOCI# used as mini-PCIe PERST# is not directly
GPIO1_IO28 but rather inverted (e.g. active-high and ored with RESETBMCU coming
off the PMIC but that is not relevant in this context). As changing the
reset-gpio polarity wasn't previously supported Petr ?tetiar's
"PCI: imx6: Fix reset-gpio to work with active low GPIO" fix [4] is needed.

1. https://www.toradex.com/computer-on-modules/apalis-arm-family/freescale-imx-6
2. https://www.toradex.com/products/carrier-boards/ixora-carrier-board
3. https://git.toradex.com/cgit/linux-toradex.git/log/?h=toradex_imx_3.14.28_1.0.0_ga
4. https://patchwork.ozlabs.org/patch/552886/

Changes in v5:
- finally get rid of regulators simple bus as suggested by Lucas, Petr and Shawn
- use reg_xxx: regulator-xxx naming scheme as suggested by Shawn
- get rid of disabled hdmi node as suggested by Shawn
- have a new line between properties and sub-node as suggested by Shawn
- get rid of disabled usbh1 node as suggested by Shawn
- drop iomux/pinctrl function container nodes as suggested by Shawn
- added new lines between nodes as suggested by Shawn
- use consistent pinctrl group node naming schema xxxgrp as suggested by Shawn
- further clean-up and re-order iomux/pinctrl stuff
- configure eMMC reset as required once fast boot mode is used
- properly set usdhc1, usdhc2 and usdhc3 vqmmc-supply rather than vmmc-supply we previously set leading to wrong signal voltage being reported
- drop iomux/pinctrl function container node as suggested by Shawn
- added new line between nodes as suggested by Shawn
- use consistent pinctrl group node naming schema xxxgrp as suggested by Shawn
- replace the gpio-key,wakeup property with the generic wakeup-source one as suggested by Shawn
- drop regulators function container node and use simple label reference to enable USB VBUS' as suggested by Shawn

Changes in v4:
- integrated review feedback from Fabio

Changes in v3:
- integrated review feedback from Petr
- integrated review feedback from Stefan
- move I2C DDC enablement and assignement handling into carrier board DTS where it belongs
- move CAN nodes up a little to keep the alphabetical order
- added an explanatory comment about PWR_I2C usage
- integrated review feedback from Petr
- integrated review feedback from Stefan
- fix comment concerning Apalis GPIO usage as GPIO7 is only used for PCIe switch reset on Apalis Evaluation board
- move I2C DDC handling into carrier board DTS where it belongs
- simplify RTC alias

Changes in v2:
- clarify exact Apalis iMX6Q/D SoM type in cover letter
- clarify exact Apalis iMX6Q/D module type and Ixora carrier board in model
  node
- got rid of obsolete mmc aliases
- working SGTL5000 audio/sound integration
- working STMPE811 touch screen controller integration
- integrated review feedback from Lucas
- left and even added some more comments as I don't see why putting any
  explanatory comments in dts' should be such a bad thing to do
- completely got rid of the memory node as that is something typically filled
  in by the boot loader e.g. U-Boot
- without the regulators simple-bus it no longer boots
- even though we supposedly shipped a few hundred V1.0a modules drop DCE UART
  support for now and simplify file layout
- replaced obsolete no-1-8-v by mainline supported voltage-ranges = <3300 3300>
  usdhc property and yes card detects are indeed active low (;-p)
- integrated review feedback from Stefan
- fixed Ethernet PHY reset & interrupt (requires Micrel PHY driver to be
  enabled)
- fixed HDMI DDC (requires GPIO-based bitbanging I2C to be enabled)
- fixed SPDIF
- clarify exact Apalis iMX6Q/D SoM type in cover letter
- clarify exact Apalis iMX6Q/D module type and Ixora carrier board in model
  node
- got rid of obsolete mmc aliases
- working SGTL5000 audio/sound integration
- working STMPE811 touch screen controller integration
- integrated review feedback from Lucas
- left and even added some more comments as I don't see why putting any
  explanatory comments in dts' should be such a bad thing to do
- completely got rid of the memory node as that is something typically filled
  in by the boot loader e.g. U-Boot
- without the regulators simple-bus it no longer boots
- even though we supposedly shipped a few hundred V1.0a modules drop DCE UART
  support for now and simplify file layout
- replaced obsolete no-1-8-v by mainline supported voltage-ranges = <3300 3300>
  usdhc property and yes card detects are indeed active low (;-p)
- integrated review feedback from Stefan
- fixed Ethernet PHY reset & interrupt (requires Micrel PHY driver to be
  enabled)
- fixed HDMI DDC (requires GPIO-based bitbanging I2C to be enabled)
- fixed SPDIF

Petr ?tetiar (2):
  ARM: dts: imx6: Add support for Toradex Apalis iMX6Q/D SoM
  ARM: dts: imx6: Add support for Toradex Ixora carrier board

 arch/arm/boot/dts/Makefile               |   1 +
 arch/arm/boot/dts/imx6q-apalis-ixora.dts | 272 +++++++++
 arch/arm/boot/dts/imx6qdl-apalis.dtsi    | 984 +++++++++++++++++++++++++++++++
 3 files changed, 1257 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6q-apalis-ixora.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-apalis.dtsi

-- 
2.5.0
