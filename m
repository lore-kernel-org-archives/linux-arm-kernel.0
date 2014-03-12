From: m.grzeschik@pengutronix.de (Michael Grzeschik)
Date: Wed, 12 Mar 2014 16:53:35 +0100
Subject: [PATCH 1/3] spi: bitbang: fix shift for getmosi
In-Reply-To: <1394639617-26917-1-git-send-email-m.grzeschik@pengutronix.de>
References: <1394639617-26917-1-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <1394639617-26917-2-git-send-email-m.grzeschik@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver needs to shift the word bit after reading the mosi bit.
Otherwise the return word will have an Off-by-one bit value.

Cc: <stable@vger.kernel.org>
Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 drivers/spi/spi-bitbang-txrx.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-bitbang-txrx.h b/drivers/spi/spi-bitbang-txrx.h
index c616e41..b6e348d 100644
--- a/drivers/spi/spi-bitbang-txrx.h
+++ b/drivers/spi/spi-bitbang-txrx.h
@@ -61,10 +61,10 @@ bitbang_txrx_be_cpha0(struct spi_device *spi,
 		spidelay(nsecs);
 
 		/* sample MSB (from slave) on leading edge */
-		word <<= 1;
 		if ((flags & SPI_MASTER_NO_RX) == 0)
 			word |= getmiso(spi);
 		setsck(spi, cpol);
+		word <<= 1;
 	}
 	return word;
 }
@@ -89,9 +89,9 @@ bitbang_txrx_be_cpha1(struct spi_device *spi,
 		spidelay(nsecs);
 
 		/* sample MSB (from slave) on trailing edge */
-		word <<= 1;
 		if ((flags & SPI_MASTER_NO_RX) == 0)
 			word |= getmiso(spi);
+		word <<= 1;
 	}
 	return word;
 }
-- 
1.9.0
