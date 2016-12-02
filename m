From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat,  3 Dec 2016 00:47:38 +0100
Subject: [PATCH 4/5] ARM64: dts: meson-gxbb-vega-s95: add reset for the
 ethernet PHY
In-Reply-To: <20161202234739.22929-1-martin.blumenstingl@googlemail.com>
References: <20161202234739.22929-1-martin.blumenstingl@googlemail.com>
Message-ID: <20161202234739.22929-5-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This resets the ethernet PHY during boot to get the PHY into a "clean"
state. While here also specify the phy-handle of the ethmac node to
make the PHY configuration similar to the one we have on GXL devices.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Tested-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
index e59ad30..a0e92e3 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
@@ -113,10 +113,25 @@
 	pinctrl-names = "default";
 };
 
+&mdio0 {
+	ethernet_phy0: ethernet-phy at 0 {
+		compatible = "ethernet-phy-id001c.c916", "ethernet-phy-ieee802.3-c22";
+		reg = <0>;
+	};
+};
+
 &ethmac {
 	status = "okay";
 	pinctrl-0 = <&eth_rgmii_pins>;
 	pinctrl-names = "default";
+
+	phy-handle = <&ethernet_phy0>;
+
+	snps,reset-gpio = <&gpio GPIOZ_14 0>;
+	snps,reset-delays-us = <0 10000 1000000>;
+	snps,reset-active-low;
+
+	phy-mode = "rgmii";
 };
 
 &usb0_phy {
-- 
2.10.2
