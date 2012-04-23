From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 23 Apr 2012 13:30:32 +0200
Subject: [PATCH 5/9 v2] gpio/nomadik: use ioremap() instead of static mappings
Message-ID: <1335180632-21381-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

We were using a custom io_p2v() (physical-to-virtual) translation
macro, but it's fully possible to just ioremap() this memory
now, so skip use of static addresses altogether.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-nomadik.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-nomadik.c b/drivers/gpio/gpio-nomadik.c
index 7b45d88..bddc3dd 100644
--- a/drivers/gpio/gpio-nomadik.c
+++ b/drivers/gpio/gpio-nomadik.c
@@ -28,7 +28,6 @@
 
 #include <plat/pincfg.h>
 #include <plat/gpio-nomadik.h>
-#include <mach/hardware.h>
 #include <asm/gpio.h>
 
 /*
@@ -1139,6 +1138,7 @@ static int __devinit nmk_gpio_probe(struct platform_device *dev)
 	struct resource *res;
 	struct clk *clk;
 	int secondary_irq;
+	void __iomem *base;
 	int irq;
 	int ret;
 
@@ -1169,10 +1169,16 @@ static int __devinit nmk_gpio_probe(struct platform_device *dev)
 		goto out;
 	}
 
+	base = ioremap(res->start, resource_size(res));
+	if (!base) {
+		ret = -ENOMEM;
+		goto out_release;
+	}
+
 	clk = clk_get(&dev->dev, NULL);
 	if (IS_ERR(clk)) {
 		ret = PTR_ERR(clk);
-		goto out_release;
+		goto out_unmap;
 	}
 
 	nmk_chip = kzalloc(sizeof(*nmk_chip), GFP_KERNEL);
@@ -1186,7 +1192,7 @@ static int __devinit nmk_gpio_probe(struct platform_device *dev)
 	 */
 	nmk_chip->bank = dev->id;
 	nmk_chip->clk = clk;
-	nmk_chip->addr = io_p2v(res->start);
+	nmk_chip->addr = base;
 	nmk_chip->chip = nmk_gpio_template;
 	nmk_chip->parent_irq = irq;
 	nmk_chip->secondary_parent_irq = secondary_irq;
@@ -1226,6 +1232,8 @@ out_free:
 out_clk:
 	clk_disable(clk);
 	clk_put(clk);
+out_unmap:
+	iounmap(base);
 out_release:
 	release_mem_region(res->start, resource_size(res));
 out:
-- 
1.7.9.2
