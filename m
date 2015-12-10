From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 10 Dec 2015 09:00:18 +0100
Subject: [PATCH v4 34/58] mtd: nand: pasemi: use the mtd instance embedded in
 struct nand_chip
In-Reply-To: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1449734442-18672-35-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

struct nand_chip now embeds an mtd device. Make use of this mtd instance.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/pasemi_nand.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/pasemi_nand.c b/drivers/mtd/nand/pasemi_nand.c
index 0ececac..4dd2985 100644
--- a/drivers/mtd/nand/pasemi_nand.c
+++ b/drivers/mtd/nand/pasemi_nand.c
@@ -110,17 +110,15 @@ static int pasemi_nand_probe(struct platform_device *ofdev)
 	pr_debug("pasemi_nand at %pR\n", &res);
 
 	/* Allocate memory for MTD device structure and private data */
-	pasemi_nand_mtd = kzalloc(sizeof(struct mtd_info) +
-				  sizeof(struct nand_chip), GFP_KERNEL);
-	if (!pasemi_nand_mtd) {
+	chip = kzalloc(sizeof(struct nand_chip), GFP_KERNEL);
+	if (!chip) {
 		printk(KERN_WARNING
 		       "Unable to allocate PASEMI NAND MTD device structure\n");
 		err = -ENOMEM;
 		goto out;
 	}
 
-	/* Get pointer to private data */
-	chip = (struct nand_chip *)&pasemi_nand_mtd[1];
+	pasemi_nand_mtd = nand_to_mtd(chip);
 
 	/* Link the private data with the MTD structure */
 	pasemi_nand_mtd->priv = chip;
@@ -180,7 +178,7 @@ static int pasemi_nand_probe(struct platform_device *ofdev)
  out_ior:
 	iounmap(chip->IO_ADDR_R);
  out_mtd:
-	kfree(pasemi_nand_mtd);
+	kfree(chip);
  out:
 	return err;
 }
@@ -202,7 +200,7 @@ static int pasemi_nand_remove(struct platform_device *ofdev)
 	iounmap(chip->IO_ADDR_R);
 
 	/* Free the MTD device structure */
-	kfree(pasemi_nand_mtd);
+	kfree(chip);
 
 	pasemi_nand_mtd = NULL;
 
-- 
2.1.4
