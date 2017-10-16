From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Mon, 16 Oct 2017 06:01:46 +0200
Subject: [PATCH 1/5] arm64: dts: realtek: Factor out common RTD129x parts
In-Reply-To: <20171016040150.23400-1-afaerber@suse.de>
References: <20171016040150.23400-1-afaerber@suse.de>
Message-ID: <20171016040150.23400-2-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Prepares for RTD1293 and RTD1296.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm64/boot/dts/realtek/rtd1295.dtsi | 65 ++--------------------------
 arch/arm64/boot/dts/realtek/rtd129x.dtsi | 72 ++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+), 61 deletions(-)
 create mode 100644 arch/arm64/boot/dts/realtek/rtd129x.dtsi

diff --git a/arch/arm64/boot/dts/realtek/rtd1295.dtsi b/arch/arm64/boot/dts/realtek/rtd1295.dtsi
index c8b7bb642a9a..8d9ac05d17dc 100644
--- a/arch/arm64/boot/dts/realtek/rtd1295.dtsi
+++ b/arch/arm64/boot/dts/realtek/rtd1295.dtsi
@@ -6,19 +6,10 @@
  * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
  */
 
-/memreserve/	0x0000000000000000 0x0000000000030000;
-/memreserve/	0x000000000001f000 0x0000000000001000;
-/memreserve/	0x0000000000030000 0x00000000000d0000;
-/memreserve/	0x0000000001b00000 0x00000000004be000;
-/memreserve/	0x0000000001ffe000 0x0000000000004000;
-
-#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include "rtd129x.dtsi"
 
 / {
 	compatible = "realtek,rtd1295";
-	interrupt-parent = <&gic>;
-	#address-cells = <1>;
-	#size-cells = <1>;
 
 	cpus {
 		#address-cells = <2>;
@@ -68,12 +59,6 @@
 		};
 	};
 
-	arm-pmu {
-		compatible = "arm,cortex-a53-pmu";
-		interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
-	};
-
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13
@@ -85,50 +70,8 @@
 			     <GIC_PPI 10
 			(GIC_CPU_MASK_RAW(0xf) | IRQ_TYPE_LEVEL_LOW)>;
 	};
+};
 
-	soc {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		/* Exclude up to 2 GiB of RAM */
-		ranges = <0x80000000 0x80000000 0x80000000>;
-
-		uart0: serial at 98007800 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0x98007800 0x400>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			clock-frequency = <27000000>;
-			status = "disabled";
-		};
-
-		uart1: serial at 9801b200 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0x9801b200 0x100>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			clock-frequency = <432000000>;
-			status = "disabled";
-		};
-
-		uart2: serial at 9801b400 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0x9801b400 0x100>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			clock-frequency = <432000000>;
-			status = "disabled";
-		};
-
-		gic: interrupt-controller at ff011000 {
-			compatible = "arm,gic-400";
-			reg = <0xff011000 0x1000>,
-			      <0xff012000 0x2000>,
-			      <0xff014000 0x2000>,
-			      <0xff016000 0x2000>;
-			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
-			interrupt-controller;
-			#interrupt-cells = <3>;
-		};
-	};
+&arm_pmu {
+	interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
 };
diff --git a/arch/arm64/boot/dts/realtek/rtd129x.dtsi b/arch/arm64/boot/dts/realtek/rtd129x.dtsi
new file mode 100644
index 000000000000..b9cb92466fc7
--- /dev/null
+++ b/arch/arm64/boot/dts/realtek/rtd129x.dtsi
@@ -0,0 +1,72 @@
+/*
+ * Realtek RTD1293/RTD1295/RTD1296 SoC
+ *
+ * Copyright (c) 2016-2017 Andreas F?rber
+ *
+ * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+ */
+
+/memreserve/	0x0000000000000000 0x0000000000030000;
+/memreserve/	0x000000000001f000 0x0000000000001000;
+/memreserve/	0x0000000000030000 0x00000000000d0000;
+/memreserve/	0x0000000001b00000 0x00000000004be000;
+/memreserve/	0x0000000001ffe000 0x0000000000004000;
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	interrupt-parent = <&gic>;
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	arm_pmu: arm-pmu {
+		compatible = "arm,cortex-a53-pmu";
+		interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		/* Exclude up to 2 GiB of RAM */
+		ranges = <0x80000000 0x80000000 0x80000000>;
+
+		uart0: serial at 98007800 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x98007800 0x400>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clock-frequency = <27000000>;
+			status = "disabled";
+		};
+
+		uart1: serial at 9801b200 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x9801b200 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clock-frequency = <432000000>;
+			status = "disabled";
+		};
+
+		uart2: serial at 9801b400 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x9801b400 0x100>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			clock-frequency = <432000000>;
+			status = "disabled";
+		};
+
+		gic: interrupt-controller at ff011000 {
+			compatible = "arm,gic-400";
+			reg = <0xff011000 0x1000>,
+			      <0xff012000 0x2000>,
+			      <0xff014000 0x2000>,
+			      <0xff016000 0x2000>;
+			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+			interrupt-controller;
+			#interrupt-cells = <3>;
+		};
+	};
+};
-- 
2.13.6
