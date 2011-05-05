From: adrian.hunter@nokia.com (Adrian Hunter)
Date: Thu,  5 May 2011 14:51:07 +0300
Subject: [PATCH 07/22] mmc: omap_hsmmc: fix missing mmc_release_host() in
	no_off case
In-Reply-To: <1304596282-4095-1-git-send-email-adrian.hunter@nokia.com>
References: <1304596282-4095-1-git-send-email-adrian.hunter@nokia.com>
Message-ID: <1304596282-4095-8-git-send-email-adrian.hunter@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sudhir Bera <ext-sudhir.bera@nokia.com>

In fact the no_off check here will not be hit because
'omap_hsmmc_disabled_to_sleep()' won't schedule a
deeper disable in the no_off case.

Signed-off-by: Sudhir Bera <ext-sudhir.bera@nokia.com>
Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 drivers/mmc/host/omap_hsmmc.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index bab25ff..bd52849 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1852,14 +1852,13 @@ static int omap_hsmmc_sleep_to_off(struct omap_hsmmc_host *host)
 		return 0;
 
 	if (mmc_slot(host).no_off)
-		return 0;
+		goto out;
 
 	if (!((host->mmc->caps & MMC_CAP_NONREMOVABLE) ||
 	      mmc_slot(host).card_detect ||
 	      (mmc_slot(host).get_cover_state &&
 	       mmc_slot(host).get_cover_state(host->dev, host->slot_id)))) {
-		mmc_release_host(host->mmc);
-		return 0;
+		goto out;
 	}
 
 	mmc_slot(host).set_power(host->dev, host->slot_id, 0, 0);
@@ -1870,7 +1869,7 @@ static int omap_hsmmc_sleep_to_off(struct omap_hsmmc_host *host)
 		host->dpm_state == CARDSLEEP ? "CARDSLEEP" : "REGSLEEP");
 
 	host->dpm_state = OFF;
-
+out:
 	mmc_release_host(host->mmc);
 
 	return 0;
-- 
1.7.0.4
