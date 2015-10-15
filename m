From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Thu, 15 Oct 2015 10:10:20 +0000
Subject: [PATCH] spi: bcm2835aux: change initialization order and switch to
 platform_get_irq
Message-ID: <1444903820-9223-1-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Change the initialization order of the HW so that the interrupt
is only requested after the HW is initialized

Also the use of irq_of_parse_and_map is replaced by platform_get_irq.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/spi/spi-bcm2835aux.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
index f92b4a6..1a1b58c 100644
--- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -410,7 +410,7 @@ static int bcm2835aux_spi_probe(struct platform_device *pdev)
 		goto out_master_put;
 	}
 
-	bs->irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
+	bs->irq = platform_get_irq(pdev, 0);
 	if (bs->irq <= 0) {
 		dev_err(&pdev->dev, "could not get IRQ: %d\n", bs->irq);
 		err = bs->irq ? bs->irq : -ENODEV;
@@ -432,6 +432,9 @@ static int bcm2835aux_spi_probe(struct platform_device *pdev)
 		goto out_clk_disable;
 	}
 
+	/* reset SPI-HW block */
+	bcm2835aux_spi_reset_hw(bs);
+
 	err = devm_request_irq(&pdev->dev, bs->irq,
 			       bcm2835aux_spi_interrupt,
 			       IRQF_SHARED,
@@ -441,9 +444,6 @@ static int bcm2835aux_spi_probe(struct platform_device *pdev)
 		goto out_clk_disable;
 	}
 
-	/* reset SPI-HW block */
-	bcm2835aux_spi_reset_hw(bs);
-
 	err = devm_spi_register_master(&pdev->dev, master);
 	if (err) {
 		dev_err(&pdev->dev, "could not register SPI master: %d\n", err);
-- 
1.7.10.4
