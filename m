From: chaotian.jing@mediatek.com (Chaotian Jing)
Date: Mon, 9 Oct 2017 19:35:21 +0800
Subject: [PATCH v2 08/13] mmc: mediatek: add busy_check support
In-Reply-To: <1507548926-9555-1-git-send-email-chaotian.jing@mediatek.com>
References: <1507548926-9555-1-git-send-email-chaotian.jing@mediatek.com>
Message-ID: <1507548926-9555-9-git-send-email-chaotian.jing@mediatek.com>
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
index e7462fe..555824d 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -315,6 +315,7 @@ struct mtk_mmc_compatible {
 	bool pad_tune0;
 	bool async_fifo;
 	bool data_tune;
+	bool busy_check;
 };
 
 struct msdc_tune_para {
@@ -379,6 +380,7 @@ struct msdc_host {
 	.pad_tune0 = false,
 	.async_fifo = false,
 	.data_tune = false,
+	.busy_check = false,
 };
 
 static const struct mtk_mmc_compatible mt8173_compat = {
@@ -386,6 +388,7 @@ struct msdc_host {
 	.pad_tune0 = false,
 	.async_fifo = false,
 	.data_tune = false,
+	.busy_check = false,
 };
 
 static const struct mtk_mmc_compatible mt2701_compat = {
@@ -393,6 +396,7 @@ struct msdc_host {
 	.pad_tune0 = true,
 	.async_fifo = true,
 	.data_tune = true,
+	.busy_check = false,
 };
 
 static const struct mtk_mmc_compatible mt2712_compat = {
@@ -400,6 +404,7 @@ struct msdc_host {
 	.pad_tune0 = true,
 	.async_fifo = true,
 	.data_tune = true,
+	.busy_check = true,
 };
 
 static const struct of_device_id msdc_of_ids[] = {
@@ -1276,6 +1281,8 @@ static void msdc_init_hw(struct msdc_host *host)
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
