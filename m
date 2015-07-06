From: parkch98@gmail.com (Chanho Park)
Date: Mon,  6 Jul 2015 23:12:35 +0900
Subject: [PATCHv5] ARM: dts: add exynos5422-cpus.dtsi to correct cpu order
Message-ID: <1436191955-3650-1-git-send-email-chanho61.park@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The odroid-xu3 board which is based on exynos5422 not exynos5800 is
booted from cortex-a7 core unlike exynos5800. The odroid-xu3's cpu order
is quite strange. cpu0 and cpu5-7 are cortex-a7 cores and cpu1-4 are
cortex-a15 cores. To correct this mis-odering, I added exynos5422.dtsi
and reversing cpu orders from exynos5420. Now, cpu0-3 are cortex-a7 and
cpu4-7 are cortex-a15.

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: Chanho Park <chanho61.park@samsung.com>
---
Changes from v4:
 - Remove temporal patch in e-mail body

Changes from v3:
 - include this exynos5422-cpus.dtsi in the exynos5422-odroidxu3-common.dtsi

Changes from v2:
 - drop inclusion of exynos5420.dtsi from exynos5422-cpus.dtsi
 - drop compatibles from exynos5422-cpus.dtsi

Changes from v1:
 - rename exynos5422.dtsi to exynos5422-cpus.dtsi
 - include the dtsi file top of the exynos5422-odroidxu3.dts

Secondary cpu booting problem[1] is not resolved yet. Need more investigations
to work booting 8 cores correctly.

[1]: http://www.spinics.net/lists/linux-samsung-soc/msg45525.html

 arch/arm/boot/dts/exynos5422-cpus.dtsi             | 81 ++++++++++++++++++++++
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |  1 +
 2 files changed, 82 insertions(+)
 create mode 100644 arch/arm/boot/dts/exynos5422-cpus.dtsi

diff --git a/arch/arm/boot/dts/exynos5422-cpus.dtsi b/arch/arm/boot/dts/exynos5422-cpus.dtsi
new file mode 100644
index 0000000..b7f60c8
--- /dev/null
+++ b/arch/arm/boot/dts/exynos5422-cpus.dtsi
@@ -0,0 +1,81 @@
+/*
+ * SAMSUNG EXYNOS5422 SoC cpu device tree source
+ *
+ * Copyright (c) 2015 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * The only difference between EXYNOS5422 and EXYNOS5800 is cpu ordering. The
+ * EXYNOS5422 is booting from Cortex-A7 core while the EXYNOS5800 is booting
+ * from Cortex-A15 core.
+ *
+ * EXYNOS5422 based board files can include this file to provide cpu ordering
+ * which could boot a cortex-a7 from cpu0.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+&cpu0 {
+	device_type = "cpu";
+	compatible = "arm,cortex-a7";
+	reg = <0x100>;
+	clock-frequency = <1000000000>;
+	cci-control-port = <&cci_control0>;
+};
+
+&cpu1 {
+	device_type = "cpu";
+	compatible = "arm,cortex-a7";
+	reg = <0x101>;
+	clock-frequency = <1000000000>;
+	cci-control-port = <&cci_control0>;
+};
+
+&cpu2 {
+	device_type = "cpu";
+	compatible = "arm,cortex-a7";
+	reg = <0x102>;
+	clock-frequency = <1000000000>;
+	cci-control-port = <&cci_control0>;
+};
+
+&cpu3 {
+	device_type = "cpu";
+	compatible = "arm,cortex-a7";
+	reg = <0x103>;
+	clock-frequency = <1000000000>;
+	cci-control-port = <&cci_control0>;
+};
+
+&cpu4 {
+	device_type = "cpu";
+	compatible = "arm,cortex-a15";
+	reg = <0x0>;
+	clock-frequency = <1800000000>;
+	cci-control-port = <&cci_control1>;
+};
+
+&cpu5 {
+	device_type = "cpu";
+	compatible = "arm,cortex-a15";
+	reg = <0x1>;
+	clock-frequency = <1800000000>;
+	cci-control-port = <&cci_control1>;
+};
+
+&cpu6 {
+	device_type = "cpu";
+	compatible = "arm,cortex-a15";
+	reg = <0x2>;
+	clock-frequency = <1800000000>;
+	cci-control-port = <&cci_control1>;
+};
+
+&cpu7 {
+	device_type = "cpu";
+	compatible = "arm,cortex-a15";
+	reg = <0x3>;
+	clock-frequency = <1800000000>;
+	cci-control-port = <&cci_control1>;
+};
diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
index 8adf455..f603133 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
@@ -15,6 +15,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/sound/samsung-i2s.h>
 #include "exynos5800.dtsi"
+#include "exynos5422-cpus.dtsi"
 
 / {
 	memory {
-- 
2.1.0
