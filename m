From: woogyom.kim@gmail.com (Milo Kim)
Date: Fri, 28 Oct 2016 15:54:12 +0900
Subject: [PATCH v2 4/4] spi: sun6i: Support Allwinner H3 SPI controller
In-Reply-To: <20161028065412.23008-1-woogyom.kim@gmail.com>
References: <20161028065412.23008-1-woogyom.kim@gmail.com>
Message-ID: <20161028065412.23008-5-woogyom.kim@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

H3 has two SPI controllers. The size of the buffer is 64 * 8.
(8 bit transfer by 64 entry FIFO)
A31 has four controllers. The size of the buffer is 128 * 8.
(8 bit transfer by 128 entry FIFO)

Register maps are sharable, so sun6i SPI driver is reusable with
device configuration.

Use the variable, 'fifo_depth' instead of fixed value to support both SPI
controllers.

Cc: Mark Brown <broonie@kernel.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
---
 drivers/spi/spi-sun6i.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index 9918a57..e311483 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -17,6 +17,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
@@ -24,6 +25,7 @@
 #include <linux/spi/spi.h>
 
 #define SUN6I_FIFO_DEPTH		128
+#define SUN8I_FIFO_DEPTH		64
 
 #define SUN6I_GBL_CTL_REG		0x04
 #define SUN6I_GBL_CTL_BUS_ENABLE		BIT(0)
@@ -90,6 +92,7 @@ struct sun6i_spi {
 	const u8		*tx_buf;
 	u8			*rx_buf;
 	int			len;
+	unsigned long		fifo_depth;
 };
 
 static inline u32 sun6i_spi_read(struct sun6i_spi *sspi, u32 reg)
@@ -155,7 +158,9 @@ static void sun6i_spi_set_cs(struct spi_device *spi, bool enable)
 
 static size_t sun6i_spi_max_transfer_size(struct spi_device *spi)
 {
-	return SUN6I_FIFO_DEPTH - 1;
+	struct sun6i_spi *sspi = spi_master_get_devdata(spi->master);
+
+	return sspi->fifo_depth - 1;
 }
 
 static int sun6i_spi_transfer_one(struct spi_master *master,
@@ -170,7 +175,7 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 	u32 reg;
 
 	/* We don't support transfer larger than the FIFO */
-	if (tfr->len > SUN6I_FIFO_DEPTH)
+	if (tfr->len > sspi->fifo_depth)
 		return -EINVAL;
 
 	reinit_completion(&sspi->done);
@@ -265,7 +270,7 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 			SUN6I_BURST_CTL_CNT_STC(tx_len));
 
 	/* Fill the TX FIFO */
-	sun6i_spi_fill_fifo(sspi, SUN6I_FIFO_DEPTH);
+	sun6i_spi_fill_fifo(sspi, sspi->fifo_depth);
 
 	/* Enable the interrupts */
 	sun6i_spi_write(sspi, SUN6I_INT_CTL_REG, SUN6I_INT_CTL_TC);
@@ -288,7 +293,7 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 		goto out;
 	}
 
-	sun6i_spi_drain_fifo(sspi, SUN6I_FIFO_DEPTH);
+	sun6i_spi_drain_fifo(sspi, sspi->fifo_depth);
 
 out:
 	sun6i_spi_write(sspi, SUN6I_INT_CTL_REG, 0);
@@ -398,6 +403,8 @@ static int sun6i_spi_probe(struct platform_device *pdev)
 	}
 
 	sspi->master = master;
+	sspi->fifo_depth = (unsigned long)of_device_get_match_data(&pdev->dev);
+
 	master->max_speed_hz = 100 * 1000 * 1000;
 	master->min_speed_hz = 3 * 1000;
 	master->set_cs = sun6i_spi_set_cs;
@@ -470,7 +477,8 @@ static int sun6i_spi_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id sun6i_spi_match[] = {
-	{ .compatible = "allwinner,sun6i-a31-spi", },
+	{ .compatible = "allwinner,sun6i-a31-spi", .data = (void *)SUN6I_FIFO_DEPTH },
+	{ .compatible = "allwinner,sun8i-h3-spi",  .data = (void *)SUN8I_FIFO_DEPTH },
 	{}
 };
 MODULE_DEVICE_TABLE(of, sun6i_spi_match);
-- 
2.9.3
