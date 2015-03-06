From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Fri,  6 Mar 2015 16:05:28 +0100
Subject: [PATCH v2 10/10] ARM: berlin: rework chip and system controller nodes
 for BG2Q
In-Reply-To: <1425654328-26298-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1425654328-26298-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1425654328-26298-11-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The chip and system controller nodes are now handled by the Berlin
controller mfd driver. Its sub-devices are then registered by the mfd
driver and let the drivers be probed properly, using their own
sub-nodes.

Rework the device tree to take this changes into account.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 arch/arm/boot/dts/berlin2q.dtsi | 70 ++++++++++++++++++++++++-----------------
 1 file changed, 41 insertions(+), 29 deletions(-)

diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
index be5397288d24..006d382d44ff 100644
--- a/arch/arm/boot/dts/berlin2q.dtsi
+++ b/arch/arm/boot/dts/berlin2q.dtsi
@@ -127,7 +127,7 @@
 			compatible = "marvell,berlin2-usb-phy";
 			reg = <0xa2f400 0x128>;
 			#phy-cells = <0>;
-			resets = <&chip 0x104 14>;
+			resets = <&chip_rst 0x104 14>;
 			status = "disabled";
 		};
 
@@ -145,7 +145,7 @@
 			compatible = "marvell,berlin2-usb-phy";
 			reg = <0xb74000 0x128>;
 			#phy-cells = <0>;
-			resets = <&chip 0x104 12>;
+			resets = <&chip_rst 0x104 12>;
 			status = "disabled";
 		};
 
@@ -359,22 +359,30 @@
 			};
 		};
 
-		chip: chip-control at ea0000 {
-			compatible = "marvell,berlin2q-chip-ctrl";
-			#clock-cells = <1>;
-			#reset-cells = <2>;
+		chip: chip-controller at ea0000 {
+			compatible = "marvell,berlin2q-chip-ctrl", "simple-mfd", "syscon";
 			reg = <0xea0000 0x400>, <0xdd0170 0x10>;
+			#clock-cells = <1>;
 			clocks = <&refclk>;
 			clock-names = "refclk";
 
-			twsi0_pmux: twsi0-pmux {
-				groups = "G6";
-				function = "twsi0";
+			soc_pinctrl: pin-controller {
+				compatible = "marvell,berlin2q-soc-pinctrl";
+
+				twsi0_pmux: twsi0-pmux {
+					groups = "G6";
+					function = "twsi0";
+				};
+
+				twsi1_pmux: twsi1-pmux {
+					groups = "G7";
+					function = "twsi1";
+				};
 			};
 
-			twsi1_pmux: twsi1-pmux {
-				groups = "G7";
-				function = "twsi1";
+			chip_rst: reset {
+				compatible = "marvell,berlin2-reset";
+				#reset-cells = <2>;
 			};
 		};
 
@@ -525,28 +533,32 @@
 				};
 			};
 
-			sysctrl: pin-controller at d000 {
-				compatible = "marvell,berlin2q-system-ctrl";
+			sysctrl: system-controller at d000 {
+				compatible = "marvell,berlin2q-system-ctrl", "simple-mfd", "syscon";
 				reg = <0xd000 0x100>;
 
-				uart0_pmux: uart0-pmux {
-					groups = "GSM12";
-					function = "uart0";
-				};
+				sys_pinctrl: pin-controller {
+					compatible = "marvell,berlin2q-system-pinctrl";
 
-				uart1_pmux: uart1-pmux {
-					groups = "GSM14";
-					function = "uart1";
-				};
+					uart0_pmux: uart0-pmux {
+						groups = "GSM12";
+						function = "uart0";
+					};
 
-				twsi2_pmux: twsi2-pmux {
-					groups = "GSM13";
-					function = "twsi2";
-				};
+					uart1_pmux: uart1-pmux {
+						groups = "GSM14";
+						function = "uart1";
+					};
+
+					twsi2_pmux: twsi2-pmux {
+						groups = "GSM13";
+						function = "twsi2";
+					};
 
-				twsi3_pmux: twsi3-pmux {
-					groups = "GSM14";
-					function = "twsi3";
+					twsi3_pmux: twsi3-pmux {
+						groups = "GSM14";
+						function = "twsi3";
+					};
 				};
 			};
 
-- 
2.3.1
