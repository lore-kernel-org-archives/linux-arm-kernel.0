From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 10 Dec 2015 08:59:56 +0100
Subject: [PATCH v4 12/58] mtd: nand: cmx270: use the mtd instance embedded in
 struct nand_chip
In-Reply-To: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1449734442-18672-13-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

struct nand_chip now embeds an mtd device. Make use of this mtd instance.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/cmx270_nand.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/nand/cmx270_nand.c b/drivers/mtd/nand/cmx270_nand.c
index 43bded6..6b26e0c 100644
--- a/drivers/mtd/nand/cmx270_nand.c
+++ b/drivers/mtd/nand/cmx270_nand.c
@@ -160,10 +160,8 @@ static int __init cmx270_init(void)
 	gpio_direction_input(GPIO_NAND_RB);
 
 	/* Allocate memory for MTD device structure and private data */
-	cmx270_nand_mtd = kzalloc(sizeof(struct mtd_info) +
-				  sizeof(struct nand_chip),
-				  GFP_KERNEL);
-	if (!cmx270_nand_mtd) {
+	this = kzalloc(sizeof(struct nand_chip), GFP_KERNEL);
+	if (!this) {
 		ret = -ENOMEM;
 		goto err_kzalloc;
 	}
@@ -175,8 +173,7 @@ static int __init cmx270_init(void)
 		goto err_ioremap;
 	}
 
-	/* Get pointer to private data */
-	this = (struct nand_chip *)(&cmx270_nand_mtd[1]);
+	cmx270_nand_mtd = nand_to_mtd(this);
 
 	/* Link the private data with the MTD structure */
 	cmx270_nand_mtd->owner = THIS_MODULE;
@@ -216,7 +213,7 @@ static int __init cmx270_init(void)
 err_scan:
 	iounmap(cmx270_nand_io);
 err_ioremap:
-	kfree(cmx270_nand_mtd);
+	kfree(this);
 err_kzalloc:
 	gpio_free(GPIO_NAND_RB);
 err_gpio_request:
@@ -241,7 +238,7 @@ static void __exit cmx270_cleanup(void)
 	iounmap(cmx270_nand_io);
 
 	/* Free the MTD device structure */
-	kfree (cmx270_nand_mtd);
+	kfree(mtd_to_nand(cmx270_nand_mtd));
 }
 module_exit(cmx270_cleanup);
 
-- 
2.1.4
