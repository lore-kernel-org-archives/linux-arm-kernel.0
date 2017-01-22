From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sun, 22 Jan 2017 19:10:21 +0100
Subject: [PATCH v4 2/9] ARM64: dts: meson-gxbb-p200: add the ethernet PHY's
 reset GPIO
In-Reply-To: <20170122181028.5014-1-martin.blumenstingl@googlemail.com>
References: <20170120152232.13943-1-martin.blumenstingl@googlemail.com>
 <20170122181028.5014-1-martin.blumenstingl@googlemail.com>
Message-ID: <20170122181028.5014-3-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This resets the ethernet PHY during boot to get the PHY into a "clean"
state.
While here also specify the phy-handle of the ethmac node to make the
PHY configuration similar to the one we have on GXL devices. This will
allow us to specify OF-properties for the PHY itself.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Tested-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts
index 03e3d76626dd..666dd1f32f55 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts
@@ -51,6 +51,29 @@
 	model = "Amlogic Meson GXBB P200 Development Board";
 };
 
+&ethmac {
+	status = "okay";
+	pinctrl-0 = <&eth_rgmii_pins>;
+	pinctrl-names = "default";
+	phy-handle = <&eth_phy0>;
+	phy-mode = "rgmii";
+
+	snps,reset-gpio = <&gpio GPIOZ_14 0>;
+	snps,reset-delays-us = <0 10000 1000000>;
+	snps,reset-active-low;
+
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		eth_phy0: ethernet-phy at 3 {
+			/* Micrel KSZ9031 (0x00221620) */
+			reg = <3>;
+		};
+	};
+};
+
 &i2c_B {
 	status = "okay";
 	pinctrl-0 = <&i2c_b_pins>;
-- 
2.11.0
