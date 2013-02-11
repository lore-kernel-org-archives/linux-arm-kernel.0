From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Tue, 12 Feb 2013 01:10:50 +0800
Subject: [PATCH v8 03/12] gpio: pl061: allocate irq dynamically
In-Reply-To: <1360602659-4774-1-git-send-email-haojian.zhuang@linaro.org>
References: <1360602659-4774-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1360602659-4774-4-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In original implementation, irq base is always specified in platform
data. If it's not specified, pl061 gpio driver can't pass the probe()
function since irq base is missing. While moving to device tree, everything
should be parsed from DTS file. So allocate irq dynamically for irq
base.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 drivers/gpio/gpio-pl061.c |   16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-pl061.c b/drivers/gpio/gpio-pl061.c
index b820869..1a6d05c 100644
--- a/drivers/gpio/gpio-pl061.c
+++ b/drivers/gpio/gpio-pl061.c
@@ -15,6 +15,7 @@
 #include <linux/io.h>
 #include <linux/ioport.h>
 #include <linux/irq.h>
+#include <linux/irqdomain.h>
 #include <linux/bitops.h>
 #include <linux/workqueue.h>
 #include <linux/gpio.h>
@@ -211,6 +212,10 @@ static void __init pl061_init_gc(struct pl061_gpio *chip, int irq_base)
 			       IRQ_GC_INIT_NESTED_LOCK, IRQ_NOREQUEST, 0);
 }
 
+static const struct irq_domain_ops pl061_domain_ops = {
+	.xlate	= irq_domain_xlate_twocell,
+};
+
 static int pl061_probe(struct amba_device *adev, const struct amba_id *id)
 {
 	struct device *dev = &adev->dev;
@@ -225,10 +230,15 @@ static int pl061_probe(struct amba_device *adev, const struct amba_id *id)
 	if (pdata) {
 		chip->gc.base = pdata->gpio_base;
 		chip->irq_base = pdata->irq_base;
-	} else if (adev->dev.of_node) {
+	} else {
 		chip->gc.base = -1;
-		chip->irq_base = 0;
-	} else
+		chip->irq_base = -1;
+	}
+	chip->irq_base = irq_alloc_descs(chip->irq_base, 0, PL061_GPIO_NR, 0);
+	if (chip->irq_base < 0)
+		return chip->irq_base;
+	if (!irq_domain_add_legacy(adev->dev.of_node, PL061_GPIO_NR,
+				   chip->irq_base, 0, &pl061_domain_ops, chip))
 		return -ENODEV;
 
 	if (!devm_request_mem_region(dev, adev->res.start,
-- 
1.7.10.4
