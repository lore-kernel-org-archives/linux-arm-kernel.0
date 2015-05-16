From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sat, 16 May 2015 02:23:36 +0200
Subject: [PATCH 07/14] ARM: berlin: move pinctrl to simple-mfd nodes
In-Reply-To: <1431735823-28006-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1431735823-28006-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1431735823-28006-8-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Antoine Tenart <antoine.tenart@free-electrons.com>

Now with proper support for simple-mfd probed pinctrl driver, move
to the new soc-pinctrl and system-pinctrl nodes.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/berlin2.dtsi   | 38 ++++++++++++++++------------
 arch/arm/boot/dts/berlin2cd.dtsi | 14 ++++++++---
 arch/arm/boot/dts/berlin2q.dtsi  | 53 +++++++++++++++++++++++-----------------
 3 files changed, 63 insertions(+), 42 deletions(-)

diff --git a/arch/arm/boot/dts/berlin2.dtsi b/arch/arm/boot/dts/berlin2.dtsi
index 1e92511f8582..94d9182e4dfe 100644
--- a/arch/arm/boot/dts/berlin2.dtsi
+++ b/arch/arm/boot/dts/berlin2.dtsi
@@ -357,9 +357,13 @@
 			clocks = <&refclk>;
 			clock-names = "refclk";
 
-			emmc_pmux: emmc-pmux {
-				groups = "G26";
-				function = "emmc";
+			soc_pinctrl: pin-controller {
+				compatible = "marvell,berlin2-soc-pinctrl";
+
+				emmc_pmux: emmc-pmux {
+					groups = "G26";
+					function = "emmc";
+				};
 			};
 
 			chip_rst: reset {
@@ -449,19 +453,21 @@
 				compatible = "marvell,berlin2-system-ctrl", "simple-mfd", "syscon";
 				reg = <0xd000 0x100>;
 
-				uart0_pmux: uart0-pmux {
-					groups = "GSM4";
-					function = "uart0";
-				};
-
-				uart1_pmux: uart1-pmux {
-					groups = "GSM5";
-					function = "uart1";
-				};
-
-				uart2_pmux: uart2-pmux {
-					groups = "GSM3";
-					function = "uart2";
+				sys_pinctrl: pin-controller {
+					compatible = "marvell,berlin2-system-pinctrl";
+					uart0_pmux: uart0-pmux {
+						groups = "GSM4";
+						function = "uart0";
+					};
+
+					uart1_pmux: uart1-pmux {
+						groups = "GSM5";
+						function = "uart1";
+					};
+					uart2_pmux: uart2-pmux {
+						groups = "GSM3";
+						function = "uart2";
+					};
 				};
 			};
 
diff --git a/arch/arm/boot/dts/berlin2cd.dtsi b/arch/arm/boot/dts/berlin2cd.dtsi
index 5f8bfcdedceb..7544fea43e3a 100644
--- a/arch/arm/boot/dts/berlin2cd.dtsi
+++ b/arch/arm/boot/dts/berlin2cd.dtsi
@@ -301,9 +301,13 @@
 			clocks = <&refclk>;
 			clock-names = "refclk";
 
-			uart0_pmux: uart0-pmux {
-				groups = "G6";
-				function = "uart0";
+			soc_pinctrl: pin-controller {
+				compatible = "marvell,berlin2cd-soc-pinctrl";
+
+				uart0_pmux: uart0-pmux {
+					groups = "G6";
+					function = "uart0";
+				};
 			};
 
 			chip_rst: reset {
@@ -395,6 +399,10 @@
 			sysctrl: system-controller at d000 {
 				compatible = "marvell,berlin2cd-system-ctrl", "simple-mfd", "syscon";
 				reg = <0xd000 0x100>;
+
+				sys_pinctrl: pin-controller {
+					compatible = "marvell,berlin2cd-system-pinctrl";
+				};
 			};
 
 			sic: interrupt-controller at e000 {
diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
index a27d03a2b5fa..8715d11c8f76 100644
--- a/arch/arm/boot/dts/berlin2q.dtsi
+++ b/arch/arm/boot/dts/berlin2q.dtsi
@@ -366,16 +366,19 @@
 			clocks = <&refclk>;
 			clock-names = "refclk";
 
-			twsi0_pmux: twsi0-pmux {
-				groups = "G6";
-				function = "twsi0";
-			};
+			soc_pinctrl: pin-controller {
+				compatible = "marvell,berlin2q-soc-pinctrl";
 
-			twsi1_pmux: twsi1-pmux {
-				groups = "G7";
-				function = "twsi1";
-			};
+				twsi0_pmux: twsi0-pmux {
+					groups = "G6";
+					function = "twsi0";
+				};
 
+				twsi1_pmux: twsi1-pmux {
+					groups = "G7";
+					function = "twsi1";
+				};
+			};
 			chip_rst: reset {
 				compatible = "marvell,berlin2-reset";
 				#reset-cells = <2>;
@@ -533,24 +536,28 @@
 				compatible = "marvell,berlin2q-system-ctrl", "simple-mfd", "syscon";
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
2.1.0
