From: broonie@kernel.org (Mark Brown)
Date: Thu, 03 Nov 2016 09:42:47 -0600
Subject: Applied "spi: sun6i: Support Allwinner H3 SPI controller" to the spi
 tree
In-Reply-To: <20161028065412.23008-5-woogyom.kim@gmail.com>
Message-ID: <E1c2KAB-0000B9-TX@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: sun6i: Support Allwinner H3 SPI controller

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 10565dfd35488c45826201b4ce28597d6b5de3dd Mon Sep 17 00:00:00 2001
From: Milo Kim <woogyom.kim@gmail.com>
Date: Fri, 28 Oct 2016 15:54:12 +0900
Subject: [PATCH] spi: sun6i: Support Allwinner H3 SPI controller

H3 has two SPI controllers. The size of the buffer is 64 * 8.
(8 bit transfer by 64 entry FIFO)
A31 has four controllers. The size of the buffer is 128 * 8.
(8 bit transfer by 128 entry FIFO)

Register maps are sharable, so sun6i SPI driver is reusable with
device configuration.

Use the variable, 'fifo_depth' instead of fixed value to support both SPI
controllers.

Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-sun6i.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index 9918a57a6a6e..e3114832c485 100644
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
2.10.1
