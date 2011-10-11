From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Tue, 11 Oct 2011 21:17:31 +0800
Subject: [PATCH v3 7/7] ARM: pxa: add clk support in gpio driver
In-Reply-To: <1318339051-19096-1-git-send-email-haojian.zhuang@marvell.com>
References: <1318339051-19096-1-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1318339051-19096-8-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support clk in gpio driver. There's no gpio clock in PXA25x and PXA27x.
So use dummy clk instead. And move the gpio edge initialization into
gpio driver for arch-mmp.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/mach-mmp/mmp2.c   |   18 ++----------------
 arch/arm/mach-mmp/pxa168.c |   18 ++----------------
 arch/arm/mach-mmp/pxa910.c |   18 ++----------------
 arch/arm/mach-pxa/pxa25x.c |    1 +
 arch/arm/mach-pxa/pxa27x.c |    1 +
 arch/arm/mach-pxa/pxa3xx.c |    2 ++
 arch/arm/mach-pxa/pxa95x.c |    2 ++
 drivers/gpio/gpio-pxa.c    |   16 ++++++++++++++++
 include/linux/gpio-pxa.h   |    1 +
 9 files changed, 29 insertions(+), 48 deletions(-)

diff --git a/arch/arm/mach-mmp/mmp2.c b/arch/arm/mach-mmp/mmp2.c
index 1291364..d350fdd 100644
--- a/arch/arm/mach-mmp/mmp2.c
+++ b/arch/arm/mach-mmp/mmp2.c
@@ -32,11 +32,8 @@
 #include "common.h"
 #include "clock.h"
 
-#define GPIO_REGS_VIRT	(APB_VIRT_BASE + 0x19000)
 #define MFPR_VIRT_BASE	(APB_VIRT_BASE + 0x1e000)
 
-#define APMASK(i)	(GPIO_REGS_VIRT + PXA_BANK_OFF(i) + 0x9c)
-
 static struct mfp_addr_map mmp2_addr_map[] __initdata = {
 
 	MFP_ADDR_X(GPIO0, GPIO58, 0x54),
@@ -96,22 +93,9 @@ void mmp2_clear_pmic_int(void)
 	__raw_writel(data, mfpr_pmic);
 }
 
-static void __init mmp2_init_gpio(void)
-{
-	int i;
-
-	/* enable GPIO clock */
-	__raw_writel(APBC_APBCLK | APBC_FNCLK, APBC_MMP2_GPIO);
-
-	/* unmask GPIO edge detection for all 6 banks -- APMASKx */
-	for (i = 0; i < 6; i++)
-		__raw_writel(0xffffffff, APMASK(i));
-}
-
 void __init mmp2_init_irq(void)
 {
 	mmp2_init_icu();
-	mmp2_init_gpio();
 }
 
 static void sdhc_clk_enable(struct clk *clk)
@@ -148,6 +132,7 @@ static APBC_CLK(twsi3, MMP2_TWSI3, 0, 26000000);
 static APBC_CLK(twsi4, MMP2_TWSI4, 0, 26000000);
 static APBC_CLK(twsi5, MMP2_TWSI5, 0, 26000000);
 static APBC_CLK(twsi6, MMP2_TWSI6, 0, 26000000);
+static APBC_CLK(gpio, MMP2_GPIO, 0, 26000000);
 
 static APMU_CLK(nand, NAND, 0xbf, 100000000);
 static APMU_CLK_OPS(sdh0, SDH0, 0x1b, 200000000, &sdhc_clk_ops);
@@ -167,6 +152,7 @@ static struct clk_lookup mmp2_clkregs[] = {
 	INIT_CLKREG(&clk_twsi5, "pxa2xx-i2c.4", NULL),
 	INIT_CLKREG(&clk_twsi6, "pxa2xx-i2c.5", NULL),
 	INIT_CLKREG(&clk_nand, "pxa3xx-nand", NULL),
+	INIT_CLKREG(&clk_gpio, "pxa-gpio", NULL),
 	INIT_CLKREG(&clk_sdh0, "sdhci-pxav3.0", "PXA-SDHCLK"),
 	INIT_CLKREG(&clk_sdh1, "sdhci-pxav3.1", "PXA-SDHCLK"),
 	INIT_CLKREG(&clk_sdh2, "sdhci-pxav3.2", "PXA-SDHCLK"),
diff --git a/arch/arm/mach-mmp/pxa168.c b/arch/arm/mach-mmp/pxa168.c
index 61395c6..0550884 100644
--- a/arch/arm/mach-mmp/pxa168.c
+++ b/arch/arm/mach-mmp/pxa168.c
@@ -29,7 +29,6 @@
 #include "common.h"
 #include "clock.h"
 
-#define GPIO_REGS_VIRT	(APB_VIRT_BASE + 0x19000)
 #define MFPR_VIRT_BASE	(APB_VIRT_BASE + 0x1e000)
 
 static struct mfp_addr_map pxa168_mfp_addr_map[] __initdata =
@@ -42,24 +41,9 @@ static struct mfp_addr_map pxa168_mfp_addr_map[] __initdata =
 	MFP_ADDR_END,
 };
 
-#define APMASK(i)	(GPIO_REGS_VIRT + PXA_BANK_OFF(i) + 0x09c)
-
-static void __init pxa168_init_gpio(void)
-{
-	int i;
-
-	/* enable GPIO clock */
-	__raw_writel(APBC_APBCLK | APBC_FNCLK, APBC_PXA168_GPIO);
-
-	/* unmask GPIO edge detection for all 4 banks - APMASKx */
-	for (i = 0; i < 4; i++)
-		__raw_writel(0xffffffff, APMASK(i));
-}
-
 void __init pxa168_init_irq(void)
 {
 	icu_init_irq();
-	pxa168_init_gpio();
 }
 
 /* APB peripheral clocks */
@@ -77,6 +61,7 @@ static APBC_CLK(ssp2, PXA168_SSP2, 4, 0);
 static APBC_CLK(ssp3, PXA168_SSP3, 4, 0);
 static APBC_CLK(ssp4, PXA168_SSP4, 4, 0);
 static APBC_CLK(ssp5, PXA168_SSP5, 4, 0);
+static APBC_CLK(gpio, PXA168_GPIO, 0, 13000000);
 static APBC_CLK(keypad, PXA168_KPC, 0, 32000);
 
 static APMU_CLK(nand, NAND, 0x19b, 156000000);
@@ -101,6 +86,7 @@ static struct clk_lookup pxa168_clkregs[] = {
 	INIT_CLKREG(&clk_ssp5, "pxa168-ssp.4", NULL),
 	INIT_CLKREG(&clk_nand, "pxa3xx-nand", NULL),
 	INIT_CLKREG(&clk_lcd, "pxa168-fb", NULL),
+	INIT_CLKREG(&clk_gpio, "pxa-gpio", NULL),
 	INIT_CLKREG(&clk_keypad, "pxa27x-keypad", NULL),
 	INIT_CLKREG(&clk_eth, "pxa168-eth", "MFUCLK"),
 };
diff --git a/arch/arm/mach-mmp/pxa910.c b/arch/arm/mach-mmp/pxa910.c
index 0b0e3db..c08607c 100644
--- a/arch/arm/mach-mmp/pxa910.c
+++ b/arch/arm/mach-mmp/pxa910.c
@@ -28,7 +28,6 @@
 #include "common.h"
 #include "clock.h"
 
-#define GPIO_REGS_VIRT	(APB_VIRT_BASE + 0x19000)
 #define MFPR_VIRT_BASE	(APB_VIRT_BASE + 0x1e000)
 
 static struct mfp_addr_map pxa910_mfp_addr_map[] __initdata =
@@ -79,24 +78,9 @@ static struct mfp_addr_map pxa910_mfp_addr_map[] __initdata =
 	MFP_ADDR_END,
 };
 
-#define APMASK(i)	(GPIO_REGS_VIRT + PXA_BANK_OFF(i) + 0x09c)
-
-static void __init pxa910_init_gpio(void)
-{
-	int i;
-
-	/* enable GPIO clock */
-	__raw_writel(APBC_APBCLK | APBC_FNCLK, APBC_PXA910_GPIO);
-
-	/* unmask GPIO edge detection for all 4 banks - APMASKx */
-	for (i = 0; i < 4; i++)
-		__raw_writel(0xffffffff, APMASK(i));
-}
-
 void __init pxa910_init_irq(void)
 {
 	icu_init_irq();
-	pxa910_init_gpio();
 }
 
 /* APB peripheral clocks */
@@ -108,6 +92,7 @@ static APBC_CLK(pwm1, PXA910_PWM1, 1, 13000000);
 static APBC_CLK(pwm2, PXA910_PWM2, 1, 13000000);
 static APBC_CLK(pwm3, PXA910_PWM3, 1, 13000000);
 static APBC_CLK(pwm4, PXA910_PWM4, 1, 13000000);
+static APBC_CLK(gpio, PXA910_GPIO, 0, 13000000);
 
 static APMU_CLK(nand, NAND, 0x19b, 156000000);
 static APMU_CLK(u2o, USB, 0x1b, 480000000);
@@ -123,6 +108,7 @@ static struct clk_lookup pxa910_clkregs[] = {
 	INIT_CLKREG(&clk_pwm3, "pxa910-pwm.2", NULL),
 	INIT_CLKREG(&clk_pwm4, "pxa910-pwm.3", NULL),
 	INIT_CLKREG(&clk_nand, "pxa3xx-nand", NULL),
+	INIT_CLKREG(&clk_gpio, "pxa-gpio", NULL),
 	INIT_CLKREG(&clk_u2o, "pxa-u2o", "U2OCLK"),
 };
 
diff --git a/arch/arm/mach-pxa/pxa25x.c b/arch/arm/mach-pxa/pxa25x.c
index b3641cc..605334c 100644
--- a/arch/arm/mach-pxa/pxa25x.c
+++ b/arch/arm/mach-pxa/pxa25x.c
@@ -208,6 +208,7 @@ static struct clk_lookup pxa25x_clkregs[] = {
 	INIT_CLKREG(&clk_pxa25x_gpio11, NULL, "GPIO11_CLK"),
 	INIT_CLKREG(&clk_pxa25x_gpio12, NULL, "GPIO12_CLK"),
 	INIT_CLKREG(&clk_pxa25x_mem, "pxa2xx-pcmcia", NULL),
+	INIT_CLKREG(&clk_dummy, "pxa-gpio", NULL),
 };
 
 static struct clk_lookup pxa25x_hwuart_clkreg =
diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index 06fb464..c62e77c 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -229,6 +229,7 @@ static struct clk_lookup pxa27x_clkregs[] = {
 	INIT_CLKREG(&clk_pxa27x_im, NULL, "IMCLK"),
 	INIT_CLKREG(&clk_pxa27x_memc, NULL, "MEMCLK"),
 	INIT_CLKREG(&clk_pxa27x_mem, "pxa2xx-pcmcia", NULL),
+	INIT_CLKREG(&clk_dummy, "pxa-gpio", NULL),
 };
 
 #ifdef CONFIG_PM
diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index 4446d56..d241354 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -55,6 +55,7 @@ static DEFINE_PXA3_CKEN(pxa3xx_pwm0, PWM0, 13000000, 0);
 static DEFINE_PXA3_CKEN(pxa3xx_pwm1, PWM1, 13000000, 0);
 static DEFINE_PXA3_CKEN(pxa3xx_mmc1, MMC1, 19500000, 0);
 static DEFINE_PXA3_CKEN(pxa3xx_mmc2, MMC2, 19500000, 0);
+static DEFINE_PXA3_CKEN(pxa3xx_gpio, GPIO, 13000000, 0);
 
 static DEFINE_CK(pxa3xx_lcd, LCD, &clk_pxa3xx_hsio_ops);
 static DEFINE_CK(pxa3xx_smemc, SMC, &clk_pxa3xx_smemc_ops);
@@ -87,6 +88,7 @@ static struct clk_lookup pxa3xx_clkregs[] = {
 	INIT_CLKREG(&clk_pxa3xx_mmc1, "pxa2xx-mci.0", NULL),
 	INIT_CLKREG(&clk_pxa3xx_mmc2, "pxa2xx-mci.1", NULL),
 	INIT_CLKREG(&clk_pxa3xx_smemc, "pxa2xx-pcmcia", NULL),
+	INIT_CLKREG(&clk_pxa3xx_gpio, "pxa-gpio", NULL),
 };
 
 #ifdef CONFIG_PM
diff --git a/arch/arm/mach-pxa/pxa95x.c b/arch/arm/mach-pxa/pxa95x.c
index dcff331..0bdea94 100644
--- a/arch/arm/mach-pxa/pxa95x.c
+++ b/arch/arm/mach-pxa/pxa95x.c
@@ -212,6 +212,7 @@ static DEFINE_PXA3_CKEN(pxa95x_ssp3, SSP3, 13000000, 0);
 static DEFINE_PXA3_CKEN(pxa95x_ssp4, SSP4, 13000000, 0);
 static DEFINE_PXA3_CKEN(pxa95x_pwm0, PWM0, 13000000, 0);
 static DEFINE_PXA3_CKEN(pxa95x_pwm1, PWM1, 13000000, 0);
+static DEFINE_PXA3_CKEN(pxa95x_gpio, GPIO, 13000000, 0);
 
 static struct clk_lookup pxa95x_clkregs[] = {
 	INIT_CLKREG(&clk_pxa95x_pout, NULL, "CLK_POUT"),
@@ -230,6 +231,7 @@ static struct clk_lookup pxa95x_clkregs[] = {
 	INIT_CLKREG(&clk_pxa95x_ssp4, "pxa27x-ssp.3", NULL),
 	INIT_CLKREG(&clk_pxa95x_pwm0, "pxa27x-pwm.0", NULL),
 	INIT_CLKREG(&clk_pxa95x_pwm1, "pxa27x-pwm.1", NULL),
+	INIT_CLKREG(&clk_pxa95x_gpio, "pxa-gpio", NULL),
 };
 
 void __init pxa95x_init_irq(void)
diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index 92b92e8..11fd69e 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -11,6 +11,8 @@
  *  it under the terms of the GNU General Public License version 2 as
  *  published by the Free Software Foundation.
  */
+#include <linux/clk.h>
+#include <linux/err.h>
 #include <linux/gpio.h>
 #include <linux/gpio-pxa.h>
 #include <linux/init.h>
@@ -28,6 +30,7 @@
 #define GFER_OFFSET	0x3C
 #define GEDR_OFFSET	0x48
 #define GAFR_OFFSET	0x54
+#define ED_MASK_OFFSET	0x9C	/* GPIO edge detection for AP side */
 
 struct pxa_gpio_chip {
 	struct gpio_chip chip;
@@ -411,6 +414,7 @@ static int __devinit pxa_gpio_probe(struct platform_device *pdev)
 {
 	struct pxa_gpio_chip *c;
 	struct resource *res;
+	struct clk *clk;
 	int gpio, irq;
 	int irq0 = 0, irq1 = 0, irq_mux, gpio_offset = 0;
 
@@ -437,10 +441,18 @@ static int __devinit pxa_gpio_probe(struct platform_device *pdev)
 	pxa_gpio_regs.gfer = res->start + GFER_OFFSET;
 	pxa_gpio_regs.gedr = res->start + GEDR_OFFSET;
 	pxa_gpio_regs.gafr = res->start + GAFR_OFFSET;
+	pxa_gpio_regs.ed_mask = res->start + ED_MASK_OFFSET;
 
 	if (irq0 > 0)
 		gpio_offset = 2;
 
+	clk = clk_get(&pdev->dev, NULL);
+	if (IS_ERR(clk)) {
+		printk(KERN_ERR "Error %ld to get gpio clock\n", PTR_ERR(clk));
+		return PTR_ERR(clk);
+	}
+	clk_enable(clk);
+
 	/* Initialize GPIO chips */
 	pxa_init_gpio_chip(pxa_last_gpio);
 
@@ -449,6 +461,10 @@ static int __devinit pxa_gpio_probe(struct platform_device *pdev)
 		__raw_writel(0, c->regbase + GFER_OFFSET);
 		__raw_writel(0, c->regbase + GRER_OFFSET);
 		__raw_writel(~0,c->regbase + GEDR_OFFSET);
+#ifdef CONFIG_ARCH_MMP
+		/* unmask GPIO edge detect for AP side */
+		__raw_writel(~0,c->regbase + ED_MASK_OFFSET);
+#endif
 	}
 
 #ifdef CONFIG_ARCH_PXA
diff --git a/include/linux/gpio-pxa.h b/include/linux/gpio-pxa.h
index 6cebf6c..dd47850 100644
--- a/include/linux/gpio-pxa.h
+++ b/include/linux/gpio-pxa.h
@@ -14,6 +14,7 @@ struct pxa_gpio_regs {
 	u32	gfer;
 	u32	gedr;
 	u32	gafr;
+	u32	ed_mask;
 };
 
 /*
-- 
1.7.2.5
