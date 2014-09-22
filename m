From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Mon, 22 Sep 2014 10:17:05 +0530
Subject: [PATCH v5 5/8] arm64: dts: Add initial device tree support for EXYNOS7
In-Reply-To: <1411361228-18279-1-git-send-email-a.kesavan@samsung.com>
References: <1411361228-18279-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <1411361228-18279-6-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Naveen Krishna Ch <naveenkrishna.ch@gmail.com>

Add initial device tree nodes for EXYNOS7 SoC and board dts file
to support Espresso board based on Exynos7 SoC.

Signed-off-by: Naveen Krishna Ch <naveenkrishna.ch@gmail.com>
Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
Reviewed-by: Thomas Abraham <thomas.ab@samsung.com>
Tested-by: Thomas Abraham <thomas.ab@samsung.com>
Acked-by: Kukjin Kim <kgene.kim@samsung.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/boot/dts/Makefile                    |   1 +
 arch/arm64/boot/dts/exynos/Makefile             |   5 +
 arch/arm64/boot/dts/exynos/exynos7-espresso.dts |  39 +++++
 arch/arm64/boot/dts/exynos/exynos7.dtsi         | 183 ++++++++++++++++++++++++
 4 files changed, 228 insertions(+)
 create mode 100644 arch/arm64/boot/dts/exynos/Makefile
 create mode 100644 arch/arm64/boot/dts/exynos/exynos7-espresso.dts
 create mode 100644 arch/arm64/boot/dts/exynos/exynos7.dtsi

diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index 309c3dc..b13bf21 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -1,5 +1,6 @@
 dts-dirs += apm
 dts-dirs += arm
+dts-dirs += exynos
 
 always		:= $(dtb-y)
 subdir-y	:= $(dts-dirs)
diff --git a/arch/arm64/boot/dts/exynos/Makefile b/arch/arm64/boot/dts/exynos/Makefile
new file mode 100644
index 0000000..20310e5
--- /dev/null
+++ b/arch/arm64/boot/dts/exynos/Makefile
@@ -0,0 +1,5 @@
+dtb-$(CONFIG_ARCH_EXYNOS7) += exynos7-espresso.dtb
+
+always		:= $(dtb-y)
+subdir-y	:= $(dts-dirs)
+clean-files	:= *.dtb
diff --git a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
new file mode 100644
index 0000000..e2c8283
--- /dev/null
+++ b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
@@ -0,0 +1,39 @@
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
+	aliases {
+		serial0 = &serial_2;
+	};
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
index 0000000..a326fbf
--- /dev/null
+++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
@@ -0,0 +1,183 @@
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
+			clocks = <&fin_pll>, <&clock_topc DOUT_SCLK_BUS0_PLL>,
+				 <&clock_topc DOUT_SCLK_BUS1_PLL>,
+				 <&clock_topc DOUT_SCLK_CC_PLL>,
+				 <&clock_topc DOUT_SCLK_MFC_PLL>;
+			clock-names = "fin_pll", "dout_sclk_bus0_pll",
+				      "dout_sclk_bus1_pll", "dout_sclk_cc_pll",
+				      "dout_sclk_mfc_pll";
+		};
+
+		clock_peric0: clock-controller at 13610000 {
+			compatible = "samsung,exynos7-clock-peric0";
+			reg = <0x13610000 0xd00>;
+			#clock-cells = <1>;
+			clocks = <&fin_pll>, <&clock_top0 DOUT_ACLK_PERIC0>,
+				 <&clock_top0 CLK_SCLK_UART0>;
+			clock-names = "fin_pll", "dout_aclk_peric0_66",
+				      "sclk_uart0";
+		};
+
+		clock_peric1: clock-controller at 14C80000 {
+			compatible = "samsung,exynos7-clock-peric1";
+			reg = <0x14c80000 0xd00>;
+			#clock-cells = <1>;
+			clocks = <&fin_pll>, <&clock_top0 DOUT_ACLK_PERIC1>,
+				 <&clock_top0 CLK_SCLK_UART1>,
+				 <&clock_top0 CLK_SCLK_UART2>,
+				 <&clock_top0 CLK_SCLK_UART3>;
+			clock-names = "fin_pll", "dout_aclk_peric1_66",
+				      "sclk_uart1", "sclk_uart2", "sclk_uart3";
+		};
+
+		clock_peris: clock-controller at 10040000 {
+			compatible = "samsung,exynos7-clock-peris";
+			reg = <0x10040000 0xd00>;
+			#clock-cells = <1>;
+			clocks = <&fin_pll>, <&clock_topc DOUT_ACLK_PERIS>;
+			clock-names = "fin_pll", "dout_aclk_peris_66";
+		};
+
+		serial_0: serial at 13630000 {
+			compatible = "samsung,exynos4210-uart";
+			reg = <0x13630000 0x100>;
+			interrupts = <0 440 0>;
+			clocks = <&clock_peric0 PCLK_UART0>,
+				 <&clock_peric0 SCLK_UART0>;
+			clock-names = "uart", "clk_uart_baud0";
+			status = "disabled";
+		};
+
+		serial_1: serial at 14c20000 {
+			compatible = "samsung,exynos4210-uart";
+			reg = <0x14c20000 0x100>;
+			interrupts = <0 456 0>;
+			clocks = <&clock_peric1 PCLK_UART1>,
+				 <&clock_peric1 SCLK_UART1>;
+			clock-names = "uart", "clk_uart_baud0";
+			status = "disabled";
+		};
+
+		serial_2: serial at 14c30000 {
+			compatible = "samsung,exynos4210-uart";
+			reg = <0x14c30000 0x100>;
+			interrupts = <0 457 0>;
+			clocks = <&clock_peric1 PCLK_UART2>,
+				 <&clock_peric1 SCLK_UART2>;
+			clock-names = "uart", "clk_uart_baud0";
+			status = "disabled";
+		};
+
+		serial_3: serial at 14c40000 {
+			compatible = "samsung,exynos4210-uart";
+			reg = <0x14c40000 0x100>;
+			interrupts = <0 458 0>;
+			clocks = <&clock_peric1 PCLK_UART3>,
+				 <&clock_peric1 SCLK_UART3>;
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
2.1.0
