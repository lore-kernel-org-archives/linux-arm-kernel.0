From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri,  9 Jan 2015 14:13:54 +0100
Subject: [PATCH 2/4] ARM: shmobile: kzm9g dts: Move Ethernet node to BSC
In-Reply-To: <1420809236-4105-1-git-send-email-geert+renesas@glider.be>
References: <1420809236-4105-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1420809236-4105-2-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the Ethernet node from the root of the device tree to the BSC node,
as it's connected to the Bus State Controller.  This allows the system
to know the right position of the Ethernet node in the clock and PM
domain hierarchy, and manage the clock and PM domain appropriately.

Also rename the node's name from "lan9220" to "ethernet", to conform to
ePAPR generic name recomendations.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - No changes,

v2:
  - s/confirm/conform/,
  - Moved from kzm9g-reference to kzm9g.
---
 arch/arm/boot/dts/sh73a0-kzm9g.dts | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g.dts b/arch/arm/boot/dts/sh73a0-kzm9g.dts
index 6f00e6b680e8e0fa..022ba505f57339a9 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g.dts
@@ -84,19 +84,6 @@
 		enable-active-high;
 	};
 
-	lan9220 at 10000000 {
-		compatible = "smsc,lan9220", "smsc,lan9115";
-		reg = <0x10000000 0x100>;
-		phy-mode = "mii";
-		interrupt-parent = <&irqpin0>;
-		interrupts = <3 IRQ_TYPE_EDGE_FALLING>;
-		reg-io-width = <4>;
-		smsc,irq-push-pull;
-		smsc,save-mac-address;
-		vddvario-supply = <&reg_1p8v>;
-		vdd33a-supply = <&reg_3p3v>;
-	};
-
 	leds {
 		compatible = "gpio-leds";
 		led1 {
@@ -178,6 +165,21 @@
 	};
 };
 
+&bsc {
+	ethernet at 10000000 {
+		compatible = "smsc,lan9220", "smsc,lan9115";
+		reg = <0x10000000 0x100>;
+		phy-mode = "mii";
+		interrupt-parent = <&irqpin0>;
+		interrupts = <3 IRQ_TYPE_EDGE_FALLING>;
+		reg-io-width = <4>;
+		smsc,irq-push-pull;
+		smsc,save-mac-address;
+		vddvario-supply = <&reg_1p8v>;
+		vdd33a-supply = <&reg_3p3v>;
+	};
+};
+
 &cmt1 {
 	status = "okay";
 };
-- 
1.9.1
