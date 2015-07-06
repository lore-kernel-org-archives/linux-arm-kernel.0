From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon,  6 Jul 2015 12:47:29 +0900
Subject: [PATCH 2/3] ARM: dts: UniPhier: add on-chip UART device nodes
In-Reply-To: <1436154450-21102-1-git-send-email-yamada.masahiro@socionext.com>
References: <1436154450-21102-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1436154450-21102-3-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The UniPhier on-chip UART driver was merged into the mainline by
commit 1a8d2903cb6a (serial: 8250_uniphier: add UniPhier serial
driver).

Add device nodes to make it really available.

We no longer have to depend on the on-board UART device (16550A),
so let's change the chosen and aliases to point to the on-chip ones.
Also, turn on the on-board Ethernet device.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/dts/uniphier-ph1-ld4-ref.dts  | 21 ++++++++++++---
 arch/arm/boot/dts/uniphier-ph1-ld4.dtsi     | 42 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/uniphier-ph1-pro4-ref.dts | 21 ++++++++++++---
 arch/arm/boot/dts/uniphier-ph1-pro4.dtsi    | 42 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/uniphier-ph1-sld3-ref.dts | 20 +++++++++++---
 arch/arm/boot/dts/uniphier-ph1-sld3.dtsi    | 33 +++++++++++++++++++++++
 arch/arm/boot/dts/uniphier-ph1-sld8-ref.dts | 21 ++++++++++++---
 arch/arm/boot/dts/uniphier-ph1-sld8.dtsi    | 42 +++++++++++++++++++++++++++++
 8 files changed, 230 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/uniphier-ph1-ld4-ref.dts b/arch/arm/boot/dts/uniphier-ph1-ld4-ref.dts
index 200b0c9..0cd385a9 100644
--- a/arch/arm/boot/dts/uniphier-ph1-ld4-ref.dts
+++ b/arch/arm/boot/dts/uniphier-ph1-ld4-ref.dts
@@ -57,11 +57,14 @@
 
 	chosen {
 		bootargs = "console=ttyS0,115200";
-		stdout-path = &serialsc;
+		stdout-path = &serial0;
 	};
 
 	aliases {
-		serial0 = &serialsc;
+		serial0 = &serial0;
+		serial1 = &serial1;
+		serial2 = &serial2;
+		serial3 = &serial3;
 	};
 };
 
@@ -74,6 +77,18 @@
 	ranges = <0x00000000 1 0x03f00000 0x00100000>;
 };
 
-&serialsc {
+&ethsc {
 	interrupts = <0 49 4>;
 };
+
+&serial0 {
+	status = "okay";
+};
+
+&serial2 {
+	status = "okay";
+};
+
+&serial3 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/uniphier-ph1-ld4.dtsi b/arch/arm/boot/dts/uniphier-ph1-ld4.dtsi
index 6a34c56..1261e6d 100644
--- a/arch/arm/boot/dts/uniphier-ph1-ld4.dtsi
+++ b/arch/arm/boot/dts/uniphier-ph1-ld4.dtsi
@@ -64,6 +64,12 @@
 			compatible = "fixed-clock";
 			clock-frequency = <50000000>;
 		};
+
+		uart_clk: uart_clk {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <36864000>;
+		};
 	};
 
 	soc {
@@ -79,6 +85,42 @@
 			#size-cells = <1>;
 		};
 
+		serial0: serial at 54006800 {
+			compatible = "socionext,uniphier-uart";
+			status = "disabled";
+			reg = <0x54006800 0x40>;
+			interrupts = <0 33 4>;
+			clocks = <&uart_clk>;
+			fifo-size = <64>;
+		};
+
+		serial1: serial at 54006900 {
+			compatible = "socionext,uniphier-uart";
+			status = "disabled";
+			reg = <0x54006900 0x40>;
+			interrupts = <0 35 4>;
+			clocks = <&uart_clk>;
+			fifo-size = <64>;
+		};
+
+		serial2: serial at 54006a00 {
+			compatible = "socionext,uniphier-uart";
+			status = "disabled";
+			reg = <0x54006a00 0x40>;
+			interrupts = <0 37 4>;
+			clocks = <&uart_clk>;
+			fifo-size = <64>;
+		};
+
+		serial3: serial at 54006b00 {
+			compatible = "socionext,uniphier-uart";
+			status = "disabled";
+			reg = <0x54006b00 0x40>;
+			interrupts = <0 29 4>;
+			clocks = <&uart_clk>;
+			fifo-size = <64>;
+		};
+
 		system-bus-controller-misc at 59800000 {
 			compatible = "socionext,uniphier-system-bus-controller-misc",
 				     "syscon";
diff --git a/arch/arm/boot/dts/uniphier-ph1-pro4-ref.dts b/arch/arm/boot/dts/uniphier-ph1-pro4-ref.dts
index d891135..0951cbf 100644
--- a/arch/arm/boot/dts/uniphier-ph1-pro4-ref.dts
+++ b/arch/arm/boot/dts/uniphier-ph1-pro4-ref.dts
@@ -57,11 +57,14 @@
 
 	chosen {
 		bootargs = "console=ttyS0,115200";
-		stdout-path = &serialsc;
+		stdout-path = &serial0;
 	};
 
 	aliases {
-		serial0 = &serialsc;
+		serial0 = &serial0;
+		serial1 = &serial1;
+		serial2 = &serial2;
+		serial3 = &serial3;
 	};
 };
 
@@ -74,6 +77,18 @@
 	ranges = <0x00000000 1 0x03f00000 0x00100000>;
 };
 
-&serialsc {
+&ethsc {
 	interrupts = <0 50 4>;
 };
+
+&serial0 {
+	status = "okay";
+};
+
+&serial1 {
+	status = "okay";
+};
+
+&serial2 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/uniphier-ph1-pro4.dtsi b/arch/arm/boot/dts/uniphier-ph1-pro4.dtsi
index dc63360..acd2c06 100644
--- a/arch/arm/boot/dts/uniphier-ph1-pro4.dtsi
+++ b/arch/arm/boot/dts/uniphier-ph1-pro4.dtsi
@@ -71,6 +71,12 @@
 			compatible = "fixed-clock";
 			clock-frequency = <50000000>;
 		};
+
+		uart_clk: uart_clk {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <73728000>;
+		};
 	};
 
 	soc {
@@ -86,6 +92,42 @@
 			#size-cells = <1>;
 		};
 
+		serial0: serial at 54006800 {
+			compatible = "socionext,uniphier-uart";
+			status = "disabled";
+			reg = <0x54006800 0x40>;
+			interrupts = <0 33 4>;
+			clocks = <&uart_clk>;
+			fifo-size = <64>;
+		};
+
+		serial1: serial at 54006900 {
+			compatible = "socionext,uniphier-uart";
+			status = "disabled";
+			reg = <0x54006900 0x40>;
+			interrupts = <0 35 4>;
+			clocks = <&uart_clk>;
+			fifo-size = <64>;
+		};
+
+		serial2: serial at 54006a00 {
+			compatible = "socionext,uniphier-uart";
+			status = "disabled";
+			reg = <0x54006a00 0x40>;
+			interrupts = <0 37 4>;
+			clocks = <&uart_clk>;
+			fifo-size = <64>;
+		};
+
+		serial3: serial at 54006b00 {
+			compatible = "socionext,uniphier-uart";
+			status = "disabled";
+			reg = <0x54006b00 0x40>;
+			interrupts = <0 29 4>;
+			clocks = <&uart_clk>;
+			fifo-size = <64>;
+		};
+
 		system-bus-controller-misc at 59800000 {
 			compatible = "socionext,uniphier-system-bus-controller-misc",
 				     "syscon";
diff --git a/arch/arm/boot/dts/uniphier-ph1-sld3-ref.dts b/arch/arm/boot/dts/uniphier-ph1-sld3-ref.dts
index 3ea64ae..47a44da 100644
--- a/arch/arm/boot/dts/uniphier-ph1-sld3-ref.dts
+++ b/arch/arm/boot/dts/uniphier-ph1-sld3-ref.dts
@@ -58,11 +58,13 @@
 
 	chosen {
 		bootargs = "console=ttyS0,115200";
-		stdout-path = &serialsc;
+		stdout-path = &serial0;
 	};
 
 	aliases {
-		serial0 = &serialsc;
+		serial0 = &serial0;
+		serial1 = &serial1;
+		serial2 = &serial2;
 	};
 };
 
@@ -75,6 +77,18 @@
 	ranges = <0x00000000 1 0x03f00000 0x00100000>;
 };
 
-&serialsc {
+&ethsc {
 	interrupts = <0 49 4>;
 };
+
+&serial0 {
+	status = "okay";
+};
+
+&serial1 {
+	status = "okay";
+};
+
+&serial2 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/uniphier-ph1-sld3.dtsi b/arch/arm/boot/dts/uniphier-ph1-sld3.dtsi
index 248b188..feb253b 100644
--- a/arch/arm/boot/dts/uniphier-ph1-sld3.dtsi
+++ b/arch/arm/boot/dts/uniphier-ph1-sld3.dtsi
@@ -71,6 +71,12 @@
 			compatible = "fixed-clock";
 			clock-frequency = <50000000>;
 		};
+
+		uart_clk: uart_clk {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <36864000>;
+		};
 	};
 
 	soc {
@@ -108,6 +114,33 @@
 			      <0x20000100 0x100>;
 		};
 
+		serial0: serial at 54006800 {
+			compatible = "socionext,uniphier-uart";
+			status = "disabled";
+			reg = <0x54006800 0x40>;
+			interrupts = <0 33 4>;
+			clocks = <&uart_clk>;
+			fifo-size = <64>;
+		};
+
+		serial1: serial at 54006900 {
+			compatible = "socionext,uniphier-uart";
+			status = "disabled";
+			reg = <0x54006900 0x40>;
+			interrupts = <0 35 4>;
+			clocks = <&uart_clk>;
+			fifo-size = <64>;
+		};
+
+		serial2: serial at 54006a00 {
+			compatible = "socionext,uniphier-uart";
+			status = "disabled";
+			reg = <0x54006a00 0x40>;
+			interrupts = <0 37 4>;
+			clocks = <&uart_clk>;
+			fifo-size = <64>;
+		};
+
 		system-bus-controller-misc at 59800000 {
 			compatible = "socionext,uniphier-system-bus-controller-misc",
 				     "syscon";
diff --git a/arch/arm/boot/dts/uniphier-ph1-sld8-ref.dts b/arch/arm/boot/dts/uniphier-ph1-sld8-ref.dts
index dcdc4f7..07e93a9 100644
--- a/arch/arm/boot/dts/uniphier-ph1-sld8-ref.dts
+++ b/arch/arm/boot/dts/uniphier-ph1-sld8-ref.dts
@@ -57,11 +57,14 @@
 
 	chosen {
 		bootargs = "console=ttyS0,115200";
-		stdout-path = &serialsc;
+		stdout-path = &serial0;
 	};
 
 	aliases {
-		serial0 = &serialsc;
+		serial0 = &serial0;
+		serial1 = &serial1;
+		serial2 = &serial2;
+		serial3 = &serial3;
 	};
 };
 
@@ -74,6 +77,18 @@
 	ranges = <0x00000000 1 0x03f00000 0x00100000>;
 };
 
-&serialsc {
+&ethsc {
 	interrupts = <0 48 4>;
 };
+
+&serial0 {
+	status = "okay";
+};
+
+&serial2 {
+	status = "okay";
+};
+
+&serial3 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/uniphier-ph1-sld8.dtsi b/arch/arm/boot/dts/uniphier-ph1-sld8.dtsi
index baa71e1..bf0c8c1 100644
--- a/arch/arm/boot/dts/uniphier-ph1-sld8.dtsi
+++ b/arch/arm/boot/dts/uniphier-ph1-sld8.dtsi
@@ -64,6 +64,12 @@
 			compatible = "fixed-clock";
 			clock-frequency = <50000000>;
 		};
+
+		uart_clk: uart_clk {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <80000000>;
+		};
 	};
 
 	soc {
@@ -79,6 +85,42 @@
 			#size-cells = <1>;
 		};
 
+		serial0: serial at 54006800 {
+			compatible = "socionext,uniphier-uart";
+			status = "disabled";
+			reg = <0x54006800 0x40>;
+			interrupts = <0 33 4>;
+			clocks = <&uart_clk>;
+			fifo-size = <64>;
+		};
+
+		serial1: serial at 54006900 {
+			compatible = "socionext,uniphier-uart";
+			status = "disabled";
+			reg = <0x54006900 0x40>;
+			interrupts = <0 35 4>;
+			clocks = <&uart_clk>;
+			fifo-size = <64>;
+		};
+
+		serial2: serial at 54006a00 {
+			compatible = "socionext,uniphier-uart";
+			status = "disabled";
+			reg = <0x54006a00 0x40>;
+			interrupts = <0 37 4>;
+			clocks = <&uart_clk>;
+			fifo-size = <64>;
+		};
+
+		serial3: serial at 54006b00 {
+			compatible = "socionext,uniphier-uart";
+			status = "disabled";
+			reg = <0x54006b00 0x40>;
+			interrupts = <0 29 4>;
+			clocks = <&uart_clk>;
+			fifo-size = <64>;
+		};
+
 		system-bus-controller-misc at 59800000 {
 			compatible = "socionext,uniphier-system-bus-controller-misc",
 				     "syscon";
-- 
1.9.1
