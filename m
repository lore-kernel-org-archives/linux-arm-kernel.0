From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Mon, 31 Mar 2014 19:51:14 +0200
Subject: [PATCH] pata_at91: fix ata_host_activate() failure handling
Message-ID: <3354637.ASvWtLs5Rq@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing clk_put() call to ata_host_activate() failure path.

Cc: Andrew Victor <linux@maxim.org.za>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/pata_at91.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

Index: b/drivers/ata/pata_at91.c
===================================================================
--- a/drivers/ata/pata_at91.c	2014-03-14 16:45:04.196724381 +0100
+++ b/drivers/ata/pata_at91.c	2014-03-31 17:46:40.127677782 +0200
@@ -407,12 +407,13 @@ static int pata_at91_probe(struct platfo
 
 	host->private_data = info;
 
-	return ata_host_activate(host, gpio_is_valid(irq) ? gpio_to_irq(irq) : 0,
-			gpio_is_valid(irq) ? ata_sff_interrupt : NULL,
-			irq_flags, &pata_at91_sht);
+	ret = ata_host_activate(host, gpio_is_valid(irq) ? gpio_to_irq(irq) : 0,
+				gpio_is_valid(irq) ? ata_sff_interrupt : NULL,
+				irq_flags, &pata_at91_sht);
+	if (ret)
+		goto err_put;
 
-	if (!ret)
-		return 0;
+	return 0;
 
 err_put:
 	clk_put(info->mck);
