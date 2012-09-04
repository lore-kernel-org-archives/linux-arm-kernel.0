From: marex@denx.de (Marek Vasut)
Date: Tue,  4 Sep 2012 04:40:18 +0200
Subject: [PATCH 4/4] mxs/spi: Rework the mxs_ssp_timeout to be more readable
In-Reply-To: <1346726418-2856-1-git-send-email-marex@denx.de>
References: <1346726418-2856-1-git-send-email-marex@denx.de>
Message-ID: <1346726418-2856-5-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rework the mxs_ssp_timeout() function to make it a bit more readable
and hopefully less error prone. Also, have only one successful exit
from the function and one failing exit instead of two.

Finally, discard the udelay() from this function altogether, as this
tightloop is quick enough it's pointless.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Chris Ball <cjb@laptop.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/spi/spi-mxs.c |   20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index 6650ded..2c3665a 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -177,25 +177,23 @@ static inline void mxs_spi_disable(struct mxs_spi *spi)
 
 static int mxs_ssp_wait(struct mxs_spi *spi, int offset, int mask, bool set)
 {
-	unsigned long timeout = jiffies + msecs_to_jiffies(SSP_TIMEOUT);
+	const unsigned long timeout = jiffies + msecs_to_jiffies(SSP_TIMEOUT);
 	struct mxs_ssp *ssp = &spi->ssp;
 	uint32_t reg;
 
-	while (1) {
+	do {
 		reg = readl_relaxed(ssp->base + offset);
 
-		if (set && ((reg & mask) == mask))
-			break;
+		if (!set)
+			reg = ~reg;
 
-		if (!set && ((~reg & mask) == mask))
-			break;
+		reg &= mask;
 
-		udelay(1);
+		if (reg == mask)
+			return 0;
+	} while (time_before(jiffies, timeout));
 
-		if (time_after(jiffies, timeout))
-			return -ETIMEDOUT;
-	}
-	return 0;
+	return -ETIMEDOUT;
 }
 
 static void mxs_ssp_dma_irq_callback(void *param)
-- 
1.7.10.4
