From: leiwen@marvell.com (Lei Wen)
Date: Thu, 6 May 2010 10:42:13 +0800
Subject: [PATCH] mtd: pxa3xx_nand: add cmdline part parser support
Message-ID: <mailman.439.1273818235.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lei Wen <leiwen@marvell.com>
Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/mtd/nand/pxa3xx_nand.c |   26 ++++++++++++++++++++++++--
 1 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index 2eebd20..793b64c 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -349,6 +349,9 @@ static struct pxa3xx_nand_flash __devinitdata
builtin_flash_types[] = {
 	{ 0, 10, 35, 15, 25, 15, 25, 25000, 0, 60, 10, }, },
 };

+#ifdef CONFIG_MTD_CMDLINE_PARTS
+static const char *part_probes[] = { "cmdlinepart", NULL };
+#endif
 static const char *mtd_names[] = {"pxa3xx_nand-0", "pxa3xx_nand-1", NULL};

 /* convert nano-seconds to nand flash controller clock cycles */
@@ -1726,6 +1729,10 @@ static int __devinit pxa3xx_nand_probe(struct
platform_device *pdev)
 	struct pxa3xx_nand *nand;
 	struct mtd_info *mtd;
 	int ret, cs, probe_success = 0;
+#ifdef CONFIG_MTD_PARTITIONS
+	struct mtd_partition *partitions = NULL;
+	int num_part = 0;
+#endif

 	pdata = pdev->dev.platform_data;
 	if (!pdata) {
@@ -1747,8 +1754,23 @@ static int __devinit pxa3xx_nand_probe(struct
platform_device *pdev)
 			dev_err(&pdev->dev, "failed to scan cs#%d nand\n", cs);
 			continue;
 		}
-		ret = add_mtd_partitions(mtd, pdata->parts[cs],
-				pdata->nr_parts[cs]);
+		mtd->name = mtd_names[cs];
+#ifdef CONFIG_MTD_PARTITIONS
+#ifdef CONFIG_MTD_CMDLINE_PARTS
+		num_part = parse_mtd_partitions(mtd, part_probes, &partitions, 0);
+#endif
+		if (num_part <= 0) {
+			num_part = pdata->nr_parts[cs];
+			partitions = pdata->parts[cs];
+		}
+
+		if (partitions && num_part > 0)
+			ret = add_mtd_partitions(mtd, partitions, num_part);
+		else
+			ret = add_mtd_device(mtd);
+#else
+		ret = add_mtd_device(mtd);
+#endif
 		if (!ret)
 			probe_success = 1;
 	}
-- 
1.5.6.5
