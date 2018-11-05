From: bugalski.piotr@gmail.com (Piotr Bugalski)
Date: Mon,  5 Nov 2018 11:36:22 +0100
Subject: [PATCH v3 3/6] mtd: spi-nor: atmel-quadspi: Use spi-mem interface for
 atmel-quadspi driver
In-Reply-To: <20181105103625.9644-1-bugalski.piotr@gmail.com>
References: <20181105103625.9644-1-bugalski.piotr@gmail.com>
Message-ID: <20181105103625.9644-4-bugalski.piotr@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Previously added spi-mem interface is now used instead of older approach.

Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Piotr Bugalski <bugalski.piotr@gmail.com>
---
 drivers/mtd/spi-nor/atmel-quadspi.c | 91 ++++++++-----------------------------
 1 file changed, 18 insertions(+), 73 deletions(-)

diff --git a/drivers/mtd/spi-nor/atmel-quadspi.c b/drivers/mtd/spi-nor/atmel-quadspi.c
index 896478a290ec..644e3f0c1558 100644
--- a/drivers/mtd/spi-nor/atmel-quadspi.c
+++ b/drivers/mtd/spi-nor/atmel-quadspi.c
@@ -766,27 +766,9 @@ static ssize_t atmel_qspi_read(struct spi_nor *nor, loff_t from, size_t len,
 
 static int atmel_qspi_init(struct atmel_qspi *aq)
 {
-	unsigned long src_rate;
-	u32 mr, scr, scbr;
-
 	/* Reset the QSPI controller */
 	qspi_writel(aq, QSPI_CR, QSPI_CR_SWRST);
 
-	/* Set the QSPI controller in Serial Memory Mode */
-	mr = QSPI_MR_NBBITS(8) | QSPI_MR_SMM;
-	qspi_writel(aq, QSPI_MR, mr);
-
-	src_rate = clk_get_rate(aq->clk);
-	if (!src_rate)
-		return -EINVAL;
-
-	/* Compute the QSPI baudrate */
-	scbr = DIV_ROUND_UP(src_rate, aq->clk_rate);
-	if (scbr > 0)
-		scbr--;
-	scr = QSPI_SCR_SCBR(scbr);
-	qspi_writel(aq, QSPI_SCR, scr);
-
 	/* Enable the QSPI controller */
 	qspi_writel(aq, QSPI_CR, QSPI_CR_QSPIEN);
 
@@ -814,38 +796,25 @@ static irqreturn_t atmel_qspi_interrupt(int irq, void *dev_id)
 
 static int atmel_qspi_probe(struct platform_device *pdev)
 {
-	const struct spi_nor_hwcaps hwcaps = {
-		.mask = SNOR_HWCAPS_READ |
-			SNOR_HWCAPS_READ_FAST |
-			SNOR_HWCAPS_READ_1_1_2 |
-			SNOR_HWCAPS_READ_1_2_2 |
-			SNOR_HWCAPS_READ_2_2_2 |
-			SNOR_HWCAPS_READ_1_1_4 |
-			SNOR_HWCAPS_READ_1_4_4 |
-			SNOR_HWCAPS_READ_4_4_4 |
-			SNOR_HWCAPS_PP |
-			SNOR_HWCAPS_PP_1_1_4 |
-			SNOR_HWCAPS_PP_1_4_4 |
-			SNOR_HWCAPS_PP_4_4_4,
-	};
-	struct device_node *child, *np = pdev->dev.of_node;
+	struct spi_controller *ctrl;
 	struct atmel_qspi *aq;
 	struct resource *res;
-	struct spi_nor *nor;
-	struct mtd_info *mtd;
 	int irq, err = 0;
 
-	if (of_get_child_count(np) != 1)
-		return -ENODEV;
-	child = of_get_next_child(np, NULL);
+	ctrl = spi_alloc_master(&pdev->dev, sizeof(*aq));
+	if (!ctrl)
+		return -ENOMEM;
 
-	aq = devm_kzalloc(&pdev->dev, sizeof(*aq), GFP_KERNEL);
-	if (!aq) {
-		err = -ENOMEM;
-		goto exit;
-	}
+	ctrl->mode_bits = SPI_RX_DUAL | SPI_RX_QUAD | SPI_TX_DUAL | SPI_TX_QUAD;
+	ctrl->setup = atmel_qspi_setup;
+	ctrl->bus_num = -1;
+	ctrl->mem_ops = &atmel_qspi_mem_ops;
+	ctrl->num_chipselect = 1;
+	ctrl->dev.of_node = pdev->dev.of_node;
+	platform_set_drvdata(pdev, ctrl);
+
+	aq = spi_controller_get_devdata(ctrl);
 
-	platform_set_drvdata(pdev, aq);
 	init_completion(&aq->cmd_completion);
 	aq->pdev = pdev;
 
@@ -894,54 +863,30 @@ static int atmel_qspi_probe(struct platform_device *pdev)
 	if (err)
 		goto disable_clk;
 
-	/* Setup the spi-nor */
-	nor = &aq->nor;
-	mtd = &nor->mtd;
-
-	nor->dev = &pdev->dev;
-	spi_nor_set_flash_node(nor, child);
-	nor->priv = aq;
-	mtd->priv = nor;
-
-	nor->read_reg = atmel_qspi_read_reg;
-	nor->write_reg = atmel_qspi_write_reg;
-	nor->read = atmel_qspi_read;
-	nor->write = atmel_qspi_write;
-	nor->erase = atmel_qspi_erase;
-
-	err = of_property_read_u32(child, "spi-max-frequency", &aq->clk_rate);
-	if (err < 0)
-		goto disable_clk;
-
 	err = atmel_qspi_init(aq);
 	if (err)
 		goto disable_clk;
 
-	err = spi_nor_scan(nor, NULL, &hwcaps);
-	if (err)
-		goto disable_clk;
-
-	err = mtd_device_register(mtd, NULL, 0);
+	err = spi_register_controller(ctrl);
 	if (err)
 		goto disable_clk;
 
-	of_node_put(child);
-
 	return 0;
 
 disable_clk:
 	clk_disable_unprepare(aq->clk);
 exit:
-	of_node_put(child);
+	spi_controller_put(ctrl);
 
 	return err;
 }
 
 static int atmel_qspi_remove(struct platform_device *pdev)
 {
-	struct atmel_qspi *aq = platform_get_drvdata(pdev);
+	struct spi_controller *ctrl = platform_get_drvdata(pdev);
+	struct atmel_qspi *aq = spi_controller_get_devdata(ctrl);
 
-	mtd_device_unregister(&aq->nor.mtd);
+	spi_unregister_controller(ctrl);
 	qspi_writel(aq, QSPI_CR, QSPI_CR_QSPIDIS);
 	clk_disable_unprepare(aq->clk);
 	return 0;
-- 
2.11.0
