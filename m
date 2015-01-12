From: eddie.huang@mediatek.com (Eddie Huang)
Date: Mon, 12 Jan 2015 17:14:32 +0800
Subject: [PATCH v4 3/4] arm64: dts: Add mediatek MT8173 SoC and evaluation
 board dts and Makefile
In-Reply-To: <1421054073-43468-1-git-send-email-eddie.huang@mediatek.com>
References: <1421054073-43468-1-git-send-email-eddie.huang@mediatek.com>
Message-ID: <1421054073-43468-4-git-send-email-eddie.huang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree support for MT8173 SoC and evaluation board based on it.

Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
---
 arch/arm64/boot/dts/Makefile                |   1 +
 arch/arm64/boot/dts/mediatek/Makefile       |   5 +
 arch/arm64/boot/dts/mediatek/mt8173-evb.dts |  38 +++++++
 arch/arm64/boot/dts/mediatek/mt8173.dtsi    | 168 ++++++++++++++++++++++++++++
 4 files changed, 212 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/Makefile
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8173-evb.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8173.dtsi

diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index 3b8d427..89124e4 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -2,6 +2,7 @@ dts-dirs += amd
 dts-dirs += apm
 dts-dirs += arm
 dts-dirs += cavium
+dts-dirs += mediatek
 
 always		:= $(dtb-y)
 subdir-y	:= $(dts-dirs)
diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
new file mode 100644
index 0000000..3ce2462
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -0,0 +1,5 @@
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-evb.dtb
+
+always		:= $(dtb-y)
+subdir-y	:= $(dts-dirs)
+clean-files	:= *.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
new file mode 100644
index 0000000..43d5401
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
@@ -0,0 +1,38 @@
+/*
+ * Copyright (c) 2014 MediaTek Inc.
+ * Author: Eddie Huang <eddie.huang@mediatek.com>
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
+#include "mt8173.dtsi"
+
+/ {
+	model = "mediatek,mt8173-evb";
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
+	};
+
+	memory at 40000000 {
+		device_type = "memory";
+		reg = <0 0x40000000 0 0x80000000>;
+	};
+
+	chosen { };
+};
+
+&uart0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
new file mode 100644
index 0000000..8554ec3
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -0,0 +1,168 @@
+/*
+ * Copyright (c) 2014 MediaTek Inc.
+ * Author: Eddie Huang <eddie.huang@mediatek.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	compatible = "mediatek,mt8173";
+	interrupt-parent = <&sysirq>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&cpu0>;
+				};
+				core1 {
+					cpu = <&cpu1>;
+				};
+			};
+
+			cluster1 {
+				core0 {
+					cpu = <&cpu2>;
+				};
+				core1 {
+					cpu = <&cpu3>;
+				};
+			};
+		};
+
+		cpu0: cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x000>;
+		};
+
+		cpu1: cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0x001>;
+			enable-method = "psci";
+		};
+
+		cpu2: cpu at 100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a57";
+			reg = <0x100>;
+			enable-method = "psci";
+		};
+
+		cpu3: cpu at 101 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a57";
+			reg = <0x101>;
+			enable-method = "psci";
+		};
+	};
+
+	psci {
+		compatible = "arm,psci";
+		method = "smc";
+		cpu_suspend   = <0x84000001>;
+		cpu_off	      = <0x84000002>;
+		cpu_on	      = <0x84000003>;
+	};
+
+	uart_clk: dummy26m {
+		compatible = "fixed-clock";
+		clock-frequency = <26000000>;
+		#clock-cells = <0>;
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_PPI 13
+			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14
+			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11
+			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10
+			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+	};
+
+	soc {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		compatible = "simple-bus";
+		ranges;
+
+		sysirq: intpol-controller at 10200620 {
+			compatible = "mediatek,mt8173-sysirq",
+					"mediatek,mt6577-sysirq";
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			interrupt-parent = <&gic>;
+			reg = <0 0x10200620 0 0x20>;
+		};
+
+		gic: interrupt-controller at 10220000 {
+			compatible = "arm,gic-400";
+			#interrupt-cells = <3>;
+			interrupt-parent = <&gic>;
+			interrupt-controller;
+			reg = <0 0x10221000 0 0x1000>,
+			      <0 0x10222000 0 0x2000>,
+			      <0 0x10224000 0 0x2000>,
+			      <0 0x10226000 0 0x2000>;
+			interrupts = <GIC_PPI 9
+				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+		};
+
+		uart0: serial at 11002000 {
+			compatible = "mediatek,mt8173-uart",
+					"mediatek,mt6577-uart";
+			reg = <0 0x11002000 0 0x400>;
+			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&uart_clk>;
+			status = "disabled";
+		};
+
+		uart1: serial at 11003000 {
+			compatible = "mediatek,mt8173-uart",
+					"mediatek,mt6577-uart";
+			reg = <0 0x11003000 0 0x400>;
+			interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&uart_clk>;
+			status = "disabled";
+		};
+
+		uart2: serial at 11004000 {
+			compatible = "mediatek,mt8173-uart",
+					"mediatek,mt6577-uart";
+			reg = <0 0x11004000 0 0x400>;
+			interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&uart_clk>;
+			status = "disabled";
+		};
+
+		uart3: serial at 11005000 {
+			compatible = "mediatek,mt8173-uart",
+					"mediatek,mt6577-uart";
+			reg = <0 0x11005000 0 0x400>;
+			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&uart_clk>;
+			status = "disabled";
+		};
+	};
+
+};
+
-- 
1.8.1.1.dirty
