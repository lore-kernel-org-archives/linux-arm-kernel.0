From: uri.mashiach@compulab.co.il (Uri Mashiach)
Date: Tue, 27 Oct 2015 14:14:59 +0200
Subject: [PATCH 5/6] ARM: OMAP2+: dts: cm-t335: add support for network device
In-Reply-To: <1445948100-16446-1-git-send-email-uri.mashiach@compulab.co.il>
References: <1445948100-16446-1-git-send-email-uri.mashiach@compulab.co.il>
Message-ID: <1445948100-16446-6-git-send-email-uri.mashiach@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ilya Ledvich <ilya@compulab.co.il>

Add pinmux configurations for RGMII1 based CPSW Ethernet pins and
MDIO pins:
 - default configuration required for module in active state,
 - sleep configuration required for module in inactive state.
Add mac node with single slave device. Add nodes for davinci_mdio and
cpsw_emac0.

Acked-by: Igor Grinberg <grinberg@compulab.co.il>
Signed-off-by: Ilya Ledvich <ilya@compulab.co.il>
Signed-off-by: Uri Mashiach <uri.mashiach@compulab.co.il>
---
 arch/arm/boot/dts/am335x-cm-t335.dts | 85 ++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-cm-t335.dts b/arch/arm/boot/dts/am335x-cm-t335.dts
index 976c330..0296d3f 100644
--- a/arch/arm/boot/dts/am335x-cm-t335.dts
+++ b/arch/arm/boot/dts/am335x-cm-t335.dts
@@ -113,6 +113,71 @@
 		>;
 	};
 
+	cpsw_default: cpsw_default {
+		pinctrl-single,pins = <
+			/* Slave 1 */
+			/* mii1_txen.rgmii1_tctl */
+			0x114 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)
+			/* mii1_rxdv.rgmii1_rctl */
+			0x118 (PIN_INPUT_PULLDOWN | MUX_MODE2)
+			/* mii1_txd3.rgmii1_td3 */
+			0x11c (PIN_OUTPUT_PULLDOWN | MUX_MODE2)
+			/* mii1_txd2.rgmii1_td2 */
+			0x120 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)
+			/* mii1_txd1.rgmii1_td1 */
+			0x124 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)
+			/* mii1_txd0.rgmii1_td0 */
+			0x128 (PIN_OUTPUT_PULLDOWN | MUX_MODE2)
+			/* mii1_txclk.rgmii1_tclk */
+			0x12c (PIN_OUTPUT_PULLDOWN | MUX_MODE2)
+			/* mii1_rxclk.rgmii1_rclk */
+			0x130 (PIN_INPUT_PULLDOWN | MUX_MODE2)
+			/* mii1_rxd3.rgmii1_rd3 */
+			0x134 (PIN_INPUT_PULLDOWN | MUX_MODE2)
+			/* mii1_rxd2.rgmii1_rd2 */
+			0x138 (PIN_INPUT_PULLDOWN | MUX_MODE2)
+			/* mii1_rxd1.rgmii1_rd1 */
+			0x13c (PIN_INPUT_PULLDOWN | MUX_MODE2)
+			/* mii1_rxd0.rgmii1_rd0 */
+			0x140 (PIN_INPUT_PULLDOWN | MUX_MODE2)
+		>;
+	};
+
+	cpsw_sleep: cpsw_sleep {
+		pinctrl-single,pins = <
+			/* Slave 1 reset value */
+			0x114 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			0x118 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			0x11c (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			0x120 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			0x124 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			0x128 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			0x12c (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			0x130 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			0x134 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			0x138 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			0x13c (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			0x140 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+		>;
+	};
+
+	davinci_mdio_default: davinci_mdio_default {
+		pinctrl-single,pins = <
+			/* mdio_data.mdio_data */
+			0x148 (PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)
+			/* mdio_clk.mdio_clk */
+			0x14c (PIN_OUTPUT_PULLUP | MUX_MODE0)
+		>;
+	};
+
+	davinci_mdio_sleep: davinci_mdio_sleep {
+		pinctrl-single,pins = <
+			/* MDIO reset value */
+			0x148 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			0x14c (PIN_INPUT_PULLDOWN | MUX_MODE7)
+		>;
+	};
+
 	mmc1_pins: pinmux_mmc1_pins {
 		pinctrl-single,pins = <
 			/* mmc0_dat3.mmc0_dat3 */
@@ -228,6 +293,26 @@
 	status = "okay";
 };
 
+&mac {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&cpsw_default>;
+	pinctrl-1 = <&cpsw_sleep>;
+	slaves = <1>;
+	status = "okay";
+};
+
+&davinci_mdio {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&davinci_mdio_default>;
+	pinctrl-1 = <&davinci_mdio_sleep>;
+	status = "okay";
+};
+
+&cpsw_emac0 {
+	phy_id = <&davinci_mdio>, <0>;
+	phy-mode = "rgmii-txid";
+};
+
 &mmc1 {
 	status = "okay";
 	vmmc-supply = <&vmmc_fixed>;
-- 
2.6.0
