From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon,  1 Feb 2016 09:57:56 +0100
Subject: [PATCH 4/5] ARM: pb1176: add ethernet to devicetree
Message-ID: <1454317076-4836-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PB1176 device tree was missing the SMSC9118 ethernet adapter,
so add it. Since this peripheral is not in either development
chip but on the board itself, it gets defined in the root node
of the device tree.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/arm-realview-pb1176.dts | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/arm-realview-pb1176.dts b/arch/arm/boot/dts/arm-realview-pb1176.dts
index 70a1ec3bedb9..95ea12b32aa5 100644
--- a/arch/arm/boot/dts/arm-realview-pb1176.dts
+++ b/arch/arm/boot/dts/arm-realview-pb1176.dts
@@ -53,6 +53,14 @@
 		regulator-boot-on;
         };
 
+	veth: fixedregulator at 0 {
+		compatible = "regulator-fixed";
+		regulator-name = "veth";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+	};
+
 	xtal24mhz: xtal24mhz at 24M {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
@@ -106,6 +114,20 @@
 		clock-frequency = <0>;
 	};
 
+	/* SMSC 9118 ethernet with PHY and EEPROM */
+	ethernet at 3a000000 {
+		compatible = "smsc,lan9118", "smsc,lan9115";
+		reg = <0x3a000000 0x10000>;
+		interrupt-parent = <&intc_fpga1176>;
+		interrupts = <0 10 IRQ_TYPE_LEVEL_HIGH>;
+		phy-mode = "mii";
+		reg-io-width = <4>;
+		smsc,irq-active-high;
+		smsc,irq-push-pull;
+		vdd33a-supply = <&veth>;
+		vddvario-supply = <&veth>;
+	};
+
 	usb at 3b000000 {
 		compatible = "nxp,usb-isp1761";
 		reg = <0x3b000000 0x20000>;
-- 
2.4.3
