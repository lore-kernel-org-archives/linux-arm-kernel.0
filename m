From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Mon, 25 Feb 2013 11:49:30 +0800
Subject: [PATCH v5 01/12] gpio: pxa: identify ed mask reg with platform data
In-Reply-To: <1361764181-26647-1-git-send-email-haojian.zhuang@linaro.org>
References: <1361764181-26647-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1361764181-26647-2-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Avoid to judge whether edge mask register exists by CPU. Use platform
data to identify it instead. The gpio edge mask register exists in MMP
series SoC.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 arch/arm/mach-mmp/aspenite.c      |    7 +++++++
 arch/arm/mach-mmp/avengers_lite.c |    7 +++++++
 arch/arm/mach-mmp/brownstone.c    |    7 +++++++
 arch/arm/mach-mmp/flint.c         |    7 +++++++
 arch/arm/mach-mmp/gplugd.c        |    7 +++++++
 arch/arm/mach-mmp/tavorevb.c      |    7 +++++++
 arch/arm/mach-mmp/teton_bga.c     |    7 +++++++
 arch/arm/mach-mmp/ttc_dkb.c       |    7 +++++++
 drivers/gpio/gpio-pxa.c           |    9 ++++++++-
 include/linux/gpio-pxa.h          |    1 +
 10 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-mmp/aspenite.c b/arch/arm/mach-mmp/aspenite.c
index 9f64d56..36f5781 100644
--- a/arch/arm/mach-mmp/aspenite.c
+++ b/arch/arm/mach-mmp/aspenite.c
@@ -9,6 +9,7 @@
  *  publishhed by the Free Software Foundation.
  */
 #include <linux/gpio.h>
+#include <linux/gpio-pxa.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
@@ -110,6 +111,10 @@ static unsigned long common_pin_config[] __initdata = {
 	GPIO121_KP_MKIN4,
 };
 
+static struct pxa_gpio_platform_data pxa168_gpio_pdata = {
+	.ed_mask	= true,
+};
+
 static struct smc91x_platdata smc91x_info = {
 	.flags	= SMC91X_USE_16BIT | SMC91X_NOWAIT,
 };
@@ -248,6 +253,8 @@ static void __init common_init(void)
 	pxa168_add_nand(&aspenite_nand_info);
 	pxa168_add_fb(&aspenite_lcd_info);
 	pxa168_add_keypad(&aspenite_keypad_info);
+	platform_device_add_data(&pxa168_device_gpio, &pxa168_gpio_pdata,
+				 sizeof(struct pxa_gpio_platform_data));
 	platform_device_register(&pxa168_device_gpio);
 
 	/* off-chip devices */
diff --git a/arch/arm/mach-mmp/avengers_lite.c b/arch/arm/mach-mmp/avengers_lite.c
index 1f94957..b8fe447 100644
--- a/arch/arm/mach-mmp/avengers_lite.c
+++ b/arch/arm/mach-mmp/avengers_lite.c
@@ -12,6 +12,7 @@
 
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/gpio-pxa.h>
 #include <linux/platform_device.h>
 
 #include <asm/mach-types.h>
@@ -32,12 +33,18 @@ static unsigned long avengers_lite_pin_config_V16F[] __initdata = {
 	GPIO89_UART2_RXD,
 };
 
+static struct pxa_gpio_platform_data pxa168_gpio_pdata = {
+	.ed_mask	= true,
+};
+
 static void __init avengers_lite_init(void)
 {
 	mfp_config(ARRAY_AND_SIZE(avengers_lite_pin_config_V16F));
 
 	/* on-chip devices */
 	pxa168_add_uart(2);
+	platform_device_add_data(&pxa168_device_gpio, &pxa168_gpio_pdata,
+				 sizeof(struct pxa_gpio_platform_data));
 	platform_device_register(&pxa168_device_gpio);
 }
 
diff --git a/arch/arm/mach-mmp/brownstone.c b/arch/arm/mach-mmp/brownstone.c
index 2358011..d6ea5c4 100644
--- a/arch/arm/mach-mmp/brownstone.c
+++ b/arch/arm/mach-mmp/brownstone.c
@@ -14,6 +14,7 @@
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
+#include <linux/gpio-pxa.h>
 #include <linux/regulator/machine.h>
 #include <linux/regulator/max8649.h>
 #include <linux/regulator/fixed.h>
@@ -104,6 +105,10 @@ static unsigned long brownstone_pin_config[] __initdata = {
 	GPIO89_GPIO,
 };
 
+static struct pxa_gpio_platform_data mmp2_gpio_pdata = {
+	.ed_mask	= true,
+};
+
 static struct regulator_consumer_supply max8649_supply[] = {
 	REGULATOR_SUPPLY("vcc_core", NULL),
 };
@@ -202,6 +207,8 @@ static void __init brownstone_init(void)
 	/* on-chip devices */
 	mmp2_add_uart(1);
 	mmp2_add_uart(3);
+	platform_device_add_data(&mmp2_device_gpio, &mmp2_gpio_pdata,
+				 sizeof(struct pxa_gpio_platform_data));
 	platform_device_register(&mmp2_device_gpio);
 	mmp2_add_twsi(1, NULL, ARRAY_AND_SIZE(brownstone_twsi1_info));
 	mmp2_add_sdhost(0, &mmp2_sdh_platdata_mmc0); /* SD/MMC */
diff --git a/arch/arm/mach-mmp/flint.c b/arch/arm/mach-mmp/flint.c
index 754c352..0955f44 100644
--- a/arch/arm/mach-mmp/flint.c
+++ b/arch/arm/mach-mmp/flint.c
@@ -16,6 +16,7 @@
 #include <linux/smc91x.h>
 #include <linux/io.h>
 #include <linux/gpio.h>
+#include <linux/gpio-pxa.h>
 #include <linux/interrupt.h>
 
 #include <asm/mach-types.h>
@@ -77,6 +78,10 @@ static unsigned long flint_pin_config[] __initdata = {
 	GPIO160_ND_RDY1,
 };
 
+static struct pxa_gpio_platform_data mmp2_gpio_pdata = {
+	.ed_mask	= true,
+};
+
 static struct smc91x_platdata flint_smc91x_info = {
 	.flags  = SMC91X_USE_16BIT | SMC91X_NOWAIT,
 };
@@ -111,6 +116,8 @@ static void __init flint_init(void)
 	/* on-chip devices */
 	mmp2_add_uart(1);
 	mmp2_add_uart(2);
+	platform_device_add_data(&mmp2_device_gpio, &mmp2_gpio_pdata,
+				 sizeof(struct pxa_gpio_platform_data));
 	platform_device_register(&mmp2_device_gpio);
 
 	/* off-chip devices */
diff --git a/arch/arm/mach-mmp/gplugd.c b/arch/arm/mach-mmp/gplugd.c
index d1e2d59..2315cce 100644
--- a/arch/arm/mach-mmp/gplugd.c
+++ b/arch/arm/mach-mmp/gplugd.c
@@ -10,6 +10,7 @@
 
 #include <linux/init.h>
 #include <linux/gpio.h>
+#include <linux/gpio-pxa.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
@@ -127,6 +128,10 @@ static unsigned long gplugd_pin_config[] __initdata = {
 	GPIO116_I2S_TXD
 };
 
+static struct pxa_gpio_platform_data pxa168_gpio_pdata = {
+	.ed_mask	= true,
+};
+
 static struct i2c_board_info gplugd_i2c_board_info[] = {
 	{
 		.type = "isl1208",
@@ -185,6 +190,8 @@ static void __init gplugd_init(void)
 	pxa168_add_uart(3);
 	pxa168_add_ssp(1);
 	pxa168_add_twsi(0, NULL, ARRAY_AND_SIZE(gplugd_i2c_board_info));
+	platform_device_add_data(&pxa168_device_gpio, &pxa168_gpio_pdata,
+				 sizeof(struct pxa_gpio_platform_data));
 	platform_device_register(&pxa168_device_gpio);
 
 	pxa168_add_eth(&gplugd_eth_platform_data);
diff --git a/arch/arm/mach-mmp/tavorevb.c b/arch/arm/mach-mmp/tavorevb.c
index 4c127d2..eaec649 100644
--- a/arch/arm/mach-mmp/tavorevb.c
+++ b/arch/arm/mach-mmp/tavorevb.c
@@ -8,6 +8,7 @@
  *  publishhed by the Free Software Foundation.
  */
 #include <linux/gpio.h>
+#include <linux/gpio-pxa.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
@@ -60,6 +61,10 @@ static unsigned long tavorevb_pin_config[] __initdata = {
 	DF_RDY0_DF_RDY0,
 };
 
+static struct pxa_gpio_platform_data ttc_dkb_gpio_pdata = {
+	.ed_mask	= true,
+};
+
 static struct smc91x_platdata tavorevb_smc91x_info = {
 	.flags	= SMC91X_USE_16BIT | SMC91X_NOWAIT,
 };
@@ -93,6 +98,8 @@ static void __init tavorevb_init(void)
 
 	/* on-chip devices */
 	pxa910_add_uart(1);
+	platform_device_add_data(&pxa910_device_gpio, &ttc_dkb_gpio_pdata,
+				 sizeof(struct pxa_gpio_platform_data));
 	platform_device_register(&pxa910_device_gpio);
 
 	/* off-chip devices */
diff --git a/arch/arm/mach-mmp/teton_bga.c b/arch/arm/mach-mmp/teton_bga.c
index 8609967..6682100 100644
--- a/arch/arm/mach-mmp/teton_bga.c
+++ b/arch/arm/mach-mmp/teton_bga.c
@@ -16,6 +16,7 @@
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
+#include <linux/gpio-pxa.h>
 #include <linux/input.h>
 #include <linux/platform_data/keypad-pxa27x.h>
 #include <linux/i2c.h>
@@ -49,6 +50,10 @@ static unsigned long teton_bga_pin_config[] __initdata = {
 	GPIO78_GPIO,
 };
 
+static struct pxa_gpio_platform_data pxa168_gpio_pdata = {
+	.ed_mask	= true,
+};
+
 static unsigned int teton_bga_matrix_key_map[] = {
 	KEY(0, 6, KEY_ESC),
 	KEY(0, 7, KEY_ENTER),
@@ -79,6 +84,8 @@ static void __init teton_bga_init(void)
 	pxa168_add_uart(1);
 	pxa168_add_keypad(&teton_bga_keypad_info);
 	pxa168_add_twsi(0, NULL, ARRAY_AND_SIZE(teton_bga_i2c_info));
+	platform_device_add_data(&pxa168_device_gpio, &pxa168_gpio_pdata,
+				 sizeof(struct pxa_gpio_platform_data));
 	platform_device_register(&pxa168_device_gpio);
 }
 
diff --git a/arch/arm/mach-mmp/ttc_dkb.c b/arch/arm/mach-mmp/ttc_dkb.c
index 22a9058..d8df90b 100644
--- a/arch/arm/mach-mmp/ttc_dkb.c
+++ b/arch/arm/mach-mmp/ttc_dkb.c
@@ -17,6 +17,7 @@
 #include <linux/interrupt.h>
 #include <linux/i2c/pca953x.h>
 #include <linux/gpio.h>
+#include <linux/gpio-pxa.h>
 #include <linux/mfd/88pm860x.h>
 #include <linux/platform_data/mv_usb.h>
 #include <linux/spi/spi.h>
@@ -75,6 +76,10 @@ static unsigned long ttc_dkb_pin_config[] __initdata = {
 	DF_RDY0_DF_RDY0,
 };
 
+static struct pxa_gpio_platform_data ttc_dkb_gpio_pdata = {
+	.ed_mask	= true,
+};
+
 static struct mtd_partition ttc_dkb_onenand_partitions[] = {
 	{
 		.name		= "bootloader",
@@ -284,6 +289,8 @@ static void __init ttc_dkb_init(void)
 
 	/* off-chip devices */
 	pxa910_add_twsi(0, NULL, ARRAY_AND_SIZE(ttc_dkb_i2c_info));
+	platform_device_add_data(&pxa910_device_gpio, &ttc_dkb_gpio_pdata,
+				 sizeof(struct pxa_gpio_platform_data));
 	platform_add_devices(ARRAY_AND_SIZE(ttc_dkb_devices));
 
 #ifdef CONFIG_USB_MV_UDC
diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index 9cc108d..59841b1 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -493,6 +493,7 @@ const struct irq_domain_ops pxa_irq_domain_ops = {
 static int pxa_gpio_probe_dt(struct platform_device *pdev)
 {
 	int ret, nr_banks, nr_gpios;
+	struct pxa_gpio_platform_data *pdata;
 	struct device_node *prev, *next, *np = pdev->dev.of_node;
 	const struct of_device_id *of_id =
 				of_match_device(pxa_gpio_dt_ids, &pdev->dev);
@@ -501,6 +502,12 @@ static int pxa_gpio_probe_dt(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Failed to find gpio controller\n");
 		return -EFAULT;
 	}
+	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
+	pdata->ed_mask = of_property_read_bool(np, "marvell,gpio-ed-mask");
+	/* set the platform data */
+	pdev->dev.platform_data = pdata;
 	gpio_type = (int)of_id->data;
 
 	next = of_get_next_child(np, NULL);
@@ -604,7 +611,7 @@ static int pxa_gpio_probe(struct platform_device *pdev)
 		writel_relaxed(0, c->regbase + GRER_OFFSET);
 		writel_relaxed(~0,c->regbase + GEDR_OFFSET);
 		/* unmask GPIO edge detect for AP side */
-		if (gpio_is_mmp_type(gpio_type))
+		if (info->ed_mask)
 			writel_relaxed(~0, c->regbase + ED_MASK_OFFSET);
 	}
 
diff --git a/include/linux/gpio-pxa.h b/include/linux/gpio-pxa.h
index d755b28..bc5cae5 100644
--- a/include/linux/gpio-pxa.h
+++ b/include/linux/gpio-pxa.h
@@ -14,6 +14,7 @@ extern int pxa_last_gpio;
 extern int pxa_irq_to_gpio(int irq);
 
 struct pxa_gpio_platform_data {
+	bool ed_mask;	/* true means that ed_mask reg is available */
 	int (*gpio_set_wake)(unsigned int gpio, unsigned int on);
 };
 
-- 
1.7.10.4
