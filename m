From: xtfeng@gmail.com (Xiaotian Feng)
Date: Wed, 31 Oct 2012 18:48:45 +0800
Subject: [PATCH] mmc: s3cmci: use tasklet_kill in device remove/release process
Message-ID: <1351680525-27253-1-git-send-email-xtfeng@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some driver uses tasklet_disable in device remove/release process,
tasklet_disable will inc tasklet->count and return. If the tasklet
is not handled yet under some softirq pressure, the tasklet will be
placed on the tasklet_vec, never have a chance to be excuted. This might
lead to a heavy loaded ksoftirqd, wakeup with pending_softirq, but
tasklet is disabled. tasklet_kill should be used in this case.

Signed-off-by: Xiaotian Feng <dannyfeng@tencent.com>
Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Chris Ball <cjb@laptop.org>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-mmc at vger.kernel.org
---
 drivers/mmc/host/s3cmci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index 4638dda..d70d0cc 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -1830,7 +1830,7 @@ static int __devexit s3cmci_remove(struct platform_device *pdev)
 
 	clk_put(host->clk);
 
-	tasklet_disable(&host->pio_tasklet);
+	tasklet_kill(&host->pio_tasklet);
 
 	if (s3cmci_host_usedma(host))
 		s3c2410_dma_free(host->dma, &s3cmci_dma_client);
-- 
1.7.9.5
