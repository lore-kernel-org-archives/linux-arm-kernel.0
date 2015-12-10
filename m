From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 10 Dec 2015 09:00:06 +0100
Subject: [PATCH v4 22/58] mtd: nand: gpio: use the mtd instance embedded in
 struct nand_chip
In-Reply-To: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1449734442-18672-23-git-send-email-boris.brezillon@free-electrons.com>
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
 drivers/mtd/nand/gpio.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/nand/gpio.c b/drivers/mtd/nand/gpio.c
index d57a07a..99dd74c 100644
--- a/drivers/mtd/nand/gpio.c
+++ b/drivers/mtd/nand/gpio.c
@@ -35,12 +35,14 @@
 
 struct gpiomtd {
 	void __iomem		*io_sync;
-	struct mtd_info		mtd_info;
 	struct nand_chip	nand_chip;
 	struct gpio_nand_platdata plat;
 };
 
-#define gpio_nand_getpriv(x) container_of(x, struct gpiomtd, mtd_info)
+static inline struct gpiomtd *gpio_nand_getpriv(struct mtd_info *mtd)
+{
+	return container_of(mtd_to_nand(mtd), struct gpiomtd, nand_chip);
+}
 
 
 #ifdef CONFIG_ARM
@@ -195,7 +197,7 @@ static int gpio_nand_remove(struct platform_device *pdev)
 {
 	struct gpiomtd *gpiomtd = platform_get_drvdata(pdev);
 
-	nand_release(&gpiomtd->mtd_info);
+	nand_release(nand_to_mtd(&gpiomtd->nand_chip));
 
 	if (gpio_is_valid(gpiomtd->plat.gpio_nwp))
 		gpio_set_value(gpiomtd->plat.gpio_nwp, 0);
@@ -208,6 +210,7 @@ static int gpio_nand_probe(struct platform_device *pdev)
 {
 	struct gpiomtd *gpiomtd;
 	struct nand_chip *chip;
+	struct mtd_info *mtd;
 	struct resource *res;
 	int ret = 0;
 
@@ -274,24 +277,24 @@ static int gpio_nand_probe(struct platform_device *pdev)
 	chip->chip_delay	= gpiomtd->plat.chip_delay;
 	chip->cmd_ctrl		= gpio_nand_cmd_ctrl;
 
-	gpiomtd->mtd_info.priv	= chip;
-	gpiomtd->mtd_info.dev.parent = &pdev->dev;
+	mtd			= nand_to_mtd(chip);
+	mtd->priv		= chip;
+	mtd->dev.parent		= &pdev->dev;
 
 	platform_set_drvdata(pdev, gpiomtd);
 
 	if (gpio_is_valid(gpiomtd->plat.gpio_nwp))
 		gpio_direction_output(gpiomtd->plat.gpio_nwp, 1);
 
-	if (nand_scan(&gpiomtd->mtd_info, 1)) {
+	if (nand_scan(mtd, 1)) {
 		ret = -ENXIO;
 		goto err_wp;
 	}
 
 	if (gpiomtd->plat.adjust_parts)
-		gpiomtd->plat.adjust_parts(&gpiomtd->plat,
-					   gpiomtd->mtd_info.size);
+		gpiomtd->plat.adjust_parts(&gpiomtd->plat, mtd->size);
 
-	ret = mtd_device_register(&gpiomtd->mtd_info, gpiomtd->plat.parts,
+	ret = mtd_device_register(mtd, gpiomtd->plat.parts,
 				  gpiomtd->plat.num_parts);
 	if (!ret)
 		return 0;
-- 
2.1.4
