From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu,  8 Sep 2016 23:46:46 +0200
Subject: [PATCH 1/4] ARM: dts: fix RealView EB SMSC ethernet version
Message-ID: <1473371209-24086-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ethernet version in the earlier RealView EB variants is
LAN91C111 and not LAN9118 according to ARM DUI 0303E
"RealView Emulation Baseboard User Guide" page 3-57.

Make sure that this is used for the base variant of the board.

As the DT bindings for LAN91C111 does not specify any power
supplies, these need to be deleted from the DTS file.

Fixes: 2440d29d2ae2 ("ARM: dts: realview: support all the RealView EB board variants")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Make sure we support 8, 16 and 32bit accesses on the LAN91C111
---
 arch/arm/boot/dts/arm-realview-eb.dtsi | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/arm-realview-eb.dtsi b/arch/arm/boot/dts/arm-realview-eb.dtsi
index 1c6a040218e3..e2e9599596e2 100644
--- a/arch/arm/boot/dts/arm-realview-eb.dtsi
+++ b/arch/arm/boot/dts/arm-realview-eb.dtsi
@@ -51,14 +51,6 @@
 		regulator-boot-on;
         };
 
-	veth: fixedregulator at 0 {
-		compatible = "regulator-fixed";
-		regulator-name = "veth";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-boot-on;
-	};
-
 	xtal24mhz: xtal24mhz at 24M {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
@@ -134,16 +126,15 @@
 		bank-width = <4>;
 	};
 
-	/* SMSC 9118 ethernet with PHY and EEPROM */
+	/* SMSC LAN91C111 ethernet with PHY and EEPROM */
 	ethernet: ethernet at 4e000000 {
-		compatible = "smsc,lan9118", "smsc,lan9115";
+		compatible = "smsc,lan91c111";
 		reg = <0x4e000000 0x10000>;
-		phy-mode = "mii";
-		reg-io-width = <4>;
-		smsc,irq-active-high;
-		smsc,irq-push-pull;
-		vdd33a-supply = <&veth>;
-		vddvario-supply = <&veth>;
+		/*
+		 * This means the adapter can be accessed with 8, 16 or
+		 * 32 bit reads/writes.
+		 */
+		reg-io-width = <7>;
 	};
 
 	usb: usb at 4f000000 {
-- 
2.7.4
