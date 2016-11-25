From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Fri, 25 Nov 2016 14:01:54 +0100
Subject: [PATCH v2 5/7] ARM64: dts: meson-gxbb-p20x: add reset for the
 ethernet PHY
In-Reply-To: <20161125130156.17879-1-martin.blumenstingl@googlemail.com>
References: <20161124143417.10178-1-martin.blumenstingl@googlemail.com>
 <20161125130156.17879-1-martin.blumenstingl@googlemail.com>
Message-ID: <20161125130156.17879-6-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This resets the ethernet PHY during boot to get the PHY into a "clean"
state. While here also specify the phy-handle of the ethmac node to
make the PHY configuration similar to the one we have on GXL devices.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
index 203be28..2abc553 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
@@ -134,10 +134,25 @@
 	pinctrl-names = "default";
 };
 
+&mdio0 {
+	ethernet_phy0: ethernet-phy at 0 {
+		compatible = "ethernet-phy-ieee802.3-c22";
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
 
 &ir {
-- 
2.10.2
