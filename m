From: riproute@gmail.com (Dan Haab)
Date: Mon,  9 Oct 2017 09:46:59 -0600
Subject: [PATCH 1/2] ARM: dts: BCM53573: Add DT for Luxul XAP-810
Message-ID: <1507564020-7394-1-git-send-email-riproute@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dan Haab <dhaab@luxul.com>

This is BCM53573 WiSoC based access point with an extra BCM43217 chipset
used for 2.4 GHz.

Signed-off-by: Dan Haab <dhaab@luxul.com>
---
 arch/arm/boot/dts/Makefile                   |  1 +
 arch/arm/boot/dts/bcm47189-luxul-xap-810.dts | 87 ++++++++++++++++++++++++++++
 2 files changed, 88 insertions(+)
 create mode 100644 arch/arm/boot/dts/bcm47189-luxul-xap-810.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 2d964c9..5cac283 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -110,6 +110,7 @@ dtb-$(CONFIG_ARCH_BCM_5301X) += \
 	bcm953012hr.dtb \
 	bcm953012k.dtb
 dtb-$(CONFIG_ARCH_BCM_53573) += \
+	bcm47189-luxul-xap-810.dtb \
 	bcm47189-tenda-ac9.dtb \
 	bcm947189acdbmr.dtb
 dtb-$(CONFIG_ARCH_BCM_63XX) += \
diff --git a/arch/arm/boot/dts/bcm47189-luxul-xap-810.dts b/arch/arm/boot/dts/bcm47189-luxul-xap-810.dts
new file mode 100644
index 0000000..214df18
--- /dev/null
+++ b/arch/arm/boot/dts/bcm47189-luxul-xap-810.dts
@@ -0,0 +1,87 @@
+/*
+ * Copyright 2017 Luxul Inc.
+ *
+ * Licensed under the ISC license.
+ */
+
+/dts-v1/;
+
+#include "bcm53573.dtsi"
+
+/ {
+	compatible = "luxul,xap-810-v1", "brcm,bcm47189", "brcm,bcm53573";
+	model = "Luxul XAP-810 V1";
+
+	chosen {
+		bootargs = "earlycon";
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
+			gpios = <&chipcommon 11 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "default-off";
+		};
+
+		system {
+			label = "bcm53xx:green:system";
+			gpios = <&chipcommon 15 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "timer";
+		};
+	};
+
+	pcie0_leds {
+		compatible = "gpio-leds";
+
+		2ghz {
+			label = "bcm53xx:blue:2ghz";
+			gpios = <&pcie0_chipcommon 3 GPIO_ACTIVE_HIGH>;
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
+			gpios = <&chipcommon 7 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
+
+&pcie0 {
+	ranges = <0x00000000 0 0 0 0 0x00100000>;
+	#address-cells = <3>;
+	#size-cells = <2>;
+
+	bridge at 0,0,0 {
+		reg = <0x0000 0 0 0 0>;
+		ranges = <0x00000000 0 0 0 0 0 0 0x00100000>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+
+		wifi at 0,1,0 {
+			reg = <0x0000 0 0 0 0>;
+			ranges = <0x00000000 0 0 0 0x00100000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			pcie0_chipcommon: chipcommon at 0 {
+				reg = <0 0x1000>;
+
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+		};
+	};
+};
-- 
1.9.1
