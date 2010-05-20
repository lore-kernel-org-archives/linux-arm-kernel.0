From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 20 May 2010 19:28:31 +0900
Subject: [PATCH v2 3/3] [WATCHDOG] s3c2410_wdt - Fix on handling of the
	request_mem_region fail
In-Reply-To: <1274351311-6879-1-git-send-email-kgene.kim@samsung.com>
References: <1274351311-6879-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1274351311-6879-4-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Banajit Goswami <banajit.g@samsung.com>

If the request for wdt_mem region fails, this patch modifies the driver
such that, it does not try to release the wdt_mem region on exit.

Signed-off-by: Banajit Goswami <banajit.g@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
Acked-by: Ben Dooks <ben-linux@fluff.org>
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
+		return -EBUSY;
 	}
 
 	wdt_base = ioremap(res->start, size);
-- 
1.6.2.5
