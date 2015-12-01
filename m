From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue,  1 Dec 2015 12:03:10 +0100
Subject: [PATCH v2 13/25] mtd: nand: update the documentation to reflect
 framework changes
In-Reply-To: <1448967802-25796-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1448967802-25796-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1448967802-25796-14-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MTD device is now directly embedded in the nand_chip struct. Update the
mtdnand documentation to mention this aspect and fix the different
examples.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 Documentation/DocBook/mtdnand.tmpl | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/Documentation/DocBook/mtdnand.tmpl b/Documentation/DocBook/mtdnand.tmpl
index 403a7ab..b442921 100644
--- a/Documentation/DocBook/mtdnand.tmpl
+++ b/Documentation/DocBook/mtdnand.tmpl
@@ -162,12 +162,15 @@
 	<sect1 id="Basic_defines">
 		<title>Basic defines</title>
 		<para>
-			At least you have to provide a mtd structure and
-			a storage for the ioremap'ed chip address.
-			You can allocate the mtd structure using kmalloc
-			or you can allocate it statically.
-			In case of static allocation you have to allocate
-			a nand_chip structure too.
+			At least you have to provide a nand_chip structure
+			and a storage for the ioremap'ed chip address.
+			You can allocate the nand_chip structure using
+			kmalloc or you can allocate it statically.
+			The NAND chip structure embeds an mtd structure
+			which will be registered to the MTD subsystem.
+			You can extract a pointer to the mtd structure
+			from a nand_chip pointer using the nand_to_mtd()
+			helper.
 		</para>
 		<para>
 			Kmalloc based example
@@ -180,7 +183,6 @@ static void __iomem *baseaddr;
 			Static example
 		</para>
 		<programlisting>
-static struct mtd_info board_mtd;
 static struct nand_chip board_chip;
 static void __iomem *baseaddr;
 		</programlisting>
@@ -274,13 +276,15 @@ static int __init board_init (void)
 	int err = 0;
 
 	/* Allocate memory for MTD device structure and private data */
-	board_mtd = kzalloc(sizeof(struct mtd_info) + sizeof(struct nand_chip), GFP_KERNEL);
-	if (!board_mtd) {
+	this = kzalloc(sizeof(struct nand_chip), GFP_KERNEL);
+	if (!this) {
 		printk ("Unable to allocate NAND MTD device structure.\n");
 		err = -ENOMEM;
 		goto out;
 	}
 
+	board_mtd = nand_to_mtd(this);
+
 	/* map physical address */
 	baseaddr = ioremap(CHIP_PHYSICAL_ADDRESS, 1024);
 	if (!baseaddr) {
@@ -289,11 +293,6 @@ static int __init board_init (void)
 		goto out_mtd;
 	}
 
-	/* Get pointer to private data */
-	this = (struct nand_chip *) ();
-	/* Link the private data with the MTD structure */
-	board_mtd->priv = this;
-
 	/* Set address of NAND IO lines */
 	this->IO_ADDR_R = baseaddr;
 	this->IO_ADDR_W = baseaddr;
@@ -317,7 +316,7 @@ static int __init board_init (void)
 out_ior:
 	iounmap(baseaddr);
 out_mtd:
-	kfree (board_mtd);
+	kfree (this);
 out:
 	return err;
 }
@@ -343,7 +342,7 @@ static void __exit board_cleanup (void)
 	iounmap(baseaddr);
 	
 	/* Free the MTD device structure */
-	kfree (board_mtd);
+	kfree (mtd_to_nand(board_mtd));
 }
 module_exit(board_cleanup);
 #endif
-- 
2.1.4
