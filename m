From: andre.przywara@arm.com (Andre Przywara)
Date: Mon, 30 Jul 2018 13:31:22 +0100
Subject: [PATCH v3 04/19] arm64: dts: allwinner: a64: Orange Pi Win: Enable
 USB hub regulator
In-Reply-To: <20180730123137.923-1-andre.przywara@arm.com>
References: <20180730123137.923-1-andre.przywara@arm.com>
Message-ID: <20180730123137.923-5-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Samuel Holland <samuel@sholland.org>

The Orange Pi Win has four standard USB-A sockets, connected to an
on-board USB hub. The hub's and socket's power regulators are enabled by
GPIO PD7.

Add the regulator to the DT to enable the power supply.

Signed-off-by: Samuel Holland <samuel@sholland.org>
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
index 667016815cf3..a73489850d88 100644
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
@@ -204,6 +215,7 @@
 };
 
 &usbphy {
+	usb1_vbus-supply = <&reg_usb1_vbus>;
 	status = "okay";
 };
 
-- 
2.14.4
