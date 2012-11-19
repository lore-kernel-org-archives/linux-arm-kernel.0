From: zonque@gmail.com (Daniel Mack)
Date: Mon, 19 Nov 2012 23:29:14 +0800
Subject: [PATCH v4 1/3] mtd: omap-nand: pass device_node in platform data
In-Reply-To: <1353338956-19420-1-git-send-email-zonque@gmail.com>
References: <1353338956-19420-1-git-send-email-zonque@gmail.com>
Message-ID: <1353338956-19420-2-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pass an optional device_node pointer in the platform data, which in turn
will be put into a mtd_part_parser_data. This way, code that sets up the
platform devices can pass along the node from DT so that the partitions
can be parsed.

For non-DT boards, this change has no effect.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 drivers/mtd/nand/omap2.c                     | 4 +++-
 include/linux/platform_data/mtd-nand-omap2.h | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 5c8978e..1e1d6ef 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -1333,6 +1333,7 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
 	dma_cap_mask_t mask;
 	unsigned sig;
 	struct resource			*res;
+	struct mtd_part_parser_data	ppdata = {};
 
 	pdata = pdev->dev.platform_data;
 	if (pdata == NULL) {
@@ -1558,7 +1559,8 @@ static int __devinit omap_nand_probe(struct platform_device *pdev)
 		goto out_release_mem_region;
 	}
 
-	mtd_device_parse_register(&info->mtd, NULL, NULL, pdata->parts,
+	ppdata.of_node = pdata->of_node;
+	mtd_device_parse_register(&info->mtd, NULL, &ppdata, pdata->parts,
 				  pdata->nr_parts);
 
 	platform_set_drvdata(pdev, &info->mtd);
diff --git a/include/linux/platform_data/mtd-nand-omap2.h b/include/linux/platform_data/mtd-nand-omap2.h
index 24d32ca..5217d6e 100644
--- a/include/linux/platform_data/mtd-nand-omap2.h
+++ b/include/linux/platform_data/mtd-nand-omap2.h
@@ -60,6 +60,8 @@ struct omap_nand_platform_data {
 	int			devsize;
 	enum omap_ecc           ecc_opt;
 	struct gpmc_nand_regs	reg;
+	/* for passing the partitions */
+	struct device_node	*of_node;
 };
 
 #endif
-- 
1.7.11.7
