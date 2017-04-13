From: jiada_wang@mentor.com (jiada_wang at mentor.com)
Date: Thu, 13 Apr 2017 05:14:01 -0700
Subject: [PATCH RFC 2/5] spi: spidev: use different name for SPI controller
 slave mode device
In-Reply-To: <1492085644-4195-1-git-send-email-jiada_wang@mentor.com>
References: <1492085644-4195-1-git-send-email-jiada_wang@mentor.com>
Message-ID: <1492085644-4195-3-git-send-email-jiada_wang@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jiada Wang <jiada_wang@mentor.com>

SPI bus controller has started to support to work in slave mode,
for device SPI controller itself works in slave mode, use name
'spidev[bus]-slv' as its name to differentiate from other
SPI devices

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 drivers/spi/spidev.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 9e2e099..e2996fb 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -781,9 +781,18 @@ static int spidev_probe(struct spi_device *spi)
 		struct device *dev;
 
 		spidev->devt = MKDEV(SPIDEV_MAJOR, minor);
-		dev = device_create(spidev_class, &spi->dev, spidev->devt,
-				    spidev, "spidev%d.%d",
-				    spi->master->bus_num, spi->chip_select);
+		if (spi->slave_mode)
+			dev = device_create(spidev_class, &spi->dev,
+					    spidev->devt, spidev,
+					    "spidev%d-slv",
+					    spi->master->bus_num);
+		else
+			dev = device_create(spidev_class, &spi->dev,
+					    spidev->devt, spidev,
+					    "spidev%d.%d",
+					    spi->master->bus_num,
+					    spi->chip_select);
+
 		status = PTR_ERR_OR_ZERO(dev);
 	} else {
 		dev_dbg(&spi->dev, "no minor number available!\n");
-- 
2.7.4
