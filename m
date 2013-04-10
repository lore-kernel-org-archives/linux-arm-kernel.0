From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Wed, 10 Apr 2013 09:18:25 +0800
Subject: [PATCH 2/3] ARM: pxa: move PXA_GPIO_TO_IRQ macro
In-Reply-To: <1365556707-9159-1-git-send-email-haojian.zhuang@linaro.org>
References: <1365556707-9159-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1365556707-9159-2-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since PXA_GPIO_TO_IRQ() & MMP_GPIO_TO_IRQ() macro are depended on
arch code, move them from gpio driver to platform driver instead.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 arch/arm/mach-mmp/aspenite.c      |    7 +++++++
 arch/arm/mach-mmp/avengers_lite.c |    7 +++++++
 arch/arm/mach-mmp/brownstone.c    |    7 +++++++
 arch/arm/mach-mmp/flint.c         |    7 +++++++
 arch/arm/mach-mmp/gplugd.c        |    7 +++++++
 arch/arm/mach-mmp/jasper.c        |    8 ++++++++
 arch/arm/mach-mmp/tavorevb.c      |    7 +++++++
 arch/arm/mach-mmp/teton_bga.c     |    7 +++++++
 arch/arm/mach-mmp/ttc_dkb.c       |    7 +++++++
 arch/arm/mach-pxa/pxa25x.c        |    3 ++-
 arch/arm/mach-pxa/pxa27x.c        |    3 ++-
 arch/arm/mach-pxa/pxa3xx.c        |   11 ++++++++++-
 arch/arm/mach-pxa/pxa930.c        |   12 ++++++++++--
 drivers/gpio/gpio-pxa.c           |   20 +++++++++-----------
 include/linux/gpio-pxa.h          |    1 +
 15 files changed, 98 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-mmp/aspenite.c b/arch/arm/mach-mmp/aspenite.c
index 76901f4..5b660ec 100644
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
+	.irq_base	= MMP_GPIO_TO_IRQ(0),
+};
+
 static struct smc91x_platdata smc91x_info = {
 	.flags	= SMC91X_USE_16BIT | SMC91X_NOWAIT,
 };
@@ -242,6 +247,8 @@ static void __init common_init(void)
 	pxa168_add_nand(&aspenite_nand_info);
 	pxa168_add_fb(&aspenite_lcd_info);
 	pxa168_add_keypad(&aspenite_keypad_info);
+	platform_device_add_data(&pxa168_device_gpio, &pxa168_gpio_pdata,
+				 sizeof(struct pxa_gpio_platform_data));
 	platform_device_register(&pxa168_device_gpio);
 
 	/* off-chip devices */
diff --git a/arch/arm/mach-mmp/avengers_lite.c b/arch/arm/mach-mmp/avengers_lite.c
index 1f94957..a451a0f 100644
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
+	.irq_base	= MMP_GPIO_TO_IRQ(0),
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
index 2358011..ac25544 100644
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
+	.irq_base	= MMP_GPIO_TO_IRQ(0),
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
index 754c352..6291c33 100644
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
+	.irq_base	= MMP_GPIO_TO_IRQ(0),
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
index f62b68d..d81b247 100644
--- a/arch/arm/mach-mmp/gplugd.c
+++ b/arch/arm/mach-mmp/gplugd.c
@@ -11,6 +11,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
+#include <linux/gpio-pxa.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
@@ -128,6 +129,10 @@ static unsigned long gplugd_pin_config[] __initdata = {
 	GPIO116_I2S_TXD
 };
 
+static struct pxa_gpio_platform_data pxa168_gpio_pdata = {
+	.irq_base	= MMP_GPIO_TO_IRQ(0),
+};
+
 static struct i2c_board_info gplugd_i2c_board_info[] = {
 	{
 		.type = "isl1208",
@@ -186,6 +191,8 @@ static void __init gplugd_init(void)
 	pxa168_add_uart(3);
 	pxa168_add_ssp(1);
 	pxa168_add_twsi(0, NULL, ARRAY_AND_SIZE(gplugd_i2c_board_info));
+	platform_device_add_data(&pxa168_device_gpio, &pxa168_gpio_pdata,
+				 sizeof(struct pxa_gpio_platform_data));
 	platform_device_register(&pxa168_device_gpio);
 
 	pxa168_add_eth(&gplugd_eth_platform_data);
diff --git a/arch/arm/mach-mmp/jasper.c b/arch/arm/mach-mmp/jasper.c
index 66634fd..0e9e5c0 100644
--- a/arch/arm/mach-mmp/jasper.c
+++ b/arch/arm/mach-mmp/jasper.c
@@ -12,6 +12,7 @@
 
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/gpio-pxa.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/regulator/machine.h>
@@ -99,6 +100,10 @@ static unsigned long jasper_pin_config[] __initdata = {
 	GPIO151_MMC3_CLK,
 };
 
+static struct pxa_gpio_platform_data mmp2_gpio_pdata = {
+	.irq_base	= MMP_GPIO_TO_IRQ(0),
+};
+
 static struct regulator_consumer_supply max8649_supply[] = {
 	REGULATOR_SUPPLY("vcc_core", NULL),
 };
@@ -165,6 +170,9 @@ static void __init jasper_init(void)
 	mmp2_add_uart(1);
 	mmp2_add_uart(3);
 	mmp2_add_twsi(1, NULL, ARRAY_AND_SIZE(jasper_twsi1_info));
+	platform_device_add_data(&mmp2_device_gpio, &mmp2_gpio_pdata,
+				 sizeof(struct pxa_gpio_platform_data));
+	platform_device_register(&mmp2_device_gpio);
 	mmp2_add_sdhost(0, &mmp2_sdh_platdata_mmc0); /* SD/MMC */
 
 	regulator_has_full_constraints();
diff --git a/arch/arm/mach-mmp/tavorevb.c b/arch/arm/mach-mmp/tavorevb.c
index 4c127d2..cdfc9bf 100644
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
 
+static struct pxa_gpio_platform_data pxa910_gpio_pdata = {
+	.irq_base	= MMP_GPIO_TO_IRQ(0),
+};
+
 static struct smc91x_platdata tavorevb_smc91x_info = {
 	.flags	= SMC91X_USE_16BIT | SMC91X_NOWAIT,
 };
@@ -93,6 +98,8 @@ static void __init tavorevb_init(void)
 
 	/* on-chip devices */
 	pxa910_add_uart(1);
+	platform_device_add_data(&pxa910_device_gpio, &pxa910_gpio_pdata,
+				 sizeof(struct pxa_gpio_platform_data));
 	platform_device_register(&pxa910_device_gpio);
 
 	/* off-chip devices */
diff --git a/arch/arm/mach-mmp/teton_bga.c b/arch/arm/mach-mmp/teton_bga.c
index 8609967..e4d95b4 100644
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
+	.irq_base	= MMP_GPIO_TO_IRQ(0),
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
index 6528a5f..8483906 100644
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
 
+static struct pxa_gpio_platform_data pxa910_gpio_pdata = {
+	.irq_base	= MMP_GPIO_TO_IRQ(0),
+};
+
 static struct mtd_partition ttc_dkb_onenand_partitions[] = {
 	{
 		.name		= "bootloader",
@@ -278,6 +283,8 @@ static void __init ttc_dkb_init(void)
 
 	/* off-chip devices */
 	pxa910_add_twsi(0, NULL, ARRAY_AND_SIZE(ttc_dkb_i2c_info));
+	platform_device_add_data(&pxa910_device_gpio, &pxa910_gpio_pdata,
+				 sizeof(struct pxa_gpio_platform_data));
 	platform_add_devices(ARRAY_AND_SIZE(ttc_dkb_devices));
 
 #ifdef CONFIG_USB_MV_UDC
diff --git a/arch/arm/mach-pxa/pxa25x.c b/arch/arm/mach-pxa/pxa25x.c
index e31a881..f2c2897 100644
--- a/arch/arm/mach-pxa/pxa25x.c
+++ b/arch/arm/mach-pxa/pxa25x.c
@@ -344,7 +344,8 @@ void __init pxa25x_map_io(void)
 }
 
 static struct pxa_gpio_platform_data pxa25x_gpio_info __initdata = {
-	.gpio_set_wake = gpio_set_wake,
+	.irq_base	= PXA_GPIO_TO_IRQ(0),
+	.gpio_set_wake	= gpio_set_wake,
 };
 
 static struct platform_device *pxa25x_devices[] __initdata = {
diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index 7635ec5..301471a 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -431,7 +431,8 @@ void __init pxa27x_set_i2c_power_info(struct i2c_pxa_platform_data *info)
 }
 
 static struct pxa_gpio_platform_data pxa27x_gpio_info __initdata = {
-	.gpio_set_wake = gpio_set_wake,
+	.irq_base	= PXA_GPIO_TO_IRQ(0),
+	.gpio_set_wake	= gpio_set_wake,
 };
 
 static struct platform_device *devices[] __initdata = {
diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index 572666a..87011f3 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/gpio-pxa.h>
 #include <linux/pm.h>
 #include <linux/platform_device.h>
 #include <linux/irq.h>
@@ -436,6 +437,10 @@ void __init pxa3xx_set_i2c_power_info(struct i2c_pxa_platform_data *info)
 	pxa_register_device(&pxa3xx_device_i2c_power, info);
 }
 
+static struct pxa_gpio_platform_data pxa3xx_gpio_pdata = {
+	.irq_base	= PXA_GPIO_TO_IRQ(0),
+};
+
 static struct platform_device *devices[] __initdata = {
 	&pxa27x_device_udc,
 	&pxa_device_pmu,
@@ -488,8 +493,12 @@ static int __init pxa3xx_init(void)
 		ret = platform_add_devices(devices, ARRAY_SIZE(devices));
 		if (ret)
 			return ret;
-		if (cpu_is_pxa300() || cpu_is_pxa310() || cpu_is_pxa320())
+		if (cpu_is_pxa300() || cpu_is_pxa310() || cpu_is_pxa320()) {
+			platform_device_add_data(&pxa3xx_device_gpio,
+						 &pxa3xx_gpio_pdata,
+						 sizeof(pxa3xx_gpio_pdata));
 			ret = platform_device_register(&pxa3xx_device_gpio);
+		}
 	}
 
 	return ret;
diff --git a/arch/arm/mach-pxa/pxa930.c b/arch/arm/mach-pxa/pxa930.c
index 4693a78..ab62448 100644
--- a/arch/arm/mach-pxa/pxa930.c
+++ b/arch/arm/mach-pxa/pxa930.c
@@ -12,9 +12,10 @@
 
 #include <linux/module.h>
 #include <linux/kernel.h>
-#include <linux/platform_device.h>
-#include <linux/irq.h>
 #include <linux/dma-mapping.h>
+#include <linux/irq.h>
+#include <linux/gpio-pxa.h>
+#include <linux/platform_device.h>
 
 #include <mach/pxa930.h>
 
@@ -192,6 +193,10 @@ static struct mfp_addr_map pxa935_mfp_addr_map[] __initdata = {
 	MFP_ADDR_END,
 };
 
+static struct pxa_gpio_platform_data pxa93x_gpio_pdata = {
+	.irq_base	= PXA_GPIO_TO_IRQ(0),
+};
+
 static int __init pxa930_init(void)
 {
 	int ret = 0;
@@ -199,6 +204,9 @@ static int __init pxa930_init(void)
 	if (cpu_is_pxa93x()) {
 		mfp_init_base(io_p2v(MFPR_BASE));
 		mfp_init_addr(pxa930_mfp_addr_map);
+		platform_device_add_data(&pxa93x_device_gpio,
+					 &pxa93x_gpio_pdata,
+					 sizeof(pxa93x_gpio_pdata));
 		ret = platform_device_register(&pxa93x_device_gpio);
 	}
 
diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index 6d53882..f4b0737 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -573,19 +573,18 @@ static int pxa_gpio_probe(struct platform_device *pdev)
 	int gpio, irq, ret, use_of = 0;
 	int irq0 = 0, irq1 = 0, irq_mux, gpio_offset = 0;
 
-	ret = pxa_gpio_probe_dt(pdev);
-	if (ret < 0) {
+	info = dev_get_platdata(&pdev->dev);
+	if (info) {
+		irq_base = info->irq_base;
+		if (irq_base <= 0)
+			return -EINVAL;
 		pxa_last_gpio = pxa_gpio_nums(pdev);
-#ifdef CONFIG_ARCH_PXA
-		if (gpio_is_pxa_type(gpio_type))
-			irq_base = PXA_GPIO_TO_IRQ(0);
-#endif
-#ifdef CONFIG_ARCH_MMP
-		if (gpio_is_mmp_type(gpio_type))
-			irq_base = MMP_GPIO_TO_IRQ(0);
-#endif
 	} else {
+		irq_base = 0;
 		use_of = 1;
+		ret = pxa_gpio_probe_dt(pdev);
+		if (ret < 0)
+			return -EINVAL;
 	}
 
 	if (!pxa_last_gpio)
@@ -622,7 +621,6 @@ static int pxa_gpio_probe(struct platform_device *pdev)
 	}
 
 	/* Initialize GPIO chips */
-	info = dev_get_platdata(&pdev->dev);
 	pxa_init_gpio_chip(pxa_last_gpio, info ? info->gpio_set_wake : NULL);
 
 	/* clear all GPIO edge detects */
diff --git a/include/linux/gpio-pxa.h b/include/linux/gpio-pxa.h
index d755b28..d90ebbe 100644
--- a/include/linux/gpio-pxa.h
+++ b/include/linux/gpio-pxa.h
@@ -14,6 +14,7 @@ extern int pxa_last_gpio;
 extern int pxa_irq_to_gpio(int irq);
 
 struct pxa_gpio_platform_data {
+	int irq_base;
 	int (*gpio_set_wake)(unsigned int gpio, unsigned int on);
 };
 
-- 
1.7.10.4
