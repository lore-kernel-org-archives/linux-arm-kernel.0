From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Mon, 18 Feb 2013 13:12:36 +0800
Subject: [PATCH v3 10/12] gpio: pxa: add irq base in platform data
In-Reply-To: <1361164358-5845-1-git-send-email-haojian.zhuang@linaro.org>
References: <1361164358-5845-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1361164358-5845-11-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Macro PXA_GPIO_TO_IRQ() & MMP_GPIO_TO_IRQ() is used in machine driver
without DT. Although we're allocating irq descriptions dynamically,
it may break machine drivers without DT. Append pdata->irq_base.
If irq_base is valid, allocate irq descriptions from irq_base.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 arch/arm/mach-mmp/aspenite.c      |    1 +
 arch/arm/mach-mmp/avengers_lite.c |    1 +
 arch/arm/mach-mmp/brownstone.c    |    1 +
 arch/arm/mach-mmp/flint.c         |    1 +
 arch/arm/mach-mmp/gplugd.c        |    2 ++
 arch/arm/mach-mmp/tavorevb.c      |    1 +
 arch/arm/mach-mmp/teton_bga.c     |    1 +
 arch/arm/mach-mmp/ttc_dkb.c       |    1 +
 arch/arm/mach-pxa/pxa25x.c        |    1 +
 arch/arm/mach-pxa/pxa27x.c        |    1 +
 arch/arm/mach-pxa/pxa3xx.c        |    1 +
 drivers/gpio/gpio-pxa.c           |   15 ++++++++++-----
 include/linux/gpio-pxa.h          |    1 +
 13 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-mmp/aspenite.c b/arch/arm/mach-mmp/aspenite.c
index a3e42dc..a160efc 100644
--- a/arch/arm/mach-mmp/aspenite.c
+++ b/arch/arm/mach-mmp/aspenite.c
@@ -113,6 +113,7 @@ static unsigned long common_pin_config[] __initdata = {
 
 static struct pxa_gpio_platform_data pxa168_gpio_pdata = {
 	.nr_gpios	= 128,
+	.irq_base	= IRQ_GPIO_START,
 	.ed_mask	= true,
 };
 
diff --git a/arch/arm/mach-mmp/avengers_lite.c b/arch/arm/mach-mmp/avengers_lite.c
index 1ea6502..5c8c93d 100644
--- a/arch/arm/mach-mmp/avengers_lite.c
+++ b/arch/arm/mach-mmp/avengers_lite.c
@@ -35,6 +35,7 @@ static unsigned long avengers_lite_pin_config_V16F[] __initdata = {
 
 static struct pxa_gpio_platform_data pxa168_gpio_pdata = {
 	.nr_gpios	= 128,
+	.irq_base	= IRQ_GPIO_START,
 	.ed_mask	= true,
 };
 
diff --git a/arch/arm/mach-mmp/brownstone.c b/arch/arm/mach-mmp/brownstone.c
index a32156f..ba9f3a1 100644
--- a/arch/arm/mach-mmp/brownstone.c
+++ b/arch/arm/mach-mmp/brownstone.c
@@ -107,6 +107,7 @@ static unsigned long brownstone_pin_config[] __initdata = {
 
 static struct pxa_gpio_platform_data mmp2_gpio_pdata = {
 	.nr_gpios	= 192,
+	.irq_base	= IRQ_GPIO_START,
 	.ed_mask	= true,
 };
 
diff --git a/arch/arm/mach-mmp/flint.c b/arch/arm/mach-mmp/flint.c
index 3f301b5..544c03a 100644
--- a/arch/arm/mach-mmp/flint.c
+++ b/arch/arm/mach-mmp/flint.c
@@ -80,6 +80,7 @@ static unsigned long flint_pin_config[] __initdata = {
 
 static struct pxa_gpio_platform_data mmp2_gpio_pdata = {
 	.nr_gpios	= 192,
+	.irq_base	= IRQ_GPIO_START,
 	.ed_mask	= true,
 };
 
diff --git a/arch/arm/mach-mmp/gplugd.c b/arch/arm/mach-mmp/gplugd.c
index 019b178..e19eae8 100644
--- a/arch/arm/mach-mmp/gplugd.c
+++ b/arch/arm/mach-mmp/gplugd.c
@@ -11,6 +11,7 @@
 #include <linux/init.h>
 #include <linux/gpio.h>
 #include <linux/gpio-pxa.h>
+#include <linux/platform_device.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
@@ -130,6 +131,7 @@ static unsigned long gplugd_pin_config[] __initdata = {
 
 static struct pxa_gpio_platform_data pxa168_gpio_pdata = {
 	.nr_gpios	= 128,
+	.irq_base	= IRQ_GPIO_START,
 	.ed_mask	= true,
 };
 
diff --git a/arch/arm/mach-mmp/tavorevb.c b/arch/arm/mach-mmp/tavorevb.c
index 6e8cf80..37a181a 100644
--- a/arch/arm/mach-mmp/tavorevb.c
+++ b/arch/arm/mach-mmp/tavorevb.c
@@ -63,6 +63,7 @@ static unsigned long tavorevb_pin_config[] __initdata = {
 
 static struct pxa_gpio_platform_data ttc_dkb_gpio_pdata = {
 	.nr_gpios	= 128,
+	.irq_base	= IRQ_GPIO_START,
 	.ed_mask	= true,
 };
 
diff --git a/arch/arm/mach-mmp/teton_bga.c b/arch/arm/mach-mmp/teton_bga.c
index b5146bb..cace3b5 100644
--- a/arch/arm/mach-mmp/teton_bga.c
+++ b/arch/arm/mach-mmp/teton_bga.c
@@ -52,6 +52,7 @@ static unsigned long teton_bga_pin_config[] __initdata = {
 
 static struct pxa_gpio_platform_data pxa168_gpio_pdata = {
 	.nr_gpios	= 128,
+	.irq_base	= IRQ_GPIO_START,
 	.ed_mask	= true,
 };
 
diff --git a/arch/arm/mach-mmp/ttc_dkb.c b/arch/arm/mach-mmp/ttc_dkb.c
index 387e3f8..a824285 100644
--- a/arch/arm/mach-mmp/ttc_dkb.c
+++ b/arch/arm/mach-mmp/ttc_dkb.c
@@ -78,6 +78,7 @@ static unsigned long ttc_dkb_pin_config[] __initdata = {
 
 static struct pxa_gpio_platform_data ttc_dkb_gpio_pdata = {
 	.nr_gpios	= 128,
+	.irq_base	= IRQ_GPIO_START,
 	.ed_mask	= true,
 };
 
diff --git a/arch/arm/mach-pxa/pxa25x.c b/arch/arm/mach-pxa/pxa25x.c
index ff91660..2646654 100644
--- a/arch/arm/mach-pxa/pxa25x.c
+++ b/arch/arm/mach-pxa/pxa25x.c
@@ -346,6 +346,7 @@ static struct pxa_gpio_platform_data pxa25x_gpio_info __initdata = {
 #else
 	.nr_gpios = 85,
 #endif
+	.irq_base = PXA_GPIO_IRQ_BASE,
 	.gafr = true,
 	.gpio_set_wake = gpio_set_wake,
 };
diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index e478ec8..9f44c4b 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -433,6 +433,7 @@ void __init pxa27x_set_i2c_power_info(struct i2c_pxa_platform_data *info)
 static struct pxa_gpio_platform_data pxa27x_gpio_info __initdata = {
 	.gafr = true,
 	.nr_gpios = 121,
+	.irq_base = PXA_GPIO_IRQ_BASE,
 	.gpio_set_wake = gpio_set_wake,
 };
 
diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index f6bff16..7506879 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -438,6 +438,7 @@ void __init pxa3xx_set_i2c_power_info(struct i2c_pxa_platform_data *info)
 
 static struct pxa_gpio_platform_data pxa3xx_gpio_info __initdata = {
 	.nr_gpios = 128,
+	.irq_base = PXA_GPIO_IRQ_BASE,
 };
 
 static struct platform_device *devices[] __initdata = {
diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index c9cc636..35cdb23 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -451,9 +451,10 @@ static int pxa_gpio_probe_dt(struct platform_device *pdev)
 #endif
 
 static int pxa_init_gpio_chip(struct platform_device *pdev, int gpio_end,
-			      int (*set_wake)(unsigned int, unsigned int))
+			      struct pxa_gpio_platform_data *pdata)
 {
 	int i, gpio, nbanks = gpio_to_bank(gpio_end) + 1;
+	int irq_base;
 	struct pxa_gpio_chip *chips;
 	struct device_node *next = NULL, *np = NULL;
 
@@ -473,12 +474,17 @@ static int pxa_init_gpio_chip(struct platform_device *pdev, int gpio_end,
 
 		sprintf(chips[i].label, "gpio-%d", i);
 		chips[i].regbase = gpio_reg_base + BANK_OFF(i);
-		chips[i].set_wake = set_wake;
+		if (pdata->gpio_set_wake)
+			chips[i].set_wake = pdata->gpio_set_wake;
 
 		/* number of GPIOs on last bank may be less than 32 */
 		gc->ngpio = (gpio + 31 > gpio_end) ? (gpio_end - gpio + 1) : 32;
 
-		chips[i].irq_base = irq_alloc_descs(-1, 0, gc->ngpio, 0);
+		if (pdata->irq_base)
+			irq_base = pdata->irq_base + gpio;
+		else
+			irq_base = -1;
+		chips[i].irq_base = irq_alloc_descs(irq_base, 0, gc->ngpio, 0);
 		if (chips[i].irq_base < 0)
 			return -EINVAL;
 		if (!irq_domain_add_legacy(pdev->dev.of_node, gc->ngpio,
@@ -557,8 +563,7 @@ static int pxa_gpio_probe(struct platform_device *pdev)
 	/* Initialize GPIO chips */
 	pdata = dev_get_platdata(&pdev->dev);
 	pxa_last_gpio = pdata->nr_gpios - 1;
-	ret = pxa_init_gpio_chip(pdev, pxa_last_gpio,
-				 pdata ? pdata->gpio_set_wake : NULL);
+	ret = pxa_init_gpio_chip(pdev, pxa_last_gpio, pdata);
 	if (ret < 0)
 		return ret;
 
diff --git a/include/linux/gpio-pxa.h b/include/linux/gpio-pxa.h
index b357fdc..0d5e6db 100644
--- a/include/linux/gpio-pxa.h
+++ b/include/linux/gpio-pxa.h
@@ -20,6 +20,7 @@ struct pxa_gpio_platform_data {
 	bool inverted;	/* only valid for PXA26x */
 	bool gafr;	/* only valid for PXA25x/PXA26x/PXA27x */
 	unsigned nr_gpios;
+	int irq_base;
 	int (*gpio_set_wake)(unsigned int gpio, unsigned int on);
 };
 
-- 
1.7.10.4
