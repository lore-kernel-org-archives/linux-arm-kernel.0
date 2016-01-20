From: jamesjj.liao@mediatek.com (James Liao)
Date: Wed, 20 Jan 2016 14:08:17 +0800
Subject: [PATCH v4 4/4] soc: mediatek: Add MT2701 scpsys driver
In-Reply-To: <1453270097-53853-1-git-send-email-jamesjj.liao@mediatek.com>
References: <1453270097-53853-1-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <1453270097-53853-5-git-send-email-jamesjj.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shunli Wang <shunli.wang@mediatek.com>

Add scpsys driver for MT2701.

Signed-off-by: Shunli Wang <shunli.wang@mediatek.com>
Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
---
 drivers/soc/mediatek/mtk-scpsys.c | 97 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
index 0490a93..ee193aa 100644
--- a/drivers/soc/mediatek/mtk-scpsys.c
+++ b/drivers/soc/mediatek/mtk-scpsys.c
@@ -402,6 +402,100 @@ void mtk_register_power_domains(struct platform_device *pdev,
 }
 
 /*
+ * MT2701 power domain support
+ */
+
+#include <dt-bindings/power/mt2701-power.h>
+
+static const struct scp_domain_data scp_domain_data_mt2701[] __initconst = {
+	[MT2701_POWER_DOMAIN_CONN] = {
+		.name = "conn",
+		.sta_mask = BIT(1),
+		.ctl_offs = 0x0280,
+		.bus_prot_mask = 0x0104,
+		.active_wakeup = true,
+	},
+	[MT2701_POWER_DOMAIN_DISP] = {
+		.name = "disp",
+		.sta_mask = BIT(3),
+		.ctl_offs = 0x023c,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.clk_id = {CLK_MM},
+		.bus_prot_mask = 0x0002,
+		.active_wakeup = true,
+	},
+	[MT2701_POWER_DOMAIN_MFG] = {
+		.name = "mfg",
+		.sta_mask = BIT(4),
+		.ctl_offs = 0x0214,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.active_wakeup = true,
+	},
+	[MT2701_POWER_DOMAIN_VDEC] = {
+		.name = "vdec",
+		.sta_mask = BIT(7),
+		.ctl_offs = 0x0210,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.clk_id = {CLK_MM},
+		.active_wakeup = true,
+	},
+	[MT2701_POWER_DOMAIN_ISP] = {
+		.name = "isp",
+		.sta_mask = BIT(5),
+		.ctl_offs = 0x0238,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(13, 12),
+		.active_wakeup = true,
+	},
+	[MT2701_POWER_DOMAIN_BDP] = {
+		.name = "bdp",
+		.sta_mask = BIT(14),
+		.ctl_offs = 0x029c,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.active_wakeup = true,
+	},
+	[MT2701_POWER_DOMAIN_ETH] = {
+		.name = "eth",
+		.sta_mask = BIT(15),
+		.ctl_offs = 0x02a0,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(15, 12),
+		.active_wakeup = true,
+	},
+	[MT2701_POWER_DOMAIN_HIF] = {
+		.name = "hif",
+		.sta_mask = BIT(16),
+		.ctl_offs = 0x02a4,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(15, 12),
+		.active_wakeup = true,
+	},
+	[MT2701_POWER_DOMAIN_IFR_MSC] = {
+		.name = "ifr_msc",
+		.sta_mask = BIT(17),
+		.ctl_offs = 0x02a8,
+		.active_wakeup = true,
+	},
+};
+
+#define NUM_DOMAINS_MT2701	ARRAY_SIZE(scp_domain_data_mt2701)
+
+static int __init scpsys_probe_mt2701(struct platform_device *pdev)
+{
+	struct scp *scp;
+
+	scp = init_scp(pdev, scp_domain_data_mt2701, NUM_DOMAINS_MT2701);
+	if (IS_ERR(scp))
+		return PTR_ERR(scp);
+
+	mtk_register_power_domains(pdev, scp, NUM_DOMAINS_MT2701);
+
+	return 0;
+}
+
+/*
  * MT8173 power domain support
  */
 
@@ -532,6 +626,9 @@ static int __init scpsys_probe_mt8173(struct platform_device *pdev)
 
 static const struct of_device_id of_scpsys_match_tbl[] = {
 	{
+		.compatible = "mediatek,mt2701-scpsys",
+		.data = scpsys_probe_mt2701,
+	}, {
 		.compatible = "mediatek,mt8173-scpsys",
 		.data = scpsys_probe_mt8173,
 	}, {
-- 
1.9.1
