From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Mon, 29 May 2017 20:56:02 +0800
Subject: [PATCH v2 2/4] arm64: dts: mt7622: add basic nodes to the mt7622.dtsi
 file
In-Reply-To: <cover.1496061587.git.sean.wang@mediatek.com>
References: <cover.1496061587.git.sean.wang@mediatek.com>
Message-ID: <642a22c93b491a58d62b939f740f07661da02dde.1496061587.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

add basic nodes into the mt7622.dtsi for the system
bring-up which includes ARM CPU, GIC, timer, MediaTek
UART, SYSIRQ and one reserved memory region for ATF.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt7622.dtsi | 97 ++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7622.dtsi

diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
new file mode 100644
index 0000000..3a729d9
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -0,0 +1,97 @@
+/*
+ * Copyright (c) 2017 MediaTek Inc.
+ * Author: Ming Huang <ming.huang@mediatek.com>
+ *	   Sean Wang <sean.wang@mediatek.com>
+ *
+ * SPDX-License-Identifier: (GPL-2.0 OR MIT)
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	compatible = "mediatek,mt7622";
+	interrupt-parent = <&sysirq>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu0: cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x0 0x0>;
+			enable-method = "psci";
+			clock-frequency = <1300000000>;
+		};
+
+		cpu1: cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x0 0x1>;
+			enable-method = "psci";
+			clock-frequency = <1300000000>;
+		};
+	};
+
+	psci {
+		compatible  = "arm,psci-0.2";
+		method      = "smc";
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		/* 192 KiB reserved for ARM Trusted Firmware (BL31) */
+		secmon_reserved: secmon at 43000000 {
+			reg = <0 0x43000000 0 0x30000>;
+			no-map;
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) |
+			      IRQ_TYPE_LEVEL_HIGH)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) |
+			      IRQ_TYPE_LEVEL_HIGH)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) |
+			      IRQ_TYPE_LEVEL_HIGH)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) |
+			      IRQ_TYPE_LEVEL_HIGH)>;
+	};
+
+	sysirq: interrupt-controller at 10200620 {
+		compatible = "mediatek,mt7622-sysirq",
+			     "mediatek,mt6577-sysirq";
+		interrupt-controller;
+		#interrupt-cells = <3>;
+		interrupt-parent = <&gic>;
+		reg = <0 0x10200620 0 0x20>;
+	};
+
+	gic: interrupt-controller at 10300000 {
+		compatible = "arm,gic-400";
+		interrupt-controller;
+		#interrupt-cells = <3>;
+		interrupt-parent = <&gic>;
+		reg = <0 0x10310000 0 0x1000>,
+		      <0 0x10320000 0 0x1000>,
+		      <0 0x10340000 0 0x2000>,
+		      <0 0x10360000 0 0x2000>;
+	};
+
+	uart0: serial at 11002000 {
+		compatible = "mediatek,mt7622-uart",
+			     "mediatek,mt6577-uart";
+		reg = <0 0x11002000 0 0x400>;
+		interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&uart_clk>;
+		status = "disabled";
+	};
+};
-- 
1.9.1
