From: cory.tusar@pid1solutions.com (Cory Tusar)
Date: Wed,  8 Jul 2015 16:21:18 -0400
Subject: [PATCH v1 4/7] mtd: fsl-quadspi: Use per-device clk_rate.
In-Reply-To: <1436386881-28088-1-git-send-email-cory.tusar@pid1solutions.com>
References: <1436386881-28088-1-git-send-email-cory.tusar@pid1solutions.com>
Message-ID: <1436386881-28088-5-git-send-email-cory.tusar@pid1solutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current fsl-quadspi implementation re-parses the 'spi-max-frequency'
property for each device, potentially allowing for an earlier, lower
frequency to be overwritten with a greater value.  This commit modifies
the parsing logic to extract the clock frequency for each flash device
and then configures for that frequency as part of the prepare() method
prior to accessing a given device.

Signed-off-by: Cory Tusar <cory.tusar@pid1solutions.com>
---
 drivers/mtd/spi-nor/fsl-quadspi.c | 41 +++++++++++++++------------------------
 1 file changed, 16 insertions(+), 25 deletions(-)

diff --git a/drivers/mtd/spi-nor/fsl-quadspi.c b/drivers/mtd/spi-nor/fsl-quadspi.c
index 4b8038b..d0cf0b7 100644
--- a/drivers/mtd/spi-nor/fsl-quadspi.c
+++ b/drivers/mtd/spi-nor/fsl-quadspi.c
@@ -233,7 +233,7 @@ struct fsl_qspi {
 	struct fsl_qspi_devtype_data *devtype_data;
 	u32 nor_size;
 	u32 nor_num;
-	u32 clk_rate;
+	u32 clk_rate[FSL_QSPI_MAX_CHIP];
 	unsigned int chip_base_addr; /* We may support two chips. */
 	bool has_second_chip;
 };
@@ -645,25 +645,13 @@ static int fsl_qspi_nor_setup(struct fsl_qspi *q)
 	return 0;
 }
 
-static int fsl_qspi_nor_setup_last(struct fsl_qspi *q)
+static void fsl_qspi_nor_setup_last(struct fsl_qspi *q)
 {
-	unsigned long rate = q->clk_rate;
-	int ret;
-
-	if (is_imx6sx_qspi(q))
-		rate *= 4;
-
-	ret = clk_set_rate(q->clk, rate);
-	if (ret)
-		return ret;
-
 	/* Init the LUT table again. */
 	fsl_qspi_init_lut(q);
 
 	/* Init for AHB read */
 	fsl_qspi_init_abh_read(q);
-
-	return 0;
 }
 
 static const struct of_device_id fsl_qspi_dt_ids[] = {
@@ -763,6 +751,8 @@ static int fsl_qspi_erase(struct spi_nor *nor, loff_t offs)
 static int fsl_qspi_prep(struct spi_nor *nor, enum spi_nor_ops ops)
 {
 	struct fsl_qspi *q = nor->priv;
+	int nor_idx = nor - q->nor;
+	unsigned long rate = q->clk_rate[nor_idx];
 	int ret;
 
 	ret = clk_enable(q->clk_en);
@@ -775,6 +765,16 @@ static int fsl_qspi_prep(struct spi_nor *nor, enum spi_nor_ops ops)
 		return ret;
 	}
 
+	if (is_imx6sx_qspi(q))
+		rate *= 4;
+
+	ret = clk_set_rate(q->clk, rate);
+	if (ret) {
+		clk_disable(q->clk);
+		clk_disable(q->clk_en);
+		return ret;
+	}
+
 	fsl_qspi_set_base_addr(q, nor);
 	return 0;
 }
@@ -899,7 +899,7 @@ static int fsl_qspi_probe(struct platform_device *pdev)
 			goto irq_failed;
 
 		ret = of_property_read_u32(np, "spi-max-frequency",
-				&q->clk_rate);
+				&q->clk_rate[i]);
 		if (ret < 0)
 			goto irq_failed;
 
@@ -939,21 +939,12 @@ static int fsl_qspi_probe(struct platform_device *pdev)
 	}
 
 	/* finish the rest init. */
-	ret = fsl_qspi_nor_setup_last(q);
-	if (ret)
-		goto last_init_failed;
+	fsl_qspi_nor_setup_last(q);
 
 	clk_disable(q->clk);
 	clk_disable(q->clk_en);
 	return 0;
 
-last_init_failed:
-	for (i = 0; i < q->nor_num; i++) {
-		/* skip the holes */
-		if (!q->has_second_chip)
-			i *= 2;
-		mtd_device_unregister(&q->mtd[i]);
-	}
 irq_failed:
 	clk_disable_unprepare(q->clk);
 clk_failed:
-- 
2.3.6
