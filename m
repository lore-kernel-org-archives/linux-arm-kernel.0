From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 10 Dec 2015 09:00:00 +0100
Subject: [PATCH v4 16/58] mtd: nand: diskonchip: use the mtd instance embedded
 in struct nand_chip
In-Reply-To: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1449734442-18672-17-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

struct nand_chip now embeds an mtd device. Make use of this mtd instance.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/diskonchip.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/diskonchip.c b/drivers/mtd/nand/diskonchip.c
index 5f7bcc8..fff7a4a 100644
--- a/drivers/mtd/nand/diskonchip.c
+++ b/drivers/mtd/nand/diskonchip.c
@@ -1556,15 +1556,15 @@ static int __init doc_probe(unsigned long physadr)
 
 	printk(KERN_NOTICE "DiskOnChip found at 0x%lx\n", physadr);
 
-	len = sizeof(struct mtd_info) +
-	    sizeof(struct nand_chip) + sizeof(struct doc_priv) + (2 * sizeof(struct nand_bbt_descr));
-	mtd = kzalloc(len, GFP_KERNEL);
-	if (!mtd) {
+	len = sizeof(struct nand_chip) + sizeof(struct doc_priv) +
+	      (2 * sizeof(struct nand_bbt_descr));
+	nand = kzalloc(len, GFP_KERNEL);
+	if (!nand) {
 		ret = -ENOMEM;
 		goto fail;
 	}
 
-	nand			= (struct nand_chip *) (mtd + 1);
+	mtd			= nand_to_mtd(nand);
 	doc			= (struct doc_priv *) (nand + 1);
 	nand->bbt_td		= (struct nand_bbt_descr *) (doc + 1);
 	nand->bbt_md		= nand->bbt_td + 1;
@@ -1615,7 +1615,7 @@ static int __init doc_probe(unsigned long physadr)
 		   haven't yet added it.  This is handled without incident by
 		   mtd_device_unregister, as far as I can tell. */
 		nand_release(mtd);
-		kfree(mtd);
+		kfree(nand);
 		goto fail;
 	}
 
@@ -1650,7 +1650,7 @@ static void release_nanddoc(void)
 		nand_release(mtd);
 		iounmap(doc->virtadr);
 		release_mem_region(doc->physadr, DOC_IOREMAP_LEN);
-		kfree(mtd);
+		kfree(nand);
 	}
 }
 
-- 
2.1.4
