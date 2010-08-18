From: leiwen@marvell.com (Lei Wen)
Date: Wed, 18 Aug 2010 18:00:03 +0800
Subject: [PATCH 3/5] pxa3xx_nand: introduce default timing to reduce
Message-ID: <mailman.201.1282142183.27306.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

read id times

We certainly don't need to send read id command times by times, since
we already know what the id is after the first read id...

So create a default timing which could ensure it would successfully read
id out all supported chip. Then follow the build-in table to reconfigure
the timing.

Signed-off-by: Lei Wen <leiwen@marvell.com>
Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/mtd/nand/pxa3xx_nand.c |   68 +++++++++++++++++++--------------------
 1 files changed, 33 insertions(+), 35 deletions(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 0b63f9c..8385e3a 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -190,22 +190,27 @@ static struct pxa3xx_nand_cmdset default_cmdset = {
 };

 static struct pxa3xx_nand_timing timing[] = {
-	{ 10,  0, 20, 40, 30, 40, 11123, 110, 10, },
-	{ 10, 25, 15, 25, 15, 30, 25000,  60, 10, },
-	{ 10, 35, 15, 25, 15, 25, 25000,  60, 10, },
+	{ 40, 80, 60, 100, 80, 100, 90000, 400, 40, },
+	{ 10,  0, 20,  40, 30,  40, 11123, 110, 10, },
+	{ 10, 25, 15,  25, 15,  30, 25000,  60, 10, },
+	{ 10, 35, 15,  25, 15,  25, 25000,  60, 10, },
 };

 static struct pxa3xx_nand_flash builtin_flash_types[] = {
-	{ 0x46ec,  32,  512, 16, 16, 4096, &default_cmdset, &timing[0] },
-	{ 0xdaec,  64, 2048,  8,  8, 2048, &default_cmdset, &timing[0] },
-	{ 0xd7ec, 128, 4096,  8,  8, 8192, &default_cmdset, &timing[0] },
-	{ 0xa12c,  64, 2048,  8,  8, 1024, &default_cmdset, &timing[1] },
-	{ 0xb12c,  64, 2048, 16, 16, 1024, &default_cmdset, &timing[1] },
-	{ 0xdc2c,  64, 2048,  8,  8, 4096, &default_cmdset, &timing[1] },
-	{ 0xcc2c,  64, 2048, 16, 16, 4096, &default_cmdset, &timing[1] },
-	{ 0xba20,  64, 2048, 16, 16, 2048, &default_cmdset, &timing[2] },
+	{      0,   0, 2048,  8,  8,    0, &default_cmdset, &timing[0] },
+	{ 0x46ec,  32,  512, 16, 16, 4096, &default_cmdset, &timing[1] },
+	{ 0xdaec,  64, 2048,  8,  8, 2048, &default_cmdset, &timing[1] },
+	{ 0xd7ec, 128, 4096,  8,  8, 8192, &default_cmdset, &timing[1] },
+	{ 0xa12c,  64, 2048,  8,  8, 1024, &default_cmdset, &timing[2] },
+	{ 0xb12c,  64, 2048, 16, 16, 1024, &default_cmdset, &timing[2] },
+	{ 0xdc2c,  64, 2048,  8,  8, 4096, &default_cmdset, &timing[2] },
+	{ 0xcc2c,  64, 2048, 16, 16, 4096, &default_cmdset, &timing[2] },
+	{ 0xba20,  64, 2048, 16, 16, 2048, &default_cmdset, &timing[3] },
 };

+/* Define a default flash type setting serve as flash detecting only */
+#define DEFAULT_FLASH_TYPE (&builtin_flash_types[0])
+
 #define NDTR0_tCH(c)	(min((c), 7) << 19)
 #define NDTR0_tCS(c)	(min((c), 7) << 16)
 #define NDTR0_tWH(c)	(min((c), 7) << 11)
@@ -945,36 +950,29 @@ static int pxa3xx_nand_detect_flash(struct
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
+	/* we use default timing to detect id */
+	f = DEFAULT_FLASH_TYPE;
+	pxa3xx_nand_config_flash(info, f);
+	if (__readid(info, &id))
+		goto fail_detect;
+
+	for (i=0; i<ARRAY_SIZE(builtin_flash_types) + pdata->num_flash - 1; i++) {
+		/* we first choose the flash definition from platfrom */
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
 		 "failed to detect configured nand flash; found %04x instead of\n",
 		 id);
+fail_detect:
 	return -ENODEV;
 }

-- 
1.7.0.4
