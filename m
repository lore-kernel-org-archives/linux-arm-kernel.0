From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 10 Dec 2015 09:00:01 +0100
Subject: [PATCH v4 17/58] mtd: nand: docg4: use the mtd instance embedded in
 struct nand_chip
In-Reply-To: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1449734442-18672-18-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

struct nand_chip now embeds an mtd device. Make use of this mtd instance.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/docg4.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/mtd/nand/docg4.c b/drivers/mtd/nand/docg4.c
index da93d7f..cb6efad 100644
--- a/drivers/mtd/nand/docg4.c
+++ b/drivers/mtd/nand/docg4.c
@@ -1305,14 +1305,14 @@ static int __init probe_docg4(struct platform_device *pdev)
 		return -EIO;
 	}
 
-	len = sizeof(struct mtd_info) + sizeof(struct nand_chip) +
-		sizeof(struct docg4_priv);
-	mtd = kzalloc(len, GFP_KERNEL);
-	if (mtd == NULL) {
+	len = sizeof(struct nand_chip) + sizeof(struct docg4_priv);
+	nand = kzalloc(len, GFP_KERNEL);
+	if (nand == NULL) {
 		retval = -ENOMEM;
-		goto fail;
+		goto fail_unmap;
 	}
-	nand = (struct nand_chip *) (mtd + 1);
+
+	mtd = nand_to_mtd(nand);
 	doc = (struct docg4_priv *) (nand + 1);
 	mtd->priv = nand;
 	nand->priv = doc;
@@ -1354,16 +1354,17 @@ static int __init probe_docg4(struct platform_device *pdev)
 	return 0;
 
  fail:
-	iounmap(virtadr);
-	if (mtd) {
+	if (nand) {
 		/* re-declarations avoid compiler warning */
-		struct nand_chip *nand = mtd_to_nand(mtd);
 		struct docg4_priv *doc = nand->priv;
 		nand_release(mtd); /* deletes partitions and mtd devices */
 		free_bch(doc->bch);
-		kfree(mtd);
+		kfree(nand);
 	}
 
+fail_unmap:
+	iounmap(virtadr);
+
 	return retval;
 }
 
@@ -1372,7 +1373,7 @@ static int __exit cleanup_docg4(struct platform_device *pdev)
 	struct docg4_priv *doc = platform_get_drvdata(pdev);
 	nand_release(doc->mtd);
 	free_bch(doc->bch);
-	kfree(doc->mtd);
+	kfree(mtd_to_nand(doc->mtd));
 	iounmap(doc->virtadr);
 	return 0;
 }
-- 
2.1.4
