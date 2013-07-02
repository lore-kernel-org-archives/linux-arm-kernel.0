From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue,  2 Jul 2013 13:03:38 +0200
Subject: [PATCH v4 2/7] ARM: kirkwood: move device tree nodes to DT irqchip
 and clocksource
In-Reply-To: <1372763023-12374-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1372763023-12374-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1372763023-12374-3-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With recent support for true irqchip and clocksource drivers for Orion
SoCs, now make use of it on DT enabled Kirkwood boards.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
--- 
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/boot/dts/kirkwood.dtsi |   35 +++++++++++++++++++++++++++--------
 1 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index ad56dd8..204f44f 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -20,13 +20,6 @@
 	       gpio0 = &gpio0;
 	       gpio1 = &gpio1;
 	};
-	intc: interrupt-controller {
-		compatible = "marvell,orion-intc", "marvell,intc";
-		interrupt-controller;
-		#interrupt-cells = <1>;
-		reg = <0xf1020204 0x04>,
-		      <0xf1020214 0x04>;
-	};
 
 	ocp at f1000000 {
 		compatible = "simple-bus";
@@ -37,6 +30,30 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 
+		timer: timer at 20300 {
+			compatible = "marvell,orion-timer";
+			reg = <0x20300 0x20>;
+			interrupt-parent = <&bridge_intc>;
+			interrupts = <1>, <2>;
+			clocks = <&core_clk 0>;
+		};
+
+		intc: main-interrupt-ctrl at 20200 {
+			compatible = "marvell,orion-intc";
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			reg = <0x20200 0x10>, <0x20210 0x10>;
+		};
+
+		bridge_intc: bridge-interrupt-ctrl at 20110 {
+			compatible = "marvell,orion-bridge-intc";
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			reg = <0x20110 0x8>;
+			interrupts = <1>;
+			marvell,#interrupts = <6>;
+		};
+
 		core_clk: core-clocks at 10030 {
 			compatible = "marvell,kirkwood-core-clock";
 			reg = <0x10030 0x4>;
@@ -103,9 +120,11 @@
 			#clock-cells = <1>;
 		};
 
-		wdt at 20300 {
+		wdt: watchdog-timer at 20300 {
 			compatible = "marvell,orion-wdt";
 			reg = <0x20300 0x28>;
+			interrupt-parent = <&bridge_intc>;
+			interrupts = <3>;
 			clocks = <&gate_clk 7>;
 			status = "okay";
 		};
-- 
1.7.2.5
