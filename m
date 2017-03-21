From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 21 Mar 2017 19:28:30 +0100
Subject: [PATCH v2 1/7] pinctrl: dt-bindings: Add documentation for Armada
 37xx pin controllers
In-Reply-To: <cover.26288667a039bc9f8e62dec2fd6342ded4014d12.1490120798.git-series.gregory.clement@free-electrons.com>
References: <cover.26288667a039bc9f8e62dec2fd6342ded4014d12.1490120798.git-series.gregory.clement@free-electrons.com>
Message-ID: <2dc869315a1b6bcc6d7eedd67b9ea8c0483b9789.1490120798.git-series.gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the device tree binding for the pin controllers found on the
Armada 37xx SoCs.

Update the binding documention of the xtal clk which is a subnode of this
syscon node.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 Documentation/devicetree/bindings/clock/armada3700-xtal-clock.txt         |   7 ++--
 Documentation/devicetree/bindings/pinctrl/marvell,armada-37xx-pinctrl.txt | 143 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 147 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/marvell,armada-37xx-pinctrl.txt

diff --git a/Documentation/devicetree/bindings/clock/armada3700-xtal-clock.txt b/Documentation/devicetree/bindings/clock/armada3700-xtal-clock.txt
index a88f1f05fbd6..4c0807f28cfa 100644
--- a/Documentation/devicetree/bindings/clock/armada3700-xtal-clock.txt
+++ b/Documentation/devicetree/bindings/clock/armada3700-xtal-clock.txt
@@ -5,6 +5,7 @@ reading the gpio latch register.
 
 This node must be a subnode of the node exposing the register address
 of the GPIO block where the gpio latch is located.
+See Documentation/devicetree/bindings/pinctrl/marvell,armada-37xx-pinctrl.txt
 
 Required properties:
 - compatible : shall be one of the following:
@@ -16,9 +17,9 @@ Optional properties:
 	output names ("xtal")
 
 Example:
-gpio1: gpio at 13800 {
-	compatible = "marvell,armada-3700-gpio", "syscon", "simple-mfd";
-	reg = <0x13800 0x1000>;
+pinctrl_nb: pinctrl-nb at 13800 {
+	compatible = "armada3710-nb-pinctrl", "syscon", "simple-mfd";
+	reg = <0x13800 0x100>, <0x13C00 0x20>;
 
 	xtalclk: xtal-clk {
 		compatible = "marvell,armada-3700-xtal-clock";
diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,armada-37xx-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/marvell,armada-37xx-pinctrl.txt
new file mode 100644
index 000000000000..9eabb42fbd53
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/marvell,armada-37xx-pinctrl.txt
@@ -0,0 +1,143 @@
+* Marvell Armada 37xx SoC pin and gpio controller
+
+Each Armada 37xx SoC come with two pin and gpio controller one for the
+south bridge and the other for the north bridge.
+
+Inside this set of register the gpio latch allows exposing some
+configuration of the SoC and especially the clock frequency of the
+xtal. Hence, this node is a represent as syscon allowing sharing the
+register between multiple hardware block.
+
+GPIO and pin controller:
+------------------------
+
+Refer to pinctrl-bindings.txt in this directory for details of the
+common pinctrl bindings used by client devices, including the meaning
+of the phrase "pin configuration node".
+
+Required properties for pinctrl driver:
+
+- compatible:	"marvell,armada3710-sb-pinctrl", "syscon, "simple-mfd"
+		for the south bridge
+		"marvell,armada3710-nb-pinctrl", "syscon, "simple-mfd"
+		for the north bridge
+- reg: The first set of register are for pinctrl/gpio and the second
+  set for the interrupt controller
+- interrupts: list of the interrupt use by the gpio
+
+Available groups and functions for the North bridge:
+
+group: jtag
+ - pins 20-24
+ - functions jtag, gpio
+
+group sdio0
+ - pins 8-10
+ - functions sdio, gpio
+
+group emmc_nb
+ - pins 27-35
+ - functions emmc, gpio
+
+group pwm0
+ - pin 11 (GPIO1-11)
+ - functions pwm, gpio
+
+group pwm1
+ - pin 12
+ - functions pwm, gpio
+
+group pwm2
+ - pin 13
+ - functions pwm, gpio
+
+group pwm3
+ - pin 14
+ - functions pwm, gpio
+
+group pmic1
+ - pin 17
+ - functions pmic, gpio
+
+group pmic0
+ - pin 16
+ - functions pmic, gpio
+
+group i2c2
+ - pins 2-3
+ - functions i2c, gpio
+
+group i2c1
+ - pins 0-1
+ - functions i2c, gpio
+
+group spi_cs1
+ - pin 17
+ - functions spi, gpio
+
+group spi_cs2
+ - pin 18
+ - functions spi, gpio
+
+group spi_cs3
+ - pin 19
+ - functions spi, gpio
+
+group onewire
+ - pin 4
+ - functions onewire, gpio
+
+group uart1
+ - pins 25-26
+ - functions uart, gpio
+
+group spi_quad
+ - pins 15-16
+ - functions spi, gpio
+
+group uart_2
+ - pins 9-10
+ - functions uart, gpio
+
+Available groups and functions for the South bridge:
+
+group usb32_drvvbus0
+ - pin 36
+ - functions drvbus, gpio
+
+group usb2_drvvbus1
+ - pin 37
+ - functions drvbus, gpio
+
+group sdio_sb
+ - pins 60-64
+ - functions sdio, gpio
+
+group rgmii
+ - pins 42-55
+ - functions mii, gpio
+
+group pcie1
+ - pins 39-40
+ - functions pcie, gpio
+
+group ptp
+ - pins 56-58
+ - functions ptp, gpio
+
+group ptp_clk
+ - pin 57
+ - functions ptp, mii
+
+group ptp_trig
+ - pin 58
+ - functions ptp, mii
+
+group mii_col
+ - pin 59
+ - functions mii, mii_err
+
+Xtal Clock bindings for Marvell Armada 37xx SoCs
+------------------------------------------------
+
+see Documentation/devicetree/bindings/clock/armada3700-xtal-clock.txt
-- 
git-series 0.9.1
