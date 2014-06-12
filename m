From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Thu, 12 Jun 2014 15:20:43 +0200
Subject: [PATCHv4 3/5] mtd: gpmi: make blockmark swapping optional
In-Reply-To: <1402579245-13377-3-git-send-email-LW@KARO-electronics.de>
References: <1402579245-13377-1-git-send-email-LW@KARO-electronics.de>
 <1402579245-13377-2-git-send-email-LW@KARO-electronics.de>
 <1402579245-13377-3-git-send-email-LW@KARO-electronics.de>
Message-ID: <1402579245-13377-4-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With a flash-based BBT there is no reason to move the Factory Bad
Block Marker from the data area buffer (to where it is mapped by the
GPMI NAND controller) to the OOB buffer. Thus, make this feature
configurable via DT. This is required for the Ka-Ro electronics
platforms.

In the original code 'this->swap_block_mark' was synonymous with
'!GPMI_IS_MX23()', so use the latter at the relevant places.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 .../devicetree/bindings/mtd/gpmi-nand.txt          |   10 ++++
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c             |   51 ++++++++++++--------
 2 files changed, 42 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/gpmi-nand.txt b/Documentation/devicetree/bindings/mtd/gpmi-nand.txt
index 458d596..a011fdf 100644
--- a/Documentation/devicetree/bindings/mtd/gpmi-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/gpmi-nand.txt
@@ -25,6 +25,16 @@ Optional properties:
                        discoverable or this property is not enabled,
                        the software may chooses an implementation-defined
                        ECC scheme.
+  - fsl,no-blockmark-swap: Don't swap the bad block marker from the OOB
+                       area with the byte in the data area but rely on the
+                       flash based BBT for identifying bad blocks.
+                       NOTE: this is only valid in conjunction with
+                             'nand-on-flash-bbt'.
+                       WARNING: on i.MX28 blockmark swapping cannot be
+                       disabled for the BootROM in the FCB. Thus,
+                       partitions written from Linux with this feature
+                       turned on may not be accessible by the BootROM
+                       code.
 
 The device tree may optionally contain sub-nodes describing partitions of the
 address space. See partition.txt for more detail.
diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
index 16a533a..959cb9b 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
@@ -1081,6 +1081,7 @@ static int gpmi_ecc_read_subpage(struct mtd_info *mtd, struct nand_chip *chip,
 	int first, last, marker_pos;
 	int ecc_parity_size;
 	int col = 0;
+	int old_swap_block_mark = this->swap_block_mark;
 
 	/* The size of ECC parity */
 	ecc_parity_size = geo->gf_len * geo->ecc_strength / 8;
@@ -1089,17 +1090,21 @@ static int gpmi_ecc_read_subpage(struct mtd_info *mtd, struct nand_chip *chip,
 	first = offs / size;
 	last = (offs + len - 1) / size;
 
-	/*
-	 * Find the chunk which contains the Block Marker. If this chunk is
-	 * in the range of [first, last], we have to read out the whole page.
-	 * Why? since we had swapped the data at the position of Block Marker
-	 * to the metadata which is bound with the chunk 0.
-	 */
-	marker_pos = geo->block_mark_byte_offset / size;
-	if (last >= marker_pos && first <= marker_pos) {
-		dev_dbg(this->dev, "page:%d, first:%d, last:%d, marker at:%d\n",
+	if (this->swap_block_mark) {
+		/*
+		 * Find the chunk which contains the Block Marker.
+		 * If this chunk is in the range of [first, last],
+		 * we have to read out the whole page.
+		 * Why? since we had swapped the data at the position of Block
+		 * Marker to the metadata which is bound with the chunk 0.
+		 */
+		marker_pos = geo->block_mark_byte_offset / size;
+		if (last >= marker_pos && first <= marker_pos) {
+			dev_dbg(this->dev,
+				"page:%d, first:%d, last:%d, marker at:%d\n",
 				page, first, last, marker_pos);
-		return gpmi_ecc_read_page(mtd, chip, buf, 0, page);
+			return gpmi_ecc_read_page(mtd, chip, buf, 0, page);
+		}
 	}
 
 	meta = geo->metadata_size;
@@ -1145,7 +1150,7 @@ static int gpmi_ecc_read_subpage(struct mtd_info *mtd, struct nand_chip *chip,
 	writel(r1_old, bch_regs + HW_BCH_FLASH0LAYOUT0);
 	writel(r2_old, bch_regs + HW_BCH_FLASH0LAYOUT1);
 	this->bch_geometry = old_geo;
-	this->swap_block_mark = true;
+	this->swap_block_mark = old_swap_block_mark;
 
 	return max_bitflips;
 }
@@ -1309,10 +1314,10 @@ static int gpmi_ecc_read_oob(struct mtd_info *mtd, struct nand_chip *chip,
 
 	/*
 	 * Now, we want to make sure the block mark is correct. In the
-	 * Swapping/Raw case, we already have it. Otherwise, we need to
-	 * explicitly read it.
+	 * non-transcribing case (!GPMI_IS_MX23()), we already have it.
+	 * Otherwise, we need to explicitly read it.
 	 */
-	if (!this->swap_block_mark) {
+	if (GPMI_IS_MX23(this)) {
 		/* Read the block mark into the first byte of the OOB buffer. */
 		chip->cmdfunc(mtd, NAND_CMD_READ0, 0, page);
 		chip->oob_poi[0] = chip->read_byte(mtd);
@@ -1353,7 +1358,7 @@ static int gpmi_block_markbad(struct mtd_info *mtd, loff_t ofs)
 	chipnr = (int)(ofs >> chip->chip_shift);
 	chip->select_chip(mtd, chipnr);
 
-	column = this->swap_block_mark ? mtd->writesize : 0;
+	column = !GPMI_IS_MX23(this) ? mtd->writesize : 0;
 
 	/* Write the block mark. */
 	block_mark = this->data_buffer_dma;
@@ -1649,9 +1654,6 @@ static int gpmi_init_last(struct gpmi_nand_data *this)
 	struct bch_geometry *bch_geo = &this->bch_geometry;
 	int ret;
 
-	/* Set up swap_block_mark, must be set before the gpmi_set_geometry() */
-	this->swap_block_mark = !GPMI_IS_MX23(this);
-
 	/* Set up the medium geometry */
 	ret = gpmi_set_geometry(this);
 	if (ret)
@@ -1715,9 +1717,20 @@ static int gpmi_nand_init(struct gpmi_nand_data *this)
 	chip->badblock_pattern	= &gpmi_bbt_descr;
 	chip->block_markbad	= gpmi_block_markbad;
 	chip->options		|= NAND_NO_SUBPAGE_WRITE;
-	if (of_get_nand_on_flash_bbt(this->dev->of_node))
+
+	/* Set up swap_block_mark, must be set before the gpmi_set_geometry() */
+	this->swap_block_mark = !GPMI_IS_MX23(this);
+
+	if (of_get_nand_on_flash_bbt(this->dev->of_node)) {
 		chip->bbt_options |= NAND_BBT_USE_FLASH | NAND_BBT_NO_OOB;
 
+		if (of_property_read_bool(this->dev->of_node,
+						"fsl,no-blockmark-swap"))
+			this->swap_block_mark = false;
+	}
+	dev_dbg(this->dev, "Blockmark swapping %sabled\n",
+		this->swap_block_mark ? "en" : "dis");
+
 	/*
 	 * Allocate a temporary DMA buffer for reading ID in the
 	 * nand_scan_ident().
-- 
1.7.10.4
