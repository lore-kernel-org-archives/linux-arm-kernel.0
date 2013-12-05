From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu,  5 Dec 2013 14:34:46 +0100
Subject: [PATCH 1/6] mmc: Do not call get_cd for non removable cards
In-Reply-To: <1386250491-4708-1-git-send-email-s.hauer@pengutronix.de>
References: <1386250491-4708-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1386250491-4708-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Non removable cards are always present, so do not call get_cd for them.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/mmc/core/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 57a2b40..098374b 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2460,7 +2460,8 @@ void mmc_rescan(struct work_struct *work)
 	 */
 	mmc_bus_put(host);
 
-	if (host->ops->get_cd && host->ops->get_cd(host) == 0) {
+	if (!(host->caps & MMC_CAP_NONREMOVABLE) && host->ops->get_cd &&
+			host->ops->get_cd(host) == 0) {
 		mmc_claim_host(host);
 		mmc_power_off(host);
 		mmc_release_host(host);
-- 
1.8.4.3
