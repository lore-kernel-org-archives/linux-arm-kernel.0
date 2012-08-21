From: ludovic.desroches@atmel.com (ludovic.desroches at atmel.com)
Date: Tue, 21 Aug 2012 16:29:02 +0200
Subject: [PATCH 2/5] i2c: at91: add dt support to i2c-at91
In-Reply-To: <1345559345-13988-1-git-send-email-ludovic.desroches@atmel.com>
References: <1345559345-13988-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1345559345-13988-3-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 .../devicetree/bindings/i2c/atmel-i2c.txt          | 29 +++++++++++++
 drivers/i2c/busses/i2c-at91.c                      | 49 +++++++++++++++++-----
 2 files changed, 68 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/atmel-i2c.txt

diff --git a/Documentation/devicetree/bindings/i2c/atmel-i2c.txt b/Documentation/devicetree/bindings/i2c/atmel-i2c.txt
new file mode 100644
index 0000000..9e46289
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/atmel-i2c.txt
@@ -0,0 +1,29 @@
+I2C for Atmel platforms
+
+Required properties :
+- compatible : Must be "atmel,at91rm9200-i2c", "atmel,at91sam9261-i2c" or
+     "atmel,at91sam9g20-i2c"
+- reg: physical base address of the controller and length of memory mapped
+     region.
+- interrupts: interrupt number to the cpu.
+- #address-cells = <1>;
+- #size-cells = <0>;
+
+Optional properties:
+- Child nodes conforming to i2c bus binding
+
+Examples :
+
+i2c0: i2c at fff84000 {
+	compatible = "atmel,at91sam9g20-i2c";
+	reg = <0xfff84000 0x100>;
+	interrupts = <12 4>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	24c512 at 50 {
+		compatible = "24c512";
+		reg = <0x50>;
+		pagesize = <128>;
+	}
+}
diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
index 4599522..1c86b24 100644
--- a/drivers/i2c/busses/i2c-at91.c
+++ b/drivers/i2c/busses/i2c-at91.c
@@ -24,6 +24,9 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_i2c.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
@@ -112,17 +115,27 @@ static void at91_init_twi_bus(struct at91_twi_dev *dev)
  */
 static void __devinit at91_calc_twi_clock(struct at91_twi_dev *dev, int twi_clk)
 {
-	int offset, div, max_ckdiv, ckdiv, cdiv;
-
-	if (cpu_is_at91rm9200()) {
-		offset = 3;
-		max_ckdiv = 5;
-	} else if (cpu_is_at91sam9261()) {
-		offset = 4;
-		max_ckdiv = 5;
+	int offset = 4, max_ckdiv = 7;
+	int div, ckdiv, cdiv;
+
+	if (dev->dev->of_node) {
+		if (of_device_is_compatible(dev->dev->of_node,
+					    "atmel,at91rm9200-i2c")) {
+			offset = 3;
+			max_ckdiv = 5;
+		} else if (of_device_is_compatible(dev->dev->of_node,
+						   "atmel,at91sam9261-i2c")) {
+			offset = 4;
+			max_ckdiv = 5;
+		}
 	} else {
-		offset = 4;
-		max_ckdiv = 7;
+		if (cpu_is_at91rm9200()) {
+			offset = 3;
+			max_ckdiv = 5;
+		} else if (cpu_is_at91sam9261()) {
+			offset = 4;
+			max_ckdiv = 5;
+		}
 	}
 
 	div = max(0, (int)DIV_ROUND_UP(clk_get_rate(dev->clk),
@@ -379,6 +392,7 @@ static int __devinit at91_twi_probe(struct platform_device *pdev)
 	dev->adapter.dev.parent = dev->dev;
 	dev->adapter.nr = pdev->id;
 	dev->adapter.timeout = AT91_I2C_TIMEOUT;
+	dev->adapter.dev.of_node = pdev->dev.of_node;
 
 	rc = i2c_add_numbered_adapter(&dev->adapter);
 	if (rc) {
@@ -387,6 +401,8 @@ static int __devinit at91_twi_probe(struct platform_device *pdev)
 		goto err_free_irq;
 	}
 
+	of_i2c_register_devices(&dev->adapter);
+
 	dev_info(dev->dev, "AT91 i2c bus driver.\n");
 	return 0;
 
@@ -454,12 +470,25 @@ static const struct dev_pm_ops at91_twi_pm = {
 #define at91_twi_pm_ops NULL
 #endif
 
+#ifdef CONFIG_OF
+static const struct of_device_id at91_twi_dt_ids[] = {
+	{ .compatible = "atmel,at91rm9200-i2c", },
+	{ .compatible = "atmel,at91sam9260-i2c", },
+	{ .compatible = "atmel,at91sam9261-i2c", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, at91_twi_dt_ids);
+#else
+#define at91_twi_dt_ids NULL
+#endif
+
 static struct platform_driver at91_twi_driver = {
 	.probe		= at91_twi_probe,
 	.remove		= __devexit_p(at91_twi_remove),
 	.driver		= {
 		.name	= "at91_i2c",
 		.owner	= THIS_MODULE,
+		.of_match_table = at91_twi_dt_ids,
 		.pm	= at91_twi_pm_ops,
 	},
 };
-- 
1.7.11.3
