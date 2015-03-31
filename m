From: m.grzeschik@pengutronix.de (Michael Grzeschik)
Date: Tue, 31 Mar 2015 15:54:49 +0200
Subject: [PATCH] spi: bitbang: only toggle bitchanges
Message-ID: <1427810089-14866-1-git-send-email-m.grzeschik@pengutronix.de>
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
 drivers/spi/spi-bitbang-txrx.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-bitbang-txrx.h b/drivers/spi/spi-bitbang-txrx.h
index c616e41..62bdf62 100644
--- a/drivers/spi/spi-bitbang-txrx.h
+++ b/drivers/spi/spi-bitbang-txrx.h
@@ -49,12 +49,16 @@ bitbang_txrx_be_cpha0(struct spi_device *spi,
 {
 	/* if (cpol == 0) this is SPI_MODE_0; else this is SPI_MODE_2 */
 
+	bool oldbit = !(word & 1);
 	/* clock starts at inactive polarity */
 	for (word <<= (32 - bits); likely(bits); bits--) {
 
 		/* setup MSB (to slave) on trailing edge */
 		if ((flags & SPI_MASTER_NO_TX) == 0)
-			setmosi(spi, word & (1 << 31));
+			if ((word & (1 << 31)) != oldbit) {
+				setmosi(spi, word & (1 << 31));
+				oldbit = word & (1 << 31);
+			}
 		spidelay(nsecs);	/* T(setup) */
 
 		setsck(spi, !cpol);
@@ -76,13 +80,17 @@ bitbang_txrx_be_cpha1(struct spi_device *spi,
 {
 	/* if (cpol == 0) this is SPI_MODE_1; else this is SPI_MODE_3 */
 
+	bool oldbit = !(word & (1 << 31));
 	/* clock starts@inactive polarity */
 	for (word <<= (32 - bits); likely(bits); bits--) {
 
 		/* setup MSB (to slave) on leading edge */
 		setsck(spi, !cpol);
 		if ((flags & SPI_MASTER_NO_TX) == 0)
-			setmosi(spi, word & (1 << 31));
+			if ((word & (1 << 31)) != oldbit) {
+				setmosi(spi, word & (1 << 31));
+				oldbit = word & (1 << 31);
+			}
 		spidelay(nsecs); /* T(setup) */
 
 		setsck(spi, cpol);
-- 
2.1.4
