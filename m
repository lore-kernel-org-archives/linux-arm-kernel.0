From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 10 Dec 2015 08:59:49 +0100
Subject: [PATCH v4 05/58] mtd: nand: ams-delta: use the mtd instance embedded
 in struct nand_chip
In-Reply-To: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1449734442-18672-6-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

struct nand_chip now embeds an mtd device. Make use of this mtd instance
instead of allocating our own.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/ams-delta.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/nand/ams-delta.c b/drivers/mtd/nand/ams-delta.c
index b2b49c4..0f638c6 100644
--- a/drivers/mtd/nand/ams-delta.c
+++ b/drivers/mtd/nand/ams-delta.c
@@ -183,19 +183,16 @@ static int ams_delta_init(struct platform_device *pdev)
 		return -ENXIO;
 
 	/* Allocate memory for MTD device structure and private data */
-	ams_delta_mtd = kzalloc(sizeof(struct mtd_info) +
-				sizeof(struct nand_chip), GFP_KERNEL);
-	if (!ams_delta_mtd) {
+	this = kzalloc(sizeof(struct nand_chip), GFP_KERNEL);
+	if (!this) {
 		printk (KERN_WARNING "Unable to allocate E3 NAND MTD device structure.\n");
 		err = -ENOMEM;
 		goto out;
 	}
 
+	ams_delta_mtd = nand_to_mtd(this);
 	ams_delta_mtd->owner = THIS_MODULE;
 
-	/* Get pointer to private data */
-	this = (struct nand_chip *) (&ams_delta_mtd[1]);
-
 	/* Link the private data with the MTD structure */
 	ams_delta_mtd->priv = this;
 
@@ -256,7 +253,7 @@ out_gpio:
 	gpio_free(AMS_DELTA_GPIO_PIN_NAND_RB);
 	iounmap(io_base);
 out_free:
-	kfree(ams_delta_mtd);
+	kfree(this);
  out:
 	return err;
 }
@@ -276,7 +273,7 @@ static int ams_delta_cleanup(struct platform_device *pdev)
 	iounmap(io_base);
 
 	/* Free the MTD device structure */
-	kfree(ams_delta_mtd);
+	kfree(mtd_to_nand(ams_delta_mtd));
 
 	return 0;
 }
-- 
2.1.4
