From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  5 Mar 2015 10:57:59 +0900
Subject: [PATCH 07/13] ARM: shmobile: r8a73a4: Move pfc node to work around
 probe ordering bug
In-Reply-To: <cover.1425517246.git.horms+renesas@verge.net.au>
References: <cover.1425517246.git.horms+renesas@verge.net.au>
Message-ID: <e4ba0a9bddff3ba52cec100414d2f178440efc91.1425517246.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Currently the pin function controller (which is also a GPIO controller)
is instantiated before the interrupt controllers due to the order in the
DTS. At that time, the irq domains for the interrupt controllers
referenced by its interrupts-extended property cannot be found yet:

    irq: no irq domain found for /interrupt-controller at e61c0000 !

Nevertheless, the core OF probing code ignores this failure, besides a
debug message that's not normally printed:

    not all legacy IRQ resources mapped for pfc

and continues initialization of the device. Then, the sh-pfc driver
cannot find any IRQ resources, and thinks no interrupts are available,
causing gpio-keys to fail later:

    gpio-keys keyboard: Unable to claim irq 0; error -22
    gpio-keys: probe of keyboard failed with error -22

Move the pin function controller node after the interrupt controller
nodes it references to work around the bug in the core OF probing code.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a73a4.dtsi | 46 +++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
index 77bd35c..d41201d 100644
--- a/arch/arm/boot/dts/r8a73a4.dtsi
+++ b/arch/arm/boot/dts/r8a73a4.dtsi
@@ -92,29 +92,6 @@
 		};
 	};
 
-	pfc: pfc at e6050000 {
-		compatible = "renesas,pfc-r8a73a4";
-		reg = <0 0xe6050000 0 0x9000>;
-		gpio-controller;
-		#gpio-cells = <2>;
-		interrupts-extended =
-			<&irqc0  0 0>, <&irqc0  1 0>, <&irqc0  2 0>, <&irqc0  3 0>,
-			<&irqc0  4 0>, <&irqc0  5 0>, <&irqc0  6 0>, <&irqc0  7 0>,
-			<&irqc0  8 0>, <&irqc0  9 0>, <&irqc0 10 0>, <&irqc0 11 0>,
-			<&irqc0 12 0>, <&irqc0 13 0>, <&irqc0 14 0>, <&irqc0 15 0>,
-			<&irqc0 16 0>, <&irqc0 17 0>, <&irqc0 18 0>, <&irqc0 19 0>,
-			<&irqc0 20 0>, <&irqc0 21 0>, <&irqc0 22 0>, <&irqc0 23 0>,
-			<&irqc0 24 0>, <&irqc0 25 0>, <&irqc0 26 0>, <&irqc0 27 0>,
-			<&irqc0 28 0>, <&irqc0 29 0>, <&irqc0 30 0>, <&irqc0 31 0>,
-			<&irqc1  0 0>, <&irqc1  1 0>, <&irqc1  2 0>, <&irqc1  3 0>,
-			<&irqc1  4 0>, <&irqc1  5 0>, <&irqc1  6 0>, <&irqc1  7 0>,
-			<&irqc1  8 0>, <&irqc1  9 0>, <&irqc1 10 0>, <&irqc1 11 0>,
-			<&irqc1 12 0>, <&irqc1 13 0>, <&irqc1 14 0>, <&irqc1 15 0>,
-			<&irqc1 16 0>, <&irqc1 17 0>, <&irqc1 18 0>, <&irqc1 19 0>,
-			<&irqc1 20 0>, <&irqc1 21 0>, <&irqc1 22 0>, <&irqc1 23 0>,
-			<&irqc1 24 0>, <&irqc1 25 0>;
-	};
-
 	i2c5: i2c at e60b0000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -210,6 +187,29 @@
 			     <0 57 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
+	pfc: pfc at e6050000 {
+		compatible = "renesas,pfc-r8a73a4";
+		reg = <0 0xe6050000 0 0x9000>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupts-extended =
+			<&irqc0  0 0>, <&irqc0  1 0>, <&irqc0  2 0>, <&irqc0  3 0>,
+			<&irqc0  4 0>, <&irqc0  5 0>, <&irqc0  6 0>, <&irqc0  7 0>,
+			<&irqc0  8 0>, <&irqc0  9 0>, <&irqc0 10 0>, <&irqc0 11 0>,
+			<&irqc0 12 0>, <&irqc0 13 0>, <&irqc0 14 0>, <&irqc0 15 0>,
+			<&irqc0 16 0>, <&irqc0 17 0>, <&irqc0 18 0>, <&irqc0 19 0>,
+			<&irqc0 20 0>, <&irqc0 21 0>, <&irqc0 22 0>, <&irqc0 23 0>,
+			<&irqc0 24 0>, <&irqc0 25 0>, <&irqc0 26 0>, <&irqc0 27 0>,
+			<&irqc0 28 0>, <&irqc0 29 0>, <&irqc0 30 0>, <&irqc0 31 0>,
+			<&irqc1  0 0>, <&irqc1  1 0>, <&irqc1  2 0>, <&irqc1  3 0>,
+			<&irqc1  4 0>, <&irqc1  5 0>, <&irqc1  6 0>, <&irqc1  7 0>,
+			<&irqc1  8 0>, <&irqc1  9 0>, <&irqc1 10 0>, <&irqc1 11 0>,
+			<&irqc1 12 0>, <&irqc1 13 0>, <&irqc1 14 0>, <&irqc1 15 0>,
+			<&irqc1 16 0>, <&irqc1 17 0>, <&irqc1 18 0>, <&irqc1 19 0>,
+			<&irqc1 20 0>, <&irqc1 21 0>, <&irqc1 22 0>, <&irqc1 23 0>,
+			<&irqc1 24 0>, <&irqc1 25 0>;
+	};
+
 	thermal at e61f0000 {
 		compatible = "renesas,thermal-r8a73a4", "renesas,rcar-thermal";
 		reg = <0 0xe61f0000 0 0x14>, <0 0xe61f0100 0 0x38>,
-- 
2.1.4
