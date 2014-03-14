From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Fri, 14 Mar 2014 18:22:09 +0100
Subject: [PATCH] ata: ahci_platform: fix devm_ioremap_resource() return value
 checking
Message-ID: <2139783.QvectlX5nq@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

devm_ioremap_resource() returns a pointer to the remapped memory or
an ERR_PTR() encoded error code on failure.  Fix the check inside
ahci_platform_get_resources() accordingly.

Also while at it remove a needless line break.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
Compile tested only.

 drivers/ata/ahci_platform.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: b/drivers/ata/ahci_platform.c
===================================================================
--- a/drivers/ata/ahci_platform.c	2014-03-14 16:45:04.056724383 +0100
+++ b/drivers/ata/ahci_platform.c	2014-03-14 17:54:12.504653647 +0100
@@ -199,8 +199,7 @@ static void ahci_platform_put_resources(
  * RETURNS:
  * The allocated ahci_host_priv on success, otherwise an ERR_PTR value
  */
-struct ahci_host_priv *ahci_platform_get_resources(
-	struct platform_device *pdev)
+struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct ahci_host_priv *hpriv;
@@ -219,8 +218,9 @@ struct ahci_host_priv *ahci_platform_get
 
 	hpriv->mmio = devm_ioremap_resource(dev,
 			      platform_get_resource(pdev, IORESOURCE_MEM, 0));
-	if (!hpriv->mmio) {
+	if (IS_ERR(hpriv->mmio)) {
 		dev_err(dev, "no mmio space\n");
+		rc = PTR_ERR(hpriv->mmio);
 		goto err_out;
 	}
 
