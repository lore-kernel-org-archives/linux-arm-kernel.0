From: nikita@compulab.co.il (Nikita Kiryanov)
Date: Tue,  1 Dec 2015 15:55:01 +0200
Subject: [PATCH V2 06/14] ARM: dts: am437x: cm-t43: add dual emac support
In-Reply-To: <1448978109-5614-1-git-send-email-nikita@compulab.co.il>
References: <1448978109-5614-1-git-send-email-nikita@compulab.co.il>
Message-ID: <1448978109-5614-7-git-send-email-nikita@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CM-T43 comes with 2 ethernet ports connected to the cpsw subsystem, which
has 2 modes of operation: switch mode and dual emac mode.
Add the relevant muxing and set it up to work in dual emac mode by
default.

Signed-off-by: Nikita Kiryanov <nikita@compulab.co.il>
Acked-by: Mugunthan V N <mugunthanvnm@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Benoit Cousson <bcousson@baylibre.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>
Cc: Dmitry Lifshitz <lifshitz@compulab.co.il>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
---
Changes in V2:
	- No changes.

 arch/arm/boot/dts/am437x-cm-t43.dts | 66 +++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/arch/arm/boot/dts/am437x-cm-t43.dts b/arch/arm/boot/dts/am437x-cm-t43.dts
index efabb31..fd97a89 100644
--- a/arch/arm/boot/dts/am437x-cm-t43.dts
+++ b/arch/arm/boot/dts/am437x-cm-t43.dts
@@ -73,6 +73,47 @@
 			AM4372_IOPAD(0x89c, PIN_OUTPUT_PULLDOWN | MUX_MODE0)
 		>;
 	};
+
+	cpsw_default: cpsw_default {
+		pinctrl-single,pins = <
+			/* Slave 1 */
+			AM4372_IOPAD(0x914, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txen.rgmii1_txen */
+			AM4372_IOPAD(0x918, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxdv.rgmii1_rxctl */
+			AM4372_IOPAD(0x91c, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd1.rgmii1_txd3 */
+			AM4372_IOPAD(0x920, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd0.rgmii1_txd2 */
+			AM4372_IOPAD(0x924, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd1.rgmii1_txd1 */
+			AM4372_IOPAD(0x928, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txd0.rgmii1_txd0 */
+			AM4372_IOPAD(0x92c, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* mii1_txclk.rmii1_tclk */
+			AM4372_IOPAD(0x930, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxclk.rmii1_rclk */
+			AM4372_IOPAD(0x934, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd1.rgmii1_rxd3 */
+			AM4372_IOPAD(0x938, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd0.rgmii1_rxd2 */
+			AM4372_IOPAD(0x93c, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd1.rgmii1_rxd1 */
+			AM4372_IOPAD(0x940, PIN_INPUT_PULLDOWN | MUX_MODE2)	/* mii1_rxd0.rgmii1_rxd0 */
+			AM4372_IOPAD(0xa74, MUX_MODE3)
+			/* Slave 2 */
+			AM4372_IOPAD(0x840, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a0.txen */
+			AM4372_IOPAD(0x844, PIN_INPUT_PULLDOWN  | MUX_MODE2)	/* gpmc_a1.rxctl */
+			AM4372_IOPAD(0x848, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a2.txd3 */
+			AM4372_IOPAD(0x84c, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a3.txd2 */
+			AM4372_IOPAD(0x850, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a4.txd1 */
+			AM4372_IOPAD(0x854, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a5.txd0 */
+			AM4372_IOPAD(0x858, PIN_OUTPUT_PULLDOWN | MUX_MODE2)	/* gpmc_a6.tclk */
+			AM4372_IOPAD(0x85c, PIN_INPUT_PULLDOWN  | MUX_MODE2)	/* gpmc_a7.rclk */
+			AM4372_IOPAD(0x860, PIN_INPUT_PULLDOWN  | MUX_MODE2)	/* gpmc_a8.rxd3 */
+			AM4372_IOPAD(0x864, PIN_INPUT_PULLDOWN  | MUX_MODE2)	/* gpmc_a9.rxd2 */
+			AM4372_IOPAD(0x868, PIN_INPUT_PULLDOWN  | MUX_MODE2)	/* gpmc_a10.rxd1 */
+			AM4372_IOPAD(0x86c, PIN_INPUT_PULLDOWN  | MUX_MODE2)	/* gpmc_a11.rxd0 */
+			AM4372_IOPAD(0xa38, MUX_MODE7)
+		>;
+	};
+
+	davinci_mdio_default: davinci_mdio_default {
+		pinctrl-single,pins = <
+			/* MDIO */
+			AM4372_IOPAD(0x948, PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)	/* mdio_data.mdio_data */
+			AM4372_IOPAD(0x94c, PIN_OUTPUT_PULLUP | MUX_MODE0)			/* mdio_clk.mdio_clk */
+		>;
+	};
 };
 
 &gpmc {
@@ -261,6 +302,31 @@
 	};
 };
 
+&mac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&cpsw_default>;
+	dual_emac = <1>;
+	status = "okay";
+};
+
+&davinci_mdio {
+	pinctrl-names = "default";
+	pinctrl-0 = <&davinci_mdio_default>;
+	status = "okay";
+};
+
+&cpsw_emac0 {
+	phy_id = <&davinci_mdio>, <0>;
+	phy-mode = "rgmii-txid";
+	dual_emac_res_vlan = <1>;
+};
+
+&cpsw_emac1 {
+	phy_id = <&davinci_mdio>, <1>;
+	phy-mode = "rgmii-txid";
+	dual_emac_res_vlan = <2>;
+};
+
 &elm {
 	status = "okay";
 };
-- 
1.9.1
