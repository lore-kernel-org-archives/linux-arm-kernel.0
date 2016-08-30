From: wxt@rock-chips.com (Caesar Wang)
Date: Wed, 31 Aug 2016 04:30:06 +0800
Subject: [PATCH 3/4] arm64: dts: rockchip: support gmac for rk3399
In-Reply-To: <1472589008-7713-1-git-send-email-wxt@rock-chips.com>
References: <1472589008-7713-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1472589008-7713-4-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds needed gamc information for rk3399,
also support the gmac pd.

Signed-off-by: Roger Chen <roger.chen@rock-chips.com>
Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 90 ++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 32aebc8..53ac651 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -200,6 +200,26 @@
 		};
 	};
 
+	gmac: eth at fe300000 {
+		compatible = "rockchip,rk3399-gmac";
+		reg = <0x0 0xfe300000 0x0 0x10000>;
+		rockchip,grf = <&grf>;
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
+		resets = <&cru SRST_A_GMAC>;
+		reset-names = "stmmaceth";
+		power-domains = <&power RK3399_PD_GMAC>;
+		status = "disabled";
+	};
+
 	sdio0: dwmmc at fe310000 {
 		compatible = "rockchip,rk3399-dw-mshc",
 			     "rockchip,rk3288-dw-mshc";
@@ -611,6 +631,11 @@
 		status = "disabled";
 	};
 
+	qos_gmac: qos at ffa5c000 {
+		compatible = "syscon";
+		reg = <0x0 0xffa5c000 0x0 0x20>;
+	};
+
 	qos_hdcp: qos at ffa90000 {
 		compatible = "syscon";
 		reg = <0x0 0xffa90000 0x0 0x20>;
@@ -704,6 +729,11 @@
 			#size-cells = <0>;
 
 			/* These power domains are grouped by VD_CENTER */
+			pd_gmac at RK3399_PD_GMAC {
+				reg = <RK3399_PD_GMAC>;
+				clocks = <&cru ACLK_GMAC>;
+				pm_qos = <&qos_gmac>;
+			};
 			pd_iep at RK3399_PD_IEP {
 				reg = <RK3399_PD_IEP>;
 				clocks = <&cru ACLK_IEP>,
@@ -1183,6 +1213,66 @@
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
