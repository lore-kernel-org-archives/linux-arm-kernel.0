From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 30 Jul 2015 15:50:24 +0200
Subject: [RFC PATCH 5/6] mtd: nand: add infrastructure for per-partition ECC
 config
In-Reply-To: <1438264225-23796-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1438264225-23796-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1438264225-23796-6-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some SoCs require a different ECC config for their first stage bootloader,
but we cannot apply the same config on the whole flash, or we might have
to live an unsuitable ECC config (often weaker than what is required by
the NAND chip).

This patch makes use of the mtd_part_ops infrastructure to let the NAND
controller adjust the ECC config for each partition.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/nand_base.c | 152 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/mtd/nand.h     |  35 +++++++++-
 2 files changed, 186 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
index 67a29f5..9b027c6 100644
--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -4152,6 +4152,155 @@ static void nand_ecc_cleanup(struct mtd_info *mtd, struct nand_ecc_ctrl *ecc)
 		nand_bch_free((struct nand_bch_control *)ecc->priv);
 }
 
+static void nand_part_select(struct mtd_part *part)
+{
+	struct nand_chip *chip = part->master->priv;
+
+	if (chip->part_ops->select)
+		chip->part_ops->select(part);
+
+	chip->cur_part = part;
+}
+
+static void nand_part_deselect(struct mtd_info *mtd)
+{
+	struct nand_chip *chip = mtd->priv;
+
+	if (chip->part_ops->deselect)
+		chip->part_ops->deselect(chip->cur_part);
+
+	chip->cur_part = NULL;
+}
+
+static int nand_part_read(struct mtd_info *mtd, loff_t from, size_t len,
+			  size_t *retlen, u_char *buf)
+{
+	struct mtd_part *part = mtd_to_part(mtd);
+	struct mtd_ecc_stats stats;
+	struct mtd_oob_ops ops;
+	int ret;
+
+	nand_get_device(part->master, FL_READING);
+	stats = part->master->ecc_stats;
+
+	nand_part_select(part);
+	memset(&ops, 0, sizeof(ops));
+	ops.len = len;
+	ops.datbuf = buf;
+	ops.mode = MTD_OPS_PLACE_OOB;
+	ret = nand_do_read_ops(part->master, from + part->offset, &ops);
+	*retlen = ops.retlen;
+	nand_part_deselect(part->master);
+
+	if (unlikely(mtd_is_eccerr(ret)))
+		part->mtd.ecc_stats.failed +=
+			part->master->ecc_stats.failed - stats.failed;
+	else
+		part->mtd.ecc_stats.corrected +=
+			part->master->ecc_stats.corrected - stats.corrected;
+	nand_release_device(part->master);
+
+	return ret;
+}
+
+static int nand_part_write(struct mtd_info *mtd, loff_t to, size_t len,
+			   size_t *retlen, const u_char *buf)
+{
+	struct mtd_part *part = mtd_to_part(mtd);
+	struct mtd_oob_ops ops;
+	int ret;
+
+	nand_get_device(part->master, FL_WRITING);
+	nand_part_select(part);
+	memset(&ops, 0, sizeof(ops));
+	ops.len = len;
+	ops.datbuf = (uint8_t *)buf;
+	ops.mode = MTD_OPS_PLACE_OOB;
+	ret = nand_do_write_ops(part->master, to + part->offset, &ops);
+	*retlen = ops.retlen;
+	nand_part_deselect(part->master);
+	nand_release_device(part->master);
+	return ret;
+}
+
+static int panic_nand_part_write(struct mtd_info *mtd, loff_t to, size_t len,
+				 size_t *retlen, const uint8_t *buf)
+{
+	struct mtd_part *part = mtd_to_part(mtd);
+	struct nand_chip *chip = part->master->priv;
+	struct mtd_oob_ops ops;
+	int ret;
+
+	/* Wait for the device to get ready */
+	panic_nand_wait(part->master, chip, 400);
+
+	/* Grab the device */
+	panic_nand_get_device(chip, part->master, FL_WRITING);
+
+	memset(&ops, 0, sizeof(ops));
+	ops.len = len;
+	ops.datbuf = (uint8_t *)buf;
+	ops.mode = MTD_OPS_PLACE_OOB;
+
+	ret = nand_do_write_ops(part->master, to + part->offset, &ops);
+
+	*retlen = ops.retlen;
+	return ret;
+}
+
+static int nand_part_add(struct mtd_part *part)
+{
+	struct mtd_info *mtd = &part->mtd;
+	struct nand_chip *chip = part->master->priv;
+	struct nand_part *npart;
+	int ret;
+
+	npart = kzalloc(sizeof(*npart), GFP_KERNEL);
+	if (!npart)
+		return -ENOMEM;
+
+	mtd_part_set_priv(part, npart);
+	mtd->_read = nand_part_read;
+	mtd->_write = nand_part_write;
+	mtd->_panic_write = panic_nand_part_write;
+
+	if (chip->part_ops->add) {
+		ret = chip->part_ops->add(part);
+		if (ret) {
+			kfree(npart);
+			return ret;
+		}
+	}
+
+	if (npart->ecc)
+		nand_ecc_ctrl_init(&part->mtd, npart->ecc);
+	else
+		npart->ecc = &chip->ecc;
+
+	return 0;
+}
+
+static void nand_part_remove(struct mtd_part *part)
+{
+	struct nand_chip *chip = part->master->priv;
+	struct nand_part *npart = mtd_part_get_priv(part);
+
+	if (npart->ecc == &chip->ecc)
+		npart->ecc = NULL;
+	else
+		nand_ecc_cleanup(&part->mtd, npart->ecc);
+
+	if (chip->part_ops->remove)
+		chip->part_ops->remove(part);
+
+	kfree(part->mtd.priv);
+}
+
+static const struct mtd_part_ops nand_mtd_part_ops = {
+	.add = nand_part_add,
+	.remove = nand_part_remove,
+};
+
 /**
  * nand_scan_tail - [NAND Interface] Scan for the NAND device
  * @mtd: MTD device structure
@@ -4189,6 +4338,9 @@ int nand_scan_tail(struct mtd_info *mtd)
 	/* Set the internal oob buffer location, just after the page data */
 	chip->oob_poi = chip->buffers->databuf + mtd->writesize;
 
+	if (chip->part_ops)
+		mtd->part_ops = &nand_mtd_part_ops;
+
 	if (!chip->write_page)
 		chip->write_page = nand_write_page;
 
diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index 2a9b557..71b491d 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -538,6 +538,28 @@ struct nand_buffers {
 	uint8_t *databuf;
 };
 
+struct nand_part {
+	struct nand_ecc_ctrl *ecc;
+	void *priv;
+};
+
+static inline void *nand_part_get_priv(struct nand_part *part)
+{
+	return part->priv;
+}
+
+static inline void nand_part_set_priv(struct nand_part *part, void *priv)
+{
+	part->priv = priv;
+}
+
+struct nand_part_ops {
+	int (*add)(struct mtd_part *part);
+	void (*remove)(struct mtd_part *part);
+	void (*select)(struct mtd_part *part);
+	void (*deselect)(struct mtd_part *part);
+};
+
 /**
  * struct nand_chip - NAND Private Flash Chip Data
  * @IO_ADDR_R:		[BOARDSPECIFIC] address to read the 8 I/O lines of the
@@ -676,6 +698,7 @@ struct nand_chip {
 	int (*onfi_get_features)(struct mtd_info *mtd, struct nand_chip *chip,
 			int feature_addr, uint8_t *subfeature_para);
 	int (*setup_read_retry)(struct mtd_info *mtd, int retry_mode);
+	int (*select_part)(struct mtd_info *master, struct mtd_info *slave);
 
 	int chip_delay;
 	unsigned int options;
@@ -723,6 +746,9 @@ struct nand_chip {
 	struct nand_bbt_descr *badblock_pattern;
 
 	void *priv;
+
+	const struct nand_part_ops *part_ops;
+	struct mtd_part *cur_part;
 };
 
 /*
@@ -1033,6 +1059,13 @@ const struct nand_sdr_timings *onfi_async_timing_mode_to_sdr_timings(int mode);
 
 static inline struct nand_ecc_ctrl *nand_ecc(struct nand_chip *chip)
 {
-	return &chip->ecc;
+	struct nand_part *npart;
+
+	if (!chip->cur_part)
+		return &chip->ecc;
+
+	npart = chip->cur_part->mtd.priv;
+
+	return npart->ecc;
 }
 #endif /* __LINUX_MTD_NAND_H */
-- 
1.9.1
