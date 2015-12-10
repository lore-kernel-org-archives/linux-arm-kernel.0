From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 10 Dec 2015 09:00:23 +0100
Subject: [PATCH v4 39/58] mtd: nand: sh_flctl: use the mtd instance embedded
 in struct nand_chip
In-Reply-To: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1449734442-18672-40-git-send-email-boris.brezillon@free-electrons.com>
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
 drivers/mtd/nand/sh_flctl.c  | 8 ++++----
 include/linux/mtd/sh_flctl.h | 3 +--
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/sh_flctl.c b/drivers/mtd/nand/sh_flctl.c
index 57dc525..0ec4b04 100644
--- a/drivers/mtd/nand/sh_flctl.c
+++ b/drivers/mtd/nand/sh_flctl.c
@@ -607,13 +607,13 @@ static void execmd_read_page_sector(struct mtd_info *mtd, int page_addr)
 		case FL_REPAIRABLE:
 			dev_info(&flctl->pdev->dev,
 				"applied ecc on page 0x%x", page_addr);
-			flctl->mtd.ecc_stats.corrected++;
+			mtd->ecc_stats.corrected++;
 			break;
 		case FL_ERROR:
 			dev_warn(&flctl->pdev->dev,
 				"page 0x%x contains corrupted data\n",
 				page_addr);
-			flctl->mtd.ecc_stats.failed++;
+			mtd->ecc_stats.failed++;
 			break;
 		default:
 			;
@@ -1120,8 +1120,8 @@ static int flctl_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, flctl);
-	flctl_mtd = &flctl->mtd;
 	nand = &flctl->chip;
+	flctl_mtd = nand_to_mtd(nand);
 	nand_set_flash_node(nand, pdev->dev.of_node);
 	flctl_mtd->priv = nand;
 	flctl_mtd->dev.parent = &pdev->dev;
@@ -1178,7 +1178,7 @@ static int flctl_remove(struct platform_device *pdev)
 	struct sh_flctl *flctl = platform_get_drvdata(pdev);
 
 	flctl_release_dma(flctl);
-	nand_release(&flctl->mtd);
+	nand_release(nand_to_mtd(&flctl->chip));
 	pm_runtime_disable(&pdev->dev);
 
 	return 0;
diff --git a/include/linux/mtd/sh_flctl.h b/include/linux/mtd/sh_flctl.h
index 1c28f88..76e3e88 100644
--- a/include/linux/mtd/sh_flctl.h
+++ b/include/linux/mtd/sh_flctl.h
@@ -143,7 +143,6 @@ enum flctl_ecc_res_t {
 struct dma_chan;
 
 struct sh_flctl {
-	struct mtd_info		mtd;
 	struct nand_chip	chip;
 	struct platform_device	*pdev;
 	struct dev_pm_qos_request pm_qos;
@@ -186,7 +185,7 @@ struct sh_flctl_platform_data {
 
 static inline struct sh_flctl *mtd_to_flctl(struct mtd_info *mtdinfo)
 {
-	return container_of(mtdinfo, struct sh_flctl, mtd);
+	return container_of(mtd_to_nand(mtdinfo), struct sh_flctl, chip);
 }
 
 #endif	/* __SH_FLCTL_H__ */
-- 
2.1.4
