From: shc_work@mail.ru (Alexander Shiyan)
Date: Sun,  9 Jun 2013 21:51:24 +0400
Subject: [PATCH v3 1/2] leds: leds-mc13783: Prepare driver to support MC13892
 LEDs
Message-ID: <1370800285-18432-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch rewrite driver code to be ready to add support for
MC13892 LEDs.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-imx/mach-mx31moboard.c |   9 +-
 drivers/leds/leds-mc13783.c          | 395 +++++++++++++----------------------
 include/linux/mfd/mc13xxx.h          |  91 ++++----
 3 files changed, 195 insertions(+), 300 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx31moboard.c b/arch/arm/mach-imx/mach-mx31moboard.c
index dae4cd7..6f424ec 100644
--- a/arch/arm/mach-imx/mach-mx31moboard.c
+++ b/arch/arm/mach-imx/mach-mx31moboard.c
@@ -268,10 +268,11 @@ static struct mc13xxx_led_platform_data moboard_led[] = {
 static struct mc13xxx_leds_platform_data moboard_leds = {
 	.num_leds = ARRAY_SIZE(moboard_led),
 	.led = moboard_led,
-	.flags = MC13783_LED_SLEWLIMTC,
-	.abmode = MC13783_LED_AB_DISABLED,
-	.tc1_period = MC13783_LED_PERIOD_10MS,
-	.tc2_period = MC13783_LED_PERIOD_10MS,
+	.led_control[0]	= MC13783_LED_C0_ENABLE | MC13783_LED_C0_ABMODE(0),
+	.led_control[1]	= MC13783_LED_C1_SLEWLIM,
+	.led_control[2]	= MC13783_LED_C2_SLEWLIM,
+	.led_control[3]	= MC13783_LED_C3_PERIOD(0),
+	.led_control[4]	= MC13783_LED_C3_PERIOD(0),
 };
 
 static struct mc13xxx_buttons_platform_data moboard_buttons = {
diff --git a/drivers/leds/leds-mc13783.c b/drivers/leds/leds-mc13783.c
index ea8fc5d..5d0b23c 100644
--- a/drivers/leds/leds-mc13783.c
+++ b/drivers/leds/leds-mc13783.c
@@ -22,9 +22,16 @@
 #include <linux/leds.h>
 #include <linux/workqueue.h>
 #include <linux/mfd/mc13xxx.h>
-#include <linux/slab.h>
 
-struct mc13783_led {
+#define MC13XXX_REG_LED_CONTROL(x)	(51 + (x))
+
+struct mc13xxx_led_devtype {
+	int	led_min;
+	int	led_max;
+	int	num_regs;
+};
+
+struct mc13xxx_led {
 	struct led_classdev	cdev;
 	struct work_struct	work;
 	struct mc13xxx		*master;
@@ -32,66 +39,35 @@ struct mc13783_led {
 	int			id;
 };
 
-#define MC13783_REG_LED_CONTROL_0	51
-#define MC13783_LED_C0_ENABLE_BIT	(1 << 0)
-#define MC13783_LED_C0_TRIODE_MD_BIT	(1 << 7)
-#define MC13783_LED_C0_TRIODE_AD_BIT	(1 << 8)
-#define MC13783_LED_C0_TRIODE_KP_BIT	(1 << 9)
-#define MC13783_LED_C0_BOOST_BIT	(1 << 10)
-#define MC13783_LED_C0_ABMODE_MASK	0x7
-#define MC13783_LED_C0_ABMODE		11
-#define MC13783_LED_C0_ABREF_MASK	0x3
-#define MC13783_LED_C0_ABREF		14
-
-#define MC13783_REG_LED_CONTROL_1	52
-#define MC13783_LED_C1_TC1HALF_BIT	(1 << 18)
-
-#define MC13783_REG_LED_CONTROL_2	53
-#define MC13783_LED_C2_BL_P_MASK	0xf
-#define MC13783_LED_C2_MD_P		9
-#define MC13783_LED_C2_AD_P		13
-#define MC13783_LED_C2_KP_P		17
-#define MC13783_LED_C2_BL_C_MASK	0x7
-#define MC13783_LED_C2_MD_C		0
-#define MC13783_LED_C2_AD_C		3
-#define MC13783_LED_C2_KP_C		6
-
-#define MC13783_REG_LED_CONTROL_3	54
-#define MC13783_LED_C3_TC_P		6
-#define MC13783_LED_C3_TC_P_MASK	0x1f
-
-#define MC13783_REG_LED_CONTROL_4	55
-#define MC13783_REG_LED_CONTROL_5	56
-
-#define MC13783_LED_Cx_PERIOD		21
-#define MC13783_LED_Cx_PERIOD_MASK	0x3
-#define MC13783_LED_Cx_SLEWLIM_BIT      (1 << 23)
-#define MC13783_LED_Cx_TRIODE_TC_BIT	(1 << 23)
-#define MC13783_LED_Cx_TC_C_MASK	0x3
-
-static void mc13783_led_work(struct work_struct *work)
+struct mc13xxx_leds {
+	struct mc13xxx_led_devtype	*devtype;
+	int				num_leds;
+	struct mc13xxx_led		*led[0];
+};
+
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
+		reg = MC13XXX_REG_LED_CONTROL(2);
+		shift = 9;
+		mask = 0x0f;
+		value = led->new_brightness >> 4;
 		break;
 	case MC13783_LED_AD:
-		reg = MC13783_REG_LED_CONTROL_2;
-		mask = MC13783_LED_C2_BL_P_MASK << MC13783_LED_C2_AD_P;
-		value = (led->new_brightness >> 4) << MC13783_LED_C2_AD_P;
+		reg = MC13XXX_REG_LED_CONTROL(2);
+		shift = 13;
+		mask = 0x0f;
+		value = led->new_brightness >> 4;
 		break;
 	case MC13783_LED_KP:
-		reg = MC13783_REG_LED_CONTROL_2;
-		mask = MC13783_LED_C2_BL_P_MASK << MC13783_LED_C2_KP_P;
-		value = (led->new_brightness >> 4) << MC13783_LED_C2_KP_P;
+		reg = MC13XXX_REG_LED_CONTROL(2);
+		shift = 17;
+		mask = 0x0f;
+		value = led->new_brightness >> 4;
 		break;
 	case MC13783_LED_R1:
 	case MC13783_LED_G1:
@@ -103,57 +79,50 @@ static void mc13783_led_work(struct work_struct *work)
 	case MC13783_LED_G3:
 	case MC13783_LED_B3:
 		off = led->id - MC13783_LED_R1;
-		bank = off/3;
-		reg = MC13783_REG_LED_CONTROL_3 + off/3;
-		shift = (off - bank * 3) * 5 + MC13783_LED_C3_TC_P;
-		value = (led->new_brightness >> 3) << shift;
-		mask = MC13783_LED_C3_TC_P_MASK << shift;
+		bank = off / 3;
+		reg = MC13XXX_REG_LED_CONTROL(3) + bank;
+ 		shift = (off - bank * 3) * 5 + 6;
+		value = led->new_brightness >> 3;
+		mask = 0x1f;
 		break;
+	default:
+		BUG();
 	}
 
 	mc13xxx_lock(led->master);
-
-	mc13xxx_reg_rmw(led->master, reg, mask, value);
-
+	mc13xxx_reg_rmw(led->master, reg, mask << shift, value << shift);
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
+static int __init mc13xxx_led_setup(struct mc13xxx_led *led, int max_current)
 {
-	int shift = 0;
-	int mask = 0;
-	int value = 0;
-	int reg = 0;
-	int ret, bank;
+	int shift, mask, reg, ret, bank;
 
 	switch (led->id) {
 	case MC13783_LED_MD:
-		shift = MC13783_LED_C2_MD_C;
-		mask = MC13783_LED_C2_BL_C_MASK;
-		value = max_current & MC13783_LED_C2_BL_C_MASK;
-		reg = MC13783_REG_LED_CONTROL_2;
+		reg = MC13XXX_REG_LED_CONTROL(2);
+		shift = 0;
+		mask = 0x07;
 		break;
 	case MC13783_LED_AD:
-		shift = MC13783_LED_C2_AD_C;
-		mask = MC13783_LED_C2_BL_C_MASK;
-		value = max_current & MC13783_LED_C2_BL_C_MASK;
-		reg = MC13783_REG_LED_CONTROL_2;
+		reg = MC13XXX_REG_LED_CONTROL(2);
+		shift = 3;
+		mask = 0x07;
 		break;
 	case MC13783_LED_KP:
-		shift = MC13783_LED_C2_KP_C;
-		mask = MC13783_LED_C2_BL_C_MASK;
-		value = max_current & MC13783_LED_C2_BL_C_MASK;
-		reg = MC13783_REG_LED_CONTROL_2;
+		reg = MC13XXX_REG_LED_CONTROL(2);
+		shift = 6;
+		mask = 0x07;
 		break;
 	case MC13783_LED_R1:
 	case MC13783_LED_G1:
@@ -164,228 +133,162 @@ static int mc13783_led_setup(struct mc13783_led *led, int max_current)
 	case MC13783_LED_R3:
 	case MC13783_LED_G3:
 	case MC13783_LED_B3:
-		bank = (led->id - MC13783_LED_R1)/3;
-		reg = MC13783_REG_LED_CONTROL_3 + bank;
+		bank = (led->id - MC13783_LED_R1) / 3;
+		reg = MC13XXX_REG_LED_CONTROL(3) + bank;
 		shift = ((led->id - MC13783_LED_R1) - bank * 3) * 2;
-		mask = MC13783_LED_Cx_TC_C_MASK;
-		value = max_current & MC13783_LED_Cx_TC_C_MASK;
+		mask = 0x03;
 		break;
+	default:
+		BUG();
 	}
 
 	mc13xxx_lock(led->master);
-
 	ret = mc13xxx_reg_rmw(led->master, reg, mask << shift,
-						value << shift);
-
+			      max_current << shift);
 	mc13xxx_unlock(led->master);
-	return ret;
-}
-
-static int mc13783_leds_prepare(struct platform_device *pdev)
-{
-	struct mc13xxx_leds_platform_data *pdata = dev_get_platdata(&pdev->dev);
-	struct mc13xxx *dev = dev_get_drvdata(pdev->dev.parent);
-	int ret = 0;
-	int reg = 0;
-
-	mc13xxx_lock(dev);
-
-	if (pdata->flags & MC13783_LED_TC1HALF)
-		reg |= MC13783_LED_C1_TC1HALF_BIT;
-
-	if (pdata->flags & MC13783_LED_SLEWLIMTC)
-		reg |= MC13783_LED_Cx_SLEWLIM_BIT;
-
-	ret = mc13xxx_reg_write(dev, MC13783_REG_LED_CONTROL_1, reg);
-	if (ret)
-		goto out;
-
-	reg = (pdata->bl_period & MC13783_LED_Cx_PERIOD_MASK) <<
-							MC13783_LED_Cx_PERIOD;
-
-	if (pdata->flags & MC13783_LED_SLEWLIMBL)
-		reg |= MC13783_LED_Cx_SLEWLIM_BIT;
-
-	ret = mc13xxx_reg_write(dev, MC13783_REG_LED_CONTROL_2, reg);
-	if (ret)
-		goto out;
-
-	reg = (pdata->tc1_period & MC13783_LED_Cx_PERIOD_MASK) <<
-							MC13783_LED_Cx_PERIOD;
-
-	if (pdata->flags & MC13783_LED_TRIODE_TC1)
-		reg |= MC13783_LED_Cx_TRIODE_TC_BIT;
 
-	ret = mc13xxx_reg_write(dev, MC13783_REG_LED_CONTROL_3, reg);
-	if (ret)
-		goto out;
-
-	reg = (pdata->tc2_period & MC13783_LED_Cx_PERIOD_MASK) <<
-							MC13783_LED_Cx_PERIOD;
-
-	if (pdata->flags & MC13783_LED_TRIODE_TC2)
-		reg |= MC13783_LED_Cx_TRIODE_TC_BIT;
-
-	ret = mc13xxx_reg_write(dev, MC13783_REG_LED_CONTROL_4, reg);
-	if (ret)
-		goto out;
-
-	reg = (pdata->tc3_period & MC13783_LED_Cx_PERIOD_MASK) <<
-							MC13783_LED_Cx_PERIOD;
-
-	if (pdata->flags & MC13783_LED_TRIODE_TC3)
-		reg |= MC13783_LED_Cx_TRIODE_TC_BIT;
-
-	ret = mc13xxx_reg_write(dev, MC13783_REG_LED_CONTROL_5, reg);
-	if (ret)
-		goto out;
-
-	reg = MC13783_LED_C0_ENABLE_BIT;
-	if (pdata->flags & MC13783_LED_TRIODE_MD)
-		reg |= MC13783_LED_C0_TRIODE_MD_BIT;
-	if (pdata->flags & MC13783_LED_TRIODE_AD)
-		reg |= MC13783_LED_C0_TRIODE_AD_BIT;
-	if (pdata->flags & MC13783_LED_TRIODE_KP)
-		reg |= MC13783_LED_C0_TRIODE_KP_BIT;
-	if (pdata->flags & MC13783_LED_BOOST_EN)
-		reg |= MC13783_LED_C0_BOOST_BIT;
-
-	reg |= (pdata->abmode & MC13783_LED_C0_ABMODE_MASK) <<
-							MC13783_LED_C0_ABMODE;
-	reg |= (pdata->abref & MC13783_LED_C0_ABREF_MASK) <<
-							MC13783_LED_C0_ABREF;
-
-	ret = mc13xxx_reg_write(dev, MC13783_REG_LED_CONTROL_0, reg);
-
-out:
-	mc13xxx_unlock(dev);
 	return ret;
 }
 
-static int mc13783_led_probe(struct platform_device *pdev)
+static int __init mc13xxx_led_probe(struct platform_device *pdev)
 {
 	struct mc13xxx_leds_platform_data *pdata = dev_get_platdata(&pdev->dev);
-	struct mc13xxx_led_platform_data *led_cur;
-	struct mc13783_led *led, *led_dat;
-	int ret, i;
-	int init_led = 0;
-
-	if (pdata == NULL) {
-		dev_err(&pdev->dev, "missing platform data\n");
+	struct mc13xxx *mcdev = dev_get_drvdata(pdev->dev.parent);
+	struct mc13xxx_led_devtype *devtype;
+	struct mc13xxx_leds *leds;
+	int i, num_leds, ret = 0;
+	u32 reg, init_led = 0;
+
+	if (!pdata) {
+		dev_err(&pdev->dev, "Missing platform data\n");
 		return -ENODEV;
 	}
 
-	if (pdata->num_leds < 1 || pdata->num_leds > (MC13783_LED_MAX + 1)) {
-		dev_err(&pdev->dev, "Invalid led count %d\n", pdata->num_leds);
+	num_leds = pdata->num_leds;
+	devtype = (struct mc13xxx_led_devtype *)pdev->id_entry->driver_data;
+
+	if ((num_leds < 1) ||
+	    (num_leds > (devtype->led_max - devtype->led_min + 1))) {
+		dev_err(&pdev->dev, "Invalid LED count %d\n", num_leds);
 		return -EINVAL;
 	}
 
-	led = devm_kzalloc(&pdev->dev, pdata->num_leds * sizeof(*led),
-				GFP_KERNEL);
-	if (led == NULL) {
-		dev_err(&pdev->dev, "failed to alloc memory\n");
+	leds = devm_kzalloc(&pdev->dev, num_leds * sizeof(struct mc13xxx_led) +
+			    sizeof(*leds), GFP_KERNEL);
+	if (!leds)
 		return -ENOMEM;
+
+	leds->devtype = devtype;
+	leds->num_leds = num_leds;
+	platform_set_drvdata(pdev, leds);
+
+	mc13xxx_lock(mcdev);
+	for (i = 0; i < leds->devtype->num_regs; i++) {
+		reg = pdata->led_control[i];
+		WARN_ON(reg >= (1 << 24));
+		ret = mc13xxx_reg_write(mcdev, MC13XXX_REG_LED_CONTROL(i), reg);
+		if (ret)
+			break;
 	}
+	mc13xxx_unlock(mcdev);
 
-	ret = mc13783_leds_prepare(pdev);
 	if (ret) {
-		dev_err(&pdev->dev, "unable to init led driver\n");
+		dev_err(&pdev->dev, "Unable to init LED driver\n");
 		return ret;
 	}
 
-	for (i = 0; i < pdata->num_leds; i++) {
-		led_dat = &led[i];
-		led_cur = &pdata->led[i];
+	for (i = 0; i < num_leds; i++) {
+		struct mc13xxx_led_platform_data *led_cur = &pdata->led[i];
+		int id = led_cur->id;
 
-		if (led_cur->id > MC13783_LED_MAX || led_cur->id < 0) {
-			dev_err(&pdev->dev, "invalid id %d\n", led_cur->id);
+		if ((id > devtype->led_max) || (id < devtype->led_min)) {
+			dev_err(&pdev->dev, "Invalid ID %i\n", id);
 			ret = -EINVAL;
-			goto err_register;
+			break;
 		}
 
-		if (init_led & (1 << led_cur->id)) {
-			dev_err(&pdev->dev, "led %d already initialized\n",
-					led_cur->id);
+		if (init_led & (1 << id)) {
+			dev_warn(&pdev->dev,
+				 "LED %i already initialized\n", id);
 			ret = -EINVAL;
-			goto err_register;
+			break;
 		}
 
-		init_led |= 1 << led_cur->id;
-		led_dat->cdev.name = led_cur->name;
-		led_dat->cdev.default_trigger = led_cur->default_trigger;
-		led_dat->cdev.brightness_set = mc13783_led_set;
-		led_dat->cdev.brightness = LED_OFF;
-		led_dat->id = led_cur->id;
-		led_dat->master = dev_get_drvdata(pdev->dev.parent);
+		init_led |= 1 << id;
+		leds->led[i]->id = id;
+		leds->led[i]->master = mcdev;
+		leds->led[i]->cdev.name = led_cur->name;
+		leds->led[i]->cdev.default_trigger = led_cur->default_trigger;
+		leds->led[i]->cdev.brightness_set = mc13xxx_led_set;
+		leds->led[i]->cdev.brightness = LED_OFF;
 
-		INIT_WORK(&led_dat->work, mc13783_led_work);
+		INIT_WORK(&leds->led[i]->work, mc13xxx_led_work);
 
-		ret = led_classdev_register(pdev->dev.parent, &led_dat->cdev);
+		ret = mc13xxx_led_setup(leds->led[i], led_cur->max_current);
 		if (ret) {
-			dev_err(&pdev->dev, "failed to register led %d\n",
-					led_dat->id);
-			goto err_register;
+			dev_err(&pdev->dev, "Unable to setup LED %i\n", id);
+			break;
 		}
-
-		ret = mc13783_led_setup(led_dat, led_cur->max_current);
+		ret = led_classdev_register(pdev->dev.parent,
+					    &leds->led[i]->cdev);
 		if (ret) {
-			dev_err(&pdev->dev, "unable to init led %d\n",
-					led_dat->id);
-			i++;
-			goto err_register;
+			dev_err(&pdev->dev, "Failed to register LED %i\n", id);
+			break;
 		}
 	}
 
-	platform_set_drvdata(pdev, led);
-	return 0;
+	if (!ret)
+		return 0;
 
-err_register:
-	for (i = i - 1; i >= 0; i--) {
-		led_classdev_unregister(&led[i].cdev);
-		cancel_work_sync(&led[i].work);
+	while (--i >= 0) {
+		led_classdev_unregister(&leds->led[i]->cdev);
+		cancel_work_sync(&leds->led[i]->work);
 	}
 
 	return ret;
 }
 
-static int mc13783_led_remove(struct platform_device *pdev)
+static int mc13xxx_led_remove(struct platform_device *pdev)
 {
-	struct mc13xxx_leds_platform_data *pdata = dev_get_platdata(&pdev->dev);
-	struct mc13783_led *led = platform_get_drvdata(pdev);
-	struct mc13xxx *dev = dev_get_drvdata(pdev->dev.parent);
+	struct mc13xxx *mcdev = dev_get_drvdata(pdev->dev.parent);
+	struct mc13xxx_leds *leds = platform_get_drvdata(pdev);
 	int i;
 
-	for (i = 0; i < pdata->num_leds; i++) {
-		led_classdev_unregister(&led[i].cdev);
-		cancel_work_sync(&led[i].work);
+	for (i = 0; i < leds->num_leds; i++) {
+		led_classdev_unregister(&leds->led[i]->cdev);
+		cancel_work_sync(&leds->led[i]->work);
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
+	mc13xxx_lock(mcdev);
+	for (i = 0; i < leds->devtype->num_regs; i++)
+		mc13xxx_reg_write(mcdev, MC13XXX_REG_LED_CONTROL(i), 0);
+	mc13xxx_unlock(mcdev);
 
 	return 0;
 }
 
-static struct platform_driver mc13783_led_driver = {
+static const struct mc13xxx_led_devtype mc13783_led_devtype = {
+	.led_min	= MC13783_LED_MD,
+	.led_max	= MC13783_LED_B3,
+	.num_regs	= 6,
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
+	.remove		= mc13xxx_led_remove,
+	.id_table	= mc13xxx_led_id_table,
 };
+module_platform_driver_probe(mc13xxx_led_driver, mc13xxx_led_probe);
 
-module_platform_driver(mc13783_led_driver);
-
-MODULE_DESCRIPTION("LEDs driver for Freescale MC13783 PMIC");
+MODULE_DESCRIPTION("LEDs driver for Freescale MC13XXX PMIC");
 MODULE_AUTHOR("Philippe Retornaz <philippe.retornaz@epfl.ch>");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:mc13783-led");
diff --git a/include/linux/mfd/mc13xxx.h b/include/linux/mfd/mc13xxx.h
index bf07075..016c684 100644
--- a/include/linux/mfd/mc13xxx.h
+++ b/include/linux/mfd/mc13xxx.h
@@ -78,20 +78,23 @@ struct mc13xxx_regulator_platform_data {
 	struct mc13xxx_regulator_init_data *regulators;
 };
 
+enum {
+	/* MC13783 LED IDs */
+	MC13783_LED_MD,
+	MC13783_LED_AD,
+	MC13783_LED_KP,
+	MC13783_LED_R1,
+	MC13783_LED_G1,
+	MC13783_LED_B1,
+	MC13783_LED_R2,
+	MC13783_LED_G2,
+	MC13783_LED_B2,
+	MC13783_LED_R3,
+	MC13783_LED_G3,
+	MC13783_LED_B3,
+};
+
 struct mc13xxx_led_platform_data {
-#define MC13783_LED_MD		0
-#define MC13783_LED_AD		1
-#define MC13783_LED_KP		2
-#define MC13783_LED_R1		3
-#define MC13783_LED_G1		4
-#define MC13783_LED_B1		5
-#define MC13783_LED_R2		6
-#define MC13783_LED_G2		7
-#define MC13783_LED_B2		8
-#define MC13783_LED_R3		9
-#define MC13783_LED_G3		10
-#define MC13783_LED_B3		11
-#define MC13783_LED_MAX MC13783_LED_B3
 	int id;
 	const char *name;
 	const char *default_trigger;
@@ -101,45 +104,33 @@ struct mc13xxx_led_platform_data {
 };
 
 struct mc13xxx_leds_platform_data {
-	int num_leds;
 	struct mc13xxx_led_platform_data *led;
+	int num_leds;
 
-#define MC13783_LED_TRIODE_MD	(1 << 0)
-#define MC13783_LED_TRIODE_AD	(1 << 1)
-#define MC13783_LED_TRIODE_KP	(1 << 2)
-#define MC13783_LED_BOOST_EN	(1 << 3)
-#define MC13783_LED_TC1HALF	(1 << 4)
-#define MC13783_LED_SLEWLIMTC	(1 << 5)
-#define MC13783_LED_SLEWLIMBL	(1 << 6)
-#define MC13783_LED_TRIODE_TC1	(1 << 7)
-#define MC13783_LED_TRIODE_TC2	(1 << 8)
-#define MC13783_LED_TRIODE_TC3	(1 << 9)
-	int flags;
-
-#define MC13783_LED_AB_DISABLED		0
-#define MC13783_LED_AB_MD1		1
-#define MC13783_LED_AB_MD12		2
-#define MC13783_LED_AB_MD123		3
-#define MC13783_LED_AB_MD1234		4
-#define MC13783_LED_AB_MD1234_AD1	5
-#define MC13783_LED_AB_MD1234_AD12	6
-#define MC13783_LED_AB_MD1_AD		7
-	char abmode;
-
-#define MC13783_LED_ABREF_200MV	0
-#define MC13783_LED_ABREF_400MV	1
-#define MC13783_LED_ABREF_600MV	2
-#define MC13783_LED_ABREF_800MV	3
-	char abref;
-
-#define MC13783_LED_PERIOD_10MS		0
-#define MC13783_LED_PERIOD_100MS	1
-#define MC13783_LED_PERIOD_500MS	2
-#define MC13783_LED_PERIOD_2S		3
-	char bl_period;
-	char tc1_period;
-	char tc2_period;
-	char tc3_period;
+/* LED Control 0 */
+#define MC13783_LED_C0_ENABLE		(1 << 0)
+#define MC13783_LED_C0_TRIODE_MD	(1 << 7)
+#define MC13783_LED_C0_TRIODE_AD	(1 << 8)
+#define MC13783_LED_C0_TRIODE_KP	(1 << 9)
+#define MC13783_LED_C0_BOOST		(1 << 10)
+#define MC13783_LED_C0_ABMODE(x)	(((x) & 0x7) << 11)
+#define MC13783_LED_C0_ABREF(x)		(((x) & 0x3) << 14)
+/* LED Control 1 */
+#define MC13783_LED_C1_TC1HALF		(1 << 18)
+#define MC13783_LED_C1_SLEWLIM		(1 << 23)
+/* LED Control 2 */
+#define MC13783_LED_C2_PERIOD(x)	(((x) & 0x3) << 21)
+#define MC13783_LED_C2_SLEWLIM		(1 << 23)
+/* LED Control 3 */
+#define MC13783_LED_C3_PERIOD(x)	(((x) & 0x3) << 21)
+#define MC13783_LED_C3_TRIODE_TC1	(1 << 23)
+/* LED Control 4 */
+#define MC13783_LED_C4_PERIOD(x)	(((x) & 0x3) << 21)
+#define MC13783_LED_C4_TRIODE_TC2	(1 << 23)
+/* LED Control 5 */
+#define MC13783_LED_C5_PERIOD(x)	(((x) & 0x3) << 21)
+#define MC13783_LED_C5_TRIODE_TC3	(1 << 23)
+	u32 led_control[6];
 };
 
 struct mc13xxx_buttons_platform_data {
-- 
1.8.1.5
