From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Mon, 12 May 2014 09:30:35 +0800
Subject: [PATCH 4/5] ARM: dts: Add hix5hd2-dkb dts file.
In-Reply-To: <1399858236-29027-1-git-send-email-haojian.zhuang@linaro.org>
References: <1399858236-29027-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1399858236-29027-5-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Haifeng Yan <yanhaifeng@gmail.com>

Add dts file for Hisilicon x5hd2 development kit board.

Signed-off-by: Haifeng Yan <yanhaifeng@gmail.com>
Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 arch/arm/boot/dts/Makefile        |   1 +
 arch/arm/boot/dts/hix5hd2-dkb.dts |  56 +++++++++++
 arch/arm/boot/dts/hix5hd2.dtsi    | 189 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 246 insertions(+)
 create mode 100644 arch/arm/boot/dts/hix5hd2-dkb.dts
 create mode 100644 arch/arm/boot/dts/hix5hd2.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 7119bca..54249d9 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -78,6 +78,7 @@ dtb-$(CONFIG_ARCH_EXYNOS) += exynos4210-origen.dtb \
 	exynos5440-sd5v1.dtb \
 	exynos5440-ssdk5440.dtb
 dtb-$(CONFIG_ARCH_HI3xxx) += hi3620-hi4511.dtb
+dtb-$(CONFIG_ARCH_HIX5HD2) += hix5hd2-dkb.dtb
 dtb-$(CONFIG_ARCH_HIGHBANK) += highbank.dtb \
 	ecx-2000.dtb
 dtb-$(CONFIG_ARCH_HIP04) += hip04-d01.dtb
diff --git a/arch/arm/boot/dts/hix5hd2-dkb.dts b/arch/arm/boot/dts/hix5hd2-dkb.dts
new file mode 100644
index 0000000..644458a
--- /dev/null
+++ b/arch/arm/boot/dts/hix5hd2-dkb.dts
@@ -0,0 +1,56 @@
+/*
+ * Copyright (c) 2013 Linaro Ltd.
+ * Copyright (c) 2013 Hisilicon Limited.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  publishhed by the Free Software Foundation.
+ */
+
+/dts-v1/;
+#include "hix5hd2.dtsi"
+
+/ {
+	model = "Hisilicon HiX5HD2 Development Board";
+	compatible = "hisilicon,hix5hd2-dkb";
+
+	chosen {
+		bootargs = "console=ttyAMA0,115200";
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			compatible = "arm,cortex-a9";
+			device_type = "cpu";
+			reg = <0>;
+			next-level-cache = <&l2>;
+		};
+
+		cpu at 1 {
+			compatible = "arm,cortex-a9";
+			device_type = "cpu";
+			reg = <1>;
+			next-level-cache = <&l2>;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x80000000>;
+	};
+
+	soc {
+		amba {
+			timer0: timer at f8002000 {
+				status = "okay";
+			};
+
+			uart0: uart at f8b00000 {
+				status = "okay";
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/hix5hd2.dtsi b/arch/arm/boot/dts/hix5hd2.dtsi
new file mode 100644
index 0000000..d8a3ad4
--- /dev/null
+++ b/arch/arm/boot/dts/hix5hd2.dtsi
@@ -0,0 +1,189 @@
+/*
+ * Copyright (c) 2013 Linaro Ltd.
+ * Copyright (c) 2013 Hisilicon Limited.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * publishhed by the Free Software Foundation.
+ */
+
+#include "skeleton.dtsi"
+#include <dt-bindings/clock/hix5hd2-clock.h>
+
+/ {
+	aliases {
+		serial0 = &uart0;
+	};
+
+	gic: interrupt-controller at f8a01000 {
+		compatible = "arm,cortex-a9-gic";
+		#interrupt-cells = <3>;
+		#address-cells = <0>;
+		interrupt-controller;
+		/* gic dist base, gic cpu base */
+		reg = <0xf8a01000 0x1000>, <0xf8a00100 0x100>;
+	};
+
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		device_type = "soc";
+		interrupt-parent = <&gic>;
+		ranges;
+
+		amba {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "arm,amba-bus";
+			ranges;
+
+			timer0: timer at f8002000 {
+				compatible = "arm,sp804", "arm,primecell";
+				reg = <0xf8002000 0x1000>;
+				/* timer00 & timer01 */
+				interrupts = <0 24 4>;
+				clocks = <&clock HIX5HD2_FIXED_24M>;
+				status = "disabled";
+			};
+
+			timer1: timer at f8a29000 {
+				/*
+				 * Only used in NORMAL state, not available ins
+				 * SLOW or DOZE state.
+				 * The rate is fixed in 24MHz.
+				 */
+				compatible = "arm,sp804", "arm,primecell";
+				reg = <0xf8a29000 0x1000>;
+				/* timer10 & timer11 */
+				interrupts = <0 25 4>;
+				clocks = <&clock HIX5HD2_FIXED_24M>;
+				status = "disabled";
+			};
+
+			timer2: timer at f8a2a000 {
+				compatible = "arm,sp804", "arm,primecell";
+				reg = <0xf8a2a000 0x1000>;
+				/* timer20 & timer21 */
+				interrupts = <0 26 4>;
+				clocks = <&clock HIX5HD2_FIXED_24M>;
+				status = "disabled";
+			};
+
+			timer3: timer at f8a2b000 {
+				compatible = "arm,sp804", "arm,primecell";
+				reg = <0xf8a2b000 0x1000>;
+				/* timer30 & timer31 */
+				interrupts = <0 27 4>;
+				clocks = <&clock HIX5HD2_FIXED_24M>;
+				status = "disabled";
+			};
+
+			timer4: timer at f8a81000 {
+				compatible = "arm,sp804", "arm,primecell";
+				reg = <0xf8a81000 0x1000>;
+				/* timer30 & timer31 */
+				interrupts = <0 28 4>;
+				clocks = <&clock HIX5HD2_FIXED_24M>;
+				status = "disabled";
+			};
+
+			uart0: uart at f8b00000 {
+				compatible = "arm,pl011", "arm,primecell";
+				reg = <0xf8b00000 0x1000>;
+				interrupts = <0 49 4>;
+				clocks = <&clock HIX5HD2_FIXED_83M>;
+				clock-names = "apb_pclk";
+				status = "disabled";
+			};
+
+			uart1: uart at f8006000 {
+				compatible = "arm,pl011", "arm,primecell";
+				reg = <0xf8006000 0x1000>;
+				interrupts = <0 50 4>;
+				clocks = <&clock HIX5HD2_FIXED_83M>;
+				clock-names = "apb_pclk";
+				status = "disabled";
+			};
+
+			uart2: uart at f8b02000 {
+				compatible = "arm,pl011", "arm,primecell";
+				reg = <0xf8b02000 0x1000>;
+				interrupts = <0 51 4>;
+				clocks = <&clock HIX5HD2_FIXED_83M>;
+				clock-names = "apb_pclk";
+				status = "disabled";
+			};
+
+			uart3: uart at f8b03000 {
+				compatible = "arm,pl011", "arm,primecell";
+				reg = <0xf8b03000 0x1000>;
+				interrupts = <0 52 4>;
+				clocks = <&clock HIX5HD2_FIXED_83M>;
+				clock-names = "apb_pclk";
+				status = "disabled";
+			};
+
+			uart4: uart at f8b04000 {
+				compatible = "arm,pl011", "arm,primecell";
+				reg = <0xf8b04000 0x1000>;
+				interrupts = <0 53 4>;
+				clocks = <&clock HIX5HD2_FIXED_83M>;
+				clock-names = "apb_pclk";
+				status = "disabled";
+			};
+		};
+
+		local_timer at f8a00600 {
+			compatible = "arm,cortex-a9-twd-timer";
+			reg = <0xf8a00600 0x20>;
+			interrupts = <1 13 0xf01>;
+		};
+
+		l2: l2-cache {
+			compatible = "arm,pl310-cache";
+			reg = <0xf8a10000 0x100000>;
+			interrupts = <0 15 4>;
+			cache-unified;
+			cache-level = <2>;
+			hisilicon,l2cache-aux = <0x00050000 0xfff0ffff>;
+		};
+
+		/* unremovable emmc as mmcblk0 */
+		dwmmc_1: dwmmc1 at f9830000 {
+			compatible = "hisilicon,hi3716-dw-mshc";
+			reg = <0xf9830000 0x1000>;
+			interrupts = <0 35 4>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&clock HIX5HD2_MMC_CIU_RST>, <&clock HIX5HD2_MMC_BIU_CLK>;
+			clock-names = "ciu", "biu";
+		};
+
+
+		sctrl at f8000000 {
+			compatible = "hisilicon,sysctrl";
+			reg = <0xf8000000 0x1000>;
+			smp_reg = <0xc0>;
+			reboot_reg = <0x4>;
+		};
+
+		clkbase at f8a22000 {
+			compatible = "hisilicon,clkbase";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0xf8a22000 0x1000>;
+			ranges = <0x0 0xf8a22000 0x1000>;
+			clock: clock at 0 {
+				compatible = "hisilicon,hix5hd2-clock";
+				reg = <0x0 0x1000>;
+				#clock-cells = <1>;
+			};
+		};
+
+		cpuctrl at f8a22000 {
+			compatible = "hisilicon,cpuctrl";
+			reg = <0xf8a22000 0x2000>;
+		};
+	};
+};
-- 
1.9.1
