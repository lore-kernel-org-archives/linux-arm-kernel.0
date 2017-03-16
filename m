From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 16 Mar 2017 09:36:00 +0100
Subject: [PATCH v2 3/3] mtd: nand: atmel: Add PM ops
In-Reply-To: <1489653360-17973-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1489653360-17973-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1489653360-17973-4-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide a ->resume() hook to make sure the NAND timings are correctly
restored by resetting all chips connected to the controller.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/atmel/nand-controller.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/mtd/nand/atmel/nand-controller.c b/drivers/mtd/nand/atmel/nand-controller.c
index f974c4e92392..b90da79317f0 100644
--- a/drivers/mtd/nand/atmel/nand-controller.c
+++ b/drivers/mtd/nand/atmel/nand-controller.c
@@ -2507,6 +2507,24 @@ static int atmel_nand_controller_remove(struct platform_device *pdev)
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
