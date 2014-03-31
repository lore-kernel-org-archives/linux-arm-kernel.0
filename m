From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Mon, 31 Mar 2014 19:52:44 +0200
Subject: [PATCH] pata_samsung_cf: fix ata_host_activate() failure handling
Message-ID: <6050762.sdUI3gZZlK@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing clk_disable() call to ata_host_activate() failure path.

Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/pata_samsung_cf.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

Index: b/drivers/ata/pata_samsung_cf.c
===================================================================
--- a/drivers/ata/pata_samsung_cf.c	2014-03-14 16:45:04.344724378 +0100
+++ b/drivers/ata/pata_samsung_cf.c	2014-03-31 18:31:58.083631437 +0200
@@ -594,9 +594,13 @@ static int __init pata_s3c_probe(struct
 
 	platform_set_drvdata(pdev, host);
 
-	return ata_host_activate(host, info->irq,
-			info->irq ? pata_s3c_irq : NULL,
-			0, &pata_s3c_sht);
+	ret = ata_host_activate(host, info->irq,
+				info->irq ? pata_s3c_irq : NULL,
+				0, &pata_s3c_sht);
+	if (ret)
+		goto stop_clk;
+
+	return 0;
 
 stop_clk:
 	clk_disable(info->clk);
