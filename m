From: chaotian.jing@mediatek.com (Chaotian Jing)
Date: Thu, 30 Jun 2016 10:00:58 +0800
Subject: [PATCH 1/4] mmc: mediatek: do not tune data for HS400 mode
In-Reply-To: <1467252061-3791-1-git-send-email-chaotian.jing@mediatek.com>
References: <1467252061-3791-1-git-send-email-chaotian.jing@mediatek.com>
Message-ID: <1467252061-3791-2-git-send-email-chaotian.jing@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

for hs400 mode, should only tune DS delay, should not
tune PAD_TUNE for data path.
if eMMC will run at hs400 mode, do not tune data while
call ops->execute_tuning().

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 5642f71..4d7ce65 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -326,6 +326,7 @@ struct msdc_host {
 	unsigned char timing;
 	bool vqmmc_enabled;
 	u32 hs400_ds_delay;
+	bool hs400_mode;	/* current eMMC will run at hs400 mode */
 	struct msdc_save_para save_para; /* used when gate HCLK */
 };
 
@@ -1402,9 +1403,11 @@ static int msdc_execute_tuning(struct mmc_host *mmc, u32 opcode)
 		dev_err(host->dev, "Tune response fail!\n");
 		return ret;
 	}
-	ret = msdc_tune_data(mmc, opcode);
-	if (ret == -EIO)
-		dev_err(host->dev, "Tune data fail!\n");
+	if (host->hs400_mode == false) {
+		ret = msdc_tune_data(mmc, opcode);
+		if (ret == -EIO)
+			dev_err(host->dev, "Tune data fail!\n");
+	}
 
 	return ret;
 }
@@ -1412,6 +1415,7 @@ static int msdc_execute_tuning(struct mmc_host *mmc, u32 opcode)
 static int msdc_prepare_hs400_tuning(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct msdc_host *host = mmc_priv(mmc);
+	host->hs400_mode = true;
 
 	writel(host->hs400_ds_delay, host->base + PAD_DS_TUNE);
 	return 0;
-- 
1.8.1.1.dirty
