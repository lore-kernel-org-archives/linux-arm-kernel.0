From: richard.genoud@gmail.com (Richard Genoud)
Date: Tue, 14 Aug 2012 15:49:29 +0200
Subject: [PATCH 15/23] spi-atmel: add DMA OF support
In-Reply-To: <1344952177-18385-1-git-send-email-richard.genoud@gmail.com>
References: <1344952177-18385-1-git-send-email-richard.genoud@gmail.com>
Message-ID: <1344952177-18385-16-git-send-email-richard.genoud@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
---
 drivers/of/of_atmel.c   |    1 -
 drivers/spi/spi-atmel.c |   22 ++++++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletions(-)

diff --git a/drivers/of/of_atmel.c b/drivers/of/of_atmel.c
index bcd3c54a..a59b9ced 100644
--- a/drivers/of/of_atmel.c
+++ b/drivers/of/of_atmel.c
@@ -55,7 +55,6 @@ struct at_dma_slave *of_create_at_dma_slave(struct device_node *np,
 	atslave->cfg |= of_property_read_bool(np, "atc_sod") ? ATC_SOD : 0;
 	atslave->cfg |= of_property_read_bool(np, "atc_lock_if") ? ATC_LOCK_IF : 0;
 	atslave->cfg |= of_property_read_bool(np, "atc_lock_b") ? ATC_LOCK_B : 0;
-	atslave->cfg |= of_property_read_bool(np, "atc_lock_if_l") ? ATC_LOCK_IF_L : 0;
 	atslave->cfg |= of_property_read_bool(np, "atc_lock_if_l_buffer") ? ATC_LOCK_IF_L_BUFFER : 0;
 	if (of_property_read_bool(np, "atc_fifocfg_halffifo"))
 		atslave->cfg = (atslave->cfg & ~ATC_FIFOCFG_MASK) | ATC_FIFOCFG_HALFFIFO;
diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 28a00ab..d629422 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -21,6 +21,7 @@
 #include <linux/spi/spi.h>
 #include <linux/slab.h>
 #include <linux/of.h>
+#include <linux/of_atmel.h>
 
 #include <asm/io.h>
 #include <mach/board.h>
@@ -1411,6 +1412,8 @@ static int __devinit atmel_spi_probe(struct platform_device *pdev)
 	int			ret;
 	struct spi_master	*master;
 	struct atmel_spi	*as;
+	struct bus_type		*bus = pdev->dev.bus;
+	struct device_node	*of = pdev->dev.of_node;
 
 	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!regs)
@@ -1430,6 +1433,17 @@ static int __devinit atmel_spi_probe(struct platform_device *pdev)
 	if (!master)
 		goto out_free;
 
+
+	/* populate platform_data from device tree */
+	if (of) {
+		pdev->dev.platform_data = of_create_at_dma_slave(of, bus);
+		if (!pdev->dev.platform_data) {
+			dev_err(&pdev->dev, "could not get DMA\n");
+			ret = -EINVAL;
+			goto out_free;
+		}
+	}
+
 	/* the spi->mode bits understood by this driver: */
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
 
@@ -1504,6 +1518,10 @@ out_free_buffer:
 	dma_free_coherent(&pdev->dev, BUFFER_SIZE, as->buffer,
 			as->buffer_dma);
 out_free:
+	if (of) {
+		kfree((struct at_dma_slave*)(pdev->dev.platform_data));
+		pdev->dev.platform_data = NULL;
+	}
 	clk_put(clk);
 	spi_master_put(master);
 	return ret;
@@ -1546,6 +1564,10 @@ static int __devexit atmel_spi_remove(struct platform_device *pdev)
 	iounmap(as->regs);
 
 	spi_unregister_master(master);
+	if (pdev->dev.of_node) {
+		kfree((struct at_dma_slave*)(pdev->dev.platform_data));
+		pdev->dev.platform_data = NULL;
+	}
 
 	return 0;
 }
-- 
1.7.2.5
