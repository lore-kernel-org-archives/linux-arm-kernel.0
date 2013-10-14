From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 14 Oct 2013 15:50:38 +0200
Subject: [PATCH v2 2/3] usb: musb: Bugfix of_node assignment
In-Reply-To: <1381758639-30300-1-git-send-email-mpa@pengutronix.de>
References: <1381758639-30300-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1381758639-30300-3-git-send-email-mpa@pengutronix.de>
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
index baa4f6a..a26eccd 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1962,6 +1962,7 @@ static int musb_probe(struct platform_device *pdev)
 	int		irq = platform_get_irq_byname(pdev, "mc");
 	struct resource	*iomem;
 	void __iomem	*base;
+	int ret;
 
 	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!iomem || irq <= 0)
@@ -1971,7 +1972,16 @@ static int musb_probe(struct platform_device *pdev)
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
index bd4138d..189e52c 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -483,7 +483,6 @@ static int dsps_create_musb_pdev(struct dsps_glue *glue,
 	musb->dev.parent		= dev;
 	musb->dev.dma_mask		= &musb_dmamask;
 	musb->dev.coherent_dma_mask	= musb_dmamask;
-	musb->dev.of_node		= of_node_get(dn);
 
 	glue->musb = musb;
 
-- 
1.8.4.rc3
