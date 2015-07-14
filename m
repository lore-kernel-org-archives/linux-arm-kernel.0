From: fcooper@ti.com (Franklin S Cooper Jr)
Date: Tue, 14 Jul 2015 14:45:24 -0500
Subject: [PATCH 1/4] spi: davinci: Set prescale value based on register value
In-Reply-To: <1436903127-6777-1-git-send-email-fcooper@ti.com>
References: <1436903127-6777-1-git-send-email-fcooper@ti.com>
Message-ID: <1436903127-6777-2-git-send-email-fcooper@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Within davinci_spi_get_prescale() the prescale has two meanings. First one
being the calculated prescale value and then at the end translates it to the
prescale value that will be written to the SPI register.

At first glance this can be confusing especially when comparing the minimum
prescale value against what is seen in the TRM.

To simplify things make it clear that the calculated prescale value will always
be based on the value that will be written into the SPI register.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
 drivers/spi/spi-davinci.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index 987afeb..b4605c4 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -255,7 +255,7 @@ static void davinci_spi_chipselect(struct spi_device *spi, int value)
  * This function calculates the prescale value that generates a clock rate
  * less than or equal to the specified maximum.
  *
- * Returns: calculated prescale - 1 for easy programming into SPI registers
+ * Returns: calculated prescale value for easy programming into SPI registers
  * or negative error number if valid prescalar cannot be updated.
  */
 static inline int davinci_spi_get_prescale(struct davinci_spi *dspi,
@@ -263,12 +263,13 @@ static inline int davinci_spi_get_prescale(struct davinci_spi *dspi,
 {
 	int ret;
 
-	ret = DIV_ROUND_UP(clk_get_rate(dspi->clk), max_speed_hz);
+	/* Subtract 1 to match what will be programmed into SPI register. */
+	ret = DIV_ROUND_UP(clk_get_rate(dspi->clk), max_speed_hz) - 1;
 
-	if (ret < 1 || ret > 256)
+	if (ret < 0 || ret > 255)
 		return -EINVAL;
 
-	return ret - 1;
+	return ret;
 }
 
 /**
-- 
1.9.1
