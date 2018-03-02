From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri,  2 Mar 2018 18:03:55 +0100
Subject: [PATCH 47/52] mtd: rawnand: docg4: fix the probe function error path
In-Reply-To: <20180302170400.6712-1-miquel.raynal@bootlin.com>
References: <20180302170400.6712-1-miquel.raynal@bootlin.com>
Message-ID: <20180302170400.6712-48-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

An error after nand_scan_tail() call should trigger a nand_release()
call. This is rightly handled in the remove function, but not in the
probe function.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/docg4.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/nand/raw/docg4.c b/drivers/mtd/nand/raw/docg4.c
index 1314aa99b9ab..1d3d5ac24381 100644
--- a/drivers/mtd/nand/raw/docg4.c
+++ b/drivers/mtd/nand/raw/docg4.c
@@ -1341,7 +1341,7 @@ static int __init probe_docg4(struct platform_device *pdev)
 	nand = kzalloc(len, GFP_KERNEL);
 	if (nand == NULL) {
 		retval = -ENOMEM;
-		goto fail_unmap;
+		goto unmap;
 	}
 
 	mtd = nand_to_mtd(nand);
@@ -1357,7 +1357,7 @@ static int __init probe_docg4(struct platform_device *pdev)
 	doc->bch = init_bch(DOCG4_M, DOCG4_T, DOCG4_PRIMITIVE_POLY);
 	if (doc->bch == NULL) {
 		retval = -EINVAL;
-		goto fail;
+		goto free_nand;
 	}
 
 	platform_set_drvdata(pdev, doc);
@@ -1366,30 +1366,32 @@ static int __init probe_docg4(struct platform_device *pdev)
 	retval = read_id_reg(mtd);
 	if (retval == -ENODEV) {
 		dev_warn(dev, "No diskonchip G4 device found.\n");
-		goto fail;
+		goto free_bch;
 	}
 
 	retval = nand_scan_tail(mtd);
 	if (retval)
-		goto fail;
+		goto free_bch;
 
 	retval = read_factory_bbt(mtd);
 	if (retval)
-		goto fail;
+		goto release_nand;
 
 	retval = mtd_device_parse_register(mtd, part_probes, NULL, NULL, 0);
 	if (retval)
-		goto fail;
+		goto release_nand;
 
 	doc->mtd = mtd;
+
 	return 0;
 
-fail:
+release_nand:
 	nand_release(mtd); /* deletes partitions and mtd devices */
+free_bch:
 	free_bch(doc->bch);
+free_nand:
 	kfree(nand);
-
-fail_unmap:
+unmap:
 	iounmap(virtadr);
 
 	return retval;
-- 
2.14.1
