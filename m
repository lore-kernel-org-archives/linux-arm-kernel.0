From: josh.wu@atmel.com (Josh Wu)
Date: Wed, 23 Jan 2013 20:47:08 +0800
Subject: [PATCH 1/5] MTD: atmel_nand: avoid to report an error when lookup
 table offset is 0.
In-Reply-To: <1358945232-2282-1-git-send-email-josh.wu@atmel.com>
References: <1358945232-2282-1-git-send-email-josh.wu@atmel.com>
Message-ID: <1358945232-2282-2-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Before this patch, we assume the whole ROM code are mapping to memory. So
it is wrong if the lookup table offset is 0.

After this patch, we can map only the lookup table of ROM code to memory
intead of the whole ROM code (about 1M). In this case, one lookup table
offset can be 0.

Signed-off-by: Josh Wu <josh.wu@atmel.com>
---
 drivers/mtd/nand/atmel_nand.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
index c516a94..1d989db 100644
--- a/drivers/mtd/nand/atmel_nand.c
+++ b/drivers/mtd/nand/atmel_nand.c
@@ -1215,7 +1215,7 @@ static void atmel_nand_hwctl(struct mtd_info *mtd, int mode)
 static int atmel_of_init_port(struct atmel_nand_host *host,
 			      struct device_node *np)
 {
-	u32 val, table_offset;
+	u32 val;
 	u32 offset[2];
 	int ecc_mode;
 	struct atmel_nand_data *board = &host->board;
@@ -1288,13 +1288,12 @@ static int atmel_of_init_port(struct atmel_nand_host *host,
 		dev_err(host->dev, "Cannot get PMECC lookup table offset\n");
 		return -EINVAL;
 	}
-	table_offset = host->pmecc_sector_size == 512 ? offset[0] : offset[1];
-
-	if (!table_offset) {
+	if (!offset[0] && !offset[1]) {
 		dev_err(host->dev, "Invalid PMECC lookup table offset\n");
 		return -EINVAL;
 	}
-	host->pmecc_lookup_table_offset = table_offset;
+	host->pmecc_lookup_table_offset =
+		(host->pmecc_sector_size == 512) ? offset[0] : offset[1];
 
 	return 0;
 }
-- 
1.7.9.5
