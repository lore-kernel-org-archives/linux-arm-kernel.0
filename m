From: oliver@schinagl.nl (Olliver Schinagl)
Date: Sun,  9 Aug 2015 20:22:58 +0200
Subject: [PATCH] ARM: dts: sunxi: enable otg port on the
 sun7i-a20-olinuxino-lime2
In-Reply-To: <1439144578-7890-1-git-send-email-oliver@schinagl.nl>
References: <1439144578-7890-1-git-send-email-oliver@schinagl.nl>
Message-ID: <1439144578-7890-2-git-send-email-oliver@schinagl.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Olliver Schinagl <o.schinagl@ultimaker.com>

This patch enables the musb-otg USB controller on the Lime2. The Lime2
differs from the Lime1 series in pins used for usb0 power.

Tested on a OlinuXino Lime2-4GB.

Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
---
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts | 41 +++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
index 22cd052..a7239fc 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
@@ -196,6 +196,10 @@
 	status = "okay";
 };
 
+&otg_sram {
+	status = "okay";
+};
+
 &pio {
 	ahci_pwr_pin_olinuxinolime: ahci_pwr_pin at 1 {
 		allwinner,pins = "PC3";
@@ -210,6 +214,27 @@
 		allwinner,drive = <SUN4I_PINCTRL_20_MA>;
 		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
+
+	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
+		allwinner,pins = "PH4";
+		allwinner,function = "gpio_in";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
+	};
+
+	usb0_vbus_detect_pin: usb0_vbus_detect_pin at 0 {
+		allwinner,pins = "PH5";
+		allwinner,function = "gpio_in";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_PULL_DOWN>;
+	};
+
+	usb0_vbus_pin_lime2: usb0_vbus_pin at 0 {
+		allwinner,pins = "PC17";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
 };
 
 &reg_ahci_5v {
@@ -218,6 +243,12 @@
 	status = "okay";
 };
 
+&reg_usb0_vbus {
+	pinctrl-0 = <&usb0_vbus_pin_lime2>;
+	gpio = <&pio 2 17 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
 &reg_usb1_vbus {
 	status = "okay";
 };
@@ -232,7 +263,17 @@
 	status = "okay";
 };
 
+&usb_otg {
+	dr_mode = "otg";
+	status = "okay";
+};
+
 &usbphy {
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb0_id_detect_pin>, <&usb0_vbus_detect_pin>;
+	usb0_id_det-gpio = <&pio 7 4 GPIO_ACTIVE_HIGH>; /* PH4 */
+	usb0_vbus_det-gpio = <&pio 7 5 GPIO_ACTIVE_HIGH>; /* PH5 */
+	usb0_vbus-supply = <&reg_usb0_vbus>;
 	usb1_vbus-supply = <&reg_usb1_vbus>;
 	usb2_vbus-supply = <&reg_usb2_vbus>;
 	status = "okay";
-- 
2.1.4
