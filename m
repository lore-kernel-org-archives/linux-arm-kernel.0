From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 20 May 2010 16:21:29 +0900
Subject: [PATCH 2/5] [WATCHDOG] s3c2410_wdt - Avoid freeing memory,
	if memory region could not be allocated
In-Reply-To: <1274340092-10706-1-git-send-email-kgene.kim@samsung.com>
References: <1274340092-10706-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1274340092-10706-3-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Banajit Goswami <banajit.g@samsung.com>

In case the WDT device memory allocation fails, this patch modifies the
driver such that, it does not try to free the memory on exit.

Signed-off-by: Banajit Goswami <banajit.g@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 drivers/watchdog/s3c2410_wdt.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index e4cebef..d421258 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -426,8 +426,7 @@ static int __devinit s3c2410wdt_probe(struct platform_device *pdev)
 	wdt_mem = request_mem_region(res->start, size, pdev->name);
 	if (wdt_mem == NULL) {
 		dev_err(dev, "failed to get memory region\n");
-		ret = -ENOENT;
-		goto err_req;
+		return -ENOMEM;
 	}
 
 	wdt_base = ioremap(res->start, size);
-- 
1.6.2.5
