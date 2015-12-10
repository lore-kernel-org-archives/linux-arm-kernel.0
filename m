From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 10 Dec 2015 09:00:13 +0100
Subject: [PATCH v4 29/58] mtd: nand: nandsim: use the mtd instance embedded in
 struct nand_chip
In-Reply-To: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1449734442-18672-30-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

struct nand_chip now embeds an mtd device. Make use of this mtd instance.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/nandsim.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/nandsim.c b/drivers/mtd/nand/nandsim.c
index eb2a567..442eeaf 100644
--- a/drivers/mtd/nand/nandsim.c
+++ b/drivers/mtd/nand/nandsim.c
@@ -2236,13 +2236,13 @@ static int __init ns_init_module(void)
 	}
 
 	/* Allocate and initialize mtd_info, nand_chip and nandsim structures */
-	nsmtd = kzalloc(sizeof(struct mtd_info) + sizeof(struct nand_chip)
-				+ sizeof(struct nandsim), GFP_KERNEL);
-	if (!nsmtd) {
+	chip = kzalloc(sizeof(struct nand_chip) + sizeof(struct nandsim),
+		       GFP_KERNEL);
+	if (!chip) {
 		NS_ERR("unable to allocate core structures.\n");
 		return -ENOMEM;
 	}
-	chip        = (struct nand_chip *)(nsmtd + 1);
+	nsmtd       = nand_to_mtd(chip);
         nsmtd->priv = (void *)chip;
 	nand        = (struct nandsim *)(chip + 1);
 	chip->priv  = (void *)nand;
@@ -2392,7 +2392,7 @@ err_exit:
 	for (i = 0;i < ARRAY_SIZE(nand->partitions); ++i)
 		kfree(nand->partitions[i].name);
 error:
-	kfree(nsmtd);
+	kfree(chip);
 	free_lists();
 
 	return retval;
@@ -2413,7 +2413,7 @@ static void __exit ns_cleanup_module(void)
 	nand_release(nsmtd); /* Unregister driver */
 	for (i = 0;i < ARRAY_SIZE(ns->partitions); ++i)
 		kfree(ns->partitions[i].name);
-	kfree(nsmtd);        /* Free other structures */
+	kfree(mtd_to_nand(nsmtd));        /* Free other structures */
 	free_lists();
 }
 
-- 
2.1.4
