From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Fri,  6 Mar 2015 16:05:18 +0100
Subject: [PATCH v2 00/10] ARM: berlin: refactor chip and system controllers
Message-ID: <1425654328-26298-1-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Marvell Berlin SoCs have a chip control register set providing several
individual registers dealing with various controllers (pinctrl, reset,
clk). This chip controller is described by a single DT node since the
individual registers are spread among the chip control register bank.

Marvell Berlin also have a system control register set providing several
individual registers for pinctrl or adc.

Prior to this series, there was no proper way of probing properly the
devices using one of the chip and system controller nodes. The pinctrl
driver was probed using the DT and the reset controller had an initcall.

This series aims to handle these two nodes correctly, by using the newly
available simple-mfd compatible, to register all the sub-devices. Syscon
is also used to provide a regmap to the sub-node drivers, so that they
can access the registers of the controllers safely. In addition, the
clock driver will need the regmap early during the boot, so syscon is a
good choice here.

Reworks were done in the Berlin pin controller and in the Berlin reset
driver, to take the changes into account (proper compatibles, syscon
helpers, regmap use).

The actual clock driver still works with these modifications, and a
dedicated series will follow to convert the Berlin clock drivers to use
the regmap provided by syscon.

Applies on top of v4.0-rc1 and [1]. Tested on the Marvell BG2Q DMP.

Thanks!

Antoine

[1] https://patchwork.kernel.org/patch/5920831/

Changes since v1:
	- Removed the custom MFD driver for Berlin and use simple-mfd
	  instead.

Antoine Tenart (10):
  Documentation: bindings: update the Berlin controllers documentation
  ARM: berlin: select MFD_SYSCON by default
  reset: berlin: convert to a platform driver
  Documentation: bindings: move the Berlin reset documentation
  pinctrl: berlin: use the regmap provided by syscon
  pinctrl: berlin: use proper compatibles
  Documentation: bindings: move the Berlin pinctrl documentation
  ARM: berlin: rework chip and system controller nodes for BG2
  ARM: berlin: rework chip and system controller nodes for BG2CD
  ARM: berlin: rework chip and system controller nodes for BG2Q

 .../devicetree/bindings/arm/marvell,berlin.txt     | 73 +++++-----------------
 .../devicetree/bindings/pinctrl/berlin,pinctrl.txt | 43 +++++++++++++
 .../devicetree/bindings/reset/berlin,reset.txt     | 23 +++++++
 arch/arm/boot/dts/berlin2.dtsi                     | 50 +++++++++------
 arch/arm/boot/dts/berlin2cd.dtsi                   | 32 +++++++---
 arch/arm/boot/dts/berlin2q.dtsi                    | 70 ++++++++++++---------
 arch/arm/mach-berlin/Kconfig                       |  1 +
 drivers/pinctrl/berlin/berlin-bg2.c                | 26 +-------
 drivers/pinctrl/berlin/berlin-bg2cd.c              | 26 +-------
 drivers/pinctrl/berlin/berlin-bg2q.c               | 26 +-------
 drivers/pinctrl/berlin/berlin.c                    |  9 ++-
 drivers/reset/reset-berlin.c                       | 71 ++++++++-------------
 12 files changed, 216 insertions(+), 234 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/berlin,pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/reset/berlin,reset.txt

-- 
2.3.1
