From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sun, 10 Feb 2013 14:54:42 +0100
Subject: [PATCH v2 3/4] ARM: dts: Add basic dts include files for Samsung
 S3C64xx SoCs
In-Reply-To: <1360504483-3465-1-git-send-email-tomasz.figa@gmail.com>
References: <1360504483-3465-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <1360504483-3465-4-git-send-email-tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds basic device tree definitions for Samsung S3C64xx SoCs.

Since all the SoCs in the series are very similar, the files are created
hierarchically - one file for the whole series and then separate files
for particular SoCs including the common one.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 arch/arm/boot/dts/s3c6400.dtsi |  33 +++++++++++++
 arch/arm/boot/dts/s3c6410.dtsi |  33 +++++++++++++
 arch/arm/boot/dts/s3c64xx.dtsi | 108 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 174 insertions(+)
 create mode 100644 arch/arm/boot/dts/s3c6400.dtsi
 create mode 100644 arch/arm/boot/dts/s3c6410.dtsi
 create mode 100644 arch/arm/boot/dts/s3c64xx.dtsi

diff --git a/arch/arm/boot/dts/s3c6400.dtsi b/arch/arm/boot/dts/s3c6400.dtsi
new file mode 100644
index 0000000..76106b8
--- /dev/null
+++ b/arch/arm/boot/dts/s3c6400.dtsi
@@ -0,0 +1,33 @@
+/*
+ * Samsung's S3C6400 SoC device tree source
+ *
+ * Copyright (c) 2013 Tomasz Figa <tomasz.figa@gmail.com>
+ *
+ * Samsung's S3C6400 SoC device nodes are listed in this file. S3C6400
+ * based board files can include this file and provide values for board specfic
+ * bindings.
+ *
+ * Note: This file does not include device nodes for all the controllers in
+ * S3C6400 SoC. As device tree coverage for S3C6400 increases, additional
+ * nodes can be added to this file.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+/include/ "s3c64xx.dtsi"
+
+/ {
+	compatible = "samsung,s3c6400";
+
+	vic0: interrupt-controller at 71200000 {
+		interrupt-mask = <0xfffffe1f>;
+		wakeup-mask = <0x00200004>;
+	};
+
+	vic1: interrupt-controller at 71300000 {
+		interrupt-mask = <0xffffffff>;
+		wakeup-mask = <0x53020000>;
+	};
+};
diff --git a/arch/arm/boot/dts/s3c6410.dtsi b/arch/arm/boot/dts/s3c6410.dtsi
new file mode 100644
index 0000000..4a74df9
--- /dev/null
+++ b/arch/arm/boot/dts/s3c6410.dtsi
@@ -0,0 +1,33 @@
+/*
+ * Samsung's S3C6410 SoC device tree source
+ *
+ * Copyright (c) 2013 Tomasz Figa <tomasz.figa@gmail.com>
+ *
+ * Samsung's S3C6410 SoC device nodes are listed in this file. S3C6410
+ * based board files can include this file and provide values for board specfic
+ * bindings.
+ *
+ * Note: This file does not include device nodes for all the controllers in
+ * S3C6410 SoC. As device tree coverage for S3C6410 increases, additional
+ * nodes can be added to this file.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+/include/ "s3c64xx.dtsi"
+
+/ {
+	compatible = "samsung,s3c6410";
+
+	vic0: interrupt-controller at 71200000 {
+		interrupt-mask = <0xffffff7f>;
+		wakeup-mask = <0x00200004>;
+	};
+
+	vic1: interrupt-controller at 71300000 {
+		interrupt-mask = <0xffffffff>;
+		wakeup-mask = <0x53020000>;
+	};
+};
diff --git a/arch/arm/boot/dts/s3c64xx.dtsi b/arch/arm/boot/dts/s3c64xx.dtsi
new file mode 100644
index 0000000..a9a394f
--- /dev/null
+++ b/arch/arm/boot/dts/s3c64xx.dtsi
@@ -0,0 +1,108 @@
+/*
+ * Samsung's S3C64xx SoC series common device tree source
+ *
+ * Copyright (c) 2013 Tomasz Figa <tomasz.figa@gmail.com>
+ *
+ * Samsung's S3C64xx SoC series device nodes are listed in this file.
+ * Particular SoCs from S3C64xx series can include this file and provide
+ * values for SoCs specfic bindings.
+ *
+ * Note: This file does not include device nodes for all the controllers in
+ * S3C64xx SoCs. As device tree coverage for S3C64xx increases, additional
+ * nodes can be added to this file.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/include/ "skeleton.dtsi"
+
+/ {
+	cpus {
+		cpu {
+			compatible = "arm,arm1176jzf-s", "arm,arm1176";
+		};
+	};
+
+	vic0: interrupt-controller at 71200000 {
+		compatible = "arm,pl192-vic";
+		interrupt-controller;
+		reg = <0x71200000 0x1000>;
+		#interrupt-cells = <1>;
+	};
+
+	vic1: interrupt-controller at 71300000 {
+		compatible = "arm,pl192-vic";
+		interrupt-controller;
+		reg = <0x71300000 0x1000>;
+		#interrupt-cells = <1>;
+	};
+
+	timer at 7f006000 {
+		compatible = "samsung,s3c64xx-pwm-timer";
+		reg = <0x7f006000 0x1000>;
+		interrupt-parent = <&vic0>;
+		interrupts = <23>, <24>, <25>, <27>, <28>;
+		samsung,source-timer = <4>;
+		samsung,event-timer = <3>;
+		samsung,prescale = <2>;
+		samsung,divisor = <1>;
+	};
+
+	serial at 7f005000 {
+		compatible = "samsung,s3c6400-uart";
+		reg = <0x7f005000 0x100>;
+		interrupt-parent = <&vic1>;
+		interrupts = <5>;
+		status = "disabled";
+	};
+
+	serial at 7f005400 {
+		compatible = "samsung,s3c6400-uart";
+		reg = <0x7f005400 0x100>;
+		interrupt-parent = <&vic1>;
+		interrupts = <6>;
+		status = "disabled";
+	};
+
+	serial at 7f005800 {
+		compatible = "samsung,s3c6400-uart";
+		reg = <0x7f005800 0x100>;
+		interrupt-parent = <&vic1>;
+		interrupts = <7>;
+		status = "disabled";
+	};
+
+	serial at 7f005c00 {
+		compatible = "samsung,s3c6400-uart";
+		reg = <0x7f005c00 0x100>;
+		interrupt-parent = <&vic1>;
+		interrupts = <8>;
+		status = "disabled";
+	};
+
+	sdhci at 7c200000 {
+		compatible = "samsung,s3c6410-sdhci";
+		reg = <0x7c200000 0x100>;
+		interrupt-parent = <&vic1>;
+		interrupts = <24>;
+		status = "disabled";
+	};
+
+	sdhci at 7c300000 {
+		compatible = "samsung,s3c6410-sdhci";
+		reg = <0x7c300000 0x100>;
+		interrupt-parent = <&vic1>;
+		interrupts = <25>;
+		status = "disabled";
+	};
+
+	sdhci at 7c400000 {
+		compatible = "samsung,s3c6410-sdhci";
+		reg = <0x7c400000 0x100>;
+		interrupt-parent = <&vic1>;
+		interrupts = <17>;
+		status = "disabled";
+	};
+};
-- 
1.8.1.2
