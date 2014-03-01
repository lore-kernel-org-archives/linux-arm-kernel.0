From: hdegoede@redhat.com (Hans de Goede)
Date: Sat,  1 Mar 2014 20:26:28 +0100
Subject: [PATCH 09/19] ARM: sun4i: dt: Add USB host nodes to hackberry dts
In-Reply-To: <1393701998-3553-1-git-send-email-hdegoede@redhat.com>
References: <1393701998-3553-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1393701998-3553-10-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add nodes for the usb-phy and ehci- and ohci-usb-host controllers.

Based on fex file settings, the fex file also contains a mysterious line:
usb_hub_vcc_en_gpio = port:PB09<1><0><default><0>

Which also clashes with usbc0, which has:
usb_drv_vbus_gpio = port:PB09<1><0><default><0>

So if usb does not work properly we need someone with a hackberry to look
closer into this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun4i-a10-hackberry.dts | 40 +++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10-hackberry.dts b/arch/arm/boot/dts/sun4i-a10-hackberry.dts
index 6692d336..d7c17e4 100644
--- a/arch/arm/boot/dts/sun4i-a10-hackberry.dts
+++ b/arch/arm/boot/dts/sun4i-a10-hackberry.dts
@@ -13,6 +13,7 @@
 
 /dts-v1/;
 /include/ "sun4i-a10.dtsi"
+/include/ "sunxi-common-regulators.dtsi"
 
 / {
 	model = "Miniand Hackberry";
@@ -35,6 +36,28 @@
 			};
 		};
 
+		usbphy: phy at 01c13400 {
+			usb1_vbus-supply = <&reg_usb1_vbus>;
+			usb2_vbus-supply = <&reg_usb2_vbus>;
+			status = "okay";
+		};
+
+		ehci0: usb at 01c14000 {
+			status = "okay";
+		};
+
+		ohci0: usb at 01c14400 {
+			status = "okay";
+		};
+
+		ehci1: usb at 01c1c000 {
+			status = "okay";
+		};
+
+		ohci1: usb at 01c1c400 {
+			status = "okay";
+		};
+
 		pio: pinctrl at 01c20800 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&hackberry_hogs>;
@@ -45,6 +68,13 @@
 				allwinner,drive = <0>;
 				allwinner,pull = <0>;
 			};
+
+			usb2_vbus_pin_hackberry: usb2_vbus_pin at 0 {
+					allwinner,pins = "PH12";
+					allwinner,function = "gpio_out";
+					allwinner,drive = <0>;
+					allwinner,pull = <0>;
+			};
 		};
 
 		uart0: serial at 01c28000 {
@@ -62,4 +92,14 @@
 		enable-active-high;
 		gpio = <&pio 7 19 0>;
 	};
+
+	reg_usb1_vbus: usb1-vbus {
+		status = "okay";
+	};
+
+	reg_usb2_vbus: usb2-vbus {
+		pinctrl-0 = <&usb2_vbus_pin_hackberry>;
+		gpio = <&pio 7 12 0>;
+		status = "okay";
+	};
 };
-- 
1.9.0
