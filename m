From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Thu,  7 Nov 2013 16:41:27 +0800
Subject: [PATCH v11 2/6] ARM: dts: enable hi4511 with device tree
In-Reply-To: <1383813691-31587-1-git-send-email-haojian.zhuang@linaro.org>
References: <1383813691-31587-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1383813691-31587-3-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable Hisilicon Hi4511 development platform with device tree support.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 arch/arm/boot/dts/Makefile    |   1 +
 arch/arm/boot/dts/hi3620.dtsi | 518 +++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/hi4511.dts  | 648 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 1167 insertions(+)
 create mode 100644 arch/arm/boot/dts/hi3620.dtsi
 create mode 100644 arch/arm/boot/dts/hi4511.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index cc0f1fb..b4ec185 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -64,6 +64,7 @@ dtb-$(CONFIG_ARCH_EXYNOS) += exynos4210-origen.dtb \
 	exynos5420-smdk5420.dtb \
 	exynos5440-sd5v1.dtb \
 	exynos5440-ssdk5440.dtb
+dtb-$(CONFIG_ARCH_HI3xxx) += hi4511.dtb
 dtb-$(CONFIG_ARCH_HIGHBANK) += highbank.dtb \
 	ecx-2000.dtb
 dtb-$(CONFIG_ARCH_INTEGRATOR) += integratorap.dtb \
diff --git a/arch/arm/boot/dts/hi3620.dtsi b/arch/arm/boot/dts/hi3620.dtsi
new file mode 100644
index 0000000..b9d8679
--- /dev/null
+++ b/arch/arm/boot/dts/hi3620.dtsi
@@ -0,0 +1,518 @@
+/*
+ * Hisilicon Ltd. Hi3620 SoC
+ *
+ * Copyright (C) 2012-2013 Hisilicon Ltd.
+ * Copyright (C) 2012-2013 Linaro Ltd.
+ *
+ * Author: Haojian Zhuang <haojian.zhuang@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * publishhed by the Free Software Foundation.
+ */
+
+/include/ "skeleton.dtsi"
+
+/ {
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
+		serial4 = &uart4;
+	};
+
+	pclk: clk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <26000000>;
+		clock-output-names = "apb_pclk";
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0x0>;
+			next-level-cache = <&L2>;
+		};
+	};
+
+	amba {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "arm,amba-bus";
+		interrupt-parent = <&gic>;
+		ranges = <0 0xfc000000 0x2000000>;
+
+		L2: l2-cache {
+			compatible = "arm,pl310-cache";
+			reg = <0xfc10000 0x100000>;
+			interrupts = <0 15 4>;
+			cache-unified;
+			cache-level = <2>;
+		};
+
+		gic: interrupt-controller at 1000 {
+			compatible = "arm,cortex-a9-gic";
+			#interrupt-cells = <3>;
+			#address-cells = <0>;
+			interrupt-controller;
+			/* gic dist base, gic cpu base */
+			reg = <0x1000 0x1000>, <0x100 0x100>;
+		};
+
+		dual_timer0: dual_timer at 800000 {
+			compatible = "arm,sp804", "arm,primecell";
+			reg = <0x800000 0x1000>;
+			/* timer00 & timer01 */
+			interrupts = <0 0 4>, <0 1 4>;
+			clocks = <&pclk>;
+			clock-names = "apb_pclk";
+			status = "disabled";
+		};
+
+		dual_timer1: dual_timer at 801000 {
+			compatible = "arm,sp804", "arm,primecell";
+			reg = <0x801000 0x1000>;
+			/* timer10 & timer11 */
+			interrupts = <0 2 4>, <0 3 4>;
+			clocks = <&pclk>;
+			clock-names = "apb_pclk";
+			status = "disabled";
+		};
+
+		dual_timer2: dual_timer at a01000 {
+			compatible = "arm,sp804", "arm,primecell";
+			reg = <0xa01000 0x1000>;
+			/* timer20 & timer21 */
+			interrupts = <0 4 4>, <0 5 4>;
+			clocks = <&pclk>;
+			clock-names = "apb_pclk";
+			status = "disabled";
+		};
+
+		dual_timer3: dual_timer at a02000 {
+			compatible = "arm,sp804", "arm,primecell";
+			reg = <0xa02000 0x1000>;
+			/* timer30 & timer31 */
+			interrupts = <0 6 4>, <0 7 4>;
+			clocks = <&pclk>;
+			clock-names = "apb_pclk";
+			status = "disabled";
+		};
+
+		dual_timer4: dual_timer at a03000 {
+			compatible = "arm,sp804", "arm,primecell";
+			reg = <0xa03000 0x1000>;
+			/* timer40 & timer41 */
+			interrupts = <0 96 4>, <0 97 4>;
+			clocks = <&pclk>;
+			clock-names = "apb_pclk";
+			status = "disabled";
+		};
+
+		uart0: uart at b00000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0xb00000 0x1000>;
+			interrupts = <0 20 4>;
+			clocks = <&pclk>;
+			clock-names = "apb_pclk";
+			status = "disabled";
+		};
+
+		uart1: uart at b01000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0xb01000 0x1000>;
+			interrupts = <0 21 4>;
+			clocks = <&pclk>;
+			clock-names = "apb_pclk";
+			status = "disabled";
+		};
+
+		uart2: uart at b02000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0xb02000 0x1000>;
+			interrupts = <0 22 4>;
+			clocks = <&pclk>;
+			clock-names = "apb_pclk";
+			status = "disabled";
+		};
+
+		uart3: uart at b03000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0xb03000 0x1000>;
+			interrupts = <0 23 4>;
+			clocks = <&pclk>;
+			clock-names = "apb_pclk";
+			status = "disabled";
+		};
+
+		uart4: uart at b04000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0xb04000 0x1000>;
+			interrupts = <0 24 4>;
+			clocks = <&pclk>;
+			clock-names = "apb_pclk";
+			status = "disabled";
+		};
+
+		gpio0: gpio at 806000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x806000 0x1000>;
+			interrupts = <0 64 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <	&pmx0 2 0 1 &pmx0 3 0 1 &pmx0 4 0 1
+					&pmx0 5 0 1 &pmx0 6 1 1 &pmx0 7 2 1>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&pclk>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio1: gpio at 807000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x807000 0x1000>;
+			interrupts = <0 65 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <	&pmx0 0 3 1 &pmx0 1 3 1 &pmx0 2 3 1
+					&pmx0 3 3 1 &pmx0 4 3 1 &pmx0 5 4 1
+					&pmx0 6 5 1 &pmx0 7 6 1>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&pclk>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio2: gpio at 808000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x808000 0x1000>;
+			interrupts = <0 66 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <	&pmx0 0 7 1 &pmx0 1 8 1 &pmx0 2 9 1
+					&pmx0 3 10 1 &pmx0 4 3 1 &pmx0 5 3 1
+					&pmx0 6 3 1 &pmx0 7 3 1>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&pclk>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio3: gpio at 809000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x809000 0x1000>;
+			interrupts = <0 67 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <	&pmx0 0 3 1 &pmx0 1 3 1 &pmx0 2 3 1
+					&pmx0 3 3 1 &pmx0 4 11 1 &pmx0 5 11 1
+					&pmx0 6 11 1 &pmx0 7 11 1>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&pclk>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio4: gpio at 80a000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x80a000 0x1000>;
+			interrupts = <0 68 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <	&pmx0 0 11 1 &pmx0 1 11 1 &pmx0 2 11 1
+					&pmx0 3 11 1 &pmx0 4 12 1 &pmx0 5 12 1
+					&pmx0 6 13 1 &pmx0 7 13 1>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&pclk>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio5: gpio at 80b000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x80b000 0x1000>;
+			interrupts = <0 69 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <	&pmx0 0 14 1 &pmx0 1 15 1 &pmx0 2 16 1
+					&pmx0 3 16 1 &pmx0 4 16 1 &pmx0 5 16 1
+					&pmx0 6 16 1 &pmx0 7 16 1>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&pclk>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio6: gpio at 80c000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x80c000 0x1000>;
+			interrupts = <0 70 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <	&pmx0 0 16 1 &pmx0 1 16 1 &pmx0 2 17 1
+					&pmx0 3 17 1 &pmx0 4 18 1 &pmx0 5 18 1
+					&pmx0 6 18 1 &pmx0 7 19 1>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&pclk>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio7: gpio at 80d000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x80d000 0x1000>;
+			interrupts = <0 71 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <	&pmx0 0 19 1 &pmx0 1 20 1 &pmx0 2 21 1
+					&pmx0 3 22 1 &pmx0 4 23 1 &pmx0 5 24 1
+					&pmx0 6 25 1 &pmx0 7 26 1>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&pclk>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio8: gpio at 80e000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x80e000 0x1000>;
+			interrupts = <0 72 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <	&pmx0 0 27 1 &pmx0 1 28 1 &pmx0 2 29 1
+					&pmx0 3 30 1 &pmx0 4 31 1 &pmx0 5 32 1
+					&pmx0 6 33 1 &pmx0 7 34 1>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&pclk>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio9: gpio at 80f000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x80f000 0x1000>;
+			interrupts = <0 73 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <	&pmx0 0 35 1 &pmx0 1 36 1 &pmx0 2 37 1
+					&pmx0 3 38 1 &pmx0 4 39 1 &pmx0 5 40 1
+					&pmx0 6 41 1>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&pclk>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio10: gpio at 810000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x810000 0x1000>;
+			interrupts = <0 74 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <	&pmx0 2 43 1 &pmx0 3 44 1 &pmx0 4 45 1
+					&pmx0 5 45 1 &pmx0 6 46 1 &pmx0 7 46 1>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&pclk>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio11: gpio at 811000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x811000 0x1000>;
+			interrupts = <0 75 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <	&pmx0 0 47 1 &pmx0 1 47 1 &pmx0 2 47 1
+					&pmx0 3 47 1 &pmx0 4 47 1 &pmx0 5 48 1
+					&pmx0 6 49 1 &pmx0 7 49 1>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&pclk>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio12: gpio at 812000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x812000 0x1000>;
+			interrupts = <0 76 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <	&pmx0 0 49 1 &pmx0 1 50 1 &pmx0 2 49 1
+					&pmx0 3 49 1 &pmx0 4 51 1 &pmx0 5 51 1
+					&pmx0 6 51 1 &pmx0 7 52 1>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&pclk>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio13: gpio at 813000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x813000 0x1000>;
+			interrupts = <0 77 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <	&pmx0 0 51 1 &pmx0 1 51 1 &pmx0 2 53 1
+					&pmx0 3 53 1 &pmx0 4 53 1 &pmx0 5 54 1
+					&pmx0 6 55 1 &pmx0 7 56 1>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&pclk>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio14: gpio at 814000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x814000 0x1000>;
+			interrupts = <0 78 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <	&pmx0 0 57 1 &pmx0 1 97 1 &pmx0 2 97 1
+					&pmx0 3 58 1 &pmx0 4 59 1 &pmx0 5 60 1
+					&pmx0 6 60 1 &pmx0 7 61 1>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&pclk>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio15: gpio at 815000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x815000 0x1000>;
+			interrupts = <0 79 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <	&pmx0 0 61 1 &pmx0 1 62 1 &pmx0 2 62 1
+					&pmx0 3 63 1 &pmx0 4 63 1 &pmx0 5 64 1
+					&pmx0 6 64 1 &pmx0 7 65 1>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&pclk>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio16: gpio at 816000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x816000 0x1000>;
+			interrupts = <0 80 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <	&pmx0 0 66 1 &pmx0 1 67 1 &pmx0 2 68 1
+					&pmx0 3 69 1 &pmx0 4 70 1 &pmx0 5 71 1
+					&pmx0 6 72 1 &pmx0 7 73 1>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&pclk>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio17: gpio at 817000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x817000 0x1000>;
+			interrupts = <0 81 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <	&pmx0 0 74 1 &pmx0 1 75 1 &pmx0 2 76 1
+					&pmx0 3 77 1 &pmx0 4 78 1 &pmx0 5 79 1
+					&pmx0 6 80 1 &pmx0 7 81 1>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&pclk>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio18: gpio at 818000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x818000 0x1000>;
+			interrupts = <0 82 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <	&pmx0 0 82 1 &pmx0 1 83 1 &pmx0 2 83 1
+					&pmx0 3 84 1 &pmx0 4 84 1 &pmx0 5 85 1
+					&pmx0 6 86 1 &pmx0 7 87 1>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&pclk>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio19: gpio at 819000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x819000 0x1000>;
+			interrupts = <0 83 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <	&pmx0 0 87 1 &pmx0 1 87 1 &pmx0 2 88 1
+					&pmx0 3 88 1>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&pclk>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio20: gpio at 81a000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x81a000 0x1000>;
+			interrupts = <0 84 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <	&pmx0 0 89 1 &pmx0 1 89 1 &pmx0 2 90 1
+					&pmx0 3 90 1 &pmx0 4 91 1 &pmx0 5 92 1>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&pclk>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio21: gpio at 81b000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x81b000 0x1000>;
+			interrupts = <0 85 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <	&pmx0 3 94 1 &pmx0 7 96 1>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&pclk>;
+			clock-names = "apb_pclk";
+		};
+
+		pmx0: pinmux at 803000 {
+			compatible = "pinctrl-single";
+			reg = <0x803000 0x188>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			#gpio-range-cells = <3>;
+			ranges;
+
+			pinctrl-single,register-width = <32>;
+			pinctrl-single,function-mask = <7>;
+			/* pin base, nr pins & gpio function */
+			pinctrl-single,gpio-range = <&range 0 3 0 &range 3 9 1
+						&range 12 1 0 &range 13 29 1
+						&range 43 1 0 &range 44 49 1
+						&range 94 1 1 &range 96 2 1>;
+
+			range: gpio-range {
+				#pinctrl-single,gpio-range-cells = <3>;
+			};
+		};
+
+		pmx1: pinmux at 803800 {
+			compatible = "pinconf-single";
+			reg = <0x803800 0x2dc>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			pinctrl-single,register-width = <32>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/hi4511.dts b/arch/arm/boot/dts/hi4511.dts
new file mode 100644
index 0000000..96e69ab
--- /dev/null
+++ b/arch/arm/boot/dts/hi4511.dts
@@ -0,0 +1,648 @@
+/*
+ *  Copyright (C) 2012-2013 Linaro Ltd.
+ *  Author: Haojian Zhuang <haojian.zhuang@linaro.org>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  publishhed by the Free Software Foundation.
+ */
+
+/dts-v1/;
+/include/ "hi3620.dtsi"
+
+/ {
+	model = "Hisilicon Hi4511 Development Board";
+	compatible = "hisilicon,hi3620-hi4511";
+
+	chosen {
+		bootargs = "console=ttyAMA0,115200 root=/dev/ram0 earlyprintk";
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x40000000 0x20000000>;
+	};
+
+	amba {
+		dual_timer0: dual_timer at 800000 {
+			status = "ok";
+		};
+
+		uart0: uart at b00000 {	/* console */
+			pinctrl-names = "default", "idle";
+			pinctrl-0 = <&uart0_pmx_func &uart0_cfg_func>;
+			pinctrl-1 = <&uart0_pmx_idle &uart0_cfg_idle>;
+			status = "ok";
+		};
+
+		uart1: uart at b01000 { /* modem */
+			pinctrl-names = "default", "idle";
+			pinctrl-0 = <&uart1_pmx_func &uart1_cfg_func>;
+			pinctrl-1 = <&uart1_pmx_idle &uart1_cfg_idle>;
+			status = "ok";
+		};
+
+		uart2: uart at b02000 { /* audience */
+			pinctrl-names = "default", "idle";
+			pinctrl-0 = <&uart2_pmx_func &uart2_cfg_func>;
+			pinctrl-1 = <&uart2_pmx_idle &uart2_cfg_idle>;
+			status = "ok";
+		};
+
+		uart3: uart at b03000 {
+			pinctrl-names = "default", "idle";
+			pinctrl-0 = <&uart3_pmx_func &uart3_cfg_func>;
+			pinctrl-1 = <&uart3_pmx_idle &uart3_cfg_idle>;
+			status = "ok";
+		};
+
+		uart4: uart at b04000 {
+			pinctrl-names = "default", "idle";
+			pinctrl-0 = <&uart4_pmx_func &uart4_cfg_func>;
+			pinctrl-1 = <&uart4_pmx_idle &uart4_cfg_func>;
+			status = "ok";
+		};
+
+		pmx0: pinmux at 803000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&board_pmx_pins>;
+
+			board_pmx_pins: board_pmx_pins {
+				pinctrl-single,pins = <
+					0x008 0x0	/* GPIO -- eFUSE_DOUT */
+					0x100 0x0	/* USIM_CLK & USIM_DATA (IOMG63) */
+				>;
+			};
+			uart0_pmx_func: uart0_pmx_func {
+				pinctrl-single,pins = <
+					0x0f0 0x0
+					0x0f4 0x0	/* UART0_RX & UART0_TX */
+				>;
+			};
+			uart0_pmx_idle: uart0_pmx_idle {
+				pinctrl-single,pins = <
+					/*0x0f0 0x1*/	/* UART0_CTS & UART0_RTS */
+					0x0f4 0x1	/* UART0_RX & UART0_TX */
+				>;
+			};
+			uart1_pmx_func: uart1_pmx_func {
+				pinctrl-single,pins = <
+					0x0f8 0x0	/* UART1_CTS & UART1_RTS (IOMG61) */
+					0x0fc 0x0	/* UART1_RX & UART1_TX (IOMG62) */
+				>;
+			};
+			uart1_pmx_idle: uart1_pmx_idle {
+				pinctrl-single,pins = <
+					0x0f8 0x1	/* GPIO (IOMG61) */
+					0x0fc 0x1	/* GPIO (IOMG62) */
+				>;
+			};
+			uart2_pmx_func: uart2_pmx_func {
+				pinctrl-single,pins = <
+					0x104 0x2	/* UART2_RXD (IOMG96) */
+					0x108 0x2	/* UART2_TXD (IOMG64) */
+				>;
+			};
+			uart2_pmx_idle: uart2_pmx_idle {
+				pinctrl-single,pins = <
+					0x104 0x1	/* GPIO (IOMG96) */
+					0x108 0x1	/* GPIO (IOMG64) */
+				>;
+			};
+			uart3_pmx_func: uart3_pmx_func {
+				pinctrl-single,pins = <
+					0x160 0x2	/* UART3_CTS & UART3_RTS (IOMG85) */
+					0x164 0x2	/* UART3_RXD & UART3_TXD (IOMG86) */
+				>;
+			};
+			uart3_pmx_idle: uart3_pmx_idle {
+				pinctrl-single,pins = <
+					0x160 0x1	/* GPIO (IOMG85) */
+					0x164 0x1	/* GPIO (IOMG86) */
+				>;
+			};
+			uart4_pmx_func: uart4_pmx_func {
+				pinctrl-single,pins = <
+					0x168 0x0	/* UART4_CTS & UART4_RTS (IOMG87) */
+					0x16c 0x0	/* UART4_RXD (IOMG88) */
+					0x170 0x0	/* UART4_TXD (IOMG93) */
+				>;
+			};
+			uart4_pmx_idle: uart4_pmx_idle {
+				pinctrl-single,pins = <
+					0x168 0x1	/* GPIO (IOMG87) */
+					0x16c 0x1	/* GPIO (IOMG88) */
+					0x170 0x1	/* GPIO (IOMG93) */
+				>;
+			};
+			i2c0_pmx_func: i2c0_pmx_func {
+				pinctrl-single,pins = <
+					0x0b4 0x0	/* I2C0_SCL & I2C0_SDA (IOMG45) */
+				>;
+			};
+			i2c0_pmx_idle: i2c0_pmx_idle {
+				pinctrl-single,pins = <
+					0x0b4 0x1	/* GPIO (IOMG45) */
+				>;
+			};
+			i2c1_pmx_func: i2c1_pmx_func {
+				pinctrl-single,pins = <
+					0x0b8 0x0	/* I2C1_SCL & I2C1_SDA (IOMG46) */
+				>;
+			};
+			i2c1_pmx_idle: i2c1_pmx_idle {
+				pinctrl-single,pins = <
+					0x0b8 0x1	/* GPIO (IOMG46) */
+				>;
+			};
+			i2c2_pmx_func: i2c2_pmx_func {
+				pinctrl-single,pins = <
+					0x068 0x0	/* I2C2_SCL (IOMG26) */
+					0x06c 0x0	/* I2C2_SDA (IOMG27) */
+				>;
+			};
+			i2c2_pmx_idle: i2c2_pmx_idle {
+				pinctrl-single,pins = <
+					0x068 0x1	/* GPIO (IOMG26) */
+					0x06c 0x1	/* GPIO (IOMG27) */
+				>;
+			};
+			i2c3_pmx_func: i2c3_pmx_func {
+				pinctrl-single,pins = <
+					0x050 0x2	/* I2C3_SCL (IOMG20) */
+					0x054 0x2	/* I2C3_SDA (IOMG21) */
+				>;
+			};
+			i2c3_pmx_idle: i2c3_pmx_idle {
+				pinctrl-single,pins = <
+					0x050 0x1	/* GPIO (IOMG20) */
+					0x054 0x1	/* GPIO (IOMG21) */
+				>;
+			};
+			spi0_pmx_func: spi0_pmx_func {
+				pinctrl-single,pins = <
+					0x0d4 0x0	/* SPI0_CLK/SPI0_DI/SPI0_DO (IOMG53) */
+					0x0d8 0x0	/* SPI0_CS0 (IOMG54) */
+					0x0dc 0x0	/* SPI0_CS1 (IOMG55) */
+					0x0e0 0x0	/* SPI0_CS2 (IOMG56) */
+					0x0e4 0x0	/* SPI0_CS3 (IOMG57) */
+				>;
+			};
+			spi0_pmx_idle: spi0_pmx_idle {
+				pinctrl-single,pins = <
+					0x0d4 0x1	/* GPIO (IOMG53) */
+					0x0d8 0x1	/* GPIO (IOMG54) */
+					0x0dc 0x1	/* GPIO (IOMG55) */
+					0x0e0 0x1	/* GPIO (IOMG56) */
+					0x0e4 0x1	/* GPIO (IOMG57) */
+				>;
+			};
+			spi1_pmx_func: spi1_pmx_func {
+				pinctrl-single,pins = <
+					0x184 0x0	/* SPI1_CLK/SPI1_DI (IOMG98) */
+					0x0e8 0x0	/* SPI1_DO (IOMG58) */
+					0x0ec 0x0	/* SPI1_CS (IOMG95) */
+				>;
+			};
+			spi1_pmx_idle: spi1_pmx_idle {
+				pinctrl-single,pins = <
+					0x184 0x1	/* GPIO (IOMG98) */
+					0x0e8 0x1	/* GPIO (IOMG58) */
+					0x0ec 0x1	/* GPIO (IOMG95) */
+				>;
+			};
+			kpc_pmx_func: kpc_pmx_func {
+				pinctrl-single,pins = <
+					0x12c 0x0	/* KEY_IN0 (IOMG73) */
+					0x130 0x0	/* KEY_IN1 (IOMG74) */
+					0x134 0x0	/* KEY_IN2 (IOMG75) */
+					0x10c 0x0	/* KEY_OUT0 (IOMG65) */
+					0x110 0x0	/* KEY_OUT1 (IOMG66) */
+					0x114 0x0	/* KEY_OUT2 (IOMG67) */
+				>;
+			};
+			kpc_pmx_idle: kpc_pmx_idle {
+				pinctrl-single,pins = <
+					0x12c 0x1	/* GPIO (IOMG73) */
+					0x130 0x1	/* GPIO (IOMG74) */
+					0x134 0x1	/* GPIO (IOMG75) */
+					0x10c 0x1	/* GPIO (IOMG65) */
+					0x110 0x1	/* GPIO (IOMG66) */
+					0x114 0x1	/* GPIO (IOMG67) */
+				>;
+			};
+			gpio_key_func: gpio_key_func {
+				pinctrl-single,pins = <
+					0x10c 0x1	/* KEY_OUT0/GPIO (IOMG65) */
+					0x130 0x1	/* KEY_IN1/GPIO (IOMG74) */
+				>;
+			};
+			emmc_pmx_func: emmc_pmx_func {
+				pinctrl-single,pins = <
+					0x030 0x2	/* eMMC_CMD/eMMC_CLK (IOMG12) */
+					0x018 0x0	/* NAND_CS3_N (IOMG6) */
+					0x024 0x0	/* NAND_BUSY2_N (IOMG8) */
+					0x028 0x0	/* NAND_BUSY3_N (IOMG9) */
+					0x02c 0x2	/* eMMC_DATA[0:7] (IOMG10) */
+				>;
+			};
+			emmc_pmx_idle: emmc_pmx_idle {
+				pinctrl-single,pins = <
+					0x030 0x0	/* GPIO (IOMG12) */
+					0x018 0x1	/* GPIO (IOMG6) */
+					0x024 0x1	/* GPIO (IOMG8) */
+					0x028 0x1	/* GPIO (IOMG9) */
+					0x02c 0x1	/* GPIO (IOMG10) */
+				>;
+			};
+			sd_pmx_func: sd_pmx_func {
+				pinctrl-single,pins = <
+					0x0bc 0x0	/* SD_CLK/SD_CMD/SD_DATA0/SD_DATA1/SD_DATA2 (IOMG47) */
+					0x0c0 0x0	/* SD_DATA3 (IOMG48) */
+				>;
+			};
+			sd_pmx_idle: sd_pmx_idle {
+				pinctrl-single,pins = <
+					0x0bc 0x1	/* GPIO (IOMG47) */
+					0x0c0 0x1	/* GPIO (IOMG48) */
+				>;
+			};
+			nand_pmx_func: nand_pmx_func {
+				pinctrl-single,pins = <
+					0x00c 0x0	/* NAND_ALE/NAND_CLE/.../NAND_DATA[0:7] (IOMG3) */
+					0x010 0x0	/* NAND_CS1_N (IOMG4) */
+					0x014 0x0	/* NAND_CS2_N (IOMG5) */
+					0x018 0x0	/* NAND_CS3_N (IOMG6) */
+					0x01c 0x0	/* NAND_BUSY0_N (IOMG94) */
+					0x020 0x0	/* NAND_BUSY1_N (IOMG7) */
+					0x024 0x0	/* NAND_BUSY2_N (IOMG8) */
+					0x028 0x0	/* NAND_BUSY3_N (IOMG9) */
+					0x02c 0x0	/* NAND_DATA[8:15] (IOMG10) */
+				>;
+			};
+			nand_pmx_idle: nand_pmx_idle {
+				pinctrl-single,pins = <
+					0x00c 0x1	/* GPIO (IOMG3) */
+					0x010 0x1	/* GPIO (IOMG4) */
+					0x014 0x1	/* GPIO (IOMG5) */
+					0x018 0x1	/* GPIO (IOMG6) */
+					0x01c 0x1	/* GPIO (IOMG94) */
+					0x020 0x1	/* GPIO (IOMG7) */
+					0x024 0x1	/* GPIO (IOMG8) */
+					0x028 0x1	/* GPIO (IOMG9) */
+					0x02c 0x1	/* GPIO (IOMG10) */
+				>;
+			};
+			sdio_pmx_func: sdio_pmx_func {
+				pinctrl-single,pins = <
+					0x0c4 0x0	/* SDIO_CLK/SDIO_CMD/SDIO_DATA[0:3] (IOMG49) */
+				>;
+			};
+			sdio_pmx_idle: sdio_pmx_idle {
+				pinctrl-single,pins = <
+					0x0c4 0x1	/* GPIO (IOMG49) */
+				>;
+			};
+			audio_out_pmx_func: audio_out_pmx_func {
+				pinctrl-single,pins = <
+					0x0f0 0x1	/* GPIO (IOMG59), audio spk & earphone */
+				>;
+			};
+		};
+
+		pmx1: pinmux at 803800 {
+			pinctrl-names = "default";
+			pinctrl-0 = <	&board_pu_pins &board_pd_pins &board_pd_ps_pins
+					&board_np_pins &board_ps_pins &kpc_cfg_func
+					&audio_out_cfg_func>;
+			board_pu_pins: board_pu_pins {
+				pinctrl-single,pins = <
+					0x014 0		/* GPIO_158 (IOCFG2) */
+					0x018 0		/* GPIO_159 (IOCFG3) */
+					0x01c 0		/* BOOT_MODE0 (IOCFG4) */
+					0x020 0		/* BOOT_MODE1 (IOCFG5) */
+				>;
+				pinctrl-single,bias-pulldown = <0 2 0 2>;
+				pinctrl-single,bias-pullup = <1 1 0 1>;
+			};
+			board_pd_pins: board_pd_pins {
+				pinctrl-single,pins = <
+					0x038 0		/* eFUSE_DOUT (IOCFG11) */
+					0x150 0		/* ISP_GPIO8 (IOCFG93) */
+					0x154 0		/* ISP_GPIO9 (IOCFG94) */
+				>;
+				pinctrl-single,bias-pulldown = <2 2 0 2>;
+				pinctrl-single,bias-pullup = <0 1 0 1>;
+			};
+			board_pd_ps_pins: board_pd_ps_pins {
+				pinctrl-single,pins = <
+					0x2d8 0		/* CLK_OUT0 (IOCFG190) */
+					0x004 0		/* PMU_SPI_DATA (IOCFG192) */
+				>;
+				pinctrl-single,bias-pulldown = <2 2 0 2>;
+				pinctrl-single,bias-pullup = <0 1 0 1>;
+				pinctrl-single,drive-strength = <0x30 0xf0>;
+			};
+			board_np_pins: board_np_pins {
+				pinctrl-single,pins = <
+					0x24c 0		/* KEYPAD_OUT7 (IOCFG155) */
+				>;
+				pinctrl-single,bias-pulldown = <0 2 0 2>;
+				pinctrl-single,bias-pullup = <0 1 0 1>;
+			};
+			board_ps_pins: board_ps_pins {
+				pinctrl-single,pins = <
+					0x000 0		/* PMU_SPI_CLK (IOCFG191) */
+					0x008 0		/* PMU_SPI_CS_N (IOCFG193) */
+				>;
+				pinctrl-single,drive-strength = <0x30 0xf0>;
+			};
+			uart0_cfg_func: uart0_cfg_func {
+				pinctrl-single,pins = <
+					0x208 0		/* UART0_RXD (IOCFG138) */
+					0x20c 0		/* UART0_TXD (IOCFG139) */
+				>;
+				pinctrl-single,bias-pulldown = <0 2 0 2>;
+				pinctrl-single,bias-pullup = <0 1 0 1>;
+			};
+			uart0_cfg_idle: uart0_cfg_idle {
+				pinctrl-single,pins = <
+					0x208 0		/* UART0_RXD (IOCFG138) */
+					0x20c 0		/* UART0_TXD (IOCFG139) */
+				>;
+				pinctrl-single,bias-pulldown = <2 2 0 2>;
+				pinctrl-single,bias-pullup = <0 1 0 1>;
+			};
+			uart1_cfg_func: uart1_cfg_func {
+				pinctrl-single,pins = <
+					0x210 0		/* UART1_CTS (IOCFG140) */
+					0x214 0		/* UART1_RTS (IOCFG141) */
+					0x218 0		/* UART1_RXD (IOCFG142) */
+					0x21c 0		/* UART1_TXD (IOCFG143) */
+				>;
+				pinctrl-single,bias-pulldown = <0 2 0 2>;
+				pinctrl-single,bias-pullup = <0 1 0 1>;
+			};
+			uart1_cfg_idle: uart1_cfg_idle {
+				pinctrl-single,pins = <
+					0x210 0		/* UART1_CTS (IOCFG140) */
+					0x214 0		/* UART1_RTS (IOCFG141) */
+					0x218 0		/* UART1_RXD (IOCFG142) */
+					0x21c 0		/* UART1_TXD (IOCFG143) */
+				>;
+				pinctrl-single,bias-pulldown = <2 2 0 2>;
+				pinctrl-single,bias-pullup = <0 1 0 1>;
+			};
+			uart2_cfg_func: uart2_cfg_func {
+				pinctrl-single,pins = <
+					0x220 0		/* UART2_CTS (IOCFG144) */
+					0x224 0		/* UART2_RTS (IOCFG145) */
+					0x228 0		/* UART2_RXD (IOCFG146) */
+					0x22c 0		/* UART2_TXD (IOCFG147) */
+				>;
+				pinctrl-single,bias-pulldown = <0 2 0 2>;
+				pinctrl-single,bias-pullup = <0 1 0 1>;
+			};
+			uart2_cfg_idle: uart2_cfg_idle {
+				pinctrl-single,pins = <
+					0x220 0		/* GPIO (IOCFG144) */
+					0x224 0		/* GPIO (IOCFG145) */
+					0x228 0		/* GPIO (IOCFG146) */
+					0x22c 0		/* GPIO (IOCFG147) */
+				>;
+				pinctrl-single,bias-pulldown = <2 2 0 2>;
+				pinctrl-single,bias-pullup = <0 1 0 1>;
+			};
+			uart3_cfg_func: uart3_cfg_func {
+				pinctrl-single,pins = <
+					0x294 0		/* UART3_CTS (IOCFG173) */
+					0x298 0		/* UART3_RTS (IOCFG174) */
+					0x29c 0		/* UART3_RXD (IOCFG175) */
+					0x2a0 0		/* UART3_TXD (IOCFG176) */
+				>;
+				pinctrl-single,bias-pulldown = <0 2 0 2>;
+				pinctrl-single,bias-pullup = <0 1 0 1>;
+			};
+			uart3_cfg_idle: uart3_cfg_idle {
+				pinctrl-single,pins = <
+					0x294 0		/* UART3_CTS (IOCFG173) */
+					0x298 0		/* UART3_RTS (IOCFG174) */
+					0x29c 0		/* UART3_RXD (IOCFG175) */
+					0x2a0 0		/* UART3_TXD (IOCFG176) */
+				>;
+				pinctrl-single,bias-pulldown = <2 2 0 2>;
+				pinctrl-single,bias-pullup = <0 1 0 1>;
+			};
+			uart4_cfg_func: uart4_cfg_func {
+				pinctrl-single,pins = <
+					0x2a4 0		/* UART4_CTS (IOCFG177) */
+					0x2a8 0		/* UART4_RTS (IOCFG178) */
+					0x2ac 0		/* UART4_RXD (IOCFG179) */
+					0x2b0 0		/* UART4_TXD (IOCFG180) */
+				>;
+				pinctrl-single,bias-pulldown = <0 2 0 2>;
+				pinctrl-single,bias-pullup = <0 1 0 1>;
+			};
+			i2c0_cfg_func: i2c0_cfg_func {
+				pinctrl-single,pins = <
+					0x17c 0		/* I2C0_SCL (IOCFG103) */
+					0x180 0		/* I2C0_SDA (IOCFG104) */
+				>;
+				pinctrl-single,bias-pulldown = <0 2 0 2>;
+				pinctrl-single,bias-pullup = <0 1 0 1>;
+				pinctrl-single,drive-strength = <0x30 0xf0>;
+			};
+			i2c1_cfg_func: i2c1_cfg_func {
+				pinctrl-single,pins = <
+					0x184 0		/* I2C1_SCL (IOCFG105) */
+					0x188 0		/* I2C1_SDA (IOCFG106) */
+				>;
+				pinctrl-single,bias-pulldown = <0 2 0 2>;
+				pinctrl-single,bias-pullup = <0 1 0 1>;
+				pinctrl-single,drive-strength = <0x30 0xf0>;
+			};
+			i2c2_cfg_func: i2c2_cfg_func {
+				pinctrl-single,pins = <
+					0x118 0		/* I2C2_SCL (IOCFG79) */
+					0x11c 0		/* I2C2_SDA (IOCFG80) */
+				>;
+				pinctrl-single,bias-pulldown = <0 2 0 2>;
+				pinctrl-single,bias-pullup = <0 1 0 1>;
+				pinctrl-single,drive-strength = <0x30 0xf0>;
+			};
+			i2c3_cfg_func: i2c3_cfg_func {
+				pinctrl-single,pins = <
+					0x100 0		/* I2C3_SCL (IOCFG73) */
+					0x104 0		/* I2C3_SDA (IOCFG74) */
+				>;
+				pinctrl-single,bias-pulldown = <0 2 0 2>;
+				pinctrl-single,bias-pullup = <0 1 0 1>;
+				pinctrl-single,drive-strength = <0x30 0xf0>;
+			};
+			spi0_cfg_func1: spi0_cfg_func1 {
+				pinctrl-single,pins = <
+					0x1d4 0		/* SPI0_CLK (IOCFG125) */
+					0x1d8 0		/* SPI0_DI (IOCFG126) */
+					0x1dc 0		/* SPI0_DO (IOCFG127) */
+				>;
+				pinctrl-single,bias-pulldown = <2 2 0 2>;
+				pinctrl-single,bias-pullup = <0 1 0 1>;
+				pinctrl-single,drive-strength = <0x30 0xf0>;
+			};
+			spi0_cfg_func2: spi0_cfg_func2 {
+				pinctrl-single,pins = <
+					0x1e0 0		/* SPI0_CS0 (IOCFG128) */
+					0x1e4 0		/* SPI0_CS1 (IOCFG129) */
+					0x1e8 0		/* SPI0_CS2 (IOCFG130 */
+					0x1ec 0		/* SPI0_CS3 (IOCFG131) */
+				>;
+				pinctrl-single,bias-pulldown = <0 2 0 2>;
+				pinctrl-single,bias-pullup = <1 1 0 1>;
+				pinctrl-single,drive-strength = <0x30 0xf0>;
+			};
+			spi1_cfg_func1: spi1_cfg_func1 {
+				pinctrl-single,pins = <
+					0x1f0 0		/* SPI1_CLK (IOCFG132) */
+					0x1f4 0		/* SPI1_DI (IOCFG133) */
+					0x1f8 0		/* SPI1_DO (IOCFG134) */
+				>;
+				pinctrl-single,bias-pulldown = <2 2 0 2>;
+				pinctrl-single,bias-pullup = <0 1 0 1>;
+				pinctrl-single,drive-strength = <0x30 0xf0>;
+			};
+			spi1_cfg_func2: spi1_cfg_func2 {
+				pinctrl-single,pins = <
+					0x1fc 0		/* SPI1_CS (IOCFG135) */
+				>;
+				pinctrl-single,bias-pulldown = <0 2 0 2>;
+				pinctrl-single,bias-pullup = <1 1 0 1>;
+				pinctrl-single,drive-strength = <0x30 0xf0>;
+			};
+			kpc_cfg_func: kpc_cfg_func {
+				pinctrl-single,pins = <
+					0x250 0		/* KEY_IN0 (IOCFG156) */
+					0x254 0		/* KEY_IN1 (IOCFG157) */
+					0x258 0		/* KEY_IN2 (IOCFG158) */
+					0x230 0		/* KEY_OUT0 (IOCFG148) */
+					0x234 0		/* KEY_OUT1 (IOCFG149) */
+					0x238 0		/* KEY_OUT2 (IOCFG150) */
+				>;
+				pinctrl-single,bias-pulldown = <2 2 0 2>;
+				pinctrl-single,bias-pullup = <0 1 0 1>;
+			};
+			emmc_cfg_func: emmc_cfg_func {
+				pinctrl-single,pins = <
+					0x0ac 0		/* eMMC_CMD (IOCFG40) */
+					0x0b0 0		/* eMMC_CLK (IOCFG41) */
+					0x058 0		/* NAND_CS3_N (IOCFG19) */
+					0x064 0		/* NAND_BUSY2_N (IOCFG22) */
+					0x068 0		/* NAND_BUSY3_N (IOCFG23) */
+					0x08c 0		/* NAND_DATA8 (IOCFG32) */
+					0x090 0		/* NAND_DATA9 (IOCFG33) */
+					0x094 0		/* NAND_DATA10 (IOCFG34) */
+					0x098 0		/* NAND_DATA11 (IOCFG35) */
+					0x09c 0		/* NAND_DATA12 (IOCFG36) */
+					0x0a0 0		/* NAND_DATA13 (IOCFG37) */
+					0x0a4 0		/* NAND_DATA14 (IOCFG38) */
+					0x0a8 0		/* NAND_DATA15 (IOCFG39) */
+				>;
+				pinctrl-single,bias-pulldown = <0 2 0 2>;
+				pinctrl-single,bias-pullup = <1 1 0 1>;
+				pinctrl-single,drive-strength = <0x30 0xf0>;
+			};
+			sd_cfg_func1: sd_cfg_func1 {
+				pinctrl-single,pins = <
+					0x18c 0		/* SD_CLK (IOCFG107) */
+					0x190 0		/* SD_CMD (IOCFG108) */
+				>;
+				pinctrl-single,bias-pulldown = <2 2 0 2>;
+				pinctrl-single,bias-pullup = <0 1 0 1>;
+				pinctrl-single,drive-strength = <0x30 0xf0>;
+			};
+			sd_cfg_func2: sd_cfg_func2 {
+				pinctrl-single,pins = <
+					0x194 0		/* SD_DATA0 (IOCFG109) */
+					0x198 0		/* SD_DATA1 (IOCFG110) */
+					0x19c 0		/* SD_DATA2 (IOCFG111) */
+					0x1a0 0		/* SD_DATA3 (IOCFG112) */
+				>;
+				pinctrl-single,bias-pulldown = <2 2 0 2>;
+				pinctrl-single,bias-pullup = <0 1 0 1>;
+				pinctrl-single,drive-strength = <0x70 0xf0>;
+			};
+			nand_cfg_func1: nand_cfg_func1 {
+				pinctrl-single,pins = <
+					0x03c 0		/* NAND_ALE (IOCFG12) */
+					0x040 0		/* NAND_CLE (IOCFG13) */
+					0x06c 0		/* NAND_DATA0 (IOCFG24) */
+					0x070 0		/* NAND_DATA1 (IOCFG25) */
+					0x074 0		/* NAND_DATA2 (IOCFG26) */
+					0x078 0		/* NAND_DATA3 (IOCFG27) */
+					0x07c 0		/* NAND_DATA4 (IOCFG28) */
+					0x080 0		/* NAND_DATA5 (IOCFG29) */
+					0x084 0		/* NAND_DATA6 (IOCFG30) */
+					0x088 0		/* NAND_DATA7 (IOCFG31) */
+					0x08c 0		/* NAND_DATA8 (IOCFG32) */
+					0x090 0		/* NAND_DATA9 (IOCFG33) */
+					0x094 0		/* NAND_DATA10 (IOCFG34) */
+					0x098 0		/* NAND_DATA11 (IOCFG35) */
+					0x09c 0		/* NAND_DATA12 (IOCFG36) */
+					0x0a0 0		/* NAND_DATA13 (IOCFG37) */
+					0x0a4 0		/* NAND_DATA14 (IOCFG38) */
+					0x0a8 0		/* NAND_DATA15 (IOCFG39) */
+				>;
+				pinctrl-single,bias-pulldown = <2 2 0 2>;
+				pinctrl-single,bias-pullup = <0 1 0 1>;
+				pinctrl-single,drive-strength = <0x30 0xf0>;
+			};
+			nand_cfg_func2: nand_cfg_func2 {
+				pinctrl-single,pins = <
+					0x044 0		/* NAND_RE_N (IOCFG14) */
+					0x048 0		/* NAND_WE_N (IOCFG15) */
+					0x04c 0		/* NAND_CS0_N (IOCFG16) */
+					0x050 0		/* NAND_CS1_N (IOCFG17) */
+					0x054 0		/* NAND_CS2_N (IOCFG18) */
+					0x058 0		/* NAND_CS3_N (IOCFG19) */
+					0x05c 0		/* NAND_BUSY0_N (IOCFG20) */
+					0x060 0		/* NAND_BUSY1_N (IOCFG21) */
+					0x064 0		/* NAND_BUSY2_N (IOCFG22) */
+					0x068 0		/* NAND_BUSY3_N (IOCFG23) */
+				>;
+				pinctrl-single,bias-pulldown = <0 2 0 2>;
+				pinctrl-single,bias-pullup = <1 1 0 1>;
+				pinctrl-single,drive-strength = <0x30 0xf0>;
+			};
+			sdio_cfg_func: sdio_cfg_func {
+				pinctrl-single,pins = <
+					0x1a4 0		/* SDIO0_CLK (IOCG113) */
+					0x1a8 0		/* SDIO0_CMD (IOCG114) */
+					0x1ac 0		/* SDIO0_DATA0 (IOCG115) */
+					0x1b0 0		/* SDIO0_DATA1 (IOCG116) */
+					0x1b4 0		/* SDIO0_DATA2 (IOCG117) */
+					0x1b8 0		/* SDIO0_DATA3 (IOCG118) */
+				>;
+				pinctrl-single,bias-pulldown = <2 2 0 2>;
+				pinctrl-single,bias-pullup = <0 1 0 1>;
+				pinctrl-single,drive-strength = <0x30 0xf0>;
+			};
+			audio_out_cfg_func: audio_out_cfg_func {
+				pinctrl-single,pins = <
+					0x200 0		/* GPIO (IOCFG136) */
+					0x204 0		/* GPIO (IOCFG137) */
+				>;
+				pinctrl-single,bias-pulldown = <2 2 0 2>;
+				pinctrl-single,bias-pullup = <0 1 0 1>;
+			};
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		call {
+			label = "call";
+			gpios = <&gpio17 2 0>;
+			linux,code = <169>;	/* KEY_PHONE */
+		};
+	};
+};
-- 
1.8.3.2
