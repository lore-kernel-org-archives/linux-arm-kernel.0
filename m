From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Wed, 10 Apr 2013 09:18:24 +0800
Subject: [PATCH 1/3] ARM: pxa: remove cpu_is_xxx in gpio driver
Message-ID: <1365556707-9159-1-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Avoid to use cpu_is_xxx() in pxa gpio driver. Use platform_device_id
to identify the difference.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 arch/arm/mach-mmp/clock-mmp2.c   |    2 +-
 arch/arm/mach-mmp/clock-pxa168.c |    2 +-
 arch/arm/mach-mmp/clock-pxa910.c |    2 +-
 arch/arm/mach-mmp/mmp-dt.c       |    4 +-
 arch/arm/mach-mmp/mmp2-dt.c      |    2 +-
 arch/arm/mach-mmp/mmp2.c         |    2 +-
 arch/arm/mach-mmp/pxa168.c       |    2 +-
 arch/arm/mach-mmp/pxa910.c       |    2 +-
 arch/arm/mach-pxa/devices.c      |   29 ++++++++++-
 arch/arm/mach-pxa/devices.h      |    6 ++-
 arch/arm/mach-pxa/pxa25x.c       |    8 ++-
 arch/arm/mach-pxa/pxa27x.c       |    4 +-
 arch/arm/mach-pxa/pxa3xx.c       |   14 +++--
 arch/arm/mach-pxa/pxa930.c       |    5 ++
 drivers/clk/mmp/clk-mmp2.c       |    2 +-
 drivers/clk/mmp/clk-pxa168.c     |    2 +-
 drivers/clk/mmp/clk-pxa910.c     |    2 +-
 drivers/gpio/gpio-pxa.c          |  106 ++++++++++++++++++++++++++------------
 18 files changed, 140 insertions(+), 56 deletions(-)

diff --git a/arch/arm/mach-mmp/clock-mmp2.c b/arch/arm/mach-mmp/clock-mmp2.c
index 21d2200..53d77cb 100644
--- a/arch/arm/mach-mmp/clock-mmp2.c
+++ b/arch/arm/mach-mmp/clock-mmp2.c
@@ -98,7 +98,7 @@ static struct clk_lookup mmp2_clkregs[] = {
 	INIT_CLKREG(&clk_twsi5, "pxa2xx-i2c.4", NULL),
 	INIT_CLKREG(&clk_twsi6, "pxa2xx-i2c.5", NULL),
 	INIT_CLKREG(&clk_nand, "pxa3xx-nand", NULL),
-	INIT_CLKREG(&clk_gpio, "pxa-gpio", NULL),
+	INIT_CLKREG(&clk_gpio, "mmp2-gpio", NULL),
 	INIT_CLKREG(&clk_sdh0, "sdhci-pxav3.0", "PXA-SDHCLK"),
 	INIT_CLKREG(&clk_sdh1, "sdhci-pxav3.1", "PXA-SDHCLK"),
 	INIT_CLKREG(&clk_sdh2, "sdhci-pxav3.2", "PXA-SDHCLK"),
diff --git a/arch/arm/mach-mmp/clock-pxa168.c b/arch/arm/mach-mmp/clock-pxa168.c
index 5e6c18c..c572f21 100644
--- a/arch/arm/mach-mmp/clock-pxa168.c
+++ b/arch/arm/mach-mmp/clock-pxa168.c
@@ -78,7 +78,7 @@ static struct clk_lookup pxa168_clkregs[] = {
 	INIT_CLKREG(&clk_ssp5, "pxa168-ssp.4", NULL),
 	INIT_CLKREG(&clk_nand, "pxa3xx-nand", NULL),
 	INIT_CLKREG(&clk_lcd, "pxa168-fb", NULL),
-	INIT_CLKREG(&clk_gpio, "pxa-gpio", NULL),
+	INIT_CLKREG(&clk_gpio, "mmp-gpio", NULL),
 	INIT_CLKREG(&clk_keypad, "pxa27x-keypad", NULL),
 	INIT_CLKREG(&clk_eth, "pxa168-eth", "MFUCLK"),
 	INIT_CLKREG(&clk_usb, NULL, "PXA168-USBCLK"),
diff --git a/arch/arm/mach-mmp/clock-pxa910.c b/arch/arm/mach-mmp/clock-pxa910.c
index 933ea71..379e1df 100644
--- a/arch/arm/mach-mmp/clock-pxa910.c
+++ b/arch/arm/mach-mmp/clock-pxa910.c
@@ -56,7 +56,7 @@ static struct clk_lookup pxa910_clkregs[] = {
 	INIT_CLKREG(&clk_pwm3, "pxa910-pwm.2", NULL),
 	INIT_CLKREG(&clk_pwm4, "pxa910-pwm.3", NULL),
 	INIT_CLKREG(&clk_nand, "pxa3xx-nand", NULL),
-	INIT_CLKREG(&clk_gpio, "pxa-gpio", NULL),
+	INIT_CLKREG(&clk_gpio, "mmp-gpio", NULL),
 	INIT_CLKREG(&clk_u2o, NULL, "U2OCLK"),
 	INIT_CLKREG(&clk_rtc, "sa1100-rtc", NULL),
 };
diff --git a/arch/arm/mach-mmp/mmp-dt.c b/arch/arm/mach-mmp/mmp-dt.c
index d063efa..5b890b6 100644
--- a/arch/arm/mach-mmp/mmp-dt.c
+++ b/arch/arm/mach-mmp/mmp-dt.c
@@ -28,7 +28,7 @@ static const struct of_dev_auxdata pxa168_auxdata_lookup[] __initconst = {
 	OF_DEV_AUXDATA("mrvl,mmp-uart", 0xd4026000, "pxa2xx-uart.2", NULL),
 	OF_DEV_AUXDATA("mrvl,mmp-twsi", 0xd4011000, "pxa2xx-i2c.0", NULL),
 	OF_DEV_AUXDATA("mrvl,mmp-twsi", 0xd4025000, "pxa2xx-i2c.1", NULL),
-	OF_DEV_AUXDATA("mrvl,mmp-gpio", 0xd4019000, "pxa-gpio", NULL),
+	OF_DEV_AUXDATA("mrvl,mmp-gpio", 0xd4019000, "mmp-gpio", NULL),
 	OF_DEV_AUXDATA("mrvl,mmp-rtc", 0xd4010000, "sa1100-rtc", NULL),
 	{}
 };
@@ -39,7 +39,7 @@ static const struct of_dev_auxdata pxa910_auxdata_lookup[] __initconst = {
 	OF_DEV_AUXDATA("mrvl,mmp-uart", 0xd4036000, "pxa2xx-uart.2", NULL),
 	OF_DEV_AUXDATA("mrvl,mmp-twsi", 0xd4011000, "pxa2xx-i2c.0", NULL),
 	OF_DEV_AUXDATA("mrvl,mmp-twsi", 0xd4037000, "pxa2xx-i2c.1", NULL),
-	OF_DEV_AUXDATA("mrvl,mmp-gpio", 0xd4019000, "pxa-gpio", NULL),
+	OF_DEV_AUXDATA("mrvl,mmp-gpio", 0xd4019000, "mmp-gpio", NULL),
 	OF_DEV_AUXDATA("mrvl,mmp-rtc", 0xd4010000, "sa1100-rtc", NULL),
 	{}
 };
diff --git a/arch/arm/mach-mmp/mmp2-dt.c b/arch/arm/mach-mmp/mmp2-dt.c
index fad431a..924b6e8 100644
--- a/arch/arm/mach-mmp/mmp2-dt.c
+++ b/arch/arm/mach-mmp/mmp2-dt.c
@@ -31,7 +31,7 @@ static const struct of_dev_auxdata mmp2_auxdata_lookup[] __initconst = {
 	OF_DEV_AUXDATA("mrvl,mmp-uart", 0xd4016000, "pxa2xx-uart.3", NULL),
 	OF_DEV_AUXDATA("mrvl,mmp-twsi", 0xd4011000, "pxa2xx-i2c.0", NULL),
 	OF_DEV_AUXDATA("mrvl,mmp-twsi", 0xd4025000, "pxa2xx-i2c.1", NULL),
-	OF_DEV_AUXDATA("mrvl,mmp-gpio", 0xd4019000, "pxa-gpio", NULL),
+	OF_DEV_AUXDATA("mrvl,mmp-gpio", 0xd4019000, "mmp2-gpio", NULL),
 	OF_DEV_AUXDATA("mrvl,mmp-rtc", 0xd4010000, "sa1100-rtc", NULL),
 	{}
 };
diff --git a/arch/arm/mach-mmp/mmp2.c b/arch/arm/mach-mmp/mmp2.c
index d94d114..c7592f1 100644
--- a/arch/arm/mach-mmp/mmp2.c
+++ b/arch/arm/mach-mmp/mmp2.c
@@ -164,7 +164,7 @@ struct resource mmp2_resource_gpio[] = {
 };
 
 struct platform_device mmp2_device_gpio = {
-	.name		= "pxa-gpio",
+	.name		= "mmp2-gpio",
 	.id		= -1,
 	.num_resources	= ARRAY_SIZE(mmp2_resource_gpio),
 	.resource	= mmp2_resource_gpio,
diff --git a/arch/arm/mach-mmp/pxa168.c b/arch/arm/mach-mmp/pxa168.c
index 9bc7b86..a30dcf3 100644
--- a/arch/arm/mach-mmp/pxa168.c
+++ b/arch/arm/mach-mmp/pxa168.c
@@ -125,7 +125,7 @@ struct resource pxa168_resource_gpio[] = {
 };
 
 struct platform_device pxa168_device_gpio = {
-	.name		= "pxa-gpio",
+	.name		= "mmp-gpio",
 	.id		= -1,
 	.num_resources	= ARRAY_SIZE(pxa168_resource_gpio),
 	.resource	= pxa168_resource_gpio,
diff --git a/arch/arm/mach-mmp/pxa910.c b/arch/arm/mach-mmp/pxa910.c
index 36cb321..ce6393a 100644
--- a/arch/arm/mach-mmp/pxa910.c
+++ b/arch/arm/mach-mmp/pxa910.c
@@ -152,7 +152,7 @@ struct resource pxa910_resource_gpio[] = {
 };
 
 struct platform_device pxa910_device_gpio = {
-	.name		= "pxa-gpio",
+	.name		= "mmp-gpio",
 	.id		= -1,
 	.num_resources	= ARRAY_SIZE(pxa910_resource_gpio),
 	.resource	= pxa910_resource_gpio,
diff --git a/arch/arm/mach-pxa/devices.c b/arch/arm/mach-pxa/devices.c
index daa86d3..6660943 100644
--- a/arch/arm/mach-pxa/devices.c
+++ b/arch/arm/mach-pxa/devices.c
@@ -1107,8 +1107,33 @@ struct resource pxa_resource_gpio[] = {
 	},
 };
 
-struct platform_device pxa_device_gpio = {
-	.name		= "pxa-gpio",
+struct platform_device pxa25x_device_gpio = {
+#ifdef CONFIG_CPU_PXA26x
+	.name		= "pxa26x-gpio",
+#else
+	.name		= "pxa25x-gpio",
+#endif
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(pxa_resource_gpio),
+	.resource	= pxa_resource_gpio,
+};
+
+struct platform_device pxa27x_device_gpio = {
+	.name		= "pxa27x-gpio",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(pxa_resource_gpio),
+	.resource	= pxa_resource_gpio,
+};
+
+struct platform_device pxa3xx_device_gpio = {
+	.name		= "pxa3xx-gpio",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(pxa_resource_gpio),
+	.resource	= pxa_resource_gpio,
+};
+
+struct platform_device pxa93x_device_gpio = {
+	.name		= "pxa93x-gpio",
 	.id		= -1,
 	.num_resources	= ARRAY_SIZE(pxa_resource_gpio),
 	.resource	= pxa_resource_gpio,
diff --git a/arch/arm/mach-pxa/devices.h b/arch/arm/mach-pxa/devices.h
index 1475db1..0f3fd0d 100644
--- a/arch/arm/mach-pxa/devices.h
+++ b/arch/arm/mach-pxa/devices.h
@@ -16,7 +16,6 @@ extern struct platform_device pxa_device_ficp;
 extern struct platform_device sa1100_device_rtc;
 extern struct platform_device pxa_device_rtc;
 extern struct platform_device pxa_device_ac97;
-extern struct platform_device pxa_device_gpio;
 
 extern struct platform_device pxa27x_device_i2c_power;
 extern struct platform_device pxa27x_device_ohci;
@@ -46,4 +45,9 @@ extern struct platform_device pxa_device_asoc_ssp2;
 extern struct platform_device pxa_device_asoc_ssp3;
 extern struct platform_device pxa_device_asoc_ssp4;
 
+extern struct platform_device pxa25x_device_gpio;
+extern struct platform_device pxa27x_device_gpio;
+extern struct platform_device pxa3xx_device_gpio;
+extern struct platform_device pxa93x_device_gpio;
+
 void __init pxa_register_device(struct platform_device *dev, void *data);
diff --git a/arch/arm/mach-pxa/pxa25x.c b/arch/arm/mach-pxa/pxa25x.c
index 3f5171e..e31a881 100644
--- a/arch/arm/mach-pxa/pxa25x.c
+++ b/arch/arm/mach-pxa/pxa25x.c
@@ -208,7 +208,11 @@ static struct clk_lookup pxa25x_clkregs[] = {
 	INIT_CLKREG(&clk_pxa25x_gpio11, NULL, "GPIO11_CLK"),
 	INIT_CLKREG(&clk_pxa25x_gpio12, NULL, "GPIO12_CLK"),
 	INIT_CLKREG(&clk_pxa25x_mem, "pxa2xx-pcmcia", NULL),
-	INIT_CLKREG(&clk_dummy, "pxa-gpio", NULL),
+#ifdef CONFIG_CPU_PXA26x
+	INIT_CLKREG(&clk_dummy, "pxa26x-gpio", NULL),
+#else
+	INIT_CLKREG(&clk_dummy, "pxa25x-gpio", NULL),
+#endif
 	INIT_CLKREG(&clk_dummy, "sa1100-rtc", NULL),
 };
 
@@ -375,7 +379,7 @@ static int __init pxa25x_init(void)
 		register_syscore_ops(&pxa2xx_mfp_syscore_ops);
 		register_syscore_ops(&pxa2xx_clock_syscore_ops);
 
-		pxa_register_device(&pxa_device_gpio, &pxa25x_gpio_info);
+		pxa_register_device(&pxa25x_device_gpio, &pxa25x_gpio_info);
 		ret = platform_add_devices(pxa25x_devices,
 					   ARRAY_SIZE(pxa25x_devices));
 		if (ret)
diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index 3203a9f..7635ec5 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -237,7 +237,7 @@ static struct clk_lookup pxa27x_clkregs[] = {
 	INIT_CLKREG(&clk_pxa27x_im, NULL, "IMCLK"),
 	INIT_CLKREG(&clk_pxa27x_memc, NULL, "MEMCLK"),
 	INIT_CLKREG(&clk_pxa27x_mem, "pxa2xx-pcmcia", NULL),
-	INIT_CLKREG(&clk_dummy, "pxa-gpio", NULL),
+	INIT_CLKREG(&clk_dummy, "pxa27x-gpio", NULL),
 	INIT_CLKREG(&clk_dummy, "sa1100-rtc", NULL),
 };
 
@@ -470,7 +470,7 @@ static int __init pxa27x_init(void)
 		register_syscore_ops(&pxa2xx_mfp_syscore_ops);
 		register_syscore_ops(&pxa2xx_clock_syscore_ops);
 
-		pxa_register_device(&pxa_device_gpio, &pxa27x_gpio_info);
+		pxa_register_device(&pxa27x_device_gpio, &pxa27x_gpio_info);
 		ret = platform_add_devices(devices, ARRAY_SIZE(devices));
 	}
 
diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index 656a1bb..572666a 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -92,7 +92,8 @@ static struct clk_lookup pxa3xx_clkregs[] = {
 	INIT_CLKREG(&clk_pxa3xx_mmc1, "pxa2xx-mci.0", NULL),
 	INIT_CLKREG(&clk_pxa3xx_mmc2, "pxa2xx-mci.1", NULL),
 	INIT_CLKREG(&clk_pxa3xx_smemc, "pxa2xx-pcmcia", NULL),
-	INIT_CLKREG(&clk_pxa3xx_gpio, "pxa-gpio", NULL),
+	INIT_CLKREG(&clk_pxa3xx_gpio, "pxa3xx-gpio", NULL),
+	INIT_CLKREG(&clk_pxa3xx_gpio, "pxa93x-gpio", NULL),
 	INIT_CLKREG(&clk_dummy, "sa1100-rtc", NULL),
 };
 
@@ -436,7 +437,6 @@ void __init pxa3xx_set_i2c_power_info(struct i2c_pxa_platform_data *info)
 }
 
 static struct platform_device *devices[] __initdata = {
-	&pxa_device_gpio,
 	&pxa27x_device_udc,
 	&pxa_device_pmu,
 	&pxa_device_i2s,
@@ -482,8 +482,14 @@ static int __init pxa3xx_init(void)
 		register_syscore_ops(&pxa3xx_mfp_syscore_ops);
 		register_syscore_ops(&pxa3xx_clock_syscore_ops);
 
-		if (!of_have_populated_dt())
-			ret = platform_add_devices(devices, ARRAY_SIZE(devices));
+		if (of_have_populated_dt())
+			return 0;
+
+		ret = platform_add_devices(devices, ARRAY_SIZE(devices));
+		if (ret)
+			return ret;
+		if (cpu_is_pxa300() || cpu_is_pxa310() || cpu_is_pxa320())
+			ret = platform_device_register(&pxa3xx_device_gpio);
 	}
 
 	return ret;
diff --git a/arch/arm/mach-pxa/pxa930.c b/arch/arm/mach-pxa/pxa930.c
index 8aeacf9..4693a78 100644
--- a/arch/arm/mach-pxa/pxa930.c
+++ b/arch/arm/mach-pxa/pxa930.c
@@ -18,6 +18,8 @@
 
 #include <mach/pxa930.h>
 
+#include "devices.h"
+
 static struct mfp_addr_map pxa930_mfp_addr_map[] __initdata = {
 
 	MFP_ADDR(GPIO0, 0x02e0),
@@ -192,9 +194,12 @@ static struct mfp_addr_map pxa935_mfp_addr_map[] __initdata = {
 
 static int __init pxa930_init(void)
 {
+	int ret = 0;
+
 	if (cpu_is_pxa93x()) {
 		mfp_init_base(io_p2v(MFPR_BASE));
 		mfp_init_addr(pxa930_mfp_addr_map);
+		ret = platform_device_register(&pxa93x_device_gpio);
 	}
 
 	if (cpu_is_pxa935())
diff --git a/drivers/clk/mmp/clk-mmp2.c b/drivers/clk/mmp/clk-mmp2.c
index ade4358..d1f1a19 100644
--- a/drivers/clk/mmp/clk-mmp2.c
+++ b/drivers/clk/mmp/clk-mmp2.c
@@ -221,7 +221,7 @@ void __init mmp2_clk_init(void)
 
 	clk = mmp_clk_register_apbc("gpio", "vctcxo",
 				apbc_base + APBC_GPIO, 10, 0, &clk_lock);
-	clk_register_clkdev(clk, NULL, "pxa-gpio");
+	clk_register_clkdev(clk, NULL, "mmp2-gpio");
 
 	clk = mmp_clk_register_apbc("kpc", "clk32",
 				apbc_base + APBC_KPC, 10, 0, &clk_lock);
diff --git a/drivers/clk/mmp/clk-pxa168.c b/drivers/clk/mmp/clk-pxa168.c
index e8d036c..28b3b51 100644
--- a/drivers/clk/mmp/clk-pxa168.c
+++ b/drivers/clk/mmp/clk-pxa168.c
@@ -172,7 +172,7 @@ void __init pxa168_clk_init(void)
 
 	clk = mmp_clk_register_apbc("gpio", "vctcxo",
 				apbc_base + APBC_GPIO, 10, 0, &clk_lock);
-	clk_register_clkdev(clk, NULL, "pxa-gpio");
+	clk_register_clkdev(clk, NULL, "mmp-gpio");
 
 	clk = mmp_clk_register_apbc("kpc", "clk32",
 				apbc_base + APBC_KPC, 10, 0, &clk_lock);
diff --git a/drivers/clk/mmp/clk-pxa910.c b/drivers/clk/mmp/clk-pxa910.c
index 7048c31..6ec0569 100644
--- a/drivers/clk/mmp/clk-pxa910.c
+++ b/drivers/clk/mmp/clk-pxa910.c
@@ -177,7 +177,7 @@ void __init pxa910_clk_init(void)
 
 	clk = mmp_clk_register_apbc("gpio", "vctcxo",
 				apbc_base + APBC_GPIO, 10, 0, &clk_lock);
-	clk_register_clkdev(clk, NULL, "pxa-gpio");
+	clk_register_clkdev(clk, NULL, "mmp-gpio");
 
 	clk = mmp_clk_register_apbc("kpc", "clk32",
 				apbc_base + APBC_KPC, 10, 0, &clk_lock);
diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index 9ee9f86..6d53882 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -85,20 +85,61 @@ struct pxa_gpio_chip {
 #endif
 };
 
-enum {
+enum pxa_gpio_type {
 	PXA25X_GPIO = 0,
 	PXA26X_GPIO,
 	PXA27X_GPIO,
 	PXA3XX_GPIO,
 	PXA93X_GPIO,
 	MMP_GPIO = 0x10,
+	MMP2_GPIO,
+};
+
+struct pxa_gpio_id {
+	enum pxa_gpio_type	type;
+	int			gpio_nums;
 };
 
 static DEFINE_SPINLOCK(gpio_lock);
 static struct pxa_gpio_chip *pxa_gpio_chips;
-static int gpio_type;
+static enum pxa_gpio_type gpio_type;
 static void __iomem *gpio_reg_base;
 
+static struct pxa_gpio_id pxa25x_id = {
+	.type		= PXA25X_GPIO,
+	.gpio_nums	= 85,
+};
+
+static struct pxa_gpio_id pxa26x_id = {
+	.type		= PXA26X_GPIO,
+	.gpio_nums	= 90,
+};
+
+static struct pxa_gpio_id pxa27x_id = {
+	.type		= PXA27X_GPIO,
+	.gpio_nums	= 121,
+};
+
+static struct pxa_gpio_id pxa3xx_id = {
+	.type		= PXA3XX_GPIO,
+	.gpio_nums	= 128,
+};
+
+static struct pxa_gpio_id pxa93x_id = {
+	.type		= PXA93X_GPIO,
+	.gpio_nums	= 192,
+};
+
+static struct pxa_gpio_id mmp_id = {
+	.type		= MMP_GPIO,
+	.gpio_nums	= 128,
+};
+
+static struct pxa_gpio_id mmp2_id = {
+	.type		= MMP2_GPIO,
+	.gpio_nums	= 192,
+};
+
 #define for_each_gpio_chip(i, c)			\
 	for (i = 0, c = &pxa_gpio_chips[0]; i <= pxa_last_gpio; i += 32, c++)
 
@@ -431,40 +472,27 @@ static struct irq_chip pxa_muxed_gpio_chip = {
 	.irq_set_wake	= pxa_gpio_set_wake,
 };
 
-static int pxa_gpio_nums(void)
+static int pxa_gpio_nums(struct platform_device *pdev)
 {
+	const struct platform_device_id *id = platform_get_device_id(pdev);
+	struct pxa_gpio_id *pxa_id = (struct pxa_gpio_id *)id->driver_data;
 	int count = 0;
 
-#ifdef CONFIG_ARCH_PXA
-	if (cpu_is_pxa25x()) {
-#ifdef CONFIG_CPU_PXA26x
-		count = 89;
-		gpio_type = PXA26X_GPIO;
-#elif defined(CONFIG_PXA25x)
-		count = 84;
-		gpio_type = PXA26X_GPIO;
-#endif /* CONFIG_CPU_PXA26x */
-	} else if (cpu_is_pxa27x()) {
-		count = 120;
-		gpio_type = PXA27X_GPIO;
-	} else if (cpu_is_pxa93x()) {
-		count = 191;
-		gpio_type = PXA93X_GPIO;
-	} else if (cpu_is_pxa3xx()) {
-		count = 127;
-		gpio_type = PXA3XX_GPIO;
-	}
-#endif /* CONFIG_ARCH_PXA */
-
-#ifdef CONFIG_ARCH_MMP
-	if (cpu_is_pxa168() || cpu_is_pxa910()) {
-		count = 127;
-		gpio_type = MMP_GPIO;
-	} else if (cpu_is_mmp2()) {
-		count = 191;
-		gpio_type = MMP_GPIO;
+	switch (pxa_id->type) {
+	case PXA25X_GPIO:
+	case PXA26X_GPIO:
+	case PXA27X_GPIO:
+	case PXA3XX_GPIO:
+	case PXA93X_GPIO:
+	case MMP_GPIO:
+	case MMP2_GPIO:
+		gpio_type = pxa_id->type;
+		count = pxa_id->gpio_nums - 1;
+		break;
+	default:
+		count = -EINVAL;
+		break;
 	}
-#endif /* CONFIG_ARCH_MMP */
 	return count;
 }
 
@@ -547,7 +575,7 @@ static int pxa_gpio_probe(struct platform_device *pdev)
 
 	ret = pxa_gpio_probe_dt(pdev);
 	if (ret < 0) {
-		pxa_last_gpio = pxa_gpio_nums();
+		pxa_last_gpio = pxa_gpio_nums(pdev);
 #ifdef CONFIG_ARCH_PXA
 		if (gpio_is_pxa_type(gpio_type))
 			irq_base = PXA_GPIO_TO_IRQ(0);
@@ -634,12 +662,24 @@ static int pxa_gpio_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct platform_device_id gpio_id_table[] = {
+	{ "pxa25x-gpio",	(unsigned long)&pxa25x_id },
+	{ "pxa26x-gpio",	(unsigned long)&pxa26x_id },
+	{ "pxa27x-gpio",	(unsigned long)&pxa27x_id },
+	{ "pxa3xx-gpio",	(unsigned long)&pxa3xx_id },
+	{ "pxa93x-gpio",	(unsigned long)&pxa93x_id },
+	{ "mmp-gpio",		(unsigned long)&mmp_id },
+	{ "mmp2-gpio",		(unsigned long)&mmp2_id },
+	{ },
+};
+
 static struct platform_driver pxa_gpio_driver = {
 	.probe		= pxa_gpio_probe,
 	.driver		= {
 		.name	= "pxa-gpio",
 		.of_match_table = of_match_ptr(pxa_gpio_dt_ids),
 	},
+	.id_table	= gpio_id_table,
 };
 module_platform_driver(pxa_gpio_driver);
 
-- 
1.7.10.4
