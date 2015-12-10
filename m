From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 10 Dec 2015 08:59:57 +0100
Subject: [PATCH v4 13/58] mtd: nand: cs553x: use the mtd instance embedded in
 struct nand_chip
In-Reply-To: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1449734442-18672-14-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

struct nand_chip now embeds an mtd device. Make use of this mtd instance.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/cs553x_nand.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/nand/cs553x_nand.c b/drivers/mtd/nand/cs553x_nand.c
index 8904d68..386ae83 100644
--- a/drivers/mtd/nand/cs553x_nand.c
+++ b/drivers/mtd/nand/cs553x_nand.c
@@ -197,14 +197,13 @@ static int __init cs553x_init_one(int cs, int mmio, unsigned long adr)
 	}
 
 	/* Allocate memory for MTD device structure and private data */
-	new_mtd = kzalloc(sizeof(struct mtd_info) + sizeof(struct nand_chip), GFP_KERNEL);
-	if (!new_mtd) {
+	this = kzalloc(sizeof(struct nand_chip), GFP_KERNEL);
+	if (!this) {
 		err = -ENOMEM;
 		goto out;
 	}
 
-	/* Get pointer to private data */
-	this = (struct nand_chip *)(&new_mtd[1]);
+	new_mtd = nand_to_mtd(this);
 
 	/* Link the private data with the MTD structure */
 	new_mtd->priv = this;
@@ -257,7 +256,7 @@ out_free:
 out_ior:
 	iounmap(this->IO_ADDR_R);
 out_mtd:
-	kfree(new_mtd);
+	kfree(this);
 out:
 	return err;
 }
@@ -337,19 +336,19 @@ static void __exit cs553x_cleanup(void)
 		if (!mtd)
 			continue;
 
-		this = mtd_to_nand(cs553x_mtd[i]);
+		this = mtd_to_nand(mtd);
 		mmio_base = this->IO_ADDR_R;
 
 		/* Release resources, unregister device */
-		nand_release(cs553x_mtd[i]);
-		kfree(cs553x_mtd[i]->name);
+		nand_release(mtd);
+		kfree(mtd->name);
 		cs553x_mtd[i] = NULL;
 
 		/* unmap physical address */
 		iounmap(mmio_base);
 
 		/* Free the MTD device structure */
-		kfree(mtd);
+		kfree(this);
 	}
 }
 
-- 
2.1.4
