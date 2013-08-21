From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Wed, 21 Aug 2013 23:21:51 +0200
Subject: [PATCH v7 7/7] ARM: dts: Add dts file for S3C6410-based SMDK6410 board
In-Reply-To: <1377120111-25601-1-git-send-email-tomasz.figa@gmail.com>
References: <1377120111-25601-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <1377120111-25601-8-git-send-email-tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds basic device tree sources for SAMSUNG SMDK6410 board
based on SAMSUNG S3C6410 SoC.

Currently only UARTs, SD channel 0 and 100Mbps ethernet (SMSC911x) are
supported.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 arch/arm/boot/dts/Makefile             |   3 +-
 arch/arm/boot/dts/s3c6410-smdk6410.dts | 103 +++++++++++++++++++++++++++++++++
 2 files changed, 105 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/s3c6410-smdk6410.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 72f8af3..e55c644 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -194,7 +194,8 @@ dtb-$(CONFIG_ARCH_U8500) += snowball.dtb \
 	ccu8540.dtb \
 	ccu9540.dtb
 dtb-$(CONFIG_ARCH_S3C24XX) += s3c2416-smdk2416.dtb
-dtb-$(CONFIG_ARCH_S3C64XX) += s3c6410-mini6410.dtb
+dtb-$(CONFIG_ARCH_S3C64XX) += s3c6410-mini6410.dtb \
+	s3c6410-smdk6410.dtb
 dtb-$(CONFIG_ARCH_SHMOBILE) += emev2-kzm9d.dtb \
 	emev2-kzm9d-reference.dtb \
 	r8a7740-armadillo800eva.dtb \
diff --git a/arch/arm/boot/dts/s3c6410-smdk6410.dts b/arch/arm/boot/dts/s3c6410-smdk6410.dts
new file mode 100644
index 0000000..ecf35ec
--- /dev/null
+++ b/arch/arm/boot/dts/s3c6410-smdk6410.dts
@@ -0,0 +1,103 @@
+/*
+ * Samsung S3C6410 based SMDK6410 board device tree source.
+ *
+ * Copyright (c) 2013 Tomasz Figa <tomasz.figa@gmail.com>
+ *
+ * Device tree source file for SAMSUNG SMDK6410 board which is based on
+ * Samsung's S3C6410 SoC.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+#include "s3c6410.dtsi"
+
+/ {
+	model = "SAMSUNG SMDK6410 board based on S3C6410";
+	compatible = "samsung,mini6410", "samsung,s3c6410";
+
+	memory {
+		reg = <0x50000000 0x8000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttySAC0,115200n8 earlyprintk rootwait root=/dev/mmcblk0p1";
+	};
+
+	clocks {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		fin_pll: oscillator at 0 {
+			compatible = "fixed-clock";
+			reg = <0>;
+			clock-frequency = <12000000>;
+			clock-output-names = "fin_pll";
+			#clock-cells = <0>;
+		};
+
+		xusbxti: oscillator at 1 {
+			compatible = "fixed-clock";
+			reg = <1>;
+			clock-output-names = "xusbxti";
+			clock-frequency = <48000000>;
+			#clock-cells = <0>;
+		};
+	};
+
+	srom-cs1 at 18000000 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0x18000000 0x8000000>;
+		ranges;
+
+		ethernet at 18000000 {
+			compatible = "smsc,lan9115";
+			reg = <0x18000000 0x10000>;
+			interrupt-parent = <&gpn>;
+			interrupts = <10 IRQ_TYPE_LEVEL_LOW>;
+			phy-mode = "mii";
+			reg-io-width = <4>;
+			smsc,force-internal-phy;
+		};
+	};
+};
+
+&sdhci0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&sd0_clk>, <&sd0_cmd>, <&sd0_cd>, <&sd0_bus4>;
+	bus-width = <4>;
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_data>, <&uart0_fctl>;
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_data>;
+	status = "okay";
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart2_data>;
+	status = "okay";
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart3_data>;
+	status = "okay";
+};
-- 
1.8.3.2
