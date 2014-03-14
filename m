From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Fri, 14 Mar 2014 18:33:13 +0100
Subject: [PATCH] ata: pata_imx: fix devm_ioremap_resource() return value
 checking
Message-ID: <2050303.yEm1sTq1hQ@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

devm_ioremap_resource() returns a pointer to the remapped memory or
an ERR_PTR() encoded error code on failure.  Fix the check inside
pata_imx_probe() accordingly.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
Compile tested only.

 drivers/ata/pata_imx.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: b/drivers/ata/pata_imx.c
===================================================================
--- a/drivers/ata/pata_imx.c	2014-03-14 16:45:04.260724378 +0100
+++ b/drivers/ata/pata_imx.c	2014-03-14 18:23:38.664623530 +0100
@@ -133,8 +133,8 @@ static int pata_imx_probe(struct platfor
 
 	io_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	priv->host_regs = devm_ioremap_resource(&pdev->dev, io_res);
-	if (!priv->host_regs) {
-		ret = -EBUSY;
+	if (IS_ERR(priv->host_regs)) {
+		ret = PTR_ERR(priv->host_regs);
 		goto err;
 	}
 
