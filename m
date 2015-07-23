From: eddie.huang@mediatek.com (Eddie Huang)
Date: Thu, 23 Jul 2015 14:00:49 +0800
Subject: [PATCH] soc: mediatek: add scpsys support active_wakeup
Message-ID: <1437631249-706-1-git-send-email-eddie.huang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Register gpd_dev_ops.active_wakeup function to support keep power
during suspend state. And add flag to each power domain to
decide whether keep power during suspend or not.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
---
 drivers/soc/mediatek/mtk-scpsys.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
index 43a79ed..fc78b70 100644
--- a/drivers/soc/mediatek/mtk-scpsys.c
+++ b/drivers/soc/mediatek/mtk-scpsys.c
@@ -67,6 +67,7 @@ struct scp_domain_data {
 	u32 sram_pdn_ack_bits;
 	u32 bus_prot_mask;
 	enum clk_id clk_id;
+	bool active_wakeup;
 };
 
 static const struct scp_domain_data scp_domain_data[] __initconst = {
@@ -77,6 +78,7 @@ static const struct scp_domain_data scp_domain_data[] __initconst = {
 		.sram_pdn_bits = GENMASK(11, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
 		.clk_id = MT8173_CLK_MM,
+		.active_wakeup = false,
 	},
 	[MT8173_POWER_DOMAIN_VENC] = {
 		.name = "venc",
@@ -85,6 +87,7 @@ static const struct scp_domain_data scp_domain_data[] __initconst = {
 		.sram_pdn_bits = GENMASK(11, 8),
 		.sram_pdn_ack_bits = GENMASK(15, 12),
 		.clk_id = MT8173_CLK_MM,
+		.active_wakeup = false,
 	},
 	[MT8173_POWER_DOMAIN_ISP] = {
 		.name = "isp",
@@ -93,6 +96,7 @@ static const struct scp_domain_data scp_domain_data[] __initconst = {
 		.sram_pdn_bits = GENMASK(11, 8),
 		.sram_pdn_ack_bits = GENMASK(13, 12),
 		.clk_id = MT8173_CLK_MM,
+		.active_wakeup = false,
 	},
 	[MT8173_POWER_DOMAIN_MM] = {
 		.name = "mm",
@@ -101,6 +105,7 @@ static const struct scp_domain_data scp_domain_data[] __initconst = {
 		.sram_pdn_bits = GENMASK(11, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
 		.clk_id = MT8173_CLK_MM,
+		.active_wakeup = false,
 		.bus_prot_mask = MT8173_TOP_AXI_PROT_EN_MM_M0 |
 			MT8173_TOP_AXI_PROT_EN_MM_M1,
 	},
@@ -111,6 +116,7 @@ static const struct scp_domain_data scp_domain_data[] __initconst = {
 		.sram_pdn_bits = GENMASK(11, 8),
 		.sram_pdn_ack_bits = GENMASK(15, 12),
 		.clk_id = MT8173_CLK_MM,
+		.active_wakeup = false,
 	},
 	[MT8173_POWER_DOMAIN_AUDIO] = {
 		.name = "audio",
@@ -119,6 +125,7 @@ static const struct scp_domain_data scp_domain_data[] __initconst = {
 		.sram_pdn_bits = GENMASK(11, 8),
 		.sram_pdn_ack_bits = GENMASK(15, 12),
 		.clk_id = MT8173_CLK_NONE,
+		.active_wakeup = false,
 	},
 	[MT8173_POWER_DOMAIN_USB] = {
 		.name = "usb",
@@ -127,6 +134,7 @@ static const struct scp_domain_data scp_domain_data[] __initconst = {
 		.sram_pdn_bits = GENMASK(11, 8),
 		.sram_pdn_ack_bits = GENMASK(15, 12),
 		.clk_id = MT8173_CLK_NONE,
+		.active_wakeup = true,
 	},
 	[MT8173_POWER_DOMAIN_MFG_ASYNC] = {
 		.name = "mfg_async",
@@ -135,6 +143,7 @@ static const struct scp_domain_data scp_domain_data[] __initconst = {
 		.sram_pdn_bits = GENMASK(11, 8),
 		.sram_pdn_ack_bits = 0,
 		.clk_id = MT8173_CLK_MFG,
+		.active_wakeup = false,
 	},
 	[MT8173_POWER_DOMAIN_MFG_2D] = {
 		.name = "mfg_2d",
@@ -143,6 +152,7 @@ static const struct scp_domain_data scp_domain_data[] __initconst = {
 		.sram_pdn_bits = GENMASK(11, 8),
 		.sram_pdn_ack_bits = GENMASK(13, 12),
 		.clk_id = MT8173_CLK_NONE,
+		.active_wakeup = false,
 	},
 	[MT8173_POWER_DOMAIN_MFG] = {
 		.name = "mfg",
@@ -151,6 +161,7 @@ static const struct scp_domain_data scp_domain_data[] __initconst = {
 		.sram_pdn_bits = GENMASK(13, 8),
 		.sram_pdn_ack_bits = GENMASK(21, 16),
 		.clk_id = MT8173_CLK_NONE,
+		.active_wakeup = false,
 		.bus_prot_mask = MT8173_TOP_AXI_PROT_EN_MFG_S |
 			MT8173_TOP_AXI_PROT_EN_MFG_M0 |
 			MT8173_TOP_AXI_PROT_EN_MFG_M1 |
@@ -171,6 +182,7 @@ struct scp_domain {
 	u32 sram_pdn_bits;
 	u32 sram_pdn_ack_bits;
 	u32 bus_prot_mask;
+	bool active_wakeup;
 };
 
 struct scp {
@@ -370,6 +382,20 @@ out:
 	return ret;
 }
 
+static bool scpsys_active_wakeup(struct device *dev)
+{
+	struct generic_pm_domain *genpd;
+	struct scp_domain *scpd;
+
+	if (IS_ERR_OR_NULL(dev->pm_domain))
+		return false;
+
+	genpd = pd_to_genpd(dev->pm_domain);
+	scpd = container_of(genpd, struct scp_domain, genpd);
+
+	return scpd->active_wakeup;
+}
+
 static int __init scpsys_probe(struct platform_device *pdev)
 {
 	struct genpd_onecell_data *pd_data;
@@ -427,12 +453,14 @@ static int __init scpsys_probe(struct platform_device *pdev)
 		scpd->sram_pdn_bits = data->sram_pdn_bits;
 		scpd->sram_pdn_ack_bits = data->sram_pdn_ack_bits;
 		scpd->bus_prot_mask = data->bus_prot_mask;
+		scpd->active_wakeup = data->active_wakeup;
 		if (data->clk_id != MT8173_CLK_NONE)
 			scpd->clk = clk[data->clk_id];
 
 		genpd->name = data->name;
 		genpd->power_off = scpsys_power_off;
 		genpd->power_on = scpsys_power_on;
+		genpd->dev_ops.active_wakeup = scpsys_active_wakeup;
 
 		/*
 		 * Initially turn on all domains to make the domains usable
-- 
1.8.1.1.dirty
