From: dhaab@luxul.com (Dan Haab)
Date: Tue, 27 Sep 2016 11:27:11 -0600
Subject: [PATCH 2/2] ARM: BCM5301X: Add DT for Luxul XWR-3100
In-Reply-To: <1474997231-27700-1-git-send-email-dhaab@luxul.com>
References: <1474997231-27700-1-git-send-email-dhaab@luxul.com>
Message-ID: <1474997231-27700-2-git-send-email-dhaab@luxul.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Luxul XWR-3100 is a wireless router based on BCM47094 SoC with two
4366c0 FullMAC PCIe cards on the PCB. It uses NAND with BCH-4 ECC
algorithm.

Signed-off-by: Dan Haab <dhaab@luxul.com>
---
 arch/arm/boot/dts/Makefile                    |    1 +
 arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts |  111 +++++++++++++++++++++++++
 arch/arm/boot/dts/bcm5301x-nand-cs0-bch4.dtsi |   13 +++
 3 files changed, 125 insertions(+)
 create mode 100644 arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts
 create mode 100644 arch/arm/boot/dts/bcm5301x-nand-cs0-bch4.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b7fbc1b..e46e2d85 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -88,6 +88,7 @@ dtb-$(CONFIG_ARCH_BCM_5301X) += \
 	bcm4709-netgear-r7000.dtb \
 	bcm4709-netgear-r8000.dtb \
 	bcm47094-dlink-dir-885l.dtb \
+	bcm47094-luxul-xwr-3100.dtb \
 	bcm47094-netgear-r8500.dtb \
 	bcm94708.dtb \
 	bcm94709.dtb \
diff --git a/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts b/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts
new file mode 100644
index 0000000..169b35f
--- /dev/null
+++ b/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts
@@ -0,0 +1,111 @@
+/*
+ * Copyright 2016 Luxul Inc.
+ *
+ * Licensed under the ISC license.
+ */
+
+/dts-v1/;
+
+#include "bcm47094.dtsi"
+#include "bcm5301x-nand-cs0-bch4.dtsi"
+
+/ {
+	compatible = "luxul,xwr-3100v1", "brcm,bcm47094", "brcm,bcm4708";
+	model = "Luxul XWR-3100 V1";
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
+		power	{
+			label = "bcm53xx:green:power";
+			gpios = <&chipcommon 0 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "default-on";
+		};
+
+		lan3	{
+			label = "bcm53xx:green:lan1";
+			gpios = <&chipcommon 1 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "default-off";
+		};
+
+		lan4	{
+			label = "bcm53xx:green:lan0";
+			gpios = <&chipcommon 2 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "default-off";
+		};
+
+		wan	{
+			label = "bcm53xx:green:wan";
+			gpios = <&chipcommon 3 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "default-off";
+		};
+
+		lan1	{
+			label = "bcm53xx:green:lan3";
+			gpios = <&chipcommon 4 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "default-off";
+		};
+
+		lan2	{
+			label = "bcm53xx:green:lan2";
+			gpios = <&chipcommon 6 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "default-off";
+		};
+
+		usb3	{
+			label = "bcm53xx:green:usb3";
+			gpios = <&chipcommon 8 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "default-off";
+		};
+
+		status	{
+			label = "bcm53xx:green:status";
+			gpios = <&chipcommon 10 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "timer";
+		};
+
+		2ghz {
+			label = "bcm53xx:green:2ghz";
+			gpios = <&chipcommon 13 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "default-off";
+		};
+
+		5ghz {
+			label = "bcm53xx:green:5ghz";
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
+};
+
+&usb3 {
+	vcc-gpio = <&chipcommon 18 GPIO_ACTIVE_HIGH>;
+};
+
+&spi_nor {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/bcm5301x-nand-cs0-bch4.dtsi b/arch/arm/boot/dts/bcm5301x-nand-cs0-bch4.dtsi
new file mode 100644
index 0000000..b4e875d
--- /dev/null
+++ b/arch/arm/boot/dts/bcm5301x-nand-cs0-bch4.dtsi
@@ -0,0 +1,13 @@
+/*
+ * Copyright 2016 Luxul Inc.
+ *
+ * Licensed under the ISC license.
+ */
+
+#include "bcm5301x-nand-cs0.dtsi"
+
+&nandcs {
+	nand-ecc-algo = "bch";
+	nand-ecc-strength = <4>;
+	nand-ecc-step-size = <512>;
+};
-- 
1.7.9.5
