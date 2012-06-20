From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 20 Jun 2012 13:56:40 +0100
Subject: [PATCH 04/15] mfd: ab8500: Register devices using the newly DT:ed MFD
 API
In-Reply-To: <1340197011-5435-1-git-send-email-lee.jones@linaro.org>
References: <1340197011-5435-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1340197011-5435-5-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now the MFD API is Device Tree aware we can use it for platform
registration again, even when booting with DT enabled. To aid in
Device Node pointer allocation we provide each cell with the
associative compatible string.

Cc: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/board-mop500.c |    1 -
 drivers/input/misc/ab8500-ponkey.c |    6 ----
 drivers/mfd/ab8500-core.c          |   64 ++++++++++++++++++++++--------------
 drivers/mfd/ab8500-debugfs.c       |    6 ----
 drivers/mfd/ab8500-gpadc.c         |    6 ----
 drivers/mfd/ab8500-sysctrl.c       |    6 ----
 drivers/misc/ab8500-pwm.c          |    6 ----
 drivers/regulator/ab8500.c         |    6 ----
 drivers/rtc/rtc-ab8500.c           |    7 ----
 drivers/usb/otg/ab8500-usb.c       |    6 ----
 10 files changed, 39 insertions(+), 75 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 1087176..7e5b161 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -822,7 +822,6 @@ static const struct of_device_id u8500_local_bus_nodes[] = {
 	{ .compatible = "stericsson,db8500-prcmu", },
 	{ .compatible = "stericsson,db8500-prcmu-regulator", },
 	{ .compatible = "stericsson,ab8500", },
-	{ .compatible = "stericsson,ab8500-regulator", },
 	{ .compatible = "simple-bus"},
 	{ },
 };
diff --git a/drivers/input/misc/ab8500-ponkey.c b/drivers/input/misc/ab8500-ponkey.c
index 33e5b1e..5ceb23e 100644
--- a/drivers/input/misc/ab8500-ponkey.c
+++ b/drivers/input/misc/ab8500-ponkey.c
@@ -132,16 +132,10 @@ static int __devexit ab8500_ponkey_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id ab8500_ponkey_match[] = {
-	{ .compatible = "stericsson,ab8500-ponkey", },
-	{}
-};
-
 static struct platform_driver ab8500_ponkey_driver = {
 	.driver		= {
 		.name	= "ab8500-poweron-key",
 		.owner	= THIS_MODULE,
-		.of_match_table = ab8500_ponkey_match,
 	},
 	.probe		= ab8500_ponkey_probe,
 	.remove		= __devexit_p(ab8500_ponkey_remove),
diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
index 8de3b65..79d7672 100644
--- a/drivers/mfd/ab8500-core.c
+++ b/drivers/mfd/ab8500-core.c
@@ -970,54 +970,69 @@ static struct mfd_cell __devinitdata abx500_common_devs[] = {
 #ifdef CONFIG_DEBUG_FS
 	{
 		.name = "ab8500-debug",
+		.of_compatible = "stericsson,ab8500-debug",
 		.num_resources = ARRAY_SIZE(ab8500_debug_resources),
 		.resources = ab8500_debug_resources,
 	},
 #endif
 	{
 		.name = "ab8500-sysctrl",
+		.of_compatible = "stericsson,ab8500-sysctrl",
 	},
 	{
 		.name = "ab8500-regulator",
+		.of_compatible = "stericsson,ab8500-regulator",
 	},
 	{
 		.name = "ab8500-gpadc",
+		.of_compatible = "stericsson,ab8500-gpadc",
 		.num_resources = ARRAY_SIZE(ab8500_gpadc_resources),
 		.resources = ab8500_gpadc_resources,
 	},
 	{
 		.name = "ab8500-rtc",
+		.of_compatible = "stericsson,ab8500-rtc",
 		.num_resources = ARRAY_SIZE(ab8500_rtc_resources),
 		.resources = ab8500_rtc_resources,
 	},
 	{
 		.name = "ab8500-acc-det",
+		.of_compatible = "stericsson,ab8500-acc-det",
 		.num_resources = ARRAY_SIZE(ab8500_av_acc_detect_resources),
 		.resources = ab8500_av_acc_detect_resources,
 	},
 	{
 		.name = "ab8500-poweron-key",
+		.of_compatible = "stericsson,ab8500-poweron-key",
 		.num_resources = ARRAY_SIZE(ab8500_poweronkey_db_resources),
 		.resources = ab8500_poweronkey_db_resources,
 	},
 	{
 		.name = "ab8500-pwm",
+		.of_compatible = "stericsson,ab8500-pwm",
 		.id = 1,
 	},
 	{
 		.name = "ab8500-pwm",
+		.of_compatible = "stericsson,ab8500-pwm",
 		.id = 2,
 	},
 	{
 		.name = "ab8500-pwm",
+		.of_compatible = "stericsson,ab8500-pwm",
 		.id = 3,
 	},
-	{ .name = "ab8500-leds", },
+	{
+		.name = "ab8500-leds",
+		.of_compatible = "stericsson,ab8500-leds",
+	},
 	{
 		.name = "ab8500-denc",
+		.of_compatible = "stericsson,ab8500-denc",
 	},
 	{
 		.name = "ab8500-temp",
+		.of_compatible = "stericsson,ab8500-temp",
 		.num_resources = ARRAY_SIZE(ab8500_temp_resources),
 		.resources = ab8500_temp_resources,
 	},
@@ -1049,11 +1064,13 @@ static struct mfd_cell __devinitdata ab8500_bm_devs[] = {
 static struct mfd_cell __devinitdata ab8500_devs[] = {
 	{
 		.name = "ab8500-gpio",
+		.of_compatible = "stericsson,ab8500-gpio",
 		.num_resources = ARRAY_SIZE(ab8500_gpio_resources),
 		.resources = ab8500_gpio_resources,
 	},
 	{
 		.name = "ab8500-usb",
+		.of_compatible = "stericsson,ab8500-usb",
 		.num_resources = ARRAY_SIZE(ab8500_usb_resources),
 		.resources = ab8500_usb_resources,
 	},
@@ -1388,32 +1405,29 @@ static int __devinit ab8500_probe(struct platform_device *pdev)
 			goto out_freeoldmask;
 	}
 
-	if (!np) {
-		ret = mfd_add_devices(ab8500->dev, 0, abx500_common_devs,
-				ARRAY_SIZE(abx500_common_devs), NULL,
-				ab8500->irq_base);
+	ret = mfd_add_devices(ab8500->dev, 0, abx500_common_devs,
+			ARRAY_SIZE(abx500_common_devs), NULL,
+			ab8500->irq_base);
+	if (ret)
+		goto out_freeirq;
 
-		if (ret)
-			goto out_freeirq;
-
-		if (is_ab9540(ab8500))
-			ret = mfd_add_devices(ab8500->dev, 0, ab9540_devs,
-					ARRAY_SIZE(ab9540_devs), NULL,
-					ab8500->irq_base);
-		else
-			ret = mfd_add_devices(ab8500->dev, 0, ab8500_devs,
-					ARRAY_SIZE(ab8500_devs), NULL,
-					ab8500->irq_base);
-		if (ret)
-			goto out_freeirq;
+	if (is_ab9540(ab8500))
+		ret = mfd_add_devices(ab8500->dev, 0, ab9540_devs,
+				ARRAY_SIZE(ab9540_devs), NULL,
+				ab8500->irq_base);
+	else
+		ret = mfd_add_devices(ab8500->dev, 0, ab8500_devs,
+				ARRAY_SIZE(ab8500_devs), NULL,
+				ab8500->irq_base);
+	if (ret)
+		goto out_freeirq;
 
-		if (is_ab9540(ab8500) || is_ab8505(ab8500))
-			ret = mfd_add_devices(ab8500->dev, 0, ab9540_ab8505_devs,
-					ARRAY_SIZE(ab9540_ab8505_devs), NULL,
-					ab8500->irq_base);
-		if (ret)
-			goto out_freeirq;
-	}
+	if (is_ab9540(ab8500) || is_ab8505(ab8500))
+		ret = mfd_add_devices(ab8500->dev, 0, ab9540_ab8505_devs,
+				ARRAY_SIZE(ab9540_ab8505_devs), NULL,
+				ab8500->irq_base);
+	if (ret)
+		goto out_freeirq;
 
 	if (!no_bm) {
 		/* Add battery management devices */
diff --git a/drivers/mfd/ab8500-debugfs.c b/drivers/mfd/ab8500-debugfs.c
index 361de52..c4cb806 100644
--- a/drivers/mfd/ab8500-debugfs.c
+++ b/drivers/mfd/ab8500-debugfs.c
@@ -608,16 +608,10 @@ static int __devexit ab8500_debug_remove(struct platform_device *plf)
 	return 0;
 }
 
-static const struct of_device_id ab8500_debug_match[] = {
-        { .compatible = "stericsson,ab8500-debug", },
-        {}
-};
-
 static struct platform_driver ab8500_debug_driver = {
 	.driver = {
 		.name = "ab8500-debug",
 		.owner = THIS_MODULE,
-		.of_match_table = ab8500_debug_match,
 	},
 	.probe  = ab8500_debug_probe,
 	.remove = __devexit_p(ab8500_debug_remove)
diff --git a/drivers/mfd/ab8500-gpadc.c b/drivers/mfd/ab8500-gpadc.c
index b6cbc3ba..866f959 100644
--- a/drivers/mfd/ab8500-gpadc.c
+++ b/drivers/mfd/ab8500-gpadc.c
@@ -649,18 +649,12 @@ static int __devexit ab8500_gpadc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id ab8500_gpadc_match[] = {
-	{ .compatible = "stericsson,ab8500-gpadc", },
-	{}
-};
-
 static struct platform_driver ab8500_gpadc_driver = {
 	.probe = ab8500_gpadc_probe,
 	.remove = __devexit_p(ab8500_gpadc_remove),
 	.driver = {
 		.name = "ab8500-gpadc",
 		.owner = THIS_MODULE,
-		.of_match_table = ab8500_gpadc_match,
 	},
 };
 
diff --git a/drivers/mfd/ab8500-sysctrl.c b/drivers/mfd/ab8500-sysctrl.c
index 5a3e51c..c28d4eb 100644
--- a/drivers/mfd/ab8500-sysctrl.c
+++ b/drivers/mfd/ab8500-sysctrl.c
@@ -61,16 +61,10 @@ static int __devexit ab8500_sysctrl_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id ab8500_sysctrl_match[] = {
-	{ .compatible = "stericsson,ab8500-sysctrl", },
-	{}
-};
-
 static struct platform_driver ab8500_sysctrl_driver = {
 	.driver = {
 		.name = "ab8500-sysctrl",
 		.owner = THIS_MODULE,
-		.of_match_table = ab8500_sysctrl_match,
 	},
 	.probe = ab8500_sysctrl_probe,
 	.remove = __devexit_p(ab8500_sysctrl_remove),
diff --git a/drivers/misc/ab8500-pwm.c b/drivers/misc/ab8500-pwm.c
index 042a8fe..d7a9aa1 100644
--- a/drivers/misc/ab8500-pwm.c
+++ b/drivers/misc/ab8500-pwm.c
@@ -142,16 +142,10 @@ static int __devexit ab8500_pwm_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id ab8500_pwm_match[] = {
-	{ .compatible = "stericsson,ab8500-pwm", },
-	{}
-};
-
 static struct platform_driver ab8500_pwm_driver = {
 	.driver = {
 		.name = "ab8500-pwm",
 		.owner = THIS_MODULE,
-		.of_match_table = ab8500_pwm_match,
 	},
 	.probe = ab8500_pwm_probe,
 	.remove = __devexit_p(ab8500_pwm_remove),
diff --git a/drivers/regulator/ab8500.c b/drivers/regulator/ab8500.c
index a739f5c..6745bd2 100644
--- a/drivers/regulator/ab8500.c
+++ b/drivers/regulator/ab8500.c
@@ -906,18 +906,12 @@ static __devexit int ab8500_regulator_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id ab8500_regulator_match[] = {
-        { .compatible = "stericsson,ab8500-regulator", },
-        {}
-};
-
 static struct platform_driver ab8500_regulator_driver = {
 	.probe = ab8500_regulator_probe,
 	.remove = __devexit_p(ab8500_regulator_remove),
 	.driver         = {
 		.name   = "ab8500-regulator",
 		.owner  = THIS_MODULE,
-		.of_match_table = ab8500_regulator_match,
 	},
 };
 
diff --git a/drivers/rtc/rtc-ab8500.c b/drivers/rtc/rtc-ab8500.c
index 116c23d..3046af5 100644
--- a/drivers/rtc/rtc-ab8500.c
+++ b/drivers/rtc/rtc-ab8500.c
@@ -17,7 +17,6 @@
 #include <linux/mfd/abx500.h>
 #include <linux/mfd/abx500/ab8500.h>
 #include <linux/delay.h>
-#include <linux/of.h>
 
 #define AB8500_RTC_SOFF_STAT_REG	0x00
 #define AB8500_RTC_CC_CONF_REG		0x01
@@ -454,16 +453,10 @@ static int __devexit ab8500_rtc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id ab8500_rtc_match[] = {
-        { .compatible = "stericsson,ab8500-rtc", },
-        {}
-};
-
 static struct platform_driver ab8500_rtc_driver = {
 	.driver = {
 		.name = "ab8500-rtc",
 		.owner = THIS_MODULE,
-		.of_match_table = ab8500_rtc_match,
 	},
 	.probe	= ab8500_rtc_probe,
 	.remove = __devexit_p(ab8500_rtc_remove),
diff --git a/drivers/usb/otg/ab8500-usb.c b/drivers/usb/otg/ab8500-usb.c
index 9799ac6..a84af67 100644
--- a/drivers/usb/otg/ab8500-usb.c
+++ b/drivers/usb/otg/ab8500-usb.c
@@ -569,18 +569,12 @@ static int __devexit ab8500_usb_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id ab8500_usb_match[] = {
-	{ .compatible = "stericsson,ab8500-usb", },
-	{},
-};
-
 static struct platform_driver ab8500_usb_driver = {
 	.probe		= ab8500_usb_probe,
 	.remove		= __devexit_p(ab8500_usb_remove),
 	.driver		= {
 		.name	= "ab8500-usb",
 		.owner	= THIS_MODULE,
-		.of_match_table = ab8500_usb_match,
 	},
 };
 
-- 
1.7.9.5
