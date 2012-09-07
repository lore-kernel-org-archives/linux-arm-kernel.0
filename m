From: lee.jones@linaro.org (Lee Jones)
Date: Fri,  7 Sep 2012 12:14:57 +0100
Subject: [PATCH 17/19] mfd: Enable the tc3589x for Device Tree
In-Reply-To: <1347016499-29354-1-git-send-email-lee.jones@linaro.org>
References: <1347016499-29354-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1347016499-29354-18-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here we provide a means to probe and extract vital information
from Device Tree when booting with it enabled. Without this
patch sub-devices wouldn't be able to reference the tc3589x
from Device Tree.

CC: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/tc3589x.c |   43 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 40 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/tc3589x.c b/drivers/mfd/tc3589x.c
index 2df44ac..8f4c853 100644
--- a/drivers/mfd/tc3589x.c
+++ b/drivers/mfd/tc3589x.c
@@ -12,6 +12,7 @@
 #include <linux/irqdomain.h>
 #include <linux/slab.h>
 #include <linux/i2c.h>
+#include <linux/of.h>
 #include <linux/mfd/core.h>
 #include <linux/mfd/tc3589x.h>
 
@@ -146,6 +147,7 @@ static struct mfd_cell tc3589x_dev_gpio[] = {
 		.name		= "tc3589x-gpio",
 		.num_resources	= ARRAY_SIZE(gpio_resources),
 		.resources	= &gpio_resources[0],
+		.of_compatible	= "tc3589x-gpio",
 	},
 };
 
@@ -154,6 +156,7 @@ static struct mfd_cell tc3589x_dev_keypad[] = {
 		.name           = "tc3589x-keypad",
 		.num_resources  = ARRAY_SIZE(keypad_resources),
 		.resources      = &keypad_resources[0],
+		.of_compatible	= "tc3589x-keypad",
 	},
 };
 
@@ -221,7 +224,7 @@ static struct irq_domain_ops tc3589x_irq_ops = {
         .xlate  = irq_domain_xlate_twocell,
 };
 
-static int tc3589x_irq_init(struct tc3589x *tc3589x)
+static int tc3589x_irq_init(struct tc3589x *tc3589x, struct device_node *np)
 {
 	int base = tc3589x->irq_base;
 
@@ -232,7 +235,7 @@ static int tc3589x_irq_init(struct tc3589x *tc3589x)
 	}
 	else {
 		tc3589x->domain = irq_domain_add_linear(
-			NULL, TC3589x_NR_INTERNAL_IRQS,
+			np, TC3589x_NR_INTERNAL_IRQS,
 			&tc3589x_irq_ops, tc3589x);
 	}
 
@@ -309,13 +312,47 @@ static int __devinit tc3589x_device_init(struct tc3589x *tc3589x)
 	return ret;
 }
 
+static int tc3589x_of_probe(struct device_node *np,
+			struct tc3589x_platform_data *pdata)
+{
+	struct device_node *child;
+
+	for_each_child_of_node(np, child) {
+		if (!strcmp(child->name, "tc3589x_gpio")) {
+			pdata->block |= TC3589x_BLOCK_GPIO;
+		}
+		if (!strcmp(child->name, "tc3589x_keypad")) {
+			pdata->block |= TC3589x_BLOCK_KEYPAD;
+		}
+	}
+
+	return 0;
+}
+
 static int __devinit tc3589x_probe(struct i2c_client *i2c,
 				   const struct i2c_device_id *id)
 {
 	struct tc3589x_platform_data *pdata = i2c->dev.platform_data;
+	struct device_node *np = i2c->dev.of_node;
 	struct tc3589x *tc3589x;
 	int ret;
 
+	if (!pdata) {
+		if (np) {
+			pdata = devm_kzalloc(&i2c->dev, sizeof(*pdata), GFP_KERNEL);
+			if (!pdata)
+				return -ENOMEM;
+
+			ret = tc3589x_of_probe(np, pdata);
+			if (ret)
+				return ret;
+		}
+		else {
+			dev_err(&i2c->dev, "No platform data or DT found\n");
+			return -EINVAL;
+		}
+	}
+
 	if (!i2c_check_functionality(i2c->adapter, I2C_FUNC_SMBUS_BYTE_DATA
 				     | I2C_FUNC_SMBUS_I2C_BLOCK))
 		return -EIO;
@@ -338,7 +375,7 @@ static int __devinit tc3589x_probe(struct i2c_client *i2c,
 	if (ret)
 		goto out_free;
 
-	ret = tc3589x_irq_init(tc3589x);
+	ret = tc3589x_irq_init(tc3589x, np);
 	if (ret)
 		goto out_free;
 
-- 
1.7.9.5
