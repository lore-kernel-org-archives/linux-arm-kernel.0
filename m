From: anup.patel@broadcom.com (Anup Patel)
Date: Fri, 15 Jul 2016 14:34:01 +0530
Subject: [PATCH 6/8] uio: UIO_IRQ_NONE is a valid option for uioinfo->irq
In-Reply-To: <1468573443-4670-1-git-send-email-anup.patel@broadcom.com>
References: <1468573443-4670-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1468573443-4670-7-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jan Viktorin <viktorin@rehivetech.com>

We can simplify handling of platform_get_irq into one place as it is
acceptable to see UIO_IRQ_NONE instead of a valid IRQ number. Some
devices don't have or don't need any interrupt to be handled. The
same change has been already done for uio_pdrv_genirq.

Signed-off-by: Jan Viktorin <viktorin@rehivetech.com>
---
 drivers/uio/uio_dmem_genirq.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/uio/uio_dmem_genirq.c b/drivers/uio/uio_dmem_genirq.c
index e1134a4..a4d6d81 100644
--- a/drivers/uio/uio_dmem_genirq.c
+++ b/drivers/uio/uio_dmem_genirq.c
@@ -154,8 +154,6 @@ static int uio_dmem_genirq_probe(struct platform_device *pdev)
 	int i;
 
 	if (pdev->dev.of_node) {
-		int irq;
-
 		/* alloc uioinfo for one device */
 		uioinfo = kzalloc(sizeof(*uioinfo), GFP_KERNEL);
 		if (!uioinfo) {
@@ -165,13 +163,6 @@ static int uio_dmem_genirq_probe(struct platform_device *pdev)
 		}
 		uioinfo->name = pdev->dev.of_node->name;
 		uioinfo->version = "devicetree";
-
-		/* Multiple IRQs are not supported */
-		irq = platform_get_irq(pdev, 0);
-		if (irq == -ENXIO)
-			uioinfo->irq = UIO_IRQ_NONE;
-		else
-			uioinfo->irq = irq;
 	}
 
 	if (!uioinfo || !uioinfo->name || !uioinfo->version) {
@@ -200,14 +191,18 @@ static int uio_dmem_genirq_probe(struct platform_device *pdev)
 	priv->pdev = pdev;
 	mutex_init(&priv->alloc_lock);
 
+	/* Multiple IRQs are not supported */
 	if (!uioinfo->irq) {
 		ret = platform_get_irq(pdev, 0);
-		if (ret < 0) {
+		uioinfo->irq = ret;
+		if (ret == -ENXIO && pdev->dev.of_node)
+			uioinfo->irq = UIO_IRQ_NONE;
+		else if (ret < 0) {
 			dev_err(&pdev->dev, "failed to get IRQ\n");
 			goto bad1;
 		}
-		uioinfo->irq = ret;
 	}
+
 	uiomem = &uioinfo->mem[0];
 
 	for (i = 0; i < pdev->num_resources; ++i) {
-- 
1.9.1
