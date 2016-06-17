From: andi.shyti@samsung.com (Andi Shyti)
Date: Fri, 17 Jun 2016 16:57:21 +0900
Subject: [PATCH 1/5] spi: do not fail if the CS line is not connected
In-Reply-To: <1466150245-2648-1-git-send-email-andi.shyti@samsung.com>
References: <1466150245-2648-1-git-send-email-andi.shyti@samsung.com>
Message-ID: <1466150245-2648-2-git-send-email-andi.shyti@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some SPI connected devices do not have any CS line connected as
some devices are alway enabled. Indeed, until now, a common
workaround was to assign to num_chipselect a -1 value or 255
(num_chipselect is unsigned).

In this case do not fail and defer to the SPI device drivers the
responsibility to check whether the num-cs is '0'.

Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
---
 drivers/spi/spi.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 77e6e45..f22dc27 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -504,8 +504,13 @@ int spi_add_device(struct spi_device *spi)
 	struct device *dev = master->dev.parent;
 	int status;
 
-	/* Chipselects are numbered 0..max; validate. */
-	if (spi->chip_select >= master->num_chipselect) {
+	/*
+	 * Chipselects are numbered 0..max; validate.
+	 * If there is no chip select (i.e. num_chipselect == 0),
+	 * the comparison doesn't make sense.
+	 */
+	if (master->num_chipselect &&
+				spi->chip_select >= master->num_chipselect) {
 		dev_err(dev, "cs%d >= max %d\n",
 			spi->chip_select,
 			master->num_chipselect);
@@ -1851,12 +1856,6 @@ int spi_register_master(struct spi_master *master)
 	if (status)
 		return status;
 
-	/* even if it's just one always-selected device, there must
-	 * be at least one chipselect
-	 */
-	if (master->num_chipselect == 0)
-		return -EINVAL;
-
 	if ((master->bus_num < 0) && master->dev.of_node)
 		master->bus_num = of_alias_get_id(master->dev.of_node, "spi");
 
-- 
2.8.1
