From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 11 Nov 2018 21:23:57 +0100
Subject: [PATCH V2 5/7] mmc: bcm2835: Terminate timeout work synchronously
In-Reply-To: <1541967839-2847-1-git-send-email-stefan.wahren@i2se.com>
References: <1541967839-2847-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1541967839-2847-6-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's better to make sure that the timeout work is really terminated
before calling mmc_request_done.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/mmc/host/bcm2835.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index 1c60798..2c7589f 100644
--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -608,7 +608,7 @@ static void bcm2835_finish_request(struct bcm2835_host *host)
 	struct dma_chan *terminate_chan = NULL;
 	struct mmc_request *mrq;
 
-	cancel_delayed_work(&host->timeout_work);
+	cancel_delayed_work_sync(&host->timeout_work);
 
 	mrq = host->mrq;
 
-- 
2.7.4
