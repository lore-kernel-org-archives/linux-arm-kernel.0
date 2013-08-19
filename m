From: shc_work@mail.ru (Alexander Shiyan)
Date: Mon, 19 Aug 2013 15:39:21 +0400
Subject: [PATCH v2 3/3] can: mcp251x: Allow tuning SPI mode and limit maximal
 SPI speed
In-Reply-To: <1376912361-22133-1-git-send-email-shc_work@mail.ru>
References: <1376912361-22133-1-git-send-email-shc_work@mail.ru>
Message-ID: <1376912361-22133-3-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch allow to use different mode settings for SPI (MODE3 for example)
and limit maximal speed according to IC datasheet.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/net/can/mcp251x.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/mcp251x.c b/drivers/net/can/mcp251x.c
index a48d3df..c08edc7 100644
--- a/drivers/net/can/mcp251x.c
+++ b/drivers/net/can/mcp251x.c
@@ -1082,7 +1082,11 @@ static int mcp251x_can_probe(struct spi_device *spi)
 	SET_NETDEV_DEV(net, &spi->dev);
 
 	/* Configure the SPI bus */
-	spi->mode = SPI_MODE_0;
+	spi->mode = spi->mode ? : SPI_MODE_0;
+	if (mcp251x_is_2510(spi))
+		spi->max_speed_hz = spi->max_speed_hz ? : 5 * 1000 * 1000;
+	else
+		spi->max_speed_hz = spi->max_speed_hz ? : 10 * 1000 * 1000;
 	spi->bits_per_word = 8;
 	spi_setup(spi);
 
-- 
1.8.1.5
