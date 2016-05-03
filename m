From: dhaab@luxul.com (Dan Haab)
Date: Tue, 3 May 2016 11:28:16 -0600
Subject: [PATCH] ARM: BCM5301X: Add DT for Luxul XAP-1510
Message-ID: <1462296501-5209-1-git-send-email-dhaab@luxul.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Luxul XAP-1510 is an AP device based on BCM4708 SoC. It uses flash
memory connected to the SPI controller.

Signed-off-by: Dan Haab <dhaab@luxul.com>
---
 arch/arm/boot/dts/Makefile                   |    1 +
 arch/arm/boot/dts/bcm4708-luxul-xap-1510.dts |   67 ++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)
 create mode 100644 arch/arm/boot/dts/bcm4708-luxul-xap-1510.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 95c1923..c499d09 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -71,6 +71,7 @@ dtb-$(CONFIG_ARCH_BCM_5301X) += \
 	bcm4708-asus-rt-ac56u.dtb \
 	bcm4708-asus-rt-ac68u.dtb \
 	bcm4708-buffalo-wzr-1750dhp.dtb \
+	bcm4708-luxul-xap-1510.dtb \
 	bcm4708-luxul-xwc-1000.dtb \
 	bcm4708-netgear-r6250.dtb \
 	bcm4708-netgear-r6300-v2.dtb \
diff --git a/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dts b/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dts
new file mode 100644
index 0000000..f4460b5
--- /dev/null
+++ b/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dts
@@ -0,0 +1,67 @@
+/*
+ * Broadcom BCM470X / BCM5301X ARM platform code.
+ * DTS for Luxul XAP-1510
+ *
+ * Copyright 2015 Luxul Inc.
+ *
+ * Licensed under the GNU/GPL. See COPYING for details.
+ */
+
+/dts-v1/;
+
+#include "bcm4708.dtsi"
+
+/ {
+	compatible = "luxul,xap-1510v1", "brcm,bcm4708";
+	model = "Luxul XAP-1510 V1";
+
+	chosen {
+		bootargs = "console=ttyS0,115200 earlycon";
+	};
+
+	memory {
+		reg = <0x00000000 0x08000000>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		5ghz {
+			label = "bcm53xx:blue:5ghz";
+			gpios = <&chipcommon 13 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "none";
+		};
+
+		2ghz {
+			label = "bcm53xx:blue:2ghz";
+			gpios = <&chipcommon 14 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "none";
+		};
+
+		status {
+			label = "bcm53xx:green:status";
+			gpios = <&chipcommon 15 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "timer";
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		restart {
+			label = "Reset";
+			linux,code = <KEY_RESTART>;
+			gpios = <&chipcommon 11 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&spi_nor {
+	status = "okay";
+};
-- 
1.7.9.5
