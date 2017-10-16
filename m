From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Mon, 16 Oct 2017 06:01:48 +0200
Subject: [PATCH 3/5] arm64: dts: realtek: Add RTD1293 and Synology DS418j
In-Reply-To: <20171016040150.23400-1-afaerber@suse.de>
References: <20171016040150.23400-1-afaerber@suse.de>
Message-ID: <20171016040150.23400-4-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Device Trees for RTD1293 SoC and Synology DiskStation DS481j NAS.

Cc: info at synology.com
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm64/boot/dts/realtek/Makefile           |  2 +
 arch/arm64/boot/dts/realtek/rtd1293-ds418j.dts | 31 ++++++++++++++
 arch/arm64/boot/dts/realtek/rtd1293.dtsi       | 56 ++++++++++++++++++++++++++
 3 files changed, 89 insertions(+)
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1293-ds418j.dts
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1293.dtsi

diff --git a/arch/arm64/boot/dts/realtek/Makefile b/arch/arm64/boot/dts/realtek/Makefile
index f43d0209ded7..25c795272507 100644
--- a/arch/arm64/boot/dts/realtek/Makefile
+++ b/arch/arm64/boot/dts/realtek/Makefile
@@ -1,3 +1,5 @@
+dtb-$(CONFIG_ARCH_REALTEK) += rtd1293-ds418j.dtb
+
 dtb-$(CONFIG_ARCH_REALTEK) += rtd1295-probox2-ava.dtb
 dtb-$(CONFIG_ARCH_REALTEK) += rtd1295-zidoo-x9s.dtb
 
diff --git a/arch/arm64/boot/dts/realtek/rtd1293-ds418j.dts b/arch/arm64/boot/dts/realtek/rtd1293-ds418j.dts
new file mode 100644
index 000000000000..0f17bbb5aabb
--- /dev/null
+++ b/arch/arm64/boot/dts/realtek/rtd1293-ds418j.dts
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
+	compatible = "synology,ds418j", "realtek,rtd1293";
+	model = "Synology DiskStation DS418j";
+
+	memory at 0 {
+		device_type = "memory";
+		reg = <0x0 0x40000000>;
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
diff --git a/arch/arm64/boot/dts/realtek/rtd1293.dtsi b/arch/arm64/boot/dts/realtek/rtd1293.dtsi
new file mode 100644
index 000000000000..403f0c55ace0
--- /dev/null
+++ b/arch/arm64/boot/dts/realtek/rtd1293.dtsi
@@ -0,0 +1,56 @@
+/*
+ * Realtek RTD1293 SoC
+ *
+ * Copyright (c) 2017 Andreas F?rber
+ *
+ * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+ */
+
+#include "rtd129x.dtsi"
+
+/ {
+	compatible = "realtek,rtd1293";
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
+	interrupt-affinity = <&cpu0>, <&cpu1>;
+};
-- 
2.13.6
