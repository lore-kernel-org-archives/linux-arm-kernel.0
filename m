From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 12 Nov 2015 17:44:34 +0100
Subject: [PATCH] spi: bcm63xx: use correct format string for printing a
 resource
Message-ID: <8442314.JjGyK1Sa3M@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With a 64-bit resource_size_t, we get a build warning on bcm63xx_spi_probe:

drivers/spi/spi-bcm63xx.c:565:16: warning: format '%x' expects argument of type 'unsigned int', but argument 3 has type 'resource_size_t {aka long long unsigned int}' [-Wformat=]

As we are printing a resource, we can just use the %pr format
specifier that pretty-prints the address and avoids the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Found on arm multi_v7_defconfig with LPAE

diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index 06858e04ec59..bf9a610e5b89 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -562,8 +562,8 @@ static int bcm63xx_spi_probe(struct platform_device *pdev)
 		goto out_clk_disable;
 	}
 
-	dev_info(dev, "at 0x%08x (irq %d, FIFOs size %d)\n",
-		 r->start, irq, bs->fifo_size);
+	dev_info(dev, "at %pr (irq %d, FIFOs size %d)\n",
+		 r, irq, bs->fifo_size);
 
 	return 0;
 
