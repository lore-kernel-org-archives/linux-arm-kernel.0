From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 25 Mar 2014 08:19:49 +0000
Subject: [RFC 32/47] mtd: nand: stm_nand_bch: scan for BBMs and build
 memory-resident BBT
In-Reply-To: <1395735604-26706-1-git-send-email-lee.jones@linaro.org>
References: <1395735604-26706-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1395735604-26706-33-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If at start-up time we can't find our own pre-built memory-resident BBT
(e.g. at first run) this routine will search for factory set BBMs and
duplicate them into our own BBT for local consumption.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/nand/stm_nand_bch.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/mtd/nand/stm_nand_bch.c b/drivers/mtd/nand/stm_nand_bch.c
index 29eeee8..d7d97720 100644
--- a/drivers/mtd/nand/stm_nand_bch.c
+++ b/drivers/mtd/nand/stm_nand_bch.c
@@ -703,6 +703,33 @@ static int nandi_scan_bad_block_markers_block(struct nandi_controller *nandi,
 	return 0;
 }
 
+/* Scan for BBMs and build memory-resident BBT */
+static int nandi_scan_build_bbt(struct nandi_controller *nandi,
+				struct nandi_bbt_info *bbt_info)
+{
+	struct mtd_info *mtd = &nandi->info.mtd;
+	struct nand_chip *chip = mtd->priv;
+	uint32_t page_size = mtd->writesize;
+	uint8_t *bbt = bbt_info->bbt;
+	uint32_t block;
+
+	dev_dbg(nandi->dev,
+		"scan device for bad-block markers [bbt options = 0x%02x]\n",
+		chip->bbt_options);
+
+	memset(bbt, 0xff, page_size);
+	bbt_info->bbt_vers[0] = 0;
+	bbt_info->bbt_vers[1] = 0;
+	bbt_info->bbt_block[0] = nandi->blocks_per_device - 1;
+	bbt_info->bbt_block[1] = nandi->blocks_per_device - 2;
+
+	for (block = 0; block < nandi->blocks_per_device; block++)
+		if (nandi_scan_bad_block_markers_block(nandi, block))
+			bbt_set_block_mark(bbt, block, BBT_MARK_BAD_FACTORY);
+
+	return 0;
+}
+
 /* Populate IBBT BCH Header */
 static void bch_fill_ibbt_header(struct nandi_controller *nandi,
 				 struct nand_ibbt_bch_header *ibbt_header,
-- 
1.8.3.2
