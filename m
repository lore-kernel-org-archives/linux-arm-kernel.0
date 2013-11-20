From: ivan.khoronzhuk@ti.com (Ivan Khoronzhuk)
Date: Wed, 20 Nov 2013 17:22:19 +0200
Subject: [PATCH 1/7] mtd: nand: davinci: fix driver registration
In-Reply-To: <1384960945-14528-1-git-send-email-ivan.khoronzhuk@ti.com>
References: <1384960945-14528-1-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <1384960945-14528-2-git-send-email-ivan.khoronzhuk@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When kernel is booted using DT, there is no guarantee that Davinci
NAND device has been created already at the time when driver init
function is executed. Therefore, platform_driver_probe() can't be used
because this may result the Davinci NAND driver will never be probed.
The driver probing has to be made with core mechanism.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 drivers/mtd/nand/davinci_nand.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/davinci_nand.c b/drivers/mtd/nand/davinci_nand.c
index b77a01e..d87213f 100644
--- a/drivers/mtd/nand/davinci_nand.c
+++ b/drivers/mtd/nand/davinci_nand.c
@@ -877,6 +877,7 @@ static int __exit nand_davinci_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver nand_davinci_driver = {
+	.probe		= nand_davinci_probe,
 	.remove		= __exit_p(nand_davinci_remove),
 	.driver		= {
 		.name	= "davinci_nand",
@@ -886,7 +887,7 @@ static struct platform_driver nand_davinci_driver = {
 };
 MODULE_ALIAS("platform:davinci_nand");
 
-module_platform_driver_probe(nand_davinci_driver, nand_davinci_probe);
+module_platform_driver(nand_davinci_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Texas Instruments");
-- 
1.7.9.5
