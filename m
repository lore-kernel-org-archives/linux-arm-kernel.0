From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 30 Sep 2010 11:57:51 +0200
Subject: [PATCH] spi/pl022: compare bitwidth to enums
Message-ID: <1285840671-9567-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The enums from <linux/amba/pl022.h> are actually off-by-one
since bitwidth 4 is defined as 0x03, causing weirdness when
we were trying out some 9-bit peripheral. Fix this by
comparing to the enum values rather than hardcoded values
and also fixing the enum to something reasonable.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 drivers/spi/amba-pl022.c   |    4 ++--
 include/linux/amba/pl022.h |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/amba-pl022.c b/drivers/spi/amba-pl022.c
index 90a7e5d..981f78d 100644
--- a/drivers/spi/amba-pl022.c
+++ b/drivers/spi/amba-pl022.c
@@ -1605,12 +1605,12 @@ static int pl022_setup(struct spi_device *spi)
 	chip->xfer_type = chip_info->com_mode;
 	chip->cs_control = chip_info->cs_control;
 
-	if (chip_info->data_size <= 8) {
+	if (chip_info->data_size <= SSP_DATA_BITS_8) {
 		dev_dbg(&spi->dev, "1 <= n <=8 bits per word\n");
 		chip->n_bytes = 1;
 		chip->read = READING_U8;
 		chip->write = WRITING_U8;
-	} else if (chip_info->data_size <= 16) {
+	} else if (chip_info->data_size <= SSP_DATA_BITS_16) {
 		dev_dbg(&spi->dev, "9 <= n <= 16 bits per word\n");
 		chip->n_bytes = 2;
 		chip->read = READING_U16;
diff --git a/include/linux/amba/pl022.h b/include/linux/amba/pl022.h
index abf26cc..3c83c62 100644
--- a/include/linux/amba/pl022.h
+++ b/include/linux/amba/pl022.h
@@ -90,7 +90,7 @@ enum ssp_tx_endian {
  * enum ssp_data_size - number of bits in one data element
  */
 enum ssp_data_size {
-	SSP_DATA_BITS_4 = 0x03, SSP_DATA_BITS_5, SSP_DATA_BITS_6,
+	SSP_DATA_BITS_4 = 0x04, SSP_DATA_BITS_5, SSP_DATA_BITS_6,
 	SSP_DATA_BITS_7, SSP_DATA_BITS_8, SSP_DATA_BITS_9,
 	SSP_DATA_BITS_10, SSP_DATA_BITS_11, SSP_DATA_BITS_12,
 	SSP_DATA_BITS_13, SSP_DATA_BITS_14, SSP_DATA_BITS_15,
-- 
1.6.3.3
