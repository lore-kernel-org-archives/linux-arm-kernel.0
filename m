From: shc_work@mail.ru (Alexander Shiyan)
Date: Mon, 13 May 2013 21:07:25 +0400
Subject: [PATCH RESEND v2 3/3] GPIO: clps711x: Add DT support
In-Reply-To: <1368464857-5038-1-git-send-email-shc_work@mail.ru>
References: <1368464857-5038-1-git-send-email-shc_work@mail.ru>
Message-ID: <1368464857-5038-6-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT support to the CLPS711X GPIO driver.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 .../devicetree/bindings/gpio/gpio-clps711x.txt     | 28 ++++++++++++++++++++++
 drivers/gpio/gpio-clps711x.c                       | 14 ++++++++---
 2 files changed, 39 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-clps711x.txt

diff --git a/Documentation/devicetree/bindings/gpio/gpio-clps711x.txt b/Documentation/devicetree/bindings/gpio/gpio-clps711x.txt
new file mode 100644
index 0000000..e0d0446
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-clps711x.txt
@@ -0,0 +1,28 @@
+Cirrus Logic CLPS711X GPIO controller
+
+Required properties:
+- compatible: Should be "cirrus,clps711x-gpio"
+- reg: Physical base GPIO controller registers location and length.
+  There should be two registers, first is DATA register, the second
+  is DIRECTION.
+- gpio-controller: Marks the device node as a gpio controller.
+- #gpio-cells: Should be two. The first cell is the pin number and
+  the second cell is used to specify the gpio polarity:
+    0 = active high
+    1 = active low
+
+Note: Each GPIO port should have an alias correctly numbered in "aliases"
+node.
+
+Example:
+
+aliases {
+	gpio0 = &porta;
+};
+
+porta: gpio at 80000000 {
+	compatible = "cirrus,clps711x-gpio";
+	reg = <0x80000000 0x1>, <0x80000040 0x1>;
+	gpio-controller;
+	#gpio-cells = <2>;
+};
diff --git a/drivers/gpio/gpio-clps711x.c b/drivers/gpio/gpio-clps711x.c
index 6ce8a8c..0edaf2c 100644
--- a/drivers/gpio/gpio-clps711x.c
+++ b/drivers/gpio/gpio-clps711x.c
@@ -17,10 +17,11 @@
 
 static int clps711x_gpio_probe(struct platform_device *pdev)
 {
+	struct device_node *np = pdev->dev.of_node;
 	void __iomem *dat, *dir;
 	struct bgpio_chip *bgc;
 	struct resource *res;
-	int err, id = pdev->id;
+	int err, id = np ? of_alias_get_id(np, "gpio") : pdev->id;
 
 	if ((id < 0) || (id > 4))
 		return -ENODEV;
@@ -76,10 +77,17 @@ static int clps711x_gpio_remove(struct platform_device *pdev)
 	return bgpio_remove(bgc);
 }
 
+static const struct of_device_id clps711x_gpio_ids[] = {
+	{ .compatible = "cirrus,clps711x-gpio" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, clps711x_gpio_ids);
+
 static struct platform_driver clps711x_gpio_driver = {
 	.driver	= {
-		.name	= "clps711x-gpio",
-		.owner	= THIS_MODULE,
+		.name		= "clps711x-gpio",
+		.owner		= THIS_MODULE,
+		.of_match_table	= of_match_ptr(clps711x_gpio_ids),
 	},
 	.probe	= clps711x_gpio_probe,
 	.remove	= clps711x_gpio_remove,
-- 
1.8.1.5
