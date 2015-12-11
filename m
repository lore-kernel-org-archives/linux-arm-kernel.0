From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 11 Dec 2015 15:17:37 +0900
Subject: [PATCH] ARM: dts: Make CPU configuration more readable for
 exynos542x/5800
Message-ID: <1449814657-25685-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Exynos5420 and Exynos5800 boards boot from big core (A15) but
Exynos5420 boards choose otherwise: LITTLE core (A7) (on Exynos5422 this
is property of the board - configurable by pulling up/down gpg2-1).
To make user-visible CPU ordering more consistent the 'cpus' node was
overridden by exynos5422-cpus.dtsi.

However this is a little bit ugly and error-prone. Overriding the CPU
child nodes requires to basically reverse what was done initially in
exynos5420.dtsi.

Instead, split CPU configuration entirely to separate files which should
be included by board DTS.

Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

---

Tested on Exynos5422 based Odroid XU4. Please kindly test on Exynos5420
or Exynos5800 boards.
---
 arch/arm/boot/dts/exynos5420-arndale-octa.dts |   1 +
 arch/arm/boot/dts/exynos5420-cpus.dtsi        |  92 ++++++++++++++++++
 arch/arm/boot/dts/exynos5420-peach-pit.dts    |   1 +
 arch/arm/boot/dts/exynos5420-smdk5420.dts     |   1 +
 arch/arm/boot/dts/exynos5420.dtsi             |  72 +-------------
 arch/arm/boot/dts/exynos5422-cpus.dtsi        | 130 ++++++++++++++------------
 arch/arm/boot/dts/exynos5800-peach-pi.dts     |   1 +
 7 files changed, 170 insertions(+), 128 deletions(-)
 create mode 100644 arch/arm/boot/dts/exynos5420-cpus.dtsi

diff --git a/arch/arm/boot/dts/exynos5420-arndale-octa.dts b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
index 4ecef6981d5c..365eec6f6687 100644
--- a/arch/arm/boot/dts/exynos5420-arndale-octa.dts
+++ b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
@@ -11,6 +11,7 @@
 
 /dts-v1/;
 #include "exynos5420.dtsi"
+#include "exynos5420-cpus.dtsi"
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/input/input.h>
diff --git a/arch/arm/boot/dts/exynos5420-cpus.dtsi b/arch/arm/boot/dts/exynos5420-cpus.dtsi
new file mode 100644
index 000000000000..7aaf0313274f
--- /dev/null
+++ b/arch/arm/boot/dts/exynos5420-cpus.dtsi
@@ -0,0 +1,92 @@
+/*
+ * SAMSUNG EXYNOS5420 SoC cpu device tree source
+ *
+ * Copyright (c) 2015 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * This file provides desired ordering for Exynos5420 and Exynos5800
+ * boards: CPU[0123] being the A15.
+ *
+ * The Exynos5420, 5422 and 5800 actually share the same CPU configuration
+ * but particular boards choose different booting order.
+ *
+ * Exynos5420 and Exynos5800 always boot from Cortex-A15. On Exynos5422
+ * booting cluster (big or LITTLE) is chosen by IROM code by reading
+ * the gpg2-1 GPIO. By default all Exynos5422 based boards choose booting
+ * from the LITTLE: Cortex-A7.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/ {
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <0x0>;
+			clock-frequency = <1800000000>;
+			cci-control-port = <&cci_control1>;
+		};
+
+		cpu1: cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <0x1>;
+			clock-frequency = <1800000000>;
+			cci-control-port = <&cci_control1>;
+		};
+
+		cpu2: cpu at 2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <0x2>;
+			clock-frequency = <1800000000>;
+			cci-control-port = <&cci_control1>;
+		};
+
+		cpu3: cpu at 3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <0x3>;
+			clock-frequency = <1800000000>;
+			cci-control-port = <&cci_control1>;
+		};
+
+		cpu4: cpu at 100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x100>;
+			clock-frequency = <1000000000>;
+			cci-control-port = <&cci_control0>;
+		};
+
+		cpu5: cpu at 101 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x101>;
+			clock-frequency = <1000000000>;
+			cci-control-port = <&cci_control0>;
+		};
+
+		cpu6: cpu at 102 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x102>;
+			clock-frequency = <1000000000>;
+			cci-control-port = <&cci_control0>;
+		};
+
+		cpu7: cpu at 103 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x103>;
+			clock-frequency = <1000000000>;
+			cci-control-port = <&cci_control0>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index 35cfb07dc4bb..61a0c0df337a 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -15,6 +15,7 @@
 #include <dt-bindings/clock/maxim,max77802.h>
 #include <dt-bindings/regulator/maxim,max77802.h>
 #include "exynos5420.dtsi"
+#include "exynos5420-cpus.dtsi"
 
 / {
 	model = "Google Peach Pit Rev 6+";
diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts b/arch/arm/boot/dts/exynos5420-smdk5420.dts
index ac35aefd320f..1935a0b671e9 100644
--- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
+++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
@@ -11,6 +11,7 @@
 
 /dts-v1/;
 #include "exynos5420.dtsi"
+#include "exynos5420-cpus.dtsi"
 #include <dt-bindings/gpio/gpio.h>
 
 / {
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 48a0a55314f5..29b7cba93689 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -50,74 +50,10 @@
 		usbdrdphy1 = &usbdrd_phy1;
 	};
 
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		cpu0: cpu at 0 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a15";
-			reg = <0x0>;
-			clock-frequency = <1800000000>;
-			cci-control-port = <&cci_control1>;
-		};
-
-		cpu1: cpu at 1 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a15";
-			reg = <0x1>;
-			clock-frequency = <1800000000>;
-			cci-control-port = <&cci_control1>;
-		};
-
-		cpu2: cpu at 2 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a15";
-			reg = <0x2>;
-			clock-frequency = <1800000000>;
-			cci-control-port = <&cci_control1>;
-		};
-
-		cpu3: cpu at 3 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a15";
-			reg = <0x3>;
-			clock-frequency = <1800000000>;
-			cci-control-port = <&cci_control1>;
-		};
-
-		cpu4: cpu at 100 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a7";
-			reg = <0x100>;
-			clock-frequency = <1000000000>;
-			cci-control-port = <&cci_control0>;
-		};
-
-		cpu5: cpu at 101 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a7";
-			reg = <0x101>;
-			clock-frequency = <1000000000>;
-			cci-control-port = <&cci_control0>;
-		};
-
-		cpu6: cpu at 102 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a7";
-			reg = <0x102>;
-			clock-frequency = <1000000000>;
-			cci-control-port = <&cci_control0>;
-		};
-
-		cpu7: cpu at 103 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a7";
-			reg = <0x103>;
-			clock-frequency = <1000000000>;
-			cci-control-port = <&cci_control0>;
-		};
-	};
+	/*
+	 * The 'cpus' node is not present here but instead it is provided
+	 * by exynos5420-cpus.dtsi or exynos5422-cpus.dtsi.
+	 */
 
 	cci: cci at 10d20000 {
 		compatible = "arm,cci-400";
diff --git a/arch/arm/boot/dts/exynos5422-cpus.dtsi b/arch/arm/boot/dts/exynos5422-cpus.dtsi
index b7f60c855459..33028ac76a33 100644
--- a/arch/arm/boot/dts/exynos5422-cpus.dtsi
+++ b/arch/arm/boot/dts/exynos5422-cpus.dtsi
@@ -4,78 +4,88 @@
  * Copyright (c) 2015 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
  *
- * The only difference between EXYNOS5422 and EXYNOS5800 is cpu ordering. The
- * EXYNOS5422 is booting from Cortex-A7 core while the EXYNOS5800 is booting
- * from Cortex-A15 core.
+ * This file provides desired ordering for Exynos5422: CPU[0123] being the A7.
  *
- * EXYNOS5422 based board files can include this file to provide cpu ordering
- * which could boot a cortex-a7 from cpu0.
+ * The Exynos5420, 5422 and 5800 actually share the same CPU configuration
+ * but particular boards choose different booting order.
+ *
+ * Exynos5420 and Exynos5800 always boot from Cortex-A15. On Exynos5422
+ * booting cluster (big or LITTLE) is chosen by IROM code by reading
+ * the gpg2-1 GPIO. By default all Exynos5422 based boards choose booting
+ * from the LITTLE: Cortex-A7.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
 
-&cpu0 {
-	device_type = "cpu";
-	compatible = "arm,cortex-a7";
-	reg = <0x100>;
-	clock-frequency = <1000000000>;
-	cci-control-port = <&cci_control0>;
-};
+/ {
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
 
-&cpu1 {
-	device_type = "cpu";
-	compatible = "arm,cortex-a7";
-	reg = <0x101>;
-	clock-frequency = <1000000000>;
-	cci-control-port = <&cci_control0>;
-};
+		cpu0: cpu at 100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x100>;
+			clock-frequency = <1000000000>;
+			cci-control-port = <&cci_control0>;
+		};
 
-&cpu2 {
-	device_type = "cpu";
-	compatible = "arm,cortex-a7";
-	reg = <0x102>;
-	clock-frequency = <1000000000>;
-	cci-control-port = <&cci_control0>;
-};
+		cpu1: cpu at 101 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x101>;
+			clock-frequency = <1000000000>;
+			cci-control-port = <&cci_control0>;
+		};
 
-&cpu3 {
-	device_type = "cpu";
-	compatible = "arm,cortex-a7";
-	reg = <0x103>;
-	clock-frequency = <1000000000>;
-	cci-control-port = <&cci_control0>;
-};
+		cpu2: cpu at 102 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x102>;
+			clock-frequency = <1000000000>;
+			cci-control-port = <&cci_control0>;
+		};
 
-&cpu4 {
-	device_type = "cpu";
-	compatible = "arm,cortex-a15";
-	reg = <0x0>;
-	clock-frequency = <1800000000>;
-	cci-control-port = <&cci_control1>;
-};
+		cpu3: cpu at 103 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x103>;
+			clock-frequency = <1000000000>;
+			cci-control-port = <&cci_control0>;
+		};
 
-&cpu5 {
-	device_type = "cpu";
-	compatible = "arm,cortex-a15";
-	reg = <0x1>;
-	clock-frequency = <1800000000>;
-	cci-control-port = <&cci_control1>;
-};
+		cpu4: cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <0x0>;
+			clock-frequency = <1800000000>;
+			cci-control-port = <&cci_control1>;
+		};
 
-&cpu6 {
-	device_type = "cpu";
-	compatible = "arm,cortex-a15";
-	reg = <0x2>;
-	clock-frequency = <1800000000>;
-	cci-control-port = <&cci_control1>;
-};
+		cpu5: cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <0x1>;
+			clock-frequency = <1800000000>;
+			cci-control-port = <&cci_control1>;
+		};
+
+		cpu6: cpu at 2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <0x2>;
+			clock-frequency = <1800000000>;
+			cci-control-port = <&cci_control1>;
+		};
 
-&cpu7 {
-	device_type = "cpu";
-	compatible = "arm,cortex-a15";
-	reg = <0x3>;
-	clock-frequency = <1800000000>;
-	cci-control-port = <&cci_control1>;
+		cpu7: cpu at 3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a15";
+			reg = <0x3>;
+			clock-frequency = <1800000000>;
+			cci-control-port = <&cci_control1>;
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index 064176f201e7..279322b83351 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -15,6 +15,7 @@
 #include <dt-bindings/clock/maxim,max77802.h>
 #include <dt-bindings/regulator/maxim,max77802.h>
 #include "exynos5800.dtsi"
+#include "exynos5420-cpus.dtsi"
 
 / {
 	model = "Google Peach Pi Rev 10+";
-- 
1.9.1
