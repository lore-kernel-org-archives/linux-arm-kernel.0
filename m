From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 10 Dec 2015 08:59:51 +0100
Subject: [PATCH v4 07/58] mtd: nand: au1550nd: use the mtd instance embedded
 in struct nand_chip
In-Reply-To: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1449734442-18672-8-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

struct nand_chip now embeds an mtd device. Make use of this mtd instance.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
Changes generated with the following coccinelle script

--->8---
virtual patch

@fix1@
identifier __chipfield, __mtdfield;
type __type;
@@
(
	__type {
		...
		struct nand_chip __chipfield;
		...
-		struct mtd_info __mtdfield;
		...
	};
|
	__type {
		...
-		struct mtd_info __mtdfield;
		...
		struct nand_chip __chipfield;
		...
	};
)

@fix2 depends on fix1@
identifier fix1.__chipfield, fix1.__mtdfield;
identifier __subfield;
type fix1.__type;
__type *__priv;
@@
(
-	__priv->__mtdfield.__subfield
+	nand_to_mtd(&__priv->__chipfield)->__subfield
|
-	&(__priv->__mtdfield)
+	nand_to_mtd(&__priv->__chipfield)
)
--->8---
---
 drivers/mtd/nand/au1550nd.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/nand/au1550nd.c b/drivers/mtd/nand/au1550nd.c
index 73fceb8..280e5b6 100644
--- a/drivers/mtd/nand/au1550nd.c
+++ b/drivers/mtd/nand/au1550nd.c
@@ -23,7 +23,6 @@
 
 
 struct au1550nd_ctx {
-	struct mtd_info info;
 	struct nand_chip chip;
 
 	int cs;
@@ -197,8 +196,9 @@ static void au_read_buf16(struct mtd_info *mtd, u_char *buf, int len)
 
 static void au1550_hwcontrol(struct mtd_info *mtd, int cmd)
 {
-	struct au1550nd_ctx *ctx = container_of(mtd, struct au1550nd_ctx, info);
 	struct nand_chip *this = mtd_to_nand(mtd);
+	struct au1550nd_ctx *ctx = container_of(this, struct au1550nd_ctx,
+						chip);
 
 	switch (cmd) {
 
@@ -267,8 +267,9 @@ static void au1550_select_chip(struct mtd_info *mtd, int chip)
  */
 static void au1550_command(struct mtd_info *mtd, unsigned command, int column, int page_addr)
 {
-	struct au1550nd_ctx *ctx = container_of(mtd, struct au1550nd_ctx, info);
 	struct nand_chip *this = mtd_to_nand(mtd);
+	struct au1550nd_ctx *ctx = container_of(this, struct au1550nd_ctx,
+						chip);
 	int ce_override = 0, i;
 	unsigned long flags = 0;
 
@@ -405,6 +406,7 @@ static int au1550nd_probe(struct platform_device *pdev)
 	struct au1550nd_platdata *pd;
 	struct au1550nd_ctx *ctx;
 	struct nand_chip *this;
+	struct mtd_info *mtd;
 	struct resource *r;
 	int ret, cs;
 
@@ -438,8 +440,9 @@ static int au1550nd_probe(struct platform_device *pdev)
 	}
 
 	this = &ctx->chip;
-	ctx->info.priv = this;
-	ctx->info.dev.parent = &pdev->dev;
+	mtd = nand_to_mtd(this);
+	mtd->priv = this;
+	mtd->dev.parent = &pdev->dev;
 
 	/* figure out which CS# r->start belongs to */
 	cs = find_nand_cs(r->start);
@@ -467,13 +470,13 @@ static int au1550nd_probe(struct platform_device *pdev)
 	this->write_buf = (pd->devwidth) ? au_write_buf16 : au_write_buf;
 	this->read_buf = (pd->devwidth) ? au_read_buf16 : au_read_buf;
 
-	ret = nand_scan(&ctx->info, 1);
+	ret = nand_scan(mtd, 1);
 	if (ret) {
 		dev_err(&pdev->dev, "NAND scan failed with %d\n", ret);
 		goto out3;
 	}
 
-	mtd_device_register(&ctx->info, pd->parts, pd->num_parts);
+	mtd_device_register(mtd, pd->parts, pd->num_parts);
 
 	platform_set_drvdata(pdev, ctx);
 
@@ -493,7 +496,7 @@ static int au1550nd_remove(struct platform_device *pdev)
 	struct au1550nd_ctx *ctx = platform_get_drvdata(pdev);
 	struct resource *r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
-	nand_release(&ctx->info);
+	nand_release(nand_to_mtd(&ctx->chip));
 	iounmap(ctx->base);
 	release_mem_region(r->start, 0x1000);
 	kfree(ctx);
-- 
2.1.4
