From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Sat,  9 Feb 2013 21:44:31 +0100
Subject: [PATCH RFC 7/7] ARM: dts: omap3-igep0020: Add SMSC911x LAN chip
 support
In-Reply-To: <1360442671-15216-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1360442671-15216-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1360442671-15216-8-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

IGEPv2 boards has an SMSC LAN9221i ethernet chip connected to
the OMAP3 processor though the General-Purpose Memory Controller.

This patch adds a device node for the ethernet chip so the GPMC
driver will call the gpmc-smsc911x setup code.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 arch/arm/boot/dts/omap3-igep.dtsi    |    6 ++++++
 arch/arm/boot/dts/omap3-igep0020.dts |   24 ++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-igep.dtsi b/arch/arm/boot/dts/omap3-igep.dtsi
index 100eb41..2f02581 100644
--- a/arch/arm/boot/dts/omap3-igep.dtsi
+++ b/arch/arm/boot/dts/omap3-igep.dtsi
@@ -48,6 +48,12 @@
 			0x126 0x0100	/* sdmmc1_dat7.sdmmc1_dat7 INPUT | MODE 0 */
 		>;
 	};
+
+        smsc911x_pins: pinmux_smsc911x_pins {
+                pinctrl-single,pins = <
+                        0x1a2 0x0104    /* mcspi1_cs2.gpio_176 INPUT | MODE4 */
+                >;
+        };
 };
 
 &i2c1 {
diff --git a/arch/arm/boot/dts/omap3-igep0020.dts b/arch/arm/boot/dts/omap3-igep0020.dts
index e2b9849..68b7cf3 100644
--- a/arch/arm/boot/dts/omap3-igep0020.dts
+++ b/arch/arm/boot/dts/omap3-igep0020.dts
@@ -40,6 +40,18 @@
 			gpios = <&twl_gpio 19 1>;
 		};
 	};
+
+        vddvario: regulator-vddvario {
+                compatible = "regulator-fixed";
+                regulator-name = "vddvario";
+                regulator-always-on;
+        };
+
+        vdd33a: regulator-vdd33a {
+                compatible = "regulator-fixed";
+                regulator-name = "vdd33a";
+                regulator-always-on;
+        };
 };
 
 &i2c3 {
@@ -54,3 +66,15 @@
 		reg = <0x50>;
 	};
 };
+
+&gpmc {
+	gpmc_smsc911x at 0 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&smsc911x_pins>;
+		gpmc,cs = <5>; /* IGEP2_SMSC911X_CS */
+		gpmc,gpio_irq = <176>; /* IGEP2_SMSC911X_GPIO */
+		gpmc,flags = <18>; /* SMSC911X_USE_32BIT | SMSC911X_SAVE_MAC_ADDRESS */
+		vmmc-supply = <&vddvario>;
+		vmmc_aux-supply = <&vdd33a>;
+      };
+};
-- 
1.7.7.6
