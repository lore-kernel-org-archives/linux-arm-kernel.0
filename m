From: ivan.khoronzhuk@ti.com (Ivan Khoronzhuk)
Date: Tue, 17 Dec 2013 15:33:50 +0200
Subject: [PATCH v4 1/9] mtd: nand: davinci: fix driver registration
In-Reply-To: <1387285155-19182-1-git-send-email-ivan.khoronzhuk@ti.com>
References: <1387285155-19182-1-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <1387287230-19693-1-git-send-email-ivan.khoronzhuk@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When kernel is booted using DT, there is no guarantee that Davinci
NAND device has been created already at the time when driver init
function is executed. Therefore, platform_driver_probe() can't be used
because this may result the Davinci NAND driver will never be probed.
The driver probing has to be made with core mechanism.

Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
Reviewed-by: Taras Kondratiuk <taras@ti.com>
Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
---
 drivers/mtd/nand/davinci_nand.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/davinci_nand.c b/drivers/mtd/nand/davinci_nand.c
index b77a01e..584c1f4 100644
--- a/drivers/mtd/nand/davinci_nand.c
+++ b/drivers/mtd/nand/davinci_nand.c
@@ -487,7 +487,7 @@ static int nand_davinci_dev_ready(struct mtd_info *mtd)
  * ten ECC bytes plus the manufacturer's bad block marker byte, and
  * and not overlapping the default BBT markers.
  */
-static struct nand_ecclayout hwecc4_small __initconst = {
+static struct nand_ecclayout hwecc4_small = {
 	.eccbytes = 10,
 	.eccpos = { 0, 1, 2, 3, 4,
 		/* offset 5 holds the badblock marker */
@@ -503,7 +503,7 @@ static struct nand_ecclayout hwecc4_small __initconst = {
  * storing ten ECC bytes plus the manufacturer's bad block marker byte,
  * and not overlapping the default BBT markers.
  */
-static struct nand_ecclayout hwecc4_2048 __initconst = {
+static struct nand_ecclayout hwecc4_2048 = {
 	.eccbytes = 40,
 	.eccpos = {
 		/* at the end of spare sector */
@@ -585,7 +585,7 @@ static struct davinci_nand_pdata
 }
 #endif
 
-static int __init nand_davinci_probe(struct platform_device *pdev)
+static int nand_davinci_probe(struct platform_device *pdev)
 {
 	struct davinci_nand_pdata	*pdata;
 	struct davinci_nand_info	*info;
@@ -860,7 +860,7 @@ err_nomem:
 	return ret;
 }
 
-static int __exit nand_davinci_remove(struct platform_device *pdev)
+static int nand_davinci_remove(struct platform_device *pdev)
 {
 	struct davinci_nand_info *info = platform_get_drvdata(pdev);
 
@@ -877,7 +877,8 @@ static int __exit nand_davinci_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver nand_davinci_driver = {
-	.remove		= __exit_p(nand_davinci_remove),
+	.probe		= nand_davinci_probe,
+	.remove		= nand_davinci_remove,
 	.driver		= {
 		.name	= "davinci_nand",
 		.owner	= THIS_MODULE,
@@ -886,7 +887,7 @@ static struct platform_driver nand_davinci_driver = {
 };
 MODULE_ALIAS("platform:davinci_nand");
 
-module_platform_driver_probe(nand_davinci_driver, nand_davinci_probe);
+module_platform_driver(nand_davinci_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Texas Instruments");
-- 
1.7.9.5
