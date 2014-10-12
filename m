From: ibanezchen@gmail.com (Howard Chen)
Date: Sun, 12 Oct 2014 23:43:22 +0800
Subject: [PATCH v2 1/3] ARM: mediatek: Add basic support for mt6592
Message-ID: <1413128604-8113-1-git-send-email-ibanezchen@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* A dtsi for boards based on Mediatek MT6592 SoCs
* Compatible string in arch/arm/mach-mediatek/mediatek.c

Signed-off-by: Howard Chen <ibanezchen@gmail.com>
---
 arch/arm/boot/dts/mt6592.dtsi     | 148 ++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-mediatek/mediatek.c |   1 +
 2 files changed, 149 insertions(+)
 create mode 100644 arch/arm/boot/dts/mt6592.dtsi

diff --git a/arch/arm/boot/dts/mt6592.dtsi b/arch/arm/boot/dts/mt6592.dtsi
new file mode 100644
index 0000000..69ff80d
--- /dev/null
+++ b/arch/arm/boot/dts/mt6592.dtsi
@@ -0,0 +1,148 @@
+/*
+ * Copyright (c) 2014 Mediatek
+ * Author: Howard Chen <ibanezchen@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include "skeleton.dtsi"
+
+/ {
+	compatible = "mediatek,mt6592";
+	interrupt-parent = <&gic>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x0>;
+		};
+		cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x1>;
+		};
+		cpu at 2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x2>;
+		};
+		cpu at 3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x3>;
+		};
+		cpu at 4 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x4>;
+		};
+		cpu at 5 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x5>;
+		};
+		cpu at 6 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x6>;
+		};
+		cpu at 7 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x7>;
+		};
+	};
+
+	system_clk: dummy13m {
+		compatible = "fixed-clock";
+		clock-frequency = <13000000>;
+		#clock-cells = <0>;
+	};
+
+	rtc_clk: dummy32k {
+		compatible = "fixed-clock";
+		clock-frequency = <32000>;
+		#clock-cells = <0>;
+	};
+
+	uart_clk: uart_clk {
+		compatible = "fixed-clock";
+		clock-frequency = <26000000>;
+		#clock-cells = <0>;
+	};
+
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		ranges;
+
+		timer: timer at 10008000 {
+			compatible = "mediatek,mt6577-timer";
+			reg = <0x10008000 0x80>;
+			interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&system_clk>, <&rtc_clk>;
+			clock-names = "system-clk", "rtc-clk";
+		};
+
+		gic: interrupt-controller at 10211000 {
+			compatible = "arm,cortex-a7-gic";
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			reg = <0x10211000 0x1000>,
+			      <0x10212000 0x1000>,
+			      <0x10214000 0x2000>,
+			      <0x10216000 0x2000>;
+		};
+
+		uart0: serial at 11002000 {
+			compatible = "mediatek,mt6592-uart";
+			reg = <0x11002000 0x400>;
+			reg-shift = <2>;
+			interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&uart_clk>;
+			status = "disabled";
+		};
+
+		uart1: serial at 11003000 {
+			compatible = "mediatek,mt6592-uart";
+			reg = <0x11003000 0x400>;
+			reg-shift = <2>;
+			interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&uart_clk>;
+			status = "disabled";
+		};
+
+		uart2: serial at 11004000 {
+			compatible = "mediatek,mt6592-uart";
+			reg = <0x11004000 0x400>;
+			reg-shift = <2>;
+			interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&uart_clk>;
+			status = "disabled";
+		};
+
+		uart3: serial at 11005000 {
+			compatible = "mediatek,mt6592-uart";
+			reg = <0x11005000 0x400>;
+			reg-shift = <2>;
+			interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&uart_clk>;
+			status = "disabled";
+		};
+	};
+};
diff --git a/arch/arm/mach-mediatek/mediatek.c b/arch/arm/mach-mediatek/mediatek.c
index f2acf07..88e4626 100644
--- a/arch/arm/mach-mediatek/mediatek.c
+++ b/arch/arm/mach-mediatek/mediatek.c
@@ -19,6 +19,7 @@
 
 static const char * const mediatek_board_dt_compat[] = {
 	"mediatek,mt6589",
+	"mediatek,mt6592",
 	NULL,
 };
 
-- 
1.9.1
