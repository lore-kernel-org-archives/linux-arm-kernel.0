From: aisheng.dong@nxp.com (A.s. Dong)
Date: Wed, 31 Oct 2018 14:43:08 +0000
Subject: [PATCH V3 04/10] gpio: vf610: add optional clock support
In-Reply-To: <1540996688-23681-1-git-send-email-aisheng.dong@nxp.com>
References: <1540996688-23681-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1540996688-23681-5-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some SoCs need the gpio clock to be enabled before accessing
HW registers. This patch add the optional clock handling.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Stefan Agner <stefan@agner.ch>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: linux-gpio at vger.kernel.org
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
v2->v3:
 * error checking updated according to Russell's suggestion:
   ptr == ERR_PTR(-EPROBE_DEFER)
 * clock independently checking
v1->v2:
 * new patch
---
 drivers/gpio/gpio-vf610.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
index d4ad6d0..02fb7d8 100644
--- a/drivers/gpio/gpio-vf610.c
+++ b/drivers/gpio/gpio-vf610.c
@@ -16,6 +16,7 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/gpio.h>
 #include <linux/init.h>
@@ -256,6 +257,7 @@ static int vf610_gpio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
+	struct clk *clk_gpio, *clk_port;
 	struct vf610_gpio_port *port;
 	struct resource *iores;
 	struct gpio_chip *gc;
@@ -280,6 +282,28 @@ static int vf610_gpio_probe(struct platform_device *pdev)
 	if (port->irq < 0)
 		return port->irq;
 
+	clk_port = devm_clk_get(&pdev->dev, "port");
+	if (clk_port == ERR_PTR(-EPROBE_DEFER))
+		return -EPROBE_DEFER;
+
+	clk_gpio = devm_clk_get(&pdev->dev, "gpio");
+	if (clk_gpio == ERR_PTR(-EPROBE_DEFER))
+		return -EPROBE_DEFER;
+
+	if (!IS_ERR_OR_NULL(clk_port)) {
+		ret = clk_prepare_enable(clk_port);
+		if (ret)
+			return ret;
+	}
+
+	if (!IS_ERR_OR_NULL(clk_gpio)) {
+		ret = clk_prepare_enable(clk_gpio);
+		if (ret) {
+			clk_disable_unprepare(clk_port);
+			return ret;
+		}
+	}
+
 	gc = &port->gc;
 	gc->of_node = np;
 	gc->parent = dev;
-- 
2.7.4
