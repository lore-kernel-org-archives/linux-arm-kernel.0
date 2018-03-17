From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 17 Mar 2018 17:28:54 +0800
Subject: [PATCH net-next 09/12] net: stmmac: dwmac-sun8i: Add support for GMAC
 on Allwinner R40 SoC
In-Reply-To: <20180317092857.4396-1-wens@csie.org>
References: <20180317092857.4396-1-wens@csie.org>
Message-ID: <20180317092857.4396-10-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Allwinner R40 SoC has the EMAC controller supported by dwmac-sun8i.
It is named "GMAC", while EMAC refers to the 10/100 Mbps Ethernet
controller supported by sun4i-emac. The controller is the same, but
the R40 has the glue layer controls in the clock control unit (CCU),
with a reduced RX delay chain, and no TX delay chain.

This patch adds support for it using the framework laid out by previous
patches to map the differences.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index 08d263567a52..be6705e89e95 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -97,6 +97,13 @@ const struct reg_field sun8i_syscon_reg_field = {
 	.msb = 31,
 };
 
+/* EMAC clock register @ 0x164 in the CCU address range */
+const struct reg_field sun8i_ccu_reg_field = {
+	.reg = 0x164,
+	.lsb = 0,
+	.msb = 31,
+};
+
 static const struct emac_variant emac_variant_h3 = {
 	.default_syscon_value = 0x58000,
 	.syscon_field = &sun8i_syscon_reg_field,
@@ -125,6 +132,15 @@ static const struct emac_variant emac_variant_a83t = {
 	.tx_delay_max = 7,
 };
 
+static const struct emac_variant emac_variant_r40 = {
+	.default_syscon_value = 0,
+	.syscon_field = &sun8i_ccu_reg_field,
+	.syscon_from_dev = true,
+	.support_mii = true,
+	.support_rgmii = true,
+	.rx_delay_max = 7,
+};
+
 static const struct emac_variant emac_variant_a64 = {
 	.default_syscon_value = 0,
 	.syscon_field = &sun8i_syscon_reg_field,
@@ -1148,6 +1164,8 @@ static const struct of_device_id sun8i_dwmac_match[] = {
 		.data = &emac_variant_v3s },
 	{ .compatible = "allwinner,sun8i-a83t-emac",
 		.data = &emac_variant_a83t },
+	{ .compatible = "allwinner,sun8i-r40-gmac",
+		.data = &emac_variant_r40 },
 	{ .compatible = "allwinner,sun50i-a64-emac",
 		.data = &emac_variant_a64 },
 	{ }
-- 
2.16.2
