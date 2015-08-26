From: ranjit.waghmode@xilinx.com (Ranjit Waghmode)
Date: Wed, 26 Aug 2015 11:56:06 +0530
Subject: [LINUX RFC v2 3/4] spi-nor: add dual parallel mode support
In-Reply-To: <1440570367-22569-1-git-send-email-ranjit.waghmode@xilinx.com>
References: <1440570367-22569-1-git-send-email-ranjit.waghmode@xilinx.com>
Message-ID: <1440570367-22569-4-git-send-email-ranjit.waghmode@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for dual parallel configuration by:

- Adding required parameters like isparallel and shift to spi_nor structure.
- Initializing all added parameters in spi_nor_scan()
- Updating read_sr() and read_fsr() for getting status of both flashes
- Increasing page_size, sector_size, erase_size and toatal flash size
  as and when required.
- Dividing address by 2
- Updating spi->master->flags for qspi driver to change CS

Signed-off-by: Ranjit Waghmode <ranjit.waghmode@xilinx.com>
---
V2 Changes:
Splitted to separate MTD layer changes from SPI core changes
---
 drivers/mtd/spi-nor/spi-nor.c | 91 ++++++++++++++++++++++++++++++++++---------
 include/linux/mtd/spi-nor.h   |  2 +
 2 files changed, 74 insertions(+), 19 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index d78831b..6a2e80b 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -22,6 +22,7 @@
 #include <linux/of_platform.h>
 #include <linux/spi/flash.h>
 #include <linux/mtd/spi-nor.h>
+#include <linux/spi/spi.h>

 /* Define max times to check status register before we give up. */
 #define	MAX_READY_WAIT_JIFFIES	(40 * HZ) /* M25P16 specs 40s max chip erase */
@@ -69,15 +70,24 @@ static const struct spi_device_id *spi_nor_match_id(const char *name);
 static int read_sr(struct spi_nor *nor)
 {
 	int ret;
-	u8 val;
+	u8 val[2];

-	ret = nor->read_reg(nor, SPINOR_OP_RDSR, &val, 1);
-	if (ret < 0) {
-		pr_err("error %d reading SR\n", (int) ret);
-		return ret;
+	if (nor->isparallel) {
+		ret = nor->read_reg(nor, SPINOR_OP_RDSR, &val[0], 2);
+		if (ret < 0) {
+			pr_err("error %d reading SR\n", (int) ret);
+			return ret;
+		}
+		val[0] |= val[1];
+	} else {
+		ret = nor->read_reg(nor, SPINOR_OP_RDSR, &val[0], 1);
+		if (ret < 0) {
+			pr_err("error %d reading SR\n", (int) ret);
+			return ret;
+		}
 	}

-	return val;
+	return val[0];
 }

 /*
@@ -87,16 +97,24 @@ static int read_sr(struct spi_nor *nor)
  */
 static int read_fsr(struct spi_nor *nor)
 {
-	int ret;
-	u8 val;
+	int ret, size;
+	u8 val[2];
+
+	size = 1;
+	val[1] = 0xff;
+
+	if (nor->isparallel)
+		size = 2;

-	ret = nor->read_reg(nor, SPINOR_OP_RDFSR, &val, 1);
+	ret = nor->read_reg(nor, SPINOR_OP_RDFSR, &val[0], size);
 	if (ret < 0) {
 		pr_err("error %d reading FSR\n", ret);
 		return ret;
 	}

-	return val;
+	val[0] &= val[1];
+
+	return val[0];
 }

 /*
@@ -317,6 +335,9 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
 	if (ret)
 		return ret;

+	if (nor->isparallel)
+		nor->spi->master->flags |= SPI_MASTER_DATA_STRIPE;
+
 	/* whole-chip erase? */
 	if (len == mtd->size) {
 		write_enable(nor);
@@ -340,6 +361,8 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
 		while (len) {
 			write_enable(nor);

+			addr = addr >> nor->shift;
+
 			if (nor->erase(nor, addr)) {
 				ret = -EIO;
 				goto erase_err;
@@ -360,19 +383,22 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)

 	instr->state = MTD_ERASE_DONE;
 	mtd_erase_callback(instr);
-
+	if (nor->isparallel)
+		nor->spi->master->flags &= ~SPI_MASTER_DATA_STRIPE;
 	return ret;

 erase_err:
 	spi_nor_unlock_and_unprep(nor, SPI_NOR_OPS_ERASE);
 	instr->state = MTD_ERASE_FAILED;
+	if (nor->isparallel)
+		nor->spi->master->flags &= ~SPI_MASTER_DATA_STRIPE;
 	return ret;
 }

 static int stm_lock(struct spi_nor *nor, loff_t ofs, uint64_t len)
 {
 	struct mtd_info *mtd = nor->mtd;
-	uint32_t offset = ofs;
+	uint32_t offset = ofs >> nor->shift;
 	uint8_t status_old, status_new;
 	int ret = 0;

@@ -406,7 +432,7 @@ static int stm_lock(struct spi_nor *nor, loff_t ofs, uint64_t len)
 static int stm_unlock(struct spi_nor *nor, loff_t ofs, uint64_t len)
 {
 	struct mtd_info *mtd = nor->mtd;
-	uint32_t offset = ofs;
+	uint32_t offset = ofs >> nor->shift;
 	uint8_t status_old, status_new;
 	int ret = 0;

@@ -446,6 +472,8 @@ static int spi_nor_lock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
 	if (ret)
 		return ret;

+	ofs = ofs >> nor->shift;
+
 	ret = nor->flash_lock(nor, ofs, len);

 	spi_nor_unlock_and_unprep(nor, SPI_NOR_OPS_UNLOCK);
@@ -461,6 +489,8 @@ static int spi_nor_unlock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
 	if (ret)
 		return ret;

+	ofs = ofs >> nor->shift;
+
 	ret = nor->flash_unlock(nor, ofs, len);

 	spi_nor_unlock_and_unprep(nor, SPI_NOR_OPS_LOCK);
@@ -738,7 +768,13 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
 	if (ret)
 		return ret;

-	ret = nor->read(nor, from, len, retlen, buf);
+	if (nor->isparallel)
+		nor->spi->master->flags |= SPI_MASTER_DATA_STRIPE;
+
+	ret = nor->read(nor, from >> nor->shift, len, retlen, buf);
+
+	if (nor->isparallel)
+		nor->spi->master->flags &= ~SPI_MASTER_DATA_STRIPE;

 	spi_nor_unlock_and_unprep(nor, SPI_NOR_OPS_READ);
 	return ret;
@@ -834,11 +870,11 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,

 	/* do all the bytes fit onto one page? */
 	if (page_offset + len <= nor->page_size) {
-		nor->write(nor, to, len, retlen, buf);
+		nor->write(nor, to >> nor->shift, len, retlen, buf);
 	} else {
 		/* the size of data remaining on the first page */
 		page_size = nor->page_size - page_offset;
-		nor->write(nor, to, page_size, retlen, buf);
+		nor->write(nor, to >> nor->shift, page_size, retlen, buf);

 		/* write everything in nor->page_size chunks */
 		for (i = page_size; i < len; i += page_size) {
@@ -852,12 +888,15 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,

 			write_enable(nor);

-			nor->write(nor, to + i, page_size, retlen, buf + i);
+			nor->write(nor, (to + i) >> nor->shift, page_size,
+					retlen, buf + i);
 		}
 	}

 	ret = spi_nor_wait_till_ready(nor);
 write_err:
+	if (nor->isparallel)
+		nor->spi->master->flags &= ~SPI_MASTER_DATA_STRIPE;
 	spi_nor_unlock_and_unprep(nor, SPI_NOR_OPS_WRITE);
 	return ret;
 }
@@ -1073,6 +1112,20 @@ int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
 	mtd->_erase = spi_nor_erase;
 	mtd->_read = spi_nor_read;

+#ifdef CONFIG_OF
+	struct device_node *np_spi = of_get_next_parent(np);
+	u32 is_dual;
+
+	if (of_property_read_u32(np_spi, "is-dual", &is_dual) > 0) {
+		nor->shift = 1;
+		info->sector_size <<= nor->shift;
+		info->page_size <<= nor->shift;
+		mtd->size <<= nor->shift;
+		nor->isparallel = 1;
+		nor->spi->master->flags |= SPI_MASTER_BOTH_CS;
+	}
+#endif
+
 	/* nor protection support for STmicro chips */
 	if (JEDEC_MFR(info) == CFI_MFR_ST) {
 		nor->flash_lock = stm_lock;
@@ -1097,10 +1150,10 @@ int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
 	/* prefer "small sector" erase if possible */
 	if (info->flags & SECT_4K) {
 		nor->erase_opcode = SPINOR_OP_BE_4K;
-		mtd->erasesize = 4096;
+		mtd->erasesize = 4096 << nor->shift;
 	} else if (info->flags & SECT_4K_PMC) {
 		nor->erase_opcode = SPINOR_OP_BE_4K_PMC;
-		mtd->erasesize = 4096;
+		mtd->erasesize = 4096 << nor->shift;
 	} else
 #endif
 	{
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 1705dc3..6ef25a8 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -171,6 +171,8 @@ struct spi_nor {
 	u8			read_dummy;
 	u8			program_opcode;
 	enum read_mode		flash_read;
+	bool			shift;
+	bool			isparallel;
 	bool			sst_write_second;
 	u32			flags;
 	struct spi_nor_xfer_cfg	cfg;
--
2.1.2
