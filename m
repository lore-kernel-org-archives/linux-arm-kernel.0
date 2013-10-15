From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Tue, 15 Oct 2013 12:59:34 +0200
Subject: [PATCH 1/5] ARM: rockchip: move shared dt properties to common source
 file
In-Reply-To: <201310151258.53435.heiko@sntech.de>
References: <201310151258.53435.heiko@sntech.de>
Message-ID: <201310151259.34314.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rk3188 SoC shares a lot of peripherals with the rk3066 SoC,
but not all. Therefore move the common parts to a shared dtsi.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3066a.dtsi |   98 +--------------------------------
 arch/arm/boot/dts/rk3xxx.dtsi  |  117 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 118 insertions(+), 97 deletions(-)
 create mode 100644 arch/arm/boot/dts/rk3xxx.dtsi

diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index 56bfac9..2218c64 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -14,15 +14,12 @@
  */
 
 #include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/interrupt-controller/irq.h>
-#include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/pinctrl/rockchip.h>
-#include "skeleton.dtsi"
+#include "rk3xxx.dtsi"
 #include "rk3066a-clocks.dtsi"
 
 / {
 	compatible = "rockchip,rk3066a";
-	interrupt-parent = <&gic>;
 
 	cpus {
 		#address-cells = <1>;
@@ -43,33 +40,6 @@
 	};
 
 	soc {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "simple-bus";
-		ranges;
-
-		gic: interrupt-controller at 1013d000 {
-			compatible = "arm,cortex-a9-gic";
-			interrupt-controller;
-			#interrupt-cells = <3>;
-			reg = <0x1013d000 0x1000>,
-			      <0x1013c100 0x0100>;
-		};
-
-		L2: l2-cache-controller at 10138000 {
-			compatible = "arm,pl310-cache";
-			reg = <0x10138000 0x1000>;
-			cache-unified;
-			cache-level = <2>;
-		};
-
-		local-timer at 1013c600 {
-			compatible = "arm,cortex-a9-twd-timer";
-			reg = <0x1013c600 0x20>;
-			interrupts = <GIC_PPI 13 0x304>;
-			clocks = <&dummy150m>;
-		};
-
 		timer at 20038000 {
 			compatible = "snps,dw-apb-timer-osc";
 			reg = <0x20038000 0x100>;
@@ -320,71 +290,5 @@
 				};
 			};
 		};
-
-		uart0: serial at 10124000 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0x10124000 0x400>;
-			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
-			reg-shift = <2>;
-			reg-io-width = <1>;
-			clocks = <&clk_gates1 8>;
-			status = "disabled";
-		};
-
-		uart1: serial at 10126000 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0x10126000 0x400>;
-			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
-			reg-shift = <2>;
-			reg-io-width = <1>;
-			clocks = <&clk_gates1 10>;
-			status = "disabled";
-		};
-
-		uart2: serial at 20064000 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0x20064000 0x400>;
-			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
-			reg-shift = <2>;
-			reg-io-width = <1>;
-			clocks = <&clk_gates1 12>;
-			status = "disabled";
-		};
-
-		uart3: serial at 20068000 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0x20068000 0x400>;
-			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
-			reg-shift = <2>;
-			reg-io-width = <1>;
-			clocks = <&clk_gates1 14>;
-			status = "disabled";
-		};
-
-		dwmmc at 10214000 {
-			compatible = "rockchip,rk2928-dw-mshc";
-			reg = <0x10214000 0x1000>;
-			interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			clocks = <&clk_gates5 10>, <&clk_gates2 11>;
-			clock-names = "biu", "ciu";
-
-			status = "disabled";
-		};
-
-		dwmmc at 10218000 {
-			compatible = "rockchip,rk2928-dw-mshc";
-			reg = <0x10218000 0x1000>;
-			interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			clocks = <&clk_gates5 11>, <&clk_gates2 13>;
-			clock-names = "biu", "ciu";
-
-			status = "disabled";
-		};
 	};
 };
diff --git a/arch/arm/boot/dts/rk3xxx.dtsi b/arch/arm/boot/dts/rk3xxx.dtsi
new file mode 100644
index 0000000..fd3e476
--- /dev/null
+++ b/arch/arm/boot/dts/rk3xxx.dtsi
@@ -0,0 +1,117 @@
+/*
+ * Copyright (c) 2013 MundoReader S.L.
+ * Author: Heiko Stuebner <heiko@sntech.de>
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
+	interrupt-parent = <&gic>;
+
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		ranges;
+
+		gic: interrupt-controller at 1013d000 {
+			compatible = "arm,cortex-a9-gic";
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			reg = <0x1013d000 0x1000>,
+			      <0x1013c100 0x0100>;
+		};
+
+		L2: l2-cache-controller at 10138000 {
+			compatible = "arm,pl310-cache";
+			reg = <0x10138000 0x1000>;
+			cache-unified;
+			cache-level = <2>;
+		};
+
+		local-timer at 1013c600 {
+			compatible = "arm,cortex-a9-twd-timer";
+			reg = <0x1013c600 0x20>;
+			interrupts = <GIC_PPI 13 0x304>;
+			clocks = <&dummy150m>;
+		};
+
+		uart0: serial at 10124000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x10124000 0x400>;
+			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+			reg-shift = <2>;
+			reg-io-width = <1>;
+			clocks = <&clk_gates1 8>;
+			status = "disabled";
+		};
+
+		uart1: serial at 10126000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x10126000 0x400>;
+			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+			reg-shift = <2>;
+			reg-io-width = <1>;
+			clocks = <&clk_gates1 10>;
+			status = "disabled";
+		};
+
+		uart2: serial at 20064000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x20064000 0x400>;
+			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
+			reg-shift = <2>;
+			reg-io-width = <1>;
+			clocks = <&clk_gates1 12>;
+			status = "disabled";
+		};
+
+		uart3: serial at 20068000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x20068000 0x400>;
+			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+			reg-shift = <2>;
+			reg-io-width = <1>;
+			clocks = <&clk_gates1 14>;
+			status = "disabled";
+		};
+
+		dwmmc at 10214000 {
+			compatible = "rockchip,rk2928-dw-mshc";
+			reg = <0x10214000 0x1000>;
+			interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			clocks = <&clk_gates5 10>, <&clk_gates2 11>;
+			clock-names = "biu", "ciu";
+
+			status = "disabled";
+		};
+
+		dwmmc at 10218000 {
+			compatible = "rockchip,rk2928-dw-mshc";
+			reg = <0x10218000 0x1000>;
+			interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			clocks = <&clk_gates5 11>, <&clk_gates2 13>;
+			clock-names = "biu", "ciu";
+
+			status = "disabled";
+		};
+	};
+};
-- 
1.7.10.4
