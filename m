From: w.egorov@phytec.de (Wadim Egorov)
Date: Fri, 15 Apr 2016 11:16:25 +0200
Subject: [PATCH 1/6] mfd: RK808: Make RK808 generic, rename rk808.c to rk8xx.c
In-Reply-To: <1460711790-22646-1-git-send-email-w.egorov@phytec.de>
References: <1460711790-22646-1-git-send-email-w.egorov@phytec.de>
Message-ID: <1460711790-22646-2-git-send-email-w.egorov@phytec.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Basically this patch just renames the RK808 driver so we can use this driver
for more than one RK8XX PMIC later.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 arch/arm/configs/multi_v7_defconfig |  2 +-
 drivers/clk/Kconfig                 |  2 +-
 drivers/mfd/Kconfig                 |  4 +-
 drivers/mfd/Makefile                |  2 +-
 drivers/mfd/{rk808.c => rk8xx.c}    | 88 ++++++++++++++++++-------------------
 drivers/regulator/Kconfig           |  2 +-
 drivers/rtc/Kconfig                 |  2 +-
 7 files changed, 51 insertions(+), 51 deletions(-)
 rename drivers/mfd/{rk808.c => rk8xx.c} (73%)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 2823490..ca995e9 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -454,7 +454,7 @@ CONFIG_MFD_MAX77686=y
 CONFIG_MFD_MAX77693=y
 CONFIG_MFD_MAX8907=y
 CONFIG_MFD_MAX8997=y
-CONFIG_MFD_RK808=y
+CONFIG_MFD_RK8XX=y
 CONFIG_MFD_PM8921_CORE=y
 CONFIG_MFD_QCOM_RPM=y
 CONFIG_MFD_SPMI_PMIC=y
diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 16f7d33..c2fd078 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -50,7 +50,7 @@ config COMMON_CLK_MAX77802
 
 config COMMON_CLK_RK808
 	tristate "Clock driver for RK808"
-	depends on MFD_RK808
+	depends on MFD_RK8XX
 	---help---
 	  This driver supports RK808 crystal oscillator clock. These
 	  multi-function devices have two fixed-rate oscillators,
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index eea61e3..dd585cb 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -813,8 +813,8 @@ config MFD_RC5T583
 	  Additional drivers must be enabled in order to use the
 	  different functionality of the device.
 
-config MFD_RK808
-	tristate "Rockchip RK808 Power Management chip"
+config MFD_RK8XX
+	tristate "Rockchip RK8XX Power Management chip"
 	depends on I2C && OF
 	select MFD_CORE
 	select REGMAP_I2C
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 5eaa6465d..dd9963f8 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -182,7 +182,7 @@ obj-$(CONFIG_MFD_INTEL_MSIC)	+= intel_msic.o
 obj-$(CONFIG_MFD_PALMAS)	+= palmas.o
 obj-$(CONFIG_MFD_VIPERBOARD)    += viperboard.o
 obj-$(CONFIG_MFD_RC5T583)	+= rc5t583.o rc5t583-irq.o
-obj-$(CONFIG_MFD_RK808)		+= rk808.o
+obj-$(CONFIG_MFD_RK8XX)		+= rk8xx.o
 obj-$(CONFIG_MFD_RN5T618)	+= rn5t618.o
 obj-$(CONFIG_MFD_SEC_CORE)	+= sec-core.o sec-irq.o
 obj-$(CONFIG_MFD_SYSCON)	+= syscon.o
diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk8xx.c
similarity index 73%
rename from drivers/mfd/rk808.c
rename to drivers/mfd/rk8xx.c
index 4b1e439..f68648e 100644
--- a/drivers/mfd/rk808.c
+++ b/drivers/mfd/rk8xx.c
@@ -1,5 +1,5 @@
 /*
- * MFD core driver for Rockchip RK808
+ * MFD core driver for Rockchip RK8XX
  *
  * Copyright (c) 2014, Fuzhou Rockchip Electronics Co., Ltd
  *
@@ -23,13 +23,13 @@
 #include <linux/module.h>
 #include <linux/regmap.h>
 
-struct rk808_reg_data {
+struct rk8xx_reg_data {
 	int addr;
 	int mask;
 	int value;
 };
 
-static bool rk808_is_volatile_reg(struct device *dev, unsigned int reg)
+static bool rk8xx_is_volatile_reg(struct device *dev, unsigned int reg)
 {
 	/*
 	 * Notes:
@@ -62,7 +62,7 @@ static const struct regmap_config rk808_regmap_config = {
 	.val_bits = 8,
 	.max_register = RK808_IO_POL_REG,
 	.cache_type = REGCACHE_RBTREE,
-	.volatile_reg = rk808_is_volatile_reg,
+	.volatile_reg = rk8xx_is_volatile_reg,
 };
 
 static struct resource rtc_resources[] = {
@@ -83,7 +83,7 @@ static const struct mfd_cell rk808s[] = {
 	},
 };
 
-static const struct rk808_reg_data pre_init_reg[] = {
+static const struct rk8xx_reg_data pre_init_reg[] = {
 	{ RK808_BUCK3_CONFIG_REG, BUCK_ILMIN_MASK,  BUCK_ILMIN_150MA },
 	{ RK808_BUCK4_CONFIG_REG, BUCK_ILMIN_MASK,  BUCK_ILMIN_200MA },
 	{ RK808_BOOST_CONFIG_REG, BOOST_ILMIN_MASK, BOOST_ILMIN_100MA },
@@ -148,30 +148,30 @@ static struct regmap_irq_chip rk808_irq_chip = {
 	.init_ack_masked = true,
 };
 
-static struct i2c_client *rk808_i2c_client;
-static void rk808_device_shutdown(void)
+static struct i2c_client *rk8xx_i2c_client;
+static void rk8xx_device_shutdown(void)
 {
 	int ret;
-	struct rk808 *rk808 = i2c_get_clientdata(rk808_i2c_client);
+	struct rk808 *rk8xx = i2c_get_clientdata(rk8xx_i2c_client);
 
-	if (!rk808) {
-		dev_warn(&rk808_i2c_client->dev,
-			 "have no rk808, so do nothing here\n");
+	if (!rk8xx) {
+		dev_warn(&rk8xx_i2c_client->dev,
+			 "have no rk8xx, so do nothing here\n");
 		return;
 	}
 
-	ret = regmap_update_bits(rk808->regmap,
+	ret = regmap_update_bits(rk8xx->regmap,
 				 RK808_DEVCTRL_REG,
 				 DEV_OFF_RST, DEV_OFF_RST);
 	if (ret)
-		dev_err(&rk808_i2c_client->dev, "power off error!\n");
+		dev_err(&rk8xx_i2c_client->dev, "power off error!\n");
 }
 
-static int rk808_probe(struct i2c_client *client,
+static int rk8xx_probe(struct i2c_client *client,
 		       const struct i2c_device_id *id)
 {
 	struct device_node *np = client->dev.of_node;
-	struct rk808 *rk808;
+	struct rk808 *rk8xx;
 	int pm_off = 0;
 	int ret;
 	int i;
@@ -181,18 +181,18 @@ static int rk808_probe(struct i2c_client *client,
 		return -EINVAL;
 	}
 
-	rk808 = devm_kzalloc(&client->dev, sizeof(*rk808), GFP_KERNEL);
-	if (!rk808)
+	rk8xx = devm_kzalloc(&client->dev, sizeof(*rk8xx), GFP_KERNEL);
+	if (!rk8xx)
 		return -ENOMEM;
 
-	rk808->regmap = devm_regmap_init_i2c(client, &rk808_regmap_config);
-	if (IS_ERR(rk808->regmap)) {
+	rk8xx->regmap = devm_regmap_init_i2c(client, &rk808_regmap_config);
+	if (IS_ERR(rk8xx->regmap)) {
 		dev_err(&client->dev, "regmap initialization failed\n");
-		return PTR_ERR(rk808->regmap);
+		return PTR_ERR(rk8xx->regmap);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(pre_init_reg); i++) {
-		ret = regmap_update_bits(rk808->regmap, pre_init_reg[i].addr,
+		ret = regmap_update_bits(rk8xx->regmap, pre_init_reg[i].addr,
 					 pre_init_reg[i].mask,
 					 pre_init_reg[i].value);
 		if (ret) {
@@ -202,20 +202,20 @@ static int rk808_probe(struct i2c_client *client,
 		}
 	}
 
-	ret = regmap_add_irq_chip(rk808->regmap, client->irq,
+	ret = regmap_add_irq_chip(rk8xx->regmap, client->irq,
 				  IRQF_ONESHOT, -1,
-				  &rk808_irq_chip, &rk808->irq_data);
+				  &rk808_irq_chip, &rk8xx->irq_data);
 	if (ret) {
 		dev_err(&client->dev, "Failed to add irq_chip %d\n", ret);
 		return ret;
 	}
 
-	rk808->i2c = client;
-	i2c_set_clientdata(client, rk808);
+	rk8xx->i2c = client;
+	i2c_set_clientdata(client, rk8xx);
 
 	ret = mfd_add_devices(&client->dev, -1,
 			      rk808s, ARRAY_SIZE(rk808s),
-			      NULL, 0, regmap_irq_get_domain(rk808->irq_data));
+			      NULL, 0, regmap_irq_get_domain(rk8xx->irq_data));
 	if (ret) {
 		dev_err(&client->dev, "failed to add MFD devices %d\n", ret);
 		goto err_irq;
@@ -224,53 +224,53 @@ static int rk808_probe(struct i2c_client *client,
 	pm_off = of_property_read_bool(np,
 				"rockchip,system-power-controller");
 	if (pm_off && !pm_power_off) {
-		rk808_i2c_client = client;
-		pm_power_off = rk808_device_shutdown;
+		rk8xx_i2c_client = client;
+		pm_power_off = rk8xx_device_shutdown;
 	}
 
 	return 0;
 
 err_irq:
-	regmap_del_irq_chip(client->irq, rk808->irq_data);
+	regmap_del_irq_chip(client->irq, rk8xx->irq_data);
 	return ret;
 }
 
-static int rk808_remove(struct i2c_client *client)
+static int rk8xx_remove(struct i2c_client *client)
 {
-	struct rk808 *rk808 = i2c_get_clientdata(client);
+	struct rk808 *rk8xx = i2c_get_clientdata(client);
 
-	regmap_del_irq_chip(client->irq, rk808->irq_data);
+	regmap_del_irq_chip(client->irq, rk8xx->irq_data);
 	mfd_remove_devices(&client->dev);
 	pm_power_off = NULL;
 
 	return 0;
 }
 
-static const struct of_device_id rk808_of_match[] = {
+static const struct of_device_id rk8xx_of_match[] = {
 	{ .compatible = "rockchip,rk808" },
 	{ },
 };
-MODULE_DEVICE_TABLE(of, rk808_of_match);
+MODULE_DEVICE_TABLE(of, rk8xx_of_match);
 
-static const struct i2c_device_id rk808_ids[] = {
+static const struct i2c_device_id rk8xx_ids[] = {
 	{ "rk808" },
 	{ },
 };
-MODULE_DEVICE_TABLE(i2c, rk808_ids);
+MODULE_DEVICE_TABLE(i2c, rk8xx_ids);
 
-static struct i2c_driver rk808_i2c_driver = {
+static struct i2c_driver rk8xx_i2c_driver = {
 	.driver = {
-		.name = "rk808",
-		.of_match_table = rk808_of_match,
+		.name = "rk8xx",
+		.of_match_table = rk8xx_of_match,
 	},
-	.probe    = rk808_probe,
-	.remove   = rk808_remove,
-	.id_table = rk808_ids,
+	.probe    = rk8xx_probe,
+	.remove   = rk8xx_remove,
+	.id_table = rk8xx_ids,
 };
 
-module_i2c_driver(rk808_i2c_driver);
+module_i2c_driver(rk8xx_i2c_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Chris Zhong <zyw@rock-chips.com>");
 MODULE_AUTHOR("Zhang Qing <zhangqing@rock-chips.com>");
-MODULE_DESCRIPTION("RK808 PMIC driver");
+MODULE_DESCRIPTION("RK8XX PMIC driver");
diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index c77dc08..f834079 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -610,7 +610,7 @@ config REGULATOR_RC5T583
 
 config REGULATOR_RK808
 	tristate "Rockchip RK808 Power regulators"
-	depends on MFD_RK808
+	depends on MFD_RK8XX
 	help
 	  Select this option to enable the power regulator of ROCKCHIP
 	  PMIC RK808.
diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 3e84315..e7cadc3 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -325,7 +325,7 @@ config RTC_DRV_MAX77686
 
 config RTC_DRV_RK808
 	tristate "Rockchip RK808 RTC"
-	depends on MFD_RK808
+	depends on MFD_RK8XX
 	help
 	  If you say yes here you will get support for the
 	  RTC of RK808 PMIC.
-- 
1.9.1
