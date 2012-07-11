From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Wed, 11 Jul 2012 16:45:59 +0530
Subject: [PATCH v5 5/6] spi: s3c64xx: Remove the 'set_level' callback from
 controller data
In-Reply-To: <CAJuYYwSi-1nBM40SWt359W0Lr2n_yVX5tvWfOS77bmLQRt_9fw@mail.gmail.com>
References: <CAJuYYwSi-1nBM40SWt359W0Lr2n_yVX5tvWfOS77bmLQRt_9fw@mail.gmail.com>
Message-ID: <1342005359-748-1-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The set_level callback in the controller data, which is used to configure
the slave select line, cannot be supported when migrating the driver to
device tree based discovery. Since all the platforms currently use gpio
as the slave select line, this callback can be removed from the
controller data and replaced with call to gpio_set_value in the driver.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
Acked-by: Jaswinder Singh <jaswinder.singh@linaro.org>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
---
 arch/arm/plat-samsung/include/plat/s3c64xx-spi.h |    2 -
 drivers/spi/spi-s3c64xx.c                        |   30 ++++++++++++++++++---
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h b/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
index c818a7c..ceba18d 100644
--- a/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
+++ b/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
@@ -18,7 +18,6 @@ struct platform_device;
  * @fb_delay: Slave specific feedback delay.
  *            Refer to FB_CLK_SEL register definition in SPI chapter.
  * @line: Custom 'identity' of the CS line.
- * @set_level: CS line control.
  *
  * This is per SPI-Slave Chipselect information.
  * Allocate and initialize one in machine init code and make the
@@ -27,7 +26,6 @@ struct platform_device;
 struct s3c64xx_spi_csinfo {
 	u8 fb_delay;
 	unsigned line;
-	void (*set_level)(unsigned line_id, int lvl);
 };
 
 /**
diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 0a9e43e..ba5193b 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -27,6 +27,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/spi/spi.h>
+#include <linux/gpio.h>
 
 #include <mach/dma.h>
 #include <plat/s3c64xx-spi.h>
@@ -411,14 +412,14 @@ static inline void enable_cs(struct s3c64xx_spi_driver_data *sdd,
 		if (sdd->tgl_spi != spi) { /* if last mssg on diff device */
 			/* Deselect the last toggled device */
 			cs = sdd->tgl_spi->controller_data;
-			cs->set_level(cs->line,
-					spi->mode & SPI_CS_HIGH ? 0 : 1);
+			gpio_set_value(cs->line,
+				spi->mode & SPI_CS_HIGH ? 0 : 1);
 		}
 		sdd->tgl_spi = NULL;
 	}
 
 	cs = spi->controller_data;
-	cs->set_level(cs->line, spi->mode & SPI_CS_HIGH ? 1 : 0);
+	gpio_set_value(cs->line, spi->mode & SPI_CS_HIGH ? 1 : 0);
 }
 
 static int wait_for_xfer(struct s3c64xx_spi_driver_data *sdd,
@@ -504,7 +505,7 @@ static inline void disable_cs(struct s3c64xx_spi_driver_data *sdd,
 	if (sdd->tgl_spi == spi)
 		sdd->tgl_spi = NULL;
 
-	cs->set_level(cs->line, spi->mode & SPI_CS_HIGH ? 0 : 1);
+	gpio_set_value(cs->line, spi->mode & SPI_CS_HIGH ? 0 : 1);
 }
 
 static void s3c64xx_spi_config(struct s3c64xx_spi_driver_data *sdd)
@@ -833,11 +834,21 @@ static int s3c64xx_spi_setup(struct spi_device *spi)
 	unsigned long flags;
 	int err = 0;
 
-	if (cs == NULL || cs->set_level == NULL) {
+	if (cs == NULL) {
 		dev_err(&spi->dev, "No CS for SPI(%d)\n", spi->chip_select);
 		return -ENODEV;
 	}
 
+	if (!spi_get_ctldata(spi)) {
+		err = gpio_request(cs->line, dev_name(&spi->dev));
+		if (err) {
+			dev_err(&spi->dev, "request for slave select gpio "
+					"line [%d] failed\n", cs->line);
+			return -EBUSY;
+		}
+		spi_set_ctldata(spi, cs);
+	}
+
 	sdd = spi_master_get_devdata(spi->master);
 	sci = sdd->cntrlr_info;
 
@@ -908,6 +919,15 @@ setup_exit:
 	return err;
 }
 
+static void s3c64xx_spi_cleanup(struct spi_device *spi)
+{
+	struct s3c64xx_spi_csinfo *cs = spi_get_ctldata(spi);
+
+	if (cs)
+		gpio_free(cs->line);
+	spi_set_ctldata(spi, NULL);
+}
+
 static irqreturn_t s3c64xx_spi_irq(int irq, void *data)
 {
 	struct s3c64xx_spi_driver_data *sdd = data;
-- 
1.6.6.rc2
