From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 10 Dec 2015 09:00:04 +0100
Subject: [PATCH v4 20/58] mtd: nand: fsl_upm: use the mtd instance embedded in
 struct nand_chip
In-Reply-To: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1449734442-18672-21-git-send-email-boris.brezillon@free-electrons.com>
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
 drivers/mtd/nand/fsl_upm.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/mtd/nand/fsl_upm.c b/drivers/mtd/nand/fsl_upm.c
index 68ec128..0379adc 100644
--- a/drivers/mtd/nand/fsl_upm.c
+++ b/drivers/mtd/nand/fsl_upm.c
@@ -31,7 +31,6 @@
 
 struct fsl_upm_nand {
 	struct device *dev;
-	struct mtd_info mtd;
 	struct nand_chip chip;
 	int last_ctrl;
 	struct mtd_partition *parts;
@@ -49,7 +48,8 @@ struct fsl_upm_nand {
 
 static inline struct fsl_upm_nand *to_fsl_upm_nand(struct mtd_info *mtdinfo)
 {
-	return container_of(mtdinfo, struct fsl_upm_nand, mtd);
+	return container_of(mtd_to_nand(mtdinfo), struct fsl_upm_nand,
+			    chip);
 }
 
 static int fun_chip_ready(struct mtd_info *mtd)
@@ -66,9 +66,10 @@ static int fun_chip_ready(struct mtd_info *mtd)
 static void fun_wait_rnb(struct fsl_upm_nand *fun)
 {
 	if (fun->rnb_gpio[fun->mchip_number] >= 0) {
+		struct mtd_info *mtd = nand_to_mtd(&fun->chip);
 		int cnt = 1000000;
 
-		while (--cnt && !fun_chip_ready(&fun->mtd))
+		while (--cnt && !fun_chip_ready(mtd))
 			cpu_relax();
 		if (!cnt)
 			dev_err(fun->dev, "tired waiting for RNB\n");
@@ -157,6 +158,7 @@ static int fun_chip_init(struct fsl_upm_nand *fun,
 			 const struct device_node *upm_np,
 			 const struct resource *io_res)
 {
+	struct mtd_info *mtd = nand_to_mtd(&fun->chip);
 	int ret;
 	struct device_node *flash_np;
 
@@ -174,30 +176,30 @@ static int fun_chip_init(struct fsl_upm_nand *fun,
 	if (fun->rnb_gpio[0] >= 0)
 		fun->chip.dev_ready = fun_chip_ready;
 
-	fun->mtd.priv = &fun->chip;
-	fun->mtd.dev.parent = fun->dev;
+	mtd->priv = &fun->chip;
+	mtd->dev.parent = fun->dev;
 
 	flash_np = of_get_next_child(upm_np, NULL);
 	if (!flash_np)
 		return -ENODEV;
 
 	nand_set_flash_node(&fun->chip, flash_np);
-	fun->mtd.name = kasprintf(GFP_KERNEL, "0x%llx.%s", (u64)io_res->start,
-				  flash_np->name);
-	if (!fun->mtd.name) {
+	mtd->name = kasprintf(GFP_KERNEL, "0x%llx.%s", (u64)io_res->start,
+			      flash_np->name);
+	if (!mtd->name) {
 		ret = -ENOMEM;
 		goto err;
 	}
 
-	ret = nand_scan(&fun->mtd, fun->mchip_count);
+	ret = nand_scan(mtd, fun->mchip_count);
 	if (ret)
 		goto err;
 
-	ret = mtd_device_register(&fun->mtd, NULL, 0);
+	ret = mtd_device_register(mtd, NULL, 0);
 err:
 	of_node_put(flash_np);
 	if (ret)
-		kfree(fun->mtd.name);
+		kfree(mtd->name);
 	return ret;
 }
 
@@ -321,10 +323,11 @@ err1:
 static int fun_remove(struct platform_device *ofdev)
 {
 	struct fsl_upm_nand *fun = dev_get_drvdata(&ofdev->dev);
+	struct mtd_info *mtd = nand_to_mtd(&fun->chip);
 	int i;
 
-	nand_release(&fun->mtd);
-	kfree(fun->mtd.name);
+	nand_release(mtd);
+	kfree(mtd->name);
 
 	for (i = 0; i < fun->mchip_count; i++) {
 		if (fun->rnb_gpio[i] < 0)
-- 
2.1.4
