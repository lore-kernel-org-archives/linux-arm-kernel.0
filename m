From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Wed,  9 Nov 2011 10:47:29 +0800
Subject: [PATCH v7 09/11] ARM: pxa: change gpio to platform device
In-Reply-To: <1320806851-13928-1-git-send-email-haojian.zhuang@marvell.com>
References: <1320806851-13928-1-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1320806851-13928-10-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove most gpio macros and change gpio driver to platform driver.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/Kconfig                           |    2 +
 arch/arm/mach-mmp/aspenite.c               |    1 +
 arch/arm/mach-mmp/avengers_lite.c          |    1 +
 arch/arm/mach-mmp/brownstone.c             |    1 +
 arch/arm/mach-mmp/flint.c                  |    1 +
 arch/arm/mach-mmp/gplugd.c                 |    1 +
 arch/arm/mach-mmp/include/mach/gpio-pxa.h  |   29 ------
 arch/arm/mach-mmp/include/mach/gpio.h      |    3 +-
 arch/arm/mach-mmp/include/mach/mmp2.h      |    2 +
 arch/arm/mach-mmp/include/mach/pxa168.h    |    2 +
 arch/arm/mach-mmp/include/mach/pxa910.h    |    2 +
 arch/arm/mach-mmp/mmp2.c                   |   28 ++++--
 arch/arm/mach-mmp/pxa168.c                 |   29 ++++--
 arch/arm/mach-mmp/pxa910.c                 |   29 ++++--
 arch/arm/mach-mmp/tavorevb.c               |    1 +
 arch/arm/mach-mmp/teton_bga.c              |    1 +
 arch/arm/mach-mmp/ttc_dkb.c                |    1 +
 arch/arm/mach-pxa/devices.c                |   30 ++++++
 arch/arm/mach-pxa/devices.h                |    1 +
 arch/arm/mach-pxa/include/mach/gpio-pxa.h  |  131 ---------------------------
 arch/arm/mach-pxa/include/mach/gpio.h      |    5 +-
 arch/arm/mach-pxa/include/mach/idp.h       |    2 -
 arch/arm/mach-pxa/include/mach/littleton.h |    2 -
 arch/arm/mach-pxa/irq.c                    |    3 +-
 arch/arm/mach-pxa/mfp-pxa2xx.c             |    6 +-
 arch/arm/mach-pxa/pxa25x.c                 |    3 +-
 arch/arm/mach-pxa/pxa27x.c                 |    3 +-
 arch/arm/mach-pxa/pxa3xx.c                 |    6 +-
 arch/arm/mach-pxa/pxa95x.c                 |    3 +-
 arch/arm/plat-pxa/include/plat/gpio-pxa.h  |   45 ---------
 drivers/gpio/Kconfig                       |    6 ++
 drivers/gpio/Makefile                      |    2 +-
 drivers/gpio/gpio-pxa.c                    |  135 +++++++++++++++++++++++++--
 include/linux/gpio-pxa.h                   |   16 ++++
 34 files changed, 271 insertions(+), 262 deletions(-)
 delete mode 100644 arch/arm/mach-mmp/include/mach/gpio-pxa.h
 delete mode 100644 arch/arm/mach-pxa/include/mach/gpio-pxa.h
 delete mode 100644 arch/arm/plat-pxa/include/plat/gpio-pxa.h
 create mode 100644 include/linux/gpio-pxa.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 44789ef..57e16d4 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -591,6 +591,7 @@ config ARCH_MMP
 	select ARCH_REQUIRE_GPIOLIB
 	select CLKDEV_LOOKUP
 	select GENERIC_CLOCKEVENTS
+	select GPIO_PXA
 	select HAVE_SCHED_CLOCK
 	select TICK_ONESHOT
 	select PLAT_PXA
@@ -673,6 +674,7 @@ config ARCH_PXA
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
index 983cfb1..eb07565 100644
--- a/arch/arm/mach-mmp/brownstone.c
+++ b/arch/arm/mach-mmp/brownstone.c
@@ -202,6 +202,7 @@ static void __init brownstone_init(void)
 	/* on-chip devices */
 	mmp2_add_uart(1);
 	mmp2_add_uart(3);
+	platform_device_register(&mmp2_device_gpio);
 	mmp2_add_twsi(1, NULL, ARRAY_AND_SIZE(brownstone_twsi1_info));
 	mmp2_add_sdhost(0, &mmp2_sdh_platdata_mmc0); /* SD/MMC */
 	mmp2_add_sdhost(2, &mmp2_sdh_platdata_mmc2); /* eMMC */
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
index 6915656..933420a 100644
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
deleted file mode 100644
index 0e135a5..0000000
--- a/arch/arm/mach-mmp/include/mach/gpio-pxa.h
+++ /dev/null
@@ -1,29 +0,0 @@
-#ifndef __ASM_MACH_GPIO_PXA_H
-#define __ASM_MACH_GPIO_PXA_H
-
-#include <mach/addr-map.h>
-#include <mach/cputype.h>
-#include <mach/irqs.h>
-
-#define GPIO_REGS_VIRT	(APB_VIRT_BASE + 0x19000)
-
-#define BANK_OFF(n)	(((n) < 3) ? (n) << 2 : 0x100 + (((n) - 3) << 2))
-#define GPIO_REG(x)	(*(volatile u32 *)(GPIO_REGS_VIRT + (x)))
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
-#include <plat/gpio-pxa.h>
-
-#endif /* __ASM_MACH_GPIO_PXA_H */
diff --git a/arch/arm/mach-mmp/include/mach/gpio.h b/arch/arm/mach-mmp/include/mach/gpio.h
index 904466d..13219eb 100644
--- a/arch/arm/mach-mmp/include/mach/gpio.h
+++ b/arch/arm/mach-mmp/include/mach/gpio.h
@@ -3,7 +3,6 @@
 
 #include <asm-generic/gpio.h>
 
-#define __gpio_is_inverted(gpio)	(0)
-#define __gpio_is_occupied(gpio)	(0)
+#include <mach/cputype.h>
 
 #endif /* __ASM_MACH_GPIO_H */
diff --git a/arch/arm/mach-mmp/include/mach/mmp2.h b/arch/arm/mach-mmp/include/mach/mmp2.h
index 2f7b2d3..cba22fe 100644
--- a/arch/arm/mach-mmp/include/mach/mmp2.h
+++ b/arch/arm/mach-mmp/include/mach/mmp2.h
@@ -32,6 +32,8 @@ extern struct pxa_device_desc mmp2_device_sdh3;
 extern struct pxa_device_desc mmp2_device_asram;
 extern struct pxa_device_desc mmp2_device_isram;
 
+extern struct platform_device mmp2_device_gpio;
+
 static inline int mmp2_add_uart(int id)
 {
 	struct pxa_device_desc *d = NULL;
diff --git a/arch/arm/mach-mmp/include/mach/pxa168.h b/arch/arm/mach-mmp/include/mach/pxa168.h
index 7fb568d..f928608 100644
--- a/arch/arm/mach-mmp/include/mach/pxa168.h
+++ b/arch/arm/mach-mmp/include/mach/pxa168.h
@@ -42,6 +42,8 @@ struct pxa168_usb_pdata {
 /* pdata can be NULL */
 int __init pxa168_add_usb_host(struct pxa168_usb_pdata *pdata);
 
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
diff --git a/arch/arm/mach-mmp/mmp2.c b/arch/arm/mach-mmp/mmp2.c
index 5dd1d4a..1ed222d 100644
--- a/arch/arm/mach-mmp/mmp2.c
+++ b/arch/arm/mach-mmp/mmp2.c
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/platform_device.h>
 
 #include <asm/hardware/cache-tauros2.h>
 
@@ -24,7 +25,6 @@
 #include <mach/irqs.h>
 #include <mach/dma.h>
 #include <mach/mfp.h>
-#include <mach/gpio-pxa.h>
 #include <mach/devices.h>
 #include <mach/mmp2.h>
 
@@ -33,8 +33,6 @@
 
 #define MFPR_VIRT_BASE	(APB_VIRT_BASE + 0x1e000)
 
-#define APMASK(i)	(GPIO_REGS_VIRT + BANK_OFF(i) + 0x9c)
-
 static struct mfp_addr_map mmp2_addr_map[] __initdata = {
 
 	MFP_ADDR_X(GPIO0, GPIO58, 0x54),
@@ -101,12 +99,6 @@ static void __init mmp2_init_gpio(void)
 
 	/* enable GPIO clock */
 	__raw_writel(APBC_APBCLK | APBC_FNCLK, APBC_MMP2_GPIO);
-
-	/* unmask GPIO edge detection for all 6 banks -- APMASKx */
-	for (i = 0; i < 6; i++)
-		__raw_writel(0xffffffff, APMASK(i));
-
-	pxa_init_gpio(IRQ_MMP2_GPIO, 0, 167, NULL);
 }
 
 void __init mmp2_init_irq(void)
@@ -230,3 +222,21 @@ MMP2_DEVICE(asram, "asram", -1, NONE, 0xe0000000, 0x4000);
 /* 0xd1000000 ~ 0xd101ffff is reserved for secure processor */
 MMP2_DEVICE(isram, "isram", -1, NONE, 0xd1020000, 0x18000);
 
+struct resource mmp2_resource_gpio[] = {
+	{
+		.start	= 0xd4019000,
+		.end	= 0xd4019fff,
+		.flags	= IORESOURCE_MEM,
+	}, {
+		.start	= IRQ_MMP2_GPIO,
+		.end	= IRQ_MMP2_GPIO,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device mmp2_device_gpio = {
+	.name		= "pxa-gpio",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(mmp2_resource_gpio),
+	.resource	= mmp2_resource_gpio,
+};
diff --git a/arch/arm/mach-mmp/pxa168.c b/arch/arm/mach-mmp/pxa168.c
index 76ca15c..fefdfe5 100644
--- a/arch/arm/mach-mmp/pxa168.c
+++ b/arch/arm/mach-mmp/pxa168.c
@@ -13,6 +13,7 @@
 #include <linux/list.h>
 #include <linux/io.h>
 #include <linux/clk.h>
+#include <linux/platform_device.h>
 
 #include <asm/mach/time.h>
 #include <mach/addr-map.h>
@@ -20,7 +21,6 @@
 #include <mach/regs-apbc.h>
 #include <mach/regs-apmu.h>
 #include <mach/irqs.h>
-#include <mach/gpio-pxa.h>
 #include <mach/dma.h>
 #include <mach/devices.h>
 #include <mach/mfp.h>
@@ -43,20 +43,12 @@ static struct mfp_addr_map pxa168_mfp_addr_map[] __initdata =
 	MFP_ADDR_END,
 };
 
-#define APMASK(i)	(GPIO_REGS_VIRT + BANK_OFF(i) + 0x09c)
-
 static void __init pxa168_init_gpio(void)
 {
 	int i;
 
 	/* enable GPIO clock */
 	__raw_writel(APBC_APBCLK | APBC_FNCLK, APBC_PXA168_GPIO);
-
-	/* unmask GPIO edge detection for all 4 banks - APMASKx */
-	for (i = 0; i < 4; i++)
-		__raw_writel(0xffffffff, APMASK(i));
-
-	pxa_init_gpio(IRQ_PXA168_GPIOX, 0, 127, NULL);
 }
 
 void __init pxa168_init_irq(void)
@@ -174,6 +166,25 @@ PXA168_DEVICE(fb, "pxa168-fb", -1, LCD, 0xd420b000, 0x1c8);
 PXA168_DEVICE(keypad, "pxa27x-keypad", -1, KEYPAD, 0xd4012000, 0x4c);
 PXA168_DEVICE(eth, "pxa168-eth", -1, MFU, 0xc0800000, 0x0fff);
 
+struct resource pxa168_resource_gpio[] = {
+	{
+		.start	= 0xd4019000,
+		.end	= 0xd4019fff,
+		.flags	= IORESOURCE_MEM,
+	}, {
+		.start	= IRQ_PXA168_GPIOX,
+		.end	= IRQ_PXA168_GPIOX,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device pxa168_device_gpio = {
+	.name		= "pxa-gpio",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(pxa168_resource_gpio),
+	.resource	= pxa168_resource_gpio,
+};
+
 struct resource pxa168_usb_host_resources[] = {
 	/* USB Host conroller register base */
 	[0] = {
diff --git a/arch/arm/mach-mmp/pxa910.c b/arch/arm/mach-mmp/pxa910.c
index 4ebbfbb..7b992ce 100644
--- a/arch/arm/mach-mmp/pxa910.c
+++ b/arch/arm/mach-mmp/pxa910.c
@@ -12,6 +12,7 @@
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/io.h>
+#include <linux/platform_device.h>
 
 #include <asm/mach/time.h>
 #include <mach/addr-map.h>
@@ -19,7 +20,6 @@
 #include <mach/regs-apmu.h>
 #include <mach/cputype.h>
 #include <mach/irqs.h>
-#include <mach/gpio-pxa.h>
 #include <mach/dma.h>
 #include <mach/mfp.h>
 #include <mach/devices.h>
@@ -77,20 +77,12 @@ static struct mfp_addr_map pxa910_mfp_addr_map[] __initdata =
 	MFP_ADDR_END,
 };
 
-#define APMASK(i)	(GPIO_REGS_VIRT + BANK_OFF(i) + 0x09c)
-
 static void __init pxa910_init_gpio(void)
 {
 	int i;
 
 	/* enable GPIO clock */
 	__raw_writel(APBC_APBCLK | APBC_FNCLK, APBC_PXA910_GPIO);
-
-	/* unmask GPIO edge detection for all 4 banks - APMASKx */
-	for (i = 0; i < 4; i++)
-		__raw_writel(0xffffffff, APMASK(i));
-
-	pxa_init_gpio(IRQ_PXA910_AP_GPIO, 0, 127, NULL);
 }
 
 void __init pxa910_init_irq(void)
@@ -179,3 +171,22 @@ PXA910_DEVICE(pwm2, "pxa910-pwm", 1, NONE, 0xd401a400, 0x10);
 PXA910_DEVICE(pwm3, "pxa910-pwm", 2, NONE, 0xd401a800, 0x10);
 PXA910_DEVICE(pwm4, "pxa910-pwm", 3, NONE, 0xd401ac00, 0x10);
 PXA910_DEVICE(nand, "pxa3xx-nand", -1, NAND, 0xd4283000, 0x80, 97, 99);
+
+struct resource pxa910_resource_gpio[] = {
+	{
+		.start	= 0xd4019000,
+		.end	= 0xd4019fff,
+		.flags	= IORESOURCE_MEM,
+	}, {
+		.start	= IRQ_PXA910_AP_GPIO,
+		.end	= IRQ_PXA910_AP_GPIO,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device pxa910_device_gpio = {
+	.name		= "pxa-gpio",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(pxa910_resource_gpio),
+	.resource	= pxa910_resource_gpio,
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
 
diff --git a/arch/arm/mach-pxa/devices.c b/arch/arm/mach-pxa/devices.c
index 2e04254..5bc1312 100644
--- a/arch/arm/mach-pxa/devices.c
+++ b/arch/arm/mach-pxa/devices.c
@@ -1051,6 +1051,36 @@ struct platform_device pxa3xx_device_ssp4 = {
 };
 #endif /* CONFIG_PXA3xx || CONFIG_PXA95x */
 
+struct resource pxa_resource_gpio[] = {
+	{
+		.start	= 0x40e00000,
+		.end	= 0x40e0ffff,
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
+	.num_resources	= ARRAY_SIZE(pxa_resource_gpio),
+	.resource	= pxa_resource_gpio,
+};
+
 /* pxa2xx-spi platform-device ID equals respective SSP platform-device ID + 1.
  * See comment in arch/arm/mach-pxa/ssp.c::ssp_probe() */
 void __init pxa2xx_set_spi_info(unsigned id, struct pxa2xx_spi_master *info)
diff --git a/arch/arm/mach-pxa/devices.h b/arch/arm/mach-pxa/devices.h
index 2fd5a8b..1475db1 100644
--- a/arch/arm/mach-pxa/devices.h
+++ b/arch/arm/mach-pxa/devices.h
@@ -16,6 +16,7 @@ extern struct platform_device pxa_device_ficp;
 extern struct platform_device sa1100_device_rtc;
 extern struct platform_device pxa_device_rtc;
 extern struct platform_device pxa_device_ac97;
+extern struct platform_device pxa_device_gpio;
 
 extern struct platform_device pxa27x_device_i2c_power;
 extern struct platform_device pxa27x_device_ohci;
diff --git a/arch/arm/mach-pxa/include/mach/gpio-pxa.h b/arch/arm/mach-pxa/include/mach/gpio-pxa.h
deleted file mode 100644
index 134b3bc..0000000
--- a/arch/arm/mach-pxa/include/mach/gpio-pxa.h
+++ /dev/null
@@ -1,131 +0,0 @@
-/*
- * Written by Philipp Zabel <philipp.zabel@gmail.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- *
- */
-#ifndef __MACH_PXA_GPIO_PXA_H
-#define __MACH_PXA_GPIO_PXA_H
-
-#include <mach/irqs.h>
-#include <mach/hardware.h>
-
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
-
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
-#include <plat/gpio-pxa.h>
-#endif /* __MACH_PXA_GPIO_PXA_H */
diff --git a/arch/arm/mach-pxa/include/mach/gpio.h b/arch/arm/mach-pxa/include/mach/gpio.h
index 561cdbf..0248e43 100644
--- a/arch/arm/mach-pxa/include/mach/gpio.h
+++ b/arch/arm/mach-pxa/include/mach/gpio.h
@@ -25,7 +25,8 @@
 #define __ASM_ARCH_PXA_GPIO_H
 
 #include <asm-generic/gpio.h>
-/* The defines for the driver are needed for the accelerated accessors */
-#include "gpio-pxa.h"
+
+#include <mach/irqs.h>
+#include <mach/hardware.h>
 
 #endif
diff --git a/arch/arm/mach-pxa/include/mach/idp.h b/arch/arm/mach-pxa/include/mach/idp.h
index a7f912f..22a96f8 100644
--- a/arch/arm/mach-pxa/include/mach/idp.h
+++ b/arch/arm/mach-pxa/include/mach/idp.h
@@ -131,8 +131,6 @@
 #define PCC_VS2		(1 << 1)
 #define PCC_VS1		(1 << 0)
 
-#define PCC_DETECT(x)	(GPLR(7 + (x)) & GPIO_bit(7 + (x)))
-
 /* A listing of interrupts used by external hardware devices */
 
 #define TOUCH_PANEL_IRQ			PXA_GPIO_TO_IRQ(5)
diff --git a/arch/arm/mach-pxa/include/mach/littleton.h b/arch/arm/mach-pxa/include/mach/littleton.h
index e20ac1b..8066be5 100644
--- a/arch/arm/mach-pxa/include/mach/littleton.h
+++ b/arch/arm/mach-pxa/include/mach/littleton.h
@@ -1,8 +1,6 @@
 #ifndef __ASM_ARCH_LITTLETON_H
 #define __ASM_ARCH_LITTLETON_H
 
-#include <mach/gpio-pxa.h>
-
 #define LITTLETON_ETH_PHYS	0x30000000
 
 #define LITTLETON_GPIO_LCD_CS	(17)
diff --git a/arch/arm/mach-pxa/irq.c b/arch/arm/mach-pxa/irq.c
index 36c538f..5dae15e 100644
--- a/arch/arm/mach-pxa/irq.c
+++ b/arch/arm/mach-pxa/irq.c
@@ -22,7 +22,6 @@
 
 #include <mach/hardware.h>
 #include <mach/irqs.h>
-#include <mach/gpio-pxa.h>
 
 #include "generic.h"
 
@@ -122,7 +121,7 @@ asmlinkage void __exception_irq_entry ichp_handle_irq(struct pt_regs *regs)
 	} while (1);
 }
 
-void __init pxa_init_irq(int irq_nr, set_wake_t fn)
+void __init pxa_init_irq(int irq_nr, int (*fn)(struct irq_data *, unsigned int))
 {
 	int irq, i, n;
 
diff --git a/arch/arm/mach-pxa/mfp-pxa2xx.c b/arch/arm/mach-pxa/mfp-pxa2xx.c
index 43a5f68..f147755 100644
--- a/arch/arm/mach-pxa/mfp-pxa2xx.c
+++ b/arch/arm/mach-pxa/mfp-pxa2xx.c
@@ -13,6 +13,7 @@
  *  published by the Free Software Foundation.
  */
 #include <linux/gpio.h>
+#include <linux/gpio-pxa.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -20,7 +21,6 @@
 
 #include <mach/pxa2xx-regs.h>
 #include <mach/mfp-pxa2xx.h>
-#include <mach/gpio-pxa.h>
 
 #include "generic.h"
 
@@ -29,6 +29,10 @@
 #define GAFR_L(x)	__GAFR(0, x)
 #define GAFR_U(x)	__GAFR(1, x)
 
+#define BANK_OFF(n)	(((n) < 3) ? (n) << 2 : 0x100 + (((n) - 3) << 2))
+#define GPLR(x)		__REG2(0x40E00000, BANK_OFF((x) >> 5))
+#define GPDR(x)		__REG2(0x40E00000, BANK_OFF((x) >> 5) + 0x0c)
+
 #define PWER_WE35	(1 << 24)
 
 struct gpio_desc {
diff --git a/arch/arm/mach-pxa/pxa25x.c b/arch/arm/mach-pxa/pxa25x.c
index 0f38cfc..91e4f6c 100644
--- a/arch/arm/mach-pxa/pxa25x.c
+++ b/arch/arm/mach-pxa/pxa25x.c
@@ -17,6 +17,7 @@
  * need be.
  */
 #include <linux/gpio.h>
+#include <linux/gpio-pxa.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -312,14 +313,12 @@ set_pwer:
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
 
diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index 44563a0..aed6cbc 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -12,6 +12,7 @@
  * published by the Free Software Foundation.
  */
 #include <linux/gpio.h>
+#include <linux/gpio-pxa.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -386,7 +387,6 @@ static int pxa27x_set_wake(struct irq_data *d, unsigned int on)
 void __init pxa27x_init_irq(void)
 {
 	pxa_init_irq(34, pxa27x_set_wake);
-	pxa_init_gpio(IRQ_GPIO_2_x, 2, 120, pxa27x_set_wake);
 }
 
 static struct map_desc pxa27x_io_desc[] __initdata = {
@@ -422,6 +422,7 @@ void __init pxa27x_set_i2c_power_info(struct i2c_pxa_platform_data *info)
 }
 
 static struct platform_device *devices[] __initdata = {
+	&pxa_device_gpio,
 	&pxa27x_device_udc,
 	&pxa_device_pmu,
 	&pxa_device_i2s,
diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index 0737c59..06cfe34 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -25,7 +25,6 @@
 #include <asm/mach/map.h>
 #include <asm/suspend.h>
 #include <mach/hardware.h>
-#include <mach/gpio-pxa.h>
 #include <mach/pxa3xx-regs.h>
 #include <mach/reset.h>
 #include <mach/ohci.h>
@@ -365,7 +364,8 @@ static struct irq_chip pxa_ext_wakeup_chip = {
 	.irq_set_type	= pxa_set_ext_wakeup_type,
 };
 
-static void __init pxa_init_ext_wakeup_irq(set_wake_t fn)
+static void __init pxa_init_ext_wakeup_irq(int (*fn)(struct irq_data *,
+					   unsigned int))
 {
 	int irq;
 
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
index 51371b3..0961093 100644
--- a/arch/arm/mach-pxa/pxa95x.c
+++ b/arch/arm/mach-pxa/pxa95x.c
@@ -20,7 +20,6 @@
 #include <linux/syscore_ops.h>
 
 #include <mach/hardware.h>
-#include <mach/gpio-pxa.h>
 #include <mach/pxa3xx-regs.h>
 #include <mach/pxa930.h>
 #include <mach/reset.h>
@@ -235,7 +234,6 @@ static struct clk_lookup pxa95x_clkregs[] = {
 void __init pxa95x_init_irq(void)
 {
 	pxa_init_irq(96, NULL);
-	pxa_init_gpio(IRQ_GPIO_2_x, 2, 127, NULL);
 }
 
 /*
@@ -248,6 +246,7 @@ void __init pxa95x_set_i2c_power_info(struct i2c_pxa_platform_data *info)
 }
 
 static struct platform_device *devices[] __initdata = {
+	&pxa_device_gpio,
 	&sa1100_device_rtc,
 	&pxa_device_rtc,
 	&pxa27x_device_ssp1,
diff --git a/arch/arm/plat-pxa/include/plat/gpio-pxa.h b/arch/arm/plat-pxa/include/plat/gpio-pxa.h
deleted file mode 100644
index 15bf9be..0000000
--- a/arch/arm/plat-pxa/include/plat/gpio-pxa.h
+++ /dev/null
@@ -1,45 +0,0 @@
-#ifndef __PLAT_PXA_GPIO_H
-#define __PLAT_PXA_GPIO_H
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
-/* NOTE: some PXAs have fewer on-chip GPIOs (like PXA255, with 85).
- * Those cases currently cause holes in the GPIO number space, the
- * actual number of the last GPIO is recorded by 'pxa_last_gpio'.
- */
-extern int pxa_last_gpio;
-
-typedef int (*set_wake_t)(struct irq_data *d, unsigned int on);
-
-extern void pxa_init_gpio(int mux_irq, int start, int end, set_wake_t fn);
-extern int pxa_irq_to_gpio(int irq);
-
-#endif /* __PLAT_PXA_GPIO_H */
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 8482a23..aa0b94f 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -141,6 +141,12 @@ config GPIO_PL061
 	help
 	  Say yes here to support the PrimeCell PL061 GPIO device
 
+config GPIO_PXA
+	bool "PXA GPIO support"
+	depends on ARCH_PXA || ARCH_MMP
+	help
+	  Say yes here to support the PXA GPIO device
+
 config GPIO_XILINX
 	bool "Xilinx GPIO support"
 	depends on PPC_OF || MICROBLAZE
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index dbcb0bc..5b2b9e2 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -40,7 +40,7 @@ obj-$(CONFIG_GPIO_PCA953X)	+= gpio-pca953x.o
 obj-$(CONFIG_GPIO_PCF857X)	+= gpio-pcf857x.o
 obj-$(CONFIG_GPIO_PCH)		+= gpio-pch.o
 obj-$(CONFIG_GPIO_PL061)	+= gpio-pl061.o
-obj-$(CONFIG_PLAT_PXA)		+= gpio-pxa.o
+obj-$(CONFIG_GPIO_PXA)		+= gpio-pxa.o
 obj-$(CONFIG_GPIO_RDC321X)	+= gpio-rdc321x.o
 obj-$(CONFIG_PLAT_SAMSUNG)	+= gpio-samsung.o
 obj-$(CONFIG_ARCH_SA1100)	+= gpio-sa1100.o
diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index 31d2da4..079f97f 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -12,13 +12,42 @@
  *  published by the Free Software Foundation.
  */
 #include <linux/gpio.h>
+#include <linux/gpio-pxa.h>
 #include <linux/init.h>
 #include <linux/irq.h>
 #include <linux/io.h>
+#include <linux/platform_device.h>
 #include <linux/syscore_ops.h>
 #include <linux/slab.h>
 
-#include <mach/gpio-pxa.h>
+/*
+ * We handle the GPIOs by banks, each bank covers up to 32 GPIOs with
+ * one set of registers. The register offsets are organized below:
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
+#define GPLR_OFFSET	0x00
+#define GPDR_OFFSET	0x0C
+#define GPSR_OFFSET	0x18
+#define GPCR_OFFSET	0x24
+#define GRER_OFFSET	0x30
+#define GFER_OFFSET	0x3C
+#define GEDR_OFFSET	0x48
+#define GAFR_OFFSET	0x54
+
+#define BANK_OFF(n)	(((n) < 3) ? (n) << 2 : 0x100 + (((n) - 3) << 2))
 
 int pxa_last_gpio;
 
@@ -52,6 +81,7 @@ enum {
 static DEFINE_SPINLOCK(gpio_lock);
 static struct pxa_gpio_chip *pxa_gpio_chips;
 static int gpio_type;
+static void __iomem *gpio_reg_base;
 
 #define for_each_gpio_chip(i, c)			\
 	for (i = 0, c = &pxa_gpio_chips[0]; i <= pxa_last_gpio; i += 32, c++)
@@ -76,6 +106,53 @@ static inline int gpio_is_mmp_type(int type)
 	return (type & MMP_GPIO) != 0;
 }
 
+/* GPIO86/87/88/89 on PXA26x have their direction bits in PXA_GPDR(2 inverted,
+ * as well as their Alternate Function value being '1' for GPIO in GAFRx.
+ */
+static inline int __gpio_is_inverted(int gpio)
+{
+	if ((gpio_type == PXA26X_GPIO) && (gpio > 85))
+		return 1;
+	return 0;
+}
+
+/*
+ * On PXA25x and PXA27x, GAFRx and GPDRx together decide the alternate
+ * function of a GPIO, and GPDRx cannot be altered once configured. It
+ * is attributed as "occupied" here (I know this terminology isn't
+ * accurate, you are welcome to propose a better one :-)
+ */
+static inline int __gpio_is_occupied(unsigned gpio)
+{
+	struct pxa_gpio_chip *pxachip;
+	void __iomem *base;
+	unsigned long gafr = 0, gpdr = 0;
+	int ret, af = 0, dir = 0;
+
+	pxachip = gpio_to_pxachip(gpio);
+	base = gpio_chip_base(&pxachip->chip);
+	gpdr = readl_relaxed(base + GPDR_OFFSET);
+
+	switch (gpio_type) {
+	case PXA25X_GPIO:
+	case PXA26X_GPIO:
+	case PXA27X_GPIO:
+		gafr = readl_relaxed(base + GAFR_OFFSET);
+		af = (gafr >> ((gpio & 0xf) * 2)) & 0x3;
+		dir = gpdr & GPIO_bit(gpio);
+
+		if (__gpio_is_inverted(gpio))
+			ret = (af != 1) || (dir == 0);
+		else
+			ret = (af != 0) || (dir != 0);
+		break;
+	default:
+		ret = gpdr & GPIO_bit(gpio);
+		break;
+	}
+	return ret;
+}
+
 #ifdef CONFIG_ARCH_PXA
 static inline int __pxa_gpio_to_irq(int gpio)
 {
@@ -187,7 +264,7 @@ static void pxa_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 				(value ? GPSR_OFFSET : GPCR_OFFSET));
 }
 
-static int __init pxa_init_gpio_chip(int gpio_end)
+static int __devinit pxa_init_gpio_chip(int gpio_end)
 {
 	int i, gpio, nbanks = gpio_to_bank(gpio_end) + 1;
 	struct pxa_gpio_chip *chips;
@@ -202,7 +279,7 @@ static int __init pxa_init_gpio_chip(int gpio_end)
 		struct gpio_chip *c = &chips[i].chip;
 
 		sprintf(chips[i].label, "gpio-%d", i);
-		chips[i].regbase = GPIO_BANK(i);
+		chips[i].regbase = gpio_reg_base + BANK_OFF(i);
 
 		c->base  = gpio;
 		c->label = chips[i].label;
@@ -384,17 +461,35 @@ static int pxa_gpio_nums(void)
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
-		return;
+		return -EINVAL;
+
+	irq0 = platform_get_irq_byname(pdev, "gpio0");
+	irq1 = platform_get_irq_byname(pdev, "gpio1");
+	irq_mux = platform_get_irq_byname(pdev, "gpio_mux");
+	if ((irq0 > 0 && irq1 <= 0) || (irq0 <= 0 && irq1 > 0)
+		|| (irq_mux <= 0))
+		return -EINVAL;
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -EINVAL;
+	gpio_reg_base = ioremap(res->start, resource_size(res));
+	if (!gpio_reg_base)
+		return -EINVAL;
+
+	if (irq0 > 0)
+		gpio_offset = 2;
 
 	/* Initialize GPIO chips */
-	pxa_init_gpio_chip(end);
+	pxa_init_gpio_chip(pxa_last_gpio);
 
 	/* clear all GPIO edge detects */
 	for_each_gpio_chip(gpio, c) {
@@ -417,16 +512,29 @@ void __init pxa_init_gpio(int mux_irq, int start, int end, set_wake_t fn)
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
+}
+
+static struct platform_driver pxa_gpio_driver = {
+	.probe		= pxa_gpio_probe,
+	.driver		= {
+		.name	= "pxa-gpio",
+	},
+};
+
+static int __init pxa_gpio_init(void)
+{
+	return platform_driver_register(&pxa_gpio_driver);
 }
+postcore_initcall(pxa_gpio_init);
 
 #ifdef CONFIG_PM
 static int pxa_gpio_suspend(void)
@@ -470,3 +578,10 @@ struct syscore_ops pxa_gpio_syscore_ops = {
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
diff --git a/include/linux/gpio-pxa.h b/include/linux/gpio-pxa.h
new file mode 100644
index 0000000..05071ee
--- /dev/null
+++ b/include/linux/gpio-pxa.h
@@ -0,0 +1,16 @@
+#ifndef __GPIO_PXA_H
+#define __GPIO_PXA_H
+
+#define GPIO_bit(x)	(1 << ((x) & 0x1f))
+
+#define gpio_to_bank(gpio)	((gpio) >> 5)
+
+/* NOTE: some PXAs have fewer on-chip GPIOs (like PXA255, with 85).
+ * Those cases currently cause holes in the GPIO number space, the
+ * actual number of the last GPIO is recorded by 'pxa_last_gpio'.
+ */
+extern int pxa_last_gpio;
+
+extern int pxa_irq_to_gpio(int irq);
+
+#endif /* __GPIO_PXA_H */
-- 
1.7.4.1
