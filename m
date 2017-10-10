From: chaotian.jing@mediatek.com (Chaotian Jing)
Date: Tue, 10 Oct 2017 17:30:29 +0800
Subject: [PATCH v4 10/12] mmc: mediatek: add latch-ck support
In-Reply-To: <1507627831-29323-1-git-send-email-chaotian.jing@mediatek.com>
References: <1507627831-29323-1-git-send-email-chaotian.jing@mediatek.com>
Message-ID: <1507627831-29323-11-git-send-email-chaotian.jing@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

some platform(eg.mt2701) does not support "stop clk fix", in
this case, need set correct latch-ck to avoid crc error caused
by stop clock block-internally.

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index d3833f3..3a1756a 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -378,6 +378,7 @@ struct msdc_host {
 	u32 sclk;		/* SD/MS bus clock frequency */
 	unsigned char timing;
 	bool vqmmc_enabled;
+	u32 latch_ck;
 	u32 hs400_ds_delay;
 	u32 hs200_cmd_int_delay; /* cmd internal delay for HS200/SDR104 */
 	u32 hs400_cmd_int_delay; /* cmd internal delay for HS400 */
@@ -1672,6 +1673,8 @@ static int msdc_tune_data(struct mmc_host *mmc, u32 opcode)
 	if (host->dev_comp->pad_tune0)
 		tune_reg = MSDC_PAD_TUNE0;
 
+	sdr_set_field(host->base + MSDC_PATCH_BIT, MSDC_INT_DAT_LATCH_CK_SEL,
+		      host->latch_ck);
 	sdr_clr_bits(host->base + MSDC_IOCON, MSDC_IOCON_DSPL);
 	sdr_clr_bits(host->base + MSDC_IOCON, MSDC_IOCON_W_DSPL);
 	for (i = 0 ; i < PAD_DELAY_MAX; i++) {
@@ -1787,6 +1790,9 @@ static void msdc_hw_reset(struct mmc_host *mmc)
 static void msdc_of_property_parse(struct platform_device *pdev,
 				   struct msdc_host *host)
 {
+	of_property_read_u32(pdev->dev.of_node, "mediatek,latch-ck",
+			     &host->latch_ck);
+
 	of_property_read_u32(pdev->dev.of_node, "hs400-ds-delay",
 			     &host->hs400_ds_delay);
 
-- 
1.8.1.1.dirty
