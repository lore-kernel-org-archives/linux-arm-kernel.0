From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Tue, 11 Oct 2011 16:06:41 +0200
Subject: [PATCH] mmc: mmci: Do not release spinlock in request_end
Message-ID: <1318342001-26955-1-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch "mmc: core: move ->request() call from atomic context",
is the reason to why this change is possible. This simplifies the
error handling code execution path quite a lot and potentially also
fixes some error handling hang problems.

Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
---
 drivers/mmc/host/mmci.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 40e4c05..f7755c9 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -165,13 +165,7 @@ mmci_request_end(struct mmci_host *host, struct mmc_request *mrq)
 	host->mrq = NULL;
 	host->cmd = NULL;
 
-	/*
-	 * Need to drop the host lock here; mmc_request_done may call
-	 * back into the driver...
-	 */
-	spin_unlock(&host->lock);
 	mmc_request_done(host->mmc, mrq);
-	spin_lock(&host->lock);
 }
 
 static void mmci_set_mask1(struct mmci_host *host, unsigned int mask)
-- 
1.7.5.4
