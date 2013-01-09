From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Thu, 10 Jan 2013 00:41:48 +0100
Subject: [RFC PATCH 6/7] ARM: dts: Add basic dts include files for Samsung
 S3C64xx SoCs
In-Reply-To: <1357774909-29938-1-git-send-email-tomasz.figa@gmail.com>
References: <1357774909-29938-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <1357774909-29938-7-git-send-email-tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds basic device tree definitions for Samsung S3C64xx SoCs.

Since all the SoCs in the series are very similar, the files are created
hierarchically - one file for the whole series and then separate files
for particular SoCs including the common one.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 arch/arm/boot/dts/s3c6400.dtsi | 33 +++++++++++++++++++
 arch/arm/boot/dts/s3c6410.dtsi | 33 +++++++++++++++++++
 arch/arm/boot/dts/s3c64xx.dtsi | 73 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 139 insertions(+)
 create mode 100644 arch/arm/boot/dts/s3c6400.dtsi
 create mode 100644 arch/arm/boot/dts/s3c6410.dtsi
 create mode 100644 arch/arm/boot/dts/s3c64xx.dtsi

diff --git a/arch/arm/boot/dts/s3c6400.dtsi b/arch/arm/boot/dts/s3c6400.dtsi
new file mode 100644
index 0000000..8c77a81
--- /dev/null
+++ b/arch/arm/boot/dts/s3c6400.dtsi
@@ -0,0 +1,33 @@
+/*
+ * Samsung's S3C6400 SoC device tree source
+ *
+ * Copyright (c) 2012 Tomasz Figa <tomasz.figa@gmail.com>
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
index 0000000..faefaffc
--- /dev/null
+++ b/arch/arm/boot/dts/s3c6410.dtsi
@@ -0,0 +1,33 @@
+/*
+ * Samsung's S3C6410 SoC device tree source
+ *
+ * Copyright (c) 2012 Tomasz Figa <tomasz.figa@gmail.com>
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
index 0000000..75a1f8a
--- /dev/null
+++ b/arch/arm/boot/dts/s3c64xx.dtsi
@@ -0,0 +1,73 @@
+/*
+ * Samsung's S3C64xx SoC series common device tree source
+ *
+ * Copyright (c) 2012 Tomasz Figa <tomasz.figa@gmail.com>
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
+		cpu at 0 {
+			compatible = "arm,arm1176jzf-s";
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
+	serial at 7f005000 {
+		compatible = "samsung,s3c6400-uart";
+		reg = <0x7f005000 0x100>;
+		interrupt-parent = <&vic1>;
+		interrupts = <5 0>;
+		status = "disabled";
+	};
+
+	serial at 7f005400 {
+		compatible = "samsung,s3c6400-uart";
+		reg = <0x7f005400 0x100>;
+		interrupt-parent = <&vic1>;
+		interrupts = <6 0>;
+		status = "disabled";
+	};
+
+	serial at 7f005800 {
+		compatible = "samsung,s3c6400-uart";
+		reg = <0x7f005800 0x100>;
+		interrupt-parent = <&vic1>;
+		interrupts = <7 0>;
+		status = "disabled";
+	};
+
+	serial at 7f005c00 {
+		compatible = "samsung,s3c6400-uart";
+		reg = <0x7f005c00 0x100>;
+		interrupt-parent = <&vic1>;
+		interrupts = <8 0>;
+		status = "disabled";
+	};
+};
-- 
1.8.1
