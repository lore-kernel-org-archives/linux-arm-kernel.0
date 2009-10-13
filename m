From: shinya.kuribayashi@necel.com (Shinya Kuribayashi)
Date: Tue, 13 Oct 2009 11:49:18 +0900
Subject: [PATCH 03/16] i2c-designware: Use platform_get_irq helper
In-Reply-To: <4AD3E974.8080200@necel.com>
References: <4AD3E974.8080200@necel.com>
Message-ID: <4AD3EAAE.7070505@necel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi@necel.com>
---
 drivers/i2c/busses/i2c-designware.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware.c b/drivers/i2c/busses/i2c-designware.c
index efddae1..0164092 100644
--- a/drivers/i2c/busses/i2c-designware.c
+++ b/drivers/i2c/busses/i2c-designware.c
@@ -543,8 +543,8 @@ static int __devinit dw_i2c_probe(struct platform_device *pdev)
 {
 	struct dw_i2c_dev *dev;
 	struct i2c_adapter *adap;
-	struct resource *mem, *irq, *ioarea;
-	int r;
+	struct resource *mem, *ioarea;
+	int irq, r;
 
 	/* NOTE: driver uses the static register mapping */
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -553,10 +553,10 @@ static int __devinit dw_i2c_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!irq) {
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
 		dev_err(&pdev->dev, "no irq resource?\n");
-		return -EINVAL;
+		return irq; /* -ENXIO */
 	}
 
 	ioarea = request_mem_region(mem->start, resource_size(mem),
@@ -576,7 +576,7 @@ static int __devinit dw_i2c_probe(struct platform_device *pdev)
 	tasklet_init(&dev->pump_msg, dw_i2c_pump_msg, (unsigned long) dev);
 	mutex_init(&dev->lock);
 	dev->dev = get_device(&pdev->dev);
-	dev->irq = irq->start;
+	dev->irq = irq;
 	platform_set_drvdata(pdev, dev);
 
 	dev->clk = clk_get(&pdev->dev, NULL);
-- 
1.6.5
