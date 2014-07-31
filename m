From: sassmann@kpanic.de (Stefan Assmann)
Date: Thu, 31 Jul 2014 11:56:15 +0200
Subject: [PATCH 2/2] clk: initial clock driver for TWL6030
In-Reply-To: <20140730175033.GA17528@sirena.org.uk>
References: <1406728949-7560-1-git-send-email-sassmann@kpanic.de>
 <1406728949-7560-3-git-send-email-sassmann@kpanic.de>
 <20140730175033.GA17528@sirena.org.uk>
Message-ID: <53DA12BF.1060008@kpanic.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30.07.2014 19:50, Mark Brown wrote:
> On Wed, Jul 30, 2014 at 04:02:29PM +0200, Stefan Assmann wrote:
> 
>> +static int twl6030_clk32kg_is_prepared(struct clk_hw *hw)
>> +{
>> +	struct twl6030_desc *desc = to_twl6030_desc(hw);
>> +
>> +	return desc->enabled;
>> +}
> 
> Why not just check the register map - can't the register be cached?  If
> that's not possible a comment would be good.

I just took atl_clk_is_enabled() as template. If you say it's better
to read the value, that can be arranged.

> 
>> +static int of_twl6030_clk32kg_probe(struct platform_device *pdev)
>> +{
>> +	struct device_node *node = pdev->dev.of_node;
>> +	struct clk *clk;
>> +	int ret = 0;
>> +
>> +	if (!node)
>> +		return -ENODEV;
>> +
>> +	clk = clk_get(&pdev->dev, "clk32kg");
> 
> devm_clk_get()?

Changed.

> 
>> +	if (IS_ERR(clk))
>> +		ret = -EPROBE_DEFER;
> 
> Shouldn't the provided return code be being used?

Changed.

> 
>> +	else
>> +		clk_prepare(clk);
> 
> Why is the clock driver defaulting to enabling the clock, and if it
> needs to shouldn't it be doing a prepere_enable() even if the enable
> happens not to do anything to the hardware?  Otherwise child clocks
> might get confused.

Mike advised me to convert the functions from enable/disable to
prepare/unprepare because i2c transactions may sleep. That's what I did.
The code no longer enables the clock and just prepares it. So IIUC the
call to clk_prepare() should be fine.

> 
> The return value is also not being checked.
> 

Changed.

Thanks for your comments Mark, here's a new version of the patch.

  Stefan

>From 2c52040f33af9dbb41e3e3f355ae154843b277c6 Mon Sep 17 00:00:00 2001
From: Stefan Assmann <sassmann@kpanic.de>
Date: Fri, 25 Jul 2014 09:42:27 +0200
Subject: [PATCH] clk: initial clock driver for TWL6030

Adding a clock driver for the TI TWL6030. The driver prepares the
CLK32KG clock, which is required for the wireless LAN.

v2:
- use MODULE_LICENSE("GPL v2")
- use devm_clk_get() instead of clk_get()
- propagate return value of clk_prepare()
- read prepared state instead of using enabled variable

Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
---
 .../devicetree/bindings/clock/ti/twl6030.txt       |   4 +
 drivers/clk/Kconfig                                |   7 ++
 drivers/clk/ti/Makefile                            |   1 +
 drivers/clk/ti/clk-6030.c                          | 133 +++++++++++++++++++++
 drivers/mfd/twl-core.c                             |   3 +
 5 files changed, 148 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/ti/twl6030.txt
 create mode 100644 drivers/clk/ti/clk-6030.c

diff --git a/Documentation/devicetree/bindings/clock/ti/twl6030.txt b/Documentation/devicetree/bindings/clock/ti/twl6030.txt
new file mode 100644
index 0000000..d290ad4
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/ti/twl6030.txt
@@ -0,0 +1,4 @@
+Binding for TI TWL6030.
+
+Required properties:
+- compatible: "ti,twl6030-clk32kg"
diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 9f9c5ae..4e89e8b 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -65,6 +65,13 @@ config COMMON_CLK_S2MPS11
 	  clock. These multi-function devices have two (S2MPS14) or three
 	  (S2MPS11, S5M8767) fixed-rate oscillators, clocked at 32KHz each.

+config CLK_TWL6030
+	tristate "Clock driver for twl6030"
+	depends on TWL4030_CORE
+	---help---
+	  Enable the TWL6030 clock CLK32KG which is disabled by default.
+	  Needed on the Pandaboard for the wireless LAN.
+
 config CLK_TWL6040
 	tristate "External McPDM functional clock from twl6040"
 	depends on TWL6040_CORE
diff --git a/drivers/clk/ti/Makefile b/drivers/clk/ti/Makefile
index ed4d0aa..04f25ea 100644
--- a/drivers/clk/ti/Makefile
+++ b/drivers/clk/ti/Makefile
@@ -10,4 +10,5 @@ obj-$(CONFIG_SOC_OMAP5)			+= $(clk-common) clk-54xx.o
 obj-$(CONFIG_SOC_DRA7XX)		+= $(clk-common) clk-7xx.o \
 					   clk-dra7-atl.o
 obj-$(CONFIG_SOC_AM43XX)		+= $(clk-common) clk-43xx.o
+obj-$(CONFIG_CLK_TWL6030)		+= $(clk-common) clk-6030.o
 endif
diff --git a/drivers/clk/ti/clk-6030.c b/drivers/clk/ti/clk-6030.c
new file mode 100644
index 0000000..61d1834
--- /dev/null
+++ b/drivers/clk/ti/clk-6030.c
@@ -0,0 +1,133 @@
+/*
+ * drivers/clk/ti/clk-6030.c
+ *
+ *  Copyright (C) 2014 Stefan Assmann <sassmann@kpanic.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Clock driver for TI twl6030.
+ */
+
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/clkdev.h>
+#include <linux/clk-provider.h>
+#include <linux/i2c/twl.h>
+#include <linux/platform_device.h>
+
+struct twl6030_desc {
+	struct clk *clk;
+	struct clk_hw hw;
+};
+
+static int twl6030_clk32kg_prepare(struct clk_hw *hw)
+{
+	int ret;
+
+	ret = twl_i2c_write_u8(TWL_MODULE_PM_RECEIVER,
+			       TWL6030_GRP_CON << TWL6030_CFG_STATE_GRP_SHIFT |
+			       TWL6030_CFG_STATE_ON,
+			       TWL6030_PM_RECEIVER_CLK32KG_CFG_STATE);
+
+	return ret;
+}
+
+void twl6030_clk32kg_unprepare(struct clk_hw *hw)
+{
+	twl_i2c_write_u8(TWL_MODULE_PM_RECEIVER,
+			 TWL6030_GRP_CON << TWL6030_CFG_STATE_GRP_SHIFT |
+			 TWL6030_CFG_STATE_OFF,
+			 TWL6030_PM_RECEIVER_CLK32KG_CFG_STATE);
+}
+
+static int twl6030_clk32kg_is_prepared(struct clk_hw *hw)
+{
+	u8 is_prepared;
+
+	twl_i2c_read_u8(TWL_MODULE_PM_RECEIVER, &is_prepared,
+			TWL6030_PM_RECEIVER_CLK32KG_CFG_STATE);
+
+	return is_prepared & TWL6030_CFG_STATE_ON;
+}
+
+static const struct clk_ops twl6030_clk32kg_ops = {
+	.prepare	= twl6030_clk32kg_prepare,
+	.unprepare	= twl6030_clk32kg_unprepare,
+	.is_prepared	= twl6030_clk32kg_is_prepared,
+};
+
+static void __init of_ti_twl6030_clk32kg_setup(struct device_node *node)
+{
+	struct twl6030_desc *clk_hw = NULL;
+	struct clk_init_data init = { 0 };
+	struct clk_lookup *clookup;
+	struct clk *clk;
+
+	clookup = kzalloc(sizeof(*clookup), GFP_KERNEL);
+	if (!clookup) {
+		pr_err("%s: could not allocate clookup\n", __func__);
+		return;
+	}
+	clk_hw = kzalloc(sizeof(*clk_hw), GFP_KERNEL);
+	if (!clk_hw) {
+		pr_err("%s: could not allocate clk_hw\n", __func__);
+		goto err_clk_hw;
+	}
+
+	clk_hw->hw.init = &init;
+
+	init.name = node->name;
+	init.ops = &twl6030_clk32kg_ops;
+	init.flags = CLK_IS_ROOT;
+
+	clk = clk_register(NULL, &clk_hw->hw);
+	if (!IS_ERR(clk)) {
+		clookup->con_id = kstrdup("clk32kg", GFP_KERNEL);
+		clookup->clk = clk;
+		clkdev_add(clookup);
+
+		return;
+	}
+
+	kfree(clookup);
+err_clk_hw:
+	kfree(clk_hw);
+}
+CLK_OF_DECLARE(of_ti_twl6030_clk32kg, "ti,twl6030-clk32kg", of_ti_twl6030_clk32kg_setup);
+
+static int of_twl6030_clk32kg_probe(struct platform_device *pdev)
+{
+	struct device_node *node = pdev->dev.of_node;
+	struct clk *clk;
+
+	if (!node)
+		return -ENODEV;
+
+	clk = devm_clk_get(&pdev->dev, "clk32kg");
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	return clk_prepare(clk);
+}
+
+static struct of_device_id of_twl6030_clk32kg_match_tbl[] = {
+	{ .compatible = "ti,twl6030-clk32kg", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, of_twl6030_clk32kg_match_tbl);
+
+static struct platform_driver twl6030_clk_driver = {
+	.driver = {
+		.name = "twl6030-clk32kg",
+		.owner = THIS_MODULE,
+		.of_match_table = of_twl6030_clk32kg_match_tbl,
+	},
+	.probe = of_twl6030_clk32kg_probe,
+};
+module_platform_driver(twl6030_clk_driver);
+
+MODULE_AUTHOR("Stefan Assmann <sassmann@kpanic.de>");
+MODULE_DESCRIPTION("clock driver for TI SoC based boards with twl6030");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index db11b4f..440fe4e 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -34,6 +34,7 @@
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/err.h>
 #include <linux/device.h>
 #include <linux/of.h>
@@ -1012,6 +1013,8 @@ static void clocks_init(struct device *dev,
 	u32 rate;
 	u8 ctrl = HFCLK_FREQ_26_MHZ;

+	of_clk_init(NULL);
+
 	osc = clk_get(dev, "fck");
 	if (IS_ERR(osc)) {
 		printk(KERN_WARNING "Skipping twl internal clock init and "
-- 
1.9.3
