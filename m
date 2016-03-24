From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 24 Mar 2016 17:50:15 +0100
Subject: [PATCH v3 18/18] arm: boot: dts: Add Western Digital My Book World
 Edition device tree
In-Reply-To: <1458838215-23314-1-git-send-email-narmstrong@baylibre.com>
References: <1458838215-23314-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1458838215-23314-19-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Western Digital My Book World Edition device tree based on
PLX Technology OX810SE SoC.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/boot/dts/Makefile    |   2 +
 arch/arm/boot/dts/wd-mbwe.dts | 112 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 114 insertions(+)
 create mode 100644 arch/arm/boot/dts/wd-mbwe.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 52b34a0..3290d4e 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -530,6 +530,8 @@ dtb-$(CONFIG_ARCH_ORION5X) += \
 	orion5x-rd88f5182-nas.dtb
 dtb-$(CONFIG_ARCH_PRIMA2) += \
 	prima2-evb.dtb
+dtb-$(CONFIG_ARCH_OXNAS) += \
+	wd-mbwe.dtb
 dtb-$(CONFIG_ARCH_QCOM) += \
 	qcom-apq8064-cm-qs600.dtb \
 	qcom-apq8064-ifc6410.dtb \
diff --git a/arch/arm/boot/dts/wd-mbwe.dts b/arch/arm/boot/dts/wd-mbwe.dts
new file mode 100644
index 0000000..ac3250a
--- /dev/null
+++ b/arch/arm/boot/dts/wd-mbwe.dts
@@ -0,0 +1,112 @@
+/*
+ * wd-mbwe.dtsi - Device tree file for Western Digital My Book World Edition
+ *
+ * Copyright (C) 2016 Neil Armstrong <narmstrong@baylibre.com>
+ *
+ * Licensed under GPLv2 or later
+ */
+
+/dts-v1/;
+#include "ox810se.dtsi"
+
+/ {
+	model = "Western Digital My Book World Edition";
+
+	compatible = "wd,mbwe", "oxsemi,ox810se";
+
+	chosen {
+		bootargs = "console=ttyS1,115200n8 earlyprintk=serial";
+	};
+
+	memory {
+		/* 128Mbytes DDR */
+		reg = <0x48000000 0x8000000>;
+	};
+
+	aliases {
+		serial1 = &uart1;
+		gpio0 = &gpio0;
+		gpio1 = &gpio1;
+	};
+
+	gpio-keys-polled {
+		compatible = "gpio-keys-polled";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		poll-interval = <100>;
+
+		power {
+			label = "power";
+			gpios = <&gpio0 0 1>;
+			linux,code = <0x198>;
+		};
+
+		recovery {
+			label = "recovery";
+			gpios = <&gpio0 4 1>;
+			linux,code = <0xab>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		a0 {
+			label = "activity0";
+			gpios = <&gpio0 25 0>;
+			default-state = "keep";
+		};
+
+		a1 {
+			label = "activity1";
+			gpios = <&gpio0 26 0>;
+			default-state = "keep";
+		};
+
+		a2 {
+			label = "activity2";
+			gpios = <&gpio0 5 0>;
+			default-state = "keep";
+		};
+
+		a3 {
+			label = "activity3";
+			gpios = <&gpio0 6 0>;
+			default-state = "keep";
+		};
+
+		a4 {
+			label = "activity4";
+			gpios = <&gpio0 7 0>;
+			default-state = "keep";
+		};
+
+		a5 {
+			label = "activity5";
+			gpios = <&gpio1 2 0>;
+			default-state = "keep";
+		};
+	};
+
+	i2c-gpio {
+		compatible = "i2c-gpio";
+		gpios = <&gpio0 3 0 /* sda */
+			 &gpio0 2 0 /* scl */
+			 >;
+		i2c-gpio,delay-us = <2>;        /* ~100 kHz */
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		rtc0: rtc at 48 {
+			compatible = "st,m41t00";
+			reg = <0x68>;
+		};
+	};
+};
+
+&uart1 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+};
-- 
1.9.1
