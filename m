From: chaotian.jing@mediatek.com (Chaotian Jing)
Date: Thu, 19 May 2016 16:47:41 +0800
Subject: [PATCH 2/3] mmc: mmc: do not use CMD13 to get status after speed mode
 switch
In-Reply-To: <1463647662-27426-1-git-send-email-chaotian.jing@mediatek.com>
References: <1463647662-27426-1-git-send-email-chaotian.jing@mediatek.com>
Message-ID: <1463647662-27426-3-git-send-email-chaotian.jing@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Per JEDEC spec, it is not recommended to use CMD13 to get card status
after speed mode switch. below are two reason about this:
1. CMD13 cannot be guaranteed due to the asynchronous operation.
Therefore it is not recommended to use CMD13 to check busy completion
of the timing change indication.
2. After switch to HS200, CMD13 will get response of 0x800, and even the
busy signal gets de-asserted, the response of CMD13 is aslo 0x800.

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 drivers/mmc/core/mmc.c | 112 ++++++++++++++++++++-----------------------------
 1 file changed, 45 insertions(+), 67 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 4dbe3df..97403a6 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -952,6 +952,19 @@ static int mmc_select_bus_width(struct mmc_card *card)
 	return err;
 }
 
+/* Caller must hold re-tuning */
+static int mmc_switch_status(struct mmc_card *card)
+{
+	u32 status;
+	int err;
+
+	err = mmc_send_status(card, &status);
+	if (err)
+		return err;
+
+	return mmc_switch_status_error(card->host, status);
+}
+
 /*
  * Switch to the high-speed mode
  */
@@ -962,9 +975,11 @@ static int mmc_select_hs(struct mmc_card *card)
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 			   EXT_CSD_HS_TIMING, EXT_CSD_TIMING_HS,
 			   card->ext_csd.generic_cmd6_time,
-			   true, true, true);
-	if (!err)
+			   true, false, true);
+	if (!err) {
 		mmc_set_timing(card->host, MMC_TIMING_MMC_HS);
+		err = mmc_switch_status(card);
+	}
 
 	return err;
 }
@@ -1040,23 +1055,9 @@ static int mmc_select_hs_ddr(struct mmc_card *card)
 	return err;
 }
 
-/* Caller must hold re-tuning */
-static int mmc_switch_status(struct mmc_card *card)
-{
-	u32 status;
-	int err;
-
-	err = mmc_send_status(card, &status);
-	if (err)
-		return err;
-
-	return mmc_switch_status_error(card->host, status);
-}
-
 static int mmc_select_hs400(struct mmc_card *card)
 {
 	struct mmc_host *host = card->host;
-	bool send_status = true;
 	unsigned int max_dtr;
 	int err = 0;
 	u8 val;
@@ -1068,9 +1069,6 @@ static int mmc_select_hs400(struct mmc_card *card)
 	      host->ios.bus_width == MMC_BUS_WIDTH_8))
 		return 0;
 
-	if (host->caps & MMC_CAP_WAIT_WHILE_BUSY)
-		send_status = false;
-
 	/* Reduce frequency to HS frequency */
 	max_dtr = card->ext_csd.hs_max_dtr;
 	mmc_set_clock(host, max_dtr);
@@ -1080,7 +1078,7 @@ static int mmc_select_hs400(struct mmc_card *card)
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 			   EXT_CSD_HS_TIMING, val,
 			   card->ext_csd.generic_cmd6_time,
-			   true, send_status, true);
+			   true, false, true);
 	if (err) {
 		pr_err("%s: switch to high-speed from hs200 failed, err:%d\n",
 			mmc_hostname(host), err);
@@ -1090,11 +1088,9 @@ static int mmc_select_hs400(struct mmc_card *card)
 	/* Set host controller to HS timing */
 	mmc_set_timing(card->host, MMC_TIMING_MMC_HS);
 
-	if (!send_status) {
-		err = mmc_switch_status(card);
-		if (err)
-			goto out_err;
-	}
+	err = mmc_switch_status(card);
+	if (err)
+		goto out_err;
 
 	/* Switch card to DDR */
 	err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
@@ -1113,7 +1109,7 @@ static int mmc_select_hs400(struct mmc_card *card)
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 			   EXT_CSD_HS_TIMING, val,
 			   card->ext_csd.generic_cmd6_time,
-			   true, send_status, true);
+			   true, false, true);
 	if (err) {
 		pr_err("%s: switch to hs400 failed, err:%d\n",
 			 mmc_hostname(host), err);
@@ -1124,11 +1120,9 @@ static int mmc_select_hs400(struct mmc_card *card)
 	mmc_set_timing(host, MMC_TIMING_MMC_HS400);
 	mmc_set_bus_speed(card);
 
-	if (!send_status) {
-		err = mmc_switch_status(card);
-		if (err)
-			goto out_err;
-	}
+	err = mmc_switch_status(card);
+	if (err)
+		goto out_err;
 
 	return 0;
 
@@ -1146,14 +1140,10 @@ int mmc_hs200_to_hs400(struct mmc_card *card)
 int mmc_hs400_to_hs200(struct mmc_card *card)
 {
 	struct mmc_host *host = card->host;
-	bool send_status = true;
 	unsigned int max_dtr;
 	int err;
 	u8 val;
 
-	if (host->caps & MMC_CAP_WAIT_WHILE_BUSY)
-		send_status = false;
-
 	/* Reduce frequency to HS */
 	max_dtr = card->ext_csd.hs_max_dtr;
 	mmc_set_clock(host, max_dtr);
@@ -1162,49 +1152,43 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
 	val = EXT_CSD_TIMING_HS;
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_HS_TIMING,
 			   val, card->ext_csd.generic_cmd6_time,
-			   true, send_status, true);
+			   true, false, true);
 	if (err)
 		goto out_err;
 
 	mmc_set_timing(host, MMC_TIMING_MMC_DDR52);
 
-	if (!send_status) {
-		err = mmc_switch_status(card);
-		if (err)
-			goto out_err;
-	}
+	err = mmc_switch_status(card);
+	if (err)
+		goto out_err;
 
 	/* Switch HS DDR to HS */
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_BUS_WIDTH,
 			   EXT_CSD_BUS_WIDTH_8, card->ext_csd.generic_cmd6_time,
-			   true, send_status, true);
+			   true, false, true);
 	if (err)
 		goto out_err;
 
 	mmc_set_timing(host, MMC_TIMING_MMC_HS);
 
-	if (!send_status) {
-		err = mmc_switch_status(card);
-		if (err)
-			goto out_err;
-	}
+	err = mmc_switch_status(card);
+	if (err)
+		goto out_err;
 
 	/* Switch HS to HS200 */
 	val = EXT_CSD_TIMING_HS200 |
 	      card->drive_strength << EXT_CSD_DRV_STR_SHIFT;
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_HS_TIMING,
 			   val, card->ext_csd.generic_cmd6_time, true,
-			   send_status, true);
+			   false, true);
 	if (err)
 		goto out_err;
 
 	mmc_set_timing(host, MMC_TIMING_MMC_HS200);
 
-	if (!send_status) {
-		err = mmc_switch_status(card);
-		if (err)
-			goto out_err;
-	}
+	err = mmc_switch_status(card);
+	if (err)
+		goto out_err;
 
 	mmc_set_bus_speed(card);
 
@@ -1243,7 +1227,6 @@ static void mmc_select_driver_type(struct mmc_card *card)
 static int mmc_select_hs200(struct mmc_card *card)
 {
 	struct mmc_host *host = card->host;
-	bool send_status = true;
 	unsigned int old_timing;
 	int err = -EINVAL;
 	u8 val;
@@ -1260,9 +1243,6 @@ static int mmc_select_hs200(struct mmc_card *card)
 
 	mmc_select_driver_type(card);
 
-	if (host->caps & MMC_CAP_WAIT_WHILE_BUSY)
-		send_status = false;
-
 	/*
 	 * Set the bus width(4 or 8) with host's support and
 	 * switch to HS200 mode if bus width is set successfully.
@@ -1274,20 +1254,18 @@ static int mmc_select_hs200(struct mmc_card *card)
 		err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 				   EXT_CSD_HS_TIMING, val,
 				   card->ext_csd.generic_cmd6_time,
-				   true, send_status, true);
+				   true, false, true);
 		if (err)
 			goto err;
 		old_timing = host->ios.timing;
 		mmc_set_timing(host, MMC_TIMING_MMC_HS200);
-		if (!send_status) {
-			err = mmc_switch_status(card);
-			/*
-			 * mmc_select_timing() assumes timing has not changed if
-			 * it is a switch error.
-			 */
-			if (err == -EBADMSG)
-				mmc_set_timing(host, old_timing);
-		}
+		err = mmc_switch_status(card);
+		/*
+		 * mmc_select_timing() assumes timing has not changed if
+		 * it is a switch error.
+		 */
+		if (err == -EBADMSG)
+			mmc_set_timing(host, old_timing);
 	}
 err:
 	if (err)
-- 
1.8.1.1.dirty
