From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  5 Mar 2015 10:57:58 +0900
Subject: [PATCH 06/13] ARM: shmobile: ape6evm dts: Move Ethernet node to BSC
In-Reply-To: <cover.1425517246.git.horms+renesas@verge.net.au>
References: <cover.1425517246.git.horms+renesas@verge.net.au>
Message-ID: <a656c603889c256e3d05e79e57714aa88d179903.1425517246.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Move the Ethernet node from the ad-hoc lbsc node to the BSC node,
as its connected to the Bus State Controller.  This allows the system to
know the right position of the Ethernet node in the clock and PM domain
hierarchy, and manage the clock and PM domain appropriately.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Acked-by: Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a73a4-ape6evm.dts | 35 +++++++++++++++--------------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm.dts b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
index 0d50bef..44c4cac 100644
--- a/arch/arm/boot/dts/r8a73a4-ape6evm.dts
+++ b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
@@ -72,26 +72,6 @@
 		regulator-always-on;
 	};
 
-	lbsc {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0 0 0 0x20000000>;
-
-		ethernet at 8000000 {
-			compatible = "smsc,lan9220", "smsc,lan9115";
-			reg = <0x08000000 0x1000>;
-			interrupt-parent = <&irqc1>;
-			interrupts = <8 IRQ_TYPE_LEVEL_HIGH>;
-			phy-mode = "mii";
-			reg-io-width = <4>;
-			smsc,irq-active-high;
-			smsc,irq-push-pull;
-			vdd33a-supply = <&ape6evm_fixed_3v3>;
-			vddvario-supply = <&ape6evm_fixed_1v8>;
-		};
-	};
-
 	leds {
 		compatible = "gpio-leds";
 		led1 {
@@ -184,6 +164,21 @@
 	voltage-tolerance = <1>; /* 1% */
 };
 
+&bsc {
+	ethernet at 8000000 {
+		compatible = "smsc,lan9220", "smsc,lan9115";
+		reg = <0x08000000 0x1000>;
+		interrupt-parent = <&irqc1>;
+		interrupts = <8 IRQ_TYPE_LEVEL_HIGH>;
+		phy-mode = "mii";
+		reg-io-width = <4>;
+		smsc,irq-active-high;
+		smsc,irq-push-pull;
+		vdd33a-supply = <&ape6evm_fixed_3v3>;
+		vddvario-supply = <&ape6evm_fixed_1v8>;
+	};
+};
+
 &cmt1 {
 	status = "okay";
 };
-- 
2.1.4
