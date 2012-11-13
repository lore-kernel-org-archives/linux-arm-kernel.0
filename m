From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 13 Nov 2012 11:33:40 +0100
Subject: [PATCH] i2c: i2c-s3c2410: Add support for pinctrl
Message-ID: <14549510.veZygXpPkq@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for pin configuration using pinctrl subsystem
to the i2c-s3c2410 driver.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 .../devicetree/bindings/i2c/samsung-i2c.txt          | 20 ++++++++++++++++----
 drivers/i2c/busses/i2c-s3c2410.c                     | 12 ++++++++----
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/samsung-i2c.txt b/Documentation/devicetree/bindings/i2c/samsung-i2c.txt
index b6cb5a1..e9611ac 100644
--- a/Documentation/devicetree/bindings/i2c/samsung-i2c.txt
+++ b/Documentation/devicetree/bindings/i2c/samsung-i2c.txt
@@ -13,11 +13,17 @@ Required properties:
   - interrupts: interrupt number to the cpu.
   - samsung,i2c-sda-delay: Delay (in ns) applied to data line (SDA) edges.
 
+Required for all cases except "samsung,s3c2440-hdmiphy-i2c":
+  - Samsung GPIO variant (deprecated):
+    - gpios: The order of the gpios should be the following: <SDA, SCL>.
+      The gpio specifier depends on the gpio controller. Required in all
+      cases except for "samsung,s3c2440-hdmiphy-i2c" whose input/output
+      lines are permanently wired to the respective clienta
+  - Pinctrl variant (preferred, if available):
+    - pinctrl-0: Pin control group to be used for this controller.
+    - pinctrl-names: Should contain only one value - "default".
+
 Optional properties:
-  - gpios: The order of the gpios should be the following: <SDA, SCL>.
-    The gpio specifier depends on the gpio controller. Required in all
-    cases except for "samsung,s3c2440-hdmiphy-i2c" whose input/output
-    lines are permanently wired to the respective client
   - samsung,i2c-slave-addr: Slave address in multi-master enviroment. If not
     specified, default value is 0.
   - samsung,i2c-max-bus-freq: Desired frequency in Hz of the bus. If not
@@ -31,8 +37,14 @@ Example:
 		interrupts = <345>;
 		samsung,i2c-sda-delay = <100>;
 		samsung,i2c-max-bus-freq = <100000>;
+		/* Samsung GPIO variant begins here */
 		gpios = <&gpd1 2 0 /* SDA */
 			 &gpd1 3 0 /* SCL */>;
+		/* Samsung GPIO variant ends here */
+		/* Pinctrl variant begins here */
+		pinctrl-0 = <&i2c3_bus>;
+		pinctrl-names = "default";
+		/* Pinctrl variant ends here */
 		#address-cells = <1>;
 		#size-cells = <0>;
 
diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
index 3e0335f..ae4304b 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -38,6 +38,7 @@
 #include <linux/io.h>
 #include <linux/of_i2c.h>
 #include <linux/of_gpio.h>
+#include <linux/pinctrl/consumer.h>
 
 #include <asm/irq.h>
 
@@ -83,6 +84,7 @@ struct s3c24xx_i2c {
 
 	struct s3c2410_platform_i2c	*pdata;
 	int			gpios[2];
+	struct pinctrl          *pctrl;
 #ifdef CONFIG_CPU_FREQ
 	struct notifier_block	freq_transition;
 #endif
@@ -861,9 +863,8 @@ static int s3c24xx_i2c_init(struct s3c24xx_i2c *i2c)
 
 	if (pdata->cfg_gpio)
 		pdata->cfg_gpio(to_platform_device(i2c->dev));
-	else
-		if (s3c24xx_i2c_parse_dt_gpio(i2c))
-			return -EINVAL;
+	else if (IS_ERR(i2c->pctrl) && s3c24xx_i2c_parse_dt_gpio(i2c))
+		return -EINVAL;
 
 	/* write slave address */
 
@@ -1013,6 +1014,8 @@ static int s3c24xx_i2c_probe(struct platform_device *pdev)
 	i2c->adap.algo_data = i2c;
 	i2c->adap.dev.parent = &pdev->dev;
 
+	i2c->pctrl = devm_pinctrl_get_select_default(i2c->dev);
+
 	/* initialise the i2c controller */
 
 	ret = s3c24xx_i2c_init(i2c);
@@ -1112,7 +1115,8 @@ static int s3c24xx_i2c_remove(struct platform_device *pdev)
 	iounmap(i2c->regs);
 
 	release_resource(i2c->ioarea);
-	s3c24xx_i2c_dt_gpio_free(i2c);
+	if (pdev->dev.of_node && IS_ERR(i2c->pctrl))
+		s3c24xx_i2c_dt_gpio_free(i2c);
 	kfree(i2c->ioarea);
 
 	return 0;
-- 
1.8.0
