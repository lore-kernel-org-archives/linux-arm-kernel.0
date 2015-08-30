From: j@jannau.net (Janne Grunau)
Date: Sun, 30 Aug 2015 17:24:29 +0200
Subject: [PATCH 1/2] arm64/apm: create X-Gene storm chip variant dtsi
In-Reply-To: <1440948270-1991-1-git-send-email-j@jannau.net>
References: <1440948270-1991-1-git-send-email-j@jannau.net>
Message-ID: <1440948270-1991-2-git-send-email-j@jannau.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CPU and timer table and GIC registers differ between APM883208 and
APM883408 chip variants.  Move them to their own file so the soc node in
apm-storm.dtsi can be shared.

Signed-off-by: Janne Grunau <j@jannau.net>
---
 arch/arm64/boot/dts/apm/apm-mustang.dts       |  1 +
 arch/arm64/boot/dts/apm/apm-storm-883208.dtsi | 99 +++++++++++++++++++++++++++
 arch/arm64/boot/dts/apm/apm-storm.dtsi        | 87 -----------------------
 3 files changed, 100 insertions(+), 87 deletions(-)
 create mode 100644 arch/arm64/boot/dts/apm/apm-storm-883208.dtsi

diff --git a/arch/arm64/boot/dts/apm/apm-mustang.dts b/arch/arm64/boot/dts/apm/apm-mustang.dts
index 4c55833..096e5ec 100644
--- a/arch/arm64/boot/dts/apm/apm-mustang.dts
+++ b/arch/arm64/boot/dts/apm/apm-mustang.dts
@@ -11,6 +11,7 @@
 
 /dts-v1/;
 
+/include/ "apm-storm-883208.dtsi"
 /include/ "apm-storm.dtsi"
 
 / {
diff --git a/arch/arm64/boot/dts/apm/apm-storm-883208.dtsi b/arch/arm64/boot/dts/apm/apm-storm-883208.dtsi
new file mode 100644
index 0000000..e4daaf9
--- /dev/null
+++ b/arch/arm64/boot/dts/apm/apm-storm-883208.dtsi
@@ -0,0 +1,99 @@
+/*
+ * dts file for AppliedMicro (APM) X-Gene Storm SOC
+ *
+ * Copyright (C) 2013, Applied Micro Circuits Corporation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ */
+
+/ {
+	compatible = "apm,xgene-storm";
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
+			compatible = "apm,potenza", "arm,armv8";
+			reg = <0x0 0x000>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x1 0x0000fff8>;
+		};
+		cpu at 001 {
+			device_type = "cpu";
+			compatible = "apm,potenza", "arm,armv8";
+			reg = <0x0 0x001>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x1 0x0000fff8>;
+		};
+		cpu at 100 {
+			device_type = "cpu";
+			compatible = "apm,potenza", "arm,armv8";
+			reg = <0x0 0x100>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x1 0x0000fff8>;
+		};
+		cpu at 101 {
+			device_type = "cpu";
+			compatible = "apm,potenza", "arm,armv8";
+			reg = <0x0 0x101>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x1 0x0000fff8>;
+		};
+		cpu at 200 {
+			device_type = "cpu";
+			compatible = "apm,potenza", "arm,armv8";
+			reg = <0x0 0x200>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x1 0x0000fff8>;
+		};
+		cpu at 201 {
+			device_type = "cpu";
+			compatible = "apm,potenza", "arm,armv8";
+			reg = <0x0 0x201>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x1 0x0000fff8>;
+		};
+		cpu at 300 {
+			device_type = "cpu";
+			compatible = "apm,potenza", "arm,armv8";
+			reg = <0x0 0x300>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x1 0x0000fff8>;
+		};
+		cpu at 301 {
+			device_type = "cpu";
+			compatible = "apm,potenza", "arm,armv8";
+			reg = <0x0 0x301>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x1 0x0000fff8>;
+		};
+	};
+
+	gic: interrupt-controller at 78010000 {
+		compatible = "arm,cortex-a15-gic";
+		#interrupt-cells = <3>;
+		interrupt-controller;
+		reg = <0x0 0x78010000 0x0 0x1000>,	/* GIC Dist */
+		      <0x0 0x78020000 0x0 0x1000>,	/* GIC CPU */
+		      <0x0 0x78040000 0x0 0x2000>,	/* GIC VCPU Control */
+		      <0x0 0x78060000 0x0 0x2000>;	/* GIC VCPU */
+		interrupts = <1 9 0xf04>;	/* GIC Maintenence IRQ */
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <1 0 0xff01>,	/* Secure Phys IRQ */
+			     <1 13 0xff01>,	/* Non-secure Phys IRQ */
+			     <1 14 0xff01>,	/* Virt IRQ */
+			     <1 15 0xff01>;	/* Hyp IRQ */
+		clock-frequency = <50000000>;
+	};
+};
diff --git a/arch/arm64/boot/dts/apm/apm-storm.dtsi b/arch/arm64/boot/dts/apm/apm-storm.dtsi
index 58093ed..4177b3d 100644
--- a/arch/arm64/boot/dts/apm/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm/apm-storm.dtsi
@@ -10,93 +10,6 @@
  */
 
 / {
-	compatible = "apm,xgene-storm";
-	interrupt-parent = <&gic>;
-	#address-cells = <2>;
-	#size-cells = <2>;
-
-	cpus {
-		#address-cells = <2>;
-		#size-cells = <0>;
-
-		cpu at 000 {
-			device_type = "cpu";
-			compatible = "apm,potenza", "arm,armv8";
-			reg = <0x0 0x000>;
-			enable-method = "spin-table";
-			cpu-release-addr = <0x1 0x0000fff8>;
-		};
-		cpu at 001 {
-			device_type = "cpu";
-			compatible = "apm,potenza", "arm,armv8";
-			reg = <0x0 0x001>;
-			enable-method = "spin-table";
-			cpu-release-addr = <0x1 0x0000fff8>;
-		};
-		cpu at 100 {
-			device_type = "cpu";
-			compatible = "apm,potenza", "arm,armv8";
-			reg = <0x0 0x100>;
-			enable-method = "spin-table";
-			cpu-release-addr = <0x1 0x0000fff8>;
-		};
-		cpu at 101 {
-			device_type = "cpu";
-			compatible = "apm,potenza", "arm,armv8";
-			reg = <0x0 0x101>;
-			enable-method = "spin-table";
-			cpu-release-addr = <0x1 0x0000fff8>;
-		};
-		cpu at 200 {
-			device_type = "cpu";
-			compatible = "apm,potenza", "arm,armv8";
-			reg = <0x0 0x200>;
-			enable-method = "spin-table";
-			cpu-release-addr = <0x1 0x0000fff8>;
-		};
-		cpu at 201 {
-			device_type = "cpu";
-			compatible = "apm,potenza", "arm,armv8";
-			reg = <0x0 0x201>;
-			enable-method = "spin-table";
-			cpu-release-addr = <0x1 0x0000fff8>;
-		};
-		cpu at 300 {
-			device_type = "cpu";
-			compatible = "apm,potenza", "arm,armv8";
-			reg = <0x0 0x300>;
-			enable-method = "spin-table";
-			cpu-release-addr = <0x1 0x0000fff8>;
-		};
-		cpu at 301 {
-			device_type = "cpu";
-			compatible = "apm,potenza", "arm,armv8";
-			reg = <0x0 0x301>;
-			enable-method = "spin-table";
-			cpu-release-addr = <0x1 0x0000fff8>;
-		};
-	};
-
-	gic: interrupt-controller at 78010000 {
-		compatible = "arm,cortex-a15-gic";
-		#interrupt-cells = <3>;
-		interrupt-controller;
-		reg = <0x0 0x78010000 0x0 0x1000>,	/* GIC Dist */
-		      <0x0 0x78020000 0x0 0x1000>,	/* GIC CPU */
-		      <0x0 0x78040000 0x0 0x2000>,	/* GIC VCPU Control */
-		      <0x0 0x78060000 0x0 0x2000>;	/* GIC VCPU */
-		interrupts = <1 9 0xf04>;	/* GIC Maintenence IRQ */
-	};
-
-	timer {
-		compatible = "arm,armv8-timer";
-		interrupts = <1 0 0xff01>,	/* Secure Phys IRQ */
-			     <1 13 0xff01>,	/* Non-secure Phys IRQ */
-			     <1 14 0xff01>,	/* Virt IRQ */
-			     <1 15 0xff01>;	/* Hyp IRQ */
-		clock-frequency = <50000000>;
-	};
-
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <2>;
-- 
2.5.0
