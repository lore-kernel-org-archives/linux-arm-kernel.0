From: shubhrajyoti@ti.com (Shubhrajyoti D)
Date: Tue, 11 Sep 2012 15:12:06 +0530
Subject: [PATCHv7 11/23] i2c: omap: switch to platform_get_irq()
In-Reply-To: <1347356538-23835-1-git-send-email-shubhrajyoti@ti.com>
References: <1347356538-23835-1-git-send-email-shubhrajyoti@ti.com>
Message-ID: <1347356538-23835-12-git-send-email-shubhrajyoti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Felipe Balbi <balbi@ti.com>

that's a nice helper from drivers core which
will give us the exact IRQ number, instead
of a pointer to an IRQ resource.

Signed-off-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index bac1f11..0da8169 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -993,11 +993,12 @@ omap_i2c_probe(struct platform_device *pdev)
 {
 	struct omap_i2c_dev	*dev;
 	struct i2c_adapter	*adap;
-	struct resource		*mem, *irq;
+	struct resource		*mem;
 	struct omap_i2c_bus_platform_data *pdata = pdev->dev.platform_data;
 	struct device_node	*node = pdev->dev.of_node;
 	const struct of_device_id *match;
 	irq_handler_t isr;
+	int irq;
 	int r;
 
 	/* NOTE: driver uses the static register mapping */
@@ -1006,10 +1007,11 @@ omap_i2c_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "no mem resource?\n");
 		return -ENODEV;
 	}
-	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!irq) {
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
 		dev_err(&pdev->dev, "no irq resource?\n");
-		return -ENODEV;
+		return irq;
 	}
 
 	dev = devm_kzalloc(&pdev->dev, sizeof(struct omap_i2c_dev), GFP_KERNEL);
@@ -1043,7 +1045,7 @@ omap_i2c_probe(struct platform_device *pdev)
 	}
 
 	dev->dev = &pdev->dev;
-	dev->irq = irq->start;
+	dev->irq = irq;
 
 	platform_set_drvdata(pdev, dev);
 	init_completion(&dev->cmd_complete);
-- 
1.7.5.4
