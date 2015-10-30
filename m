From: anup.patel@broadcom.com (Anup Patel)
Date: Fri, 30 Oct 2015 12:29:19 +0530
Subject: [PATCH v5 1/3] mtd: brcmnand: factor out CFG and CFG_EXT bitfields
In-Reply-To: <1446188361-15146-1-git-send-email-anup.patel@broadcom.com>
References: <1446188361-15146-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1446188361-15146-2-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Brian Norris <computersforpeace@gmail.com>

Use enum instead of magic numbers for CFG and CFG_EXT bitfields.

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
Tested-by: Anup Patel <anup.patel@broadcom.com>
---
 drivers/mtd/nand/brcmnand/brcmnand.c | 38 +++++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/brcmnand/brcmnand.c b/drivers/mtd/nand/brcmnand/brcmnand.c
index 4cba03d..dda96fa 100644
--- a/drivers/mtd/nand/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/brcmnand/brcmnand.c
@@ -344,6 +344,28 @@ static const u8 brcmnand_cs_offsets_cs0[] = {
 	[BRCMNAND_CS_TIMING2]		= 0x14,
 };
 
+/*
+ * Bitfields for the CFG and CFG_EXT registers. Pre-v7.1 controllers only had
+ * one config register, but once the bitfields overflowed, newer controllers
+ * (v7.1 and newer) added a CFG_EXT register and shuffled a few fields around.
+ */
+enum {
+	CFG_BLK_ADR_BYTES_SHIFT		= 8,
+	CFG_COL_ADR_BYTES_SHIFT		= 12,
+	CFG_FUL_ADR_BYTES_SHIFT		= 16,
+	CFG_BUS_WIDTH_SHIFT		= 23,
+	CFG_BUS_WIDTH			= BIT(CFG_BUS_WIDTH_SHIFT),
+	CFG_DEVICE_SIZE_SHIFT		= 24,
+
+	/* Only for pre-v7.1 (with no CFG_EXT register) */
+	CFG_PAGE_SIZE_SHIFT		= 20,
+	CFG_BLK_SIZE_SHIFT		= 28,
+
+	/* Only for v7.1+ (with CFG_EXT register) */
+	CFG_EXT_PAGE_SIZE_SHIFT		= 0,
+	CFG_EXT_BLK_SIZE_SHIFT		= 4,
+};
+
 /* BRCMNAND_INTFC_STATUS */
 enum {
 	INTFC_FLASH_STATUS		= GENMASK(7, 0),
@@ -1720,17 +1742,19 @@ static int brcmnand_set_cfg(struct brcmnand_host *host,
 	}
 	device_size = fls64(cfg->device_size) - fls64(BRCMNAND_MIN_DEVSIZE);
 
-	tmp = (cfg->blk_adr_bytes << 8) |
-		(cfg->col_adr_bytes << 12) |
-		(cfg->ful_adr_bytes << 16) |
-		(!!(cfg->device_width == 16) << 23) |
-		(device_size << 24);
+	tmp = (cfg->blk_adr_bytes << CFG_BLK_ADR_BYTES_SHIFT) |
+		(cfg->col_adr_bytes << CFG_COL_ADR_BYTES_SHIFT) |
+		(cfg->ful_adr_bytes << CFG_FUL_ADR_BYTES_SHIFT) |
+		(!!(cfg->device_width == 16) << CFG_BUS_WIDTH_SHIFT) |
+		(device_size << CFG_DEVICE_SIZE_SHIFT);
 	if (cfg_offs == cfg_ext_offs) {
-		tmp |= (page_size << 20) | (block_size << 28);
+		tmp |= (page_size << CFG_PAGE_SIZE_SHIFT) |
+		       (block_size << CFG_BLK_SIZE_SHIFT);
 		nand_writereg(ctrl, cfg_offs, tmp);
 	} else {
 		nand_writereg(ctrl, cfg_offs, tmp);
-		tmp = page_size | (block_size << 4);
+		tmp = (page_size << CFG_EXT_PAGE_SIZE_SHIFT) |
+		      (block_size << CFG_EXT_BLK_SIZE_SHIFT);
 		nand_writereg(ctrl, cfg_ext_offs, tmp);
 	}
 
-- 
1.9.1
