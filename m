From: hdegoede@redhat.com (Hans de Goede)
Date: Fri,  2 May 2014 17:57:29 +0200
Subject: [PATCH v10 15/15] ARM: dts: sun7i: Add basic support for the
 Cubietruck WiFi module
In-Reply-To: <1399046249-19472-1-git-send-email-hdegoede@redhat.com>
References: <1399046249-19472-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1399046249-19472-16-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chen-Yu Tsai <wens@csie.org>

The CubieTruck has an AMPAK AP6210 WiFi+Bluetooth module. The WiFi
part is a BCM43362 IC connected to MMC3 in the A20 SoC via SDIO.
The IC also takes a power enable signal via GPIO.

The WiFi module supports out-of-band interrupt signaling via GPIO,
but this is not supported in this patch.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts | 31 ++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
index b2e2efd..97b6f02 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
@@ -29,6 +29,14 @@
 			status = "okay";
 		};
 
+		mmc3: mmc at 01c12000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&mmc3_pins_a>;
+			vmmc-supply = <&reg_vmmc3>;
+			non-removable;
+			status = "okay";
+		};
+
 		usbphy: phy at 01c13400 {
 			usb1_vbus-supply = <&reg_usb1_vbus>;
 			usb2_vbus-supply = <&reg_usb2_vbus>;
@@ -57,6 +65,18 @@
 		};
 
 		pinctrl at 01c20800 {
+			mmc3_pins_a: mmc3 at 0 {
+				/* AP6210 requires pull-up */
+				allwinner,pull = <1>;
+			};
+
+			vmmc3_pin_cubietruck: vmmc3_pin at 0 {
+				allwinner,pins = "PH9";
+				allwinner,function = "gpio_out";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
 			ahci_pwr_pin_cubietruck: ahci_pwr_pin at 1 {
 				allwinner,pins = "PH12";
 				allwinner,function = "gpio_out";
@@ -148,4 +168,15 @@
 	reg_usb2_vbus: usb2-vbus {
 		status = "okay";
 	};
+
+	reg_vmmc3: vmmc3 {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&vmmc3_pin_cubietruck>;
+		regulator-name = "vmmc3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		enable-active-high;
+		gpio = <&pio 7 9 0>;
+	};
 };
-- 
1.9.0
