From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Thu,  1 Mar 2012 14:10:21 +0800
Subject: [PATCH 1/8] gpio: pxa: add OF support
In-Reply-To: <1330582228-12424-1-git-send-email-haojian.zhuang@marvell.com>
References: <1330582228-12424-1-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1330582228-12424-2-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gpio-pxa drivers needs to parse two properties: mrvl,gpio-irq0 and
mrvl,gpio-irq1.

There may be 3 irqs in gpio devices in arch-pxa. The first one may
be only for gpio0, the second on may be only for gpio1, and the last
one may be the irq mux for other gpios. In arch-mmp, there's only
one irq mux for all gpios.

Since irq mux is common, we only specify it in interrupts propery.
And we creates two properties mrvl,gpio-irq0 and mrvl,gpio-irq1 for
arch-pxa.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/gpio/gpio-pxa.c |   40 +++++++++++++++++++++++++++++++++++++---
 1 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index b2d3ee1..7d8e1d0 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -18,6 +18,7 @@
 #include <linux/init.h>
 #include <linux/irq.h>
 #include <linux/io.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/syscore_ops.h>
 #include <linux/slab.h>
@@ -464,6 +465,39 @@ static int pxa_gpio_nums(void)
 	return count;
 }
 
+#ifdef CONFIG_OF
+static int __devinit pxa_gpio_probe_dt(struct platform_device *pdev,
+				       int *irq0, int *irq1, int *irq_mux)
+{
+	struct device_node *np = pdev->dev.of_node;
+	const __be32 *irq;
+
+	irq = of_get_property(np, "mrvl,gpio-irq0", NULL);
+	if (irq)
+		*irq0 = be32_to_cpup(irq);
+	irq = of_get_property(np, "mrvl,gpio-irq1", NULL);
+	if (irq)
+		*irq1 = be32_to_cpup(irq);
+	*irq_mux = platform_get_irq(pdev, 0);
+	return 0;
+}
+#else
+static int __devinit pxa_gpio_probe_dt(struct platform_device *pdev,
+				       int *irq0, int *irq1, int *irq_mux)
+{
+	return 1;
+}
+#endif
+
+static int __devinit pxa_gpio_probe_irq(struct platform_device *pdev,
+					int *irq0, int *irq1, int *irq_mux)
+{
+	*irq0 = platform_get_irq_byname(pdev, "gpio0");
+	*irq1 = platform_get_irq_byname(pdev, "gpio1");
+	*irq_mux = platform_get_irq_byname(pdev, "gpio_mux");
+	return 0;
+}
+
 static int __devinit pxa_gpio_probe(struct platform_device *pdev)
 {
 	struct pxa_gpio_chip *c;
@@ -476,9 +510,9 @@ static int __devinit pxa_gpio_probe(struct platform_device *pdev)
 	if (!pxa_last_gpio)
 		return -EINVAL;
 
-	irq0 = platform_get_irq_byname(pdev, "gpio0");
-	irq1 = platform_get_irq_byname(pdev, "gpio1");
-	irq_mux = platform_get_irq_byname(pdev, "gpio_mux");
+	ret = pxa_gpio_probe_dt(pdev, &irq0, &irq1, &irq_mux);
+	if (ret > 0)
+		ret = pxa_gpio_probe_irq(pdev, &irq0, &irq1, &irq_mux);
 	if ((irq0 > 0 && irq1 <= 0) || (irq0 <= 0 && irq1 > 0)
 		|| (irq_mux <= 0))
 		return -EINVAL;
-- 
1.7.0.4
