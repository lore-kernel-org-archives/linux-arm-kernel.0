From: kraxel@redhat.com (Gerd Hoffmann)
Date: Wed, 22 Jun 2016 13:42:17 +0200
Subject: [PATCH 4/5] mmc: bcm2835-sdhost: reset tweaks. [fixup]
In-Reply-To: <1466595738-2229-1-git-send-email-kraxel@redhat.com>
References: <1466595738-2229-1-git-send-email-kraxel@redhat.com>
Message-ID: <1466595738-2229-5-git-send-email-kraxel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kill any pending stuff before calling reset_internal(), so there
shouldn't be any completion callbacks interfering.  This allows
to call reset_internal without lock, which in turn allows to
turn the mdelay calls into msleep calls.  Also adjust the time
from 10ms to 20ms as checkpatch warns about the 10ms.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/mmc/host/bcm2835-sdhost.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/bcm2835-sdhost.c b/drivers/mmc/host/bcm2835-sdhost.c
index 8a05c02..a895561 100644
--- a/drivers/mmc/host/bcm2835-sdhost.c
+++ b/drivers/mmc/host/bcm2835-sdhost.c
@@ -321,9 +321,9 @@ static void bcm2835_sdhost_reset_internal(struct bcm2835_host *host)
 	temp |= (FIFO_READ_THRESHOLD << SDEDM_READ_THRESHOLD_SHIFT) |
 		(FIFO_WRITE_THRESHOLD << SDEDM_WRITE_THRESHOLD_SHIFT);
 	bcm2835_sdhost_write(host, temp, SDEDM);
-	mdelay(10);
+	msleep(20);
 	bcm2835_sdhost_set_power(host, true);
-	mdelay(10);
+	msleep(20);
 	host->clock = 0;
 	bcm2835_sdhost_write(host, host->hcfg, SDHCFG);
 	bcm2835_sdhost_write(host, host->cdiv, SDCDIV);
@@ -334,9 +334,10 @@ static void bcm2835_sdhost_reset(struct mmc_host *mmc)
 	struct bcm2835_host *host = mmc_priv(mmc);
 	unsigned long flags;
 
-	spin_lock_irqsave(&host->lock, flags);
+	if (host->dma_chan)
+		dmaengine_terminate_sync(host->dma_chan);
+	tasklet_kill(&host->finish_tasklet);
 	bcm2835_sdhost_reset_internal(host);
-	spin_unlock_irqrestore(&host->lock, flags);
 }
 
 static void bcm2835_sdhost_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
-- 
1.8.3.1
