From: viresh.kumar@st.com (Viresh KUMAR)
Date: Mon, 21 Jun 2010 12:27:43 +0530
Subject: [PATCH V2] GPIO PL061: Adding Clk framework support
Message-ID: <1277103463-7311-1-git-send-email-viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Viresh KUMAR <viresh.kumar@st.com>

GPIO Clk is never enabled on Platforms, like: SPEAr, which are based upon clock
framework and use PL061 driver. This patch adds support for Clk enabling and
disabling as and when gpios are requested and freed.

Modifications since V1:
 - Removed usage_count, as already done by clk framework.
 - Checking error case of clk_enable.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/gpio/pl061.c |   37 ++++++++++++++++++++++++++++++++++---
 1 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/pl061.c b/drivers/gpio/pl061.c
index 105701a..fd37349 100644
--- a/drivers/gpio/pl061.c
+++ b/drivers/gpio/pl061.c
@@ -11,7 +11,10 @@
  *
  * Data sheet: ARM DDI 0190B, September 2000
  */
+
+#include <linux/clk.h>
 #include <linux/spinlock.h>
+#include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/module.h>
 #include <linux/list.h>
@@ -56,8 +59,26 @@ struct pl061_gpio {
 	void __iomem		*base;
 	unsigned		irq_base;
 	struct gpio_chip	gc;
+	struct clk		*clk;
 };
 
+static int pl061_request(struct gpio_chip *gc, unsigned offset)
+{
+	struct pl061_gpio *chip = container_of(gc, struct pl061_gpio, gc);
+
+	if (offset >= gc->ngpio)
+		return -EINVAL;
+
+	return clk_enable(chip->clk);
+}
+
+static void pl061_free(struct gpio_chip *gc, unsigned offset)
+{
+	struct pl061_gpio *chip = container_of(gc, struct pl061_gpio, gc);
+
+	clk_disable(chip->clk);
+}
+
 static int pl061_direction_input(struct gpio_chip *gc, unsigned offset)
 {
 	struct pl061_gpio *chip = container_of(gc, struct pl061_gpio, gc);
@@ -260,10 +281,18 @@ static int __init pl061_probe(struct amba_device *dev, struct amba_id *id)
 		goto release_region;
 	}
 
+	chip->clk = clk_get(&dev->dev, NULL);
+	if (IS_ERR(chip->clk)) {
+		ret = PTR_ERR(chip->clk);
+		goto iounmap;
+	}
+
 	spin_lock_init(&chip->lock);
 	spin_lock_init(&chip->irq_lock);
 	INIT_LIST_HEAD(&chip->list);
 
+	chip->gc.request = pl061_request;
+	chip->gc.free = pl061_free;
 	chip->gc.direction_input = pl061_direction_input;
 	chip->gc.direction_output = pl061_direction_output;
 	chip->gc.get = pl061_get_value;
@@ -279,7 +308,7 @@ static int __init pl061_probe(struct amba_device *dev, struct amba_id *id)
 
 	ret = gpiochip_add(&chip->gc);
 	if (ret)
-		goto iounmap;
+		goto free_clk;
 
 	/*
 	 * irq_chip support
@@ -292,7 +321,7 @@ static int __init pl061_probe(struct amba_device *dev, struct amba_id *id)
 	irq = dev->irq[0];
 	if (irq < 0) {
 		ret = -ENODEV;
-		goto iounmap;
+		goto free_clk;
 	}
 	set_irq_chained_handler(irq, pl061_irq_handler);
 	if (!test_and_set_bit(irq, init_irq)) { /* list initialized? */
@@ -300,7 +329,7 @@ static int __init pl061_probe(struct amba_device *dev, struct amba_id *id)
 		if (chip_list == NULL) {
 			clear_bit(irq, init_irq);
 			ret = -ENOMEM;
-			goto iounmap;
+			goto free_clk;
 		}
 		INIT_LIST_HEAD(chip_list);
 		set_irq_data(irq, chip_list);
@@ -323,6 +352,8 @@ static int __init pl061_probe(struct amba_device *dev, struct amba_id *id)
 
 	return 0;
 
+free_clk:
+	clk_put(chip->clk);
 iounmap:
 	iounmap(chip->base);
 release_region:
-- 
1.6.0.2
