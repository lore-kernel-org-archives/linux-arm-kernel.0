From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 10 Dec 2015 09:00:07 +0100
Subject: [PATCH v4 23/58] mtd: nand: gpmi: use the mtd instance embedded in
 struct nand_chip
In-Reply-To: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1449734442-18672-24-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

struct nand_chip now embeds an mtd device. Make use of this mtd instance.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
Changes generated with the following coccinelle script

--->8---
virtual patch

@fix1@
identifier __chipfield, __mtdfield;
type __type;
@@
(
	__type {
		...
		struct nand_chip __chipfield;
		...
-		struct mtd_info __mtdfield;
		...
	};
|
	__type {
		...
-		struct mtd_info __mtdfield;
		...
		struct nand_chip __chipfield;
		...
	};
)

@fix2 depends on fix1@
identifier fix1.__chipfield, fix1.__mtdfield;
identifier __subfield;
type fix1.__type;
__type *__priv;
@@
(
-	__priv->__mtdfield.__subfield
+	nand_to_mtd(&__priv->__chipfield)->__subfield
|
-	&(__priv->__mtdfield)
+	nand_to_mtd(&__priv->__chipfield)
)
--->8---
---
 drivers/mtd/nand/gpmi-nand/gpmi-lib.c  |  2 +-
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c | 23 +++++++++++------------
 drivers/mtd/nand/gpmi-nand/gpmi-nand.h |  1 -
 3 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-lib.c b/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
index 43fa16b..0f68a99 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
@@ -919,7 +919,7 @@ static int enable_edo_mode(struct gpmi_nand_data *this, int mode)
 {
 	struct resources  *r = &this->resources;
 	struct nand_chip *nand = &this->nand;
-	struct mtd_info	 *mtd = &this->mtd;
+	struct mtd_info	 *mtd = nand_to_mtd(nand);
 	uint8_t *feature;
 	unsigned long rate;
 	int ret;
diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
index 802adb0..38b07c7 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
@@ -107,7 +107,7 @@ static irqreturn_t bch_irq(int irq, void *cookie)
 static inline int get_ecc_strength(struct gpmi_nand_data *this)
 {
 	struct bch_geometry *geo = &this->bch_geometry;
-	struct mtd_info	*mtd = &this->mtd;
+	struct mtd_info	*mtd = nand_to_mtd(&this->nand);
 	int ecc_strength;
 
 	ecc_strength = ((mtd->oobsize - geo->metadata_size) * 8)
@@ -139,8 +139,8 @@ static inline bool gpmi_check_ecc(struct gpmi_nand_data *this)
 static bool set_geometry_by_ecc_info(struct gpmi_nand_data *this)
 {
 	struct bch_geometry *geo = &this->bch_geometry;
-	struct mtd_info *mtd = &this->mtd;
-	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct nand_chip *chip = &this->nand;
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct nand_oobfree *of = gpmi_hw_ecclayout.oobfree;
 	unsigned int block_mark_bit_offset;
 
@@ -257,7 +257,7 @@ static bool set_geometry_by_ecc_info(struct gpmi_nand_data *this)
 static int legacy_set_geometry(struct gpmi_nand_data *this)
 {
 	struct bch_geometry *geo = &this->bch_geometry;
-	struct mtd_info *mtd = &this->mtd;
+	struct mtd_info *mtd = nand_to_mtd(&this->nand);
 	unsigned int metadata_size;
 	unsigned int status_size;
 	unsigned int block_mark_bit_offset;
@@ -804,7 +804,7 @@ static int gpmi_alloc_dma_buffer(struct gpmi_nand_data *this)
 {
 	struct bch_geometry *geo = &this->bch_geometry;
 	struct device *dev = this->dev;
-	struct mtd_info *mtd = &this->mtd;
+	struct mtd_info *mtd = nand_to_mtd(&this->nand);
 
 	/* [1] Allocate a command buffer. PAGE_SIZE is enough. */
 	this->cmd_buffer = kzalloc(PAGE_SIZE, GFP_DMA | GFP_KERNEL);
@@ -1600,8 +1600,8 @@ static int mx23_check_transcription_stamp(struct gpmi_nand_data *this)
 {
 	struct boot_rom_geometry *rom_geo = &this->rom_geometry;
 	struct device *dev = this->dev;
-	struct mtd_info *mtd = &this->mtd;
 	struct nand_chip *chip = &this->nand;
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	unsigned int search_area_size_in_strides;
 	unsigned int stride;
 	unsigned int page;
@@ -1655,8 +1655,8 @@ static int mx23_write_transcription_stamp(struct gpmi_nand_data *this)
 {
 	struct device *dev = this->dev;
 	struct boot_rom_geometry *rom_geo = &this->rom_geometry;
-	struct mtd_info *mtd = &this->mtd;
 	struct nand_chip *chip = &this->nand;
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	unsigned int block_size_in_pages;
 	unsigned int search_area_size_in_strides;
 	unsigned int search_area_size_in_pages;
@@ -1735,7 +1735,7 @@ static int mx23_boot_init(struct gpmi_nand_data  *this)
 {
 	struct device *dev = this->dev;
 	struct nand_chip *chip = &this->nand;
-	struct mtd_info *mtd = &this->mtd;
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	unsigned int block_count;
 	unsigned int block;
 	int     chipnr;
@@ -1831,14 +1831,13 @@ static int gpmi_set_geometry(struct gpmi_nand_data *this)
 
 static void gpmi_nand_exit(struct gpmi_nand_data *this)
 {
-	nand_release(&this->mtd);
+	nand_release(nand_to_mtd(&this->nand));
 	gpmi_free_dma_buffer(this);
 }
 
 static int gpmi_init_last(struct gpmi_nand_data *this)
 {
-	struct mtd_info *mtd = &this->mtd;
-	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct nand_chip *chip = &this->nand;
 	struct nand_ecc_ctrl *ecc = &chip->ecc;
 	struct bch_geometry *bch_geo = &this->bch_geometry;
 	int ret;
@@ -1886,8 +1885,8 @@ static int gpmi_init_last(struct gpmi_nand_data *this)
 
 static int gpmi_nand_init(struct gpmi_nand_data *this)
 {
-	struct mtd_info  *mtd = &this->mtd;
 	struct nand_chip *chip = &this->nand;
+	struct mtd_info  *mtd = nand_to_mtd(chip);
 	int ret;
 
 	/* init current chip */
diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.h b/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
index 544062f..4e49a1f 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
@@ -160,7 +160,6 @@ struct gpmi_nand_data {
 
 	/* MTD / NAND */
 	struct nand_chip	nand;
-	struct mtd_info		mtd;
 
 	/* General-use Variables */
 	int			current_chip;
-- 
2.1.4
