From: andre.przywara@arm.com (Andre Przywara)
Date: Thu, 26 Jul 2018 01:35:18 +0100
Subject: [PATCH v2 04/18] arm64: dts: allwinner: a64: Orange Pi Win: Fix USB
In-Reply-To: <20180726003532.18751-1-andre.przywara@arm.com>
References: <20180726003532.18751-1-andre.przywara@arm.com>
Message-ID: <20180726003532.18751-5-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Samuel Holland <samuel@sholland.org>

The Orange Pi Win has 5 USB ports:
Four are standard A sockets, connected to an on-board HUB. The hub's and
socket's power regulators are enabled by GPIO PD7.
Also it features a microB socket, connected to the SoC's USB-OTG port.
It's power is supplied by the AXP PMIC, and the ID pin is connected to
GPIO PH9. It can serve both as a host or a client port.

Signed-off-by: Samuel Holland <samuel@sholland.org>
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 .../boot/dts/allwinner/sun50i-a64-orangepi-win.dts    | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
index 667016815cf3..c9cabe987c19 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
@@ -57,6 +57,17 @@
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+	reg_usb1_vbus: usb1-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb1-vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-boot-on;
+		enable-active-high;
+		gpio = <&pio 3 7 GPIO_ACTIVE_HIGH>; /* PD7 */
+		status = "okay";
+	};
 };
 
 &ehci1 {
@@ -203,7 +214,13 @@
 	status = "okay";
 };
 
-&usbphy {
+&usb_otg {
+	dr_mode = "otg";
 	status = "okay";
 };
 
+&usbphy {
+	usb0_id_det-gpios = <&pio 7 9 GPIO_ACTIVE_HIGH>; /* PH9 */
+	usb1_vbus-supply = <&reg_usb1_vbus>;
+	status = "okay";
+};
-- 
2.14.4
