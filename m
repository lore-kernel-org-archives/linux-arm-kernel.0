From: ch.naveen@samsung.com (Naveen Krishna Chatradhi)
Date: Mon, 14 Jul 2014 11:11:45 +0530
Subject: [PATCH 2/3 v6] spi: s3c64xx: for DT platofrms always get the
 chipselect info from DT node
In-Reply-To: <1405316506-27855-1-git-send-email-ch.naveen@samsung.com>
References: <1405316506-27855-1-git-send-email-ch.naveen@samsung.com>
Message-ID: <1405316506-27855-3-git-send-email-ch.naveen@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use controller_data structure only for the Non Device tree  platforms.
For Device tree platforms, always derive the chipselect info from
DT node.

Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Tested-by: Doug Anderson <dianders@chromium.org>
---
Changes since v5:
None

Changes since v4:
1. Added reviewed by from Javier and Tested by from Doug

Changes since v3:
New change
 drivers/spi/spi-s3c64xx.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index b61ff3d..a4b1af0 100644
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
