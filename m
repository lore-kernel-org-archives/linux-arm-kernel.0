From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 11 Feb 2014 11:59:41 +0530
Subject: [PATCH 1/3] arm64: dts: add initial dts for Samsung GH7 SoC and
 SSDK-GH7 board
In-Reply-To: <1392100183-30930-1-git-send-email-kgene.kim@samsung.com>
References: <1392100183-30930-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1392100183-30930-2-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
Reviewed-by: Thomas Abraham <thomas.ab@samsung.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/boot/dts/samsung-gh7.dtsi     |  108 ++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/samsung-ssdk-gh7.dts |   26 +++++++
 2 files changed, 134 insertions(+)
 create mode 100644 arch/arm64/boot/dts/samsung-gh7.dtsi
 create mode 100644 arch/arm64/boot/dts/samsung-ssdk-gh7.dts

diff --git a/arch/arm64/boot/dts/samsung-gh7.dtsi b/arch/arm64/boot/dts/samsung-gh7.dtsi
new file mode 100644
index 0000000..5b8785c
--- /dev/null
+++ b/arch/arm64/boot/dts/samsung-gh7.dtsi
@@ -0,0 +1,108 @@
+/*
+ * SAMSUNG GH7 SoC device tree source
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
+
+/memreserve/ 0x80000000 0x0C400000;
+
+/ {
+	model = "SAMSUNG GH7";
+	compatible = "samsung,gh7";
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu at 000 {
+			device_type = "cpu";
+			compatible = "arm,armv8";
+			reg = <0x0 0x000>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0x8000fff8>;
+		};
+		cpu at 001 {
+			device_type = "cpu";
+			compatible = "arm,armv8";
+			reg = <0x0 0x001>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0x8000fff8>;
+		};
+		cpu at 002 {
+			device_type = "cpu";
+			compatible = "arm,armv8";
+			reg = <0x0 0x002>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0x8000fff8>;
+		};
+		cpu at 003 {
+			device_type = "cpu";
+			compatible = "arm,armv8";
+			reg = <0x0 0x003>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0x8000fff8>;
+		};
+	};
+
+	gic: interrupt-controller at 1C000000 {
+		compatible = "arm,cortex-a15-gic", "arm,cortex-a9-gic";
+		#interrupt-cells = <3>;
+		#address-cells = <0>;
+		interrupt-controller;
+		reg = <0x0 0x1C001000 0 0x1000>,	/* GIC Dist */
+		      <0x0 0x1C002000 0 0x1000>,	/* GIC CPU */
+		      <0x0 0x1C004000 0 0x2000>,	/* GIC VCPU Control */
+		      <0x0 0x1C006000 0 0x2000>;	/* GIC VCPU */
+		interrupts = <1 9 0xf04>;	/* GIC Maintenence IRQ */
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <1 13 0xff01>,	/* Secure Phys IRQ */
+			     <1 14 0xff01>,	/* Non-secure Phys IRQ */
+			     <1 11 0xff01>,	/* Virt IRQ */
+			     <1 10 0xff01>;	/* Hyp IRQ */
+		clock-frequency = <100000000>;
+	};
+
+	pmu {
+		compatible = "arm,armv8-pmuv3";
+		interrupts = <0 294 8>,
+			     <0 295 8>,
+			     <0 296 8>,
+			     <0 297 8>,
+			     <0 298 8>,
+			     <0 299 8>,
+			     <0 300 8>,
+			     <0 301 8>;
+	};
+
+	amba {
+		compatible = "arm,amba-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		serial at 12c00000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x12c00000 0x10000>;
+			interrupts = <418>;
+		};
+
+		serial at 12c20000 {
+			compatible = "arm,pl011", "arm,primecell";
+			reg = <0x12c20000 0x10000>;
+			interrupts = <420>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/samsung-ssdk-gh7.dts b/arch/arm64/boot/dts/samsung-ssdk-gh7.dts
new file mode 100644
index 0000000..47afbc4
--- /dev/null
+++ b/arch/arm64/boot/dts/samsung-ssdk-gh7.dts
@@ -0,0 +1,26 @@
+/*
+ * SAMSUNG SSDK-GH7 board device tree source
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
+#include "samsung-gh7.dtsi"
+
+/ {
+	model = "SAMSUNG SSDK-GH7 board based on GH7 SoC";
+	compatible = "samsung,ssdk-gh7", "samsung,gh7";
+
+	chosen {
+	};
+
+	memory at 80000000 {
+		device_type = "memory";
+		reg = <0x00000000 0x80000000 0 0x80000000>;
+	};
+};
-- 
1.7.10.4
