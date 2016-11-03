From: jh80.chung@samsung.com (Jaehoon Chung)
Date: Thu, 03 Nov 2016 15:21:24 +0900
Subject: [PATCH 02/13] mmc: dw_mmc: fix the debug message for checking card's
 present
In-Reply-To: <20161103062135.10697-1-jh80.chung@samsung.com>
References: <20161103062135.10697-1-jh80.chung@samsung.com>
Message-ID: <20161103062135.10697-3-jh80.chung@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If display the debug message, this message should be spamming.
If flags is maintained the previous value, didn't display the debug
message.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/host/dw_mmc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index b87dd07..1e71fd4 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1537,13 +1537,10 @@ static int dw_mci_get_cd(struct mmc_host *mmc)
 			== 0 ? 1 : 0;
 
 	spin_lock_bh(&host->lock);
-	if (present) {
-		set_bit(DW_MMC_CARD_PRESENT, &slot->flags);
+	if (present && !test_and_set_bit(DW_MMC_CARD_PRESENT, &slot->flags))
 		dev_dbg(&mmc->class_dev, "card is present\n");
-	} else {
-		clear_bit(DW_MMC_CARD_PRESENT, &slot->flags);
+	else if (!test_and_clear_bit(DW_MMC_CARD_PRESENT, &slot->flags))
 		dev_dbg(&mmc->class_dev, "card is not present\n");
-	}
 	spin_unlock_bh(&host->lock);
 
 	return present;
-- 
2.10.1
