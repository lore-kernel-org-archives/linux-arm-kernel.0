From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed,  4 Oct 2017 10:18:32 +0100
Subject: [PATCH 1/2] ARM: dts: iwg20d-q7: Rework DT architecture
In-Reply-To: <1507108713-10686-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1507108713-10686-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1507108713-10686-2-git-send-email-fabrizio.castro@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the same carrier board may host RZ/G1M and RZ/G1N based
Systems on Module, the DT architecture for iwg20d-q7 needs
better decoupling. This patch provides:
* iwg20d-q7-common.dtsi - its purpose is to define the carrier
  board definitions, and its content is basically the same
  as the previous version of r8a7743-iwg20d-q7.dts, only it
  has no reference to the SoM .dtsi, and that's why the
  filename doesn't mention the SoC name any more.
* r8a7743-iwg20d-q7.dts - its new purpose is to put together
  the SoM .dtsi (r8a7743-iwg20m.dtsi) and the carrier board
  .dtsi defined by this very patch, along with "model" and
  "compatible" properties.
The final DT architecture to describe the board is now:
r8a7743-iwg20d-q7.dts           # Carrier Board + SoM
??? r8a7743-iwg20m.dtsi         # SoM
??? ??? r8a7743.dtsi            # SoC
??? iwg20d-q7-common.dtsi       # Carrier Board
and maximizes the reuse of the definitions for the carrier board
and for the SoM.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
---
 arch/arm/boot/dts/iwg20d-q7-common.dtsi | 147 ++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/r8a7743-iwg20d-q7.dts | 139 +-----------------------------
 2 files changed, 149 insertions(+), 137 deletions(-)
 create mode 100644 arch/arm/boot/dts/iwg20d-q7-common.dtsi

diff --git a/arch/arm/boot/dts/iwg20d-q7-common.dtsi b/arch/arm/boot/dts/iwg20d-q7-common.dtsi
new file mode 100644
index 0000000..f9d153c
--- /dev/null
+++ b/arch/arm/boot/dts/iwg20d-q7-common.dtsi
@@ -0,0 +1,147 @@
+/*
+ * Device Tree Source for the iWave-RZ/G1M/G1N Qseven carrier board
+ *
+ * Copyright (C) 2017 Renesas Electronics Corp.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/ {
+	aliases {
+		serial0 = &scif0;
+		ethernet0 = &avb;
+	};
+
+	chosen {
+		bootargs = "ignore_loglevel rw root=/dev/nfs ip=dhcp";
+		stdout-path = "serial0:115200n8";
+	};
+
+	vcc_sdhi1: regulator-vcc-sdhi1 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "SDHI1 Vcc";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&gpio1 16 GPIO_ACTIVE_LOW>;
+	};
+
+	vccq_sdhi1: regulator-vccq-sdhi1 {
+		compatible = "regulator-gpio";
+
+		regulator-name = "SDHI1 VccQ";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpios = <&gpio2 30 GPIO_ACTIVE_LOW>;
+		gpios-states = <1>;
+		states = <3300000 1
+			  1800000 0>;
+	};
+};
+
+&pfc {
+	i2c2_pins: i2c2 {
+		groups = "i2c2";
+		function = "i2c2";
+	};
+
+	scif0_pins: scif0 {
+		groups = "scif0_data_d";
+		function = "scif0";
+	};
+
+	avb_pins: avb {
+		groups = "avb_mdio", "avb_gmii";
+		function = "avb";
+	};
+
+	sdhi1_pins: sd1 {
+		groups = "sdhi1_data4", "sdhi1_ctrl";
+		function = "sdhi1";
+		power-source = <3300>;
+	};
+
+	sdhi1_pins_uhs: sd1_uhs {
+		groups = "sdhi1_data4", "sdhi1_ctrl";
+		function = "sdhi1";
+		power-source = <1800>;
+	};
+
+	usb0_pins: usb0 {
+		groups = "usb0";
+		function = "usb0";
+	};
+
+	usb1_pins: usb1 {
+		groups = "usb1";
+		function = "usb1";
+	};
+};
+
+&scif0 {
+	pinctrl-0 = <&scif0_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&avb {
+	pinctrl-0 = <&avb_pins>;
+	pinctrl-names = "default";
+
+	phy-handle = <&phy3>;
+	phy-mode = "gmii";
+	renesas,no-ether-link;
+	status = "okay";
+
+	phy3: ethernet-phy at 3 {
+		reg = <3>;
+		micrel,led-mode = <1>;
+	};
+};
+
+&sdhi1 {
+	pinctrl-0 = <&sdhi1_pins>;
+	pinctrl-1 = <&sdhi1_pins_uhs>;
+	pinctrl-names = "default", "state_uhs";
+
+	vmmc-supply = <&vcc_sdhi1>;
+	vqmmc-supply = <&vccq_sdhi1>;
+	cd-gpios = <&gpio6 14 GPIO_ACTIVE_LOW>;
+	wp-gpios = <&gpio6 15 GPIO_ACTIVE_HIGH>;
+	sd-uhs-sdr50;
+	status = "okay";
+};
+
+&i2c2 {
+	pinctrl-0 = <&i2c2_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+	clock-frequency = <400000>;
+
+	rtc at 68 {
+		compatible = "ti,bq32000";
+		reg = <0x68>;
+	};
+};
+
+&pci0 {
+	status = "okay";
+	pinctrl-0 = <&usb0_pins>;
+	pinctrl-names = "default";
+};
+
+&pci1 {
+	status = "okay";
+	pinctrl-0 = <&usb1_pins>;
+	pinctrl-names = "default";
+};
+
+&usbphy {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/r8a7743-iwg20d-q7.dts b/arch/arm/boot/dts/r8a7743-iwg20d-q7.dts
index 0136864..6aa6b74 100644
--- a/arch/arm/boot/dts/r8a7743-iwg20d-q7.dts
+++ b/arch/arm/boot/dts/r8a7743-iwg20d-q7.dts
@@ -1,5 +1,5 @@
 /*
- * Device Tree Source for the iWave-RZG1M Qseven carrier board
+ * Device Tree Source for the iWave-RZ/G1M Qseven board
  *
  * Copyright (C) 2017 Renesas Electronics Corp.
  *
@@ -10,144 +10,9 @@
 
 /dts-v1/;
 #include "r8a7743-iwg20m.dtsi"
+#include "iwg20d-q7-common.dtsi"
 
 / {
 	model = "iWave Systems RainboW-G20D-Qseven board based on RZ/G1M";
 	compatible = "iwave,g20d", "iwave,g20m", "renesas,r8a7743";
-
-	aliases {
-		serial0 = &scif0;
-		ethernet0 = &avb;
-	};
-
-	chosen {
-		bootargs = "ignore_loglevel rw root=/dev/nfs ip=dhcp";
-		stdout-path = "serial0:115200n8";
-	};
-
-	vcc_sdhi1: regulator-vcc-sdhi1 {
-		compatible = "regulator-fixed";
-
-		regulator-name = "SDHI1 Vcc";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-
-		gpio = <&gpio1 16 GPIO_ACTIVE_LOW>;
-	};
-
-	vccq_sdhi1: regulator-vccq-sdhi1 {
-		compatible = "regulator-gpio";
-
-		regulator-name = "SDHI1 VccQ";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <3300000>;
-
-		gpios = <&gpio2 30 GPIO_ACTIVE_LOW>;
-		gpios-states = <1>;
-		states = <3300000 1
-			  1800000 0>;
-	};
-};
-
-&pfc {
-	i2c2_pins: i2c2 {
-		groups = "i2c2";
-		function = "i2c2";
-	};
-
-	scif0_pins: scif0 {
-		groups = "scif0_data_d";
-		function = "scif0";
-	};
-
-	avb_pins: avb {
-		groups = "avb_mdio", "avb_gmii";
-		function = "avb";
-	};
-
-	sdhi1_pins: sd1 {
-		groups = "sdhi1_data4", "sdhi1_ctrl";
-		function = "sdhi1";
-		power-source = <3300>;
-	};
-
-	sdhi1_pins_uhs: sd1_uhs {
-		groups = "sdhi1_data4", "sdhi1_ctrl";
-		function = "sdhi1";
-		power-source = <1800>;
-	};
-
-	usb0_pins: usb0 {
-		groups = "usb0";
-		function = "usb0";
-	};
-
-	usb1_pins: usb1 {
-		groups = "usb1";
-		function = "usb1";
-	};
-};
-
-&scif0 {
-	pinctrl-0 = <&scif0_pins>;
-	pinctrl-names = "default";
-
-	status = "okay";
-};
-
-&avb {
-	pinctrl-0 = <&avb_pins>;
-	pinctrl-names = "default";
-
-	phy-handle = <&phy3>;
-	phy-mode = "gmii";
-	renesas,no-ether-link;
-	status = "okay";
-
-	phy3: ethernet-phy at 3 {
-		reg = <3>;
-		micrel,led-mode = <1>;
-	};
-};
-
-&sdhi1 {
-	pinctrl-0 = <&sdhi1_pins>;
-	pinctrl-1 = <&sdhi1_pins_uhs>;
-	pinctrl-names = "default", "state_uhs";
-
-	vmmc-supply = <&vcc_sdhi1>;
-	vqmmc-supply = <&vccq_sdhi1>;
-	cd-gpios = <&gpio6 14 GPIO_ACTIVE_LOW>;
-	wp-gpios = <&gpio6 15 GPIO_ACTIVE_HIGH>;
-	sd-uhs-sdr50;
-	status = "okay";
-};
-
-&i2c2 {
-	pinctrl-0 = <&i2c2_pins>;
-	pinctrl-names = "default";
-
-	status = "okay";
-	clock-frequency = <400000>;
-
-	rtc at 68 {
-		compatible = "ti,bq32000";
-		reg = <0x68>;
-	};
-};
-
-&pci0 {
-	status = "okay";
-	pinctrl-0 = <&usb0_pins>;
-	pinctrl-names = "default";
-};
-
-&pci1 {
-	status = "okay";
-	pinctrl-0 = <&usb1_pins>;
-	pinctrl-names = "default";
-};
-
-&usbphy {
-	status = "okay";
 };
-- 
2.7.4
