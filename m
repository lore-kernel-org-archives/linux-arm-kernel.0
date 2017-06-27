From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Tue, 27 Jun 2017 02:55:20 +0200
Subject: [PATCH 6/6] ARM: dts: Add RDA8810PL and Orange Pi 2G-IoT
In-Reply-To: <20170627005520.23731-1-afaerber@suse.de>
References: <20170627005520.23731-1-afaerber@suse.de>
Message-ID: <20170627005520.23731-7-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Device Trees for RDA Micro RDA8810PL SoC and Orange Pi 2G-IoT board.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm/boot/dts/Makefile                      |  2 +
 arch/arm/boot/dts/rda8810pl-orangepi-2g-iot.dts | 27 +++++++
 arch/arm/boot/dts/rda8810pl.dtsi                | 94 +++++++++++++++++++++++++
 3 files changed, 123 insertions(+)
 create mode 100644 arch/arm/boot/dts/rda8810pl-orangepi-2g-iot.dts
 create mode 100644 arch/arm/boot/dts/rda8810pl.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 4b17f35dc9a7..d651033db30e 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -693,6 +693,8 @@ dtb-$(CONFIG_ARCH_QCOM) += \
 	qcom-msm8974-lge-nexus5-hammerhead.dtb \
 	qcom-msm8974-sony-xperia-honami.dtb \
 	qcom-mdm9615-wp8548-mangoh-green.dtb
+dtb-$(CONFIG_ARCH_RDA) += \
+	rda8810pl-orangepi-2g-iot.dtb
 dtb-$(CONFIG_ARCH_REALVIEW) += \
 	arm-realview-pb1176.dtb \
 	arm-realview-pb11mp.dtb \
diff --git a/arch/arm/boot/dts/rda8810pl-orangepi-2g-iot.dts b/arch/arm/boot/dts/rda8810pl-orangepi-2g-iot.dts
new file mode 100644
index 000000000000..4142ecb529c9
--- /dev/null
+++ b/arch/arm/boot/dts/rda8810pl-orangepi-2g-iot.dts
@@ -0,0 +1,27 @@
+/*
+ * Copyright (c) 2017 Andreas F?rber
+ *
+ * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+ */
+
+/dts-v1/;
+
+#include "rda8810pl.dtsi"
+
+/ {
+	compatible = "xunlong,orangepi-2g-iot", "rda,8810pl";
+	model = "Orange Pi 2G-IoT";
+
+	chosen {
+		stdout-path = "serial3:921600n8";
+	};
+
+	memory at 80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x10000000>;
+	};
+};
+
+&uart3 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/rda8810pl.dtsi b/arch/arm/boot/dts/rda8810pl.dtsi
new file mode 100644
index 000000000000..f066ac7a4ee9
--- /dev/null
+++ b/arch/arm/boot/dts/rda8810pl.dtsi
@@ -0,0 +1,94 @@
+/*
+ * RDA8810PL SoC
+ *
+ * Copyright (c) 2017 Andreas F?rber
+ *
+ * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+ */
+
+/ {
+	compatible = "rda,8810pl";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	aliases {
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a5";
+			reg = <0x0>;
+		};
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x0 0x80000000>;
+
+		sram at 100000 {
+			compatible = "mmio-sram";
+			reg = <0x100000 0x10000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+		};
+
+		apb at 20800000 {
+			compatible = "simple-bus";
+			reg = <0x20800000 0x100000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x20800000 0x100000>;
+		};
+
+		apb at 20900000 {
+			compatible = "simple-bus";
+			reg = <0x20900000 0x100000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x20900000 0x100000>;
+		};
+
+		apb at 20a00000 {
+			compatible = "simple-bus";
+			reg = <0x20a00000 0x100000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x20a00000 0x100000>;
+
+			uart1: serial at 0 {
+				compatible = "rda,8810pl-uart";
+				reg = <0x0 0x1000>;
+				status = "disabled";
+			};
+
+			uart2: serial at 10000 {
+				compatible = "rda,8810pl-uart";
+				reg = <0x10000 0x1000>;
+				status = "disabled";
+			};
+
+			uart3: serial at 90000 {
+				compatible = "rda,8810pl-uart";
+				reg = <0x90000 0x1000>;
+				status = "disabled";
+			};
+		};
+
+		l2: cache-controller at 21100000 {
+			compatible = "arm,pl310-cache";
+			reg = <0x21100000 0x1000>;
+			cache-unified;
+			cache-level = <2>;
+		};
+	};
+};
-- 
2.12.3
