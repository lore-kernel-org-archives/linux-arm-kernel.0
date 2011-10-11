From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Tue, 11 Oct 2011 21:17:29 +0800
Subject: [PATCH v3 5/7] ARM: pxa: change gpio driver to platform driver
In-Reply-To: <1318339051-19096-1-git-send-email-haojian.zhuang@marvell.com>
References: <1318339051-19096-1-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1318339051-19096-6-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change gpio driver to platform driver and remove the potential
conflicted name.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/Kconfig                          |    2 +
 arch/arm/mach-mmp/aspenite.c              |    1 +
 arch/arm/mach-mmp/avengers_lite.c         |    1 +
 arch/arm/mach-mmp/brownstone.c            |    1 +
 arch/arm/mach-mmp/flint.c                 |    1 +
 arch/arm/mach-mmp/gplugd.c                |    1 +
 arch/arm/mach-mmp/include/mach/gpio-pxa.h |   17 -----
 arch/arm/mach-mmp/include/mach/mmp2.h     |    2 +
 arch/arm/mach-mmp/include/mach/pxa168.h   |    2 +
 arch/arm/mach-mmp/include/mach/pxa910.h   |    2 +
 arch/arm/mach-mmp/jasper.c                |    1 +
 arch/arm/mach-mmp/mmp2.c                  |   30 ++++++++-
 arch/arm/mach-mmp/pxa168.c                |   31 +++++++++-
 arch/arm/mach-mmp/pxa910.c                |   31 +++++++++-
 arch/arm/mach-mmp/tavorevb.c              |    1 +
 arch/arm/mach-mmp/teton_bga.c             |    1 +
 arch/arm/mach-mmp/ttc_dkb.c               |    1 +
 arch/arm/mach-pxa/corgi_pm.c              |   19 +++---
 arch/arm/mach-pxa/devices.c               |   37 +++++++++++
 arch/arm/mach-pxa/devices.h               |    1 +
 arch/arm/mach-pxa/include/mach/corgi.h    |    4 +-
 arch/arm/mach-pxa/include/mach/gpio-pxa.h |   82 ++-----------------------
 arch/arm/mach-pxa/include/mach/idp.h      |    2 +-
 arch/arm/mach-pxa/include/mach/tosa.h     |    4 +-
 arch/arm/mach-pxa/mfp-pxa2xx.c            |   36 ++++++------
 arch/arm/mach-pxa/pxa25x.c                |    3 +-
 arch/arm/mach-pxa/pxa27x.c                |    2 +-
 arch/arm/mach-pxa/pxa3xx.c                |    2 +-
 arch/arm/mach-pxa/pxa95x.c                |    2 +-
 arch/arm/mach-pxa/spitz_pm.c              |   29 ++++++----
 arch/arm/plat-pxa/include/plat/gpio-pxa.h |   51 +++++++++++++---
 drivers/gpio/Kconfig                      |    6 ++
 drivers/gpio/Makefile                     |    2 +-
 drivers/gpio/gpio-pxa.c                   |   93 +++++++++++++++++++++++------
 34 files changed, 324 insertions(+), 177 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index c704bd7..8b54401 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -556,6 +556,7 @@ config ARCH_MMP
 	select ARCH_REQUIRE_GPIOLIB
 	select CLKDEV_LOOKUP
 	select GENERIC_CLOCKEVENTS
+	select GPIO_PXA
 	select HAVE_SCHED_CLOCK
 	select TICK_ONESHOT
 	select PLAT_PXA
@@ -627,6 +628,7 @@ config ARCH_PXA
 	select CLKSRC_MMIO
 	select ARCH_REQUIRE_GPIOLIB
 	select GENERIC_CLOCKEVENTS
+	select GPIO_PXA
 	select HAVE_SCHED_CLOCK
 	select TICK_ONESHOT
 	select PLAT_PXA
diff --git a/arch/arm/mach-mmp/aspenite.c b/arch/arm/mach-mmp/aspenite.c
index fb7dfc1..edcbada 100644
--- a/arch/arm/mach-mmp/aspenite.c
+++ b/arch/arm/mach-mmp/aspenite.c
@@ -231,6 +231,7 @@ static void __init common_init(void)
 	pxa168_add_nand(&aspenite_nand_info);
 	pxa168_add_fb(&aspenite_lcd_info);
 	pxa168_add_keypad(&aspenite_keypad_info);
+	platform_device_register(&pxa168_device_gpio);
 
 	/* off-chip devices */
 	platform_device_register(&smc91x_device);
diff --git a/arch/arm/mach-mmp/avengers_lite.c b/arch/arm/mach-mmp/avengers_lite.c
index 39f0878..c5d53e0 100644
--- a/arch/arm/mach-mmp/avengers_lite.c
+++ b/arch/arm/mach-mmp/avengers_lite.c
@@ -38,6 +38,7 @@ static void __init avengers_lite_init(void)
 
 	/* on-chip devices */
 	pxa168_add_uart(2);
+	platform_device_register(&pxa168_device_gpio);
 }
 
 MACHINE_START(AVENGERS_LITE, "PXA168 Avengers lite Development Platform")
diff --git a/arch/arm/mach-mmp/brownstone.c b/arch/arm/mach-mmp/brownstone.c
index e411252..1e8c6ee 100644
--- a/arch/arm/mach-mmp/brownstone.c
+++ b/arch/arm/mach-mmp/brownstone.c
@@ -196,6 +196,7 @@ static void __init brownstone_init(void)
 	mmp2_add_twsi(1, NULL, ARRAY_AND_SIZE(brownstone_twsi1_info));
 	mmp2_add_sdhost(0, &mmp2_sdh_platdata_mmc0); /* SD/MMC */
 	mmp2_add_sdhost(2, &mmp2_sdh_platdata_mmc2); /* eMMC */
+	platform_device_register(&mmp2_device_gpio);
 
 	/* enable 5v regulator */
 	platform_device_register(&brownstone_v_5vp_device);
diff --git a/arch/arm/mach-mmp/flint.c b/arch/arm/mach-mmp/flint.c
index a64c172..c1f0aa8 100644
--- a/arch/arm/mach-mmp/flint.c
+++ b/arch/arm/mach-mmp/flint.c
@@ -110,6 +110,7 @@ static void __init flint_init(void)
 	/* on-chip devices */
 	mmp2_add_uart(1);
 	mmp2_add_uart(2);
+	platform_device_register(&mmp2_device_gpio);
 
 	/* off-chip devices */
 	platform_device_register(&smc91x_device);
diff --git a/arch/arm/mach-mmp/gplugd.c b/arch/arm/mach-mmp/gplugd.c
index 32776f3..5315fcc 100644
--- a/arch/arm/mach-mmp/gplugd.c
+++ b/arch/arm/mach-mmp/gplugd.c
@@ -184,6 +184,7 @@ static void __init gplugd_init(void)
 	pxa168_add_uart(3);
 	pxa168_add_ssp(0);
 	pxa168_add_twsi(0, NULL, ARRAY_AND_SIZE(gplugd_i2c_board_info));
+	platform_device_register(&pxa168_device_gpio);
 
 	pxa168_add_eth(&gplugd_eth_platform_data);
 }
diff --git a/arch/arm/mach-mmp/include/mach/gpio-pxa.h b/arch/arm/mach-mmp/include/mach/gpio-pxa.h
index 78199bd..f8448b5 100644
--- a/arch/arm/mach-mmp/include/mach/gpio-pxa.h
+++ b/arch/arm/mach-mmp/include/mach/gpio-pxa.h
@@ -7,23 +7,6 @@
 
 #define GPIO_REGS_VIRT	(APB_VIRT_BASE + 0x19000)
 
-#define BANK_OFF(n)	(((n) < 3) ? (n) << 2 : 0x100 + (((n) - 3) << 2))
-#define GPIO_REG(x)	(*((volatile u32 *)(GPIO_REGS_VIRT + (x))))
-
-#define gpio_to_bank(gpio)	((gpio) >> 5)
-
-/* NOTE: these macros are defined here to make optimization of
- * gpio_{get,set}_value() to work when 'gpio' is a constant.
- * Usage of these macros otherwise is no longer recommended,
- * use generic GPIO API whenever possible.
- */
-#define GPIO_bit(gpio)	(1 << ((gpio) & 0x1f))
-
-#define GPLR(x)		GPIO_REG(BANK_OFF(gpio_to_bank(x)) + 0x00)
-#define GPDR(x)		GPIO_REG(BANK_OFF(gpio_to_bank(x)) + 0x0c)
-#define GPSR(x)		GPIO_REG(BANK_OFF(gpio_to_bank(x)) + 0x18)
-#define GPCR(x)		GPIO_REG(BANK_OFF(gpio_to_bank(x)) + 0x24)
-
 #include <plat/gpio-pxa.h>
 
 #endif /* __ASM_MACH_GPIO_PXA_H */
diff --git a/arch/arm/mach-mmp/include/mach/mmp2.h b/arch/arm/mach-mmp/include/mach/mmp2.h
index de7b888..c4c9046 100644
--- a/arch/arm/mach-mmp/include/mach/mmp2.h
+++ b/arch/arm/mach-mmp/include/mach/mmp2.h
@@ -29,6 +29,8 @@ extern struct pxa_device_desc mmp2_device_sdh1;
 extern struct pxa_device_desc mmp2_device_sdh2;
 extern struct pxa_device_desc mmp2_device_sdh3;
 
+extern struct platform_device mmp2_device_gpio;
+
 static inline int mmp2_add_uart(int id)
 {
 	struct pxa_device_desc *d = NULL;
diff --git a/arch/arm/mach-mmp/include/mach/pxa168.h b/arch/arm/mach-mmp/include/mach/pxa168.h
index 7f00584..dfd6b37 100644
--- a/arch/arm/mach-mmp/include/mach/pxa168.h
+++ b/arch/arm/mach-mmp/include/mach/pxa168.h
@@ -35,6 +35,8 @@ extern struct pxa_device_desc pxa168_device_fb;
 extern struct pxa_device_desc pxa168_device_keypad;
 extern struct pxa_device_desc pxa168_device_eth;
 
+extern struct platform_device pxa168_device_gpio;
+
 static inline int pxa168_add_uart(int id)
 {
 	struct pxa_device_desc *d = NULL;
diff --git a/arch/arm/mach-mmp/include/mach/pxa910.h b/arch/arm/mach-mmp/include/mach/pxa910.h
index 91be755..4de13ab 100644
--- a/arch/arm/mach-mmp/include/mach/pxa910.h
+++ b/arch/arm/mach-mmp/include/mach/pxa910.h
@@ -21,6 +21,8 @@ extern struct pxa_device_desc pxa910_device_pwm3;
 extern struct pxa_device_desc pxa910_device_pwm4;
 extern struct pxa_device_desc pxa910_device_nand;
 
+extern struct platform_device pxa910_device_gpio;
+
 static inline int pxa910_add_uart(int id)
 {
 	struct pxa_device_desc *d = NULL;
diff --git a/arch/arm/mach-mmp/jasper.c b/arch/arm/mach-mmp/jasper.c
index 8bfac66..63b414b 100644
--- a/arch/arm/mach-mmp/jasper.c
+++ b/arch/arm/mach-mmp/jasper.c
@@ -165,6 +165,7 @@ static void __init jasper_init(void)
 	mmp2_add_uart(3);
 	mmp2_add_twsi(1, NULL, ARRAY_AND_SIZE(jasper_twsi1_info));
 	mmp2_add_sdhost(0, &mmp2_sdh_platdata_mmc0); /* SD/MMC */
+	platform_device_register(&mmp2_device_gpio);
 
 	regulator_has_full_constraints();
 }
diff --git a/arch/arm/mach-mmp/mmp2.c b/arch/arm/mach-mmp/mmp2.c
index 65d8689e..01e5c73 100644
--- a/arch/arm/mach-mmp/mmp2.c
+++ b/arch/arm/mach-mmp/mmp2.c
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/platform_device.h>
 
 #include <asm/hardware/cache-tauros2.h>
 
@@ -33,7 +34,7 @@
 
 #define MFPR_VIRT_BASE	(APB_VIRT_BASE + 0x1e000)
 
-#define APMASK(i)	(GPIO_REGS_VIRT + BANK_OFF(i) + 0x9c)
+#define APMASK(i)	(GPIO_REGS_VIRT + PXA_BANK_OFF(i) + 0x9c)
 
 static struct mfp_addr_map mmp2_addr_map[] __initdata = {
 
@@ -104,8 +105,6 @@ static void __init mmp2_init_gpio(void)
 	/* unmask GPIO edge detection for all 6 banks -- APMASKx */
 	for (i = 0; i < 6; i++)
 		__raw_writel(0xffffffff, APMASK(i));
-
-	pxa_init_gpio(IRQ_MMP2_GPIO, 0, 167, NULL);
 }
 
 void __init mmp2_init_irq(void)
@@ -226,3 +225,28 @@ MMP2_DEVICE(sdh1, "sdhci-pxav3", 1, MMC2, 0xd4280800, 0x120);
 MMP2_DEVICE(sdh2, "sdhci-pxav3", 2, MMC3, 0xd4281000, 0x120);
 MMP2_DEVICE(sdh3, "sdhci-pxav3", 3, MMC4, 0xd4281800, 0x120);
 
+struct resource mmp2_resources_gpio[] = {
+	{
+		.start  = 0xd4019000,
+		.end    = 0xd4019fff,
+		.name   = "gpio_phys_base",
+		.flags  = IORESOURCE_MEM,
+	}, {
+		.start  = APB_VIRT_BASE + 0x19000,
+		.end    = APB_VIRT_BASE + 0x19fff,
+		.name   = "gpio_virtual_base",
+		.flags  = IORESOURCE_MEM,
+	}, {
+		.start  = IRQ_MMP2_GPIO,
+		.end    = IRQ_MMP2_GPIO,
+		.name   = "gpio_mux",
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device mmp2_device_gpio = {
+	.name           = "pxa-gpio",
+	.id             = -1,
+	.num_resources  = ARRAY_SIZE(mmp2_resources_gpio),
+	.resource       = mmp2_resources_gpio,
+};
diff --git a/arch/arm/mach-mmp/pxa168.c b/arch/arm/mach-mmp/pxa168.c
index 50c1763..f0da013 100644
--- a/arch/arm/mach-mmp/pxa168.c
+++ b/arch/arm/mach-mmp/pxa168.c
@@ -13,6 +13,7 @@
 #include <linux/list.h>
 #include <linux/io.h>
 #include <linux/clk.h>
+#include <linux/platform_device.h>
 
 #include <asm/mach/time.h>
 #include <mach/addr-map.h>
@@ -40,7 +41,7 @@ static struct mfp_addr_map pxa168_mfp_addr_map[] __initdata =
 	MFP_ADDR_END,
 };
 
-#define APMASK(i)	(GPIO_REGS_VIRT + BANK_OFF(i) + 0x09c)
+#define APMASK(i)	(GPIO_REGS_VIRT + PXA_BANK_OFF(i) + 0x09c)
 
 static void __init pxa168_init_gpio(void)
 {
@@ -52,8 +53,6 @@ static void __init pxa168_init_gpio(void)
 	/* unmask GPIO edge detection for all 4 banks - APMASKx */
 	for (i = 0; i < 4; i++)
 		__raw_writel(0xffffffff, APMASK(i));
-
-	pxa_init_gpio(IRQ_PXA168_GPIOX, 0, 127, NULL);
 }
 
 void __init pxa168_init_irq(void)
@@ -168,3 +167,29 @@ PXA168_DEVICE(ssp5, "pxa168-ssp", 4, SSP5, 0xd4021000, 0x40, 60, 61);
 PXA168_DEVICE(fb, "pxa168-fb", -1, LCD, 0xd420b000, 0x1c8);
 PXA168_DEVICE(keypad, "pxa27x-keypad", -1, KEYPAD, 0xd4012000, 0x4c);
 PXA168_DEVICE(eth, "pxa168-eth", -1, MFU, 0xc0800000, 0x0fff);
+
+struct resource pxa168_resources_gpio[] = {
+	{
+		.start  = 0xd4019000,
+		.end    = 0xd4019fff,
+		.name   = "gpio_phys_base",
+		.flags  = IORESOURCE_MEM,
+	}, {
+		.start  = APB_VIRT_BASE + 0x19000,
+		.end    = APB_VIRT_BASE + 0x19fff,
+		.name   = "gpio_virtual_base",
+		.flags  = IORESOURCE_MEM,
+	}, {
+		.start  = IRQ_PXA168_GPIOX,
+		.end    = IRQ_PXA168_GPIOX,
+		.name   = "gpio_mux",
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device pxa168_device_gpio = {
+	.name           = "pxa-gpio",
+	.id             = -1,
+	.num_resources  = ARRAY_SIZE(pxa168_resources_gpio),
+	.resource       = pxa168_resources_gpio,
+};
diff --git a/arch/arm/mach-mmp/pxa910.c b/arch/arm/mach-mmp/pxa910.c
index 4ebbfbb..4654e62 100644
--- a/arch/arm/mach-mmp/pxa910.c
+++ b/arch/arm/mach-mmp/pxa910.c
@@ -12,6 +12,7 @@
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/io.h>
+#include <linux/platform_device.h>
 
 #include <asm/mach/time.h>
 #include <mach/addr-map.h>
@@ -77,7 +78,7 @@ static struct mfp_addr_map pxa910_mfp_addr_map[] __initdata =
 	MFP_ADDR_END,
 };
 
-#define APMASK(i)	(GPIO_REGS_VIRT + BANK_OFF(i) + 0x09c)
+#define APMASK(i)	(GPIO_REGS_VIRT + PXA_BANK_OFF(i) + 0x09c)
 
 static void __init pxa910_init_gpio(void)
 {
@@ -89,8 +90,6 @@ static void __init pxa910_init_gpio(void)
 	/* unmask GPIO edge detection for all 4 banks - APMASKx */
 	for (i = 0; i < 4; i++)
 		__raw_writel(0xffffffff, APMASK(i));
-
-	pxa_init_gpio(IRQ_PXA910_AP_GPIO, 0, 127, NULL);
 }
 
 void __init pxa910_init_irq(void)
@@ -179,3 +178,29 @@ PXA910_DEVICE(pwm2, "pxa910-pwm", 1, NONE, 0xd401a400, 0x10);
 PXA910_DEVICE(pwm3, "pxa910-pwm", 2, NONE, 0xd401a800, 0x10);
 PXA910_DEVICE(pwm4, "pxa910-pwm", 3, NONE, 0xd401ac00, 0x10);
 PXA910_DEVICE(nand, "pxa3xx-nand", -1, NAND, 0xd4283000, 0x80, 97, 99);
+
+struct resource pxa910_resources_gpio[] = {
+	{
+		.start  = 0xd4019000,
+		.end    = 0xd4019fff,
+		.name   = "gpio_phys_base",
+		.flags  = IORESOURCE_MEM,
+	}, {
+		.start  = APB_VIRT_BASE + 0x19000,
+		.end    = APB_VIRT_BASE + 0x19fff,
+		.name   = "gpio_virtual_base",
+		.flags  = IORESOURCE_MEM,
+	}, {
+		.start  = IRQ_PXA910_AP_GPIO,
+		.end    = IRQ_PXA910_AP_GPIO,
+		.name   = "gpio_mux",
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device pxa910_device_gpio = {
+	.name           = "pxa-gpio",
+	.id             = -1,
+	.num_resources  = ARRAY_SIZE(pxa910_resources_gpio),
+	.resource       = pxa910_resources_gpio,
+};
diff --git a/arch/arm/mach-mmp/tavorevb.c b/arch/arm/mach-mmp/tavorevb.c
index 331f5f3..bb2ddb7 100644
--- a/arch/arm/mach-mmp/tavorevb.c
+++ b/arch/arm/mach-mmp/tavorevb.c
@@ -94,6 +94,7 @@ static void __init tavorevb_init(void)
 
 	/* on-chip devices */
 	pxa910_add_uart(1);
+	platform_device_register(&pxa910_device_gpio);
 
 	/* off-chip devices */
 	platform_device_register(&smc91x_device);
diff --git a/arch/arm/mach-mmp/teton_bga.c b/arch/arm/mach-mmp/teton_bga.c
index 825a01c..703de85 100644
--- a/arch/arm/mach-mmp/teton_bga.c
+++ b/arch/arm/mach-mmp/teton_bga.c
@@ -78,6 +78,7 @@ static void __init teton_bga_init(void)
 	pxa168_add_uart(1);
 	pxa168_add_keypad(&teton_bga_keypad_info);
 	pxa168_add_twsi(0, NULL, ARRAY_AND_SIZE(teton_bga_i2c_info));
+	platform_device_register(&pxa168_device_gpio);
 }
 
 MACHINE_START(TETON_BGA, "PXA168-based Teton BGA Development Platform")
diff --git a/arch/arm/mach-mmp/ttc_dkb.c b/arch/arm/mach-mmp/ttc_dkb.c
index fac0d5d..a80ed26 100644
--- a/arch/arm/mach-mmp/ttc_dkb.c
+++ b/arch/arm/mach-mmp/ttc_dkb.c
@@ -123,6 +123,7 @@ static struct platform_device ttc_dkb_device_onenand = {
 };
 
 static struct platform_device *ttc_dkb_devices[] = {
+	&pxa910_device_gpio,
 	&ttc_dkb_device_onenand,
 };
 
diff --git a/arch/arm/mach-pxa/corgi_pm.c b/arch/arm/mach-pxa/corgi_pm.c
index 2903477..96183c6 100644
--- a/arch/arm/mach-pxa/corgi_pm.c
+++ b/arch/arm/mach-pxa/corgi_pm.c
@@ -90,9 +90,9 @@ static int corgi_should_wakeup(unsigned int resume_on_alarm)
 {
 	int is_resume = 0;
 
-	dev_dbg(sharpsl_pm.dev, "GPLR0 = %x,%x\n", GPLR0, PEDR);
+	dev_dbg(sharpsl_pm.dev, "PXA_GPLR0 = %x,%x\n", PXA_GPLR(0), PEDR);
 
-	if ((PEDR & GPIO_bit(CORGI_GPIO_AC_IN))) {
+	if ((PEDR & PXA_GPIO_bit(CORGI_GPIO_AC_IN))) {
 		if (sharpsl_pm.machinfo->read_devdata(SHARPSL_STATUS_ACIN)) {
 			/* charge on */
 			dev_dbg(sharpsl_pm.dev, "ac insert\n");
@@ -106,14 +106,14 @@ static int corgi_should_wakeup(unsigned int resume_on_alarm)
 		}
 	}
 
-	if ((PEDR & GPIO_bit(CORGI_GPIO_CHRG_FULL)))
+	if ((PEDR & PXA_GPIO_bit(CORGI_GPIO_CHRG_FULL)))
 		dev_dbg(sharpsl_pm.dev, "Charge full interrupt\n");
 
-	if (PEDR & GPIO_bit(CORGI_GPIO_KEY_INT))
-		is_resume |= GPIO_bit(CORGI_GPIO_KEY_INT);
+	if (PEDR & PXA_GPIO_bit(CORGI_GPIO_KEY_INT))
+		is_resume |= PXA_GPIO_bit(CORGI_GPIO_KEY_INT);
 
-	if (PEDR & GPIO_bit(CORGI_GPIO_WAKEUP))
-		is_resume |= GPIO_bit(CORGI_GPIO_WAKEUP);
+	if (PEDR & PXA_GPIO_bit(CORGI_GPIO_WAKEUP))
+		is_resume |= PXA_GPIO_bit(CORGI_GPIO_WAKEUP);
 
 	if (resume_on_alarm && (PEDR & PWER_RTC))
 		is_resume |= PWER_RTC;
@@ -124,14 +124,15 @@ static int corgi_should_wakeup(unsigned int resume_on_alarm)
 
 static unsigned long corgi_charger_wakeup(void)
 {
-	return ~GPLR0 & ( GPIO_bit(CORGI_GPIO_AC_IN) | GPIO_bit(CORGI_GPIO_KEY_INT) | GPIO_bit(CORGI_GPIO_WAKEUP) );
+	return ~PXA_GPLR(CORGI_GPIO_AC_IN) & ( PXA_GPIO_bit(CORGI_GPIO_AC_IN)
+		| PXA_GPIO_bit(CORGI_GPIO_KEY_INT) | PXA_GPIO_bit(CORGI_GPIO_WAKEUP) );
 }
 
 unsigned long corgipm_read_devdata(int type)
 {
 	switch(type) {
 	case SHARPSL_STATUS_ACIN:
-		return ((GPLR(CORGI_GPIO_AC_IN) & GPIO_bit(CORGI_GPIO_AC_IN)) != 0);
+		return ((PXA_GPLR(CORGI_GPIO_AC_IN) & PXA_GPIO_bit(CORGI_GPIO_AC_IN)) != 0);
 	case SHARPSL_STATUS_LOCK:
 		return gpio_get_value(sharpsl_pm.machinfo->gpio_batlock);
 	case SHARPSL_STATUS_CHRGFULL:
diff --git a/arch/arm/mach-pxa/devices.c b/arch/arm/mach-pxa/devices.c
index 2e04254..2b552fa 100644
--- a/arch/arm/mach-pxa/devices.c
+++ b/arch/arm/mach-pxa/devices.c
@@ -1051,6 +1051,43 @@ struct platform_device pxa3xx_device_ssp4 = {
 };
 #endif /* CONFIG_PXA3xx || CONFIG_PXA95x */
 
+struct resource pxa_resources_gpio[] = {
+	{
+		.start  = 0x40e00000,
+		.end    = 0x40e0ffff,
+		.name   = "gpio_phys_base",
+		.flags  = IORESOURCE_MEM,
+	}, {
+		.start  = io_p2v(0x40e00000),
+		.end    = io_p2v(0x40e0ffff),
+		.name   = "gpio_virtual_base",
+		.flags  = IORESOURCE_MEM,
+	}, {
+		.start  = IRQ_GPIO0,
+		.end    = IRQ_GPIO0,
+		.name   = "gpio0",
+		.flags  = IORESOURCE_IRQ,
+	}, {
+		.start  = IRQ_GPIO1,
+		.end    = IRQ_GPIO1,
+		.name   = "gpio1",
+		.flags  = IORESOURCE_IRQ,
+	}, {
+		.start  = IRQ_GPIO_2_x,
+			.end    = IRQ_GPIO_2_x,
+			.name   = "gpio_mux",
+			.flags  = IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device pxa_device_gpio = {
+	.name           = "pxa-gpio",
+	.id             = -1,
+	.num_resources  = ARRAY_SIZE(pxa_resources_gpio),
+	.resource       = pxa_resources_gpio,
+};
+
+
 /* pxa2xx-spi platform-device ID equals respective SSP platform-device ID + 1.
  * See comment in arch/arm/mach-pxa/ssp.c::ssp_probe() */
 void __init pxa2xx_set_spi_info(unsigned id, struct pxa2xx_spi_master *info)
diff --git a/arch/arm/mach-pxa/devices.h b/arch/arm/mach-pxa/devices.h
index 2fd5a8b..54d121d 100644
--- a/arch/arm/mach-pxa/devices.h
+++ b/arch/arm/mach-pxa/devices.h
@@ -1,3 +1,4 @@
+extern struct platform_device pxa_device_gpio;
 extern struct platform_device pxa_device_pmu;
 extern struct platform_device pxa_device_mci;
 extern struct platform_device pxa3xx_device_mci2;
diff --git a/arch/arm/mach-pxa/include/mach/corgi.h b/arch/arm/mach-pxa/include/mach/corgi.h
index f3c3493..14477f5 100644
--- a/arch/arm/mach-pxa/include/mach/corgi.h
+++ b/arch/arm/mach-pxa/include/mach/corgi.h
@@ -54,8 +54,8 @@
 #define CORGI_GPIO_HIGH_SENSE_RSHIFT	(26)
 #define CORGI_GPIO_LOW_SENSE_BIT	(0x00000003)
 #define CORGI_GPIO_LOW_SENSE_LSHIFT	(6)
-#define CORGI_GPIO_STROBE_BIT(a)	GPIO_bit(66+(a))
-#define CORGI_GPIO_SENSE_BIT(a)		GPIO_bit(58+(a))
+#define CORGI_GPIO_STROBE_BIT(a)	PXA_GPIO_bit(66+(a))
+#define CORGI_GPIO_SENSE_BIT(a)		PXA_GPIO_bit(58+(a))
 #define CORGI_GAFR_ALL_STROBE_BIT	(0x0ffffff0)
 #define CORGI_GAFR_HIGH_SENSE_BIT	(0xfff00000)
 #define CORGI_GAFR_LOW_SENSE_BIT	(0x0000000f)
diff --git a/arch/arm/mach-pxa/include/mach/gpio-pxa.h b/arch/arm/mach-pxa/include/mach/gpio-pxa.h
index 134b3bc..29dfcde 100644
--- a/arch/arm/mach-pxa/include/mach/gpio-pxa.h
+++ b/arch/arm/mach-pxa/include/mach/gpio-pxa.h
@@ -22,81 +22,12 @@
 #include <mach/irqs.h>
 #include <mach/hardware.h>
 
-#define GPIO_REGS_VIRT	io_p2v(0x40E00000)
-
-#define BANK_OFF(n)	(((n) < 3) ? (n) << 2 : 0x100 + (((n) - 3) << 2))
-#define GPIO_REG(x)	(*(volatile u32 *)(GPIO_REGS_VIRT + (x)))
-
-/* GPIO Pin Level Registers */
-#define GPLR0		GPIO_REG(BANK_OFF(0) + 0x00)
-#define GPLR1		GPIO_REG(BANK_OFF(1) + 0x00)
-#define GPLR2		GPIO_REG(BANK_OFF(2) + 0x00)
-#define GPLR3		GPIO_REG(BANK_OFF(3) + 0x00)
-
-/* GPIO Pin Direction Registers */
-#define GPDR0		GPIO_REG(BANK_OFF(0) + 0x0c)
-#define GPDR1		GPIO_REG(BANK_OFF(1) + 0x0c)
-#define GPDR2		GPIO_REG(BANK_OFF(2) + 0x0c)
-#define GPDR3		GPIO_REG(BANK_OFF(3) + 0x0c)
-
-/* GPIO Pin Output Set Registers */
-#define GPSR0		GPIO_REG(BANK_OFF(0) + 0x18)
-#define GPSR1		GPIO_REG(BANK_OFF(1) + 0x18)
-#define GPSR2		GPIO_REG(BANK_OFF(2) + 0x18)
-#define GPSR3		GPIO_REG(BANK_OFF(3) + 0x18)
-
-/* GPIO Pin Output Clear Registers */
-#define GPCR0		GPIO_REG(BANK_OFF(0) + 0x24)
-#define GPCR1		GPIO_REG(BANK_OFF(1) + 0x24)
-#define GPCR2		GPIO_REG(BANK_OFF(2) + 0x24)
-#define GPCR3		GPIO_REG(BANK_OFF(3) + 0x24)
-
-/* GPIO Rising Edge Detect Registers */
-#define GRER0		GPIO_REG(BANK_OFF(0) + 0x30)
-#define GRER1		GPIO_REG(BANK_OFF(1) + 0x30)
-#define GRER2		GPIO_REG(BANK_OFF(2) + 0x30)
-#define GRER3		GPIO_REG(BANK_OFF(3) + 0x30)
-
-/* GPIO Falling Edge Detect Registers */
-#define GFER0		GPIO_REG(BANK_OFF(0) + 0x3c)
-#define GFER1		GPIO_REG(BANK_OFF(1) + 0x3c)
-#define GFER2		GPIO_REG(BANK_OFF(2) + 0x3c)
-#define GFER3		GPIO_REG(BANK_OFF(3) + 0x3c)
-
-/* GPIO Edge Detect Status Registers */
-#define GEDR0		GPIO_REG(BANK_OFF(0) + 0x48)
-#define GEDR1		GPIO_REG(BANK_OFF(1) + 0x48)
-#define GEDR2		GPIO_REG(BANK_OFF(2) + 0x48)
-#define GEDR3		GPIO_REG(BANK_OFF(3) + 0x48)
-
-/* GPIO Alternate Function Select Registers */
-#define GAFR0_L		GPIO_REG(0x0054)
-#define GAFR0_U		GPIO_REG(0x0058)
-#define GAFR1_L		GPIO_REG(0x005C)
-#define GAFR1_U		GPIO_REG(0x0060)
-#define GAFR2_L		GPIO_REG(0x0064)
-#define GAFR2_U		GPIO_REG(0x0068)
-#define GAFR3_L		GPIO_REG(0x006C)
-#define GAFR3_U		GPIO_REG(0x0070)
-
-/* More handy macros.  The argument is a literal GPIO number. */
-
-#define GPIO_bit(x)	(1 << ((x) & 0x1f))
-
-#define GPLR(x)		GPIO_REG(BANK_OFF((x) >> 5) + 0x00)
-#define GPDR(x)		GPIO_REG(BANK_OFF((x) >> 5) + 0x0c)
-#define GPSR(x)		GPIO_REG(BANK_OFF((x) >> 5) + 0x18)
-#define GPCR(x)		GPIO_REG(BANK_OFF((x) >> 5) + 0x24)
-#define GRER(x)		GPIO_REG(BANK_OFF((x) >> 5) + 0x30)
-#define GFER(x)		GPIO_REG(BANK_OFF((x) >> 5) + 0x3c)
-#define GEDR(x)		GPIO_REG(BANK_OFF((x) >> 5) + 0x48)
-#define GAFR(x)		GPIO_REG(0x54 + (((x) & 0x70) >> 2))
-
+#include <plat/gpio-pxa.h>
 
-#define gpio_to_bank(gpio)	((gpio) >> 5)
+#define GPIO_REGS_VIRT	io_p2v(0x40E00000)
 
 #ifdef CONFIG_CPU_PXA26x
-/* GPIO86/87/88/89 on PXA26x have their direction bits in GPDR2 inverted,
+/* GPIO86/87/88/89 on PXA26x have their direction bits in PXA_GPDR(2 inverted,
  * as well as their Alternate Function value being '1' for GPIO in GAFRx.
  */
 static inline int __gpio_is_inverted(unsigned gpio)
@@ -116,16 +47,15 @@ static inline int __gpio_is_inverted(unsigned gpio) { return 0; }
 static inline int __gpio_is_occupied(unsigned gpio)
 {
 	if (cpu_is_pxa27x() || cpu_is_pxa25x()) {
-		int af = (GAFR(gpio) >> ((gpio & 0xf) * 2)) & 0x3;
-		int dir = GPDR(gpio) & GPIO_bit(gpio);
+		int af = (PXA_GAFR(gpio) >> ((gpio & 0xf) * 2)) & 0x3;
+		int dir = PXA_GPDR(gpio) & PXA_GPIO_bit(gpio);
 
 		if (__gpio_is_inverted(gpio))
 			return af != 1 || dir == 0;
 		else
 			return af != 0 || dir != 0;
 	} else
-		return GPDR(gpio) & GPIO_bit(gpio);
+		return PXA_GPDR(gpio) & PXA_GPIO_bit(gpio);
 }
 
-#include <plat/gpio-pxa.h>
 #endif /* __MACH_PXA_GPIO_PXA_H */
diff --git a/arch/arm/mach-pxa/include/mach/idp.h b/arch/arm/mach-pxa/include/mach/idp.h
index a7f912f..d784e4c 100644
--- a/arch/arm/mach-pxa/include/mach/idp.h
+++ b/arch/arm/mach-pxa/include/mach/idp.h
@@ -131,7 +131,7 @@
 #define PCC_VS2		(1 << 1)
 #define PCC_VS1		(1 << 0)
 
-#define PCC_DETECT(x)	(GPLR(7 + (x)) & GPIO_bit(7 + (x)))
+#define PCC_DETECT(x)	(PXA_GPLR(7 + (x)) & PXA_GPIO_bit(7 + (x)))
 
 /* A listing of interrupts used by external hardware devices */
 
diff --git a/arch/arm/mach-pxa/include/mach/tosa.h b/arch/arm/mach-pxa/include/mach/tosa.h
index 2bb0e86..990b152 100644
--- a/arch/arm/mach-pxa/include/mach/tosa.h
+++ b/arch/arm/mach-pxa/include/mach/tosa.h
@@ -130,8 +130,8 @@
 #define TOSA_GPIO_LOW_STROBE_BIT	(0x0000001f)
 #define TOSA_GPIO_ALL_SENSE_BIT		(0x00000fe0)
 #define TOSA_GPIO_ALL_SENSE_RSHIFT	(5)
-#define TOSA_GPIO_STROBE_BIT(a)		GPIO_bit(58+(a))
-#define TOSA_GPIO_SENSE_BIT(a)		GPIO_bit(69+(a))
+#define TOSA_GPIO_STROBE_BIT(a)		PXA_GPIO_bit(58+(a))
+#define TOSA_GPIO_SENSE_BIT(a)		PXA_GPIO_bit(69+(a))
 #define TOSA_GAFR_HIGH_STROBE_BIT	(0xfff00000)
 #define TOSA_GAFR_LOW_STROBE_BIT	(0x000003ff)
 #define TOSA_GAFR_ALL_SENSE_BIT		(0x00fffc00)
diff --git a/arch/arm/mach-pxa/mfp-pxa2xx.c b/arch/arm/mach-pxa/mfp-pxa2xx.c
index 43a5f68..af302b4 100644
--- a/arch/arm/mach-pxa/mfp-pxa2xx.c
+++ b/arch/arm/mach-pxa/mfp-pxa2xx.c
@@ -47,8 +47,8 @@ static unsigned long gpdr_lpm[4];
 
 static int __mfp_config_gpio(unsigned gpio, unsigned long c)
 {
-	unsigned long gafr, mask = GPIO_bit(gpio);
-	int bank = gpio_to_bank(gpio);
+	unsigned long gafr, mask = PXA_GPIO_bit(gpio);
+	int bank = pxa_gpio_to_bank(gpio);
 	int uorl = !!(gpio & 0x10); /* GAFRx_U or GAFRx_L ? */
 	int shft = (gpio & 0xf) << 1;
 	int fn = MFP_AF(c);
@@ -67,9 +67,9 @@ static int __mfp_config_gpio(unsigned gpio, unsigned long c)
 		GAFR_U(bank) = gafr;
 
 	if (is_out ^ gpio_desc[gpio].dir_inverted)
-		GPDR(gpio) |= mask;
+		PXA_GPDR(gpio) |= mask;
 	else
-		GPDR(gpio) &= ~mask;
+		PXA_GPDR(gpio) &= ~mask;
 
 	/* alternate function and direction@low power mode */
 	switch (c & MFP_LPM_STATE_MASK) {
@@ -227,7 +227,7 @@ static void __init pxa25x_mfp_init(void)
 
 	for (i = 0; i <= 15; i++) {
 		gpio_desc[i].can_wakeup = 1;
-		gpio_desc[i].mask = GPIO_bit(i);
+		gpio_desc[i].mask = PXA_GPIO_bit(i);
 	}
 
 	/* PXA26x has additional 4 GPIOs (86/87/88/89) which has the
@@ -312,11 +312,11 @@ static void __init pxa27x_mfp_init(void)
 	/* Overwrite GPIO13 as a PWER wakeup source */
 	for (i = 0; i <= 15; i++) {
 		/* skip GPIO2, 5, 6, 7, 8 */
-		if (GPIO_bit(i) & 0x1e4)
+		if (PXA_GPIO_bit(i) & 0x1e4)
 			continue;
 
 		gpio_desc[i].can_wakeup = 1;
-		gpio_desc[i].mask = GPIO_bit(i);
+		gpio_desc[i].mask = PXA_GPIO_bit(i);
 	}
 
 	gpio_desc[35].can_wakeup = 1;
@@ -345,22 +345,22 @@ static int pxa2xx_mfp_suspend(void)
 	/* set corresponding PGSR bit of those marked MFP_LPM_KEEP_OUTPUT */
 	for (i = 0; i < pxa_last_gpio; i++) {
 		if ((gpio_desc[i].config & MFP_LPM_KEEP_OUTPUT) &&
-		    (GPDR(i) & GPIO_bit(i))) {
-			if (GPLR(i) & GPIO_bit(i))
-				PGSR(gpio_to_bank(i)) |= GPIO_bit(i);
+		    (PXA_GPDR(i) & PXA_GPIO_bit(i))) {
+			if (PXA_GPLR(i) & PXA_GPIO_bit(i))
+				PGSR(pxa_gpio_to_bank(i)) |= PXA_GPIO_bit(i);
 			else
-				PGSR(gpio_to_bank(i)) &= ~GPIO_bit(i);
+				PGSR(pxa_gpio_to_bank(i)) &= ~PXA_GPIO_bit(i);
 		}
 	}
 
-	for (i = 0; i <= gpio_to_bank(pxa_last_gpio); i++) {
+	for (i = 0; i <= pxa_gpio_to_bank(pxa_last_gpio); i++) {
 
 		saved_gafr[0][i] = GAFR_L(i);
 		saved_gafr[1][i] = GAFR_U(i);
-		saved_gpdr[i] = GPDR(i * 32);
+		saved_gpdr[i] = PXA_GPDR(i * 32);
 		saved_pgsr[i] = PGSR(i);
 
-		GPDR(i * 32) = gpdr_lpm[i];
+		PXA_GPDR(i * 32) = gpdr_lpm[i];
 	}
 	return 0;
 }
@@ -369,10 +369,10 @@ static void pxa2xx_mfp_resume(void)
 {
 	int i;
 
-	for (i = 0; i <= gpio_to_bank(pxa_last_gpio); i++) {
+	for (i = 0; i <= pxa_gpio_to_bank(pxa_last_gpio); i++) {
 		GAFR_L(i) = saved_gafr[0][i];
 		GAFR_U(i) = saved_gafr[1][i];
-		GPDR(i * 32) = saved_gpdr[i];
+		PXA_GPDR(i * 32) = saved_gpdr[i];
 		PGSR(i) = saved_pgsr[i];
 	}
 	PSSR = PSSR_RDH | PSSR_PH;
@@ -404,8 +404,8 @@ static int __init pxa2xx_mfp_init(void)
 	PSSR = PSSR_RDH;
 
 	/* initialize gafr_run[], pgsr_lpm[] from existing values */
-	for (i = 0; i <= gpio_to_bank(pxa_last_gpio); i++)
-		gpdr_lpm[i] = GPDR(i * 32);
+	for (i = 0; i <= pxa_gpio_to_bank(pxa_last_gpio); i++)
+		gpdr_lpm[i] = PXA_GPDR(i * 32);
 
 	return 0;
 }
diff --git a/arch/arm/mach-pxa/pxa25x.c b/arch/arm/mach-pxa/pxa25x.c
index d4fca6a..10a4fb3 100644
--- a/arch/arm/mach-pxa/pxa25x.c
+++ b/arch/arm/mach-pxa/pxa25x.c
@@ -312,14 +312,12 @@ set_pwer:
 void __init pxa25x_init_irq(void)
 {
 	pxa_init_irq(32, pxa25x_set_wake);
-	pxa_init_gpio(IRQ_GPIO_2_x, 2, 84, pxa25x_set_wake);
 }
 
 #ifdef CONFIG_CPU_PXA26x
 void __init pxa26x_init_irq(void)
 {
 	pxa_init_irq(32, pxa25x_set_wake);
-	pxa_init_gpio(IRQ_GPIO_2_x, 2, 89, pxa25x_set_wake);
 }
 #endif
 
@@ -340,6 +338,7 @@ void __init pxa25x_map_io(void)
 }
 
 static struct platform_device *pxa25x_devices[] __initdata = {
+	&pxa_device_gpio,
 	&pxa25x_device_udc,
 	&pxa_device_pmu,
 	&pxa_device_i2s,
diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index 08eb452..a200bae 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -386,7 +386,6 @@ static int pxa27x_set_wake(struct irq_data *d, unsigned int on)
 void __init pxa27x_init_irq(void)
 {
 	pxa_init_irq(34, pxa27x_set_wake);
-	pxa_init_gpio(IRQ_GPIO_2_x, 2, 120, pxa27x_set_wake);
 }
 
 static struct map_desc pxa27x_io_desc[] __initdata = {
@@ -422,6 +421,7 @@ void __init pxa27x_set_i2c_power_info(struct i2c_pxa_platform_data *info)
 }
 
 static struct platform_device *devices[] __initdata = {
+	&pxa_device_gpio,
 	&pxa27x_device_udc,
 	&pxa_device_pmu,
 	&pxa_device_i2s,
diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index f940a13..e5c3688 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -388,7 +388,6 @@ void __init pxa3xx_init_irq(void)
 
 	pxa_init_irq(56, pxa3xx_set_wake);
 	pxa_init_ext_wakeup_irq(pxa3xx_set_wake);
-	pxa_init_gpio(IRQ_GPIO_2_x, 2, 127, NULL);
 }
 
 static struct map_desc pxa3xx_io_desc[] __initdata = {
@@ -417,6 +416,7 @@ void __init pxa3xx_set_i2c_power_info(struct i2c_pxa_platform_data *info)
 }
 
 static struct platform_device *devices[] __initdata = {
+	&pxa_device_gpio,
 	&pxa27x_device_udc,
 	&pxa_device_pmu,
 	&pxa_device_i2s,
diff --git a/arch/arm/mach-pxa/pxa95x.c b/arch/arm/mach-pxa/pxa95x.c
index 51371b3..5af6a44 100644
--- a/arch/arm/mach-pxa/pxa95x.c
+++ b/arch/arm/mach-pxa/pxa95x.c
@@ -235,7 +235,6 @@ static struct clk_lookup pxa95x_clkregs[] = {
 void __init pxa95x_init_irq(void)
 {
 	pxa_init_irq(96, NULL);
-	pxa_init_gpio(IRQ_GPIO_2_x, 2, 127, NULL);
 }
 
 /*
@@ -248,6 +247,7 @@ void __init pxa95x_set_i2c_power_info(struct i2c_pxa_platform_data *info)
 }
 
 static struct platform_device *devices[] __initdata = {
+	&pxa_device_gpio,
 	&sa1100_device_rtc,
 	&pxa_device_rtc,
 	&pxa27x_device_ssp1,
diff --git a/arch/arm/mach-pxa/spitz_pm.c b/arch/arm/mach-pxa/spitz_pm.c
index 094279a..a8d9aee 100644
--- a/arch/arm/mach-pxa/spitz_pm.c
+++ b/arch/arm/mach-pxa/spitz_pm.c
@@ -108,16 +108,20 @@ static void spitz_presuspend(void)
 	PGSR1 &= ~SPITZ_GPIO_G1_STROBE_BIT;
 	PGSR2 &= ~SPITZ_GPIO_G2_STROBE_BIT;
 	PGSR3 &= ~SPITZ_GPIO_G3_STROBE_BIT;
-	PGSR2 |= GPIO_bit(SPITZ_GPIO_KEY_STROBE0);
+	PGSR2 |= PXA_GPIO_bit(SPITZ_GPIO_KEY_STROBE0);
 
 	pxa2xx_mfp_config(&gpio18_config[0], 1);
 	gpio_request_one(18, GPIOF_OUT_INIT_HIGH, "Unknown");
 	gpio_free(18);
 
-	PRER = GPIO_bit(SPITZ_GPIO_KEY_INT);
-	PFER = GPIO_bit(SPITZ_GPIO_KEY_INT) | GPIO_bit(SPITZ_GPIO_RESET);
-	PWER = GPIO_bit(SPITZ_GPIO_KEY_INT) | GPIO_bit(SPITZ_GPIO_RESET) | PWER_RTC;
-	PKWR = GPIO_bit(SPITZ_GPIO_SYNC) | GPIO_bit(SPITZ_GPIO_KEY_INT) | GPIO_bit(SPITZ_GPIO_RESET);
+	PRER = PXA_GPIO_bit(SPITZ_GPIO_KEY_INT);
+	PFER = PXA_GPIO_bit(SPITZ_GPIO_KEY_INT)
+		| PXA_GPIO_bit(SPITZ_GPIO_RESET);
+	PWER = PXA_GPIO_bit(SPITZ_GPIO_KEY_INT)
+		| PXA_GPIO_bit(SPITZ_GPIO_RESET) | PWER_RTC;
+	PKWR = PXA_GPIO_bit(SPITZ_GPIO_SYNC)
+		| PXA_GPIO_bit(SPITZ_GPIO_KEY_INT)
+		| PXA_GPIO_bit(SPITZ_GPIO_RESET);
 	PKSR = 0xffffffff; /* clear */
 
 	/* nRESET_OUT Disable */
@@ -154,11 +158,11 @@ static int spitz_should_wakeup(unsigned int resume_on_alarm)
 		return 0;
 	}
 
-	if (PEDR & GPIO_bit(SPITZ_GPIO_KEY_INT))
-		is_resume |= GPIO_bit(SPITZ_GPIO_KEY_INT);
+	if (PEDR & PXA_GPIO_bit(SPITZ_GPIO_KEY_INT))
+		is_resume |= PXA_GPIO_bit(SPITZ_GPIO_KEY_INT);
 
-	if (PKSR & GPIO_bit(SPITZ_GPIO_SYNC))
-		is_resume |= GPIO_bit(SPITZ_GPIO_SYNC);
+	if (PKSR & PXA_GPIO_bit(SPITZ_GPIO_SYNC))
+		is_resume |= PXA_GPIO_bit(SPITZ_GPIO_SYNC);
 
 	if (resume_on_alarm && (PEDR & PWER_RTC))
 		is_resume |= PWER_RTC;
@@ -169,14 +173,17 @@ static int spitz_should_wakeup(unsigned int resume_on_alarm)
 
 static unsigned long spitz_charger_wakeup(void)
 {
-	return (~GPLR0 & GPIO_bit(SPITZ_GPIO_KEY_INT)) | (GPLR0 & GPIO_bit(SPITZ_GPIO_SYNC));
+	return (~PXA_GPLR(SPITZ_GPIO_KEY_INT)
+		& PXA_GPIO_bit(SPITZ_GPIO_KEY_INT))
+		| (PXA_GPLR(SPITZ_GPIO_SYNC) & PXA_GPIO_bit(SPITZ_GPIO_SYNC));
 }
 
 unsigned long spitzpm_read_devdata(int type)
 {
 	switch (type) {
 	case SHARPSL_STATUS_ACIN:
-		return (((~GPLR(SPITZ_GPIO_AC_IN)) & GPIO_bit(SPITZ_GPIO_AC_IN)) != 0);
+		return (((~PXA_GPLR(SPITZ_GPIO_AC_IN))
+			& PXA_GPIO_bit(SPITZ_GPIO_AC_IN)) != 0);
 	case SHARPSL_STATUS_LOCK:
 		return gpio_get_value(sharpsl_pm.machinfo->gpio_batlock);
 	case SHARPSL_STATUS_CHRGFULL:
diff --git a/arch/arm/plat-pxa/include/plat/gpio-pxa.h b/arch/arm/plat-pxa/include/plat/gpio-pxa.h
index 15bf9be..b74b921 100644
--- a/arch/arm/plat-pxa/include/plat/gpio-pxa.h
+++ b/arch/arm/plat-pxa/include/plat/gpio-pxa.h
@@ -3,6 +3,17 @@
 
 struct irq_data;
 
+struct pxa_gpio_regs {
+	u32	gplr;
+	u32	gpdr;
+	u32	gpsr;
+	u32	gpcr;
+	u32	grer;
+	u32	gfer;
+	u32	gedr;
+	u32	gafr;
+};
+
 /*
  * We handle the GPIOs by banks, each bank covers up to 32 GPIOs with
  * one set of registers. The register offsets are organized below:
@@ -21,15 +32,39 @@ struct irq_data;
  *   BANK 4 and 5 are only available on PXA935
  */
 
-#define GPIO_BANK(n)	(GPIO_REGS_VIRT + BANK_OFF(n))
+#define PXA_BANK_OFF(n)	(((n) < 3) ? (n) << 2 : 0x100 + (((n) - 3) << 2))
+
+#define PXA_GPIO_BANK(n)	(pxa_gpio_regs.gplr + PXA_BANK_OFF(n))
+#define PXA_GPIO_bit(x)		(1 << ((x) & 0x1f))
+#define pxa_gpio_to_bank(gpio)	((gpio) >> 5)
+
+
+/* GPIO Pin Level Registers */
+#define PXA_GPLR(x)	(*(volatile u32 *)(pxa_gpio_regs.gplr	\
+			+ PXA_BANK_OFF((x >> 5))))
+/* GPIO Pin Direction Registers */
+#define PXA_GPDR(x)	(*(volatile u32 *)(pxa_gpio_regs.gpdr	\
+			+ PXA_BANK_OFF((x >> 5))))
+/* GPIO Pin Output Set Registers */
+#define PXA_GPSR(x)	(*(volatile u32 *)(pxa_gpio_regs.gpsr	\
+			+ PXA_BANK_OFF((x >> 5))))
+/* GPIO Pin Output Clear Registers */
+#define PXA_GPCR(x)	(*(volatile u32 *)(pxa_gpio_regs.gpcr	\
+			+ PXA_BANK_OFF((x >> 5))))
+/* GPIO Rising Edge Detect Registers */
+#define PXA_GRER(x)	(*(volatile u32 *)(pxa_gpio_regs.grer	\
+			+ PXA_BANK_OFF((x >> 5))))
+/* GPIO Falling Edge Detect Registers */
+#define PXA_GFER(x)	(*(volatile u32 *)(pxa_gpio_regs.gfer	\
+			+ PXA_BANK_OFF((x >> 5))))
+/* GPIO Edge Detect Status Registers */
+#define PXA_GEDR(x)	(*(volatile u32 *)(pxa_gpio_regs.gedr	\
+			+ PXA_BANK_OFF((x >> 5))))
+/* GPIO Alternate Function Select Registers */
+#define PXA_GAFR(x)	(*(volatile u32 *)(pxa_gpio_regs.gafr	\
+			+ (((x) & 0x70) >> 2)))
 
-#define GPLR_OFFSET	0x00
-#define GPDR_OFFSET	0x0C
-#define GPSR_OFFSET	0x18
-#define GPCR_OFFSET	0x24
-#define GRER_OFFSET	0x30
-#define GFER_OFFSET	0x3C
-#define GEDR_OFFSET	0x48
+extern struct pxa_gpio_regs pxa_gpio_regs;
 
 /* NOTE: some PXAs have fewer on-chip GPIOs (like PXA255, with 85).
  * Those cases currently cause holes in the GPIO number space, the
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 4caa3d3..015e95c 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -149,6 +149,12 @@ config GPIO_PL061
 	help
 	  Say yes here to support the PrimeCell PL061 GPIO device
 
+config GPIO_PXA
+	def_bool y
+	depends on ARCH_PXA || ARCH_MMP
+	help
+	  Say yes here to support the PXA GPIO device
+
 config GPIO_XILINX
 	bool "Xilinx GPIO support"
 	depends on PPC_OF || MICROBLAZE
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 19c5d27..56e4f1e 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -40,7 +40,7 @@ obj-$(CONFIG_GPIO_PCA953X)	+= gpio-pca953x.o
 obj-$(CONFIG_GPIO_PCF857X)	+= gpio-pcf857x.o
 obj-$(CONFIG_GPIO_PCH)		+= gpio-pch.o
 obj-$(CONFIG_GPIO_PL061)	+= gpio-pl061.o
-obj-$(CONFIG_PLAT_PXA)		+= gpio-pxa.o
+obj-$(CONFIG_GPIO_PXA)		+= gpio-pxa.o
 obj-$(CONFIG_GPIO_RDC321X)	+= gpio-rdc321x.o
 
 obj-$(CONFIG_GPIO_PLAT_SAMSUNG)	+= gpio-plat-samsung.o
diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index a26e37a..6731779 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -15,12 +15,20 @@
 #include <linux/init.h>
 #include <linux/irq.h>
 #include <linux/io.h>
+#include <linux/platform_device.h>
 #include <linux/syscore_ops.h>
 #include <linux/slab.h>
 
 #include <mach/gpio-pxa.h>
 
-int pxa_last_gpio;
+#define GPLR_OFFSET	0x00
+#define GPDR_OFFSET	0x0C
+#define GPSR_OFFSET	0x18
+#define GPCR_OFFSET	0x24
+#define GRER_OFFSET	0x30
+#define GFER_OFFSET	0x3C
+#define GEDR_OFFSET	0x48
+#define GAFR_OFFSET	0x54
 
 struct pxa_gpio_chip {
 	struct gpio_chip chip;
@@ -49,6 +57,9 @@ enum {
 	MMP2_GPIO,
 };
 
+struct pxa_gpio_regs pxa_gpio_regs;
+int pxa_last_gpio;
+
 static DEFINE_SPINLOCK(gpio_lock);
 static struct pxa_gpio_chip *pxa_gpio_chips;
 static int gpio_type;
@@ -63,7 +74,7 @@ static inline void __iomem *gpio_chip_base(struct gpio_chip *c)
 
 static inline struct pxa_gpio_chip *gpio_to_pxachip(unsigned gpio)
 {
-	return &pxa_gpio_chips[gpio_to_bank(gpio)];
+	return &pxa_gpio_chips[pxa_gpio_to_bank(gpio)];
 }
 
 static inline int gpio_is_pxa_type(int type)
@@ -163,7 +174,7 @@ static void pxa_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 
 static int __init pxa_init_gpio_chip(int gpio_end)
 {
-	int i, gpio, nbanks = gpio_to_bank(gpio_end) + 1;
+	int i, gpio, nbanks = pxa_gpio_to_bank(gpio_end) + 1;
 	struct pxa_gpio_chip *chips;
 
 	chips = kzalloc(nbanks * sizeof(struct pxa_gpio_chip), GFP_KERNEL);
@@ -176,7 +187,7 @@ static int __init pxa_init_gpio_chip(int gpio_end)
 		struct gpio_chip *c = &chips[i].chip;
 
 		sprintf(chips[i].label, "gpio-%d", i);
-		chips[i].regbase = (void __iomem *)GPIO_BANK(i);
+		chips[i].regbase = (void __iomem *)PXA_GPIO_BANK(i);
 
 		c->base  = gpio;
 		c->label = chips[i].label;
@@ -214,7 +225,7 @@ static int pxa_gpio_irq_type(struct irq_data *d, unsigned int type)
 {
 	struct pxa_gpio_chip *c;
 	int gpio = pxa_irq_to_gpio(d->irq);
-	unsigned long gpdr, mask = GPIO_bit(gpio);
+	unsigned long gpdr, mask = PXA_GPIO_bit(gpio);
 
 	c = gpio_to_pxachip(gpio);
 
@@ -222,7 +233,7 @@ static int pxa_gpio_irq_type(struct irq_data *d, unsigned int type)
 		/* Don't mess with enabled GPIOs using preconfigured edges or
 		 * GPIOs set to alternate function or to output during probe
 		 */
-		if ((c->irq_edge_rise | c->irq_edge_fall) & GPIO_bit(gpio))
+		if ((c->irq_edge_rise | c->irq_edge_fall) & PXA_GPIO_bit(gpio))
 			return 0;
 
 		if (__gpio_is_occupied(gpio))
@@ -287,7 +298,7 @@ static void pxa_ack_muxed_gpio(struct irq_data *d)
 	int gpio = pxa_irq_to_gpio(d->irq);
 	struct pxa_gpio_chip *c = gpio_to_pxachip(gpio);
 
-	__raw_writel(GPIO_bit(gpio), c->regbase + GEDR_OFFSET);
+	__raw_writel(PXA_GPIO_bit(gpio), c->regbase + GEDR_OFFSET);
 }
 
 static void pxa_mask_muxed_gpio(struct irq_data *d)
@@ -296,10 +307,10 @@ static void pxa_mask_muxed_gpio(struct irq_data *d)
 	struct pxa_gpio_chip *c = gpio_to_pxachip(gpio);
 	uint32_t grer, gfer;
 
-	c->irq_mask &= ~GPIO_bit(gpio);
+	c->irq_mask &= ~PXA_GPIO_bit(gpio);
 
-	grer = __raw_readl(c->regbase + GRER_OFFSET) & ~GPIO_bit(gpio);
-	gfer = __raw_readl(c->regbase + GFER_OFFSET) & ~GPIO_bit(gpio);
+	grer = __raw_readl(c->regbase + GRER_OFFSET) & ~PXA_GPIO_bit(gpio);
+	gfer = __raw_readl(c->regbase + GFER_OFFSET) & ~PXA_GPIO_bit(gpio);
 	__raw_writel(grer, c->regbase + GRER_OFFSET);
 	__raw_writel(gfer, c->regbase + GFER_OFFSET);
 }
@@ -309,7 +320,7 @@ static void pxa_unmask_muxed_gpio(struct irq_data *d)
 	int gpio = pxa_irq_to_gpio(d->irq);
 	struct pxa_gpio_chip *c = gpio_to_pxachip(gpio);
 
-	c->irq_mask |= GPIO_bit(gpio);
+	c->irq_mask |= PXA_GPIO_bit(gpio);
 	update_edge_detect(c);
 }
 
@@ -321,7 +332,7 @@ static struct irq_chip pxa_muxed_gpio_chip = {
 	.irq_set_type	= pxa_gpio_irq_type,
 };
 
-static int pxa_gpio_nums(void)
+static int __devinit pxa_gpio_nums(void)
 {
 	int count = 0;
 
@@ -358,17 +369,42 @@ static int pxa_gpio_nums(void)
 	return count;
 }
 
-void __init pxa_init_gpio(int mux_irq, int start, int end, set_wake_t fn)
+static int __devinit pxa_gpio_probe(struct platform_device *pdev)
 {
 	struct pxa_gpio_chip *c;
+	struct resource *res;
 	int gpio, irq;
+	int irq0 = 0, irq1 = 0, irq_mux, gpio_offset = 0;
 
 	pxa_last_gpio = pxa_gpio_nums();
 	if (!pxa_last_gpio)
 		return -EINVAL;
 
+	irq0 = platform_get_irq_byname(pdev, "gpio0");
+	irq1 = platform_get_irq_byname(pdev, "gpio1");
+	irq_mux = platform_get_irq_byname(pdev, "gpio_mux");
+	if ((irq0 > 0 && irq1 <= 0) || (irq0 <= 0 && irq1 > 0)
+		|| (irq_mux <= 0))
+		return -EINVAL;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+					   "gpio_virtual_base");
+	if (!res)
+		return -EINVAL;
+	pxa_gpio_regs.gplr = res->start + GPLR_OFFSET;
+	pxa_gpio_regs.gpdr = res->start + GPDR_OFFSET;
+	pxa_gpio_regs.gpsr = res->start + GPSR_OFFSET;
+	pxa_gpio_regs.gpcr = res->start + GPCR_OFFSET;
+	pxa_gpio_regs.grer = res->start + GRER_OFFSET;
+	pxa_gpio_regs.gfer = res->start + GFER_OFFSET;
+	pxa_gpio_regs.gedr = res->start + GEDR_OFFSET;
+	pxa_gpio_regs.gafr = res->start + GAFR_OFFSET;
+
+	if (irq0 > 0)
+		gpio_offset = 2;
+
 	/* Initialize GPIO chips */
-	pxa_init_gpio_chip(end);
+	pxa_init_gpio_chip(pxa_last_gpio);
 
 	/* clear all GPIO edge detects */
 	for_each_gpio_chip(gpio, c) {
@@ -391,17 +427,31 @@ void __init pxa_init_gpio(int mux_irq, int start, int end, set_wake_t fn)
 	irq_set_chained_handler(IRQ_GPIO1, pxa_gpio_demux_handler);
 #endif
 
-	for (irq  = gpio_to_irq(start); irq <= gpio_to_irq(end); irq++) {
+	for (irq  = gpio_to_irq(gpio_offset);
+		irq <= gpio_to_irq(pxa_last_gpio); irq++) {
 		irq_set_chip_and_handler(irq, &pxa_muxed_gpio_chip,
 					 handle_edge_irq);
 		set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
 	}
 
-	/* Install handler for GPIO>=2 edge detect interrupts */
-	irq_set_chained_handler(mux_irq, pxa_gpio_demux_handler);
-	pxa_muxed_gpio_chip.irq_set_wake = fn;
+	irq_set_chained_handler(irq_mux, pxa_gpio_demux_handler);
+	return 0;
 }
 
+static struct platform_driver pxa_gpio_driver = {
+	.probe          = pxa_gpio_probe,
+	.driver         = {
+		.owner  = THIS_MODULE,
+		.name   = "pxa-gpio",
+	},
+};
+
+static int __init pxa_gpio_init(void)
+{
+	return platform_driver_register(&pxa_gpio_driver);
+}
+postcore_initcall(pxa_gpio_init);
+
 #ifdef CONFIG_PM
 static int pxa_gpio_suspend(void)
 {
@@ -444,3 +494,10 @@ struct syscore_ops pxa_gpio_syscore_ops = {
 	.suspend	= pxa_gpio_suspend,
 	.resume		= pxa_gpio_resume,
 };
+
+static int __init pxa_gpio_sysinit(void)
+{
+	register_syscore_ops(&pxa_gpio_syscore_ops);
+	return 0;
+}
+postcore_initcall(pxa_gpio_sysinit);
-- 
1.7.2.5
