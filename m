From: wxt@rock-chips.com (Caesar Wang)
Date: Thu,  1 Sep 2016 07:28:51 +0800
Subject: [PATCH v3 4/5] arm64: dts: rockchip: add the gmac needed node for
 rk3399
In-Reply-To: <1472686132-27827-1-git-send-email-wxt@rock-chips.com>
References: <1472686132-27827-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1472686132-27827-5-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The RK3399 GMAC Ethernet Controller provides a complete Ethernet interface
from processor to a Reduced Media Independent Interface (RMII) and Reduced
Gigabit Media Independent Interface (RGMII) compliant Ethernet PHY.

This patch adds the related needed device information.
e.g.: interrupts, grf, clocks, pinctrl and so on.

The full details are in [0].

[0]:
Documentation/devicetree/bindings/net/rockchip-dwmac.txt

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

Changes in v3:
- generate a patch from https://patchwork.kernel.org/patch/9306339/.

Changes in v2: None

 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 80 ++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 2ab233f..092bb45 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -200,6 +200,26 @@
 		};
 	};
 
+	gmac: ethernet at fe300000 {
+		compatible = "rockchip,rk3399-gmac";
+		reg = <0x0 0xfe300000 0x0 0x10000>;
+		interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "macirq";
+		clocks = <&cru SCLK_MAC>, <&cru SCLK_MAC_RX>,
+			 <&cru SCLK_MAC_TX>, <&cru SCLK_MACREF>,
+			 <&cru SCLK_MACREF_OUT>, <&cru ACLK_GMAC>,
+			 <&cru PCLK_GMAC>;
+		clock-names = "stmmaceth", "mac_clk_rx",
+			      "mac_clk_tx", "clk_mac_ref",
+			      "clk_mac_refout", "aclk_mac",
+			      "pclk_mac";
+		power-domains = <&power RK3399_PD_GMAC>;
+		resets = <&cru SRST_A_GMAC>;
+		reset-names = "stmmaceth";
+		rockchip,grf = <&grf>;
+		status = "disabled";
+	};
+
 	sdio0: dwmmc at fe310000 {
 		compatible = "rockchip,rk3399-dw-mshc",
 			     "rockchip,rk3288-dw-mshc";
@@ -1193,6 +1213,66 @@
 			drive-strength = <13>;
 		};
 
+		gmac {
+			rgmii_pins: rgmii-pins {
+				rockchip,pins =
+					/* mac_txclk */
+					<3 17 RK_FUNC_1 &pcfg_pull_none_13ma>,
+					/* mac_rxclk */
+					<3 14 RK_FUNC_1 &pcfg_pull_none>,
+					/* mac_mdio */
+					<3 13 RK_FUNC_1 &pcfg_pull_none>,
+					/* mac_txen */
+					<3 12 RK_FUNC_1 &pcfg_pull_none_13ma>,
+					/* mac_clk */
+					<3 11 RK_FUNC_1 &pcfg_pull_none>,
+					/* mac_rxdv */
+					<3 9 RK_FUNC_1 &pcfg_pull_none>,
+					/* mac_mdc */
+					<3 8 RK_FUNC_1 &pcfg_pull_none>,
+					/* mac_rxd1 */
+					<3 7 RK_FUNC_1 &pcfg_pull_none>,
+					/* mac_rxd0 */
+					<3 6 RK_FUNC_1 &pcfg_pull_none>,
+					/* mac_txd1 */
+					<3 5 RK_FUNC_1 &pcfg_pull_none_13ma>,
+					/* mac_txd0 */
+					<3 4 RK_FUNC_1 &pcfg_pull_none_13ma>,
+					/* mac_rxd3 */
+					<3 3 RK_FUNC_1 &pcfg_pull_none>,
+					/* mac_rxd2 */
+					<3 2 RK_FUNC_1 &pcfg_pull_none>,
+					/* mac_txd3 */
+					<3 1 RK_FUNC_1 &pcfg_pull_none_13ma>,
+					/* mac_txd2 */
+					<3 0 RK_FUNC_1 &pcfg_pull_none_13ma>;
+			};
+
+			rmii_pins: rmii-pins {
+				rockchip,pins =
+					/* mac_mdio */
+					<3 13 RK_FUNC_1 &pcfg_pull_none>,
+					/* mac_txen */
+					<3 12 RK_FUNC_1 &pcfg_pull_none_13ma>,
+					/* mac_clk */
+					<3 11 RK_FUNC_1 &pcfg_pull_none>,
+					/* mac_rxer */
+					<3 10 RK_FUNC_1 &pcfg_pull_none>,
+					/* mac_rxdv */
+					<3 9 RK_FUNC_1 &pcfg_pull_none>,
+					/* mac_mdc */
+					<3 8 RK_FUNC_1 &pcfg_pull_none>,
+					/* mac_rxd1 */
+					<3 7 RK_FUNC_1 &pcfg_pull_none>,
+					/* mac_rxd0 */
+					<3 6 RK_FUNC_1 &pcfg_pull_none>,
+					/* mac_txd1 */
+					<3 5 RK_FUNC_1 &pcfg_pull_none_13ma>,
+					/* mac_txd0 */
+					<3 4 RK_FUNC_1 &pcfg_pull_none_13ma>;
+			};
+		};
+
 		i2c0 {
 			i2c0_xfer: i2c0-xfer {
 				rockchip,pins =
-- 
1.9.1
