From: shc_work@mail.ru (Alexander Shiyan)
Date: Wed,  5 Jun 2013 12:34:36 +0400
Subject: [PATCH v2 1/4] leds: leds-mc13783: Prepare driver to support MC13892
 LEDs
In-Reply-To: <1370421279-23348-1-git-send-email-shc_work@mail.ru>
References: <1370421279-23348-1-git-send-email-shc_work@mail.ru>
Message-ID: <1370421279-23348-2-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch prepares driver code to support MC13892 LEDs.
Some stuff was optimized for support another PMIC, some
dependencies was moved into devdata calls.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/leds/leds-mc13783.c | 197 +++++++++++++++++++++++++-------------------
 include/linux/mfd/mc13xxx.h |   1 -
 2 files changed, 111 insertions(+), 87 deletions(-)

diff --git a/drivers/leds/leds-mc13783.c b/drivers/leds/leds-mc13783.c
index ea8fc5d..2203bc0 100644
--- a/drivers/leds/leds-mc13783.c
+++ b/drivers/leds/leds-mc13783.c
@@ -24,7 +24,14 @@
 #include <linux/mfd/mc13xxx.h>
 #include <linux/slab.h>
 
-struct mc13783_led {
+struct mc13xxx_led_devtype {
+	int	led_min;
+	int	led_max;
+	int	(*leds_startup)(struct platform_device *);
+	void	(*leds_shutdown)(struct platform_device *);
+};
+
+struct mc13xxx_led {
 	struct led_classdev	cdev;
 	struct work_struct	work;
 	struct mc13xxx		*master;
@@ -32,7 +39,7 @@ struct mc13783_led {
 	int			id;
 };
 
-#define MC13783_REG_LED_CONTROL_0	51
+#define MC13XXX_REG_LED_CONTROL_0	51
 #define MC13783_LED_C0_ENABLE_BIT	(1 << 0)
 #define MC13783_LED_C0_TRIODE_MD_BIT	(1 << 7)
 #define MC13783_LED_C0_TRIODE_AD_BIT	(1 << 8)
@@ -43,10 +50,10 @@ struct mc13783_led {
 #define MC13783_LED_C0_ABREF_MASK	0x3
 #define MC13783_LED_C0_ABREF		14
 
-#define MC13783_REG_LED_CONTROL_1	52
+#define MC13XXX_REG_LED_CONTROL_1	52
 #define MC13783_LED_C1_TC1HALF_BIT	(1 << 18)
 
-#define MC13783_REG_LED_CONTROL_2	53
+#define MC13XXX_REG_LED_CONTROL_2	53
 #define MC13783_LED_C2_BL_P_MASK	0xf
 #define MC13783_LED_C2_MD_P		9
 #define MC13783_LED_C2_AD_P		13
@@ -56,7 +63,7 @@ struct mc13783_led {
 #define MC13783_LED_C2_AD_C		3
 #define MC13783_LED_C2_KP_C		6
 
-#define MC13783_REG_LED_CONTROL_3	54
+#define MC13XXX_REG_LED_CONTROL_3	54
 #define MC13783_LED_C3_TC_P		6
 #define MC13783_LED_C3_TC_P_MASK	0x1f
 
@@ -69,29 +76,29 @@ struct mc13783_led {
 #define MC13783_LED_Cx_TRIODE_TC_BIT	(1 << 23)
 #define MC13783_LED_Cx_TC_C_MASK	0x3
 
-static void mc13783_led_work(struct work_struct *work)
+static void mc13xxx_led_work(struct work_struct *work)
 {
-	struct mc13783_led *led = container_of(work, struct mc13783_led, work);
-	int reg = 0;
-	int mask = 0;
-	int value = 0;
-	int bank, off, shift;
+	struct mc13xxx_led *led = container_of(work, struct mc13xxx_led, work);
+	int reg, mask, value, bank, off, shift;
 
 	switch (led->id) {
 	case MC13783_LED_MD:
-		reg = MC13783_REG_LED_CONTROL_2;
-		mask = MC13783_LED_C2_BL_P_MASK << MC13783_LED_C2_MD_P;
-		value = (led->new_brightness >> 4) << MC13783_LED_C2_MD_P;
+		reg = MC13XXX_REG_LED_CONTROL_2;
+		mask = MC13783_LED_C2_BL_P_MASK;
+		shift = MC13783_LED_C2_MD_P;
+		value = led->new_brightness >> 4;
 		break;
 	case MC13783_LED_AD:
-		reg = MC13783_REG_LED_CONTROL_2;
-		mask = MC13783_LED_C2_BL_P_MASK << MC13783_LED_C2_AD_P;
-		value = (led->new_brightness >> 4) << MC13783_LED_C2_AD_P;
+		reg = MC13XXX_REG_LED_CONTROL_2;
+		mask = MC13783_LED_C2_BL_P_MASK;
+		shift = MC13783_LED_C2_AD_P;
+		value = led->new_brightness >> 4;
 		break;
 	case MC13783_LED_KP:
-		reg = MC13783_REG_LED_CONTROL_2;
-		mask = MC13783_LED_C2_BL_P_MASK << MC13783_LED_C2_KP_P;
-		value = (led->new_brightness >> 4) << MC13783_LED_C2_KP_P;
+		reg = MC13XXX_REG_LED_CONTROL_2;
+		mask = MC13783_LED_C2_BL_P_MASK;
+		shift = MC13783_LED_C2_KP_P;
+		value = led->new_brightness >> 4;
 		break;
 	case MC13783_LED_R1:
 	case MC13783_LED_G1:
@@ -103,57 +110,51 @@ static void mc13783_led_work(struct work_struct *work)
 	case MC13783_LED_G3:
 	case MC13783_LED_B3:
 		off = led->id - MC13783_LED_R1;
-		bank = off/3;
-		reg = MC13783_REG_LED_CONTROL_3 + off/3;
-		shift = (off - bank * 3) * 5 + MC13783_LED_C3_TC_P;
-		value = (led->new_brightness >> 3) << shift;
-		mask = MC13783_LED_C3_TC_P_MASK << shift;
+		bank = off / 3;
+		reg = MC13XXX_REG_LED_CONTROL_3 + bank;
+ 		shift = (off - bank * 3) * 5 + MC13783_LED_C3_TC_P;
+		value = led->new_brightness >> 3;
+		mask = MC13783_LED_C3_TC_P_MASK;
 		break;
+	default:
+		BUG();
 	}
 
 	mc13xxx_lock(led->master);
-
-	mc13xxx_reg_rmw(led->master, reg, mask, value);
-
+	mc13xxx_reg_rmw(led->master, reg, mask << shift,
+					  value << shift);
 	mc13xxx_unlock(led->master);
 }
 
-static void mc13783_led_set(struct led_classdev *led_cdev,
-			   enum led_brightness value)
+static void mc13xxx_led_set(struct led_classdev *led_cdev,
+			    enum led_brightness value)
 {
-	struct mc13783_led *led;
+	struct mc13xxx_led *led =
+		container_of(led_cdev, struct mc13xxx_led, cdev);
 
-	led = container_of(led_cdev, struct mc13783_led, cdev);
 	led->new_brightness = value;
 	schedule_work(&led->work);
 }
 
-static int mc13783_led_setup(struct mc13783_led *led, int max_current)
+static int mc13xxx_led_setup(struct mc13xxx_led *led, int max_current)
 {
-	int shift = 0;
-	int mask = 0;
-	int value = 0;
-	int reg = 0;
-	int ret, bank;
+	int shift, mask, reg, ret, bank;
 
 	switch (led->id) {
 	case MC13783_LED_MD:
 		shift = MC13783_LED_C2_MD_C;
 		mask = MC13783_LED_C2_BL_C_MASK;
-		value = max_current & MC13783_LED_C2_BL_C_MASK;
-		reg = MC13783_REG_LED_CONTROL_2;
+		reg = MC13XXX_REG_LED_CONTROL_2;
 		break;
 	case MC13783_LED_AD:
 		shift = MC13783_LED_C2_AD_C;
 		mask = MC13783_LED_C2_BL_C_MASK;
-		value = max_current & MC13783_LED_C2_BL_C_MASK;
-		reg = MC13783_REG_LED_CONTROL_2;
+		reg = MC13XXX_REG_LED_CONTROL_2;
 		break;
 	case MC13783_LED_KP:
 		shift = MC13783_LED_C2_KP_C;
 		mask = MC13783_LED_C2_BL_C_MASK;
-		value = max_current & MC13783_LED_C2_BL_C_MASK;
-		reg = MC13783_REG_LED_CONTROL_2;
+		reg = MC13XXX_REG_LED_CONTROL_2;
 		break;
 	case MC13783_LED_R1:
 	case MC13783_LED_G1:
@@ -164,29 +165,28 @@ static int mc13783_led_setup(struct mc13783_led *led, int max_current)
 	case MC13783_LED_R3:
 	case MC13783_LED_G3:
 	case MC13783_LED_B3:
-		bank = (led->id - MC13783_LED_R1)/3;
-		reg = MC13783_REG_LED_CONTROL_3 + bank;
+		bank = (led->id - MC13783_LED_R1) / 3;
+		reg = MC13XXX_REG_LED_CONTROL_3 + bank;
 		shift = ((led->id - MC13783_LED_R1) - bank * 3) * 2;
 		mask = MC13783_LED_Cx_TC_C_MASK;
-		value = max_current & MC13783_LED_Cx_TC_C_MASK;
 		break;
+	default:
+		BUG();
 	}
 
 	mc13xxx_lock(led->master);
-
 	ret = mc13xxx_reg_rmw(led->master, reg, mask << shift,
-						value << shift);
-
+			      (max_current & mask) << shift);
 	mc13xxx_unlock(led->master);
+
 	return ret;
 }
 
-static int mc13783_leds_prepare(struct platform_device *pdev)
+static int mc13783_leds_startup(struct platform_device *pdev)
 {
 	struct mc13xxx_leds_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	struct mc13xxx *dev = dev_get_drvdata(pdev->dev.parent);
-	int ret = 0;
-	int reg = 0;
+	int ret, reg = 0;
 
 	mc13xxx_lock(dev);
 
@@ -196,7 +196,7 @@ static int mc13783_leds_prepare(struct platform_device *pdev)
 	if (pdata->flags & MC13783_LED_SLEWLIMTC)
 		reg |= MC13783_LED_Cx_SLEWLIM_BIT;
 
-	ret = mc13xxx_reg_write(dev, MC13783_REG_LED_CONTROL_1, reg);
+	ret = mc13xxx_reg_write(dev, MC13XXX_REG_LED_CONTROL_1, reg);
 	if (ret)
 		goto out;
 
@@ -206,7 +206,7 @@ static int mc13783_leds_prepare(struct platform_device *pdev)
 	if (pdata->flags & MC13783_LED_SLEWLIMBL)
 		reg |= MC13783_LED_Cx_SLEWLIM_BIT;
 
-	ret = mc13xxx_reg_write(dev, MC13783_REG_LED_CONTROL_2, reg);
+	ret = mc13xxx_reg_write(dev, MC13XXX_REG_LED_CONTROL_2, reg);
 	if (ret)
 		goto out;
 
@@ -216,7 +216,7 @@ static int mc13783_leds_prepare(struct platform_device *pdev)
 	if (pdata->flags & MC13783_LED_TRIODE_TC1)
 		reg |= MC13783_LED_Cx_TRIODE_TC_BIT;
 
-	ret = mc13xxx_reg_write(dev, MC13783_REG_LED_CONTROL_3, reg);
+	ret = mc13xxx_reg_write(dev, MC13XXX_REG_LED_CONTROL_3, reg);
 	if (ret)
 		goto out;
 
@@ -255,27 +255,47 @@ static int mc13783_leds_prepare(struct platform_device *pdev)
 	reg |= (pdata->abref & MC13783_LED_C0_ABREF_MASK) <<
 							MC13783_LED_C0_ABREF;
 
-	ret = mc13xxx_reg_write(dev, MC13783_REG_LED_CONTROL_0, reg);
+	ret = mc13xxx_reg_write(dev, MC13XXX_REG_LED_CONTROL_0, reg);
 
 out:
 	mc13xxx_unlock(dev);
+
 	return ret;
 }
 
-static int mc13783_led_probe(struct platform_device *pdev)
+static void mc13783_leds_shutdown(struct platform_device *pdev)
+{
+	struct mc13xxx *dev = dev_get_drvdata(pdev->dev.parent);
+
+	mc13xxx_lock(dev);
+
+	mc13xxx_reg_write(dev, MC13XXX_REG_LED_CONTROL_0, 0);
+	mc13xxx_reg_write(dev, MC13XXX_REG_LED_CONTROL_1, 0);
+	mc13xxx_reg_write(dev, MC13XXX_REG_LED_CONTROL_2, 0);
+	mc13xxx_reg_write(dev, MC13XXX_REG_LED_CONTROL_3, 0);
+	mc13xxx_reg_write(dev, MC13783_REG_LED_CONTROL_4, 0);
+	mc13xxx_reg_write(dev, MC13783_REG_LED_CONTROL_5, 0);
+
+	mc13xxx_unlock(dev);
+}
+
+static int mc13xxx_led_probe(struct platform_device *pdev)
 {
 	struct mc13xxx_leds_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	struct mc13xxx_led_devtype *devtype =
+		(struct mc13xxx_led_devtype *)pdev->id_entry->driver_data;
 	struct mc13xxx_led_platform_data *led_cur;
-	struct mc13783_led *led, *led_dat;
+	struct mc13xxx_led *led, *led_dat;
+	unsigned int init_led = 0;
 	int ret, i;
-	int init_led = 0;
 
 	if (pdata == NULL) {
 		dev_err(&pdev->dev, "missing platform data\n");
 		return -ENODEV;
 	}
 
-	if (pdata->num_leds < 1 || pdata->num_leds > (MC13783_LED_MAX + 1)) {
+	if ((pdata->num_leds < 1) ||
+	    (pdata->num_leds > (devtype->led_max - devtype->led_min + 1))) {
 		dev_err(&pdev->dev, "Invalid led count %d\n", pdata->num_leds);
 		return -EINVAL;
 	}
@@ -287,7 +307,7 @@ static int mc13783_led_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	ret = mc13783_leds_prepare(pdev);
+	ret = devtype->leds_startup(pdev);
 	if (ret) {
 		dev_err(&pdev->dev, "unable to init led driver\n");
 		return ret;
@@ -297,7 +317,8 @@ static int mc13783_led_probe(struct platform_device *pdev)
 		led_dat = &led[i];
 		led_cur = &pdata->led[i];
 
-		if (led_cur->id > MC13783_LED_MAX || led_cur->id < 0) {
+		if ((led_cur->id > devtype->led_max) ||
+		    (led_cur->id < devtype->led_min)) {
 			dev_err(&pdev->dev, "invalid id %d\n", led_cur->id);
 			ret = -EINVAL;
 			goto err_register;
@@ -313,12 +334,12 @@ static int mc13783_led_probe(struct platform_device *pdev)
 		init_led |= 1 << led_cur->id;
 		led_dat->cdev.name = led_cur->name;
 		led_dat->cdev.default_trigger = led_cur->default_trigger;
-		led_dat->cdev.brightness_set = mc13783_led_set;
+		led_dat->cdev.brightness_set = mc13xxx_led_set;
 		led_dat->cdev.brightness = LED_OFF;
 		led_dat->id = led_cur->id;
 		led_dat->master = dev_get_drvdata(pdev->dev.parent);
 
-		INIT_WORK(&led_dat->work, mc13783_led_work);
+		INIT_WORK(&led_dat->work, mc13xxx_led_work);
 
 		ret = led_classdev_register(pdev->dev.parent, &led_dat->cdev);
 		if (ret) {
@@ -327,7 +348,7 @@ static int mc13783_led_probe(struct platform_device *pdev)
 			goto err_register;
 		}
 
-		ret = mc13783_led_setup(led_dat, led_cur->max_current);
+		ret = mc13xxx_led_setup(led_dat, led_cur->max_current);
 		if (ret) {
 			dev_err(&pdev->dev, "unable to init led %d\n",
 					led_dat->id);
@@ -348,11 +369,12 @@ err_register:
 	return ret;
 }
 
-static int mc13783_led_remove(struct platform_device *pdev)
+static int mc13xxx_led_remove(struct platform_device *pdev)
 {
 	struct mc13xxx_leds_platform_data *pdata = dev_get_platdata(&pdev->dev);
-	struct mc13783_led *led = platform_get_drvdata(pdev);
-	struct mc13xxx *dev = dev_get_drvdata(pdev->dev.parent);
+	struct mc13xxx_led_devtype *devtype =
+		(struct mc13xxx_led_devtype *)pdev->id_entry->driver_data;
+	struct mc13xxx_led *led = platform_get_drvdata(pdev);
 	int i;
 
 	for (i = 0; i < pdata->num_leds; i++) {
@@ -360,32 +382,35 @@ static int mc13783_led_remove(struct platform_device *pdev)
 		cancel_work_sync(&led[i].work);
 	}
 
-	mc13xxx_lock(dev);
-
-	mc13xxx_reg_write(dev, MC13783_REG_LED_CONTROL_0, 0);
-	mc13xxx_reg_write(dev, MC13783_REG_LED_CONTROL_1, 0);
-	mc13xxx_reg_write(dev, MC13783_REG_LED_CONTROL_2, 0);
-	mc13xxx_reg_write(dev, MC13783_REG_LED_CONTROL_3, 0);
-	mc13xxx_reg_write(dev, MC13783_REG_LED_CONTROL_4, 0);
-	mc13xxx_reg_write(dev, MC13783_REG_LED_CONTROL_5, 0);
-
-	mc13xxx_unlock(dev);
+	devtype->leds_shutdown(pdev);
 
 	return 0;
 }
 
-static struct platform_driver mc13783_led_driver = {
+static const struct mc13xxx_led_devtype mc13783_led_devtype = {
+	.led_min	= MC13783_LED_MD,
+	.led_max	= MC13783_LED_B3,
+	.leds_startup	= mc13783_leds_startup,
+	.leds_shutdown	= mc13783_leds_shutdown,
+};
+
+static const struct platform_device_id mc13xxx_led_id_table[] = {
+	{ "mc13783-led", (kernel_ulong_t)&mc13783_led_devtype, },
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, mc13xxx_led_id_table);
+
+static struct platform_driver mc13xxx_led_driver = {
 	.driver	= {
-		.name	= "mc13783-led",
+		.name	= "mc13xxx-led",
 		.owner	= THIS_MODULE,
 	},
-	.probe		= mc13783_led_probe,
-	.remove		= mc13783_led_remove,
+	.probe		= mc13xxx_led_probe,
+	.remove		= mc13xxx_led_remove,
+	.id_table	= mc13xxx_led_id_table,
 };
-
-module_platform_driver(mc13783_led_driver);
+module_platform_driver(mc13xxx_led_driver);
 
 MODULE_DESCRIPTION("LEDs driver for Freescale MC13783 PMIC");
 MODULE_AUTHOR("Philippe Retornaz <philippe.retornaz@epfl.ch>");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:mc13783-led");
diff --git a/include/linux/mfd/mc13xxx.h b/include/linux/mfd/mc13xxx.h
index bf07075..fe0e003 100644
--- a/include/linux/mfd/mc13xxx.h
+++ b/include/linux/mfd/mc13xxx.h
@@ -91,7 +91,6 @@ struct mc13xxx_led_platform_data {
 #define MC13783_LED_R3		9
 #define MC13783_LED_G3		10
 #define MC13783_LED_B3		11
-#define MC13783_LED_MAX MC13783_LED_B3
 	int id;
 	const char *name;
 	const char *default_trigger;
-- 
1.8.1.5
