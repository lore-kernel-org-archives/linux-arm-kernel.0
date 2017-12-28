From: icenowy@aosc.io (Icenowy Zheng)
Date: Thu, 28 Dec 2017 22:05:38 +0800
Subject: [PATCH] ARM: dts: sun8i: fix USB Ethernet of Orange Pi R1
Message-ID: <20171228140538.14388-1-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Orange Pi R1 uses a Realtek RTL8152B USB Ethernet chip, which is easily
seen on the board but not show in the schematics. A regulator for the
power of the RTL8152B chip is hidden, which uses the same pin with the
Wi-Fi regulator on the original Orange Pi Zero.

Add this regulator back to the device tree, and bind it to USB1.

Tested-by: Hauke Mehrtens <hauke@hauke-m.de>
Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm/boot/dts/sun8i-h2-plus-orangepi-r1.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-r1.dts b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-r1.dts
index 32a6d312422e..f7f61cbcd15a 100644
--- a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-r1.dts
+++ b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-r1.dts
@@ -49,6 +49,20 @@
 
 	/delete-node/ reg_vcc_wifi;
 
+	/*
+	 * Ths pin of this regulator is the same with the Wi-Fi extra
+	 * regulator on the original Zero. However it's used for USB
+	 * Ethernet rather than the Wi-Fi now.
+	 */
+	reg_vcc_usb_eth: reg-vcc-usb-ethernet {
+		compatible = "regulator-fixed";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-name = "vcc-usb-ethernet";
+		enable-active-high;
+		gpio = <&pio 0 20 GPIO_ACTIVE_HIGH>;
+	};
+
 	aliases {
 		ethernet1 = &rtl8189etv;
 	};
@@ -71,3 +85,7 @@
 		reg = <1>;
 	};
 };
+
+&usbphy {
+	usb1_vbus-supply = <&reg_vcc_usb_eth>;
+};
-- 
2.14.2
