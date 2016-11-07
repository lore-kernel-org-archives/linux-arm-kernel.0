From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon,  7 Nov 2016 11:43:55 +0100
Subject: [PATCH 1/3] ARM64: dts: meson-gxl: Add ethernet nodes with internal
 PHY
In-Reply-To: <20161107104357.24428-1-narmstrong@baylibre.com>
References: <20161107104357.24428-1-narmstrong@baylibre.com>
Message-ID: <20161107104357.24428-2-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Ethernet node with Internal PHY selection for the Amlogic GXL SoCs

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi | 43 ++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index d1bf381..3af54dc 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -49,6 +49,22 @@
 	compatible = "amlogic,meson-gxl";
 };
 
+&ethmac {
+	reg = <0x0 0xc9410000 0x0 0x10000
+	       0x0 0xc8834540 0x0 0x4>;
+
+	clocks = <&clkc CLKID_ETH>,
+		 <&clkc CLKID_FCLK_DIV2>,
+		 <&clkc CLKID_MPLL2>;
+	clock-names = "stmmaceth", "clkin0", "clkin1";
+
+	mdio0: mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwmac-mdio";
+	};
+};
+
 &aobus {
 	pinctrl_aobus: pinctrl at 14 {
 		compatible = "amlogic,meson-gxl-aobus-pinctrl";
@@ -214,6 +230,33 @@
 			};
 		};
 	};
+
+	eth-phy-mux {
+		compatible = "mdio-mux-mmioreg", "mdio-mux";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x0 0x55c 0x0 0x4>;
+		mux-mask = <0xffffffff>;
+		mdio-parent-bus = <&mdio0>;
+
+		internal_mdio: mdio at e40908ff {
+			reg = <0xe40908ff>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			internal_phy: ethernet-phy at 8 {
+				compatible = "ethernet-phy-id0181.4400", "ethernet-phy-ieee802.3-c22";
+				reg = <8>;
+				max-speed = <100>;
+			};
+		};
+
+		external_mdio: mdio at 2009087f {
+			reg = <0x2009087f>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
 };
 
 &hiubus {
-- 
2.7.0
