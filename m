From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Tue, 23 Aug 2016 08:40:32 +0200
Subject: [PATCH] ARM: BCM5301X: Add DT for Netgear R8500
Message-ID: <20160823064034.19316-1-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rafa? Mi?ecki <rafal@milecki.pl>

Netgear R8500 is another BCM47094 device, it just has three BCM4366
wireless chipsets. It's a very standard DT with mostly GPIO devices.

Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
---
 arch/arm/boot/dts/Makefile                   |   1 +
 arch/arm/boot/dts/bcm47094-netgear-r8500.dts | 104 +++++++++++++++++++++++++++
 2 files changed, 105 insertions(+)
 create mode 100644 arch/arm/boot/dts/bcm47094-netgear-r8500.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index dd2c49e..dfdb5fc 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -86,6 +86,7 @@ dtb-$(CONFIG_ARCH_BCM_5301X) += \
 	bcm4709-netgear-r7000.dtb \
 	bcm4709-netgear-r8000.dtb \
 	bcm47094-dlink-dir-885l.dtb \
+	bcm47094-netgear-r8500.dtb \
 	bcm94708.dtb \
 	bcm94709.dtb \
 	bcm953012er.dtb \
diff --git a/arch/arm/boot/dts/bcm47094-netgear-r8500.dts b/arch/arm/boot/dts/bcm47094-netgear-r8500.dts
new file mode 100644
index 0000000..10db4f8
--- /dev/null
+++ b/arch/arm/boot/dts/bcm47094-netgear-r8500.dts
@@ -0,0 +1,104 @@
+/*
+ * Copyright (C) 2016 Rafa? Mi?ecki <rafal@milecki.pl>
+ *
+ * Licensed under the ISC license.
+ */
+
+/dts-v1/;
+
+#include "bcm4708.dtsi"
+#include "bcm5301x-nand-cs0-bch8.dtsi"
+
+/ {
+	compatible = "netgear,r8500", "brcm,bcm47094", "brcm,bcm4708";
+	model = "Netgear R8500";
+
+	chosen {
+		bootargs = "console=ttyS0,115200";
+	};
+
+	memory {
+		reg = <0x00000000 0x08000000>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		power0 {
+			label = "bcm53xx:white:power";
+			gpios = <&chipcommon 2 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "default-on";
+		};
+
+		power1 {
+			label = "bcm53xx:amber:power";
+			gpios = <&chipcommon 3 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "default-off";
+		};
+
+		5ghz-1 {
+			label = "bcm53xx:white:5ghz-1";
+			gpios = <&chipcommon 11 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "default-off";
+		};
+
+		5ghz-2 {
+			label = "bcm53xx:white:5ghz-2";
+			gpios = <&chipcommon 12 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "default-off";
+		};
+
+		2ghz {
+			label = "bcm53xx:white:2ghz";
+			gpios = <&chipcommon 13 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "default-off";
+		};
+
+		usb2 {
+			label = "bcm53xx:white:usb2";
+			gpios = <&chipcommon 17 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "default-off";
+		};
+
+		usb3 {
+			label = "bcm53xx:white:usb3";
+			gpios = <&chipcommon 18 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "default-off";
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		brightness {
+			label = "Backlight";
+			linux,code = <KEY_BRIGHTNESS_ZERO>;
+			gpios = <&chipcommon 1 GPIO_ACTIVE_LOW>;
+		};
+
+		restart {
+			label = "Reset";
+			linux,code = <KEY_RESTART>;
+			gpios = <&chipcommon 10 GPIO_ACTIVE_LOW>;
+		};
+
+		wps {
+			label = "WPS";
+			linux,code = <KEY_WPS_BUTTON>;
+			gpios = <&chipcommon 14 GPIO_ACTIVE_LOW>;
+		};
+
+		rfkill {
+			label = "WiFi";
+			linux,code = <KEY_RFKILL>;
+			gpios = <&chipcommon 20 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
+
+&uart0 {
+	status = "okay";
+	clock-frequency = <125000000>;
+};
-- 
2.9.3
