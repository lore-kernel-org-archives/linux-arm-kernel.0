From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Mon, 29 Sep 2014 11:47:53 +0200
Subject: [PATCH 1/2] mtd: m25p80: get rid of spi_get_device_id
Message-ID: <1411984074-3850-1-git-send-email-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This simplifies the way we use spi_nor framework and will allow us to
drop spi_nor_match_id.

Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
---
 drivers/mtd/devices/m25p80.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index dcda628..822209d 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -197,6 +197,7 @@ static int m25p_probe(struct spi_device *spi)
 	struct m25p *flash;
 	struct spi_nor *nor;
 	enum read_mode mode = SPI_NOR_NORMAL;
+	char *flash_name = NULL;
 	int ret;
 
 	data = dev_get_platdata(&spi->dev);
@@ -236,12 +237,11 @@ static int m25p_probe(struct spi_device *spi)
 	 * If that's the case, respect "type" and ignore a "name".
 	 */
 	if (data && data->type)
-		id = spi_nor_match_id(data->type);
-
-	/* If we didn't get name from platform, simply use "modalias". */
-	if (!id)
-		id = spi_get_device_id(spi);
+		flash_name = data->type;
+	else
+		flash_name = spi->modalias;
 
+	id = spi_nor_match_id(flash_name);
 	ret = spi_nor_scan(nor, id, mode);
 	if (ret)
 		return ret;
-- 
1.8.4.5
