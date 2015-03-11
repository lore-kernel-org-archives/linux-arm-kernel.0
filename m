From: Chunyan.Zhang@spreadtrum.com (=?gb2312?B?Q2h1bnlhbiBaaGFuZyAo1cW0utHeKQ==?=)
Date: Wed, 11 Mar 2015 02:27:08 +0000
Subject: [PATCH v8 1/2] arm64: dts: Add support for Spreadtrum SC9836 SoC in
 dts and Makefile
In-Reply-To: <1426040790-19495-1-git-send-email-chunyan.zhang@spreadtrum.com>
References: <1426040790-19495-1-git-send-email-chunyan.zhang@spreadtrum.com>
Message-ID: <1426040790-19495-2-git-send-email-chunyan.zhang@spreadtrum.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Zhizhou Zhang <zhizhou.zhang@spreadtrum.com>

Adds the device tree support for Spreadtrum SC9836 SoC which is based on
Sharkl64 platform.

Sharkl64 platform contains the common nodes of Spreadtrum's arm64-based SoCs.

Signed-off-by: Zhizhou Zhang <zhizhou.zhang@spreadtrum.com>
Signed-off-by: Orson Zhai <orson.zhai@spreadtrum.com>
Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/boot/dts/Makefile                  |  1 +
 arch/arm64/boot/dts/sprd/Makefile             |  5 ++
 arch/arm64/boot/dts/sprd/sc9836-openphone.dts | 49 ++++++++++++++++++
 arch/arm64/boot/dts/sprd/sc9836.dtsi          | 74 +++++++++++++++++++++++++++
 arch/arm64/boot/dts/sprd/sharkl64.dtsi        | 65 +++++++++++++++++++++++
 5 files changed, 194 insertions(+)
 create mode 100644 arch/arm64/boot/dts/sprd/Makefile
 create mode 100644 arch/arm64/boot/dts/sprd/sc9836-openphone.dts
 create mode 100644 arch/arm64/boot/dts/sprd/sc9836.dtsi
 create mode 100644 arch/arm64/boot/dts/sprd/sharkl64.dtsi

diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index e0350ca..930f7f8 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -5,5 +5,6 @@ dts-dirs += cavium
 dts-dirs += exynos
 dts-dirs += freescale
 dts-dirs += mediatek
+dts-dirs += sprd
 
 subdir-y	:= $(dts-dirs)
diff --git a/arch/arm64/boot/dts/sprd/Makefile b/arch/arm64/boot/dts/sprd/Makefile
new file mode 100644
index 0000000..b658c5e
--- /dev/null
+++ b/arch/arm64/boot/dts/sprd/Makefile
@@ -0,0 +1,5 @@
+dtb-$(CONFIG_ARCH_SPRD) += sc9836-openphone.dtb
+
+always		:= $(dtb-y)
+subdir-y	:= $(dts-dirs)
+clean-files	:= *.dtb
diff --git a/arch/arm64/boot/dts/sprd/sc9836-openphone.dts b/arch/arm64/boot/dts/sprd/sc9836-openphone.dts
new file mode 100644
index 0000000..e5657c3
--- /dev/null
+++ b/arch/arm64/boot/dts/sprd/sc9836-openphone.dts
@@ -0,0 +1,49 @@
+/*
+ * Spreadtrum SC9836 openphone board DTS file
+ *
+ * Copyright (C) 2014, Spreadtrum Communications Inc.
+ *
+ * This file is licensed under a dual GPLv2 or X11 license.
+ */
+
+/dts-v1/;
+
+#include "sc9836.dtsi"
+
+/ {
+	model = "Spreadtrum SC9836 Openphone Board";
+
+	compatible = "sprd,sc9836-openphone", "sprd,sc9836";
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
+	};
+
+	memory at 80000000 {
+		device_type = "memory";
+		reg = <0 0x80000000 0 0x20000000>;
+	};
+
+	chosen {
+		stdout-path = "serial1:115200n8";
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&uart3 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/sprd/sc9836.dtsi b/arch/arm64/boot/dts/sprd/sc9836.dtsi
new file mode 100644
index 0000000..f92f1b4
--- /dev/null
+++ b/arch/arm64/boot/dts/sprd/sc9836.dtsi
@@ -0,0 +1,74 @@
+/*
+ * Spreadtrum SC9836 SoC DTS file
+ *
+ * Copyright (C) 2014, Spreadtrum Communications Inc.
+ *
+ * This file is licensed under a dual GPLv2 or X11 license.
+ */
+
+#include "sharkl64.dtsi"
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	compatible = "sprd,sc9836";
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x0 0x0>;
+			enable-method = "psci";
+		};
+
+		cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x0 0x1>;
+			enable-method = "psci";
+		};
+
+		cpu at 2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x0 0x2>;
+			enable-method = "psci";
+		};
+
+		cpu at 3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x0 0x3>;
+			enable-method = "psci";
+		};
+	};
+
+	gic: interrupt-controller at 12001000 {
+		compatible = "arm,gic-400";
+		reg = <0 0x12001000 0 0x1000>,
+		      <0 0x12002000 0 0x2000>,
+		      <0 0x12004000 0 0x2000>,
+		      <0 0x12006000 0 0x2000>;
+		#interrupt-cells = <3>;
+		interrupt-controller;
+		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+	};
+
+	psci {
+		compatible	= "arm,psci";
+		method		= "smc";
+		cpu_on		= <0xc4000003>;
+		cpu_off		= <0x84000002>;
+		cpu_suspend	= <0xc4000001>;
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+	};
+};
diff --git a/arch/arm64/boot/dts/sprd/sharkl64.dtsi b/arch/arm64/boot/dts/sprd/sharkl64.dtsi
new file mode 100644
index 0000000..6b4bdc5
--- /dev/null
+++ b/arch/arm64/boot/dts/sprd/sharkl64.dtsi
@@ -0,0 +1,65 @@
+/*
+ * Spreadtrum Sharkl64 platform DTS file
+ *
+ * Copyright (C) 2014, Spreadtrum Communications Inc.
+ *
+ * This file is licensed under a dual GPLv2 or X11 license.
+ */
+
+/ {
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		ap-apb {
+			compatible = "simple-bus";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			uart0: serial at 70000000 {
+				compatible = "sprd,sc9836-uart";
+				reg = <0 0x70000000 0 0x100>;
+				interrupts = <0 2 0xf04>;
+				clocks = <&clk26mhz>;
+				status = "disabled";
+			};
+
+			uart1: serial at 70100000 {
+				compatible = "sprd,sc9836-uart";
+				reg = <0 0x70100000 0 0x100>;
+				interrupts = <0 3 0xf04>;
+				clocks = <&clk26mhz>;
+				status = "disabled";
+			};
+
+			uart2: serial at 70200000 {
+				compatible = "sprd,sc9836-uart";
+				reg = <0 0x70200000 0 0x100>;
+				interrupts = <0 4 0xf04>;
+				clocks = <&clk26mhz>;
+				status = "disabled";
+			};
+
+			uart3: serial at 70300000 {
+				compatible = "sprd,sc9836-uart";
+				reg = <0 0x70300000 0 0x100>;
+				interrupts = <0 5 0xf04>;
+				clocks = <&clk26mhz>;
+				status = "disabled";
+			};
+		};
+	};
+
+	clk26mhz: clk26mhz {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <26000000>;
+	};
+};
-- 
1.9.1
