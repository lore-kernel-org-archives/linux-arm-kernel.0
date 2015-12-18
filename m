From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 18 Dec 2015 14:15:17 +0100
Subject: [PATCH v2] mtd: omap_elm: print interrupt resource using %pr
Message-ID: <2327550.1yLrRnIh7I@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When CONFIG_LPAE is set on ARM, resource_size_t is 64-bit wide
and we get a warning about an incorrect format string for printing
the interrupt number in elm_probe:

drivers/mtd/nand/omap_elm.c: In function 'elm_probe':
drivers/mtd/nand/omap_elm.c:417:23: warning: format '%i' expects argument of type 'int', but argument 3 has type 'resource_size_t {aka long long unsigned int}' [-Wformat=]

This patch avoids the type mismatch by printing the interrupt as
a resource using the %pr format string.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: pass correct pointer

diff --git a/drivers/mtd/nand/omap_elm.c b/drivers/mtd/nand/omap_elm.c
index 235ec7992b4c..a3f32f939cc1 100644
--- a/drivers/mtd/nand/omap_elm.c
+++ b/drivers/mtd/nand/omap_elm.c
@@ -414,7 +414,7 @@ static int elm_probe(struct platform_device *pdev)
 	ret = devm_request_irq(&pdev->dev, irq->start, elm_isr, 0,
 			pdev->name, info);
 	if (ret) {
-		dev_err(&pdev->dev, "failure requesting irq %i\n", irq->start);
+		dev_err(&pdev->dev, "failure requesting %pr\n", irq);
 		return ret;
 	}
 
