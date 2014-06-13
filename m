From: ch.naveen@samsung.com (Naveen Krishna Chatradhi)
Date: Fri, 13 Jun 2014 09:29:51 +0530
Subject: [PATCH 2/3 v5] spi: s3c64xx: for DT platofrms always get the
 chipselect info from DT node
In-Reply-To: <1402631992-500-1-git-send-email-ch.naveen@samsung.com>
References: <1402631992-500-1-git-send-email-ch.naveen@samsung.com>
Message-ID: <1402631992-500-2-git-send-email-ch.naveen@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use controller_data structure only for the Non Device tree  platforms.
For Device tree platforms, always derive the chipselect info from
DT node.

Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Tested-by: Doug Anderson <dianders@chromium.org>
---
Changes since v4:
1. Added reviewed by from Javier and Tested by from Doug

Changes since v3:
New change

 drivers/spi/spi-s3c64xx.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index b888c66..f27e15d 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -795,14 +795,15 @@ static int s3c64xx_spi_setup(struct spi_device *spi)
 	int err;
 
 	sdd = spi_master_get_devdata(spi->master);
-	if (!cs && spi->dev.of_node) {
+	if (spi->dev.of_node) {
 		cs = s3c64xx_get_slave_ctrldata(spi);
 		spi->controller_data = cs;
-	}
-
-	/* For the non-DT platforms derive chip selects from controller data */
-	if (!spi->dev.of_node)
+	} else {
+		/* For the non-DT platforms derive chip
+		 * selects from controller data
+		 */
 		spi->cs_gpio = cs->line;
+	}
 
 	if (IS_ERR_OR_NULL(cs)) {
 		dev_err(&spi->dev, "No CS for SPI(%d)\n", spi->chip_select);
-- 
1.7.9.5
