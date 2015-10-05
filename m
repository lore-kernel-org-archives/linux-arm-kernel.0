From: erin.lo@mediatek.com (Erin Lo)
Date: Mon, 5 Oct 2015 14:27:49 +0800
Subject: [PATCH v2 2/2] ARM: dts: mediatek: add MT2701 basic support
In-Reply-To: <1444026469-24789-1-git-send-email-erin.lo@mediatek.com>
References: <1444026469-24789-1-git-send-email-erin.lo@mediatek.com>
Message-ID: <1444026469-24789-3-git-send-email-erin.lo@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds basic chip support for Mediatek 2701.

Signed-off-by: Erin Lo <erin.lo@mediatek.com>
---
 arch/arm/boot/dts/Makefile       |   1 +
 arch/arm/boot/dts/mt2701-evb.dts |  29 ++++++++
 arch/arm/boot/dts/mt2701.dtsi    | 146 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 176 insertions(+)
 create mode 100644 arch/arm/boot/dts/mt2701-evb.dts
 create mode 100644 arch/arm/boot/dts/mt2701.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 233159d..aec787e 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -732,6 +732,7 @@ dtb-$(CONFIG_MACH_DOVE) += \
 	dove-dove-db.dtb \
 	dove-sbc-a510.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += \
+	mt2701-evb.dtb \
 	mt6580-evbp1.dtb \
 	mt6589-aquaris5.dtb \
 	mt6592-evb.dtb \
diff --git a/arch/arm/boot/dts/mt2701-evb.dts b/arch/arm/boot/dts/mt2701-evb.dts
new file mode 100644
index 0000000..082ca88
--- /dev/null
+++ b/arch/arm/boot/dts/mt2701-evb.dts
@@ -0,0 +1,29 @@
+/*
+ * Copyright (c) 2015 MediaTek Inc.
+ * Author: Erin Lo <erin.lo@mediatek.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+/dts-v1/;
+#include "mt2701.dtsi"
+
+/ {
+	model = "MediaTek MT2701 evaluation board";
+	compatible = "mediatek,mt2701-evb", "mediatek,mt2701";
+
+	memory {
+		reg = <0 0x80000000 0 0x40000000>;
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/mt2701.dtsi b/arch/arm/boot/dts/mt2701.dtsi
new file mode 100644
index 0000000..69f240f
--- /dev/null
+++ b/arch/arm/boot/dts/mt2701.dtsi
@@ -0,0 +1,146 @@
+/*
+ * Copyright (c) 2015 MediaTek Inc.
+ * Author: Erin.Lo <erin.lo@mediatek.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include "skeleton64.dtsi"
+
+/ {
+	compatible = "mediatek,mt2701";
+	interrupt-parent = <&sysirq>;
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
+	uart_clk: dummy26m {
+		compatible = "fixed-clock";
+		clock-frequency = <26000000>;
+		#clock-cells = <0>;
+	};
+
+	timer {
+		compatible = "arm,armv7-timer";
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+	};
+
+	watchdog: watchdog at 10007000 {
+		compatible = "mediatek,mt2701-wdt",
+			     "mediatek,mt6589-wdt";
+		reg = <0 0x10007000 0 0x100>;
+	};
+
+	timer: timer at 10008000 {
+		compatible = "mediatek,mt2701-timer",
+			     "mediatek,mt6577-timer";
+		reg = <0x10008000 0x80>;
+		interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&system_clk>, <&rtc_clk>;
+		clock-names = "system-clk", "rtc-clk";
+	};
+
+	sysirq: interrupt-controller at 10200100 {
+		compatible = "mediatek,mt2701-sysirq",
+			     "mediatek,mt6577-sysirq";
+		interrupt-controller;
+		#interrupt-cells = <3>;
+		interrupt-parent = <&gic>;
+		reg = <0 0x10200100 0 0x1c>;
+	};
+
+	gic: interrupt-controller at 10211000 {
+		compatible = "arm,cortex-a7-gic";
+		interrupt-controller;
+		#interrupt-cells = <3>;
+		interrupt-parent = <&gic>;
+		reg = <0 0x10211000 0 0x1000>,
+		      <0 0x10212000 0 0x1000>,
+		      <0 0x10214000 0 0x2000>,
+		      <0 0x10216000 0 0x2000>;
+	};
+
+	uart0: serial at 11002000 {
+		compatible = "mediatek,mt2701-uart",
+			     "mediatek,mt6577-uart";
+		reg = <0 0x11002000 0 0x400>;
+		interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&uart_clk>;
+		status = "disabled";
+	};
+
+	uart1: serial at 11003000 {
+		compatible = "mediatek,mt2701-uart",
+			     "mediatek,mt6577-uart";
+		reg = <0 0x11003000 0 0x400>;
+		interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&uart_clk>;
+		status = "disabled";
+	};
+
+	uart2: serial at 11004000 {
+		compatible = "mediatek,mt2701-uart",
+			     "mediatek,mt6577-uart";
+		reg = <0 0x11004000 0 0x400>;
+		interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&uart_clk>;
+		status = "disabled";
+	};
+
+	uart3: serial at 11005000 {
+		compatible = "mediatek,mt2701-uart",
+			     "mediatek,mt6577-uart";
+		reg = <0 0x11005000 0 0x400>;
+		interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&uart_clk>;
+		status = "disabled";
+	};
+};
-- 
1.9.1
