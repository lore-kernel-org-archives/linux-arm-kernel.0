From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 23 Aug 2011 11:16:39 +0100
Subject: [PATCH 2/2] PM: add runtime PM support to MMCI
In-Reply-To: <20110823101555.GE19622@n2100.arm.linux.org.uk>
References: <20110823101555.GE19622@n2100.arm.linux.org.uk>
Message-ID: <E1Qvo2B-0000qz-3A@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add runtime PM support to the MMCI primecell driver, making use of
the core primecell bus runtime PM support.

Tested-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/mmci.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 56e9a41..5e142b7 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -29,6 +29,7 @@
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
 #include <linux/amba/mmci.h>
+#include <linux/pm_runtime.h>
 
 #include <asm/div64.h>
 #include <asm/io.h>
@@ -170,6 +171,7 @@ mmci_request_end(struct mmci_host *host, struct mmc_request *mrq)
 	 * back into the driver...
 	 */
 	spin_unlock(&host->lock);
+	pm_runtime_put(mmc_dev(host->mmc));
 	mmc_request_done(host->mmc, mrq);
 	spin_lock(&host->lock);
 }
@@ -984,6 +986,8 @@ static void mmci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		return;
 	}
 
+	pm_runtime_get_sync(mmc_dev(mmc));
+
 	spin_lock_irqsave(&host->lock, flags);
 
 	host->mrq = mrq;
@@ -1327,6 +1331,8 @@ static int __devinit mmci_probe(struct amba_device *dev,
 
 	mmci_dma_setup(host);
 
+	pm_runtime_put(&dev->dev);
+
 	mmc_add_host(mmc);
 
 	return 0;
@@ -1364,6 +1370,12 @@ static int __devexit mmci_remove(struct amba_device *dev)
 	if (mmc) {
 		struct mmci_host *host = mmc_priv(mmc);
 
+		/*
+		 * Undo pm_runtime_put() in probe.  We use the _sync
+		 * version here so that we can access the primecell.
+		 */
+		pm_runtime_get_sync(&dev->dev);
+
 		mmc_remove_host(mmc);
 
 		writel(0, host->base + MMCIMASK0);
-- 
1.7.4.4
