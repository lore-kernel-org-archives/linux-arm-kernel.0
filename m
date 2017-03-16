From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 16 Mar 2017 09:30:34 +0100
Subject: [PATCH v2 7/7] memory: atmel-ebi: Add PM ops
In-Reply-To: <1489653034-17777-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1489653034-17777-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1489653034-17777-8-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a ->resume() hook to make sure the EBI dev configs are correctly
restored when resuming the platform.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/memory/atmel-ebi.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/memory/atmel-ebi.c b/drivers/memory/atmel-ebi.c
index 7d24a957e98c..35910f945bfa 100644
--- a/drivers/memory/atmel-ebi.c
+++ b/drivers/memory/atmel-ebi.c
@@ -507,6 +507,8 @@ static int atmel_ebi_probe(struct platform_device *pdev)
 	if (!ebi)
 		return -ENOMEM;
 
+	platform_set_drvdata(pdev, ebi);
+
 	INIT_LIST_HEAD(&ebi->devs);
 	ebi->caps = match->data;
 	ebi->dev = dev;
@@ -579,10 +581,28 @@ static int atmel_ebi_probe(struct platform_device *pdev)
 	return of_platform_populate(np, NULL, NULL, dev);
 }
 
+static int atmel_ebi_resume(struct device *dev)
+{
+	struct atmel_ebi *ebi = dev_get_drvdata(dev);
+	struct atmel_ebi_dev *ebid;
+
+	list_for_each_entry(ebid, &ebi->devs, node) {
+		int i;
+
+		for (i = 0; i < ebid->numcs; i++)
+			ebid->ebi->caps->apply_config(ebid, &ebid->configs[i]);
+	}
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(atmel_ebi_pm_ops, NULL, atmel_ebi_resume);
+
 static struct platform_driver atmel_ebi_driver = {
 	.driver = {
 		.name = "atmel-ebi",
 		.of_match_table	= atmel_ebi_id_table,
+		.pm = &atmel_ebi_pm_ops,
 	},
 };
 builtin_platform_driver_probe(atmel_ebi_driver, atmel_ebi_probe);
-- 
2.7.4
