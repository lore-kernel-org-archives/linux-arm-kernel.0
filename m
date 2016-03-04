From: eric@anholt.net (Eric Anholt)
Date: Fri,  4 Mar 2016 12:32:08 -0800
Subject: [PATCH 3/3] ARM: bcm2835: Add VC4 to the device tree.
In-Reply-To: <1457123528-13482-1-git-send-email-eric@anholt.net>
References: <1457123528-13482-1-git-send-email-eric@anholt.net>
Message-ID: <1457123528-13482-4-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

VC4 is the GPU (display and 3D) present on the 283x.

Signed-off-by: Eric Anholt <eric@anholt.net>
---

v2: Sort by register address, mark HDMI as disabled by default in the
    SoC file and enable it from -rpi.
v3: Add references to the pixel/HSM clocks for HDMI.  Rename
    compatibility strings and clean up node names.
v4: Fix comment marking pv0's interrupt as pwa2 instead of pwa0.
    Rename hpd-gpio to hpd-gpios.
v5: Rebase on bcm283x.dtsi change, add v3d.
v6: Make HDMI reference the power domain.
v7: Fix the HDMI HPD gpios active value and HDMI enable for each RPI
    board.  Change V3D compatible string to 2835.

 arch/arm/boot/dts/bcm2835-rpi-a-plus.dts |  4 +++
 arch/arm/boot/dts/bcm2835-rpi-a.dts      |  4 +++
 arch/arm/boot/dts/bcm2835-rpi-b-plus.dts |  4 +++
 arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts |  4 +++
 arch/arm/boot/dts/bcm2835-rpi-b.dts      |  4 +++
 arch/arm/boot/dts/bcm2835-rpi.dtsi       |  9 ++++++
 arch/arm/boot/dts/bcm2836-rpi-2-b.dts    |  4 +++
 arch/arm/boot/dts/bcm283x.dtsi           | 47 ++++++++++++++++++++++++++++++++
 8 files changed, 80 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts b/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts
index 228614f..35ff4e7a 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-a-plus.dts
@@ -29,3 +29,7 @@
 		brcm,function = <BCM2835_FSEL_ALT0>;
 	};
 };
+
+&hdmi {
+	hpd-gpios = <&gpio 46 GPIO_ACTIVE_LOW>;
+};
diff --git a/arch/arm/boot/dts/bcm2835-rpi-a.dts b/arch/arm/boot/dts/bcm2835-rpi-a.dts
index ddbbbbd..306a84e 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-a.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-a.dts
@@ -22,3 +22,7 @@
 		brcm,function = <BCM2835_FSEL_ALT2>;
 	};
 };
+
+&hdmi {
+	hpd-gpios = <&gpio 46 GPIO_ACTIVE_HIGH>;
+};
diff --git a/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts b/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts
index ef54050..57d313b 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-b-plus.dts
@@ -29,3 +29,7 @@
 		brcm,function = <BCM2835_FSEL_ALT0>;
 	};
 };
+
+&hdmi {
+	hpd-gpios = <&gpio 46 GPIO_ACTIVE_LOW>;
+};
diff --git a/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts b/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts
index 86f1f2f..cf2774e 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts
@@ -22,3 +22,7 @@
 		brcm,function = <BCM2835_FSEL_ALT2>;
 	};
 };
+
+&hdmi {
+	hpd-gpios = <&gpio 46 GPIO_ACTIVE_LOW>;
+};
diff --git a/arch/arm/boot/dts/bcm2835-rpi-b.dts b/arch/arm/boot/dts/bcm2835-rpi-b.dts
index 4859e9d..8b15f9c 100644
--- a/arch/arm/boot/dts/bcm2835-rpi-b.dts
+++ b/arch/arm/boot/dts/bcm2835-rpi-b.dts
@@ -16,3 +16,7 @@
 &gpio {
 	pinctrl-0 = <&gpioout &alt0 &alt3>;
 };
+
+&hdmi {
+	hpd-gpios = <&gpio 46 GPIO_ACTIVE_HIGH>;
+};
diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
index 76bdbca..caf2707 100644
--- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
+++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
@@ -74,3 +74,12 @@
 &usb {
 	power-domains = <&power RPI_POWER_DOMAIN_USB>;
 };
+
+&v3d {
+	power-domains = <&power RPI_POWER_DOMAIN_V3D>;
+};
+
+&hdmi {
+	power-domains = <&power RPI_POWER_DOMAIN_HDMI>;
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/bcm2836-rpi-2-b.dts b/arch/arm/boot/dts/bcm2836-rpi-2-b.dts
index ff94666..c4743f4 100644
--- a/arch/arm/boot/dts/bcm2836-rpi-2-b.dts
+++ b/arch/arm/boot/dts/bcm2836-rpi-2-b.dts
@@ -33,3 +33,7 @@
 		brcm,function = <BCM2835_FSEL_ALT0>;
 	};
 };
+
+&hdmi {
+	hpd-gpios = <&gpio 46 GPIO_ACTIVE_LOW>;
+};
diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index 8aaf193..31cc2f2 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -1,6 +1,7 @@
 #include <dt-bindings/pinctrl/bcm2835.h>
 #include <dt-bindings/clock/bcm2835.h>
 #include <dt-bindings/clock/bcm2835-aux.h>
+#include <dt-bindings/gpio/gpio.h>
 #include "skeleton.dtsi"
 
 /* This include file covers the common peripherals and configuration between
@@ -153,6 +154,18 @@
 			status = "disabled";
 		};
 
+		pixelvalve at 7e206000 {
+			compatible = "brcm,bcm2835-pixelvalve0";
+			reg = <0x7e206000 0x100>;
+			interrupts = <2 13>; /* pwa0 */
+		};
+
+		pixelvalve at 7e207000 {
+			compatible = "brcm,bcm2835-pixelvalve1";
+			reg = <0x7e207000 0x100>;
+			interrupts = <2 14>; /* pwa1 */
+		};
+
 		aux: aux at 0x7e215000 {
 			compatible = "brcm,bcm2835-aux";
 			#clock-cells = <1>;
@@ -206,6 +219,12 @@
 			status = "disabled";
 		};
 
+		hvs at 7e400000 {
+			compatible = "brcm,bcm2835-hvs";
+			reg = <0x7e400000 0x6000>;
+			interrupts = <2 1>;
+		};
+
 		i2c1: i2c at 7e804000 {
 			compatible = "brcm,bcm2835-i2c";
 			reg = <0x7e804000 0x1000>;
@@ -226,11 +245,39 @@
 			status = "disabled";
 		};
 
+		pixelvalve at 7e807000 {
+			compatible = "brcm,bcm2835-pixelvalve2";
+			reg = <0x7e807000 0x100>;
+			interrupts = <2 10>; /* pixelvalve */
+		};
+
+		hdmi: hdmi at 7e902000 {
+			compatible = "brcm,bcm2835-hdmi";
+			reg = <0x7e902000 0x600>,
+			      <0x7e808000 0x100>;
+			interrupts = <2 8>, <2 9>;
+			ddc = <&i2c2>;
+			clocks = <&clocks BCM2835_PLLH_PIX>,
+				 <&clocks BCM2835_CLOCK_HSM>;
+			clock-names = "pixel", "hdmi";
+			status = "disabled";
+		};
+
 		usb: usb at 7e980000 {
 			compatible = "brcm,bcm2835-usb";
 			reg = <0x7e980000 0x10000>;
 			interrupts = <1 9>;
 		};
+
+		v3d: v3d at 7ec00000 {
+			compatible = "brcm,bcm2835-v3d";
+			reg = <0x7ec00000 0x1000>;
+			interrupts = <1 10>;
+		};
+
+		vc4: gpu {
+			compatible = "brcm,bcm2835-vc4";
+		};
 	};
 
 	clocks {
-- 
2.7.0
