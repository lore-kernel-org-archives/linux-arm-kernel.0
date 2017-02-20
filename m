From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 20 Feb 2017 18:16:18 +0100
Subject: [PATCH 3/3] mtd: nand: atmel: Add PM ops
In-Reply-To: <1487610978-12423-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1487610978-12423-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1487610978-12423-7-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide a ->resume() hook to make sure the NAND timings are correctly
restored by resetting all chips connected to the controller.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/atmel/nand-controller.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/mtd/nand/atmel/nand-controller.c b/drivers/mtd/nand/atmel/nand-controller.c
index ae46ef711d67..cd107e6edcbc 100644
--- a/drivers/mtd/nand/atmel/nand-controller.c
+++ b/drivers/mtd/nand/atmel/nand-controller.c
@@ -2575,6 +2575,24 @@ static int atmel_nand_controller_remove(struct platform_device *pdev)
 	return nc->caps->ops->remove(nc);
 }
 
+static int atmel_nand_controller_resume(struct device *dev)
+{
+	struct atmel_nand_controller *nc = dev_get_drvdata(dev);
+	struct atmel_nand *nand;
+
+	list_for_each_entry(nand, &nc->chips, node) {
+		int i;
+
+		for (i = 0; i < nand->numcs; i++)
+			nand_reset(&nand->base, i);
+	}
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(atmel_nand_controller_pm_ops, NULL,
+			 atmel_nand_controller_resume);
+
 static struct platform_driver atmel_nand_controller_driver = {
 	.driver = {
 		.name = "atmel-nand-controller",
-- 
2.7.4
