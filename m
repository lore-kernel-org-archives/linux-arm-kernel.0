From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Fri,  8 Jul 2011 18:20:25 +0800
Subject: [PATCH] regulator: convert devicetree to platform data on max8649
In-Reply-To: <1310120428-22700-8-git-send-email-haojian.zhuang@marvell.com>
References: <1310120428-22700-1-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-2-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-3-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-4-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-5-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-6-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-7-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-8-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1310120428-22700-9-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/regulator/max8649.c |   70 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 70 insertions(+), 0 deletions(-)

diff --git a/drivers/regulator/max8649.c b/drivers/regulator/max8649.c
index 30eb9e5..4316a37 100644
--- a/drivers/regulator/max8649.c
+++ b/drivers/regulator/max8649.c
@@ -15,6 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/regulator/driver.h>
 #include <linux/slab.h>
+#include <linux/of_regulator.h>
 #include <linux/regulator/max8649.h>
 
 #define MAX8649_DCDC_VMIN	750000		/* uV */
@@ -275,6 +276,69 @@ static struct regulator_desc dcdc_desc = {
 	.owner		= THIS_MODULE,
 };
 
+#ifdef CONFIG_OF_REGULATOR
+static struct max8649_platform_data __devinit
+*max8649_get_alt_pdata(struct i2c_client *client)
+{
+	struct device_node *np = client->dev.of_node;
+	struct max8649_platform_data *pdata;
+	const __be32 *mode, *extclk, *ramp;
+	int ret = 0;
+
+	if (np == NULL)
+		goto out;
+
+	mode = of_get_property(np, "max8649-mode", NULL);
+	if (mode == NULL) {
+		dev_err(&client->dev, "mode property is missed\n");
+		goto out;
+	}
+	extclk = of_get_property(np, "ext-clock-frequency", NULL);
+	if (extclk == NULL)
+		dev_dbg(&client->dev, "ext-clock-frequency is not set\n");
+	ramp = of_get_property(np, "max8649-ramp", NULL);
+	if (ramp == NULL) {
+		dev_err(&client->dev, "ramp is missed\n");
+		goto out;
+	}
+
+	pdata = kzalloc(sizeof(struct max8649_platform_data), GFP_KERNEL);
+	if (pdata == NULL)
+		goto out;
+	pdata->mode = be32_to_cpu(*mode);
+	if (extclk) {
+		pdata->extclk = 1;
+		pdata->extclk_freq = be32_to_cpu(*extclk);
+	}
+	if (ramp) {
+		pdata->ramp_timing = be32_to_cpu(*ramp++);
+		pdata->ramp_down = be32_to_cpu(*ramp);
+	}
+
+	pdata->regulator = kzalloc(sizeof(struct regulator_init_data),
+				GFP_KERNEL);
+	if (pdata->regulator == NULL)
+		goto out_pdata;
+	ret = of_regulator_init_data(np, pdata->regulator);
+	if (ret < 0)
+		goto out_regulator;
+	return pdata;
+
+out_regulator:
+	kfree(pdata->regulator);
+out_pdata:
+	kfree(pdata);
+out:
+	return NULL;
+}
+#else
+static struct max8649_platform_data __devinit
+*max8649_get_alt_pdata(struct i2c_client *client)
+{
+	return 0;
+}
+#endif
+
 static int __devinit max8649_regulator_probe(struct i2c_client *client,
 					     const struct i2c_device_id *id)
 {
@@ -294,6 +358,12 @@ static int __devinit max8649_regulator_probe(struct i2c_client *client,
 	mutex_init(&info->io_lock);
 	i2c_set_clientdata(client, info);
 
+	if (pdata == NULL) {
+		pdata = max8649_get_alt_pdata(client);
+		if (pdata == NULL)
+			return -ENODEV;
+	}
+
 	info->mode = pdata->mode;
 	switch (info->mode) {
 	case 0:
-- 
1.5.6.5
