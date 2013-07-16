From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Tue, 16 Jul 2013 17:16:22 +0200
Subject: [PATCH v3 5/7] spi: atmel: prepare clk before calling enable
In-Reply-To: <1373986995-23899-1-git-send-email-b.brezillon@overkiz.com>
References: <1373986995-23899-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <1373987782-24463-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace clk_enable/disable with clk_prepare_enable/disable_unprepare to
avoid common clk framework warnings.

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 drivers/spi/spi-atmel.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index ea1ec00..4c6c455 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1579,7 +1579,9 @@ static int atmel_spi_probe(struct platform_device *pdev)
 		goto out_unmap_regs;
 
 	/* Initialize the hardware */
-	clk_enable(clk);
+	ret = clk_prepare_enable(clk);
+	if (ret)
+		goto out_unmap_regs;
 	spi_writel(as, CR, SPI_BIT(SWRST));
 	spi_writel(as, CR, SPI_BIT(SWRST)); /* AT91SAM9263 Rev B workaround */
 	if (as->caps.has_wdrbt) {
@@ -1609,7 +1611,7 @@ out_free_dma:
 
 	spi_writel(as, CR, SPI_BIT(SWRST));
 	spi_writel(as, CR, SPI_BIT(SWRST)); /* AT91SAM9263 Rev B workaround */
-	clk_disable(clk);
+	clk_disable_unprepare(clk);
 	free_irq(irq, master);
 out_unmap_regs:
 	iounmap(as->regs);
@@ -1661,7 +1663,7 @@ static int atmel_spi_remove(struct platform_device *pdev)
 	dma_free_coherent(&pdev->dev, BUFFER_SIZE, as->buffer,
 			as->buffer_dma);
 
-	clk_disable(as->clk);
+	clk_disable_unprepare(as->clk);
 	clk_put(as->clk);
 	free_irq(as->irq, master);
 	iounmap(as->regs);
@@ -1678,7 +1680,7 @@ static int atmel_spi_suspend(struct platform_device *pdev, pm_message_t mesg)
 	struct spi_master	*master = platform_get_drvdata(pdev);
 	struct atmel_spi	*as = spi_master_get_devdata(master);
 
-	clk_disable(as->clk);
+	clk_disable_unprepare(as->clk);
 	return 0;
 }
 
@@ -1687,7 +1689,7 @@ static int atmel_spi_resume(struct platform_device *pdev)
 	struct spi_master	*master = platform_get_drvdata(pdev);
 	struct atmel_spi	*as = spi_master_get_devdata(master);
 
-	clk_enable(as->clk);
+	return clk_prepare_enable(as->clk);
 	return 0;
 }
 
-- 
1.7.9.5
