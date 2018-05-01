From: wens@csie.org (Chen-Yu Tsai)
Date: Wed,  2 May 2018 00:12:21 +0800
Subject: [PATCH net-next v2 09/15] net: stmmac: dwmac-sun8i: Support different
 ranges for TX/RX delay chains
In-Reply-To: <20180501161227.2110-1-wens@csie.org>
References: <20180501161227.2110-1-wens@csie.org>
Message-ID: <20180501161227.2110-10-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the R40 SoC, the RX delay chain only has a range of 0~7 (hundred
picoseconds), instead of 0~31. Also the TX delay chain is completely
absent.

This patch adds support for different ranges by adding per-compatible
maximum values in the variant data. A maximum of 0 indicates that the
delay chain is not supported or absent.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 32 +++++++++++++------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index 79e104a20e20..4f5612a3c855 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -47,6 +47,12 @@
  * @support_mii:		Does the MAC handle MII
  * @support_rmii:		Does the MAC handle RMII
  * @support_rgmii:		Does the MAC handle RGMII
+ *
+ * @rx_delay_max:		Maximum raw value for RX delay chain
+ * @tx_delay_max:		Maximum raw value for TX delay chain
+ *				These two also indicate the bitmask for
+ *				the RX and TX delay chain registers. A
+ *				value of zero indicates this is not supported.
  */
 struct emac_variant {
 	u32 default_syscon_value;
@@ -55,6 +61,8 @@ struct emac_variant {
 	bool support_mii;
 	bool support_rmii;
 	bool support_rgmii;
+	u8 rx_delay_max;
+	u8 tx_delay_max;
 };
 
 /* struct sunxi_priv_data - hold all sunxi private data
@@ -91,7 +99,9 @@ static const struct emac_variant emac_variant_h3 = {
 	.soc_has_internal_phy = true,
 	.support_mii = true,
 	.support_rmii = true,
-	.support_rgmii = true
+	.support_rgmii = true,
+	.rx_delay_max = 31,
+	.tx_delay_max = 7,
 };
 
 static const struct emac_variant emac_variant_v3s = {
@@ -106,7 +116,9 @@ static const struct emac_variant emac_variant_a83t = {
 	.syscon_field = &sun8i_syscon_reg_field,
 	.soc_has_internal_phy = false,
 	.support_mii = true,
-	.support_rgmii = true
+	.support_rgmii = true,
+	.rx_delay_max = 31,
+	.tx_delay_max = 7,
 };
 
 static const struct emac_variant emac_variant_a64 = {
@@ -115,7 +127,9 @@ static const struct emac_variant emac_variant_a64 = {
 	.soc_has_internal_phy = false,
 	.support_mii = true,
 	.support_rmii = true,
-	.support_rgmii = true
+	.support_rgmii = true,
+	.rx_delay_max = 31,
+	.tx_delay_max = 7,
 };
 
 #define EMAC_BASIC_CTL0 0x00
@@ -219,9 +233,7 @@ static const struct emac_variant emac_variant_a64 = {
 #define SYSCON_RMII_EN		BIT(13) /* 1: enable RMII (overrides EPIT) */
 
 /* Generic system control EMAC_CLK bits */
-#define SYSCON_ETXDC_MASK		GENMASK(2, 0)
 #define SYSCON_ETXDC_SHIFT		10
-#define SYSCON_ERXDC_MASK		GENMASK(4, 0)
 #define SYSCON_ERXDC_SHIFT		5
 /* EMAC PHY Interface Type */
 #define SYSCON_EPIT			BIT(2) /* 1: RGMII, 0: MII */
@@ -847,8 +859,9 @@ static int sun8i_dwmac_set_syscon(struct stmmac_priv *priv)
 		}
 		val /= 100;
 		dev_dbg(priv->device, "set tx-delay to %x\n", val);
-		if (val <= SYSCON_ETXDC_MASK) {
-			reg &= ~(SYSCON_ETXDC_MASK << SYSCON_ETXDC_SHIFT);
+		if (val <= gmac->variant->tx_delay_max) {
+			reg &= ~(gmac->variant->tx_delay_max <<
+				 SYSCON_ETXDC_SHIFT);
 			reg |= (val << SYSCON_ETXDC_SHIFT);
 		} else {
 			dev_err(priv->device, "Invalid TX clock delay: %d\n",
@@ -864,8 +877,9 @@ static int sun8i_dwmac_set_syscon(struct stmmac_priv *priv)
 		}
 		val /= 100;
 		dev_dbg(priv->device, "set rx-delay to %x\n", val);
-		if (val <= SYSCON_ERXDC_MASK) {
-			reg &= ~(SYSCON_ERXDC_MASK << SYSCON_ERXDC_SHIFT);
+		if (val <= gmac->variant->rx_delay_max) {
+			reg &= ~(gmac->variant->rx_delay_max <<
+				 SYSCON_ERXDC_SHIFT);
 			reg |= (val << SYSCON_ERXDC_SHIFT);
 		} else {
 			dev_err(priv->device, "Invalid RX clock delay: %d\n",
-- 
2.17.0
