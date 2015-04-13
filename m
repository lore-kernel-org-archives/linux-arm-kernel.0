From: m.grzeschik@pengutronix.de (Michael Grzeschik)
Date: Mon, 13 Apr 2015 12:59:30 +0200
Subject: [PATCH v3] spi: bitbang: only toggle bitchanges
In-Reply-To: <20150331202306.GX2869@sirena.org.uk>
References: <20150331202306.GX2869@sirena.org.uk>
Message-ID: <1428922770-16955-1-git-send-email-m.grzeschik@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current implementation of bitbang_txrx_be_cpha0 and
bitbang_txrx_be_cpha1 always call setmosi. That runs into several
unnecessary calls into the gpiolib when the level of the GPIO actually
has not to be changed.

This patch changes the routines to remember the last GPIO level
and only calls setmosi if an change has to be made. This
way it improves the transfer throughput.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
v2: - added missing braces
v3: - fixed initial value of oldbit
    - added !! to condition for bool comparison

 drivers/spi/spi-bitbang-txrx.h | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-bitbang-txrx.h b/drivers/spi/spi-bitbang-txrx.h
index c616e41..58606bf 100644
--- a/drivers/spi/spi-bitbang-txrx.h
+++ b/drivers/spi/spi-bitbang-txrx.h
@@ -49,12 +49,17 @@ bitbang_txrx_be_cpha0(struct spi_device *spi,
 {
 	/* if (cpol == 0) this is SPI_MODE_0; else this is SPI_MODE_2 */
 
+	bool oldbit = !(word & (1 << 31));
 	/* clock starts at inactive polarity */
 	for (word <<= (32 - bits); likely(bits); bits--) {
 
 		/* setup MSB (to slave) on trailing edge */
-		if ((flags & SPI_MASTER_NO_TX) == 0)
-			setmosi(spi, word & (1 << 31));
+		if ((flags & SPI_MASTER_NO_TX) == 0) {
+			if (!!(word & (1 << 31)) != oldbit) {
+				setmosi(spi, word & (1 << 31));
+				oldbit = word & (1 << 31);
+			}
+		}
 		spidelay(nsecs);	/* T(setup) */
 
 		setsck(spi, !cpol);
@@ -76,13 +81,18 @@ bitbang_txrx_be_cpha1(struct spi_device *spi,
 {
 	/* if (cpol == 0) this is SPI_MODE_1; else this is SPI_MODE_3 */
 
+	bool oldbit = !(word & (1 << 31));
 	/* clock starts@inactive polarity */
 	for (word <<= (32 - bits); likely(bits); bits--) {
 
 		/* setup MSB (to slave) on leading edge */
 		setsck(spi, !cpol);
-		if ((flags & SPI_MASTER_NO_TX) == 0)
-			setmosi(spi, word & (1 << 31));
+		if ((flags & SPI_MASTER_NO_TX) == 0) {
+			if (!!(word & (1 << 31)) != oldbit) {
+				setmosi(spi, word & (1 << 31));
+				oldbit = word & (1 << 31);
+			}
+		}
 		spidelay(nsecs); /* T(setup) */
 
 		setsck(spi, cpol);
-- 
2.1.4
