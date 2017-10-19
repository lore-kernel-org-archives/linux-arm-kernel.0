From: weiyi.lu@mediatek.com (Weiyi Lu)
Date: Thu, 19 Oct 2017 10:48:49 +0800
Subject: [PATCH v5 8/9] soc: mediatek: add MT2712 scpsys support
In-Reply-To: <1508381330-3700-1-git-send-email-weiyi.lu@mediatek.com>
References: <1508381330-3700-1-git-send-email-weiyi.lu@mediatek.com>
Message-ID: <1508381330-3700-9-git-send-email-weiyi.lu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add scpsys driver for MT2712

Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
---
 drivers/soc/mediatek/mtk-scpsys.c | 106 +++++++++++++++++++++++++++++++++++---
 1 file changed, 100 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
index a4ece75..8809430 100644
--- a/drivers/soc/mediatek/mtk-scpsys.c
+++ b/drivers/soc/mediatek/mtk-scpsys.c
@@ -21,6 +21,7 @@
 #include <linux/soc/mediatek/infracfg.h>
 
 #include <dt-bindings/power/mt2701-power.h>
+#include <dt-bindings/power/mt2712-power.h>
 #include <dt-bindings/power/mt6797-power.h>
 #include <dt-bindings/power/mt7622-power.h>
 #include <dt-bindings/power/mt8173-power.h>
@@ -32,7 +33,7 @@
 #define SPM_DIS_PWR_CON			0x023c
 #define SPM_CONN_PWR_CON		0x0280
 #define SPM_VEN2_PWR_CON		0x0298
-#define SPM_AUDIO_PWR_CON		0x029c	/* MT8173 */
+#define SPM_AUDIO_PWR_CON		0x029c	/* MT8173, MT2712 */
 #define SPM_BDP_PWR_CON			0x029c	/* MT2701 */
 #define SPM_ETH_PWR_CON			0x02a0
 #define SPM_HIF_PWR_CON			0x02a4
@@ -40,12 +41,12 @@
 #define SPM_MFG_2D_PWR_CON		0x02c0
 #define SPM_MFG_ASYNC_PWR_CON		0x02c4
 #define SPM_USB_PWR_CON			0x02cc
+#define SPM_USB2_PWR_CON		0x02d4	/* MT2712 */
 #define SPM_ETHSYS_PWR_CON		0x02e0	/* MT7622 */
 #define SPM_HIF0_PWR_CON		0x02e4	/* MT7622 */
 #define SPM_HIF1_PWR_CON		0x02e8	/* MT7622 */
 #define SPM_WB_PWR_CON			0x02ec	/* MT7622 */
 
-
 #define SPM_PWR_STATUS			0x060c
 #define SPM_PWR_STATUS_2ND		0x0610
 
@@ -64,12 +65,13 @@
 #define PWR_STATUS_ETH			BIT(15)
 #define PWR_STATUS_HIF			BIT(16)
 #define PWR_STATUS_IFR_MSC		BIT(17)
+#define PWR_STATUS_USB2			BIT(19)	/* MT2712 */
 #define PWR_STATUS_VENC_LT		BIT(20)
 #define PWR_STATUS_VENC			BIT(21)
-#define PWR_STATUS_MFG_2D		BIT(22)
-#define PWR_STATUS_MFG_ASYNC		BIT(23)
-#define PWR_STATUS_AUDIO		BIT(24)
-#define PWR_STATUS_USB			BIT(25)
+#define PWR_STATUS_MFG_2D		BIT(22)	/* MT8173 */
+#define PWR_STATUS_MFG_ASYNC		BIT(23)	/* MT8173 */
+#define PWR_STATUS_AUDIO		BIT(24)	/* MT8173, MT2712 */
+#define PWR_STATUS_USB			BIT(25)	/* MT8173, MT2712 */
 #define PWR_STATUS_ETHSYS		BIT(24)	/* MT7622 */
 #define PWR_STATUS_HIF0			BIT(25)	/* MT7622 */
 #define PWR_STATUS_HIF1			BIT(26)	/* MT7622 */
@@ -602,6 +604,85 @@ static void mtk_register_power_domains(struct platform_device *pdev,
 };
 
 /*
+ * MT2712 power domain support
+ */
+static const struct scp_domain_data scp_domain_data_mt2712[] = {
+	[MT2712_POWER_DOMAIN_MM] = {
+		.name = "mm",
+		.sta_mask = PWR_STATUS_DISP,
+		.ctl_offs = SPM_DIS_PWR_CON,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.clk_id = {CLK_MM},
+		.active_wakeup = true,
+	},
+	[MT2712_POWER_DOMAIN_VDEC] = {
+		.name = "vdec",
+		.sta_mask = PWR_STATUS_VDEC,
+		.ctl_offs = SPM_VDE_PWR_CON,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.clk_id = {CLK_MM, CLK_VDEC},
+		.active_wakeup = true,
+	},
+	[MT2712_POWER_DOMAIN_VENC] = {
+		.name = "venc",
+		.sta_mask = PWR_STATUS_VENC,
+		.ctl_offs = SPM_VEN_PWR_CON,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(15, 12),
+		.clk_id = {CLK_MM, CLK_VENC, CLK_JPGDEC},
+		.active_wakeup = true,
+	},
+	[MT2712_POWER_DOMAIN_ISP] = {
+		.name = "isp",
+		.sta_mask = PWR_STATUS_ISP,
+		.ctl_offs = SPM_ISP_PWR_CON,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(13, 12),
+		.clk_id = {CLK_MM},
+		.active_wakeup = true,
+	},
+	[MT2712_POWER_DOMAIN_AUDIO] = {
+		.name = "audio",
+		.sta_mask = PWR_STATUS_AUDIO,
+		.ctl_offs = SPM_AUDIO_PWR_CON,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(15, 12),
+		.clk_id = {CLK_AUDIO},
+		.active_wakeup = true,
+	},
+	[MT2712_POWER_DOMAIN_USB] = {
+		.name = "usb",
+		.sta_mask = PWR_STATUS_USB,
+		.ctl_offs = SPM_USB_PWR_CON,
+		.sram_pdn_bits = GENMASK(10, 8),
+		.sram_pdn_ack_bits = GENMASK(14, 12),
+		.clk_id = {CLK_NONE},
+		.active_wakeup = true,
+	},
+	[MT2712_POWER_DOMAIN_USB2] = {
+		.name = "usb2",
+		.sta_mask = PWR_STATUS_USB2,
+		.ctl_offs = SPM_USB2_PWR_CON,
+		.sram_pdn_bits = GENMASK(10, 8),
+		.sram_pdn_ack_bits = GENMASK(14, 12),
+		.clk_id = {CLK_NONE},
+		.active_wakeup = true,
+	},
+	[MT2712_POWER_DOMAIN_MFG] = {
+		.name = "mfg",
+		.sta_mask = PWR_STATUS_MFG,
+		.ctl_offs = SPM_MFG_PWR_CON,
+		.sram_pdn_bits = GENMASK(11, 8),
+		.sram_pdn_ack_bits = GENMASK(19, 16),
+		.clk_id = {CLK_MFG},
+		.bus_prot_mask = BIT(14) | BIT(21) | BIT(23),
+		.active_wakeup = true,
+	},
+};
+
+/*
  * MT6797 power domain support
  */
 
@@ -831,6 +912,16 @@ static void mtk_register_power_domains(struct platform_device *pdev,
 	.bus_prot_use_set_clr_reg = false,
 };
 
+static const struct scp_soc_data mt2712_data = {
+	.domains = scp_domain_data_mt2712,
+	.num_domains = ARRAY_SIZE(scp_domain_data_mt2712),
+	.regs = {
+		.pwr_sta_offs = SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND
+	},
+	.bus_prot_use_set_clr_reg = true,
+};
+
 static const struct scp_soc_data mt6797_data = {
 	.domains = scp_domain_data_mt6797,
 	.num_domains = ARRAY_SIZE(scp_domain_data_mt6797),
@@ -874,6 +965,9 @@ static void mtk_register_power_domains(struct platform_device *pdev,
 		.compatible = "mediatek,mt2701-scpsys",
 		.data = &mt2701_data,
 	}, {
+		.compatible = "mediatek,mt2712-scpsys",
+		.data = &mt2712_data,
+	}, {
 		.compatible = "mediatek,mt6797-scpsys",
 		.data = &mt6797_data,
 	}, {
-- 
1.9.1
