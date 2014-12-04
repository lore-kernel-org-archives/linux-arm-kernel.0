From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Thu,  4 Dec 2014 10:23:33 +0100
Subject: [PATCH V2 4/5] ARM: BCM5301X: Add DT for Asus RT-N18U
In-Reply-To: <1417368513-13808-4-git-send-email-zajec5@gmail.com>
References: <1417368513-13808-4-git-send-email-zajec5@gmail.com>
Message-ID: <1417685013-1325-1-git-send-email-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
---
V2: Use (C) instad of UTF ?
    Use "brcm,bcm4708" compatibility after "brcm,bcm47081"
---
 arch/arm/boot/dts/Makefile                  |  3 +-
 arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts | 78 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/bcm47081.dtsi             | 26 ++++++++++
 3 files changed, 106 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts
 create mode 100644 arch/arm/boot/dts/bcm47081.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 18a21d9..db51a31 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -58,7 +58,8 @@ dtb-$(CONFIG_ARCH_BCM2835) += bcm2835-rpi-b-plus.dtb
 dtb-$(CONFIG_ARCH_BCM_5301X) += \
 	bcm4708-buffalo-wzr-1750dhp.dtb \
 	bcm4708-netgear-r6250.dtb \
-	bcm4708-netgear-r6300-v2.dtb
+	bcm4708-netgear-r6300-v2.dtb \
+	bcm47081-asus-rt-n18u.dtb
 dtb-$(CONFIG_ARCH_BCM_63XX) += bcm963138dvt.dtb
 dtb-$(CONFIG_ARCH_BCM_CYGNUS) += bcm911360_entphn.dtb \
 	bcm911360k.dtb \
diff --git a/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts b/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts
new file mode 100644
index 0000000..fb76378
--- /dev/null
+++ b/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts
@@ -0,0 +1,78 @@
+/*
+ * Broadcom BCM470X / BCM5301X ARM platform code.
+ * DTS for Asus RT-N18U
+ *
+ * Copyright (C) 2014 Rafa? Mi?ecki <zajec5@gmail.com>
+ *
+ * Licensed under the GNU/GPL. See COPYING for details.
+ */
+
+/dts-v1/;
+
+#include "bcm47081.dtsi"
+
+/ {
+	compatible = "asus,rt-n18u", "brcm,bcm47081", "brcm,bcm4708";
+	model = "Asus RT-N18U (BCM47081)";
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
+		power {
+			label = "bcm53xx:blue:power";
+			gpios = <&chipcommon 0 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "default-on";
+		};
+
+		usb2 {
+			label = "bcm53xx:blue:usb2";
+			gpios = <&chipcommon 3 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "default-off";
+		};
+
+		wan {
+			label = "bcm53xx:blue:wan";
+			gpios = <&chipcommon 6 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "default-on";
+		};
+
+		lan {
+			label = "bcm53xx:blue:lan";
+			gpios = <&chipcommon 9 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "default-on";
+		};
+
+		usb3 {
+			label = "bcm53xx:blue:usb3";
+			gpios = <&chipcommon 14 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "default-off";
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		poll-interval = <200>;
+
+		restart {
+			label = "Reset";
+			linux,code = <KEY_RESTART>;
+			gpios = <&chipcommon 7 GPIO_ACTIVE_LOW>;
+		};
+
+		wps {
+			label = "WPS";
+			linux,code = <KEY_WPS_BUTTON>;
+			gpios = <&chipcommon 11 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/bcm47081.dtsi b/arch/arm/boot/dts/bcm47081.dtsi
new file mode 100644
index 0000000..f720012
--- /dev/null
+++ b/arch/arm/boot/dts/bcm47081.dtsi
@@ -0,0 +1,26 @@
+/*
+ * Broadcom BCM470X / BCM5301X ARM platform code.
+ * DTS for BCM47081 SoC.
+ *
+ * Copyright ? 2014 Rafa? Mi?ecki <zajec5@gmail.com>
+ *
+ * Licensed under the GNU/GPL. See COPYING for details.
+ */
+
+#include "bcm5301x.dtsi"
+
+/ {
+	compatible = "brcm,bcm47081";
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			next-level-cache = <&L2>;
+			reg = <0x0>;
+		};
+	};
+};
-- 
1.8.4.5
