From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 14 Aug 2011 00:14:02 +0800
Subject: [PATCH v2 3/8] gpio/mxc: add .to_irq for gpio chip
In-Reply-To: <1313252047-8820-1-git-send-email-shawn.guo@linaro.org>
References: <1313252047-8820-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1313252047-8820-4-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It adds .to_irq support for gpio chip, so that __gpio_to_irq in
gpiolib becomes usable.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/gpio/gpio-mxc.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
index 4340aca..64aff20 100644
--- a/drivers/gpio/gpio-mxc.c
+++ b/drivers/gpio/gpio-mxc.c
@@ -337,6 +337,15 @@ static void __devinit mxc_gpio_get_hw(struct platform_device *pdev)
 	mxc_gpio_hwtype = hwtype;
 }
 
+static int mxc_gpio_to_irq(struct gpio_chip *gc, unsigned offset)
+{
+	struct bgpio_chip *bgc = to_bgpio_chip(gc);
+	struct mxc_gpio_port *port =
+		container_of(bgc, struct mxc_gpio_port, bgc);
+
+	return port->virtual_irq_start + offset;
+}
+
 static int __devinit mxc_gpio_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -403,6 +412,7 @@ static int __devinit mxc_gpio_probe(struct platform_device *pdev)
 	if (err)
 		goto out_iounmap;
 
+	port->bgc.gc.to_irq = mxc_gpio_to_irq;
 	port->bgc.gc.base = pdev->id * 32;
 	port->bgc.dir = port->bgc.read_reg(port->bgc.reg_dir);
 	port->bgc.data = port->bgc.read_reg(port->bgc.reg_set);
-- 
1.7.4.1
