From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue,  7 Apr 2015 16:45:00 +0200
Subject: [PATCH v3 0/9] ARM: berlin: refactor the clock
Message-ID: <1428417909-27378-1-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Since v2, this series has changed a lot. We postponed the introduction
of regmap into the Berlin clock driver (and some parts of the clock
framework) to first take care of the Berlin DT reorganisation of the
chip and system controllers.

Marvell Berlin SoCs have a chip control register set providing several
individual registers dealing with various controllers (pinctrl, reset,
clk). This chip controller is described by a single DT node since the
individual registers are spread among the chip control register bank.

Marvell Berlin also have a system control register set providing several
individual registers for pinctrl or adc.

A series was sent[1] to correctly handle these two nodes, by using
simple-mfd. The series converted the existing pin-controller and reset
drivers to take the changes into account.

This series moves the clock DT bindings into their own sub-node of the
chip controller node, and make minor changes into the Berlin clock
driver to take this change into account.

This series has been tested on the Marvell Berlin BG2Q DMP.

This series is based on v4.0-rc1 and [1].

Thanks!

Antoine

[1] https://lkml.org/lkml/2015/3/6/511

Changes since v2:
	- Removed all regmap related changes and kept only minor
	  needed changes in the Berlin clock driver.

Changes since v1:
        - Rebased of top of the new version of [1].
	- Removed now useless chip and system ctrl compatibles.

Antoine Tenart (9):
  clk: berlin: move to a dedicated sub-node
  Documentation: bindings: move the Berlin clock documentation
  ARM: berlin: rework the clock node for BG2
  ARM: berlin: rework the clock node for BG2CD
  ARM: berlin: rework the clock node for BG2Q
  Documentation: bindings: update the berlin chip and system ctrl doc
  ARM: berlin: remove useless chip and system ctrl compatibles in BG2
  ARM: berlin: remove useless chip and system ctrl compatibles in BG2CD
  ARM: berlin: remove useless chip and system ctrl compatibles in BG2Q

 .../devicetree/bindings/arm/marvell,berlin.txt     | 43 +++-------------
 .../devicetree/bindings/clock/marvell,berlin.txt   | 31 ++++++++++++
 arch/arm/boot/dts/berlin2.dtsi                     | 47 ++++++++++--------
 arch/arm/boot/dts/berlin2cd.dtsi                   | 43 ++++++++--------
 arch/arm/boot/dts/berlin2q.dtsi                    | 57 ++++++++++++----------
 drivers/clk/berlin/bg2.c                           |  7 ++-
 drivers/clk/berlin/bg2q.c                          |  7 +--
 7 files changed, 127 insertions(+), 108 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/marvell,berlin.txt

-- 
2.3.5
