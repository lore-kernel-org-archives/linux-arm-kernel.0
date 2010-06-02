From: leiwen@marvell.com (Lei Wen)
Date: Wed, 2 Jun 2010 21:50:25 +0800
Subject: [PATCH 02/25] pxa3xx_nand: introduce common timing to reduce
Message-ID: <mailman.4.1276839228.27306.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

read id times

We certainly don't need to send read id command times by times, since
we already know what the id is after the first read id...

So create a common timing which could ensure it would successfully read id
out all supported chip. Then follow the build-in table to reconfigure
the timing.

Signed-off-by: Lei Wen <leiwen@marvell.com>
Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/mtd/nand/pxa3xx_nand.c |   72 ++++++++++++++++-----------------------
 1 files changed, 30 insertions(+), 42 deletions(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 013e075..f939083 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -226,23 +226,26 @@ const static struct pxa3xx_nand_cmdset cmdset = {
 };

 static struct pxa3xx_nand_timing __devinitdata timing[] = {
+	/* common timing used to detect flash id */
+	{ 40, 80, 60, 100, 80, 100, 90000, 400, 40, },
 	/* Samsung NAND series */
-	{ 10,  0, 20, 40, 30, 40, 11123, 110, 10, },
+	{ 10,  0, 20,  40, 30,  40, 11123, 110, 10, },
 	/* Micron NAND series */
-	{ 10, 25, 15, 25, 15, 30, 25000,  60, 10, },
+	{ 10, 25, 15,  25, 15,  30, 25000,  60, 10, },
 	/* ST NAND series */
-	{ 10, 35, 15, 25, 15, 25, 25000,  60, 10, },
+	{ 10, 35, 15,  25, 15,  25, 25000,  60, 10, },
 };

 static struct pxa3xx_nand_flash __devinitdata builtin_flash_types[] = {
-	{ 0x46ec,  32,  512, 16, 16, 4096, &timing[0], },
-	{ 0xdaec,  64, 2048,  8,  8, 2048, &timing[0], },
-	{ 0xd7ec, 128, 4096,  8,  8, 8192, &timing[0], },
-	{ 0xa12c,  64, 2048,  8,  8, 1024, &timing[1], },
-	{ 0xb12c,  64, 2048, 16, 16, 1024, &timing[1], },
-	{ 0xdc2c,  64, 2048,  8,  8, 4096, &timing[1], },
-	{ 0xcc2c,  64, 2048, 16, 16, 4096, &timing[1], },
-	{ 0xba20,  64, 2048, 16, 16, 2048, &timing[2], },
+	{      0,   0,    0,  0,  0,    0, &timing[0], },
+	{ 0x46ec,  32,  512, 16, 16, 4096, &timing[1], },
+	{ 0xdaec,  64, 2048,  8,  8, 2048, &timing[1], },
+	{ 0xd7ec, 128, 4096,  8,  8, 8192, &timing[1], },
+	{ 0xa12c,  64, 2048,  8,  8, 1024, &timing[2], },
+	{ 0xb12c,  64, 2048, 16, 16, 1024, &timing[2], },
+	{ 0xdc2c,  64, 2048,  8,  8, 4096, &timing[2], },
+	{ 0xcc2c,  64, 2048, 16, 16, 4096, &timing[2], },
+	{ 0xba20,  64, 2048, 16, 16, 2048, &timing[3], },
 };

 #define NDTR0_tCH(c)	(min((c), 7) << 19)
@@ -859,12 +862,6 @@ static int pxa3xx_nand_config_flash(struct
pxa3xx_nand_info *info,
 	struct pxa3xx_nand_platform_data *pdata = pdev->dev.platform_data;
 	uint32_t ndcr = 0x00000FFF; /* disable all interrupts */

-	if (f->page_size != 2048 && f->page_size != 512)
-		return -EINVAL;
-
-	if (f->flash_width != 16 && f->flash_width != 8)
-		return -EINVAL;
-
 	/* calculate flash information */
 	info->oob_size = (f->page_size == 2048) ? 64 : 16;
 	info->read_id_bytes = (f->page_size == 2048) ? 4 : 2;
@@ -976,36 +973,27 @@ static int pxa3xx_nand_detect_flash(struct
pxa3xx_nand_info *info,
 		if (pxa3xx_nand_detect_config(info) == 0)
 			return 0;

-	for (i = 0; i<pdata->num_flash; ++i) {
-		f = pdata->flash + i;
-
-		if (pxa3xx_nand_config_flash(info, f))
-			continue;
-
-		if (__readid(info, &id))
-			continue;
-
-		if (id == f->chip_id)
-			return 0;
-	}
-
-	for (i = 0; i < ARRAY_SIZE(builtin_flash_types); i++) {
-
-		f = &builtin_flash_types[i];
-
-		if (pxa3xx_nand_config_flash(info, f))
-			continue;
-
-		if (__readid(info, &id))
-			continue;
-
-		if (id == f->chip_id)
+	f = &builtin_flash_types[0];
+	pxa3xx_nand_config_flash(info, f);
+	if (__readid(info, &id))
+		goto fail_detect;
+
+	for (i=0; i<ARRAY_SIZE(builtin_flash_types) + pdata->num_flash - 1; i++) {
+		if (i < pdata->num_flash)
+			f = pdata->flash + i;
+		else
+			f = &builtin_flash_types[i - pdata->num_flash + 1];
+		if (f->chip_id == id) {
+			dev_info(&info->pdev->dev, "detect chip id: 0x%x\n", id);
+			pxa3xx_nand_config_flash(info, f);
 			return 0;
+		}
 	}

 	dev_warn(&info->pdev->dev,
-		 "failed to detect configured nand flash; found %04x instead of\n",
+			"failed to detect configured nand flash; found %04x instead of\n",
 		 id);
+fail_detect:
 	return -ENODEV;
 }

-- 
1.7.0.4
