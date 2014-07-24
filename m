From: sassmann@kpanic.de (Stefan Assmann)
Date: Thu, 24 Jul 2014 17:03:32 +0200
Subject: [PATCH RFC 2/2] regulator: twl: Re-add clk32kg to get wifi working
In-Reply-To: <20140716212340.GZ17528@sirena.org.uk>
References: <1405338655-18415-1-git-send-email-sassmann@kpanic.de>
 <1405338655-18415-3-git-send-email-sassmann@kpanic.de>
 <20140714120051.GF6800@sirena.org.uk> <53C3C77F.7080208@kpanic.de>
 <20140714181338.GR6800@sirena.org.uk> <53C525A2.8080609@kpanic.de>
 <20140716212340.GZ17528@sirena.org.uk>
Message-ID: <53D12044.1060500@kpanic.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16.07.2014 23:23, Mark Brown wrote:
> On Tue, Jul 15, 2014 at 02:59:14PM +0200, Stefan Assmann wrote:
>
>> Looking at this more closely it seems to me that it's a regulator thing
>> after all. In the end it all boils down to a single register write.
>> twl_i2c_write_u8(TWL_MODULE_PM_RECEIVER, 0x41, 0x8e);
>> This is a write to the CLK32KG_CFG_STATE [1] register to power on the
>> device.
>
> The register description happening to mention power doesn't mean it's
> not functionally an enable for a clock.
>
>> I tried moving that to omap4xxx_dt_clk_init() but that won't work
>> because the twl core structures aren't initialized yet.
>
>> Any suggestions?
>
> Why not just add this to (or create a new) clock driver for the chip?
>

OK, here's a first attempt to add a clock driver for the twl6030. Let
me know if this is going the right direction and I'll post a proper
patchset.
Thanks!

   Stefan

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
index 0000000..3eb0f1a
--- /dev/null
+++ b/drivers/clk/ti/clk-6030.c
@@ -0,0 +1,147 @@
+/*
+ * drivers/clk/ti/clk-6030.c
+ *
+ *  Copyright (C) 2014 Stefan Assmann <sassmann@kpanic.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Clock driver for ti twl6030.
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
+	bool enabled;
+};
+
+#define to_twl6030_desc(_hw) container_of(_hw, struct twl6030_desc, hw)
+
+static int twl6030_clk32kg_enable(struct clk_hw *hw)
+{
+	struct twl6030_desc *desc = to_twl6030_desc(hw);
+	int ret;
+
+	ret = twl_i2c_write_u8(TWL_MODULE_PM_RECEIVER,
+			       TWL6030_GRP_CON << TWL6030_CFG_STATE_GRP_SHIFT |
+			       TWL6030_CFG_STATE_ON,
+			       TWL6030_PM_RECEIVER_CLK32KG_CFG_STATE);
+	if (ret == 0)
+		desc->enabled = true;
+
+	return ret;
+}
+void twl6030_clk32kg_disable(struct clk_hw *hw)
+{
+	struct twl6030_desc *desc = to_twl6030_desc(hw);
+
+	twl_i2c_write_u8(TWL_MODULE_PM_RECEIVER,
+			 TWL6030_GRP_CON << TWL6030_CFG_STATE_GRP_SHIFT |
+			 TWL6030_CFG_STATE_OFF,
+			 TWL6030_PM_RECEIVER_CLK32KG_CFG_STATE);
+	desc->enabled = false;
+}
+
+static int twl6030_clk32kg_is_enabled(struct clk_hw *hw)
+{
+	struct twl6030_desc *desc = to_twl6030_desc(hw);
+
+	return desc->enabled;
+}
+
+static const struct clk_ops twl6030_clk32kg_ops = {
+	.enable		= twl6030_clk32kg_enable,
+	.disable	= twl6030_clk32kg_disable,
+	.is_enabled	= twl6030_clk32kg_is_enabled,
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
+	int ret = 0;
+
+	if (!node)
+		return -ENODEV;
+
+	clk = clk_get(&pdev->dev, "clk32kg");
+	if (IS_ERR(clk))
+		ret = -EPROBE_DEFER;
+	else
+		clk_prepare_enable(clk);
+
+	return ret;
+}
+
+static int of_twl6030_clk32kg_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static struct of_device_id of_twl6030_clk32kg_match_tbl[] = {
+	{ .compatible = "ti,twl6030-clk32kg", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, of_twl6030_clk32kg_match_tbl);
+
+static struct platform_driver dra7_atl_clk_driver = {
+	.driver = {
+		.name = "twl6030-clk32kg",
+		.owner = THIS_MODULE,
+		.of_match_table = of_twl6030_clk32kg_match_tbl,
+	},
+	.probe = of_twl6030_clk32kg_probe,
+	.remove = of_twl6030_clk32kg_remove,
+};
+module_platform_driver(dra7_atl_clk_driver);
+
+MODULE_AUTHOR("Stefan Assmann <sassmann@kpanic.de>");
+MODULE_DESCRIPTION("clock driver for TI SoC based boards with twl6030");
+MODULE_LICENSE("GPL");
diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index db11b4f..fd332d6 100644
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
@@ -459,9 +460,15 @@ int twl_i2c_write(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes)
  	if (!regmap)
  		return -EPERM;

-	ret = regmap_bulk_write(regmap, twl_priv->twl_map[mod_no].base + reg,
-				value, num_bytes);
-
+	if (num_bytes == 1) {
+		ret = regmap_write(regmap,
+				   twl_priv->twl_map[mod_no].base + reg,
+				   *value);
+	} else {
+		ret = regmap_bulk_write(regmap,
+					twl_priv->twl_map[mod_no].base + reg,
+					value, num_bytes);
+	}
  	if (ret)
  		pr_err("%s: Write failed (mod %d, reg 0x%02x count %d)\n",
  		       DRIVER_NAME, mod_no, reg, num_bytes);
@@ -482,14 +489,22 @@ EXPORT_SYMBOL(twl_i2c_write);
  int twl_i2c_read(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes)
  {
  	struct regmap *regmap = twl_get_regmap(mod_no);
+	unsigned int val;
  	int ret;

  	if (!regmap)
  		return -EPERM;

-	ret = regmap_bulk_read(regmap, twl_priv->twl_map[mod_no].base + reg,
-			       value, num_bytes);
-
+	if (num_bytes == 1) {
+		ret = regmap_read(regmap,
+				  twl_priv->twl_map[mod_no].base + reg,
+				  &val);
+		*value = val;
+	} else {
+		ret = regmap_bulk_read(regmap,
+				       twl_priv->twl_map[mod_no].base + reg,
+				       value, num_bytes);
+	}
  	if (ret)
  		pr_err("%s: Read failed (mod %d, reg 0x%02x count %d)\n",
  		       DRIVER_NAME, mod_no, reg, num_bytes);
@@ -1012,6 +1027,8 @@ static void clocks_init(struct device *dev,
  	u32 rate;
  	u8 ctrl = HFCLK_FREQ_26_MHZ;

+	of_clk_init(NULL);
+
  	osc = clk_get(dev, "fck");
  	if (IS_ERR(osc)) {
  		printk(KERN_WARNING "Skipping twl internal clock init and "
diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
index fed28ab..ad0dd22 100644
--- a/drivers/regulator/twl-regulator.c
+++ b/drivers/regulator/twl-regulator.c
@@ -94,17 +94,6 @@ struct twlreg_info {
  #define VREG_BC_PROC		3
  #define VREG_BC_CLK_RST		4

-/* TWL6030 LDO register values for CFG_STATE */
-#define TWL6030_CFG_STATE_OFF	0x00
-#define TWL6030_CFG_STATE_ON	0x01
-#define TWL6030_CFG_STATE_OFF2	0x02
-#define TWL6030_CFG_STATE_SLEEP	0x03
-#define TWL6030_CFG_STATE_GRP_SHIFT	5
-#define TWL6030_CFG_STATE_APP_SHIFT	2
-#define TWL6030_CFG_STATE_APP_MASK	(0x03 << TWL6030_CFG_STATE_APP_SHIFT)
-#define TWL6030_CFG_STATE_APP(v)	(((v) & TWL6030_CFG_STATE_APP_MASK) >>\
-						TWL6030_CFG_STATE_APP_SHIFT)
-
  /* Flags for SMPS Voltage reading */
  #define SMPS_OFFSET_EN		BIT(0)
  #define SMPS_EXTENDED_EN	BIT(1)
diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
index 8cfb50f..8ad63a2 100644
--- a/include/linux/i2c/twl.h
+++ b/include/linux/i2c/twl.h
@@ -127,6 +127,20 @@ enum twl6030_module_ids {
  #define REG_INT_MSK_STS_B		0x07
  #define REG_INT_MSK_STS_C		0x08

+/* TWL6030 register values for CFG_STATE */
+#define TWL6030_GRP_APP			(1 << 0)
+#define TWL6030_GRP_CON			(1 << 1)
+#define TWL6030_GRP_MOD			(1 << 2)
+#define TWL6030_CFG_STATE_OFF		0x00
+#define TWL6030_CFG_STATE_ON		0x01
+#define TWL6030_CFG_STATE_OFF2		0x02
+#define TWL6030_CFG_STATE_SLEEP		0x03
+#define TWL6030_CFG_STATE_GRP_SHIFT	5
+#define TWL6030_CFG_STATE_APP_SHIFT	2
+#define TWL6030_CFG_STATE_APP_MASK	(0x03 << TWL6030_CFG_STATE_APP_SHIFT)
+#define TWL6030_CFG_STATE_APP(v)	(((v) & TWL6030_CFG_STATE_APP_MASK) >>\
+						TWL6030_CFG_STATE_APP_SHIFT)
+
  /* MASK INT REG GROUP A */
  #define TWL6030_PWR_INT_MASK 		0x07
  #define TWL6030_RTC_INT_MASK 		0x18
@@ -470,6 +484,12 @@ static inline int twl6030_mmc_card_detect(struct device *dev, int slot)

  #define TWL4030_PM_MASTER_GLOBAL_TST		0xb6

+/*
+ * PM Receiver module register offsets (use TWL_MODULE_PM_RECEIVER)
+ */
+
+#define TWL6030_PM_RECEIVER_CLK32KG_CFG_STATE	0x8e
+
  /*----------------------------------------------------------------------*/

  /* Power bus message definitions */
-- 
1.9.3
