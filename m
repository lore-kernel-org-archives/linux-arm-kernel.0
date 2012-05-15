From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 15 May 2012 12:13:19 +0800
Subject: [PATCH] gpio/mxs: add .request and .free to hook in pinctrl calls
Message-ID: <1337055199-24753-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add .request and .free to gpio_chip for hooking in pinctrl calls.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/gpio/gpio-mxs.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/drivers/gpio/gpio-mxs.c b/drivers/gpio/gpio-mxs.c
index 429228b..7c817f9 100644
--- a/drivers/gpio/gpio-mxs.c
+++ b/drivers/gpio/gpio-mxs.c
@@ -32,6 +32,7 @@
 #include <linux/slab.h>
 #include <linux/basic_mmio_gpio.h>
 #include <linux/module.h>
+#include <linux/pinctrl/consumer.h>
 
 #define MXS_SET		0x4
 #define MXS_CLR		0x8
@@ -197,6 +198,16 @@ static int mxs_gpio_to_irq(struct gpio_chip *gc, unsigned offset)
 	return port->virtual_irq_start + offset;
 }
 
+static int mxs_gpio_request(struct gpio_chip *gc, unsigned offset)
+{
+	return pinctrl_request_gpio(gc->base + offset);
+}
+
+static void mxs_gpio_free(struct gpio_chip *gc, unsigned offset)
+{
+	return pinctrl_free_gpio(gc->base + offset);
+}
+
 static struct platform_device_id mxs_gpio_ids[] = {
 	{
 		.name = "imx23-gpio",
@@ -290,6 +301,8 @@ static int __devinit mxs_gpio_probe(struct platform_device *pdev)
 		return err;
 
 	port->bgc.gc.to_irq = mxs_gpio_to_irq;
+	port->bgc.gc.request = mxs_gpio_request;
+	port->bgc.gc.free = mxs_gpio_free;
 	port->bgc.gc.base = port->id * 32;
 
 	err = gpiochip_add(&port->bgc.gc);
-- 
1.7.4.1
