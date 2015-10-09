From: siarhei.siamashka@gmail.com (Siarhei Siamashka)
Date: Fri,  9 Oct 2015 14:09:39 +0300
Subject: [PATCH v2 3/3] ARM: dts: sun4i: Enable USB DRC on pcDuino1/2
In-Reply-To: <1444388979-12072-1-git-send-email-siarhei.siamashka@gmail.com>
References: <1444388979-12072-1-git-send-email-siarhei.siamashka@gmail.com>
Message-ID: <1444388979-12072-4-git-send-email-siarhei.siamashka@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the otg/drc usb controller on the pcDuino1/2 board. Note
that the pcDuino1 FEX file from the vendor contains the following
information in the [usbc0] section:
    usb_id_gpio = port:PH04<0><1><default><default>
    usb_det_vbus_gpio = port:PH05<0><0><default><default>
    usb_drv_vbus_gpio = port:PB09<1><0><default><0>
While the pcDuino2 FEX has:
    usb_id_gpio = port:PH04<0><1><default><default>
    usb_det_vbus_gpio = port:PH05<0><0><default><default>
    usb_drv_vbus_gpio = port:PD02<1><0><default><0>

The ID pin is indeed PH4. The PD2 pin can be used to switch power
on/off for the USB Type A receptacle on pcDuino2, but it has nothing
to do with the MicroUSB OTG receptacle. The VBUS pin of the MicroUSB
receptacle is always connected to 5V according to the schematics
(both pcDuino1 and pcDuino2) and confirmed by doing some tests on
pcDuino2. The PH5 pin is just one of the pins on the J8 expansion
header and has nothing to do with USB OTG. The PB9 pin is pulled
up and connected to the N_VBUSEN pin of AXP209 PMIC, while the
VBUS pin of AXP209 only has a capacitor between it and the
ground (this pin is not used for anything else).

To sum it up. Only the ID pin (PH4) has a real use. And 5V voltage
is always served to the MicroUSB OTG receptacle no matter what is
the state of the PB9/PD2 pins.

This patch has been tested on pcDuino2 to work fine in a host role
with a USB keyboard connected via an OTG cable. It also works fine
in a device role (cdc_ether) with a regular Micro-B cable connected
to a desktop PC.

Signed-off-by: Siarhei Siamashka <siarhei.siamashka@gmail.com>
---
 arch/arm/boot/dts/sun4i-a10-pcduino.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10-pcduino.dts b/arch/arm/boot/dts/sun4i-a10-pcduino.dts
index 0b45d27..39034aa 100644
--- a/arch/arm/boot/dts/sun4i-a10-pcduino.dts
+++ b/arch/arm/boot/dts/sun4i-a10-pcduino.dts
@@ -164,6 +164,10 @@
 	status = "okay";
 };
 
+&otg_sram {
+	status = "okay";
+};
+
 &pio {
 	led_pins_pcduino: led_pins at 0 {
 		allwinner,pins = "PH15", "PH16";
@@ -178,6 +182,13 @@
 		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
 		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
+
+	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
+		allwinner,pins = "PH4";
+		allwinner,function = "gpio_in";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
+	};
 };
 
 #include "axp209.dtsi"
@@ -213,7 +224,15 @@
 	status = "okay";
 };
 
+&usb_otg {
+	dr_mode = "otg";
+	status = "okay";
+};
+
 &usbphy {
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb0_id_detect_pin>;
+	usb0_id_det-gpio = <&pio 7 4 GPIO_ACTIVE_HIGH>; /* PH4 */
 	usb1_vbus-supply = <&reg_vcc5v0>; /* USB1 VBUS is always on */
 	usb2_vbus-supply = <&reg_vcc5v0>; /* USB2 VBUS is always on */
 	status = "okay";
-- 
2.4.9
