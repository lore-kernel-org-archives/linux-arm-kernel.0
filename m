From: tpiepho@gmail.com (Trent Piepho)
Date: Tue,  2 Apr 2013 05:19:51 -0700
Subject: [PATCH V2 08/12] spi/mxs: Fix race in setup method
In-Reply-To: <1364905195-24286-1-git-send-email-tpiepho@gmail.com>
References: <1364905195-24286-1-git-send-email-tpiepho@gmail.com>
Message-ID: <1364905195-24286-8-git-send-email-tpiepho@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Despite many warnings in the SPI documentation and code, the spi-mxs
driver sets shared chip registers in the ->setup method.  This method can
be called when transfers are in progress on other slaves controlled by the
master.  Setting registers or any other shared state will corrupt those
transfers.

So fix mxs_spi_setup() to not call mxs_spi_setup_transfer().

Signed-off-by: Trent Piepho <tpiepho@gmail.com>
Cc: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/spi/spi-mxs.c |   11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index 103c478..2a2147a 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -115,21 +115,16 @@ static int mxs_spi_setup_transfer(struct spi_device *dev,
 
 static int mxs_spi_setup(struct spi_device *dev)
 {
-	int err = 0;
-
 	if (!dev->bits_per_word)
 		dev->bits_per_word = 8;
 
 	if (dev->mode & ~(SPI_CPOL | SPI_CPHA))
 		return -EINVAL;
 
-	err = mxs_spi_setup_transfer(dev, NULL);
-	if (err) {
-		dev_err(&dev->dev,
-			"Failed to setup transfer, error = %d\n", err);
-	}
+	if (dev->bits_per_word != 8)
+		return -EINVAL;
 
-	return err;
+	return 0;
 }
 
 static uint32_t mxs_spi_cs_to_reg(unsigned cs)
-- 
1.7.10.4
