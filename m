From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Tue, 29 Nov 2011 16:03:25 +0100
Subject: [PATCH V2] mmc: mmci: Do not release spinlock in request_end
Message-ID: <1322579005-19074-1-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch "mmc: core: move ->request() call from atomic context",
is the reason to why this change is possible. This simplifies the
error handling code execution path quite a lot and potentially also
fixes some error handling hang problems.

Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---

Changes in v2:
	- Rebased against 3.2-rc3, which also has the patch this patch
	depends on.

---
 drivers/mmc/host/mmci.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 2bc7b6b..409e876 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -166,14 +166,8 @@ mmci_request_end(struct mmci_host *host, struct mmc_request *mrq)
 	host->mrq = NULL;
 	host->cmd = NULL;
 
-	/*
-	 * Need to drop the host lock here; mmc_request_done may call
-	 * back into the driver...
-	 */
-	spin_unlock(&host->lock);
 	pm_runtime_put(mmc_dev(host->mmc));
 	mmc_request_done(host->mmc, mrq);
-	spin_lock(&host->lock);
 }
 
 static void mmci_set_mask1(struct mmci_host *host, unsigned int mask)
-- 
1.7.5.4
