From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 21 Oct 2016 16:40:35 +0200
Subject: [RFC PATCH 10/13] ARM64: dts: meson-gxl: Add ethernet nodes with
 internal PHY
In-Reply-To: <1477060838-14164-1-git-send-email-narmstrong@baylibre.com>
References: <1477060838-14164-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1477060838-14164-11-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Ethernet node with Internal PHY selection for the Amlogic GXL SoCs

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index d1bf381..85969c6 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -49,6 +49,34 @@
 	compatible = "amlogic,meson-gxl";
 };
 
+&ethmac {
+	reg = <0x0 0xc9410000 0x0 0x10000
+	       0x0 0xc8834540 0x0 0x4
+	       0x0 0xc8834558 0x0 0xc>;
+
+	clocks = <&clkc CLKID_ETH>,
+		 <&clkc CLKID_FCLK_DIV2>,
+		 <&clkc CLKID_MPLL2>;
+	clock-names = "stmmaceth", "clkin0", "clkin1";
+
+	/* Select Internal PHY by default */
+	amlogic,phy-select = <0xe40908ff>;
+	phy-mode = "rmii";
+	phy-handle = <&internal_phy>;
+
+	mdio0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwmac-mdio";
+
+		internal_phy: ethernet-phy at 8 {
+			compatible = "ethernet-phy-id0181.4400", "ethernet-phy-ieee802.3-c22";
+			reg = <8>;
+			max-speed = <100>;
+		};
+	};
+};
+
 &aobus {
 	pinctrl_aobus: pinctrl at 14 {
 		compatible = "amlogic,meson-gxl-aobus-pinctrl";
-- 
1.9.1
