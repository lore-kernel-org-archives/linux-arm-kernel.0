From: icenowy@aosc.io (Icenowy Zheng)
Date: Sat, 20 Jan 2018 07:17:34 +0800
Subject: [RFC PATCH 8/9] ARM: dts: suniv: add initial DTSI file for suniv and
 F1C100s
In-Reply-To: <20180119231735.61504-1-icenowy@aosc.io>
References: <20180119231735.61504-1-icenowy@aosc.io>
Message-ID: <20180119231735.61504-9-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we have the support for suniv pin controller and CCU now, add a
initial DTSI for it.

F1C100s is one product with the suniv die, which has a 32MiB co-packaged
DDR1 DRAM chip. As there's nothing special for it, add a dummy DTSI file
for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm/boot/dts/Makefile           |   2 +
 arch/arm/boot/dts/suniv-f1c100s.dtsi |   6 ++
 arch/arm/boot/dts/suniv.dtsi         | 157 +++++++++++++++++++++++++++++++++++
 3 files changed, 165 insertions(+)
 create mode 100644 arch/arm/boot/dts/suniv-f1c100s.dtsi
 create mode 100644 arch/arm/boot/dts/suniv.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index d0381e9caf21..b877e0bf1823 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -972,6 +972,8 @@ dtb-$(CONFIG_MACH_SUN8I) += \
 dtb-$(CONFIG_MACH_SUN9I) += \
 	sun9i-a80-optimus.dtb \
 	sun9i-a80-cubieboard4.dtb
+dtb-$(CONFIG_MACH_SUNIV) += \
+	suniv-f1c100s-licheepi-nano.dtb
 dtb-$(CONFIG_ARCH_TANGO) += \
 	tango4-vantage-1172.dtb
 dtb-$(CONFIG_ARCH_TEGRA_2x_SOC) += \
diff --git a/arch/arm/boot/dts/suniv-f1c100s.dtsi b/arch/arm/boot/dts/suniv-f1c100s.dtsi
new file mode 100644
index 000000000000..f084bc8dd19b
--- /dev/null
+++ b/arch/arm/boot/dts/suniv-f1c100s.dtsi
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR X11)
+/*
+ * Copyright 2018 Icenowy Zheng <icenowy@aosc.io>
+ */
+
+#include "suniv.dtsi"
diff --git a/arch/arm/boot/dts/suniv.dtsi b/arch/arm/boot/dts/suniv.dtsi
new file mode 100644
index 000000000000..af1903237514
--- /dev/null
+++ b/arch/arm/boot/dts/suniv.dtsi
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR X11)
+/*
+ * Copyright 2018 Icenowy Zheng <icenowy@aosc.io>
+ */
+
+#include <dt-bindings/clock/suniv-ccu.h>
+#include <dt-bindings/reset/suniv-ccu.h>
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	interrupt-parent = <&intc>;
+
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		osc24M: clk-24M {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <24000000>;
+			clock-output-names = "osc24M";
+		};
+
+		osc32k: clk-32k {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <32768>;
+			clock-output-names = "osc32k";
+		};
+
+		fake100M: clk-100M {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <100000000>;
+			clock-output-names = "fake-100M";
+		};
+	};
+
+	cpus {
+		#address-cells = <0>;
+		#size-cells = <0>;
+
+		cpu {
+			compatible = "arm,arm926ej-s";
+			device_type = "cpu";
+		};
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		sram-controller at 1c00000 {
+			compatible = "allwinner,sun4i-a10-sram-controller";
+			reg = <0x01c00000 0x30>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			sram_d: sram at 10000 {
+				compatible = "mmio-sram";
+				reg = <0x00010000 0x1000>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0x00010000 0x1000>;
+
+				otg_sram: sram-section at 0 {
+					compatible = "allwinner,sun4i-a10-sram-d";
+					reg = <0x0000 0x1000>;
+					status = "disabled";
+				};
+			};
+		};
+
+		ccu: clock at 1c20000 {
+			compatible = "allwinner,suniv-ccu";
+			reg = <0x01c20000 0x400>;
+			clocks = <&osc24M>, <&osc32k>;
+			clock-names = "hosc", "losc";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
+		intc: interrupt-controller at 1c20400 {
+			compatible = "allwinner,suniv-ic";
+			reg = <0x01c20400 0x400>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		pio: pinctrl at 1c20800 {
+			compatible = "allwinner,suniv-pinctrl";
+			reg = <0x01c20800 0x400>;
+			interrupts = <38>, <39>, <40>;
+			clocks = <&ccu CLK_BUS_PIO>, <&osc24M>, <&osc32k>;
+			clock-names = "apb", "hosc", "losc";
+			gpio-controller;
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			#gpio-cells = <3>;
+
+			uart0_pins_a: uart-pins-pe {
+				pins = "PE0", "PE1";
+				function = "uart0";
+			};
+		};
+
+		timer at 1c20c00 {
+			compatible = "allwinner,suniv-timer";
+			reg = <0x01c20c00 0x90>;
+			interrupts = <13>;
+			clocks = <&osc24M>;
+		};
+
+		wdt: watchdog at 1c20ca0 {
+			compatible = "allwinner,sun6i-a31-wdt";
+			reg = <0x01c20ca0 0x20>;
+		};
+
+		uart0: serial at 1c25000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x01c25000 0x400>;
+			interrupts = <1>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&ccu CLK_BUS_UART0>;
+			resets = <&ccu RST_BUS_UART0>;
+			status = "disabled";
+		};
+
+		uart1: serial at 1c25400 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x01c25400 0x400>;
+			interrupts = <2>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&ccu CLK_BUS_UART1>;
+			resets = <&ccu RST_BUS_UART1>;
+			status = "disabled";
+		};
+
+		uart2: serial at 1c25800 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x01c25800 0x400>;
+			interrupts = <3>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clocks = <&ccu CLK_BUS_UART2>;
+			resets = <&ccu RST_BUS_UART2>;
+			status = "disabled";
+		};
+	};
+};
-- 
2.14.2
