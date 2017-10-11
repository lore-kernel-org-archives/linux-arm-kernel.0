From: chaotian.jing@mediatek.com (Chaotian Jing)
Date: Wed, 11 Oct 2017 10:41:31 +0800
Subject: [PATCH v5 07/12] mmc: mediatek: add busy_check support
In-Reply-To: <1507689696-25928-1-git-send-email-chaotian.jing@mediatek.com>
References: <1507689696-25928-1-git-send-email-chaotian.jing@mediatek.com>
Message-ID: <1507689696-25928-8-git-send-email-chaotian.jing@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

bit7 of PATCH_BIT1 has different meaning in new design, to
compatible with previous platform, clear this bit in new
platform.

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 8113bac..eceaee8 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -316,6 +316,7 @@ struct mtk_mmc_compatible {
 	u32 pad_tune_reg;
 	bool async_fifo;
 	bool data_tune;
+	bool busy_check;
 };
 
 struct msdc_tune_para {
@@ -380,6 +381,7 @@ struct msdc_host {
 	.pad_tune_reg = MSDC_PAD_TUNE,
 	.async_fifo = false,
 	.data_tune = false,
+	.busy_check = false,
 };
 
 static const struct mtk_mmc_compatible mt8173_compat = {
@@ -388,6 +390,7 @@ struct msdc_host {
 	.pad_tune_reg = MSDC_PAD_TUNE,
 	.async_fifo = false,
 	.data_tune = false,
+	.busy_check = false,
 };
 
 static const struct mtk_mmc_compatible mt2701_compat = {
@@ -396,6 +399,7 @@ struct msdc_host {
 	.pad_tune_reg = MSDC_PAD_TUNE0,
 	.async_fifo = true,
 	.data_tune = true,
+	.busy_check = false,
 };
 
 static const struct mtk_mmc_compatible mt2712_compat = {
@@ -404,6 +408,7 @@ struct msdc_host {
 	.pad_tune_reg = MSDC_PAD_TUNE0,
 	.async_fifo = true,
 	.data_tune = true,
+	.busy_check = true,
 };
 
 static const struct of_device_id msdc_of_ids[] = {
@@ -1275,6 +1280,8 @@ static void msdc_init_hw(struct msdc_host *host)
 	sdr_set_field(host->base + MSDC_PATCH_BIT, MSDC_CKGEN_MSDC_DLY_SEL, 1);
 	writel(0xffff4089, host->base + MSDC_PATCH_BIT1);
 	sdr_set_bits(host->base + EMMC50_CFG0, EMMC50_CFG_CFCSTS_SEL);
+	if (host->dev_comp->busy_check)
+		sdr_clr_bits(host->base + MSDC_PATCH_BIT1, (1 << 7));
 	if (host->dev_comp->async_fifo) {
 		sdr_set_field(host->base + MSDC_PATCH_BIT2,
 			      MSDC_PB2_RESPWAIT, 3);
-- 
1.8.1.1.dirty
