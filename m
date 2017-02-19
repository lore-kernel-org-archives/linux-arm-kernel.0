From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sun, 19 Feb 2017 22:41:43 +0100
Subject: [PATCH v5 3/9] ARM64: dts: meson-gxbb-vega-s95: add the ethernet
 PHY's reset GPIO
In-Reply-To: <20170219214149.30418-1-martin.blumenstingl@googlemail.com>
References: <20170122181028.5014-1-martin.blumenstingl@googlemail.com>
 <20170219214149.30418-1-martin.blumenstingl@googlemail.com>
Message-ID: <20170219214149.30418-4-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This resets the ethernet PHY during boot to get the PHY into a "clean"
state.
While here also specify the phy-handle of the ethmac node to make the
PHY configuration similar to the one we have on GXL devices. This will
allow us to specify OF-properties for the PHY itself.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
index 86709929fd20..aa571970c5e9 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
@@ -115,7 +115,6 @@
 	status = "okay";
 	pinctrl-0 = <&uart_ao_a_pins>;
 	pinctrl-names = "default";
-
 };
 
 &ir {
@@ -128,6 +127,24 @@
 	status = "okay";
 	pinctrl-0 = <&eth_rgmii_pins>;
 	pinctrl-names = "default";
+
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
+		eth_phy0: ethernet-phy at 0 {
+			/* Realtek RTL8211F (0x001cc916) */
+			reg = <0>;
+		};
+	};
 };
 
 &usb0_phy {
-- 
2.11.1
