From: yingjoe.chen@mediatek.com (Joe.C)
Date: Wed, 22 Oct 2014 18:29:50 +0800
Subject: [PATCH v4 1/8] ARM: mediatek: Add basic support for mt8127
In-Reply-To: <1413973797-17619-1-git-send-email-yingjoe.chen@mediatek.com>
References: <1413973797-17619-1-git-send-email-yingjoe.chen@mediatek.com>
Message-ID: <1413973797-17619-2-git-send-email-yingjoe.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Joe.C" <yingjoe.chen@mediatek.com>

This adds a basic dtsi for MT8127 SoC.

Signed-off-by: Joe.C <yingjoe.chen@mediatek.com>
---
 arch/arm/boot/dts/mt8127.dtsi     | 93 +++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-mediatek/mediatek.c |  1 +
 2 files changed, 94 insertions(+)
 create mode 100644 arch/arm/boot/dts/mt8127.dtsi

diff --git a/arch/arm/boot/dts/mt8127.dtsi b/arch/arm/boot/dts/mt8127.dtsi
new file mode 100644
index 0000000..25c9f69
--- /dev/null
+++ b/arch/arm/boot/dts/mt8127.dtsi
@@ -0,0 +1,93 @@
+/*
+ * Copyright (c) 2014 MediaTek Inc.
+ * Author: Joe.C <yingjoe.chen@mediatek.com>
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
+	compatible = "mediatek,mt8127";
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
+
+	};
+
+	clocks {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		compatible = "simple-bus";
+		ranges;
+
+		system_clk: dummy13m {
+			compatible = "fixed-clock";
+			clock-frequency = <13000000>;
+			#clock-cells = <0>;
+		};
+
+		rtc_clk: dummy32k {
+			compatible = "fixed-clock";
+			clock-frequency = <32000>;
+			#clock-cells = <0>;
+		};
+	};
+
+	soc {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		compatible = "simple-bus";
+		ranges;
+
+		timer: timer at 10008000 {
+			compatible = "mediatek,mt8127-timer", "mediatek,mt6577-timer";
+			reg = <0 0x10008000 0 0x80>;
+			interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&system_clk>, <&rtc_clk>;
+			clock-names = "system-clk", "rtc-clk";
+		};
+
+		gic: interrupt-controller at 10211000 {
+			compatible = "arm,cortex-a7-gic";
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			reg = <0 0x10211000 0 0x1000>,
+			      <0 0x10212000 0 0x1000>,
+			      <0 0x10214000 0 0x2000>,
+			      <0 0x10216000 0 0x2000>;
+		};
+	};
+};
diff --git a/arch/arm/mach-mediatek/mediatek.c b/arch/arm/mach-mediatek/mediatek.c
index f2acf07..7f478ce 100644
--- a/arch/arm/mach-mediatek/mediatek.c
+++ b/arch/arm/mach-mediatek/mediatek.c
@@ -19,6 +19,7 @@
 
 static const char * const mediatek_board_dt_compat[] = {
 	"mediatek,mt6589",
+	"mediatek,mt8127",
 	NULL,
 };
 
-- 
1.8.1.1.dirty
