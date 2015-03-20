From: dianders@chromium.org (Doug Anderson)
Date: Fri, 20 Mar 2015 11:00:20 -0700
Subject: [PATCH] mmc: dw_mmc: Don't send clock off command if power is off
Message-ID: <1426874420-25103-1-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We've already seen that it causes failures if we try to send the
"SDMMC_CMD_UPD_CLK" command when power is off to the system.  Here's
another case where we were doing it: we were sending an
SDMMC_CMD_UPD_CLK to set the clock to 0 when the card was already
powered off and the clock was already at 0.  Let's avoid that command
and avoid problems.

Signed-off-by: Doug Anderson <dianders@chromium.org>
---
 drivers/mmc/host/dw_mmc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 47dfd0e..aeec698 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1172,8 +1172,9 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 		break;
 	case MMC_POWER_OFF:
-		/* Turn clock off before power goes down */
-		dw_mci_setup_bus(slot, false);
+		/* Turn clock off before power goes down; only if powered */
+		if (slot->host->vqmmc_enabled)
+			dw_mci_setup_bus(slot, false);
 
 		if (!IS_ERR(mmc->supply.vmmc))
 			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
-- 
2.2.0.rc0.207.ga3a616c
