From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu,  3 Dec 2015 15:33:57 +0900
Subject: [PATCH 2/2] ARM: dts: uniphier: factor out common nodes to
 uniphier-common32.dtsi
In-Reply-To: <1449124437-18479-1-git-send-email-yamada.masahiro@socionext.com>
References: <1449124437-18479-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1449124437-18479-3-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

UniPhier SoCs (except PH1-sLD3) have several nodes in common.
Factor out them into uniphier-common32.dtsi.  This improves the code
maintainability.

PH1-sLD3 is so old that it has more or less different register maps
than the others.  So, it cannot be included in this refactoring.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/dts/uniphier-common32.dtsi    | 135 +++++++++++++
 arch/arm/boot/dts/uniphier-ph1-ld4.dtsi     | 265 +++++++++----------------
 arch/arm/boot/dts/uniphier-ph1-pro4.dtsi    | 288 ++++++++++------------------
 arch/arm/boot/dts/uniphier-ph1-pro5.dtsi    | 274 +++++++++-----------------
 arch/arm/boot/dts/uniphier-ph1-sld8.dtsi    | 266 +++++++++----------------
 arch/arm/boot/dts/uniphier-proxstream2.dtsi | 269 +++++++++-----------------
 6 files changed, 605 insertions(+), 892 deletions(-)
 create mode 100644 arch/arm/boot/dts/uniphier-common32.dtsi

diff --git a/arch/arm/boot/dts/uniphier-common32.dtsi b/arch/arm/boot/dts/uniphier-common32.dtsi
new file mode 100644
index 0000000..ea9301a
--- /dev/null
+++ b/arch/arm/boot/dts/uniphier-common32.dtsi
@@ -0,0 +1,135 @@
+/*
+ * Device Tree Source commonly used by UniPhier ARM SoCs
+ *
+ * Copyright (C) 2015 Masahiro Yamada <yamada.masahiro@socionext.com>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+/include/ "skeleton.dtsi"
+
+/ {
+	soc: soc {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+		interrupt-parent = <&intc>;
+
+		extbus: extbus {
+			compatible = "simple-bus";
+			#address-cells = <2>;
+			#size-cells = <1>;
+		};
+
+		serial0: serial at 54006800 {
+			compatible = "socionext,uniphier-uart";
+			status = "disabled";
+			reg = <0x54006800 0x40>;
+			interrupts = <0 33 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_uart0>;
+			clocks = <&uart_clk>;
+		};
+
+		serial1: serial at 54006900 {
+			compatible = "socionext,uniphier-uart";
+			status = "disabled";
+			reg = <0x54006900 0x40>;
+			interrupts = <0 35 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_uart1>;
+			clocks = <&uart_clk>;
+		};
+
+		serial2: serial at 54006a00 {
+			compatible = "socionext,uniphier-uart";
+			status = "disabled";
+			reg = <0x54006a00 0x40>;
+			interrupts = <0 37 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_uart2>;
+			clocks = <&uart_clk>;
+		};
+
+		serial3: serial at 54006b00 {
+			compatible = "socionext,uniphier-uart";
+			status = "disabled";
+			reg = <0x54006b00 0x40>;
+			interrupts = <0 177 4>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_uart3>;
+			clocks = <&uart_clk>;
+		};
+
+		system-bus-controller at 58c00000 {
+			compatible = "socionext,uniphier-system-bus-controller";
+			reg = <0x58c00000 0x400>, <0x59800000 0x2000>;
+		};
+
+		timer at 60000200 {
+			compatible = "arm,cortex-a9-global-timer";
+			reg = <0x60000200 0x20>;
+			interrupts = <1 11 0x104>;
+			clocks = <&arm_timer_clk>;
+		};
+
+		timer at 60000600 {
+			compatible = "arm,cortex-a9-twd-timer";
+			reg = <0x60000600 0x20>;
+			interrupts = <1 13 0x104>;
+			clocks = <&arm_timer_clk>;
+		};
+
+		intc: interrupt-controller at 60001000 {
+			compatible = "arm,cortex-a9-gic";
+			reg = <0x60001000 0x1000>,
+			      <0x60000100 0x100>;
+			#interrupt-cells = <3>;
+			interrupt-controller;
+		};
+
+		pinctrl: pinctrl at 5f801000 {
+			/* specify compatible in each SoC DTSI */
+			reg = <0x5f801000 0xe00>;
+		};
+	};
+};
+
+/include/ "uniphier-pinctrl.dtsi"
diff --git a/arch/arm/boot/dts/uniphier-ph1-ld4.dtsi b/arch/arm/boot/dts/uniphier-ph1-ld4.dtsi
index af49381..34f0d8d 100644
--- a/arch/arm/boot/dts/uniphier-ph1-ld4.dtsi
+++ b/arch/arm/boot/dts/uniphier-ph1-ld4.dtsi
@@ -42,7 +42,7 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
-/include/ "skeleton.dtsi"
+/include/ "uniphier-common32.dtsi"
 
 / {
 	compatible = "socionext,ph1-ld4";
@@ -78,188 +78,105 @@
 			clock-frequency = <100000000>;
 		};
 	};
+};
 
-	soc {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-		interrupt-parent = <&intc>;
-
-		extbus: extbus {
-			compatible = "simple-bus";
-			#address-cells = <2>;
-			#size-cells = <1>;
-		};
-
-		l2: l2-cache at 500c0000 {
-			compatible = "socionext,uniphier-system-cache";
-			reg = <0x500c0000 0x2000>, <0x503c0100 0x4>,
-			      <0x506c0000 0x400>;
-			interrupts = <0 174 4>, <0 175 4>;
-			cache-unified;
-			cache-size = <(512 * 1024)>;
-			cache-sets = <256>;
-			cache-line-size = <128>;
-			cache-level = <2>;
-		};
-
-		serial0: serial at 54006800 {
-			compatible = "socionext,uniphier-uart";
-			status = "disabled";
-			reg = <0x54006800 0x40>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_uart0>;
-			interrupts = <0 33 4>;
-			clocks = <&uart_clk>;
-			fifo-size = <64>;
-		};
-
-		serial1: serial at 54006900 {
-			compatible = "socionext,uniphier-uart";
-			status = "disabled";
-			reg = <0x54006900 0x40>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_uart1>;
-			interrupts = <0 35 4>;
-			clocks = <&uart_clk>;
-			fifo-size = <64>;
-		};
-
-		serial2: serial at 54006a00 {
-			compatible = "socionext,uniphier-uart";
-			status = "disabled";
-			reg = <0x54006a00 0x40>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_uart2>;
-			interrupts = <0 37 4>;
-			clocks = <&uart_clk>;
-			fifo-size = <64>;
-		};
-
-		serial3: serial at 54006b00 {
-			compatible = "socionext,uniphier-uart";
-			status = "disabled";
-			reg = <0x54006b00 0x40>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_uart3>;
-			interrupts = <0 29 4>;
-			clocks = <&uart_clk>;
-			fifo-size = <64>;
-		};
-
-		i2c0: i2c at 58400000 {
-			compatible = "socionext,uniphier-i2c";
-			status = "disabled";
-			reg = <0x58400000 0x40>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_i2c0>;
-			interrupts = <0 41 1>;
-			clocks = <&iobus_clk>;
-			clock-frequency = <100000>;
-		};
-
-		i2c1: i2c at 58480000 {
-			compatible = "socionext,uniphier-i2c";
-			status = "disabled";
-			reg = <0x58480000 0x40>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_i2c1>;
-			interrupts = <0 42 1>;
-			clocks = <&iobus_clk>;
-			clock-frequency = <100000>;
-		};
-
-		/* chip-internal connection for DMD */
-		i2c2: i2c at 58500000 {
-			compatible = "socionext,uniphier-i2c";
-			reg = <0x58500000 0x40>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_i2c2>;
-			interrupts = <0 43 1>;
-			clocks = <&iobus_clk>;
-			clock-frequency = <400000>;
-		};
+&soc {
+	l2: l2-cache at 500c0000 {
+		compatible = "socionext,uniphier-system-cache";
+		reg = <0x500c0000 0x2000>, <0x503c0100 0x4>, <0x506c0000 0x400>;
+		interrupts = <0 174 4>, <0 175 4>;
+		cache-unified;
+		cache-size = <(512 * 1024)>;
+		cache-sets = <256>;
+		cache-line-size = <128>;
+		cache-level = <2>;
+	};
 
-		i2c3: i2c at 58580000 {
-			compatible = "socionext,uniphier-i2c";
-			status = "disabled";
-			reg = <0x58580000 0x40>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_i2c3>;
-			interrupts = <0 44 1>;
-			clocks = <&iobus_clk>;
-			clock-frequency = <100000>;
-		};
+	i2c0: i2c at 58400000 {
+		compatible = "socionext,uniphier-i2c";
+		status = "disabled";
+		reg = <0x58400000 0x40>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupts = <0 41 1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i2c0>;
+		clocks = <&iobus_clk>;
+		clock-frequency = <100000>;
+	};
 
-		system-bus-controller at 58c00000 {
-			compatible = "socionext,uniphier-system-bus-controller";
-			reg = <0x58c00000 0x400>, <0x59800000 0x2000>;
-		};
+	i2c1: i2c at 58480000 {
+		compatible = "socionext,uniphier-i2c";
+		status = "disabled";
+		reg = <0x58480000 0x40>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupts = <0 42 1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i2c1>;
+		clocks = <&iobus_clk>;
+		clock-frequency = <100000>;
+	};
 
-		usb0: usb at 5a800100 {
-			compatible = "socionext,uniphier-ehci", "generic-ehci";
-			status = "disabled";
-			reg = <0x5a800100 0x100>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_usb0>;
-			interrupts = <0 80 4>;
-		};
+	/* chip-internal connection for DMD */
+	i2c2: i2c at 58500000 {
+		compatible = "socionext,uniphier-i2c";
+		reg = <0x58500000 0x40>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupts = <0 43 1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i2c2>;
+		clocks = <&iobus_clk>;
+		clock-frequency = <400000>;
+	};
 
-		usb1: usb at 5a810100 {
-			compatible = "socionext,uniphier-ehci", "generic-ehci";
-			status = "disabled";
-			reg = <0x5a810100 0x100>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_usb1>;
-			interrupts = <0 81 4>;
-		};
+	i2c3: i2c at 58580000 {
+		compatible = "socionext,uniphier-i2c";
+		status = "disabled";
+		reg = <0x58580000 0x40>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupts = <0 44 1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i2c3>;
+		clocks = <&iobus_clk>;
+		clock-frequency = <100000>;
+	};
 
-		usb2: usb at 5a820100 {
-			compatible = "socionext,uniphier-ehci", "generic-ehci";
-			status = "disabled";
-			reg = <0x5a820100 0x100>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_usb2>;
-			interrupts = <0 82 4>;
-		};
+	usb0: usb at 5a800100 {
+		compatible = "socionext,uniphier-ehci", "generic-ehci";
+		status = "disabled";
+		reg = <0x5a800100 0x100>;
+		interrupts = <0 80 4>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usb0>;
+	};
 
-		pinctrl: pinctrl at 5f801000 {
-			compatible = "socionext,ph1-ld4-pinctrl",
-				     "syscon";
-			reg = <0x5f801000 0xe00>;
-		};
+	usb1: usb at 5a810100 {
+		compatible = "socionext,uniphier-ehci", "generic-ehci";
+		status = "disabled";
+		reg = <0x5a810100 0x100>;
+		interrupts = <0 81 4>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usb1>;
+	};
 
-		timer at 60000200 {
-			compatible = "arm,cortex-a9-global-timer";
-			reg = <0x60000200 0x20>;
-			interrupts = <1 11 0x104>;
-			clocks = <&arm_timer_clk>;
-		};
+	usb2: usb at 5a820100 {
+		compatible = "socionext,uniphier-ehci", "generic-ehci";
+		status = "disabled";
+		reg = <0x5a820100 0x100>;
+		interrupts = <0 82 4>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usb2>;
+	};
 
-		timer at 60000600 {
-			compatible = "arm,cortex-a9-twd-timer";
-			reg = <0x60000600 0x20>;
-			interrupts = <1 13 0x104>;
-			clocks = <&arm_timer_clk>;
-		};
+};
 
-		intc: interrupt-controller at 60001000 {
-			compatible = "arm,cortex-a9-gic";
-			#interrupt-cells = <3>;
-			interrupt-controller;
-			reg = <0x60001000 0x1000>,
-			      <0x60000100 0x100>;
-		};
-	};
+&serial3 {
+	interrupts = <0 29 4>;
 };
 
-/include/ "uniphier-pinctrl.dtsi"
+&pinctrl {
+	compatible = "socionext,ph1-ld4-pinctrl", "syscon";
+};
diff --git a/arch/arm/boot/dts/uniphier-ph1-pro4.dtsi b/arch/arm/boot/dts/uniphier-ph1-pro4.dtsi
index bbf3727..d78142f 100644
--- a/arch/arm/boot/dts/uniphier-ph1-pro4.dtsi
+++ b/arch/arm/boot/dts/uniphier-ph1-pro4.dtsi
@@ -42,7 +42,7 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
-/include/ "skeleton.dtsi"
+/include/ "uniphier-common32.dtsi"
 
 / {
 	compatible = "socionext,ph1-pro4";
@@ -86,203 +86,115 @@
 			clock-frequency = <50000000>;
 		};
 	};
+};
 
-	soc {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-		interrupt-parent = <&intc>;
-
-		extbus: extbus {
-			compatible = "simple-bus";
-			#address-cells = <2>;
-			#size-cells = <1>;
-		};
-
-		l2: l2-cache at 500c0000 {
-			compatible = "socionext,uniphier-system-cache";
-			reg = <0x500c0000 0x2000>, <0x503c0100 0x4>,
-			      <0x506c0000 0x400>;
-			interrupts = <0 174 4>, <0 175 4>;
-			cache-unified;
-			cache-size = <(768 * 1024)>;
-			cache-sets = <256>;
-			cache-line-size = <128>;
-			cache-level = <2>;
-		};
-
-		serial0: serial at 54006800 {
-			compatible = "socionext,uniphier-uart";
-			status = "disabled";
-			reg = <0x54006800 0x40>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_uart0>;
-			interrupts = <0 33 4>;
-			clocks = <&uart_clk>;
-			fifo-size = <64>;
-		};
-
-		serial1: serial at 54006900 {
-			compatible = "socionext,uniphier-uart";
-			status = "disabled";
-			reg = <0x54006900 0x40>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_uart1>;
-			interrupts = <0 35 4>;
-			clocks = <&uart_clk>;
-			fifo-size = <64>;
-		};
-
-		serial2: serial at 54006a00 {
-			compatible = "socionext,uniphier-uart";
-			status = "disabled";
-			reg = <0x54006a00 0x40>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_uart2>;
-			interrupts = <0 37 4>;
-			clocks = <&uart_clk>;
-			fifo-size = <64>;
-		};
-
-		serial3: serial at 54006b00 {
-			compatible = "socionext,uniphier-uart";
-			status = "disabled";
-			reg = <0x54006b00 0x40>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_uart3>;
-			interrupts = <0 177 4>;
-			clocks = <&uart_clk>;
-			fifo-size = <64>;
-		};
-
-		i2c0: i2c at 58780000 {
-			compatible = "socionext,uniphier-fi2c";
-			status = "disabled";
-			reg = <0x58780000 0x80>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_i2c0>;
-			interrupts = <0 41 4>;
-			clocks = <&i2c_clk>;
-			clock-frequency = <100000>;
-		};
-
-		i2c1: i2c at 58781000 {
-			compatible = "socionext,uniphier-fi2c";
-			status = "disabled";
-			reg = <0x58781000 0x80>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_i2c1>;
-			interrupts = <0 42 4>;
-			clocks = <&i2c_clk>;
-			clock-frequency = <100000>;
-		};
-
-		i2c2: i2c at 58782000 {
-			compatible = "socionext,uniphier-fi2c";
-			status = "disabled";
-			reg = <0x58782000 0x80>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_i2c2>;
-			interrupts = <0 43 4>;
-			clocks = <&i2c_clk>;
-			clock-frequency = <100000>;
-		};
-
-		i2c3: i2c at 58783000 {
-			compatible = "socionext,uniphier-fi2c";
-			status = "disabled";
-			reg = <0x58783000 0x80>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_i2c3>;
-			interrupts = <0 44 4>;
-			clocks = <&i2c_clk>;
-			clock-frequency = <100000>;
-		};
-
-		/* i2c4 does not exist */
+&soc {
+	l2: l2-cache at 500c0000 {
+		compatible = "socionext,uniphier-system-cache";
+		reg = <0x500c0000 0x2000>, <0x503c0100 0x4>, <0x506c0000 0x400>;
+		interrupts = <0 174 4>, <0 175 4>;
+		cache-unified;
+		cache-size = <(768 * 1024)>;
+		cache-sets = <256>;
+		cache-line-size = <128>;
+		cache-level = <2>;
+	};
 
-		/* chip-internal connection for DMD */
-		i2c5: i2c at 58785000 {
-			compatible = "socionext,uniphier-fi2c";
-			reg = <0x58785000 0x80>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			interrupts = <0 25 4>;
-			clocks = <&i2c_clk>;
-			clock-frequency = <400000>;
-		};
+	i2c0: i2c at 58780000 {
+		compatible = "socionext,uniphier-fi2c";
+		status = "disabled";
+		reg = <0x58780000 0x80>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupts = <0 41 4>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i2c0>;
+		clocks = <&i2c_clk>;
+		clock-frequency = <100000>;
+	};
 
-		/* chip-internal connection for HDMI */
-		i2c6: i2c at 58786000 {
-			compatible = "socionext,uniphier-fi2c";
-			reg = <0x58786000 0x80>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			interrupts = <0 26 4>;
-			clocks = <&i2c_clk>;
-			clock-frequency = <400000>;
-		};
+	i2c1: i2c at 58781000 {
+		compatible = "socionext,uniphier-fi2c";
+		status = "disabled";
+		reg = <0x58781000 0x80>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupts = <0 42 4>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i2c1>;
+		clocks = <&i2c_clk>;
+		clock-frequency = <100000>;
+	};
 
-		system-bus-controller at 58c00000 {
-			compatible = "socionext,uniphier-system-bus-controller";
-			reg = <0x58c00000 0x400>, <0x59800000 0x2000>;
-		};
+	i2c2: i2c at 58782000 {
+		compatible = "socionext,uniphier-fi2c";
+		status = "disabled";
+		reg = <0x58782000 0x80>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupts = <0 43 4>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i2c2>;
+		clocks = <&i2c_clk>;
+		clock-frequency = <100000>;
+	};
 
-		usb2: usb at 5a800100 {
-			compatible = "socionext,uniphier-ehci", "generic-ehci";
-			status = "disabled";
-			reg = <0x5a800100 0x100>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_usb2>;
-			interrupts = <0 80 4>;
-		};
+	i2c3: i2c at 58783000 {
+		compatible = "socionext,uniphier-fi2c";
+		status = "disabled";
+		reg = <0x58783000 0x80>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupts = <0 44 4>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i2c3>;
+		clocks = <&i2c_clk>;
+		clock-frequency = <100000>;
+	};
 
-		usb3: usb at 5a810100 {
-			compatible = "socionext,uniphier-ehci", "generic-ehci";
-			status = "disabled";
-			reg = <0x5a810100 0x100>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_usb3>;
-			interrupts = <0 81 4>;
-		};
+	/* i2c4 does not exist */
 
-		pinctrl: pinctrl at 5f801000 {
-			compatible = "socionext,ph1-pro4-pinctrl",
-				     "syscon";
-			reg = <0x5f801000 0xe00>;
-		};
+	/* chip-internal connection for DMD */
+	i2c5: i2c at 58785000 {
+		compatible = "socionext,uniphier-fi2c";
+		reg = <0x58785000 0x80>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupts = <0 25 4>;
+		clocks = <&i2c_clk>;
+		clock-frequency = <400000>;
+	};
 
-		timer at 60000200 {
-			compatible = "arm,cortex-a9-global-timer";
-			reg = <0x60000200 0x20>;
-			interrupts = <1 11 0x304>;
-			clocks = <&arm_timer_clk>;
-		};
+	/* chip-internal connection for HDMI */
+	i2c6: i2c at 58786000 {
+		compatible = "socionext,uniphier-fi2c";
+		reg = <0x58786000 0x80>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupts = <0 26 4>;
+		clocks = <&i2c_clk>;
+		clock-frequency = <400000>;
+	};
 
-		timer at 60000600 {
-			compatible = "arm,cortex-a9-twd-timer";
-			reg = <0x60000600 0x20>;
-			interrupts = <1 13 0x304>;
-			clocks = <&arm_timer_clk>;
-		};
+	usb2: usb at 5a800100 {
+		compatible = "socionext,uniphier-ehci", "generic-ehci";
+		status = "disabled";
+		reg = <0x5a800100 0x100>;
+		interrupts = <0 80 4>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usb2>;
+	};
 
-		intc: interrupt-controller at 60001000 {
-			compatible = "arm,cortex-a9-gic";
-			#interrupt-cells = <3>;
-			interrupt-controller;
-			reg = <0x60001000 0x1000>,
-			      <0x60000100 0x100>;
-		};
+	usb3: usb at 5a810100 {
+		compatible = "socionext,uniphier-ehci", "generic-ehci";
+		status = "disabled";
+		reg = <0x5a810100 0x100>;
+		interrupts = <0 81 4>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usb3>;
 	};
 };
 
-/include/ "uniphier-pinctrl.dtsi"
+&pinctrl {
+	compatible = "socionext,ph1-pro4-pinctrl", "syscon";
+};
diff --git a/arch/arm/boot/dts/uniphier-ph1-pro5.dtsi b/arch/arm/boot/dts/uniphier-ph1-pro5.dtsi
index 11eb762..2f389ea 100644
--- a/arch/arm/boot/dts/uniphier-ph1-pro5.dtsi
+++ b/arch/arm/boot/dts/uniphier-ph1-pro5.dtsi
@@ -42,7 +42,7 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
-/include/ "skeleton.dtsi"
+/include/ "uniphier-common32.dtsi"
 
 / {
 	compatible = "socionext,ph1-pro5";
@@ -86,193 +86,109 @@
 			clock-frequency = <50000000>;
 		};
 	};
+};
 
-	soc {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-		interrupt-parent = <&intc>;
-
-		extbus: extbus {
-			compatible = "simple-bus";
-			#address-cells = <2>;
-			#size-cells = <1>;
-		};
-
-		l2: l2-cache at 500c0000 {
-			compatible = "socionext,uniphier-system-cache";
-			reg = <0x500c0000 0x2000>, <0x503c0100 0x8>,
-			      <0x506c0000 0x400>;
-			interrupts = <0 190 4>, <0 191 4>;
-			cache-unified;
-			cache-size = <(2 * 1024 * 1024)>;
-			cache-sets = <512>;
-			cache-line-size = <128>;
-			cache-level = <2>;
-			next-level-cache = <&l3>;
-		};
-
-		l3: l3-cache at 500c8000 {
-			compatible = "socionext,uniphier-system-cache";
-			reg = <0x500c8000 0x2000>, <0x503c8100 0x8>,
-			      <0x506c8000 0x400>;
-			interrupts = <0 174 4>, <0 175 4>;
-			cache-unified;
-			cache-size = <(2 * 1024 * 1024)>;
-			cache-sets = <512>;
-			cache-line-size = <256>;
-			cache-level = <3>;
-		};
-
-		serial0: serial at 54006800 {
-			compatible = "socionext,uniphier-uart";
-			status = "disabled";
-			reg = <0x54006800 0x40>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_uart0>;
-			interrupts = <0 33 4>;
-			clocks = <&uart_clk>;
-		};
-
-		serial1: serial at 54006900 {
-			compatible = "socionext,uniphier-uart";
-			status = "disabled";
-			reg = <0x54006900 0x40>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_uart1>;
-			interrupts = <0 35 4>;
-			clocks = <&uart_clk>;
-		};
-
-		serial2: serial at 54006a00 {
-			compatible = "socionext,uniphier-uart";
-			status = "disabled";
-			reg = <0x54006a00 0x40>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_uart2>;
-			interrupts = <0 37 4>;
-			clocks = <&uart_clk>;
-		};
-
-		serial3: serial at 54006b00 {
-			compatible = "socionext,uniphier-uart";
-			status = "disabled";
-			reg = <0x54006b00 0x40>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_uart3>;
-			interrupts = <0 177 4>;
-			clocks = <&uart_clk>;
-		};
-
-		i2c0: i2c at 58780000 {
-			compatible = "socionext,uniphier-fi2c";
-			status = "disabled";
-			reg = <0x58780000 0x80>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_i2c0>;
-			interrupts = <0 41 4>;
-			clocks = <&i2c_clk>;
-			clock-frequency = <100000>;
-		};
-
-		i2c1: i2c at 58781000 {
-			compatible = "socionext,uniphier-fi2c";
-			status = "disabled";
-			reg = <0x58781000 0x80>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_i2c1>;
-			interrupts = <0 42 4>;
-			clocks = <&i2c_clk>;
-			clock-frequency = <100000>;
-		};
-
-		i2c2: i2c at 58782000 {
-			compatible = "socionext,uniphier-fi2c";
-			status = "disabled";
-			reg = <0x58782000 0x80>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_i2c2>;
-			interrupts = <0 43 4>;
-			clocks = <&i2c_clk>;
-			clock-frequency = <100000>;
-		};
-
-		i2c3: i2c at 58783000 {
-			compatible = "socionext,uniphier-fi2c";
-			status = "disabled";
-			reg = <0x58783000 0x80>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_i2c3>;
-			interrupts = <0 44 4>;
-			clocks = <&i2c_clk>;
-			clock-frequency = <100000>;
-		};
+&soc {
+	l2: l2-cache at 500c0000 {
+		compatible = "socionext,uniphier-system-cache";
+		reg = <0x500c0000 0x2000>, <0x503c0100 0x8>, <0x506c0000 0x400>;
+		interrupts = <0 190 4>, <0 191 4>;
+		cache-unified;
+		cache-size = <(2 * 1024 * 1024)>;
+		cache-sets = <512>;
+		cache-line-size = <128>;
+		cache-level = <2>;
+		next-level-cache = <&l3>;
+	};
 
-		/* i2c4 does not exist */
+	l3: l3-cache at 500c8000 {
+		compatible = "socionext,uniphier-system-cache";
+		reg = <0x500c8000 0x2000>, <0x503c8100 0x8>, <0x506c8000 0x400>;
+		interrupts = <0 174 4>, <0 175 4>;
+		cache-unified;
+		cache-size = <(2 * 1024 * 1024)>;
+		cache-sets = <512>;
+		cache-line-size = <256>;
+		cache-level = <3>;
+	};
 
-		/* chip-internal connection for DMD */
-		i2c5: i2c at 58785000 {
-			compatible = "socionext,uniphier-fi2c";
-			reg = <0x58785000 0x80>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			interrupts = <0 25 4>;
-			clocks = <&i2c_clk>;
-			clock-frequency = <400000>;
-		};
+	i2c0: i2c at 58780000 {
+		compatible = "socionext,uniphier-fi2c";
+		status = "disabled";
+		reg = <0x58780000 0x80>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupts = <0 41 4>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i2c0>;
+		clocks = <&i2c_clk>;
+		clock-frequency = <100000>;
+	};
 
-		/* chip-internal connection for HDMI */
-		i2c6: i2c at 58786000 {
-			compatible = "socionext,uniphier-fi2c";
-			reg = <0x58786000 0x80>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			interrupts = <0 26 4>;
-			clocks = <&i2c_clk>;
-			clock-frequency = <400000>;
-		};
+	i2c1: i2c at 58781000 {
+		compatible = "socionext,uniphier-fi2c";
+		status = "disabled";
+		reg = <0x58781000 0x80>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupts = <0 42 4>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i2c1>;
+		clocks = <&i2c_clk>;
+		clock-frequency = <100000>;
+	};
 
-		system-bus-controller at 58c00000 {
-			compatible = "socionext,uniphier-system-bus-controller";
-			reg = <0x58c00000 0x400>, <0x59800000 0x2000>;
-		};
+	i2c2: i2c at 58782000 {
+		compatible = "socionext,uniphier-fi2c";
+		status = "disabled";
+		reg = <0x58782000 0x80>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupts = <0 43 4>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i2c2>;
+		clocks = <&i2c_clk>;
+		clock-frequency = <100000>;
+	};
 
-		pinctrl: pinctrl at 5f801000 {
-			compatible = "socionext,ph1-pro5-pinctrl", "syscon";
-			reg = <0x5f801000 0xe00>;
-		};
+	i2c3: i2c at 58783000 {
+		compatible = "socionext,uniphier-fi2c";
+		status = "disabled";
+		reg = <0x58783000 0x80>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupts = <0 44 4>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i2c3>;
+		clocks = <&i2c_clk>;
+		clock-frequency = <100000>;
+	};
 
-		timer at 60000200 {
-			compatible = "arm,cortex-a9-global-timer";
-			reg = <0x60000200 0x20>;
-			interrupts = <1 11 0x304>;
-			clocks = <&arm_timer_clk>;
-		};
+	/* i2c4 does not exist */
 
-		timer at 60000600 {
-			compatible = "arm,cortex-a9-twd-timer";
-			reg = <0x60000600 0x20>;
-			interrupts = <1 13 0x304>;
-			clocks = <&arm_timer_clk>;
-		};
+	/* chip-internal connection for DMD */
+	i2c5: i2c at 58785000 {
+		compatible = "socionext,uniphier-fi2c";
+		reg = <0x58785000 0x80>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupts = <0 25 4>;
+		clocks = <&i2c_clk>;
+		clock-frequency = <400000>;
+	};
 
-		intc: interrupt-controller at 60001000 {
-			compatible = "arm,cortex-a9-gic";
-			#interrupt-cells = <3>;
-			interrupt-controller;
-			reg = <0x60001000 0x1000>,
-			      <0x60000100 0x100>;
-		};
+	/* chip-internal connection for HDMI */
+	i2c6: i2c at 58786000 {
+		compatible = "socionext,uniphier-fi2c";
+		reg = <0x58786000 0x80>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupts = <0 26 4>;
+		clocks = <&i2c_clk>;
+		clock-frequency = <400000>;
 	};
 };
 
-/include/ "uniphier-pinctrl.dtsi"
+&pinctrl {
+	compatible = "socionext,ph1-pro5-pinctrl", "syscon";
+};
diff --git a/arch/arm/boot/dts/uniphier-ph1-sld8.dtsi b/arch/arm/boot/dts/uniphier-ph1-sld8.dtsi
index e88559b..7d06a1c 100644
--- a/arch/arm/boot/dts/uniphier-ph1-sld8.dtsi
+++ b/arch/arm/boot/dts/uniphier-ph1-sld8.dtsi
@@ -42,7 +42,7 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
-/include/ "skeleton.dtsi"
+/include/ "uniphier-common32.dtsi"
 
 / {
 	compatible = "socionext,ph1-sld8";
@@ -78,188 +78,104 @@
 			clock-frequency = <100000000>;
 		};
 	};
+};
 
-	soc {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-		interrupt-parent = <&intc>;
-
-		extbus: extbus {
-			compatible = "simple-bus";
-			#address-cells = <2>;
-			#size-cells = <1>;
-		};
-
-		l2: l2-cache at 500c0000 {
-			compatible = "socionext,uniphier-system-cache";
-			reg = <0x500c0000 0x2000>, <0x503c0100 0x4>,
-			      <0x506c0000 0x400>;
-			interrupts = <0 174 4>, <0 175 4>;
-			cache-unified;
-			cache-size = <(256 * 1024)>;
-			cache-sets = <256>;
-			cache-line-size = <128>;
-			cache-level = <2>;
-		};
-
-		serial0: serial at 54006800 {
-			compatible = "socionext,uniphier-uart";
-			status = "disabled";
-			reg = <0x54006800 0x40>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_uart0>;
-			interrupts = <0 33 4>;
-			clocks = <&uart_clk>;
-			fifo-size = <64>;
-		};
-
-		serial1: serial at 54006900 {
-			compatible = "socionext,uniphier-uart";
-			status = "disabled";
-			reg = <0x54006900 0x40>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_uart1>;
-			interrupts = <0 35 4>;
-			clocks = <&uart_clk>;
-			fifo-size = <64>;
-		};
-
-		serial2: serial at 54006a00 {
-			compatible = "socionext,uniphier-uart";
-			status = "disabled";
-			reg = <0x54006a00 0x40>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_uart2>;
-			interrupts = <0 37 4>;
-			clocks = <&uart_clk>;
-			fifo-size = <64>;
-		};
-
-		serial3: serial at 54006b00 {
-			compatible = "socionext,uniphier-uart";
-			status = "disabled";
-			reg = <0x54006b00 0x40>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_uart3>;
-			interrupts = <0 29 4>;
-			clocks = <&uart_clk>;
-			fifo-size = <64>;
-		};
-
-		i2c0: i2c at 58400000 {
-			compatible = "socionext,uniphier-i2c";
-			status = "disabled";
-			reg = <0x58400000 0x40>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_i2c0>;
-			interrupts = <0 41 1>;
-			clocks = <&iobus_clk>;
-			clock-frequency = <100000>;
-		};
-
-		i2c1: i2c at 58480000 {
-			compatible = "socionext,uniphier-i2c";
-			status = "disabled";
-			reg = <0x58480000 0x40>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_i2c1>;
-			interrupts = <0 42 1>;
-			clocks = <&iobus_clk>;
-			clock-frequency = <100000>;
-		};
-
-		/* chip-internal connection for DMD */
-		i2c2: i2c at 58500000 {
-			compatible = "socionext,uniphier-i2c";
-			reg = <0x58500000 0x40>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_i2c2>;
-			interrupts = <0 43 1>;
-			clocks = <&iobus_clk>;
-			clock-frequency = <400000>;
-		};
-
-		i2c3: i2c at 58580000 {
-			compatible = "socionext,uniphier-i2c";
-			status = "disabled";
-			reg = <0x58580000 0x40>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_i2c3>;
-			interrupts = <0 44 1>;
-			clocks = <&iobus_clk>;
-			clock-frequency = <100000>;
-		};
-
-		system-bus-controller at 58c00000 {
-			compatible = "socionext,uniphier-system-bus-controller";
-			reg = <0x58c00000 0x400>, <0x59800000 0x2000>;
-		};
+&soc {
+	l2: l2-cache at 500c0000 {
+		compatible = "socionext,uniphier-system-cache";
+		reg = <0x500c0000 0x2000>, <0x503c0100 0x4>, <0x506c0000 0x400>;
+		interrupts = <0 174 4>, <0 175 4>;
+		cache-unified;
+		cache-size = <(256 * 1024)>;
+		cache-sets = <256>;
+		cache-line-size = <128>;
+		cache-level = <2>;
+	};
 
-		usb0: usb at 5a800100 {
-			compatible = "socionext,uniphier-ehci", "generic-ehci";
-			status = "disabled";
-			reg = <0x5a800100 0x100>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_usb0>;
-			interrupts = <0 80 4>;
-		};
+	i2c0: i2c at 58400000 {
+		compatible = "socionext,uniphier-i2c";
+		status = "disabled";
+		reg = <0x58400000 0x40>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupts = <0 41 1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i2c0>;
+		clocks = <&iobus_clk>;
+		clock-frequency = <100000>;
+	};
 
-		usb1: usb at 5a810100 {
-			compatible = "socionext,uniphier-ehci", "generic-ehci";
-			status = "disabled";
-			reg = <0x5a810100 0x100>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_usb1>;
-			interrupts = <0 81 4>;
-		};
+	i2c1: i2c at 58480000 {
+		compatible = "socionext,uniphier-i2c";
+		status = "disabled";
+		reg = <0x58480000 0x40>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupts = <0 42 1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i2c1>;
+		clocks = <&iobus_clk>;
+		clock-frequency = <100000>;
+	};
 
-		usb2: usb at 5a820100 {
-			compatible = "socionext,uniphier-ehci", "generic-ehci";
-			status = "disabled";
-			reg = <0x5a820100 0x100>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_usb2>;
-			interrupts = <0 82 4>;
-		};
+	/* chip-internal connection for DMD */
+	i2c2: i2c at 58500000 {
+		compatible = "socionext,uniphier-i2c";
+		reg = <0x58500000 0x40>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupts = <0 43 1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i2c2>;
+		clocks = <&iobus_clk>;
+		clock-frequency = <400000>;
+	};
 
-		pinctrl: pinctrl at 5f801000 {
-			compatible = "socionext,ph1-sld8-pinctrl",
-				     "syscon";
-			reg = <0x5f801000 0xe00>;
-		};
+	i2c3: i2c at 58580000 {
+		compatible = "socionext,uniphier-i2c";
+		status = "disabled";
+		reg = <0x58580000 0x40>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupts = <0 44 1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i2c3>;
+		clocks = <&iobus_clk>;
+		clock-frequency = <100000>;
+	};
 
-		timer at 60000200 {
-			compatible = "arm,cortex-a9-global-timer";
-			reg = <0x60000200 0x20>;
-			interrupts = <1 11 0x104>;
-			clocks = <&arm_timer_clk>;
-		};
+	usb0: usb at 5a800100 {
+		compatible = "socionext,uniphier-ehci", "generic-ehci";
+		status = "disabled";
+		reg = <0x5a800100 0x100>;
+		interrupts = <0 80 4>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usb0>;
+	};
 
-		timer at 60000600 {
-			compatible = "arm,cortex-a9-twd-timer";
-			reg = <0x60000600 0x20>;
-			interrupts = <1 13 0x104>;
-			clocks = <&arm_timer_clk>;
-		};
+	usb1: usb at 5a810100 {
+		compatible = "socionext,uniphier-ehci", "generic-ehci";
+		status = "disabled";
+		reg = <0x5a810100 0x100>;
+		interrupts = <0 81 4>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usb1>;
+	};
 
-		intc: interrupt-controller at 60001000 {
-			compatible = "arm,cortex-a9-gic";
-			#interrupt-cells = <3>;
-			interrupt-controller;
-			reg = <0x60001000 0x1000>,
-			      <0x60000100 0x100>;
-		};
+	usb2: usb at 5a820100 {
+		compatible = "socionext,uniphier-ehci", "generic-ehci";
+		status = "disabled";
+		reg = <0x5a820100 0x100>;
+		interrupts = <0 82 4>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usb2>;
 	};
 };
 
-/include/ "uniphier-pinctrl.dtsi"
+&serial3 {
+	interrupts = <0 29 4>;
+};
+
+&pinctrl {
+	compatible = "socionext,ph1-sld8-pinctrl", "syscon";
+};
diff --git a/arch/arm/boot/dts/uniphier-proxstream2.dtsi b/arch/arm/boot/dts/uniphier-proxstream2.dtsi
index 259f1a9..6bd353f 100644
--- a/arch/arm/boot/dts/uniphier-proxstream2.dtsi
+++ b/arch/arm/boot/dts/uniphier-proxstream2.dtsi
@@ -42,7 +42,7 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
-/include/ "skeleton.dtsi"
+/include/ "uniphier-common32.dtsi"
 
 / {
 	compatible = "socionext,proxstream2";
@@ -100,189 +100,106 @@
 			clock-frequency = <50000000>;
 		};
 	};
+};
 
-	soc {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-		interrupt-parent = <&intc>;
-
-		extbus: extbus {
-			compatible = "simple-bus";
-			#address-cells = <2>;
-			#size-cells = <1>;
-		};
-
-		l2: l2-cache at 500c0000 {
-			compatible = "socionext,uniphier-system-cache";
-			reg = <0x500c0000 0x2000>, <0x503c0100 0x4>,
-			      <0x506c0000 0x400>;
-			interrupts = <0 174 4>, <0 175 4>, <0 190 4>, <0 191 4>;
-			cache-unified;
-			cache-size = <(1280 * 1024)>;
-			cache-sets = <512>;
-			cache-line-size = <128>;
-			cache-level = <2>;
-		};
-
-		serial0: serial at 54006800 {
-			compatible = "socionext,uniphier-uart";
-			status = "disabled";
-			reg = <0x54006800 0x40>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_uart0>;
-			interrupts = <0 33 4>;
-			clocks = <&uart_clk>;
-		};
-
-		serial1: serial at 54006900 {
-			compatible = "socionext,uniphier-uart";
-			status = "disabled";
-			reg = <0x54006900 0x40>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_uart1>;
-			interrupts = <0 35 4>;
-			clocks = <&uart_clk>;
-		};
-
-		serial2: serial at 54006a00 {
-			compatible = "socionext,uniphier-uart";
-			status = "disabled";
-			reg = <0x54006a00 0x40>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_uart2>;
-			interrupts = <0 37 4>;
-			clocks = <&uart_clk>;
-		};
-
-		serial3: serial at 54006b00 {
-			compatible = "socionext,uniphier-uart";
-			status = "disabled";
-			reg = <0x54006b00 0x40>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_uart3>;
-			interrupts = <0 177 4>;
-			clocks = <&uart_clk>;
-		};
-
-		i2c0: i2c at 58780000 {
-			compatible = "socionext,uniphier-fi2c";
-			status = "disabled";
-			reg = <0x58780000 0x80>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_i2c0>;
-			interrupts = <0 41 4>;
-			clocks = <&i2c_clk>;
-			clock-frequency = <100000>;
-		};
-
-		i2c1: i2c at 58781000 {
-			compatible = "socionext,uniphier-fi2c";
-			status = "disabled";
-			reg = <0x58781000 0x80>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_i2c1>;
-			interrupts = <0 42 4>;
-			clocks = <&i2c_clk>;
-			clock-frequency = <100000>;
-		};
-
-		i2c2: i2c at 58782000 {
-			compatible = "socionext,uniphier-fi2c";
-			status = "disabled";
-			reg = <0x58782000 0x80>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_i2c2>;
-			interrupts = <0 43 4>;
-			clocks = <&i2c_clk>;
-			clock-frequency = <100000>;
-		};
-
-		i2c3: i2c at 58783000 {
-			compatible = "socionext,uniphier-fi2c";
-			status = "disabled";
-			reg = <0x58783000 0x80>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_i2c3>;
-			interrupts = <0 44 4>;
-			clocks = <&i2c_clk>;
-			clock-frequency = <100000>;
-		};
-
-		/* chip-internal connection for DMD */
-		i2c4: i2c at 58784000 {
-			compatible = "socionext,uniphier-fi2c";
-			reg = <0x58784000 0x80>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			interrupts = <0 45 4>;
-			clocks = <&i2c_clk>;
-			clock-frequency = <400000>;
-		};
+&soc {
+	l2: l2-cache at 500c0000 {
+		compatible = "socionext,uniphier-system-cache";
+		reg = <0x500c0000 0x2000>, <0x503c0100 0x4>, <0x506c0000 0x400>;
+		interrupts = <0 174 4>, <0 175 4>, <0 190 4>, <0 191 4>;
+		cache-unified;
+		cache-size = <(1280 * 1024)>;
+		cache-sets = <512>;
+		cache-line-size = <128>;
+		cache-level = <2>;
+	};
 
-		/* chip-internal connection for STM */
-		i2c5: i2c at 58785000 {
-			compatible = "socionext,uniphier-fi2c";
-			reg = <0x58785000 0x80>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			interrupts = <0 25 4>;
-			clocks = <&i2c_clk>;
-			clock-frequency = <400000>;
-		};
+	i2c0: i2c at 58780000 {
+		compatible = "socionext,uniphier-fi2c";
+		status = "disabled";
+		reg = <0x58780000 0x80>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupts = <0 41 4>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i2c0>;
+		clocks = <&i2c_clk>;
+		clock-frequency = <100000>;
+	};
 
-		/* chip-internal connection for HDMI */
-		i2c6: i2c at 58786000 {
-			compatible = "socionext,uniphier-fi2c";
-			reg = <0x58786000 0x80>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			interrupts = <0 26 4>;
-			clocks = <&i2c_clk>;
-			clock-frequency = <400000>;
-		};
+	i2c1: i2c at 58781000 {
+		compatible = "socionext,uniphier-fi2c";
+		status = "disabled";
+		reg = <0x58781000 0x80>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupts = <0 42 4>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i2c1>;
+		clocks = <&i2c_clk>;
+		clock-frequency = <100000>;
+	};
 
-		system-bus-controller at 58c00000 {
-			compatible = "socionext,uniphier-system-bus-controller";
-			reg = <0x58c00000 0x400>, <0x59800000 0x2000>;
-		};
+	i2c2: i2c at 58782000 {
+		compatible = "socionext,uniphier-fi2c";
+		status = "disabled";
+		reg = <0x58782000 0x80>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i2c2>;
+		interrupts = <0 43 4>;
+		clocks = <&i2c_clk>;
+		clock-frequency = <100000>;
+	};
 
-		pinctrl: pinctrl at 5f801000 {
-			compatible = "socionext,proxstream2-pinctrl", "syscon";
-			reg = <0x5f801000 0xe00>;
-		};
+	i2c3: i2c at 58783000 {
+		compatible = "socionext,uniphier-fi2c";
+		status = "disabled";
+		reg = <0x58783000 0x80>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupts = <0 44 4>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i2c3>;
+		clocks = <&i2c_clk>;
+		clock-frequency = <100000>;
+	};
 
-		timer at 60000200 {
-			compatible = "arm,cortex-a9-global-timer";
-			reg = <0x60000200 0x20>;
-			interrupts = <1 11 0xf04>;
-			clocks = <&arm_timer_clk>;
-		};
+	/* chip-internal connection for DMD */
+	i2c4: i2c at 58784000 {
+		compatible = "socionext,uniphier-fi2c";
+		reg = <0x58784000 0x80>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupts = <0 45 4>;
+		clocks = <&i2c_clk>;
+		clock-frequency = <400000>;
+	};
 
-		timer at 60000600 {
-			compatible = "arm,cortex-a9-twd-timer";
-			reg = <0x60000600 0x20>;
-			interrupts = <1 13 0xf04>;
-			clocks = <&arm_timer_clk>;
-		};
+	/* chip-internal connection for STM */
+	i2c5: i2c at 58785000 {
+		compatible = "socionext,uniphier-fi2c";
+		reg = <0x58785000 0x80>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupts = <0 25 4>;
+		clocks = <&i2c_clk>;
+		clock-frequency = <400000>;
+	};
 
-		intc: interrupt-controller at 60001000 {
-			compatible = "arm,cortex-a9-gic";
-			#interrupt-cells = <3>;
-			interrupt-controller;
-			reg = <0x60001000 0x1000>,
-			      <0x60000100 0x100>;
-		};
+	/* chip-internal connection for HDMI */
+	i2c6: i2c at 58786000 {
+		compatible = "socionext,uniphier-fi2c";
+		reg = <0x58786000 0x80>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupts = <0 26 4>;
+		clocks = <&i2c_clk>;
+		clock-frequency = <400000>;
 	};
 };
 
-/include/ "uniphier-pinctrl.dtsi"
+&pinctrl {
+	compatible = "socionext,proxstream2-pinctrl", "syscon";
+};
-- 
1.9.1
