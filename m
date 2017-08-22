From: brendanhiggins@google.com (Brendan Higgins)
Date: Mon, 21 Aug 2017 20:35:01 -0700
Subject: [PATCH v1 2/3] arm: dts: add Nuvoton NPCM750 device tree
In-Reply-To: <20170822033502.4100-1-brendanhiggins@google.com>
References: <20170822033502.4100-1-brendanhiggins@google.com>
Message-ID: <20170822033502.4100-3-brendanhiggins@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a common device tree for all Nuvoton NPCM750 BMCs and a board
specific device tree for the NPCM750 (Poleg) evaluation board.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 .../devicetree/bindings/arm/npcm/npcm.txt          |   6 +
 arch/arm/boot/dts/nuvoton-npcm750-evb.dts          |  63 ++++++
 arch/arm/boot/dts/nuvoton-npcm750.dtsi             | 222 +++++++++++++++++++++
 include/dt-bindings/clock/nuvoton,npcm7xx-clks.h   |  39 ++++
 4 files changed, 330 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/npcm/npcm.txt
 create mode 100644 arch/arm/boot/dts/nuvoton-npcm750-evb.dts
 create mode 100644 arch/arm/boot/dts/nuvoton-npcm750.dtsi
 create mode 100644 include/dt-bindings/clock/nuvoton,npcm7xx-clks.h

diff --git a/Documentation/devicetree/bindings/arm/npcm/npcm.txt b/Documentation/devicetree/bindings/arm/npcm/npcm.txt
new file mode 100644
index 000000000000..19aabe9a7414
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/npcm/npcm.txt
@@ -0,0 +1,6 @@
+NPCM Platforms Device Tree Bindings
+-----------------------------------
+NPCM750 SoC
+Required root node properties:
+	- compatible = "nuvoton,npcm750";
+	- enable-method = "nuvoton,npcm7xx-smp"; required for dual core variant.
diff --git a/arch/arm/boot/dts/nuvoton-npcm750-evb.dts b/arch/arm/boot/dts/nuvoton-npcm750-evb.dts
new file mode 100644
index 000000000000..10f523388dc1
--- /dev/null
+++ b/arch/arm/boot/dts/nuvoton-npcm750-evb.dts
@@ -0,0 +1,63 @@
+/*
+ * DTS file for all NPCM750 SoCs
+ *
+ * Copyright 2012 Tomer Maimon <tomer.maimon@nuvoton.com>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/dts-v1/;
+#include "nuvoton-npcm750.dtsi"
+
+/ {
+	model = "Nuvoton npcm750 Development Board (Device Tree)";
+	compatible = "nuvoton,npcm750";
+	enable-method = "nuvoton,npcm7xx-smp";
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
+	};
+
+	memory {
+		reg = <0 0x40000000>;
+	};
+
+	clocks {
+		clk: clock-controller at f0801000 {
+			status = "okay";
+		};
+	};
+
+	ahb {
+	};
+
+	apb {
+		watchdog1: watchdog at f0009000 {
+			status = "okay";
+		};
+
+		uart0: uart0 at f0001000 {
+			status = "okay";
+		};
+
+		uart1: uart1 at f0002000 {
+			status = "okay";
+		};
+
+		uart2: uart2 at f0003000 {
+			status = "okay";
+		};
+
+		uart3: uart3 at f0004000 {
+			status = "okay";
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/nuvoton-npcm750.dtsi b/arch/arm/boot/dts/nuvoton-npcm750.dtsi
new file mode 100644
index 000000000000..fc64550c49a6
--- /dev/null
+++ b/arch/arm/boot/dts/nuvoton-npcm750.dtsi
@@ -0,0 +1,222 @@
+/*
+ * DTSi file for the NPCM750 SoC
+ *
+ * Copyright 2012 Tomer Maimon <tomer.maimon@nuvoton.com>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include "skeleton.dtsi"
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/nuvoton,npcm7xx-clks.h>
+
+/ {
+	interrupt-parent = <&gic>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			clocks = <&clk NPCM7XX_CLK_CPU>;
+			clock-names = "clk_cpu";
+			reg = <0>;
+			next-level-cache = <&L2>;
+		};
+
+		cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			clocks = <&clk NPCM7XX_CLK_CPU>;
+			clock-names = "clk_cpu";
+			reg = <1>;
+			next-level-cache = <&L2>;
+		};
+
+	};
+
+	L2: l2-cache {
+		compatible = "arm,pl310-cache";
+		reg = <0xf03fc000 0x80000>;
+		interrupts = <0 21 4>;
+		cache-unified;
+		cache-level = <2>;
+		clocks = <&clk NPCM7XX_CLK_AXI>;
+		clock-names = "clk_axi";
+	    };
+
+	    clocks {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		clk: clock-controller at f0801000 {
+			compatible = "nuvoton,npcm750-clk";
+			#clock-cells = <1>;
+		};
+
+		/* external clock signal rg1refck, supplied by the phy */
+		clk_rg1refck: clk_rg1refck {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <125000000>;
+			clock-output-names = "clk_rg1refck";
+		};
+
+		/* external clock signal rg2refck, supplied by the phy */
+		clk_rg2refck: clk_rg2refck {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <125000000>;
+			clock-output-names = "clk_rg2refck";
+		};
+
+		clk_xin: clk_xin {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <50000000>;
+			clock-output-names = "clk_xin";
+		};
+	};
+
+	ahb {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		interrupt-parent = <&gic>;
+		ranges = <0x80000000 0x80000000 0x20000000 /* AHB18 */
+			0xa0000000 0xa0000000 0x28000000 /* AHB3  */
+			0xe0000000 0xe0000000 0x10000000 /* AHB14 */
+			0xf0000000 0xf0000000 0x00800000 /* AHB1  */
+			0xf0800000 0xf0800000 0x00800000 /* AHB8  */
+			0xf8000000 0xf8000000 0x04000000  /* AHB18 - cont */
+			0xfffd0000 0xfffd0000 0x00040000>;   /* RAM2 */
+
+		gic: interrupt-controller at f03ff000 {
+			compatible = "arm,cortex-a9-gic";
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			reg = <0xf03ff000 0x1000>,
+			    <0xf03fe100 0x100>;
+		};
+
+		gcr: gcr at f0800000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "nuvoton,npcm750-gcr", "syscon",
+				"simple-mfd";
+			reg = <0xf0800000 0x1000>;
+		};
+
+		scu: scu at f03fe000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "arm,cortex-a9-scu";
+			reg = <0xf03fe000 0x1000>;
+		};
+
+		clk_rst: clk_rst at f0801000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "nuvoton,npcm750-clk_rst", "syscon",
+				"simple-mfd";
+			reg = <0xF0801000 0x1000>;
+		};
+
+		twd: timer at f03fe600 {
+			compatible = "arm,cortex-a9-twd-timer";
+			reg = <0xf03fe600 0x20>;
+			interrupts = <1 13 0x304>;
+		};
+	};
+
+	apb {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		interrupt-parent = <&gic>;
+		ranges = <0xf0000000 0xf0000000 0x00080000
+			0xf0080000 0xf0080000 0x00080000
+			0xf0100000 0xf0100000 0x00080000
+			0xf0180000 0xf0180000 0x00080000
+			0xf0200000 0xf0200000 0x00600000>;
+
+		timer0: timer at f0000000 {
+			compatible = "nuvoton,npcm750-timer";
+			interrupts = <0 32 4>;
+			clocks = <&clk NPCM7XX_CLK_TIMER>;
+			clock-names = "clk_timer";
+		};
+
+		watchdog0: watchdog at f0008000 {
+			compatible = "nuvoton,npcm750-wdt";
+			interrupts = <0 47 4>;
+			reg = <0xf0008000 0x1000>;
+			status = "disabled";
+			clocks = <&clk NPCM7XX_CLK_TIMER>;
+			clock-names = "clk_timer";
+		};
+
+		watchdog1: watchdog at f0009000 {
+			compatible = "nuvoton,npcm750-wdt";
+			interrupts = <0 48 4>;
+			reg = <0xf0009000 0x1000>;
+			status = "disabled";
+			clocks = <&clk NPCM7XX_CLK_TIMER>;
+			clock-names = "clk_timer";
+		};
+
+		watchdog2: watchdog at f000a000 {
+			compatible = "nuvoton,npcm750-wdt";
+			interrupts = <0 49 4>;
+			reg = <0xf000a000 0x1000>;
+			status = "disabled";
+			clocks = <&clk NPCM7XX_CLK_TIMER>;
+			clock-names = "clk_timer";
+		};
+
+		uart0: uart0 at f0001000 {
+			compatible = "nuvoton,npcm750-uart";
+			reg = <0xf0001000 0x1000>;
+			clocks = <&clk NPCM7XX_CLK_UART_CORE>;
+			clock-names = "clk_uart";
+			interrupts = <0 2 4>;
+			status = "disabled";
+		};
+
+		uart1: uart1 at f0002000 {
+			compatible = "nuvoton,npcm750-uart";
+			reg = <0xf0002000 0x1000>;
+			clocks = <&clk NPCM7XX_CLK_UART_CORE>;
+			clock-names = "clk_uart";
+			interrupts = <0 3 4>;
+			status = "disabled";
+		};
+
+		uart2: uart2 at f0003000 {
+			compatible = "nuvoton,npcm750-uart";
+			reg = <0xf0003000 0x1000>;
+			clocks = <&clk NPCM7XX_CLK_UART_CORE>;
+			clock-names = "clk_uart";
+			interrupts = <0 4 4>;
+			status = "disabled";
+		};
+
+		uart3: uart3 at f0004000 {
+			compatible = "nuvoton,npcm750-uart";
+			reg = <0xf0004000 0x1000>;
+			clocks = <&clk NPCM7XX_CLK_UART_CORE>;
+			clock-names = "clk_uart";
+			interrupts = <0 5 4>;
+			status = "disabled";
+		};
+	};
+};
diff --git a/include/dt-bindings/clock/nuvoton,npcm7xx-clks.h b/include/dt-bindings/clock/nuvoton,npcm7xx-clks.h
new file mode 100644
index 000000000000..c69d3bbf7e42
--- /dev/null
+++ b/include/dt-bindings/clock/nuvoton,npcm7xx-clks.h
@@ -0,0 +1,39 @@
+/*
+ * Copyright (C) 2016 Nuvoton Technologies,  tali.perry at nuvoton.com
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ */
+
+#ifndef _DT_BINDINGS_CLK_NPCM7XX_H
+#define _DT_BINDINGS_CLK_NPCM7XX_H
+
+#define NPCM7XX_CLK_PLL0	0
+#define NPCM7XX_CLK_PLL1	1
+#define NPCM7XX_CLK_PLL2	2
+#define NPCM7XX_CLK_GFX		3
+#define NPCM7XX_CLK_APB1	4
+#define NPCM7XX_CLK_APB2	5
+#define NPCM7XX_CLK_APB3	6
+#define NPCM7XX_CLK_APB4	7
+#define NPCM7XX_CLK_APB5	8
+#define NPCM7XX_CLK_MC		9
+#define NPCM7XX_CLK_CPU		10
+#define NPCM7XX_CLK_SPI0	11
+#define NPCM7XX_CLK_SPI3	12
+#define NPCM7XX_CLK_SPIX	13
+#define NPCM7XX_CLK_UART_CORE	14
+#define NPCM7XX_CLK_TIMER	15
+#define NPCM7XX_CLK_HOST_UART	16
+#define NPCM7XX_CLK_MMC		17
+#define NPCM7XX_CLK_SDHC	18
+#define NPCM7XX_CLK_ADC		19
+#define NPCM7XX_CLK_GFX_MEM	20
+#define NPCM7XX_CLK_USB_BRIDGE	21
+#define NPCM7XX_CLK_AXI		22
+#define NPCM7XX_CLK_AHB		23
+#define NPCM7XX_CLK_EMC		24
+#define NPCM7XX_CLK_GMAC	25
+
+#endif
-- 
2.14.1.480.gb18f417b89-goog
