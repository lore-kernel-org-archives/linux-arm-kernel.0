From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 23 Jul 2012 13:16:54 +0200
Subject: [PATCH 1/2] spi-orion: remove uneeded spi_info
Message-ID: <1343042216-4113-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Michael Walle <michael@walle.cc>

This was formerly used to store the tclk value. This is now discovered
using the clk API, rather than pass it as platform data.

Signed-off-by: Michael Walle <michael@walle.cc>
Acked-by: Jason Cooper <jason@lakedaemon.net>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>
---
 drivers/spi/spi-orion.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index 74312a8..9b0cadd 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -46,7 +46,6 @@ struct orion_spi {
 	void __iomem		*base;
 	unsigned int		max_speed;
 	unsigned int		min_speed;
-	struct orion_spi_info	*spi_info;
 	struct clk              *clk;
 };
 
@@ -451,14 +450,11 @@ static int __init orion_spi_probe(struct platform_device *pdev)
 	struct spi_master *master;
 	struct orion_spi *spi;
 	struct resource *r;
-	struct orion_spi_info *spi_info;
 	unsigned long tclk_hz;
 	int status = 0;
 	const u32 *iprop;
 	int size;
 
-	spi_info = pdev->dev.platform_data;
-
 	master = spi_alloc_master(&pdev->dev, sizeof *spi);
 	if (master == NULL) {
 		dev_dbg(&pdev->dev, "master allocation failed\n");
@@ -485,7 +481,6 @@ static int __init orion_spi_probe(struct platform_device *pdev)
 
 	spi = spi_master_get_devdata(master);
 	spi->master = master;
-	spi->spi_info = spi_info;
 
 	spi->clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(spi->clk)) {
-- 
1.7.10.4
