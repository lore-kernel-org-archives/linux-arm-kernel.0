From: shc_work@mail.ru (Alexander Shiyan)
Date: Mon,  3 Jun 2013 19:38:35 +0400
Subject: [PATCH 2/3] leds: leds-mc13783: Add MC13892 LED support
In-Reply-To: <1370273916-29852-1-git-send-email-shc_work@mail.ru>
References: <1370273916-29852-1-git-send-email-shc_work@mail.ru>
Message-ID: <1370273916-29852-2-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/leds/leds-mc13783.c | 132 +++++++++++++++++++++++++++++++++++++++++++-
 include/linux/mfd/mc13xxx.h |  48 +++++++++++-----
 2 files changed, 166 insertions(+), 14 deletions(-)

diff --git a/drivers/leds/leds-mc13783.c b/drivers/leds/leds-mc13783.c
index 449940d..f4e50cc 100644
--- a/drivers/leds/leds-mc13783.c
+++ b/drivers/leds/leds-mc13783.c
@@ -1,5 +1,5 @@
 /*
- * LEDs driver for Freescale MC13783
+ * LEDs driver for Freescale MC13783/MC13982
  *
  * Copyright (C) 2010 Philippe R?tornaz
  *
@@ -49,9 +49,15 @@ struct mc13xxx_led {
 #define MC13783_LED_C0_ABMODE		11
 #define MC13783_LED_C0_ABREF_MASK	0x3
 #define MC13783_LED_C0_ABREF		14
+#define MC13892_LED_C0_MD_HI_CURRENT	(1 << 1)
+#define MC13892_LED_C0_RAMPMD_ENABLE	(1 << 2)
+#define MC13892_LED_C0_AD_HI_CURRENT	(1 << 13)
+#define MC13892_LED_C0_RAMPAD_ENABLE	(1 << 14)
 
 #define MC13XXX_REG_LED_CONTROL_1	52
 #define MC13783_LED_C1_TC1HALF_BIT	(1 << 18)
+#define MC13892_LED_C1_KP_HI_CURRENT	(1 << 1)
+#define MC13892_LED_C1_RAMPKP_ENABLE	(1 << 2)
 
 #define MC13XXX_REG_LED_CONTROL_2	53
 #define MC13783_LED_C2_BL_P_MASK	0xf
@@ -62,10 +68,15 @@ struct mc13xxx_led {
 #define MC13783_LED_C2_MD_C		0
 #define MC13783_LED_C2_AD_C		3
 #define MC13783_LED_C2_KP_C		6
+#define MC13892_LED_C2_RAMPR_ENABLE	(1 << 2)
+#define MC13892_LED_CX_CURRENT_MASK	0x7
+#define MC13892_LED_CX_DUTY_MASK	0x3f
+#define MC13892_LED_C2_RAMPG_ENABLE	(1 << 14)
 
 #define MC13XXX_REG_LED_CONTROL_3	54
 #define MC13783_LED_C3_TC_P		6
 #define MC13783_LED_C3_TC_P_MASK	0x1f
+#define MC13892_LED_C3_RAMPB_ENABLE	(1 << 2)
 
 #define MC13783_REG_LED_CONTROL_4	55
 #define MC13783_REG_LED_CONTROL_5	56
@@ -116,6 +127,34 @@ static void mc13xxx_led_work(struct work_struct *work)
 		value = led->new_brightness >> 3;
 		mask = MC13783_LED_C3_TC_P_MASK;
 		break;
+	case MC13892_LED_MD:
+		reg = MC13XXX_REG_LED_CONTROL_0;
+		mask = MC13892_LED_CX_DUTY_MASK;
+		shift = 3;
+		value = led->new_brightness >> 2;
+		break;
+	case MC13892_LED_AD:
+		reg = MC13XXX_REG_LED_CONTROL_0;
+		mask = MC13892_LED_CX_DUTY_MASK;
+		shift = 15;
+		value = led->new_brightness >> 2;
+		break;
+	case MC13892_LED_KP:
+		reg = MC13XXX_REG_LED_CONTROL_1;
+		mask = MC13892_LED_CX_DUTY_MASK;
+		shift = 3;
+		value = led->new_brightness >> 2;
+		break;
+	case MC13892_LED_R:
+	case MC13892_LED_G:
+	case MC13892_LED_B:
+		off = led->id - MC13892_LED_R;
+		bank = off / 2;
+		reg = MC13XXX_REG_LED_CONTROL_2 + bank;
+		shift = (off - bank * 2) * 12 + 3;
+		value = led->new_brightness >> 2;
+		mask = MC13892_LED_CX_DUTY_MASK;
+		break;
 	default:
 		BUG();
 	}
@@ -170,6 +209,29 @@ static int mc13xxx_led_setup(struct mc13xxx_led *led, int max_current)
 		shift = ((led->id - MC13783_LED_R1) - bank * 3) * 2;
 		mask = MC13783_LED_Cx_TC_C_MASK;
 		break;
+	case MC13892_LED_MD:
+		shift = 9;
+		mask = MC13892_LED_CX_CURRENT_MASK;
+		reg = MC13XXX_REG_LED_CONTROL_0;
+		break;
+	case MC13892_LED_AD:
+		shift = 21;
+		mask = MC13892_LED_CX_CURRENT_MASK;
+		reg = MC13XXX_REG_LED_CONTROL_0;
+		break;
+	case MC13892_LED_KP:
+		shift = 9;
+		mask = MC13892_LED_CX_CURRENT_MASK;
+		reg = MC13XXX_REG_LED_CONTROL_1;
+		break;
+	case MC13892_LED_R:
+	case MC13892_LED_G:
+	case MC13892_LED_B:
+		bank = (led->id - MC13892_LED_R) / 2;
+		reg = MC13XXX_REG_LED_CONTROL_2 + bank;
+		shift = ((led->id - MC13892_LED_R) - bank * 2) * 12 + 9;
+		mask = MC13892_LED_CX_CURRENT_MASK;
+		break;
 	default:
 		BUG();
 	}
@@ -279,6 +341,66 @@ static void mc13783_leds_shutdown(struct platform_device *pdev)
 	mc13xxx_unlock(dev);
 }
 
+static int mc13892_leds_startup(struct platform_device *pdev)
+{
+	struct mc13xxx_leds_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	struct mc13xxx *dev = dev_get_drvdata(pdev->dev.parent);
+	int ret, reg;
+
+	mc13xxx_lock(dev);
+
+	reg = (pdata->flags & MC13892_LEDMD_HI_CURR) ?
+	      MC13892_LED_C0_MD_HI_CURRENT : 0;
+	reg |= (pdata->flags & MC13892_LEDMD_RAMP_EN) ?
+	       MC13892_LED_C0_RAMPMD_ENABLE : 0;
+	reg |= (pdata->flags & MC13892_LEDAD_HI_CURR) ?
+	       MC13892_LED_C0_AD_HI_CURRENT : 0;
+	reg |= (pdata->flags & MC13892_LEDAD_RAMP_EN) ?
+	       MC13892_LED_C0_RAMPAD_ENABLE : 0;
+	ret = mc13xxx_reg_write(dev, MC13XXX_REG_LED_CONTROL_0, 0);
+	if (ret)
+		goto out;
+
+	reg = (pdata->flags & MC13892_LEDKP_HI_CURR) ?
+	      MC13892_LED_C1_KP_HI_CURRENT : 0;
+	reg |= (pdata->flags & MC13892_LEDKP_RAMP_EN) ?
+	       MC13892_LED_C1_RAMPKP_ENABLE : 0;
+	ret = mc13xxx_reg_write(dev, MC13XXX_REG_LED_CONTROL_1, 0);
+	if (ret)
+		goto out;
+
+	reg = (pdata->flags & MC13892_LEDR_RAMP_EN) ?
+	      MC13892_LED_C2_RAMPR_ENABLE : 0;
+	reg |= (pdata->flags & MC13892_LEDG_RAMP_EN) ?
+	       MC13892_LED_C2_RAMPG_ENABLE : 0;
+	ret = mc13xxx_reg_write(dev, MC13XXX_REG_LED_CONTROL_2, reg);
+	if (ret)
+		goto out;
+
+	reg = (pdata->flags & MC13892_LEDB_RAMP_EN) ?
+	      MC13892_LED_C3_RAMPB_ENABLE : 0;
+	ret = mc13xxx_reg_write(dev, MC13XXX_REG_LED_CONTROL_3, reg);
+
+out:
+	mc13xxx_unlock(dev);
+
+	return ret;
+}
+
+static void mc13892_leds_shutdown(struct platform_device *pdev)
+{
+	struct mc13xxx *dev = dev_get_drvdata(pdev->dev.parent);
+
+	mc13xxx_lock(dev);
+
+	mc13xxx_reg_write(dev, MC13XXX_REG_LED_CONTROL_0, 0);
+	mc13xxx_reg_write(dev, MC13XXX_REG_LED_CONTROL_1, 0);
+	mc13xxx_reg_write(dev, MC13XXX_REG_LED_CONTROL_2, 0);
+	mc13xxx_reg_write(dev, MC13XXX_REG_LED_CONTROL_3, 0);
+
+	mc13xxx_unlock(dev);
+}
+
 static int mc13xxx_led_probe(struct platform_device *pdev)
 {
 	struct mc13xxx_leds_platform_data *pdata = dev_get_platdata(&pdev->dev);
@@ -394,8 +516,16 @@ static const struct mc13xxx_led_devtype mc13783_led_devtype = {
 	.leds_shutdown	= mc13783_leds_shutdown,
 };
 
+static const struct mc13xxx_led_devtype mc13892_led_devtype = {
+	.led_min	= MC13892_LED_MD,
+	.led_max	= MC13892_LED_B,
+	.leds_startup	= mc13892_leds_startup,
+	.leds_shutdown	= mc13892_leds_shutdown,
+};
+
 static const struct platform_device_id mc13xxx_led_id_table[] = {
 	{ "mc13783-led", (kernel_ulong_t)&mc13783_led_devtype, },
+	{ "mc13892-led", (kernel_ulong_t)&mc13892_led_devtype, },
 	{ }
 };
 MODULE_DEVICE_TABLE(platform, mc13xxx_led_id_table);
diff --git a/include/linux/mfd/mc13xxx.h b/include/linux/mfd/mc13xxx.h
index fe0e003..8eba95d 100644
--- a/include/linux/mfd/mc13xxx.h
+++ b/include/linux/mfd/mc13xxx.h
@@ -78,19 +78,30 @@ struct mc13xxx_regulator_platform_data {
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
+	/* MC13892 LED IDs */
+	MC13892_LED_MD,
+	MC13892_LED_AD,
+	MC13892_LED_KP,
+	MC13892_LED_R,
+	MC13892_LED_G,
+	MC13892_LED_B
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
 	int id;
 	const char *name;
 	const char *default_trigger;
@@ -103,6 +114,7 @@ struct mc13xxx_leds_platform_data {
 	int num_leds;
 	struct mc13xxx_led_platform_data *led;
 
+/* MC13783 specific */
 #define MC13783_LED_TRIODE_MD	(1 << 0)
 #define MC13783_LED_TRIODE_AD	(1 << 1)
 #define MC13783_LED_TRIODE_KP	(1 << 2)
@@ -113,7 +125,17 @@ struct mc13xxx_leds_platform_data {
 #define MC13783_LED_TRIODE_TC1	(1 << 7)
 #define MC13783_LED_TRIODE_TC2	(1 << 8)
 #define MC13783_LED_TRIODE_TC3	(1 << 9)
-	int flags;
+/* MC13892 specific */
+#define MC13892_LEDMD_HI_CURR	(1 << 10)
+#define MC13892_LEDMD_RAMP_EN	(1 << 11)
+#define MC13892_LEDAD_HI_CURR	(1 << 12)
+#define MC13892_LEDAD_RAMP_EN	(1 << 13)
+#define MC13892_LEDKP_HI_CURR	(1 << 14)
+#define MC13892_LEDKP_RAMP_EN	(1 << 15)
+#define MC13892_LEDR_RAMP_EN	(1 << 16)
+#define MC13892_LEDG_RAMP_EN	(1 << 17)
+#define MC13892_LEDB_RAMP_EN	(1 << 18)
+	unsigned int flags;
 
 #define MC13783_LED_AB_DISABLED		0
 #define MC13783_LED_AB_MD1		1
-- 
1.8.1.5
