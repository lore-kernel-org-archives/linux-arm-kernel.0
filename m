From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Wed, 26 Nov 2014 15:59:49 +0200
Subject: [PATCH v2 1/5] i2c: i2c-davinci: switch to use platform_get_irq
In-Reply-To: <1417010393-30598-1-git-send-email-grygorii.strashko@ti.com>
References: <1417010393-30598-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <1417010393-30598-2-git-send-email-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch Davinci I2C driver to use platform_get_irq(), because
it is not recommened to use platform_get_resource(pdev, IORESOURCE_IRQ, ..)
for requesting IRQ resources any more, as they can be not ready yet
in case of DT-boot.

CC: Sekhar Nori <nsekhar@ti.com>
CC: Kevin Hilman <khilman@deeprootsystems.com>
CC: Santosh Shilimkar <ssantosh@kernel.org>
CC: Murali Karicheri <m-karicheri2@ti.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/i2c/busses/i2c-davinci.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index 4d96147..7f54903 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -640,13 +640,17 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 {
 	struct davinci_i2c_dev *dev;
 	struct i2c_adapter *adap;
-	struct resource *mem, *irq;
-	int r;
-
-	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!irq) {
-		dev_err(&pdev->dev, "no irq resource?\n");
-		return -ENODEV;
+	struct resource *mem;
+	int r, irq;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq <= 0) {
+		if (irq == -EPROBE_DEFER)
+			return irq;
+		if (!irq)
+			irq = -ENXIO;
+		dev_err(&pdev->dev, "can't get irq resource ret=%d\n", irq);
+		return irq;
 	}
 
 	dev = devm_kzalloc(&pdev->dev, sizeof(struct davinci_i2c_dev),
@@ -661,7 +665,7 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 	init_completion(&dev->xfr_complete);
 #endif
 	dev->dev = &pdev->dev;
-	dev->irq = irq->start;
+	dev->irq = irq;
 	dev->pdata = dev_get_platdata(&pdev->dev);
 	platform_set_drvdata(pdev, dev);
 
-- 
1.9.1
