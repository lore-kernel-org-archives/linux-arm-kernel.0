From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Sun, 24 Jan 2016 22:29:24 +0100
Subject: [PATCH] ARM: BCM5301X: Add DT for D-Link DIR-885L
Message-ID: <1453670964-23572-1-git-send-email-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
---
 arch/arm/boot/dts/Makefile                |   1 +
 arch/arm/boot/dts/bcm47094-dlink-885l.dts | 112 ++++++++++++++++++++++++++++++
 2 files changed, 113 insertions(+)
 create mode 100644 arch/arm/boot/dts/bcm47094-dlink-885l.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index eab8a7f..bf9c185 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -76,6 +76,7 @@ dtb-$(CONFIG_ARCH_BCM_5301X) += \
 	bcm4709-buffalo-wxr-1900dhp.dtb \
 	bcm4709-netgear-r7000.dtb \
 	bcm4709-netgear-r8000.dtb \
+	bcm47094-dlink-885l.dtb \
 	bcm94708.dtb \
 	bcm94709.dtb \
 	bcm953012k.dtb
diff --git a/arch/arm/boot/dts/bcm47094-dlink-885l.dts b/arch/arm/boot/dts/bcm47094-dlink-885l.dts
new file mode 100644
index 0000000..bc622d9
--- /dev/null
+++ b/arch/arm/boot/dts/bcm47094-dlink-885l.dts
@@ -0,0 +1,112 @@
+/*
+ * Broadcom BCM470X / BCM5301X ARM platform code.
+ * DTS for D-Link DIR-885L
+ *
+ * Copyright (C) 2016 Rafa? Mi?ecki <zajec5@gmail.com>
+ *
+ * Licensed under the GNU/GPL. See COPYING for details.
+ */
+
+/dts-v1/;
+
+#include "bcm4708.dtsi"
+#include "bcm5301x-nand-cs0-bch8.dtsi"
+
+/ {
+	compatible = "dlink,dir-885l", "brcm,bcm47094", "brcm,bcm4708";
+	model = "D-Link DIR-885L";
+
+	chosen {
+		bootargs = "console=ttyS0,115200 earlyprintk";
+	};
+
+	memory {
+		reg = <0x00000000 0x08000000
+		       0x88000000 0x08000000>;
+	};
+
+	nand: nand at 18028000 {
+		nandcs at 0 {
+			partition at 0 {
+				label = "firmware";
+				reg = <0x00000000 0x08000000>;
+			};
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		power-white {
+			label = "bcm53xx:white:power";
+			gpios = <&chipcommon 0 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "default-on";
+		};
+
+		wan-white {
+			label = "bcm53xx:white:wan";
+			gpios = <&chipcommon 1 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "default-off";
+		};
+
+		power-amber {
+			label = "bcm53xx:amber:power";
+			gpios = <&chipcommon 2 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "default-off";
+		};
+
+		wan-amber {
+			label = "bcm53xx:amber:wan";
+			gpios = <&chipcommon 3 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "default-off";
+		};
+
+		usb3-white {
+			label = "bcm53xx:white:usb3";
+			gpios = <&chipcommon 8 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "default-off";
+		};
+
+		2ghz {
+			label = "bcm53xx:white:2ghz";
+			gpios = <&chipcommon 13 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "default-off";
+		};
+
+		5ghz {
+			label = "bcm53xx:white:5ghz";
+			gpios = <&chipcommon 14 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "default-off";
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		wps {
+			label = "WPS";
+			linux,code = <KEY_WPS_BUTTON>;
+			gpios = <&chipcommon 7 GPIO_ACTIVE_LOW>;
+		};
+
+		/* Switch: router / extender */
+		extender {
+			label = "Extender";
+			linux,code = <BTN_0>;
+			gpios = <&chipcommon 10 GPIO_ACTIVE_LOW>;
+		};
+
+		restart {
+			label = "Reset";
+			linux,code = <KEY_RESTART>;
+			gpios = <&chipcommon 17 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
+
+&uart0 {
+	status = "okay";
+	clock-frequency = <125000000>;
+};
-- 
1.8.4.5
