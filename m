From: christopher.spinrath@rwth-aachen.de (christopher.spinrath at rwth-aachen.de)
Date: Sun, 5 Jun 2016 20:26:55 +0200
Subject: [PATCH v2 2/4] ARM: dts: imx6q: extend support for the cm-fx6
In-Reply-To: <20160605182657.1706-1-christopher.spinrath@rwth-aachen.de>
References: <20160605182657.1706-1-christopher.spinrath@rwth-aachen.de>
Message-ID: <90e7dea7dee342cf82ccedcd463a60fc@rwthex-s1-b.rwth-ad.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christopher Spinrath <christopher.spinrath@rwth-aachen.de>

The cm-fx6 module has an on-board spi-flash chip for its firmware, an
eeprom (containing e.g. the mac address of the on-board Ethernet),
a sata port, a pcie controller, an USB hub, and an USB otg port.
Enable support for them. In addition, enable syscon poweroff support.

Signed-off-by: Christopher Spinrath <christopher.spinrath@rwth-aachen.de>
---

Changes since v1:
 - remove regulator pseudo-bus
 - remove partition layout from spi flash node
 - remove unneeded label of the spi flash node
 - convert downstream power-on-gpio property of pcie node to a proper
   regulator
 - sort usb* related nodes alphabetically
 - make use of GPIO_ACTIVE_{LOW,HIGH} defines
 - replace 0x80000000 iomuxc configs by proper defaults obtained from
   u-boot

 arch/arm/boot/dts/imx6q-cm-fx6.dts | 125 +++++++++++++++++++++++++++++++++++++
 1 file changed, 125 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q-cm-fx6.dts b/arch/arm/boot/dts/imx6q-cm-fx6.dts
index 21c513f..c6f0e58 100644
--- a/arch/arm/boot/dts/imx6q-cm-fx6.dts
+++ b/arch/arm/boot/dts/imx6q-cm-fx6.dts
@@ -12,6 +12,7 @@
  */
 
 /dts-v1/;
+#include <dt-bindings/gpio/gpio.h>
 #include "imx6q.dtsi"
 
 / {
@@ -31,6 +32,49 @@
 			linux,default-trigger = "heartbeat";
 		};
 	};
+
+	reg_pcie_power_on_gpio: regulator-pcie-power-on-gpio {
+		compatible = "regulator-fixed";
+		regulator-name = "regulator-pcie-power-on-gpio";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio2 24 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_usb_h1_vbus: usb_h1_vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb_h1_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio7 8 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_usb_otg_vbus: usb_otg_vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb_otg_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio3 22 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+};
+
+&ecspi1 {
+	fsl,spi-num-chipselects = <2>;
+	cs-gpios = <&gpio2 30 GPIO_ACTIVE_HIGH>, <&gpio3 19 GPIO_ACTIVE_HIGH>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi1>;
+	status = "okay";
+
+	m25p80 at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "st,m25p", "jedec,spi-nor";
+		spi-max-frequency = <20000000>;
+		reg = <0>;
+	};
 };
 
 &fec {
@@ -46,7 +90,30 @@
 	status = "okay";
 };
 
+&i2c3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	status = "okay";
+	clock-frequency = <100000>;
+
+	eeprom at 50 {
+		compatible = "at24,24c02";
+		reg = <0x50>;
+		pagesize = <16>;
+	};
+};
+
 &iomuxc {
+	pinctrl_ecspi1: ecspi1grp {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_D16__ECSPI1_SCLK	0x100b1
+			MX6QDL_PAD_EIM_D17__ECSPI1_MISO	0x100b1
+			MX6QDL_PAD_EIM_D18__ECSPI1_MOSI	0x100b1
+			MX6QDL_PAD_EIM_EB2__GPIO2_IO30	0x100b1
+			MX6QDL_PAD_EIM_D19__GPIO3_IO19	0x100b1
+		>;
+	};
+
 	pinctrl_enet: enetgrp {
 		fsl,pins = <
 			MX6QDL_PAD_RGMII_RXC__RGMII_RXC		0x1b0b0
@@ -90,12 +157,55 @@
 		>;
 	};
 
+	pinctrl_i2c3: i2c3grp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_3__I2C3_SCL	0x4001b8b1
+			MX6QDL_PAD_GPIO_6__I2C3_SDA	0x4001b8b1
+		>;
+	};
+
+	pinctrl_pcie: pciegrp {
+		fsl,pins = <
+			MX6QDL_PAD_ENET_RXD1__GPIO1_IO26	0x1b0b1
+			MX6QDL_PAD_EIM_CS1__GPIO2_IO24	0x1b0b1
+		>;
+	};
+
 	pinctrl_uart4: uart4grp {
 		fsl,pins = <
 			MX6QDL_PAD_KEY_COL0__UART4_TX_DATA	0x1b0b1
 			MX6QDL_PAD_KEY_ROW0__UART4_RX_DATA	0x1b0b1
 		>;
 	};
+
+	pinctrl_usbh1: usbh1grp {
+		fsl,pins = <
+			MX6QDL_PAD_SD3_RST__GPIO7_IO08	0x1b0b1
+		>;
+	};
+
+	pinctrl_usbotg: usbotggrp {
+		fsl,pins = <
+			MX6QDL_PAD_ENET_RX_ER__USB_OTG_ID	0x17059
+			MX6QDL_PAD_EIM_D22__GPIO3_IO22	0x130b0
+		>;
+	};
+};
+
+&pcie {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pcie>;
+	reset-gpio = <&gpio1 26 GPIO_ACTIVE_HIGH>;
+	vdd-supply = <&reg_pcie_power_on_gpio>;
+	status = "okay";
+};
+
+&sata {
+	status = "okay";
+};
+
+&snvs_poweroff {
+	status = "okay";
 };
 
 &uart4 {
@@ -103,3 +213,18 @@
 	pinctrl-0 = <&pinctrl_uart4>;
 	status = "okay";
 };
+
+&usbh1 {
+	vbus-supply = <&reg_usb_h1_vbus>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbh1>;
+	status = "okay";
+};
+
+&usbotg {
+	vbus-supply = <&reg_usb_otg_vbus>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbotg>;
+	dr_mode = "otg";
+	status = "okay";
+};
-- 
2.8.3
