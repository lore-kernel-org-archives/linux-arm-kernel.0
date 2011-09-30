From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Fri, 30 Sep 2011 18:19:20 +0800
Subject: [PATCH v2 5/5] ARM: pxa: move gpio driver into drivers directory
In-Reply-To: <1317377960-11063-1-git-send-email-haojian.zhuang@marvell.com>
References: <1317377960-11063-1-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1317377960-11063-6-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move gpio driver from plat-pxa to drivers/gpio directory. Only leave
gpio number macro in mach/gpio.h.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/mach-mmp/Kconfig               |    3 +
 arch/arm/mach-mmp/aspenite.c            |    5 +-
 arch/arm/mach-mmp/avengers_lite.c       |    1 +
 arch/arm/mach-mmp/brownstone.c          |    1 +
 arch/arm/mach-mmp/flint.c               |    5 +-
 arch/arm/mach-mmp/gplugd.c              |    3 +-
 arch/arm/mach-mmp/include/mach/gpio.h   |   25 --
 arch/arm/mach-mmp/include/mach/irqs.h   |    4 +-
 arch/arm/mach-mmp/include/mach/mmp2.h   |    3 +
 arch/arm/mach-mmp/include/mach/pxa168.h |    3 +
 arch/arm/mach-mmp/include/mach/pxa910.h |    3 +
 arch/arm/mach-mmp/jasper.c              |    1 +
 arch/arm/mach-mmp/mmp2.c                |   43 ++-
 arch/arm/mach-mmp/pxa168.c              |   44 ++-
 arch/arm/mach-mmp/pxa910.c              |   44 ++-
 arch/arm/mach-mmp/tavorevb.c            |    5 +-
 arch/arm/mach-mmp/teton_bga.c           |    3 +-
 arch/arm/mach-mmp/ttc_dkb.c             |    3 +-
 arch/arm/mach-pxa/Kconfig               |    5 +
 arch/arm/mach-pxa/devices.c             |   36 ++
 arch/arm/mach-pxa/devices.h             |    1 +
 arch/arm/mach-pxa/include/mach/gpio.h   |   64 ----
 arch/arm/mach-pxa/pxa25x.c              |    4 +-
 arch/arm/mach-pxa/pxa27x.c              |    3 +-
 arch/arm/mach-pxa/pxa3xx.c              |    3 +-
 arch/arm/mach-pxa/pxa95x.c              |    3 +-
 arch/arm/plat-pxa/Makefile              |    1 -
 arch/arm/plat-pxa/gpio.c                |  352 -------------------
 arch/arm/plat-pxa/include/plat/gpio.h   |   65 ----
 drivers/gpio/Kconfig                    |    6 +
 drivers/gpio/Makefile                   |    1 +
 drivers/gpio/gpio-pxa.c                 |  558 +++++++++++++++++++++++++++++++
 include/linux/gpio-pxa.h                |   64 ++++
 33 files changed, 787 insertions(+), 578 deletions(-)
 delete mode 100644 arch/arm/plat-pxa/gpio.c
 delete mode 100644 arch/arm/plat-pxa/include/plat/gpio.h
 create mode 100644 drivers/gpio/gpio-pxa.c
 create mode 100644 include/linux/gpio-pxa.h

diff --git a/arch/arm/mach-mmp/Kconfig b/arch/arm/mach-mmp/Kconfig
index 56ef5f6..47810fb 100644
--- a/arch/arm/mach-mmp/Kconfig
+++ b/arch/arm/mach-mmp/Kconfig
@@ -89,18 +89,21 @@ endmenu
 config CPU_PXA168
 	bool
 	select CPU_MOHAWK
+	select GPIO_PXA
 	help
 	  Select code specific to PXA168
 
 config CPU_PXA910
 	bool
 	select CPU_MOHAWK
+	select GPIO_PXA
 	help
 	  Select code specific to PXA910
 
 config CPU_MMP2
 	bool
 	select CPU_PJ4
+	select GPIO_PXA
 	help
 	  Select code specific to MMP2. MMP2 is ARMv7 compatible.
 endif
diff --git a/arch/arm/mach-mmp/aspenite.c b/arch/arm/mach-mmp/aspenite.c
index 6b19812..aa52b3b 100644
--- a/arch/arm/mach-mmp/aspenite.c
+++ b/arch/arm/mach-mmp/aspenite.c
@@ -119,8 +119,8 @@ static struct resource smc91x_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= pxa_gpio_to_irq(27),
-		.end	= pxa_gpio_to_irq(27),
+		.start	= mmp_gpio_to_irq(27),
+		.end	= mmp_gpio_to_irq(27),
 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE,
 	}
 };
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
index c79162a..3ae42ee 100644
--- a/arch/arm/mach-mmp/brownstone.c
+++ b/arch/arm/mach-mmp/brownstone.c
@@ -197,6 +197,7 @@ static void __init brownstone_init(void)
 	mmp2_add_twsi(1, NULL, ARRAY_AND_SIZE(brownstone_twsi1_info));
 	mmp2_add_sdhost(0, &mmp2_sdh_platdata_mmc0); /* SD/MMC */
 	mmp2_add_sdhost(2, &mmp2_sdh_platdata_mmc2); /* eMMC */
+	platform_device_register(&mmp2_device_gpio);
 
 	/* enable 5v regulator */
 	platform_device_register(&brownstone_v_5vp_device);
diff --git a/arch/arm/mach-mmp/flint.c b/arch/arm/mach-mmp/flint.c
index f466a2c..838cc31 100644
--- a/arch/arm/mach-mmp/flint.c
+++ b/arch/arm/mach-mmp/flint.c
@@ -87,8 +87,8 @@ static struct resource smc91x_resources[] = {
 		.flags  = IORESOURCE_MEM,
 	},
 	[1] = {
-		.start  = pxa_gpio_to_irq(155),
-		.end    = pxa_gpio_to_irq(155),
+		.start  = mmp_gpio_to_irq(155),
+		.end    = mmp_gpio_to_irq(155),
 		.flags  = IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE,
 	}
 };
@@ -110,6 +110,7 @@ static void __init flint_init(void)
 	/* on-chip devices */
 	mmp2_add_uart(1);
 	mmp2_add_uart(2);
+	platform_device_register(&mmp2_device_gpio);
 
 	/* off-chip devices */
 	platform_device_register(&smc91x_device);
diff --git a/arch/arm/mach-mmp/gplugd.c b/arch/arm/mach-mmp/gplugd.c
index 98e25d9..5315fcc 100644
--- a/arch/arm/mach-mmp/gplugd.c
+++ b/arch/arm/mach-mmp/gplugd.c
@@ -9,11 +9,11 @@
  */
 
 #include <linux/init.h>
+#include <linux/gpio.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
 
-#include <mach/gpio.h>
 #include <mach/pxa168.h>
 #include <mach/mfp-pxa168.h>
 
@@ -184,6 +184,7 @@ static void __init gplugd_init(void)
 	pxa168_add_uart(3);
 	pxa168_add_ssp(0);
 	pxa168_add_twsi(0, NULL, ARRAY_AND_SIZE(gplugd_i2c_board_info));
+	platform_device_register(&pxa168_device_gpio);
 
 	pxa168_add_eth(&gplugd_eth_platform_data);
 }
diff --git a/arch/arm/mach-mmp/include/mach/gpio.h b/arch/arm/mach-mmp/include/mach/gpio.h
index 89d499e..691443d0 100644
--- a/arch/arm/mach-mmp/include/mach/gpio.h
+++ b/arch/arm/mach-mmp/include/mach/gpio.h
@@ -1,33 +1,8 @@
 #ifndef __ASM_MACH_GPIO_H
 #define __ASM_MACH_GPIO_H
 
-#include <mach/addr-map.h>
 #include <mach/irqs.h>
-#include <asm-generic/gpio.h>
-
-#define GPIO_REGS_VIRT	(APB_VIRT_BASE + 0x19000)
-
-#define BANK_OFF(n)	(((n) < 3) ? (n) << 2 : 0x100 + (((n) - 3) << 2))
-#define GPIO_REG(x)	(*((volatile u32 *)(GPIO_REGS_VIRT + (x))))
 
 #define NR_BUILTIN_GPIO		IRQ_GPIO_NUM
 
-#define gpio_to_bank(gpio)	((gpio) >> 5)
-
-#define __gpio_is_inverted(gpio)	(0)
-#define __gpio_is_occupied(gpio)	(0)
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
-#include <plat/gpio.h>
 #endif /* __ASM_MACH_GPIO_H */
diff --git a/arch/arm/mach-mmp/include/mach/irqs.h b/arch/arm/mach-mmp/include/mach/irqs.h
index 2971a00..6a72198 100644
--- a/arch/arm/mach-mmp/include/mach/irqs.h
+++ b/arch/arm/mach-mmp/include/mach/irqs.h
@@ -220,8 +220,8 @@
 
 #define IRQ_GPIO_START			128
 #define IRQ_GPIO_NUM			192
-#define pxa_gpio_to_irq(gpio)		(IRQ_GPIO_START + (gpio))
-#define pxa_irq_to_gpio(irq)		((irq) - IRQ_GPIO_START)
+#define mmp_gpio_to_irq(gpio)		(IRQ_GPIO_START + (gpio))
+#define mmp_irq_to_gpio(irq)		((irq) - IRQ_GPIO_START)
 
 #define IRQ_BOARD_START			(IRQ_GPIO_START + IRQ_GPIO_NUM)
 
diff --git a/arch/arm/mach-mmp/include/mach/mmp2.h b/arch/arm/mach-mmp/include/mach/mmp2.h
index de7b888..d228a28 100644
--- a/arch/arm/mach-mmp/include/mach/mmp2.h
+++ b/arch/arm/mach-mmp/include/mach/mmp2.h
@@ -12,6 +12,7 @@ extern void mmp2_clear_pmic_int(void);
 
 #include <linux/i2c.h>
 #include <linux/i2c/pxa-i2c.h>
+#include <linux/platform_device.h>
 #include <mach/devices.h>
 
 extern struct pxa_device_desc mmp2_device_uart1;
@@ -29,6 +30,8 @@ extern struct pxa_device_desc mmp2_device_sdh1;
 extern struct pxa_device_desc mmp2_device_sdh2;
 extern struct pxa_device_desc mmp2_device_sdh3;
 
+extern struct platform_device mmp2_device_gpio;
+
 static inline int mmp2_add_uart(int id)
 {
 	struct pxa_device_desc *d = NULL;
diff --git a/arch/arm/mach-mmp/include/mach/pxa168.h b/arch/arm/mach-mmp/include/mach/pxa168.h
index 7fb568d..22eccf0 100644
--- a/arch/arm/mach-mmp/include/mach/pxa168.h
+++ b/arch/arm/mach-mmp/include/mach/pxa168.h
@@ -9,6 +9,7 @@ extern void pxa168_clear_keypad_wakeup(void);
 
 #include <linux/i2c.h>
 #include <linux/i2c/pxa-i2c.h>
+#include <linux/platform_device.h>
 #include <mach/devices.h>
 #include <plat/pxa3xx_nand.h>
 #include <video/pxa168fb.h>
@@ -35,6 +36,8 @@ extern struct pxa_device_desc pxa168_device_fb;
 extern struct pxa_device_desc pxa168_device_keypad;
 extern struct pxa_device_desc pxa168_device_eth;
 
+extern struct platform_device pxa168_device_gpio;
+
 struct pxa168_usb_pdata {
 	/* If NULL, default phy init routine for PXA168 would be called */
 	int (*phy_init)(void __iomem *usb_phy_reg_base);
diff --git a/arch/arm/mach-mmp/include/mach/pxa910.h b/arch/arm/mach-mmp/include/mach/pxa910.h
index 91be755..fb84fd6 100644
--- a/arch/arm/mach-mmp/include/mach/pxa910.h
+++ b/arch/arm/mach-mmp/include/mach/pxa910.h
@@ -8,6 +8,7 @@ extern void __init pxa910_init_irq(void);
 
 #include <linux/i2c.h>
 #include <linux/i2c/pxa-i2c.h>
+#include <linux/platform_device.h>
 #include <mach/devices.h>
 #include <plat/pxa3xx_nand.h>
 
@@ -21,6 +22,8 @@ extern struct pxa_device_desc pxa910_device_pwm3;
 extern struct pxa_device_desc pxa910_device_pwm4;
 extern struct pxa_device_desc pxa910_device_nand;
 
+extern struct platform_device pxa910_device_gpio;
+
 static inline int pxa910_add_uart(int id)
 {
 	struct pxa_device_desc *d = NULL;
diff --git a/arch/arm/mach-mmp/jasper.c b/arch/arm/mach-mmp/jasper.c
index 5d6421d..f49bad2 100644
--- a/arch/arm/mach-mmp/jasper.c
+++ b/arch/arm/mach-mmp/jasper.c
@@ -166,6 +166,7 @@ static void __init jasper_init(void)
 	mmp2_add_uart(3);
 	mmp2_add_twsi(1, NULL, ARRAY_AND_SIZE(jasper_twsi1_info));
 	mmp2_add_sdhost(0, &mmp2_sdh_platdata_mmc0); /* SD/MMC */
+	platform_device_register(&mmp2_device_gpio);
 
 	regulator_has_full_constraints();
 }
diff --git a/arch/arm/mach-mmp/mmp2.c b/arch/arm/mach-mmp/mmp2.c
index 1935834..84aafae 100644
--- a/arch/arm/mach-mmp/mmp2.c
+++ b/arch/arm/mach-mmp/mmp2.c
@@ -14,6 +14,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/platform_device.h>
 
 #include <asm/hardware/cache-tauros2.h>
 
@@ -33,8 +34,6 @@
 
 #define MFPR_VIRT_BASE	(APB_VIRT_BASE + 0x1e000)
 
-#define APMASK(i)	(GPIO_REGS_VIRT + BANK_OFF(i) + 0x9c)
-
 static struct mfp_addr_map mmp2_addr_map[] __initdata = {
 
 	MFP_ADDR_X(GPIO0, GPIO58, 0x54),
@@ -94,24 +93,9 @@ void mmp2_clear_pmic_int(void)
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
-
-	pxa_init_gpio(IRQ_MMP2_GPIO, 0, 167, NULL);
-}
-
 void __init mmp2_init_irq(void)
 {
 	mmp2_init_icu();
-	mmp2_init_gpio();
 }
 
 static void sdhc_clk_enable(struct clk *clk)
@@ -226,3 +210,28 @@ MMP2_DEVICE(sdh1, "sdhci-pxav3", 1, MMC2, 0xd4280800, 0x120);
 MMP2_DEVICE(sdh2, "sdhci-pxav3", 2, MMC3, 0xd4281000, 0x120);
 MMP2_DEVICE(sdh3, "sdhci-pxav3", 3, MMC4, 0xd4281800, 0x120);
 
+struct resource mmp2_resources_gpio[] = {
+	{
+		.start	= 0xd4019000,
+		.end	= 0xd4019fff,
+		.name	= "gpio_phys_base",
+		.flags	= IORESOURCE_MEM,
+	}, {
+		.start	= APB_VIRT_BASE + 0x19000,
+		.end	= APB_VIRT_BASE + 0x19fff,
+		.name	= "gpio_virtual_base",
+		.flags	= IORESOURCE_MEM,
+	}, {
+		.start	= IRQ_MMP2_GPIO,
+		.end	= IRQ_MMP2_GPIO,
+		.name	= "gpio_mux",
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device mmp2_device_gpio = {
+	.name		= "pxa-gpio",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(mmp2_resources_gpio),
+	.resource	= mmp2_resources_gpio,
+};
diff --git a/arch/arm/mach-mmp/pxa168.c b/arch/arm/mach-mmp/pxa168.c
index e6f6789..f38bf35 100644
--- a/arch/arm/mach-mmp/pxa168.c
+++ b/arch/arm/mach-mmp/pxa168.c
@@ -14,6 +14,7 @@
 #include <linux/list.h>
 #include <linux/io.h>
 #include <linux/clk.h>
+#include <linux/platform_device.h>
 
 #include <asm/mach/time.h>
 #include <mach/addr-map.h>
@@ -43,26 +44,9 @@ static struct mfp_addr_map pxa168_mfp_addr_map[] __initdata =
 	MFP_ADDR_END,
 };
 
-#define APMASK(i)	(GPIO_REGS_VIRT + BANK_OFF(i) + 0x09c)
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
-
-	pxa_init_gpio(IRQ_PXA168_GPIOX, 0, 127, NULL);
-}
-
 void __init pxa168_init_irq(void)
 {
 	icu_init_irq();
-	pxa168_init_gpio();
 }
 
 /* APB peripheral clocks */
@@ -174,6 +158,32 @@ PXA168_DEVICE(fb, "pxa168-fb", -1, LCD, 0xd420b000, 0x1c8);
 PXA168_DEVICE(keypad, "pxa27x-keypad", -1, KEYPAD, 0xd4012000, 0x4c);
 PXA168_DEVICE(eth, "pxa168-eth", -1, MFU, 0xc0800000, 0x0fff);
 
+struct resource pxa168_resources_gpio[] = {
+	{
+		.start	= 0xd4019000,
+		.end	= 0xd4019fff,
+		.name	= "gpio_phys_base",
+		.flags	= IORESOURCE_MEM,
+	}, {
+		.start	= APB_VIRT_BASE + 0x19000,
+		.end	= APB_VIRT_BASE + 0x19fff,
+		.name	= "gpio_virtual_base",
+		.flags	= IORESOURCE_MEM,
+	}, {
+		.start	= IRQ_PXA168_GPIOX,
+		.end	= IRQ_PXA168_GPIOX,
+		.name	= "gpio_mux",
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device pxa168_device_gpio = {
+	.name		= "pxa-gpio",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(pxa168_resources_gpio),
+	.resource	= pxa168_resources_gpio,
+};
+
 struct resource pxa168_usb_host_resources[] = {
 	/* USB Host conroller register base */
 	[0] = {
diff --git a/arch/arm/mach-mmp/pxa910.c b/arch/arm/mach-mmp/pxa910.c
index c70b4dd..7b3b27a 100644
--- a/arch/arm/mach-mmp/pxa910.c
+++ b/arch/arm/mach-mmp/pxa910.c
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/io.h>
+#include <linux/platform_device.h>
 
 #include <asm/mach/time.h>
 #include <mach/addr-map.h>
@@ -77,26 +78,9 @@ static struct mfp_addr_map pxa910_mfp_addr_map[] __initdata =
 	MFP_ADDR_END,
 };
 
-#define APMASK(i)	(GPIO_REGS_VIRT + BANK_OFF(i) + 0x09c)
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
-
-	pxa_init_gpio(IRQ_PXA910_AP_GPIO, 0, 127, NULL);
-}
-
 void __init pxa910_init_irq(void)
 {
 	icu_init_irq();
-	pxa910_init_gpio();
 }
 
 /* APB peripheral clocks */
@@ -179,3 +163,29 @@ PXA910_DEVICE(pwm2, "pxa910-pwm", 1, NONE, 0xd401a400, 0x10);
 PXA910_DEVICE(pwm3, "pxa910-pwm", 2, NONE, 0xd401a800, 0x10);
 PXA910_DEVICE(pwm4, "pxa910-pwm", 3, NONE, 0xd401ac00, 0x10);
 PXA910_DEVICE(nand, "pxa3xx-nand", -1, NAND, 0xd4283000, 0x80, 97, 99);
+
+struct resource pxa910_resources_gpio[] = {
+	{
+		.start	= 0xd4019000,
+		.end	= 0xd4019fff,
+		.name	= "gpio_phys_base",
+		.flags	= IORESOURCE_MEM,
+	}, {
+		.start	= APB_VIRT_BASE + 0x19000,
+		.end	= APB_VIRT_BASE + 0x19fff,
+		.name	= "gpio_virtual_base",
+		.flags	= IORESOURCE_MEM,
+	}, {
+		.start	= IRQ_PXA910_AP_GPIO,
+		.end	= IRQ_PXA910_AP_GPIO,
+		.name	= "gpio_mux",
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device pxa910_device_gpio = {
+	.name		= "pxa-gpio",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(pxa910_resources_gpio),
+	.resource	= pxa910_resources_gpio,
+};
diff --git a/arch/arm/mach-mmp/tavorevb.c b/arch/arm/mach-mmp/tavorevb.c
index c5e1529..1cd3e50 100644
--- a/arch/arm/mach-mmp/tavorevb.c
+++ b/arch/arm/mach-mmp/tavorevb.c
@@ -70,8 +70,8 @@ static struct resource smc91x_resources[] = {
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= pxa_gpio_to_irq(80),
-		.end	= pxa_gpio_to_irq(80),
+		.start	= mmp_gpio_to_irq(80),
+		.end	= mmp_gpio_to_irq(80),
 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE,
 	}
 };
@@ -92,6 +92,7 @@ static void __init tavorevb_init(void)
 
 	/* on-chip devices */
 	pxa910_add_uart(1);
+	platform_device_register(&pxa910_device_gpio);
 
 	/* off-chip devices */
 	platform_device_register(&smc91x_device);
diff --git a/arch/arm/mach-mmp/teton_bga.c b/arch/arm/mach-mmp/teton_bga.c
index 79bbbc2..8ea6eeb 100644
--- a/arch/arm/mach-mmp/teton_bga.c
+++ b/arch/arm/mach-mmp/teton_bga.c
@@ -66,7 +66,7 @@ static struct pxa27x_keypad_platform_data teton_bga_keypad_info __initdata = {
 static struct i2c_board_info teton_bga_i2c_info[] __initdata = {
 	{
 		I2C_BOARD_INFO("ds1337", 0x68),
-		.irq = pxa_gpio_to_irq(RTC_INT_GPIO)
+		.irq = mmp_gpio_to_irq(RTC_INT_GPIO)
 	},
 };
 
@@ -78,6 +78,7 @@ static void __init teton_bga_init(void)
 	pxa168_add_uart(1);
 	pxa168_add_keypad(&teton_bga_keypad_info);
 	pxa168_add_twsi(0, NULL, ARRAY_AND_SIZE(teton_bga_i2c_info));
+	platform_device_register(&pxa168_device_gpio);
 }
 
 MACHINE_START(TETON_BGA, "PXA168-based Teton BGA Development Platform")
diff --git a/arch/arm/mach-mmp/ttc_dkb.c b/arch/arm/mach-mmp/ttc_dkb.c
index a420b07..e367438 100644
--- a/arch/arm/mach-mmp/ttc_dkb.c
+++ b/arch/arm/mach-mmp/ttc_dkb.c
@@ -122,6 +122,7 @@ static struct platform_device ttc_dkb_device_onenand = {
 };
 
 static struct platform_device *ttc_dkb_devices[] = {
+	&pxa910_device_gpio,
 	&ttc_dkb_device_onenand,
 };
 
@@ -136,7 +137,7 @@ static struct i2c_board_info ttc_dkb_i2c_info[] = {
 	{
 		.type		= "max7312",
 		.addr		= 0x23,
-		.irq		= pxa_gpio_to_irq(80),
+		.irq		= mmp_gpio_to_irq(80),
 		.platform_data	= &max7312_data,
 	},
 };
diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index cd19309..046f345 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -604,12 +604,14 @@ endmenu
 config PXA25x
 	bool
 	select CPU_XSCALE
+	select GPIO_PXA
 	help
 	  Select code specific to PXA21x/25x/26x variants
 
 config PXA27x
 	bool
 	select CPU_XSCALE
+	select GPIO_PXA
 	help
 	  Select code specific to PXA27x variants
 
@@ -622,6 +624,7 @@ config CPU_PXA26x
 config PXA3xx
 	bool
 	select CPU_XSC3
+	select GPIO_PXA
 	help
 	  Select code specific to PXA3xx variants
 
@@ -647,6 +650,7 @@ config CPU_PXA320
 config CPU_PXA930
 	bool
 	select PXA3xx
+	select GPIO_PXA
 	help
 	  PXA930 (codename Tavor-P)
 
@@ -659,6 +663,7 @@ config CPU_PXA935
 config PXA95x
 	bool
 	select CPU_PJ4
+	select GPIO_PXA
 	help
 	  Select code specific to PXA95x variants
 
diff --git a/arch/arm/mach-pxa/devices.c b/arch/arm/mach-pxa/devices.c
index 2e04254..4d6b9f2 100644
--- a/arch/arm/mach-pxa/devices.c
+++ b/arch/arm/mach-pxa/devices.c
@@ -1051,6 +1051,42 @@ struct platform_device pxa3xx_device_ssp4 = {
 };
 #endif /* CONFIG_PXA3xx || CONFIG_PXA95x */
 
+struct resource pxa_resources_gpio[] = {
+	{
+		.start	= 0x40e00000,
+		.end	= 0x40e0ffff,
+		.name	= "gpio_phys_base",
+		.flags	= IORESOURCE_MEM,
+	}, {
+		.start	= io_p2v(0x40e00000),
+		.end	= io_p2v(0x40e0ffff),
+		.name	= "gpio_virtual_base",
+		.flags	= IORESOURCE_MEM,
+	}, {
+		.start	= IRQ_GPIO0,
+		.end	= IRQ_GPIO0,
+		.name	= "gpio0",
+		.flags	= IORESOURCE_IRQ,
+	}, {
+		.start	= IRQ_GPIO1,
+		.end	= IRQ_GPIO1,
+		.name	= "gpio1",
+		.flags	= IORESOURCE_IRQ,
+	}, {
+		.start	= IRQ_GPIO_2_x,
+		.end	= IRQ_GPIO_2_x,
+		.name	= "gpio_mux",
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device pxa_device_gpio = {
+	.name		= "pxa-gpio",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(pxa_resources_gpio),
+	.resource	= pxa_resources_gpio,
+};
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
diff --git a/arch/arm/mach-pxa/include/mach/gpio.h b/arch/arm/mach-pxa/include/mach/gpio.h
index d58efb5..6db7f59 100644
--- a/arch/arm/mach-pxa/include/mach/gpio.h
+++ b/arch/arm/mach-pxa/include/mach/gpio.h
@@ -25,71 +25,7 @@
 #define __ASM_ARCH_PXA_GPIO_H
 
 #include <mach/irqs.h>
-#include <mach/hardware.h>
-#include <asm-generic/gpio.h>
-
-#define GPIO_REGS_VIRT	io_p2v(0x40E00000)
-
-#define BANK_OFF(n)	(((n) < 3) ? (n) << 2 : 0x100 + (((n) - 3) << 2))
-#define GPIO_REG(x)	(*(volatile u32 *)(GPIO_REGS_VIRT + (x)))
-
-/* More handy macros.  The argument is a literal GPIO number. */
-
-#define GPIO_bit(x)	(1 << ((x) & 0x1f))
-
-/* GPIO Pin Level Registers */
-#define GPLR(x)		GPIO_REG(BANK_OFF((x) >> 5) + 0x00)
-/* GPIO Pin Direction Registers */
-#define GPDR(x)		GPIO_REG(BANK_OFF((x) >> 5) + 0x0c)
-/* GPIO Pin Output Set Registers */
-#define GPSR(x)		GPIO_REG(BANK_OFF((x) >> 5) + 0x18)
-/* GPIO Pin Output Clear Registers */
-#define GPCR(x)		GPIO_REG(BANK_OFF((x) >> 5) + 0x24)
-/* GPIO Rising Edge Detect Registers */
-#define GRER(x)		GPIO_REG(BANK_OFF((x) >> 5) + 0x30)
-/* GPIO Falling Edge Detect Registers */
-#define GFER(x)		GPIO_REG(BANK_OFF((x) >> 5) + 0x3c)
-/* GPIO Edge Detect Status Registers */
-#define GEDR(x)		GPIO_REG(BANK_OFF((x) >> 5) + 0x48)
-/* GPIO Alternate Function Select Registers */
-#define GAFR(x)		GPIO_REG(0x54 + (((x) & 0x70) >> 2))
-
 
 #define NR_BUILTIN_GPIO		PXA_GPIO_IRQ_NUM
 
-#define gpio_to_bank(gpio)	((gpio) >> 5)
-
-#ifdef CONFIG_CPU_PXA26x
-/* GPIO86/87/88/89 on PXA26x have their direction bits in GPDR2 inverted,
- * as well as their Alternate Function value being '1' for GPIO in GAFRx.
- */
-static inline int __gpio_is_inverted(unsigned gpio)
-{
-	return cpu_is_pxa25x() && gpio > 85;
-}
-#else
-static inline int __gpio_is_inverted(unsigned gpio) { return 0; }
-#endif
-
-/*
- * On PXA25x and PXA27x, GAFRx and GPDRx together decide the alternate
- * function of a GPIO, and GPDRx cannot be altered once configured. It
- * is attributed as "occupied" here (I know this terminology isn't
- * accurate, you are welcome to propose a better one :-)
- */
-static inline int __gpio_is_occupied(unsigned gpio)
-{
-	if (cpu_is_pxa27x() || cpu_is_pxa25x()) {
-		int af = (GAFR(gpio) >> ((gpio & 0xf) * 2)) & 0x3;
-		int dir = GPDR(gpio) & GPIO_bit(gpio);
-
-		if (__gpio_is_inverted(gpio))
-			return af != 1 || dir == 0;
-		else
-			return af != 0 || dir != 0;
-	} else
-		return GPDR(gpio) & GPIO_bit(gpio);
-}
-
-#include <plat/gpio.h>
 #endif
diff --git a/arch/arm/mach-pxa/pxa25x.c b/arch/arm/mach-pxa/pxa25x.c
index 2ae1739..d802a96 100644
--- a/arch/arm/mach-pxa/pxa25x.c
+++ b/arch/arm/mach-pxa/pxa25x.c
@@ -311,14 +311,12 @@ set_pwer:
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
 
@@ -339,6 +337,7 @@ void __init pxa25x_map_io(void)
 }
 
 static struct platform_device *pxa25x_devices[] __initdata = {
+	&pxa_device_gpio,
 	&pxa25x_device_udc,
 	&pxa_device_pmu,
 	&pxa_device_i2s,
@@ -368,7 +367,6 @@ static int __init pxa25x_init(void)
 
 		register_syscore_ops(&pxa_irq_syscore_ops);
 		register_syscore_ops(&pxa2xx_mfp_syscore_ops);
-		register_syscore_ops(&pxa_gpio_syscore_ops);
 		register_syscore_ops(&pxa2xx_clock_syscore_ops);
 
 		ret = platform_add_devices(pxa25x_devices,
diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index 03d0728..572ae34 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -385,7 +385,6 @@ static int pxa27x_set_wake(struct irq_data *d, unsigned int on)
 void __init pxa27x_init_irq(void)
 {
 	pxa_init_irq(34, pxa27x_set_wake);
-	pxa_init_gpio(IRQ_GPIO_2_x, 2, 120, pxa27x_set_wake);
 }
 
 static struct map_desc pxa27x_io_desc[] __initdata = {
@@ -421,6 +420,7 @@ void __init pxa27x_set_i2c_power_info(struct i2c_pxa_platform_data *info)
 }
 
 static struct platform_device *devices[] __initdata = {
+	&pxa_device_gpio,
 	&pxa27x_device_udc,
 	&pxa_device_pmu,
 	&pxa_device_i2s,
@@ -454,7 +454,6 @@ static int __init pxa27x_init(void)
 
 		register_syscore_ops(&pxa_irq_syscore_ops);
 		register_syscore_ops(&pxa2xx_mfp_syscore_ops);
-		register_syscore_ops(&pxa_gpio_syscore_ops);
 		register_syscore_ops(&pxa2xx_clock_syscore_ops);
 
 		ret = platform_add_devices(devices, ARRAY_SIZE(devices));
diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index f18a6eb..807d343 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -389,7 +389,6 @@ void __init pxa3xx_init_irq(void)
 
 	pxa_init_irq(56, pxa3xx_set_wake);
 	pxa_init_ext_wakeup_irq(pxa3xx_set_wake);
-	pxa_init_gpio(IRQ_GPIO_2_x, 2, 127, NULL);
 }
 
 static struct map_desc pxa3xx_io_desc[] __initdata = {
@@ -418,6 +417,7 @@ void __init pxa3xx_set_i2c_power_info(struct i2c_pxa_platform_data *info)
 }
 
 static struct platform_device *devices[] __initdata = {
+	&pxa_device_gpio,
 	&pxa27x_device_udc,
 	&pxa_device_pmu,
 	&pxa_device_i2s,
@@ -461,7 +461,6 @@ static int __init pxa3xx_init(void)
 
 		register_syscore_ops(&pxa_irq_syscore_ops);
 		register_syscore_ops(&pxa3xx_mfp_syscore_ops);
-		register_syscore_ops(&pxa_gpio_syscore_ops);
 		register_syscore_ops(&pxa3xx_clock_syscore_ops);
 
 		ret = platform_add_devices(devices, ARRAY_SIZE(devices));
diff --git a/arch/arm/mach-pxa/pxa95x.c b/arch/arm/mach-pxa/pxa95x.c
index de25ceb..c89e209 100644
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
@@ -282,7 +282,6 @@ static int __init pxa95x_init(void)
 			return ret;
 
 		register_syscore_ops(&pxa_irq_syscore_ops);
-		register_syscore_ops(&pxa_gpio_syscore_ops);
 		register_syscore_ops(&pxa3xx_clock_syscore_ops);
 
 		ret = platform_add_devices(devices, ARRAY_SIZE(devices));
diff --git a/arch/arm/plat-pxa/Makefile b/arch/arm/plat-pxa/Makefile
index 3aca5ba..f302d04 100644
--- a/arch/arm/plat-pxa/Makefile
+++ b/arch/arm/plat-pxa/Makefile
@@ -4,7 +4,6 @@
 
 obj-y	:= dma.o
 
-obj-$(CONFIG_GENERIC_GPIO)	+= gpio.o
 obj-$(CONFIG_PXA3xx)		+= mfp.o
 obj-$(CONFIG_PXA95x)		+= mfp.o
 obj-$(CONFIG_ARCH_MMP)		+= mfp.o
diff --git a/arch/arm/plat-pxa/gpio.c b/arch/arm/plat-pxa/gpio.c
deleted file mode 100644
index d667d8d..0000000
--- a/arch/arm/plat-pxa/gpio.c
+++ /dev/null
@@ -1,352 +0,0 @@
-/*
- *  linux/arch/arm/plat-pxa/gpio.c
- *
- *  Generic PXA GPIO handling
- *
- *  Author:	Nicolas Pitre
- *  Created:	Jun 15, 2001
- *  Copyright:	MontaVista Software Inc.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- */
-#include <linux/gpio.h>
-#include <linux/init.h>
-#include <linux/irq.h>
-#include <linux/io.h>
-#include <linux/syscore_ops.h>
-#include <linux/slab.h>
-
-int pxa_last_gpio;
-
-struct pxa_gpio_chip {
-	struct gpio_chip chip;
-	void __iomem	*regbase;
-	char label[10];
-
-	unsigned long	irq_mask;
-	unsigned long	irq_edge_rise;
-	unsigned long	irq_edge_fall;
-
-#ifdef CONFIG_PM
-	unsigned long	saved_gplr;
-	unsigned long	saved_gpdr;
-	unsigned long	saved_grer;
-	unsigned long	saved_gfer;
-#endif
-};
-
-static DEFINE_SPINLOCK(gpio_lock);
-static struct pxa_gpio_chip *pxa_gpio_chips;
-
-#define for_each_gpio_chip(i, c)			\
-	for (i = 0, c = &pxa_gpio_chips[0]; i <= pxa_last_gpio; i += 32, c++)
-
-static inline void __iomem *gpio_chip_base(struct gpio_chip *c)
-{
-	return container_of(c, struct pxa_gpio_chip, chip)->regbase;
-}
-
-static inline struct pxa_gpio_chip *gpio_to_pxachip(unsigned gpio)
-{
-	return &pxa_gpio_chips[gpio_to_bank(gpio)];
-}
-
-static int pxa_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
-{
-	void __iomem *base = gpio_chip_base(chip);
-	uint32_t value, mask = 1 << offset;
-	unsigned long flags;
-
-	spin_lock_irqsave(&gpio_lock, flags);
-
-	value = __raw_readl(base + GPDR_OFFSET);
-	if (__gpio_is_inverted(chip->base + offset))
-		value |= mask;
-	else
-		value &= ~mask;
-	__raw_writel(value, base + GPDR_OFFSET);
-
-	spin_unlock_irqrestore(&gpio_lock, flags);
-	return 0;
-}
-
-static int pxa_gpio_direction_output(struct gpio_chip *chip,
-				     unsigned offset, int value)
-{
-	void __iomem *base = gpio_chip_base(chip);
-	uint32_t tmp, mask = 1 << offset;
-	unsigned long flags;
-
-	__raw_writel(mask, base + (value ? GPSR_OFFSET : GPCR_OFFSET));
-
-	spin_lock_irqsave(&gpio_lock, flags);
-
-	tmp = __raw_readl(base + GPDR_OFFSET);
-	if (__gpio_is_inverted(chip->base + offset))
-		tmp &= ~mask;
-	else
-		tmp |= mask;
-	__raw_writel(tmp, base + GPDR_OFFSET);
-
-	spin_unlock_irqrestore(&gpio_lock, flags);
-	return 0;
-}
-
-static int pxa_gpio_get(struct gpio_chip *chip, unsigned offset)
-{
-	return __raw_readl(gpio_chip_base(chip) + GPLR_OFFSET) & (1 << offset);
-}
-
-static void pxa_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
-{
-	__raw_writel(1 << offset, gpio_chip_base(chip) +
-				(value ? GPSR_OFFSET : GPCR_OFFSET));
-}
-
-static int __init pxa_init_gpio_chip(int gpio_end)
-{
-	int i, gpio, nbanks = gpio_to_bank(gpio_end) + 1;
-	struct pxa_gpio_chip *chips;
-
-	chips = kzalloc(nbanks * sizeof(struct pxa_gpio_chip), GFP_KERNEL);
-	if (chips == NULL) {
-		pr_err("%s: failed to allocate GPIO chips\n", __func__);
-		return -ENOMEM;
-	}
-
-	for (i = 0, gpio = 0; i < nbanks; i++, gpio += 32) {
-		struct gpio_chip *c = &chips[i].chip;
-
-		sprintf(chips[i].label, "gpio-%d", i);
-		chips[i].regbase = (void __iomem *)GPIO_BANK(i);
-
-		c->base  = gpio;
-		c->label = chips[i].label;
-
-		c->direction_input  = pxa_gpio_direction_input;
-		c->direction_output = pxa_gpio_direction_output;
-		c->get = pxa_gpio_get;
-		c->set = pxa_gpio_set;
-
-		/* number of GPIOs on last bank may be less than 32 */
-		c->ngpio = (gpio + 31 > gpio_end) ? (gpio_end - gpio + 1) : 32;
-		gpiochip_add(c);
-	}
-	pxa_gpio_chips = chips;
-	return 0;
-}
-
-/* Update only those GRERx and GFERx edge detection register bits if those
- * bits are set in c->irq_mask
- */
-static inline void update_edge_detect(struct pxa_gpio_chip *c)
-{
-	uint32_t grer, gfer;
-
-	grer = __raw_readl(c->regbase + GRER_OFFSET) & ~c->irq_mask;
-	gfer = __raw_readl(c->regbase + GFER_OFFSET) & ~c->irq_mask;
-	grer |= c->irq_edge_rise & c->irq_mask;
-	gfer |= c->irq_edge_fall & c->irq_mask;
-	__raw_writel(grer, c->regbase + GRER_OFFSET);
-	__raw_writel(gfer, c->regbase + GFER_OFFSET);
-}
-
-static int pxa_gpio_irq_type(struct irq_data *d, unsigned int type)
-{
-	struct pxa_gpio_chip *c;
-	int gpio = pxa_irq_to_gpio(d->irq);
-	unsigned long gpdr, mask = GPIO_bit(gpio);
-
-	c = gpio_to_pxachip(gpio);
-
-	if (type == IRQ_TYPE_PROBE) {
-		/* Don't mess with enabled GPIOs using preconfigured edges or
-		 * GPIOs set to alternate function or to output during probe
-		 */
-		if ((c->irq_edge_rise | c->irq_edge_fall) & GPIO_bit(gpio))
-			return 0;
-
-		if (__gpio_is_occupied(gpio))
-			return 0;
-
-		type = IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING;
-	}
-
-	gpdr = __raw_readl(c->regbase + GPDR_OFFSET);
-
-	if (__gpio_is_inverted(gpio))
-		__raw_writel(gpdr | mask,  c->regbase + GPDR_OFFSET);
-	else
-		__raw_writel(gpdr & ~mask, c->regbase + GPDR_OFFSET);
-
-	if (type & IRQ_TYPE_EDGE_RISING)
-		c->irq_edge_rise |= mask;
-	else
-		c->irq_edge_rise &= ~mask;
-
-	if (type & IRQ_TYPE_EDGE_FALLING)
-		c->irq_edge_fall |= mask;
-	else
-		c->irq_edge_fall &= ~mask;
-
-	update_edge_detect(c);
-
-	pr_debug("%s: IRQ%d (GPIO%d) - edge%s%s\n", __func__, d->irq, gpio,
-		((type & IRQ_TYPE_EDGE_RISING)  ? " rising"  : ""),
-		((type & IRQ_TYPE_EDGE_FALLING) ? " falling" : ""));
-	return 0;
-}
-
-static void pxa_gpio_demux_handler(unsigned int irq, struct irq_desc *desc)
-{
-	struct pxa_gpio_chip *c;
-	int loop, gpio, gpio_base, n;
-	unsigned long gedr;
-
-	do {
-		loop = 0;
-		for_each_gpio_chip(gpio, c) {
-			gpio_base = c->chip.base;
-
-			gedr = __raw_readl(c->regbase + GEDR_OFFSET);
-			gedr = gedr & c->irq_mask;
-			__raw_writel(gedr, c->regbase + GEDR_OFFSET);
-
-			n = find_first_bit(&gedr, BITS_PER_LONG);
-			while (n < BITS_PER_LONG) {
-				loop = 1;
-
-				generic_handle_irq(pxa_gpio_to_irq(gpio_base + n));
-				n = find_next_bit(&gedr, BITS_PER_LONG, n + 1);
-			}
-		}
-	} while (loop);
-}
-
-static void pxa_ack_muxed_gpio(struct irq_data *d)
-{
-	int gpio = pxa_irq_to_gpio(d->irq);
-	struct pxa_gpio_chip *c = gpio_to_pxachip(gpio);
-
-	__raw_writel(GPIO_bit(gpio), c->regbase + GEDR_OFFSET);
-}
-
-static void pxa_mask_muxed_gpio(struct irq_data *d)
-{
-	int gpio = pxa_irq_to_gpio(d->irq);
-	struct pxa_gpio_chip *c = gpio_to_pxachip(gpio);
-	uint32_t grer, gfer;
-
-	c->irq_mask &= ~GPIO_bit(gpio);
-
-	grer = __raw_readl(c->regbase + GRER_OFFSET) & ~GPIO_bit(gpio);
-	gfer = __raw_readl(c->regbase + GFER_OFFSET) & ~GPIO_bit(gpio);
-	__raw_writel(grer, c->regbase + GRER_OFFSET);
-	__raw_writel(gfer, c->regbase + GFER_OFFSET);
-}
-
-static void pxa_unmask_muxed_gpio(struct irq_data *d)
-{
-	int gpio = pxa_irq_to_gpio(d->irq);
-	struct pxa_gpio_chip *c = gpio_to_pxachip(gpio);
-
-	c->irq_mask |= GPIO_bit(gpio);
-	update_edge_detect(c);
-}
-
-static struct irq_chip pxa_muxed_gpio_chip = {
-	.name		= "GPIO",
-	.irq_ack	= pxa_ack_muxed_gpio,
-	.irq_mask	= pxa_mask_muxed_gpio,
-	.irq_unmask	= pxa_unmask_muxed_gpio,
-	.irq_set_type	= pxa_gpio_irq_type,
-};
-
-void __init pxa_init_gpio(int mux_irq, int start, int end,
-			  int (*fn)(struct irq_data *, unsigned int))
-{
-	struct pxa_gpio_chip *c;
-	int gpio, irq;
-
-	pxa_last_gpio = end;
-
-	/* Initialize GPIO chips */
-	pxa_init_gpio_chip(end);
-
-	/* clear all GPIO edge detects */
-	for_each_gpio_chip(gpio, c) {
-		__raw_writel(0, c->regbase + GFER_OFFSET);
-		__raw_writel(0, c->regbase + GRER_OFFSET);
-		__raw_writel(~0,c->regbase + GEDR_OFFSET);
-	}
-
-#ifdef CONFIG_ARCH_PXA
-	irq = gpio_to_irq(0);
-	irq_set_chip_and_handler(irq, &pxa_muxed_gpio_chip,
-				 handle_edge_irq);
-	set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
-	irq_set_chained_handler(IRQ_GPIO0, pxa_gpio_demux_handler);
-
-	irq = gpio_to_irq(1);
-	irq_set_chip_and_handler(irq, &pxa_muxed_gpio_chip,
-				 handle_edge_irq);
-	set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
-	irq_set_chained_handler(IRQ_GPIO1, pxa_gpio_demux_handler);
-#endif
-
-	for (irq  = pxa_gpio_to_irq(start); irq <= pxa_gpio_to_irq(end);
-		irq++) {
-		irq_set_chip_and_handler(irq, &pxa_muxed_gpio_chip,
-					 handle_edge_irq);
-		set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
-	}
-
-	/* Install handler for GPIO>=2 edge detect interrupts */
-	irq_set_chained_handler(mux_irq, pxa_gpio_demux_handler);
-	pxa_muxed_gpio_chip.irq_set_wake = fn;
-}
-
-#ifdef CONFIG_PM
-static int pxa_gpio_suspend(void)
-{
-	struct pxa_gpio_chip *c;
-	int gpio;
-
-	for_each_gpio_chip(gpio, c) {
-		c->saved_gplr = __raw_readl(c->regbase + GPLR_OFFSET);
-		c->saved_gpdr = __raw_readl(c->regbase + GPDR_OFFSET);
-		c->saved_grer = __raw_readl(c->regbase + GRER_OFFSET);
-		c->saved_gfer = __raw_readl(c->regbase + GFER_OFFSET);
-
-		/* Clear GPIO transition detect bits */
-		__raw_writel(0xffffffff, c->regbase + GEDR_OFFSET);
-	}
-	return 0;
-}
-
-static void pxa_gpio_resume(void)
-{
-	struct pxa_gpio_chip *c;
-	int gpio;
-
-	for_each_gpio_chip(gpio, c) {
-		/* restore level with set/clear */
-		__raw_writel( c->saved_gplr, c->regbase + GPSR_OFFSET);
-		__raw_writel(~c->saved_gplr, c->regbase + GPCR_OFFSET);
-
-		__raw_writel(c->saved_grer, c->regbase + GRER_OFFSET);
-		__raw_writel(c->saved_gfer, c->regbase + GFER_OFFSET);
-		__raw_writel(c->saved_gpdr, c->regbase + GPDR_OFFSET);
-	}
-}
-#else
-#define pxa_gpio_suspend	NULL
-#define pxa_gpio_resume		NULL
-#endif
-
-struct syscore_ops pxa_gpio_syscore_ops = {
-	.suspend	= pxa_gpio_suspend,
-	.resume		= pxa_gpio_resume,
-};
diff --git a/arch/arm/plat-pxa/include/plat/gpio.h b/arch/arm/plat-pxa/include/plat/gpio.h
deleted file mode 100644
index d31c2a5..0000000
--- a/arch/arm/plat-pxa/include/plat/gpio.h
+++ /dev/null
@@ -1,65 +0,0 @@
-#ifndef __PLAT_GPIO_H
-#define __PLAT_GPIO_H
-
-#define __ARM_GPIOLIB_COMPLEX
-
-struct irq_data;
-
-/*
- * We handle the GPIOs by banks, each bank covers up to 32 GPIOs with
- * one set of registers. The register offsets are organized below:
- *
- *           GPLR    GPDR    GPSR    GPCR    GRER    GFER    GEDR
- * BANK 0 - 0x0000  0x000C  0x0018  0x0024  0x0030  0x003C  0x0048
- * BANK 1 - 0x0004  0x0010  0x001C  0x0028  0x0034  0x0040  0x004C
- * BANK 2 - 0x0008  0x0014  0x0020  0x002C  0x0038  0x0044  0x0050
- *
- * BANK 3 - 0x0100  0x010C  0x0118  0x0124  0x0130  0x013C  0x0148
- * BANK 4 - 0x0104  0x0110  0x011C  0x0128  0x0134  0x0140  0x014C
- * BANK 5 - 0x0108  0x0114  0x0120  0x012C  0x0138  0x0144  0x0150
- *
- * NOTE:
- *   BANK 3 is only available on PXA27x and later processors.
- *   BANK 4 and 5 are only available on PXA935
- */
-
-#define GPIO_BANK(n)	(GPIO_REGS_VIRT + BANK_OFF(n))
-
-#define GPLR_OFFSET	0x00
-#define GPDR_OFFSET	0x0C
-#define GPSR_OFFSET	0x18
-#define GPCR_OFFSET	0x24
-#define GRER_OFFSET	0x30
-#define GFER_OFFSET	0x3C
-#define GEDR_OFFSET	0x48
-
-static inline int gpio_get_value(unsigned gpio)
-{
-	if (__builtin_constant_p(gpio) && (gpio < NR_BUILTIN_GPIO))
-		return GPLR(gpio) & GPIO_bit(gpio);
-	else
-		return __gpio_get_value(gpio);
-}
-
-static inline void gpio_set_value(unsigned gpio, int value)
-{
-	if (__builtin_constant_p(gpio) && (gpio < NR_BUILTIN_GPIO)) {
-		if (value)
-			GPSR(gpio) = GPIO_bit(gpio);
-		else
-			GPCR(gpio) = GPIO_bit(gpio);
-	} else
-		__gpio_set_value(gpio, value);
-}
-
-#define gpio_cansleep		__gpio_cansleep
-
-/* NOTE: some PXAs have fewer on-chip GPIOs (like PXA255, with 85).
- * Those cases currently cause holes in the GPIO number space, the
- * actual number of the last GPIO is recorded by 'pxa_last_gpio'.
- */
-extern int pxa_last_gpio;
-
-extern void pxa_init_gpio(int mux_irq, int start, int end,
-			  int (*fn)(struct irq_data *, unsigned int));
-#endif /* __PLAT_GPIO_H */
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 6465030..08fe9f6 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -141,6 +141,12 @@ config GPIO_PL061
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
index a4c8ac9..194899f 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -40,6 +40,7 @@ obj-$(CONFIG_GPIO_PCA953X)	+= gpio-pca953x.o
 obj-$(CONFIG_GPIO_PCF857X)	+= gpio-pcf857x.o
 obj-$(CONFIG_GPIO_PCH)		+= gpio-pch.o
 obj-$(CONFIG_GPIO_PL061)	+= gpio-pl061.o
+obj-$(CONFIG_GPIO_PXA)		+= gpio-pxa.o
 obj-$(CONFIG_GPIO_RDC321X)	+= gpio-rdc321x.o
 obj-$(CONFIG_ARCH_SA1100)	+= gpio-sa1100.o
 obj-$(CONFIG_PLAT_SAMSUNG)	+= gpio-samsung.o
diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
new file mode 100644
index 0000000..e8bb2d2
--- /dev/null
+++ b/drivers/gpio/gpio-pxa.c
@@ -0,0 +1,558 @@
+/*
+ *  linux/arch/arm/plat-pxa/gpio.c
+ *
+ *  Generic PXA GPIO handling
+ *
+ *  Author:	Nicolas Pitre
+ *  Created:	Jun 15, 2001
+ *  Copyright:	MontaVista Software Inc.
+ *
+ *  Copyright (C) 2011 Marvell Technology
+ *  Moved to drivers/gpio - Haojian Zhuang <haojian.zhuang@marvell.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ */
+
+#include <linux/gpio.h>
+#include <linux/gpio-pxa.h>
+#include <linux/irq.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/syscore_ops.h>
+
+#ifdef CONFIG_ARCH_MMP
+#include <mach/cputype.h>
+#endif
+
+#define GPLR_OFFSET	0x00
+#define GPDR_OFFSET	0x0C
+#define GPSR_OFFSET	0x18
+#define GPCR_OFFSET	0x24
+#define GRER_OFFSET	0x30
+#define GFER_OFFSET	0x3C
+#define GEDR_OFFSET	0x48
+#define GAFR_OFFSET	0x54
+
+static int pxa_last_gpio;
+
+struct pxa_gpio_irq_data {
+	int	irq_gpio0;
+	int	irq_gpio1;
+	int	irq_mux;
+};
+
+struct pxa_gpio_chip {
+	struct gpio_chip		chip;
+	void __iomem			*regbase;
+	char				label[10];
+
+	unsigned long			irq_mask;
+	unsigned long			irq_edge_rise;
+	unsigned long			irq_edge_fall;
+
+#ifdef CONFIG_PM
+	unsigned long			saved_gplr;
+	unsigned long			saved_gpdr;
+	unsigned long			saved_grer;
+	unsigned long			saved_gfer;
+#endif
+};
+
+enum {
+	/*
+	 * Interrupt of GPIO0 & GPIO1 is dependant in PXA series.
+	 * Interrupt of all GPIO is muxed into one in MMP series.
+	 */
+	PXA25X_GPIO = 0,
+	PXA26X_GPIO,
+	PXA27X_GPIO,
+	PXA3XX_GPIO,
+	PXA93X_GPIO,
+	MMP_GPIO = 0x10,
+	MMP2_GPIO,
+};
+
+struct pxa_gpio_regs pxa_gpio_regs;
+
+static DEFINE_SPINLOCK(gpio_lock);
+static struct pxa_gpio_chip *pxa_gpio_chips;
+static int gpio_type;
+
+#define for_each_gpio_chip(i, c)			\
+	for (i = 0, c = &pxa_gpio_chips[0]; i <= pxa_last_gpio; i += 32, c++)
+
+static inline void __iomem *gpio_chip_base(struct gpio_chip *c)
+{
+	return container_of(c, struct pxa_gpio_chip, chip)->regbase;
+}
+
+static inline struct pxa_gpio_chip *gpio_to_pxachip(unsigned gpio)
+{
+	return &pxa_gpio_chips[gpio_to_bank(gpio)];
+}
+
+static inline int gpio_is_pxa_type(int type)
+{
+	if (type & 0x10)
+		return 0;
+	return 1;
+}
+
+static inline int gpio_is_mmp_type(int type)
+{
+	if (type & 0x10)
+		return 1;
+	return 0;
+}
+
+static int __gpio_is_inverted(int gpio)
+{
+	if ((gpio_type == PXA26X_GPIO) && (gpio > 84))
+		return 1;
+	return 0;
+}
+
+static int __gpio_is_irq(int gpio)
+{
+	int af = 0, dir = 0;
+	int ret;
+
+	switch (gpio_type) {
+	case PXA25X_GPIO:
+	case PXA26X_GPIO:
+	case PXA27X_GPIO:
+		af = (GAFR(gpio) >> ((gpio & 0xf) * 2)) & 0x3;
+		dir = GPDR(gpio) & GPIO_bit(gpio);
+		if ((gpio_type == PXA26X_GPIO) && (gpio > 84))
+			ret = (af != 1) || (dir == 0);
+		else
+			ret = (af != 0) || (dir != 0);
+		break;
+	default:
+		ret = GPDR(gpio) & GPIO_bit(gpio);
+		break;
+	}
+	return ret;
+}
+
+static inline int mgpio_to_irq(int gpio)
+{
+#ifdef CONFIG_ARCH_PXA
+	if (gpio_is_pxa_type(gpio_type))
+		return pxa_gpio_to_irq(gpio);
+#endif
+#ifdef CONFIG_ARCH_MMP
+	if (gpio_is_mmp_type(gpio_type))
+		return mmp_gpio_to_irq(gpio);
+#endif
+	return 0;
+}
+
+static inline int mirq_to_gpio(struct irq_data *d)
+{
+#ifdef CONFIG_ARCH_PXA
+	if (gpio_is_pxa_type(gpio_type))
+		return pxa_irq_to_gpio(d->irq);
+#endif
+#ifdef CONFIG_ARCH_MMP
+	if (gpio_is_mmp_type(gpio_type))
+		return mmp_irq_to_gpio(d->irq);
+#endif
+	return 0;
+}
+
+static int pxa_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
+{
+	void __iomem *base = gpio_chip_base(chip);
+	uint32_t value, mask = 1 << offset;
+	unsigned long flags;
+
+	spin_lock_irqsave(&gpio_lock, flags);
+
+	value = __raw_readl(base + GPDR_OFFSET);
+	if (__gpio_is_inverted(chip->base + offset))
+		value |= mask;
+	else
+		value &= ~mask;
+	__raw_writel(value, base + GPDR_OFFSET);
+
+	spin_unlock_irqrestore(&gpio_lock, flags);
+	return 0;
+}
+
+static int pxa_gpio_direction_output(struct gpio_chip *chip,
+				     unsigned offset, int value)
+{
+	void __iomem *base = gpio_chip_base(chip);
+	uint32_t tmp, mask = 1 << offset;
+	unsigned long flags;
+
+	__raw_writel(mask, base + (value ? GPSR_OFFSET : GPCR_OFFSET));
+
+	spin_lock_irqsave(&gpio_lock, flags);
+
+	tmp = __raw_readl(base + GPDR_OFFSET);
+	if (__gpio_is_inverted(chip->base + offset))
+		tmp &= ~mask;
+	else
+		tmp |= mask;
+	__raw_writel(tmp, base + GPDR_OFFSET);
+
+	spin_unlock_irqrestore(&gpio_lock, flags);
+	return 0;
+}
+
+static int pxa_gpio_get(struct gpio_chip *chip, unsigned offset)
+{
+	return __raw_readl(gpio_chip_base(chip) + GPLR_OFFSET) & (1 << offset);
+}
+
+static void pxa_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
+{
+	__raw_writel(1 << offset, gpio_chip_base(chip) +
+				(value ? GPSR_OFFSET : GPCR_OFFSET));
+}
+
+static int __init pxa_init_gpio_chip(int gpio_end,
+				     struct pxa_gpio_irq_data *data)
+{
+	int i, gpio, nbanks = gpio_to_bank(gpio_end) + 1;
+	struct pxa_gpio_chip *chips;
+
+	chips = kzalloc(nbanks * sizeof(struct pxa_gpio_chip), GFP_KERNEL);
+	if (chips == NULL) {
+		pr_err("%s: failed to allocate GPIO chips\n", __func__);
+		return -ENOMEM;
+	}
+
+	for (i = 0, gpio = 0; i < nbanks; i++, gpio += 32) {
+		struct gpio_chip *c = &chips[i].chip;
+
+		sprintf(chips[i].label, "gpio-%d", i);
+		chips[i].regbase = (void __iomem *)GPIO_BANK(i);
+
+		c->base  = gpio;
+		c->label = chips[i].label;
+
+		c->direction_input  = pxa_gpio_direction_input;
+		c->direction_output = pxa_gpio_direction_output;
+		c->get = pxa_gpio_get;
+		c->set = pxa_gpio_set;
+
+		/* number of GPIOs on last bank may be less than 32 */
+		c->ngpio = (gpio + 31 > gpio_end) ? (gpio_end - gpio + 1) : 32;
+		gpiochip_add(c);
+	}
+	pxa_gpio_chips = chips;
+	return 0;
+}
+
+/* Update only those GRERx and GFERx edge detection register bits if those
+ * bits are set in c->irq_mask
+ */
+static inline void update_edge_detect(struct pxa_gpio_chip *c)
+{
+	uint32_t grer, gfer;
+
+	grer = __raw_readl(c->regbase + GRER_OFFSET) & ~c->irq_mask;
+	gfer = __raw_readl(c->regbase + GFER_OFFSET) & ~c->irq_mask;
+	grer |= c->irq_edge_rise & c->irq_mask;
+	gfer |= c->irq_edge_fall & c->irq_mask;
+	__raw_writel(grer, c->regbase + GRER_OFFSET);
+	__raw_writel(gfer, c->regbase + GFER_OFFSET);
+}
+
+static int pxa_gpio_irq_type(struct irq_data *d, unsigned int type)
+{
+	struct pxa_gpio_chip *c;
+	int gpio = mirq_to_gpio(d);
+	unsigned long gpdr, mask = GPIO_bit(gpio);
+
+	c = gpio_to_pxachip(gpio);
+
+	if (type == IRQ_TYPE_PROBE) {
+		/* Don't mess with enabled GPIOs using preconfigured edges or
+		 * GPIOs set to alternate function or to output during probe
+		 */
+		if ((c->irq_edge_rise | c->irq_edge_fall) & GPIO_bit(gpio))
+			return 0;
+
+		if (!__gpio_is_irq(gpio))
+			return 0;
+
+		type = IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING;
+	}
+
+	gpdr = __raw_readl(c->regbase + GPDR_OFFSET);
+
+	if (__gpio_is_inverted(gpio))
+		__raw_writel(gpdr | mask,  c->regbase + GPDR_OFFSET);
+	else
+		__raw_writel(gpdr & ~mask, c->regbase + GPDR_OFFSET);
+
+	if (type & IRQ_TYPE_EDGE_RISING)
+		c->irq_edge_rise |= mask;
+	else
+		c->irq_edge_rise &= ~mask;
+
+	if (type & IRQ_TYPE_EDGE_FALLING)
+		c->irq_edge_fall |= mask;
+	else
+		c->irq_edge_fall &= ~mask;
+
+	update_edge_detect(c);
+
+	pr_debug("%s: IRQ%d (GPIO%d) - edge%s%s\n", __func__, d->irq, gpio,
+		((type & IRQ_TYPE_EDGE_RISING)  ? " rising"  : ""),
+		((type & IRQ_TYPE_EDGE_FALLING) ? " falling" : ""));
+	return 0;
+}
+
+static void pxa_gpio_demux_handler(unsigned int irq, struct irq_desc *desc)
+{
+	struct pxa_gpio_chip *c;
+	int loop, gpio, gpio_base, n;
+	unsigned long gedr;
+
+	do {
+		loop = 0;
+		for_each_gpio_chip(gpio, c) {
+			gpio_base = c->chip.base;
+
+			gedr = __raw_readl(c->regbase + GEDR_OFFSET);
+			gedr = gedr & c->irq_mask;
+			__raw_writel(gedr, c->regbase + GEDR_OFFSET);
+
+			n = find_first_bit(&gedr, BITS_PER_LONG);
+			while (n < BITS_PER_LONG) {
+				loop = 1;
+
+				irq = mgpio_to_irq(gpio_base + n);
+				generic_handle_irq(irq);
+				n = find_next_bit(&gedr, BITS_PER_LONG, n + 1);
+			}
+		}
+	} while (loop);
+}
+
+static void pxa_ack_muxed_gpio(struct irq_data *d)
+{
+	int gpio = mirq_to_gpio(d);
+	struct pxa_gpio_chip *c = gpio_to_pxachip(gpio);
+
+	__raw_writel(GPIO_bit(gpio), c->regbase + GEDR_OFFSET);
+}
+
+static void pxa_mask_muxed_gpio(struct irq_data *d)
+{
+	int gpio = mirq_to_gpio(d);
+	struct pxa_gpio_chip *c = gpio_to_pxachip(gpio);
+	uint32_t grer, gfer;
+
+	c->irq_mask &= ~GPIO_bit(gpio);
+
+	grer = __raw_readl(c->regbase + GRER_OFFSET) & ~GPIO_bit(gpio);
+	gfer = __raw_readl(c->regbase + GFER_OFFSET) & ~GPIO_bit(gpio);
+	__raw_writel(grer, c->regbase + GRER_OFFSET);
+	__raw_writel(gfer, c->regbase + GFER_OFFSET);
+}
+
+static void pxa_unmask_muxed_gpio(struct irq_data *d)
+{
+	int gpio = mirq_to_gpio(d);
+	struct pxa_gpio_chip *c = gpio_to_pxachip(gpio);
+
+	c->irq_mask |= GPIO_bit(gpio);
+	update_edge_detect(c);
+}
+
+static struct irq_chip pxa_muxed_gpio_chip = {
+	.name		= "GPIO",
+	.irq_ack	= pxa_ack_muxed_gpio,
+	.irq_mask	= pxa_mask_muxed_gpio,
+	.irq_unmask	= pxa_unmask_muxed_gpio,
+	.irq_set_type	= pxa_gpio_irq_type,
+};
+
+static int __devinit pxa_gpio_nums(void)
+{
+	int count = 0;
+
+#ifdef CONFIG_ARCH_PXA
+	if (cpu_is_pxa25x()) {
+#ifdef CONFIG_CPU_PXA26x
+		count = 89;
+		gpio_type = PXA26X_GPIO;
+#elif defined(CONFIG_PXA25x)
+		count = 84;
+		gpio_type = PXA25X_GPIO;
+#endif	/* CONFIG_CPU_PXA26x */
+	} else if (cpu_is_pxa27x()) {
+		count = 120;
+		gpio_type = PXA27X_GPIO;
+	} else if (cpu_is_pxa93x() || cpu_is_pxa95x()) {
+		count = 191;
+		gpio_type = PXA93X_GPIO;
+	} else if (cpu_is_pxa3xx()) {
+		count = 127;
+		gpio_type = PXA3XX_GPIO;
+	}
+#endif	/* CONFIG_ARCH_PXA */
+
+#ifdef CONFIG_ARCH_MMP
+	if (cpu_is_pxa168() || cpu_is_pxa910()) {
+		count = 127;
+		gpio_type = MMP_GPIO;
+	} else if (cpu_is_mmp2()) {
+		count = 191;
+		gpio_type = MMP2_GPIO;
+	}
+#endif	/* CONFIG_ARCH_MMP */
+
+	return count;
+}
+
+static int __devinit pxa_gpio_probe(struct platform_device *pdev)
+{
+	struct pxa_gpio_chip *c;
+	struct pxa_gpio_irq_data *mux_data;
+	struct resource *res;
+	int gpio, irq;
+	int irq0 = 0, irq1 = 0, irq_mux, gpio_offset = 0;
+
+	pxa_last_gpio = pxa_gpio_nums();
+	if (!pxa_last_gpio)
+		return -EINVAL;
+
+	mux_data = kzalloc(sizeof(struct pxa_gpio_irq_data), GFP_KERNEL);
+	if (mux_data < 0)
+		return -ENOMEM;
+
+	irq0 = platform_get_irq_byname(pdev, "gpio0");
+	irq1 = platform_get_irq_byname(pdev, "gpio1");
+	irq_mux = platform_get_irq_byname(pdev, "gpio_mux");
+	if ((irq0 > 0 && irq1 < 0) || (irq0 < 0 && irq1 > 0) || (irq_mux < 0))
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
+	if (irq0 > 0) {
+		mux_data->irq_gpio0 = irq0;
+		mux_data->irq_gpio1 = irq1;
+		gpio_offset = 2;
+	}
+	mux_data->irq_mux = irq_mux;
+
+	/* Initialize GPIO chips */
+	pxa_init_gpio_chip(pxa_last_gpio, mux_data);
+
+	/* clear all GPIO edge detects */
+	for_each_gpio_chip(gpio, c) {
+		__raw_writel(0, c->regbase + GFER_OFFSET);
+		__raw_writel(0, c->regbase + GRER_OFFSET);
+		__raw_writel(~0,c->regbase + GEDR_OFFSET);
+	}
+
+#ifdef CONFIG_ARCH_PXA
+	if (irq0 > 0) {
+		irq = pxa_gpio_to_irq(0);
+		irq_set_chip_and_handler(irq, &pxa_muxed_gpio_chip,
+					 handle_edge_irq);
+		set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
+		irq_set_chained_handler(irq0, pxa_gpio_demux_handler);
+
+		irq = pxa_gpio_to_irq(1);
+		irq_set_chip_and_handler(irq, &pxa_muxed_gpio_chip,
+					 handle_edge_irq);
+		set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
+		irq_set_chained_handler(irq1, pxa_gpio_demux_handler);
+	}
+#endif	/* CONFIG_ARCH_PXA */
+
+	for (irq = mgpio_to_irq(gpio_offset);
+		irq <= mgpio_to_irq(pxa_last_gpio); irq++) {
+		irq_set_chip_and_handler(irq, &pxa_muxed_gpio_chip,
+					 handle_edge_irq);
+		set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
+	}
+
+	irq_set_chained_handler(irq_mux, pxa_gpio_demux_handler);
+	return 0;
+}
+
+static struct platform_driver pxa_gpio_driver = {
+	.probe		= pxa_gpio_probe,
+	.driver		= {
+		.owner	= THIS_MODULE,
+		.name	= "pxa-gpio",
+	},
+};
+
+static int __init pxa_gpio_init(void)
+{
+	return platform_driver_register(&pxa_gpio_driver);
+}
+postcore_initcall(pxa_gpio_init);
+
+#ifdef CONFIG_PM
+static int pxa_gpio_suspend(void)
+{
+	struct pxa_gpio_chip *c;
+	int gpio;
+
+	for_each_gpio_chip(gpio, c) {
+		c->saved_gplr = __raw_readl(c->regbase + GPLR_OFFSET);
+		c->saved_gpdr = __raw_readl(c->regbase + GPDR_OFFSET);
+		c->saved_grer = __raw_readl(c->regbase + GRER_OFFSET);
+		c->saved_gfer = __raw_readl(c->regbase + GFER_OFFSET);
+
+		/* Clear GPIO transition detect bits */
+		__raw_writel(0xffffffff, c->regbase + GEDR_OFFSET);
+	}
+	return 0;
+}
+
+static void pxa_gpio_resume(void)
+{
+	struct pxa_gpio_chip *c;
+	int gpio;
+
+	for_each_gpio_chip(gpio, c) {
+		/* restore level with set/clear */
+		__raw_writel( c->saved_gplr, c->regbase + GPSR_OFFSET);
+		__raw_writel(~c->saved_gplr, c->regbase + GPCR_OFFSET);
+
+		__raw_writel(c->saved_grer, c->regbase + GRER_OFFSET);
+		__raw_writel(c->saved_gfer, c->regbase + GFER_OFFSET);
+		__raw_writel(c->saved_gpdr, c->regbase + GPDR_OFFSET);
+	}
+}
+#else
+#define pxa_gpio_suspend	NULL
+#define pxa_gpio_resume		NULL
+#endif
+
+struct syscore_ops pxa_gpio_syscore_ops = {
+	.suspend	= pxa_gpio_suspend,
+	.resume		= pxa_gpio_resume,
+};
+
+static int __init pxa_gpio_sysinit(void)
+{
+	register_syscore_ops(&pxa_gpio_syscore_ops);
+	return 0;
+}
+postcore_initcall(pxa_gpio_sysinit);
diff --git a/include/linux/gpio-pxa.h b/include/linux/gpio-pxa.h
new file mode 100644
index 0000000..6ab993b
--- /dev/null
+++ b/include/linux/gpio-pxa.h
@@ -0,0 +1,64 @@
+#ifndef __GPIO_PXA_H
+#define __GPIO_PXA_H
+
+#include <linux/io.h>
+
+/*
+ * We handle the GPIOs by banks, each bank covers up to 32 GPIOs with
+ * one set of registers. The register offsets are organized below:
+ *
+ * GPLR -- GPIO Pin Level Registers
+ * GPDR -- GPIO Pin Direction Registers
+ * GPSR -- GPIO Pin Output Set Registers
+ * GPCR -- GPIO Pin Output Clear Registers
+ * GRER -- GPIO Rising Edge Detect Registers
+ * GFER -- GPIO Falling Edge Detect Registers
+ * GEDR -- GPIO Edge Detect Status Registers
+ *
+ *           GPLR    GPDR    GPSR    GPCR    GRER    GFER    GEDR
+ * BANK 0 - 0x0000  0x000C  0x0018  0x0024  0x0030  0x003C  0x0048
+ * BANK 1 - 0x0004  0x0010  0x001C  0x0028  0x0034  0x0040  0x004C
+ * BANK 2 - 0x0008  0x0014  0x0020  0x002C  0x0038  0x0044  0x0050
+ *
+ * BANK 3 - 0x0100  0x010C  0x0118  0x0124  0x0130  0x013C  0x0148
+ * BANK 4 - 0x0104  0x0110  0x011C  0x0128  0x0134  0x0140  0x014C
+ * BANK 5 - 0x0108  0x0114  0x0120  0x012C  0x0138  0x0144  0x0150
+ *
+ * NOTE:
+ *   BANK 3 is only available on PXA27x and later processors.
+ *   BANK 4 and 5 are only available on PXA935
+ */
+
+#define BANK_OFF(n)	(((n) < 3) ? (n) << 2 : 0x100 + (((n) - 3) << 2))
+
+#define gpio_to_bank(x)	((x) >> 5)
+
+/* More handy macros.  The argument is a literal GPIO number. */
+
+#define GPIO_bit(x)	(1 << ((x) & 0x1f))
+
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
+extern struct pxa_gpio_regs pxa_gpio_regs;
+
+#define GPLR(x)		(*(volatile u32 *)(pxa_gpio_regs.gplr + BANK_OFF((x >> 5))))
+#define GPDR(x)		(*(volatile u32 *)(pxa_gpio_regs.gpdr + BANK_OFF((x >> 5))))
+#define GPSR(x)		(*(volatile u32 *)(pxa_gpio_regs.gpsr + BANK_OFF((x >> 5))))
+#define GPCR(x)		(*(volatile u32 *)(pxa_gpio_regs.gpcr + BANK_OFF((x >> 5))))
+#define GRER(x)		(*(volatile u32 *)(pxa_gpio_regs.grer + BANK_OFF((x >> 5))))
+#define GFER(x)		(*(volatile u32 *)(pxa_gpio_regs.gfer + BANK_OFF((x >> 5))))
+#define GEDR(x)		(*(volatile u32 *)(pxa_gpio_regs.gedr + BANK_OFF((x >> 5))))
+#define GAFR(x)		(*(volatile u32 *)(pxa_gpio_regs.gafr + (((x) & 0x70) >> 2)))
+
+#define GPIO_BANK(n)	(pxa_gpio_regs.gplr + BANK_OFF(n))
+
+#endif	/* __GPIO_PXA_H */
-- 
1.7.2.5
