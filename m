From: chaotian.jing@mediatek.com (Chaotian Jing)
Date: Fri, 29 Jan 2016 03:31:54 +0800
Subject: [PATCH] mmc: mediatek: make sure clock is enabled when executing
 ops->card_busy()
Message-ID: <1454009514-6474-1-git-send-email-chaotian.jing@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add pm_runtime_get_sync() before access MSDC_PS register

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 82a97ac..a56b16d 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -1054,13 +1054,15 @@ static int msdc_ops_switch_volt(struct mmc_host *mmc, struct mmc_ios *ios)
 static int msdc_card_busy(struct mmc_host *mmc)
 {
 	struct msdc_host *host = mmc_priv(mmc);
-	u32 status = readl(host->base + MSDC_PS);
+	u32 status;
 
-	/* check if any pin between dat[0:3] is low */
-	if (((status >> 16) & 0xf) != 0xf)
-		return 1;
+	pm_runtime_get_sync(host->dev);
+	status = readl(host->base + MSDC_PS);
+	pm_runtime_mark_last_busy(host->dev);
+	pm_runtime_put_autosuspend(host->dev);
 
-	return 0;
+	/* check if any pin between dat[0:3] is low */
+	return !!(((status >> 16) & 0xf) != 0xf);
 }
 
 static void msdc_request_timeout(struct work_struct *work)
-- 
1.8.1.1.dirty
