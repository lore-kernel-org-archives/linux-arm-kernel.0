From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 20 Jun 2017 10:37:53 +0200
Subject: [PATCH 6/6] gpio: dt-bindings: Add documentation for gpio controllers
 on Armada 7K/8K
In-Reply-To: <20170620083754.28053-1-gregory.clement@free-electrons.com>
References: <20170620083754.28053-1-gregory.clement@free-electrons.com>
Message-ID: <20170620083754.28053-7-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the device tree binding for the gpio controllers found on the
Marvell Armada 7K and Armada 8K SoCs.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 .../arm/marvell/ap806-system-controller.txt        | 20 ++++++++++++++++++
 .../arm/marvell/cp110-system-controller0.txt       | 24 +++++++++++++++++++++-
 .../devicetree/bindings/gpio/gpio-mvebu.txt        | 24 +++++++++++++++-------
 3 files changed, 60 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt b/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
index 4228d158fb31..0b887440e08a 100644
--- a/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
+++ b/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
@@ -64,6 +64,17 @@ mpp17	17	gpio
 mpp18	18	gpio
 mpp19	19	gpio, uart0(rxd), sdio(pw_off)
 
+GPIO:
+-----
+For common binding part and usage, refer to
+Documentation/devicetree/bindings/gpio/gpio-mvebu.txt.
+
+Required properties:
+
+- compatible: "marvell,armada-8k-gpio"
+
+- offset: offset address inside the syscon block
+
 Example:
 ap_syscon: system-controller at 6f4000 {
 	compatible = "syscon", "simple-mfd";
@@ -77,4 +88,13 @@ ap_syscon: system-controller at 6f4000 {
 	ap_pinctrl: pinctrl {
 		compatible = "marvell,ap806-pinctrl";
 	};
+
+	ap_gpio: gpio {
+		compatible = "marvell,armada-8k-gpio";
+		offset = <0x1040>;
+		ngpios = <19>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-ranges = <&ap_pinctrl 0 0 19>;
+	};
 };
diff --git a/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller0.txt b/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller0.txt
index 06e2b977f18f..171d02cadea4 100644
--- a/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller0.txt
+++ b/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller0.txt
@@ -149,6 +149,18 @@ mpp60	60	gpio, mss_gpio6, ptp(pulse), tdm(dtx), au(i2smclk), spi0(csn1), uart0(r
 mpp61	61	gpio, mss_gpio5, ptp(clk), tdm(pclk), au(i2sextclk), spi0(csn2), uart0(txd), uart2(txd), sata1(present_act), ge(mdio), sdio(d3)
 mpp62	62	gpio, mss_gpio4, synce1(clk), ptp(pclk_out), sata1(present_act), spi0(csn3), uart0(rxd), uart2(rxd), sata0(present_act), ge(mdc)
 
+GPIO:
+-----
+
+For common binding part and usage, refer to
+Documentation/devicetree/bindings/gpio/gpio-mvebu.txt.
+
+Required properties:
+
+- compatible: "marvell,armada-8k-gpio"
+
+- offset: offset address inside the syscon block
+
 Example:
 
 cpm_syscon0: system-controller at 440000 {
@@ -163,5 +175,15 @@ cpm_syscon0: system-controller at 440000 {
 	cpm_pinctrl: pinctrl {
 		compatible = "marvell,armada-8k-cpm-pinctrl";
 	};
-};
 
+	cpm_gpio1: gpio at 100 {
+		compatible = "marvell,armada-8k-gpio";
+		offset = <0x100>;
+		ngpios = <32>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-ranges = <&cpm_pinctrl 0 0 32>;
+		status = "disabled";
+	};
+
+};
diff --git a/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt b/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt
index 42c3bb2d53e8..2c5304ff467c 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio-mvebu.txt
@@ -2,17 +2,27 @@
 
 Required properties:
 
-- compatible : Should be "marvell,orion-gpio", "marvell,mv78200-gpio"
-  or "marvell,armadaxp-gpio". "marvell,orion-gpio" should be used for
-  Orion, Kirkwood, Dove, Discovery (except MV78200) and Armada
-  370. "marvell,mv78200-gpio" should be used for the Discovery
-  MV78200. "marvel,armadaxp-gpio" should be used for all Armada XP
-  SoCs (MV78230, MV78260, MV78460).
+- compatible : Should be "marvell,orion-gpio", "marvell,mv78200-gpio",
+  "marvell,armadaxp-gpio" or "marvell,armada-8k-gpio".
+
+    "marvell,orion-gpio" should be used for Orion, Kirkwood, Dove,
+    Discovery (except MV78200) and Armada 370. "marvell,mv78200-gpio"
+    should be used for the Discovery MV78200.
+
+    "marvel,armadaxp-gpio" should be used for all Armada XP SoCs
+    (MV78230, MV78260, MV78460).
+
+    "marvell,armada-8k-gpio" should be used for the Armada 7K and 8K
+    SoCs (either from AP or CP), see
+    Documentation/devicetree/bindings/arm/marvell/cp110-system-controller0.txt
+    and
+    Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
+    for specific details about the offset property.
 
 - reg: Address and length of the register set for the device. Only one
   entry is expected, except for the "marvell,armadaxp-gpio" variant
   for which two entries are expected: one for the general registers,
-  one for the per-cpu registers.
+  one for the per-cpu registers. Not used for marvell,armada-8k-gpio.
 
 - interrupts: The list of interrupts that are used for all the pins
   managed by this GPIO bank. There can be more than one interrupt
-- 
2.11.0
