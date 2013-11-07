From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu,  7 Nov 2013 12:17:17 -0300
Subject: [PATCH v4 13/31] mtd: nand: pxa3xx: Replace host->page_size by
 mtd->writesize
In-Reply-To: <1383837455-30721-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1383837455-30721-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1383837455-30721-14-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There's no need to privately store the device page size as it's
available in mtd structure field mtd->writesize.
Also, this removes the hardcoded page size value, leaving the
auto-detected value only.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/mtd/nand/pxa3xx_nand.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 6a69deb..dd8a7cf 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -151,7 +151,6 @@ struct pxa3xx_nand_host {
 	void			*info_data;
 
 	/* page size of attached chip */
-	unsigned int		page_size;
 	int			use_ecc;
 	int			cs;
 
@@ -614,12 +613,12 @@ static int prepare_command_pool(struct pxa3xx_nand_info *info, int command,
 			info->buf_start += mtd->writesize;
 
 		/* Second command setting for large pages */
-		if (host->page_size >= PAGE_CHUNK_SIZE)
+		if (mtd->writesize >= PAGE_CHUNK_SIZE)
 			info->ndcb0 |= NDCB0_DBC | (NAND_CMD_READSTART << 8);
 
 	case NAND_CMD_SEQIN:
 		/* small page addr setting */
-		if (unlikely(host->page_size < PAGE_CHUNK_SIZE)) {
+		if (unlikely(mtd->writesize < PAGE_CHUNK_SIZE)) {
 			info->ndcb1 = ((page_addr & 0xFFFFFF) << 8)
 					| (column & 0xFF);
 
@@ -895,7 +894,6 @@ static int pxa3xx_nand_config_flash(struct pxa3xx_nand_info *info,
 	}
 
 	/* calculate flash information */
-	host->page_size = f->page_size;
 	host->read_id_bytes = (f->page_size == 2048) ? 4 : 2;
 
 	/* calculate addressing information */
@@ -934,11 +932,9 @@ static int pxa3xx_nand_detect_config(struct pxa3xx_nand_info *info)
 	if (ndcr & NDCR_PAGE_SZ) {
 		/* Controller's FIFO size */
 		info->fifo_size = 2048;
-		host->page_size = 2048;
 		host->read_id_bytes = 4;
 	} else {
 		info->fifo_size = 512;
-		host->page_size = 512;
 		host->read_id_bytes = 2;
 	}
 
@@ -1106,7 +1102,7 @@ static int pxa3xx_nand_scan(struct mtd_info *mtd)
 	def = pxa3xx_flash_ids;
 KEEP_CONFIG:
 	chip->ecc.mode = NAND_ECC_HW;
-	chip->ecc.size = host->page_size;
+	chip->ecc.size = info->fifo_size;
 	chip->ecc.strength = 1;
 
 	if (info->reg_ndcr & NDCR_DWIDTH_M)
-- 
1.8.1.5
