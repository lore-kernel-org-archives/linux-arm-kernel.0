From: ch.naveen@samsung.com (Naveen Krishna Chatradhi)
Date: Thu, 11 Sep 2014 15:50:49 +0530
Subject: [PATCH v3 5/8] arm64: dts: Add initial device tree support for EXYNOS7
In-Reply-To: <1410430852-3491-1-git-send-email-ch.naveen@samsung.com>
References: <1410430852-3491-1-git-send-email-ch.naveen@samsung.com>
Message-ID: <1410430852-3491-6-git-send-email-ch.naveen@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add initial device tree nodes for EXYNOS7 SoC and board dts file
to support Espresso board based on Exynos7 SoC.

Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/boot/dts/Makefile                    |    1 +
 arch/arm64/boot/dts/exynos/exynos7-espresso.dts |   35 +++++
 arch/arm64/boot/dts/exynos/exynos7.dtsi         |  167 +++++++++++++++++++++++
 3 files changed, 203 insertions(+)
 create mode 100644 arch/arm64/boot/dts/exynos/exynos7-espresso.dts
 create mode 100644 arch/arm64/boot/dts/exynos/exynos7.dtsi

diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index c52bdb0..a3bc18a 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -1,3 +1,4 @@
+dtb-$(CONFIG_ARCH_EXYNOS7) += exynos/exynos7-espresso.dtb
 dtb-$(CONFIG_ARCH_VEXPRESS) += rtsm_ve-aemv8a.dtb foundation-v8.dtb
 dtb-$(CONFIG_ARCH_XGENE) += apm-mustang.dtb
 
diff --git a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
new file mode 100644
index 0000000..4f69991
--- /dev/null
+++ b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
@@ -0,0 +1,35 @@
+/*
+ * SAMSUNG Exynos7 Espresso board device tree source
+ *
+ * Copyright (c) 2014 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+/dts-v1/;
+#include "exynos7.dtsi"
+
+/ {
+	model = "Samsung Exynos7 Espresso board based on EXYNOS7";
+	compatible = "samsung,exynos7-espresso", "samsung,exynos7";
+
+	chosen {
+		linux,stdout-path = &serial_2;
+	};
+
+	memory at 40000000 {
+		device_type = "memory";
+		reg = <0x0 0x40000000 0x0 0xC0000000>;
+	};
+};
+
+&fin_pll {
+	clock-frequency = <24000000>;
+};
+
+&serial_2 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/exynos/exynos7.dtsi b/arch/arm64/boot/dts/exynos/exynos7.dtsi
new file mode 100644
index 0000000..56ec5f4
--- /dev/null
+++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
@@ -0,0 +1,167 @@
+/*
+ * SAMSUNG EXYNOS7 SoC device tree source
+ *
+ * Copyright (c) 2014 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <dt-bindings/clock/exynos7-clk.h>
+
+/ {
+	compatible = "samsung,exynos7";
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	aliases {
+		serial0 = &serial_0;
+		serial1 = &serial_1;
+		serial2 = &serial_2;
+		serial3 = &serial_3;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a57", "arm,armv8";
+			enable-method = "psci";
+			reg = <0x0>;
+		};
+
+		cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a57", "arm,armv8";
+			enable-method = "psci";
+			reg = <0x1>;
+		};
+
+		cpu at 2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a57", "arm,armv8";
+			enable-method = "psci";
+			reg = <0x2>;
+		};
+
+		cpu at 3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a57", "arm,armv8";
+			enable-method = "psci";
+			reg = <0x3>;
+		};
+	};
+
+	psci {
+		compatible = "arm,psci-0.2";
+		method = "smc";
+	};
+
+	soc: soc {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0 0 0x18000000>;
+
+		chipid at 10000000 {
+			compatible = "samsung,exynos4210-chipid";
+			reg = <0x10000000 0x100>;
+		};
+
+		fin_pll: xxti {
+			compatible = "fixed-clock";
+			clock-output-names = "fin_pll";
+			#clock-cells = <0>;
+		};
+
+		gic: interrupt-controller at 11001000 {
+			compatible = "arm,gic-400";
+			#interrupt-cells = <3>;
+			#address-cells = <0>;
+			interrupt-controller;
+			reg =	<0x11001000 0x1000>,
+				<0x11002000 0x1000>,
+				<0x11004000 0x2000>,
+				<0x11006000 0x2000>;
+		};
+
+		clock_topc: clock-controller at 10570000 {
+			compatible = "samsung,exynos7-clock-topc";
+			reg = <0x10570000 0x10000>;
+			#clock-cells = <1>;
+		};
+
+		clock_top0: clock-controller at 105d0000 {
+			compatible = "samsung,exynos7-clock-top0";
+			reg = <0x105d0000 0xb000>;
+			#clock-cells = <1>;
+		};
+
+		clock_peric0: clock-controller at 13610000 {
+			compatible = "samsung,exynos7-clock-peric0";
+			reg = <0x13610000 0xd00>;
+			#clock-cells = <1>;
+		};
+
+		clock_peric1: clock-controller at 14C80000 {
+			compatible = "samsung,exynos7-clock-peric1";
+			reg = <0x14c80000 0xd00>;
+			#clock-cells = <1>;
+		};
+
+		clock_peris: clock-controller at 10040000 {
+			compatible = "samsung,exynos7-clock-peris";
+			reg = <0x10040000 0xd00>;
+			#clock-cells = <1>;
+		};
+
+		serial_0: serial at 13630000 {
+			compatible = "samsung,exynos4210-uart";
+			reg = <0x13630000 0x100>;
+			interrupts = <0 440 0>;
+			clocks = <&clock_peric0 PCLK_UART0>, <&clock_peric0 SCLK_UART0>;
+			clock-names = "uart", "clk_uart_baud0";
+			status = "disabled";
+		};
+
+		serial_1: serial at 14c20000 {
+			compatible = "samsung,exynos4210-uart";
+			reg = <0x14c20000 0x100>;
+			interrupts = <0 456 0>;
+			clocks = <&clock_peric1 PCLK_UART1>, <&clock_peric1 SCLK_UART1>;
+			clock-names = "uart", "clk_uart_baud0";
+			status = "disabled";
+		};
+
+		serial_2: serial at 14c30000 {
+			compatible = "samsung,exynos4210-uart";
+			reg = <0x14c30000 0x100>;
+			interrupts = <0 457 0>;
+			clocks = <&clock_peric1 PCLK_UART2>, <&clock_peric1 SCLK_UART2>;
+			clock-names = "uart", "clk_uart_baud0";
+			status = "disabled";
+		};
+
+		serial_3: serial at 14c40000 {
+			compatible = "samsung,exynos4210-uart";
+			reg = <0x14c40000 0x100>;
+			interrupts = <0 458 0>;
+			clocks = <&clock_peric1 PCLK_UART3>, <&clock_peric1 SCLK_UART3>;
+			clock-names = "uart", "clk_uart_baud0";
+			status = "disabled";
+		};
+
+		timer {
+			compatible = "arm,armv8-timer";
+			interrupts = <1 13 0xff01>,
+				     <1 14 0xff01>,
+				     <1 11 0xff01>,
+				     <1 10 0xff01>;
+		};
+	};
+};
-- 
1.7.9.5
