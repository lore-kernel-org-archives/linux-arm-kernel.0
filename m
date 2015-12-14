From: ranjit.waghmode@xilinx.com (Ranjit Waghmode)
Date: Mon, 14 Dec 2015 18:39:44 +0530
Subject: [LINUX RFC v3 3/4] mtd: spi-nor: add dual parallel mode support
In-Reply-To: <1450098585-3129-1-git-send-email-ranjit.waghmode@xilinx.com>
References: <1450098585-3129-1-git-send-email-ranjit.waghmode@xilinx.com>
Message-ID: <1450098585-3129-4-git-send-email-ranjit.waghmode@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for dual parallel configuration mode by:

- Adding required parameters like isparallel and shift to spi_nor structure.
- Initializing all added parameters in spi_nor_scan()
- Updating read_sr() and read_fsr() for getting status from both flashes
- Increasing page_size, sector_size, erase_size and toatal flash size
  as and when required.
- Dividing address by 2
- Updating spi->master->flags for qspi driver to change CS

Signed-off-by: Ranjit Waghmode <ranjit.waghmode@xilinx.com>
---
V3 Changes:
	- No change in this patch
V2 Changes:
	- Splitted to separate MTD layer changes from SPI core changes
---

 drivers/mtd/spi-nor/spi-nor.c | 89 +++++++++++++++++++++++++++++++++++--------
 include/linux/mtd/spi-nor.h   |  2 +
 2 files changed, 75 insertions(+), 16 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 4988390..f7a6458 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -22,6 +22,7 @@
 #include <linux/of_platform.h>
 #include <linux/spi/flash.h>
 #include <linux/mtd/spi-nor.h>
+#include <linux/spi/spi.h>

 /* Define max times to check status register before we give up. */

@@ -82,15 +83,24 @@ static const struct flash_info *spi_nor_match_id(const char *name);
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
+	       ret = nor->read_reg(nor, SPINOR_OP_RDSR, &val[0], 2);
+		if (ret < 0) {
+			pr_err("error %d reading SR\n", (int) ret);
+			return ret;
+		}
+		val[0] |= val[1];
+       } else {
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
@@ -100,16 +110,24 @@ static int read_sr(struct spi_nor *nor)
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

-	ret = nor->read_reg(nor, SPINOR_OP_RDFSR, &val, 1);
+	if (nor->isparallel)
+	size = 2;
+
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
@@ -337,6 +355,9 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
 	if (ret)
 		return ret;

+	if (nor->isparallel)
+		nor->spi->master->flags |= SPI_MASTER_DATA_STRIPE;
+
 	/* whole-chip erase? */
 	if (len == mtd->size) {
 		unsigned long timeout;
@@ -371,6 +392,8 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
 		while (len) {
 			write_enable(nor);

+			addr = addr >> nor->shift;
+
 			if (nor->erase(nor, addr)) {
 				ret = -EIO;
 				goto erase_err;
@@ -392,11 +415,17 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
 	instr->state = MTD_ERASE_DONE;
 	mtd_erase_callback(instr);

+	if (nor->isparallel)
+		nor->spi->master->flags &= ~SPI_MASTER_DATA_STRIPE;
+
 	return ret;

 erase_err:
 	spi_nor_unlock_and_unprep(nor, SPI_NOR_OPS_ERASE);
 	instr->state = MTD_ERASE_FAILED;
+	if (nor->isparallel)
+		nor->spi->master->flags &= ~SPI_MASTER_DATA_STRIPE;
+
 	return ret;
 }

@@ -463,6 +492,8 @@ static int stm_lock(struct spi_nor *nor, loff_t ofs, uint64_t len)
 	u8 mask = SR_BP2 | SR_BP1 | SR_BP0;
 	u8 shift = ffs(mask) - 1, pow, val;

+	ofs = ofs >> nor->shift;
+
 	status_old = read_sr(nor);

 	/* SPI NOR always locks to the end */
@@ -513,6 +544,8 @@ static int stm_unlock(struct spi_nor *nor, loff_t ofs, uint64_t len)
 	u8 mask = SR_BP2 | SR_BP1 | SR_BP0;
 	u8 shift = ffs(mask) - 1, pow, val;

+	ofs = ofs >> nor->shift;
+
 	status_old = read_sr(nor);

 	/* Cannot unlock; would unlock larger region than requested */
@@ -576,6 +609,8 @@ static int spi_nor_lock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
 	if (ret)
 		return ret;

+	ofs = ofs >> nor->shift;
+
 	ret = nor->flash_lock(nor, ofs, len);

 	spi_nor_unlock_and_unprep(nor, SPI_NOR_OPS_UNLOCK);
@@ -591,6 +626,8 @@ static int spi_nor_unlock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
 	if (ret)
 		return ret;

+	ofs = ofs >> nor->shift;
+
 	ret = nor->flash_unlock(nor, ofs, len);

 	spi_nor_unlock_and_unprep(nor, SPI_NOR_OPS_LOCK);
@@ -884,7 +921,13 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
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
@@ -980,11 +1023,11 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,

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
@@ -998,7 +1041,8 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,

 			write_enable(nor);

-			nor->write(nor, to + i, page_size, retlen, buf + i);
+			nor->write(nor, (to + i) >> nor->shift, page_size,
+					retlen, buf + i);
 		}
 	}

@@ -1216,6 +1260,19 @@ int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
 	mtd->_erase = spi_nor_erase;
 	mtd->_read = spi_nor_read;

+#ifdef CONFIG_OF
+	struct device_node *np_spi = of_get_next_parent(np);
+	u32 is_dual;
+	if (of_property_read_u32(np_spi, "is-dual", &is_dual) > 0) {
+	       nor->shift = 1;
+	       info->sector_size <<= nor->shift;
+	       info->page_size <<= nor->shift;
+	       mtd->size <<= nor->shift;
+	       nor->isparallel = 1;
+	       nor->spi->master->flags |= SPI_MASTER_BOTH_CS;
+	}
+#endif
+
 	/* NOR protection support for STmicro/Micron chips and similar */
 	if (JEDEC_MFR(info) == SNOR_MFR_MICRON ||
 	    JEDEC_MFR(info) == SNOR_MFR_WINBOND) {
@@ -1243,10 +1300,10 @@ int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
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
index 872b2b4..145a2b9 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -164,6 +164,8 @@ struct spi_nor {
 	u8			read_dummy;
 	u8			program_opcode;
 	enum read_mode		flash_read;
+	bool                    shift;
+	bool                    isparallel;
 	bool			sst_write_second;
 	u32			flags;
 	u8			cmd_buf[SPI_NOR_MAX_CMD_SIZE];
--
2.1.2
