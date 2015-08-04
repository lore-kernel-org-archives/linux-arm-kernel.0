From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue,  4 Aug 2015 20:21:02 +0900
Subject: [PATCH 1/3] ARM: dts: UniPhier: add I2C controller device nodes
In-Reply-To: <1438687264-26538-1-git-send-email-yamada.masahiro@socionext.com>
References: <1438687264-26538-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1438687264-26538-2-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add I2C controller device nodes for PH1-sLD3, PH1-LD4, PH1-sLD8
(FIFO-less I2C) and PH1-Pro4 (FIFO-builtin I2C).

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/dts/uniphier-ph1-ld4-ref.dts  |  8 +++
 arch/arm/boot/dts/uniphier-ph1-ld4.dtsi     | 58 ++++++++++++++++++++
 arch/arm/boot/dts/uniphier-ph1-pro4-ref.dts | 10 ++++
 arch/arm/boot/dts/uniphier-ph1-pro4.dtsi    | 82 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/uniphier-ph1-sld3-ref.dts |  9 ++++
 arch/arm/boot/dts/uniphier-ph1-sld3.dtsi    | 61 +++++++++++++++++++++
 arch/arm/boot/dts/uniphier-ph1-sld8-ref.dts |  8 +++
 arch/arm/boot/dts/uniphier-ph1-sld8.dtsi    | 58 ++++++++++++++++++++
 arch/arm/boot/dts/uniphier-pinctrl.dtsi     | 20 +++++++
 9 files changed, 314 insertions(+)

diff --git a/arch/arm/boot/dts/uniphier-ph1-ld4-ref.dts b/arch/arm/boot/dts/uniphier-ph1-ld4-ref.dts
index 7ac053d..5d24c57 100644
--- a/arch/arm/boot/dts/uniphier-ph1-ld4-ref.dts
+++ b/arch/arm/boot/dts/uniphier-ph1-ld4-ref.dts
@@ -65,6 +65,10 @@
 		serial1 = &serial1;
 		serial2 = &serial2;
 		serial3 = &serial3;
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		i2c2 = &i2c2;
+		i2c3 = &i2c3;
 	};
 };
 
@@ -93,6 +97,10 @@
 	status = "okay";
 };
 
+&i2c0 {
+	status = "okay";
+};
+
 &usb0 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/uniphier-ph1-ld4.dtsi b/arch/arm/boot/dts/uniphier-ph1-ld4.dtsi
index 4add90b..a6a185f 100644
--- a/arch/arm/boot/dts/uniphier-ph1-ld4.dtsi
+++ b/arch/arm/boot/dts/uniphier-ph1-ld4.dtsi
@@ -70,6 +70,12 @@
 			compatible = "fixed-clock";
 			clock-frequency = <36864000>;
 		};
+
+		iobus_clk: iobus_clk {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <100000000>;
+		};
 	};
 
 	soc {
@@ -129,6 +135,58 @@
 			fifo-size = <64>;
 		};
 
+		i2c0: i2c at 58400000 {
+			compatible = "socionext,uniphier-i2c";
+			status = "disabled";
+			reg = <0x58400000 0x40>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_i2c0>;
+			interrupts = <0 41 1>;
+			clocks = <&iobus_clk>;
+			clock-frequency = <100000>;
+		};
+
+		i2c1: i2c at 58480000 {
+			compatible = "socionext,uniphier-i2c";
+			status = "disabled";
+			reg = <0x58480000 0x40>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_i2c1>;
+			interrupts = <0 42 1>;
+			clocks = <&iobus_clk>;
+			clock-frequency = <100000>;
+		};
+
+		/* chip-internal connection for DMD */
+		i2c2: i2c at 58500000 {
+			compatible = "socionext,uniphier-i2c";
+			reg = <0x58500000 0x40>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_i2c2>;
+			interrupts = <0 43 1>;
+			clocks = <&iobus_clk>;
+			clock-frequency = <400000>;
+		};
+
+		i2c3: i2c at 58580000 {
+			compatible = "socionext,uniphier-i2c";
+			status = "disabled";
+			reg = <0x58580000 0x40>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_i2c3>;
+			interrupts = <0 44 1>;
+			clocks = <&iobus_clk>;
+			clock-frequency = <100000>;
+		};
+
 		system-bus-controller-misc at 59800000 {
 			compatible = "socionext,uniphier-system-bus-controller-misc",
 				     "syscon";
diff --git a/arch/arm/boot/dts/uniphier-ph1-pro4-ref.dts b/arch/arm/boot/dts/uniphier-ph1-pro4-ref.dts
index b669d32..26c18ac 100644
--- a/arch/arm/boot/dts/uniphier-ph1-pro4-ref.dts
+++ b/arch/arm/boot/dts/uniphier-ph1-pro4-ref.dts
@@ -65,6 +65,12 @@
 		serial1 = &serial1;
 		serial2 = &serial2;
 		serial3 = &serial3;
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		i2c2 = &i2c2;
+		i2c3 = &i2c3;
+		i2c5 = &i2c5;
+		i2c6 = &i2c6;
 	};
 };
 
@@ -93,6 +99,10 @@
 	status = "okay";
 };
 
+&i2c0 {
+	status = "okay";
+};
+
 &usb2 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/uniphier-ph1-pro4.dtsi b/arch/arm/boot/dts/uniphier-ph1-pro4.dtsi
index d0ca4c8..e8bbc45 100644
--- a/arch/arm/boot/dts/uniphier-ph1-pro4.dtsi
+++ b/arch/arm/boot/dts/uniphier-ph1-pro4.dtsi
@@ -77,6 +77,12 @@
 			compatible = "fixed-clock";
 			clock-frequency = <73728000>;
 		};
+
+		i2c_clk: i2c_clk {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <50000000>;
+		};
 	};
 
 	soc {
@@ -136,6 +142,82 @@
 			fifo-size = <64>;
 		};
 
+		i2c0: i2c at 58780000 {
+			compatible = "socionext,uniphier-fi2c";
+			status = "disabled";
+			reg = <0x58780000 0x80>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_i2c0>;
+			interrupts = <0 41 4>;
+			clocks = <&i2c_clk>;
+			clock-frequency = <100000>;
+		};
+
+		i2c1: i2c at 58781000 {
+			compatible = "socionext,uniphier-fi2c";
+			status = "disabled";
+			reg = <0x58781000 0x80>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_i2c1>;
+			interrupts = <0 42 4>;
+			clocks = <&i2c_clk>;
+			clock-frequency = <100000>;
+		};
+
+		i2c2: i2c at 58782000 {
+			compatible = "socionext,uniphier-fi2c";
+			status = "disabled";
+			reg = <0x58782000 0x80>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_i2c2>;
+			interrupts = <0 43 4>;
+			clocks = <&i2c_clk>;
+			clock-frequency = <100000>;
+		};
+
+		i2c3: i2c at 58783000 {
+			compatible = "socionext,uniphier-fi2c";
+			status = "disabled";
+			reg = <0x58783000 0x80>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_i2c3>;
+			interrupts = <0 44 4>;
+			clocks = <&i2c_clk>;
+			clock-frequency = <100000>;
+		};
+
+		/* i2c4 does not exist */
+
+		/* chip-internal connection for DMD */
+		i2c5: i2c at 58785000 {
+			compatible = "socionext,uniphier-fi2c";
+			reg = <0x58785000 0x80>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <0 25 4>;
+			clocks = <&i2c_clk>;
+			clock-frequency = <400000>;
+		};
+
+		/* chip-internal connection for HDMI */
+		i2c6: i2c at 58786000 {
+			compatible = "socionext,uniphier-fi2c";
+			reg = <0x58786000 0x80>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <0 26 4>;
+			clocks = <&i2c_clk>;
+			clock-frequency = <400000>;
+		};
+
 		system-bus-controller-misc at 59800000 {
 			compatible = "socionext,uniphier-system-bus-controller-misc",
 				     "syscon";
diff --git a/arch/arm/boot/dts/uniphier-ph1-sld3-ref.dts b/arch/arm/boot/dts/uniphier-ph1-sld3-ref.dts
index 48f7361..cb6e9aa 100644
--- a/arch/arm/boot/dts/uniphier-ph1-sld3-ref.dts
+++ b/arch/arm/boot/dts/uniphier-ph1-sld3-ref.dts
@@ -65,6 +65,11 @@
 		serial0 = &serial0;
 		serial1 = &serial1;
 		serial2 = &serial2;
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		i2c2 = &i2c2;
+		i2c3 = &i2c3;
+		i2c4 = &i2c4;
 	};
 };
 
@@ -93,6 +98,10 @@
 	status = "okay";
 };
 
+&i2c0 {
+	status = "okay";
+};
+
 &usb0 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/uniphier-ph1-sld3.dtsi b/arch/arm/boot/dts/uniphier-ph1-sld3.dtsi
index db74457..3cc90cd 100644
--- a/arch/arm/boot/dts/uniphier-ph1-sld3.dtsi
+++ b/arch/arm/boot/dts/uniphier-ph1-sld3.dtsi
@@ -77,6 +77,12 @@
 			compatible = "fixed-clock";
 			clock-frequency = <36864000>;
 		};
+
+		iobus_clk: iobus_clk {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <100000000>;
+		};
 	};
 
 	soc {
@@ -141,6 +147,61 @@
 			fifo-size = <64>;
 		};
 
+		i2c0: i2c at 58400000 {
+			compatible = "socionext,uniphier-i2c";
+			status = "disabled";
+			reg = <0x58400000 0x40>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <0 41 1>;
+			clocks = <&iobus_clk>;
+			clock-frequency = <100000>;
+		};
+
+		i2c1: i2c at 58480000 {
+			compatible = "socionext,uniphier-i2c";
+			status = "disabled";
+			reg = <0x58480000 0x40>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <0 42 1>;
+			clocks = <&iobus_clk>;
+			clock-frequency = <100000>;
+		};
+
+		i2c2: i2c at 58500000 {
+			compatible = "socionext,uniphier-i2c";
+			status = "disabled";
+			reg = <0x58500000 0x40>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <0 43 1>;
+			clocks = <&iobus_clk>;
+			clock-frequency = <100000>;
+		};
+
+		i2c3: i2c at 58580000 {
+			compatible = "socionext,uniphier-i2c";
+			status = "disabled";
+			reg = <0x58580000 0x40>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <0 44 1>;
+			clocks = <&iobus_clk>;
+			clock-frequency = <100000>;
+		};
+
+		/* chip-internal connection for DMD */
+		i2c4: i2c at 58600000 {
+			compatible = "socionext,uniphier-i2c";
+			reg = <0x58600000 0x40>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <0 45 1>;
+			clocks = <&iobus_clk>;
+			clock-frequency = <400000>;
+		};
+
 		system-bus-controller-misc at 59800000 {
 			compatible = "socionext,uniphier-system-bus-controller-misc",
 				     "syscon";
diff --git a/arch/arm/boot/dts/uniphier-ph1-sld8-ref.dts b/arch/arm/boot/dts/uniphier-ph1-sld8-ref.dts
index 9b5992a..a40a0fb 100644
--- a/arch/arm/boot/dts/uniphier-ph1-sld8-ref.dts
+++ b/arch/arm/boot/dts/uniphier-ph1-sld8-ref.dts
@@ -65,6 +65,10 @@
 		serial1 = &serial1;
 		serial2 = &serial2;
 		serial3 = &serial3;
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		i2c2 = &i2c2;
+		i2c3 = &i2c3;
 	};
 };
 
@@ -93,6 +97,10 @@
 	status = "okay";
 };
 
+&i2c0 {
+	status = "okay";
+};
+
 &usb0 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/uniphier-ph1-sld8.dtsi b/arch/arm/boot/dts/uniphier-ph1-sld8.dtsi
index 3ead910..58067df 100644
--- a/arch/arm/boot/dts/uniphier-ph1-sld8.dtsi
+++ b/arch/arm/boot/dts/uniphier-ph1-sld8.dtsi
@@ -70,6 +70,12 @@
 			compatible = "fixed-clock";
 			clock-frequency = <80000000>;
 		};
+
+		iobus_clk: iobus_clk {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <100000000>;
+		};
 	};
 
 	soc {
@@ -129,6 +135,58 @@
 			fifo-size = <64>;
 		};
 
+		i2c0: i2c at 58400000 {
+			compatible = "socionext,uniphier-i2c";
+			status = "disabled";
+			reg = <0x58400000 0x40>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_i2c0>;
+			interrupts = <0 41 1>;
+			clocks = <&iobus_clk>;
+			clock-frequency = <100000>;
+		};
+
+		i2c1: i2c at 58480000 {
+			compatible = "socionext,uniphier-i2c";
+			status = "disabled";
+			reg = <0x58480000 0x40>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_i2c1>;
+			interrupts = <0 42 1>;
+			clocks = <&iobus_clk>;
+			clock-frequency = <100000>;
+		};
+
+		/* chip-internal connection for DMD */
+		i2c2: i2c at 58500000 {
+			compatible = "socionext,uniphier-i2c";
+			reg = <0x58500000 0x40>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_i2c2>;
+			interrupts = <0 43 1>;
+			clocks = <&iobus_clk>;
+			clock-frequency = <400000>;
+		};
+
+		i2c3: i2c at 58580000 {
+			compatible = "socionext,uniphier-i2c";
+			status = "disabled";
+			reg = <0x58580000 0x40>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_i2c3>;
+			interrupts = <0 44 1>;
+			clocks = <&iobus_clk>;
+			clock-frequency = <100000>;
+		};
+
 		system-bus-controller-misc at 59800000 {
 			compatible = "socionext,uniphier-system-bus-controller-misc",
 				     "syscon";
diff --git a/arch/arm/boot/dts/uniphier-pinctrl.dtsi b/arch/arm/boot/dts/uniphier-pinctrl.dtsi
index 1b5b4fe..f67445f 100644
--- a/arch/arm/boot/dts/uniphier-pinctrl.dtsi
+++ b/arch/arm/boot/dts/uniphier-pinctrl.dtsi
@@ -43,6 +43,26 @@
  */
 
 &pinctrl {
+	pinctrl_i2c0: i2c0_grp {
+		groups = "i2c0";
+		function = "i2c0";
+	};
+
+	pinctrl_i2c1: i2c1_grp {
+		groups = "i2c1";
+		function = "i2c1";
+	};
+
+	pinctrl_i2c2: i2c2_grp {
+		groups = "i2c2";
+		function = "i2c2";
+	};
+
+	pinctrl_i2c3: i2c3_grp {
+		groups = "i2c3";
+		function = "i2c3";
+	};
+
 	pinctrl_uart0: uart0_grp {
 		groups = "uart0";
 		function = "uart0";
-- 
1.9.1
