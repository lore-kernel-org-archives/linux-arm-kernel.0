From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 18 Nov 2013 16:54:36 +0100
Subject: [RESEND PATCH v3 2/4] usb: musb: Bugfix of_node assignment
In-Reply-To: <1384790078-15366-1-git-send-email-mpa@pengutronix.de>
References: <1384790078-15366-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1384790078-15366-3-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is not safe to assign the of_node to a device without driver. The
device is matched against a list of drivers and the of_node could lead
to a DT match with the parent driver.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/usb/musb/musb_core.c | 12 +++++++++++-
 drivers/usb/musb/musb_dsps.c |  1 -
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 8b7d903..d5ad9db 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1966,6 +1966,7 @@ static int musb_probe(struct platform_device *pdev)
 	int		irq = platform_get_irq_byname(pdev, "mc");
 	struct resource	*iomem;
 	void __iomem	*base;
+	int ret;
 
 	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!iomem || irq <= 0)
@@ -1975,7 +1976,16 @@ static int musb_probe(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	return musb_init_controller(dev, irq, base);
+	if (dev->parent)
+		dev->of_node = dev->parent->of_node;
+
+	ret = musb_init_controller(dev, irq, base);
+	if (ret) {
+		dev->of_node = NULL;
+		return ret;
+	}
+
+	return 0;
 }
 
 static int musb_remove(struct platform_device *pdev)
diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index 82e1da0..7b36d32 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -485,7 +485,6 @@ static int dsps_create_musb_pdev(struct dsps_glue *glue,
 	musb->dev.parent		= dev;
 	musb->dev.dma_mask		= &musb_dmamask;
 	musb->dev.coherent_dma_mask	= musb_dmamask;
-	musb->dev.of_node		= of_node_get(dn);
 
 	glue->musb = musb;
 
-- 
1.8.4.2
