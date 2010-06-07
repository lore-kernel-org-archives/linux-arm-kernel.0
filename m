From: leiwen@marvell.com (Lei Wen)
Date: Mon, 7 Jun 2010 09:24:11 +0800
Subject: [PATCH 18/25] pxa3xx_nand: add ext id to distinguish
Message-ID: <mailman.36.1276839542.27306.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

different flash with the same chip id

For K9LBG08U0M and K9LBG08UXD two nand chip, they have the same chip id as
0xd7ec. So we should use the ext id to distinguish them.

Signed-off-by: Lei Wen <leiwen@marvell.com>
---
 drivers/mtd/nand/pxa3xx_nand.c |   35 ++++++++++++++++++-----------------
 1 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 67acea4..e4ccf7c 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -188,7 +188,8 @@ struct pxa3xx_nand_cmdset {

 struct pxa3xx_nand_flash {
 	char		*name;
-	uint32_t	chip_id;
+	uint16_t	chip_id;
+	uint16_t	ext_id;
 	uint16_t	page_per_block; /* Pages per block */
 	uint16_t 	page_size;	/* Page size in bytes */
 	uint8_t		flash_width;	/* Width of Flash memory (DWIDTH_M) */
@@ -292,17 +293,17 @@ static struct pxa3xx_nand_timing __devinitdata
timing[] = {
 };

 static struct pxa3xx_nand_flash __devinitdata builtin_flash_types[] = {
-{ 		0,	0,   0,    0,  0,  0, ECC_NONE,      0, &timing[0], },
-{ "64MiB 16-bit",  0x46ec,  32,  512, 16, 16, ECC_HAMMIN, 4096, &timing[1], },
-{ "256MiB 8-bit",  0xdaec,  64, 2048,  8,  8, ECC_HAMMIN, 2048, &timing[1], },
-{ "1GiB 8-bit",    0xd3ec, 128, 2048,  8,  8, ECC_BCH,    4096, &timing[1], },
-{ "4GiB 8-bit",    0xd7ec, 128, 4096,  8,  8, ECC_BCH,    8192, &timing[1], },
-{ "128MiB 8-bit",  0xa12c,  64, 2048,  8,  8, ECC_HAMMIN, 1024, &timing[2], },
-{ "128MiB 16-bit", 0xb12c,  64, 2048, 16, 16, ECC_HAMMIN, 1024, &timing[2], },
-{ "512MiB 8-bit",  0xdc2c,  64, 2048,  8,  8, ECC_HAMMIN, 4096, &timing[2], },
-{ "512MiB 16-bit", 0xcc2c,  64, 2048, 16, 16, ECC_HAMMIN, 4096, &timing[2], },
-{ "1GiB 8-bit",    0x382c, 128, 4096,  8,  8, ECC_BCH,    2048, &timing[2], },
-{ "256MiB 16-bit", 0xba20,  64, 2048, 16, 16, ECC_HAMMIN, 2048, &timing[3], },
+{ 		0,	0,	0,   0,	   0,  0,  0, ECC_NONE,      0, &timing[0], },
+{ "64MiB 16-bit",  0x46ec, 0xffff,  32,  512, 16, 16, ECC_HAMMIN,
4096, &timing[1], },
+{ "256MiB 8-bit",  0xdaec, 0xffff,  64, 2048,  8,  8, ECC_HAMMIN,
2048, &timing[1], },
+{ "1GiB 8-bit",    0xd3ec, 0xffff, 128, 2048,  8,  8, ECC_BCH,
4096, &timing[1], },
+{ "4GiB 8-bit",    0xd7ec, 0x29d5, 128, 4096,  8,  8, ECC_BCH,
8192, &timing[1], },
+{ "128MiB 8-bit",  0xa12c, 0xffff,  64, 2048,  8,  8, ECC_HAMMIN,
1024, &timing[2], },
+{ "128MiB 16-bit", 0xb12c, 0xffff,  64, 2048, 16, 16, ECC_HAMMIN,
1024, &timing[2], },
+{ "512MiB 8-bit",  0xdc2c, 0xffff,  64, 2048,  8,  8, ECC_HAMMIN,
4096, &timing[2], },
+{ "512MiB 16-bit", 0xcc2c, 0xffff,  64, 2048, 16, 16, ECC_HAMMIN,
4096, &timing[2], },
+{ "1GiB 8-bit",    0x382c, 0xffff, 128, 4096,  8,  8, ECC_BCH,
2048, &timing[2], },
+{ "256MiB 16-bit", 0xba20, 0xffff,  64, 2048, 16, 16, ECC_HAMMIN,
2048, &timing[3], },
 };

 static const char *mtd_names[] = {"pxa3xx_nand-0", "pxa3xx_nand-1", NULL};
@@ -1237,7 +1238,7 @@ static int __devinit pxa3xx_nand_scan(struct
mtd_info *mtd)
 	struct nand_flash_dev pxa3xx_flash_ids[2] = {{NULL,}, {NULL,}};
 	const struct pxa3xx_nand_flash *f = NULL;
 	struct nand_chip *chip = mtd->priv;
-	uint32_t id = -1;
+	uint16_t id[2];
 	uint64_t chipsize;
 	int i, ret;

@@ -1253,10 +1254,10 @@ static int __devinit pxa3xx_nand_scan(struct
mtd_info *mtd)
 		return -EINVAL;
 	}

-	nand->data_buff = (unsigned char *)&id;
+	nand->data_buff = (unsigned char *)id;
 	chip->cmdfunc(mtd, NAND_CMD_READID, 0, 0);
-	if (id != 0)
-		dev_info(&nand->pdev->dev, "Detect a flash id %x\n", id);
+	if (id[0] != 0)
+		dev_info(&nand->pdev->dev, "Detect a flash id %x\n", id[0]);
 	else {
 		dev_warn(&nand->pdev->dev, "Read out ID 0, potential timing set wrong!!\n");
 		free_cs_resource(info, nand->chip_select);
@@ -1270,7 +1271,7 @@ static int __devinit pxa3xx_nand_scan(struct
mtd_info *mtd)
 			f = &builtin_flash_types[i - pdata->num_flash + 1];

 		/* find the chip in default list */
-		if (f->chip_id == id)
+		if ((f->chip_id == id[0]) && ((f->ext_id & id[1]) == id[1]))
 			break;
 	}

-- 
1.7.0.4
