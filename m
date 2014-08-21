From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Thu, 21 Aug 2014 18:25:05 +0300
Subject: [PATCH 1/2] spi: davinci: fix SPI_NO_CS functionality
In-Reply-To: <1408634706-5762-1-git-send-email-grygorii.strashko@ti.com>
References: <1408634706-5762-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <1408634706-5762-2-git-send-email-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver should not touch CS lines if SPI_NO_CS flag is set.
This patch fixes it as this functionality was broken accidentally
by
commit a88e34ea213e1b ("spi: davinci: add support to configure gpio cs through dt").

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/spi/spi-davinci.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index 276a388..48f1d26 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -417,16 +417,16 @@ static int davinci_spi_setup(struct spi_device *spi)
 						  flags, dev_name(&spi->dev));
 			internal_cs = false;
 		}
-	}
 
-	if (retval) {
-		dev_err(&spi->dev, "GPIO %d setup failed (%d)\n",
-			spi->cs_gpio, retval);
-		return retval;
-	}
+		if (retval) {
+			dev_err(&spi->dev, "GPIO %d setup failed (%d)\n",
+				spi->cs_gpio, retval);
+			return retval;
+		}
 
-	if (internal_cs)
-		set_io_bits(dspi->base + SPIPC0, 1 << spi->chip_select);
+		if (internal_cs)
+			set_io_bits(dspi->base + SPIPC0, 1 << spi->chip_select);
+	}
 
 	if (spi->mode & SPI_READY)
 		set_io_bits(dspi->base + SPIPC0, SPIPC0_SPIENA_MASK);
-- 
1.7.9.5
