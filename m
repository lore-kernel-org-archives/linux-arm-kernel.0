From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 14 May 2018 03:14:25 +0800
Subject: [PATCH RESEND net-next v2 8/8] net: stmmac: dwmac-sun8i: Add support
 for GMAC on Allwinner R40 SoC
In-Reply-To: <20180513191425.9801-1-wens@csie.org>
References: <20180513191425.9801-1-wens@csie.org>
Message-ID: <20180513191425.9801-9-wens@csie.org>
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
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c   | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index 4f5612a3c855..2f7f0915f071 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -93,6 +93,13 @@ static const struct reg_field sun8i_syscon_reg_field = {
 	.msb = 31,
 };
 
+/* EMAC clock register @ 0x164 in the CCU address range */
+static const struct reg_field sun8i_ccu_reg_field = {
+	.reg = 0x164,
+	.lsb = 0,
+	.msb = 31,
+};
+
 static const struct emac_variant emac_variant_h3 = {
 	.default_syscon_value = 0x58000,
 	.syscon_field = &sun8i_syscon_reg_field,
@@ -121,6 +128,14 @@ static const struct emac_variant emac_variant_a83t = {
 	.tx_delay_max = 7,
 };
 
+static const struct emac_variant emac_variant_r40 = {
+	.default_syscon_value = 0,
+	.syscon_field = &sun8i_ccu_reg_field,
+	.support_mii = true,
+	.support_rgmii = true,
+	.rx_delay_max = 7,
+};
+
 static const struct emac_variant emac_variant_a64 = {
 	.default_syscon_value = 0,
 	.syscon_field = &sun8i_syscon_reg_field,
@@ -1160,6 +1175,8 @@ static const struct of_device_id sun8i_dwmac_match[] = {
 		.data = &emac_variant_v3s },
 	{ .compatible = "allwinner,sun8i-a83t-emac",
 		.data = &emac_variant_a83t },
+	{ .compatible = "allwinner,sun8i-r40-gmac",
+		.data = &emac_variant_r40 },
 	{ .compatible = "allwinner,sun50i-a64-emac",
 		.data = &emac_variant_a64 },
 	{ }
-- 
2.17.0
