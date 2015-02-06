From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri,  6 Feb 2015 21:22:53 +0100
Subject: [PATCH] ARM: shmobile: r8a73a4: Move pfc node to work around probe
 ordering bug
Message-ID: <1423254173-31852-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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
---
Notes:
  - It seems several people tried to solve this in the core OF probing
    code before, but the final solution never went in?
  - This can be reproduced on other SoCs (e.g. sh73a0 and r8a7740) by
    moving their pfc nodes before their interrupt controller nodes.
  - This patch is against my working tree, so it doesn't apply to
    Simon's repository, but you get the idea....
---
 arch/arm/boot/dts/r8a73a4.dtsi | 48 +++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
index 8a23442f0c70359d..47b657de4f68f56c 100644
--- a/arch/arm/boot/dts/r8a73a4.dtsi
+++ b/arch/arm/boot/dts/r8a73a4.dtsi
@@ -259,30 +259,6 @@
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
-		power-domains = <&pd_c5>;
-	};
-
 	i2c5: i2c at e60b0000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -382,6 +358,30 @@
 		power-domains = <&pd_c4>;
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
+		power-domains = <&pd_c5>;
+	};
+
 	thermal at e61f0000 {
 		compatible = "renesas,thermal-r8a73a4", "renesas,rcar-thermal";
 		reg = <0 0xe61f0000 0 0x14>, <0 0xe61f0100 0 0x38>,
-- 
1.9.1
