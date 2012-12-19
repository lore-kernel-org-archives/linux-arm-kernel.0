From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Wed, 19 Dec 2012 14:33:09 +0100
Subject: [PATCH v4 2/3] ARM/dts: omap3: Add support for IGEPv2 board
In-Reply-To: <1355923990-21240-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1355923990-21240-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1355923990-21240-3-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ISEE IGEPv2 is an TI OMAP3 SoC based embedded board.

This patch adds an initial device tree support to boot
an IGEPv2 from the MMC/SD.

Currently is working everything that is supported by DT
on OMAP3 SoCs (MMC/SD, GPIO LEDs, EEPROM, TWL4030 audio).

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Tested-by: Enric Balletbo i Serra <eballetbo@gmail.com>
---

Changes since v1:
    - Use default-state = "on" instead default-trigger = "default-on" for LED

 arch/arm/boot/dts/Makefile           |    1 +
 arch/arm/boot/dts/omap3-igep0020.dts |   56 ++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap3-igep0020.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 0f44174..24b28ba 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -106,6 +106,7 @@ dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap2420-h4.dtb \
 	omap3-beagle-xm.dtb \
 	omap3-evm.dtb \
 	omap3-tobi.dtb \
+	omap3-igep0020.dtb \
 	omap4-panda.dtb \
 	omap4-panda-es.dtb \
 	omap4-var-som.dtb \
diff --git a/arch/arm/boot/dts/omap3-igep0020.dts b/arch/arm/boot/dts/omap3-igep0020.dts
new file mode 100644
index 0000000..e2b9849
--- /dev/null
+++ b/arch/arm/boot/dts/omap3-igep0020.dts
@@ -0,0 +1,56 @@
+/*
+ * Device Tree Source for IGEPv2 board
+ *
+ * Copyright (C) 2012 Javier Martinez Canillas <javier@collabora.co.uk>
+ * Copyright (C) 2012 Enric Balletbo i Serra <eballetbo@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/include/ "omap3-igep.dtsi"
+
+/ {
+	model = "IGEPv2";
+	compatible = "isee,omap3-igep0020", "ti,omap3";
+
+	leds {
+		compatible = "gpio-leds";
+		boot {
+			 label = "omap3:green:boot";
+			 gpios = <&gpio1 26 0>;
+			 default-state = "on";
+		};
+
+		user0 {
+			 label = "omap3:red:user0";
+			 gpios = <&gpio1 27 0>;
+			 default-state = "off";
+		};
+
+		user1 {
+			 label = "omap3:red:user1";
+			 gpios = <&gpio1 28 0>;
+			 default-state = "off";
+		};
+
+		user2 {
+			label = "omap3:green:user1";
+			gpios = <&twl_gpio 19 1>;
+		};
+	};
+};
+
+&i2c3 {
+	clock-frequency = <100000>;
+
+	/*
+	 * Display monitor features are burnt in the EEPROM
+	 * as EDID data.
+	 */
+	eeprom at 50 {
+		compatible = "ti,eeprom";
+		reg = <0x50>;
+	};
+};
-- 
1.7.7.6
