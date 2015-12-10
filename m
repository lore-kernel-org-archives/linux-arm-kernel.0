From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 10 Dec 2015 09:00:12 +0100
Subject: [PATCH v4 28/58] mtd: nand: mxc: use the mtd instance embedded in
 struct nand_chip
In-Reply-To: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1449734442-18672-29-git-send-email-boris.brezillon@free-electrons.com>
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
 drivers/mtd/nand/mxc_nand.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
index b291258..9dd71af 100644
--- a/drivers/mtd/nand/mxc_nand.c
+++ b/drivers/mtd/nand/mxc_nand.c
@@ -173,7 +173,6 @@ struct mxc_nand_devtype_data {
 };
 
 struct mxc_nand_host {
-	struct mtd_info		mtd;
 	struct nand_chip	nand;
 	struct device		*dev;
 
@@ -1514,7 +1513,7 @@ static int mxcnd_probe(struct platform_device *pdev)
 	host->dev = &pdev->dev;
 	/* structures must be linked */
 	this = &host->nand;
-	mtd = &host->mtd;
+	mtd = nand_to_mtd(this);
 	mtd->priv = this;
 	mtd->dev.parent = &pdev->dev;
 	mtd->name = DRIVER_NAME;
@@ -1702,7 +1701,7 @@ static int mxcnd_remove(struct platform_device *pdev)
 {
 	struct mxc_nand_host *host = platform_get_drvdata(pdev);
 
-	nand_release(&host->mtd);
+	nand_release(nand_to_mtd(&host->nand));
 	if (host->clk_act)
 		clk_disable_unprepare(host->clk);
 
-- 
2.1.4
