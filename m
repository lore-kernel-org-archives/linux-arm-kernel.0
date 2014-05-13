From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Tue, 13 May 2014 17:44:39 +0800
Subject: [PATCH v2 4/6] ARM: dts: Add hix5hd2-dkb dts file.
In-Reply-To: <1399974281-9737-1-git-send-email-haojian.zhuang@linaro.org>
References: <1399974281-9737-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1399974281-9737-5-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Haifeng Yan <yanhaifeng@gmail.com>

Add dts file for Hisilicon x5hd2 development kit board.

Signed-off-by: Haifeng Yan <yanhaifeng@gmail.com>
Signed-off-by: Jiancheng Xue <jchxue@gmail.com>
Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 arch/arm/boot/dts/Makefile        |   1 +
 arch/arm/boot/dts/hix5hd2-dkb.dts |  52 ++++++++++++
 arch/arm/boot/dts/hix5hd2.dtsi    | 171 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 224 insertions(+)
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
index 0000000..d55738b
--- /dev/null
+++ b/arch/arm/boot/dts/hix5hd2-dkb.dts
@@ -0,0 +1,52 @@
+/*
+ * Copyright (c) 2013-2014 Linaro Ltd.
+ * Copyright (c) 2013-2014 Hisilicon Limited.
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
+	compatible = "hisilicon,hix5hd2";
+
+	chosen {
+		bootargs = "console=ttyAMA0,115200 earlyprintk";
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
+};
+
+&timer0 {
+	status = "okay";
+};
+
+&uart0 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/hix5hd2.dtsi b/arch/arm/boot/dts/hix5hd2.dtsi
new file mode 100644
index 0000000..73f9ac1
--- /dev/null
+++ b/arch/arm/boot/dts/hix5hd2.dtsi
@@ -0,0 +1,171 @@
+/*
+ * Copyright (c) 2013-2014 Linaro Ltd.
+ * Copyright (c) 2013-2014 Hisilicon Limited.
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
+		interrupt-parent = <&gic>;
+		ranges = <0 0xf8000000 0x8000000>;
+
+		amba {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "arm,amba-bus";
+			ranges;
+
+			timer0: timer at 00002000 {
+				compatible = "arm,sp804", "arm,primecell";
+				reg = <0x00002000 0x1000>;
+				/* timer00 & timer01 */
+				interrupts = <0 24 4>;
+				clocks = <&clock HIX5HD2_FIXED_24M>;
+				status = "disabled";
+			};
+
+			timer1: timer at 00a29000 {
+				/*
+				 * Only used in NORMAL state, not available ins
+				 * SLOW or DOZE state.
+				 * The rate is fixed in 24MHz.
+				 */
+				compatible = "arm,sp804", "arm,primecell";
+				reg = <0x00a29000 0x1000>;
+				/* timer10 & timer11 */
+				interrupts = <0 25 4>;
+				clocks = <&clock HIX5HD2_FIXED_24M>;
+				status = "disabled";
+			};
+
+			timer2: timer at 00a2a000 {
+				compatible = "arm,sp804", "arm,primecell";
+				reg = <0x00a2a000 0x1000>;
+				/* timer20 & timer21 */
+				interrupts = <0 26 4>;
+				clocks = <&clock HIX5HD2_FIXED_24M>;
+				status = "disabled";
+			};
+
+			timer3: timer at 00a2b000 {
+				compatible = "arm,sp804", "arm,primecell";
+				reg = <0x00a2b000 0x1000>;
+				/* timer30 & timer31 */
+				interrupts = <0 27 4>;
+				clocks = <&clock HIX5HD2_FIXED_24M>;
+				status = "disabled";
+			};
+
+			timer4: timer at 00a81000 {
+				compatible = "arm,sp804", "arm,primecell";
+				reg = <0x00a81000 0x1000>;
+				/* timer30 & timer31 */
+				interrupts = <0 28 4>;
+				clocks = <&clock HIX5HD2_FIXED_24M>;
+				status = "disabled";
+			};
+
+			uart0: uart at 00b00000 {
+				compatible = "arm,pl011", "arm,primecell";
+				reg = <0x00b00000 0x1000>;
+				interrupts = <0 49 4>;
+				clocks = <&clock HIX5HD2_FIXED_83M>;
+				clock-names = "apb_pclk";
+				status = "disabled";
+			};
+
+			uart1: uart at 00006000 {
+				compatible = "arm,pl011", "arm,primecell";
+				reg = <0x00006000 0x1000>;
+				interrupts = <0 50 4>;
+				clocks = <&clock HIX5HD2_FIXED_83M>;
+				clock-names = "apb_pclk";
+				status = "disabled";
+			};
+
+			uart2: uart at 00b02000 {
+				compatible = "arm,pl011", "arm,primecell";
+				reg = <0x00b02000 0x1000>;
+				interrupts = <0 51 4>;
+				clocks = <&clock HIX5HD2_FIXED_83M>;
+				clock-names = "apb_pclk";
+				status = "disabled";
+			};
+
+			uart3: uart at 00b03000 {
+				compatible = "arm,pl011", "arm,primecell";
+				reg = <0x00b03000 0x1000>;
+				interrupts = <0 52 4>;
+				clocks = <&clock HIX5HD2_FIXED_83M>;
+				clock-names = "apb_pclk";
+				status = "disabled";
+			};
+
+			uart4: uart at 00b04000 {
+				compatible = "arm,pl011", "arm,primecell";
+				reg = <0xb04000 0x1000>;
+				interrupts = <0 53 4>;
+				clocks = <&clock HIX5HD2_FIXED_83M>;
+				clock-names = "apb_pclk";
+				status = "disabled";
+			};
+		};
+
+		local_timer at 00a00600 {
+			compatible = "arm,cortex-a9-twd-timer";
+			reg = <0x00a00600 0x20>;
+			interrupts = <1 13 0xf01>;
+		};
+
+		l2: l2-cache {
+			compatible = "arm,pl310-cache";
+			reg = <0x00a10000 0x100000>;
+			interrupts = <0 15 4>;
+			cache-unified;
+			cache-level = <2>;
+			hisilicon,l2cache-aux = <0x00050000 0xfff0ffff>;
+		};
+
+		sysctrl: system-controller at 00000000 {
+			compatible = "hisilicon,sysctrl";
+			reg = <0x00000000 0x1000>;
+			reboot-offset = <0x4>;
+		};
+
+		cpuctrl at 00a22000 {
+			compatible = "hisilicon,cpuctrl";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x00a22000 0x2000>;
+			ranges = <0 0x00a22000 0x2000>;
+
+			clock: clock at 0 {
+				compatible = "hisilicon,hix5hd2-clock";
+				reg = <0 0x2000>;
+				#clock-cells = <1>;
+			};
+		};
+	};
+};
-- 
1.9.1
