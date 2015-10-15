From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Thu, 15 Oct 2015 10:09:11 +0000
Subject: [PATCH] spi: bcm2835: change initialization order and switch to
 platform_get_irq
Message-ID: <1444903752-9180-1-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Change the initialization order of the HW so that the interrupt
is only requested after the HW is initialized

Also the use of irq_of_parse_and_map is replaced by platform_get_irq.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/spi/spi-bcm2835.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 3e8eeb2..cf04960 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -777,7 +777,7 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 		goto out_master_put;
 	}
 
-	bs->irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
+	bs->irq = platform_get_irq(pdev, 0);
 	if (bs->irq <= 0) {
 		dev_err(&pdev->dev, "could not get IRQ: %d\n", bs->irq);
 		err = bs->irq ? bs->irq : -ENODEV;
@@ -786,6 +786,12 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 
 	clk_prepare_enable(bs->clk);
 
+	bcm2835_dma_init(master, &pdev->dev);
+
+	/* initialise the hardware with the default polarities */
+	bcm2835_wr(bs, BCM2835_SPI_CS,
+		   BCM2835_SPI_CS_CLEAR_RX | BCM2835_SPI_CS_CLEAR_TX);
+
 	err = devm_request_irq(&pdev->dev, bs->irq, bcm2835_spi_interrupt, 0,
 			       dev_name(&pdev->dev), master);
 	if (err) {
@@ -793,12 +799,6 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 		goto out_clk_disable;
 	}
 
-	bcm2835_dma_init(master, &pdev->dev);
-
-	/* initialise the hardware with the default polarities */
-	bcm2835_wr(bs, BCM2835_SPI_CS,
-		   BCM2835_SPI_CS_CLEAR_RX | BCM2835_SPI_CS_CLEAR_TX);
-
 	err = devm_spi_register_master(&pdev->dev, master);
 	if (err) {
 		dev_err(&pdev->dev, "could not register SPI master: %d\n", err);
-- 
1.7.10.4
