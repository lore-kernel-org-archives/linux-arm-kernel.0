From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Mon, 16 Oct 2017 06:01:50 +0200
Subject: [PATCH 5/5] arm64: dts: realtek: Add RTD1296 and Synology DS418
In-Reply-To: <20171016040150.23400-1-afaerber@suse.de>
References: <20171016040150.23400-1-afaerber@suse.de>
Message-ID: <20171016040150.23400-6-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Device Trees for RTD1296 SoC and Synology DiskStation DS418.

Cc: info at synology.com
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm64/boot/dts/realtek/Makefile          |  2 +
 arch/arm64/boot/dts/realtek/rtd1296-ds418.dts | 31 +++++++++++
 arch/arm64/boot/dts/realtek/rtd1296.dtsi      | 74 +++++++++++++++++++++++++++
 3 files changed, 107 insertions(+)
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1296-ds418.dts
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1296.dtsi

diff --git a/arch/arm64/boot/dts/realtek/Makefile b/arch/arm64/boot/dts/realtek/Makefile
index 25c795272507..cf93f4db7a69 100644
--- a/arch/arm64/boot/dts/realtek/Makefile
+++ b/arch/arm64/boot/dts/realtek/Makefile
@@ -3,6 +3,8 @@ dtb-$(CONFIG_ARCH_REALTEK) += rtd1293-ds418j.dtb
 dtb-$(CONFIG_ARCH_REALTEK) += rtd1295-probox2-ava.dtb
 dtb-$(CONFIG_ARCH_REALTEK) += rtd1295-zidoo-x9s.dtb
 
+dtb-$(CONFIG_ARCH_REALTEK) += rtd1296-ds418.dtb
+
 always		:= $(dtb-y)
 subdir-y	:= $(dts-dirs)
 clean-files	:= *.dtb
diff --git a/arch/arm64/boot/dts/realtek/rtd1296-ds418.dts b/arch/arm64/boot/dts/realtek/rtd1296-ds418.dts
new file mode 100644
index 000000000000..015ef06e1933
--- /dev/null
+++ b/arch/arm64/boot/dts/realtek/rtd1296-ds418.dts
@@ -0,0 +1,31 @@
+/*
+ * Copyright (c) 2017 Andreas F?rber
+ *
+ * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+ */
+
+/dts-v1/;
+
+#include "rtd1293.dtsi"
+
+/ {
+	compatible = "synology,ds418", "realtek,rtd1296";
+	model = "Synology DiskStation DS418";
+
+	memory at 0 {
+		device_type = "memory";
+		reg = <0x0 0x80000000>;
+	};
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/realtek/rtd1296.dtsi b/arch/arm64/boot/dts/realtek/rtd1296.dtsi
new file mode 100644
index 000000000000..d30d708775f8
--- /dev/null
+++ b/arch/arm64/boot/dts/realtek/rtd1296.dtsi
@@ -0,0 +1,74 @@
+/*
+ * Realtek RTD1296 SoC
+ *
+ * Copyright (c) 2017 Andreas F?rber
+ *
+ * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+ */
+
+#include "rtd129x.dtsi"
+
+/ {
+	compatible = "realtek,rtd1296";
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu0: cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x0 0x0>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0x9801aa44>;
+			next-level-cache = <&l2>;
+		};
+
+		cpu1: cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x0 0x1>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0x9801aa44>;
+			next-level-cache = <&l2>;
+		};
+
+		cpu2: cpu at 2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x0 0x2>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0x9801aa44>;
+			next-level-cache = <&l2>;
+		};
+
+		cpu3: cpu at 3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x0 0x3>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0x9801aa44>;
+			next-level-cache = <&l2>;
+		};
+
+		l2: l2-cache {
+			compatible = "cache";
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13
+			(GIC_CPU_MASK_RAW(0xf) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14
+			(GIC_CPU_MASK_RAW(0xf) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11
+			(GIC_CPU_MASK_RAW(0xf) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10
+			(GIC_CPU_MASK_RAW(0xf) | IRQ_TYPE_LEVEL_LOW)>;
+	};
+};
+
+&arm_pmu {
+	interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
+};
-- 
2.13.6
