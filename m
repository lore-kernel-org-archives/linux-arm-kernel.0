From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Thu, 21 Apr 2016 00:51:30 +0800
Subject: [PATCH 1/3] mmc: core: fix using wrong io voltage if mmc_select_hs200
 fails
Message-ID: <1461171092-30631-1-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently MMC core will keep going if HS200/HS timing switch failed
with -EBADMSG error by the assumption that the old timing is still valid.

However, for mmc_select_hs200 case, the signal voltage may have already
been switched. If the timing switch failed, we should fall back to
the old voltage in case the card is continue run with legacy timing.

If fall back signal voltage failed, we explicitly report an EIO error
to force retry during the next power cycle.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/mmc/core/mmc.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index b8aa12c..f6683a9 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1245,9 +1245,11 @@ static int mmc_select_hs200(struct mmc_card *card)
 	struct mmc_host *host = card->host;
 	bool send_status = true;
 	unsigned int old_timing;
+	unsigned int old_signal_voltage;
 	int err = -EINVAL;
 	u8 val;
 
+	old_signal_voltage = host->ios.signal_voltage;
 	if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS200_1_2V)
 		err = __mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_120);
 
@@ -1256,7 +1258,7 @@ static int mmc_select_hs200(struct mmc_card *card)
 
 	/* If fails try again during next card power cycle */
 	if (err)
-		goto err;
+		return err;
 
 	mmc_select_driver_type(card);
 
@@ -1290,9 +1292,14 @@ static int mmc_select_hs200(struct mmc_card *card)
 		}
 	}
 err:
-	if (err)
+	if (err) {
+		/* fall back to the old signal voltage, if fails report error */
+		if (__mmc_set_signal_voltage(host, old_signal_voltage))
+			err = -EIO;
+
 		pr_err("%s: %s failed, error %d\n", mmc_hostname(card->host),
 		       __func__, err);
+	}
 	return err;
 }
 
-- 
1.9.1
