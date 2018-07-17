From: tudor.ambarus@microchip.com (Tudor Ambarus)
Date: Tue, 17 Jul 2018 19:28:29 +0300
Subject: [PATCH 1/3] mtd: spi-nor: add Global Block Unlock support
Message-ID: <20180717162831.17947-1-tudor.ambarus@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We can't determine this purely by manufacturer type and it's not
autodetectable by anything like SFDP, so make a new flag for it:
UNLOCK_GLOBAL_BLOCK.

Note that the Global Block Unlock command has different names
depending on the manufacturer, but always the same command value:
0x98. Macronix's MX25U12835F names it Gang Block Unlock,
Winbound's W25Q128FV names it Global Block Unlock and
Microchip's SST26VF064B names it Global Block Protection Unlock.

Based on initial work done by Anurag Kumar Vulisha:
https://patchwork.kernel.org/patch/7611271/

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 21 +++++++++++++++++++++
 include/linux/mtd/spi-nor.h   |  1 +
 2 files changed, 22 insertions(+)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index d9c368c..6648251 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -89,6 +89,7 @@ struct flash_info {
 #define NO_CHIP_ERASE		BIT(12) /* Chip does not support chip erase */
 #define SPI_NOR_SKIP_SFDP	BIT(13)	/* Skip parsing of SFDP tables */
 #define USE_CLSR		BIT(14)	/* use CLSR command */
+#define UNLOCK_GLOBAL_BLOCK	BIT(15)	/* Unlock global block protection */
 
 	int	(*quad_enable)(struct spi_nor *nor);
 };
@@ -2730,6 +2731,17 @@ static int spi_nor_setup(struct spi_nor *nor, const struct flash_info *info,
 	return 0;
 }
 
+static int spi_nor_unlock_global_block_protection(struct spi_nor *nor)
+{
+	int ret;
+
+	write_enable(nor);
+	ret = nor->write_reg(nor, SPINOR_OP_GBULK, NULL, 0);
+	if (ret < 0)
+		return ret;
+	return spi_nor_wait_till_ready(nor);
+}
+
 static int spi_nor_init(struct spi_nor *nor)
 {
 	int err;
@@ -2747,6 +2759,15 @@ static int spi_nor_init(struct spi_nor *nor)
 		spi_nor_wait_till_ready(nor);
 	}
 
+	if (nor->info->flags & UNLOCK_GLOBAL_BLOCK) {
+		err = spi_nor_unlock_global_block_protection(nor);
+		if (err) {
+			dev_err(nor->dev,
+				"Cannot unlock the global block protection\n");
+			return err;
+		}
+	}
+
 	if (nor->quad_enable) {
 		err = nor->quad_enable(nor);
 		if (err) {
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index e60da0d..e8dd11d 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -64,6 +64,7 @@
 #define SPINOR_OP_CLFSR		0x50	/* Clear flag status register */
 #define SPINOR_OP_RDEAR		0xc8	/* Read Extended Address Register */
 #define SPINOR_OP_WREAR		0xc5	/* Write Extended Address Register */
+#define SPINOR_OP_GBULK		0x98	/* Global Block Unlock Protection */
 
 /* 4-byte address opcodes - used on Spansion and some Macronix flashes. */
 #define SPINOR_OP_READ_4B	0x13	/* Read data bytes (low frequency) */
-- 
2.9.4
