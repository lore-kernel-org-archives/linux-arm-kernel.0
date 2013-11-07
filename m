From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu,  7 Nov 2013 12:17:16 -0300
Subject: [PATCH v4 12/31] mtd: nand: pxa3xx: Split FIFO size from to-be-read
 FIFO count
In-Reply-To: <1383837455-30721-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1383837455-30721-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1383837455-30721-13-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce a fifo_size field to represent the size of the controller's
FIFO buffer, and use it to distinguish that size from the amount
of data bytes to be read from the FIFO.

This is important to support devices with pages larger than the
controller's internal FIFO, that need to read the pages in FIFO-sized
chunks.

In particular, the current code is at least confusing, for it mixes
all the different sizes involved: FIFO size, page size and data size.

This commit starts the cleaning by removing the info->page_size field
that is not currently used. The host->page_size field should also
be removed and use always mtd->writesize instead. Follow up commits
will clean this up.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/mtd/nand/pxa3xx_nand.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index d153ba8..6a69deb 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -201,8 +201,8 @@ struct pxa3xx_nand_info {
 	int			use_spare;	/* use spare ? */
 	int			is_ready;
 
-	unsigned int		page_size;	/* page size of attached chip */
-	unsigned int		data_size;	/* data size in FIFO */
+	unsigned int		fifo_size;	/* max. data size in the FIFO */
+	unsigned int		data_size;	/* data to be read from FIFO */
 	unsigned int		oob_size;
 	int 			retcode;
 
@@ -307,16 +307,15 @@ static void pxa3xx_nand_set_timing(struct pxa3xx_nand_host *host,
 
 static void pxa3xx_set_datasize(struct pxa3xx_nand_info *info)
 {
-	struct pxa3xx_nand_host *host = info->host[info->cs];
 	int oob_enable = info->reg_ndcr & NDCR_SPARE_EN;
 
-	info->data_size = host->page_size;
+	info->data_size = info->fifo_size;
 	if (!oob_enable) {
 		info->oob_size = 0;
 		return;
 	}
 
-	switch (host->page_size) {
+	switch (info->fifo_size) {
 	case 2048:
 		info->oob_size = (info->use_ecc) ? 40 : 64;
 		break;
@@ -933,9 +932,12 @@ static int pxa3xx_nand_detect_config(struct pxa3xx_nand_info *info)
 	uint32_t ndcr = nand_readl(info, NDCR);
 
 	if (ndcr & NDCR_PAGE_SZ) {
+		/* Controller's FIFO size */
+		info->fifo_size = 2048;
 		host->page_size = 2048;
 		host->read_id_bytes = 4;
 	} else {
+		info->fifo_size = 512;
 		host->page_size = 512;
 		host->read_id_bytes = 2;
 	}
-- 
1.8.1.5
