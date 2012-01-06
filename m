From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri,  6 Jan 2012 14:03:08 +0900
Subject: [PATCH 1/2] mmc: core: Separate the timeout value for cache-ctrl
Message-ID: <1325826189-29953-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Seungwon Jeon <tgih.jun@samsung.com>

Turning the cache off implies flushing cache which doesn't define
maximum timeout unlike cache-on. This patch will apply the generic
CMD6 timeout only for cache-on. Additionally the kernel message is
added for checking failure case of cache-on.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
Signed-off-by: Chris Ball <cjb@laptop.org>
---
 drivers/mmc/core/core.c |   21 ++++++++++++---------
 drivers/mmc/core/mmc.c  |   13 +++++++++++--
 2 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index cb74f28..91bb100 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2426,6 +2426,7 @@ EXPORT_SYMBOL(mmc_flush_cache);
 int mmc_cache_ctrl(struct mmc_host *host, u8 enable)
 {
 	struct mmc_card *card = host->card;
+	unsigned int timeout;
 	int err = 0;
 
 	if (!(host->caps2 & MMC_CAP2_CACHE_CTRL) ||
@@ -2436,16 +2437,18 @@ int mmc_cache_ctrl(struct mmc_host *host, u8 enable)
 			(card->ext_csd.cache_size > 0)) {
 		enable = !!enable;
 
-		if (card->ext_csd.cache_ctrl ^ enable)
+		if (card->ext_csd.cache_ctrl ^ enable) {
+			timeout = enable ? card->ext_csd.generic_cmd6_time : 0;
 			err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
-					EXT_CSD_CACHE_CTRL, enable, 0);
-		if (err)
-			pr_err("%s: cache %s error %d\n",
-					mmc_hostname(card->host),
-					enable ? "on" : "off",
-					err);
-		else
-			card->ext_csd.cache_ctrl = enable;
+					EXT_CSD_CACHE_CTRL, enable, timeout);
+			if (err)
+				pr_err("%s: cache %s error %d\n",
+						mmc_hostname(card->host),
+						enable ? "on" : "off",
+						err);
+			else
+				card->ext_csd.cache_ctrl = enable;
+		}
 	}
 
 	return err;
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 94456b1..04a160f 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1085,14 +1085,23 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	if ((host->caps2 & MMC_CAP2_CACHE_CTRL) &&
 			card->ext_csd.cache_size > 0) {
 		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
-				EXT_CSD_CACHE_CTRL, 1, 0);
+				EXT_CSD_CACHE_CTRL, 1,
+				card->ext_csd.generic_cmd6_time);
 		if (err && err != -EBADMSG)
 			goto free_card;
 
 		/*
 		 * Only if no error, cache is turned on successfully.
 		 */
-		card->ext_csd.cache_ctrl = err ? 0 : 1;
+		if (err) {
+			pr_warning("%s: Cache is supported, "
+					"but failed to turn on (%d)\n",
+					mmc_hostname(card->host), err);
+			card->ext_csd.cache_ctrl = 0;
+			err = 0;
+		} else {
+			card->ext_csd.cache_ctrl = 1;
+		}
 	}
 
 	if (!oldcard)
-- 
1.7.1
