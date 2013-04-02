From: tpiepho@gmail.com (Trent Piepho)
Date: Tue,  2 Apr 2013 05:19:54 -0700
Subject: [PATCH V2 11/12] spi/mxs: Don't set clock for each xfer
In-Reply-To: <1364905195-24286-1-git-send-email-tpiepho@gmail.com>
References: <1364905195-24286-1-git-send-email-tpiepho@gmail.com>
Message-ID: <1364905195-24286-11-git-send-email-tpiepho@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mxs_spi_setup_transfer() would set the SSP SCK rate every time it was
called, which is before each transfer.  It is uncommon for the SCK rate to
change between transfers and this causes unnecessary reprogramming of the
clock registers.  Changed to only set the rate when it has changed.

This significantly speeds up short SPI messages, especially messages made
up of many transfers.  On an iMX287, using spidev with messages that
consist of 511 transfers of 4 bytes each at an SCK of 48 MHz, the
effective transfer rate more than doubles from about 290 KB/sec to 600
KB/sec.

Signed-off-by: Trent Piepho <tpiepho@gmail.com>
Cc: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/spi/spi-mxs.c |   15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index a7d5f85..12794ea 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -68,6 +68,7 @@
 struct mxs_spi {
 	struct mxs_ssp		ssp;
 	struct completion	c;
+	unsigned int		sck;	/* Rate requested (vs actual) */
 };
 
 static int mxs_spi_setup_transfer(struct spi_device *dev,
@@ -88,7 +89,19 @@ static int mxs_spi_setup_transfer(struct spi_device *dev,
 		return -EINVAL;
 	}
 
-	mxs_ssp_set_clk_rate(ssp, hz);
+	if (hz != spi->sck) {
+		mxs_ssp_set_clk_rate(ssp, hz);
+		/*
+		 * Save requested value, not actual value from ssp->clk_rate.
+		 * Otherwise we would set the rate again each trasfer when
+		 * actual is not quite the same as requested.
+		 */
+		spi->sck = hz;
+		/*
+		 * Perhaps we should return an error if the actual clock is
+		 * nowhere close to what was requested?
+		 */
+	}
 
 	writel(BM_SSP_CTRL0_LOCK_CS,
 		ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_SET);
-- 
1.7.10.4
