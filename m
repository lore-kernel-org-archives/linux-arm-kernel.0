From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 11 Aug 2010 14:03:56 +0200
Subject: [PATCH 7/9] ARM: S5PV210: convert framebuffer to device-table
In-Reply-To: <1281528238-7298-1-git-send-email-m.szyprowski@samsung.com>
References: <1281528238-7298-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1281528238-7298-8-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert s3c-fb platform device initialization to device-table approach.
The conversion is performed only for S5PV210 SoC.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv210/Kconfig           |    3 +-
 arch/arm/mach-s5pv210/dev-table.c       |    8 +++++
 arch/arm/mach-s5pv210/mach-aquila.c     |    5 +---
 arch/arm/mach-s5pv210/mach-goni.c       |    5 +---
 arch/arm/plat-samsung/dev-fb.c          |   44 ++++++------------------------
 arch/arm/plat-samsung/dev_templates.c   |    2 +
 arch/arm/plat-samsung/include/plat/fb.h |    9 ++++++
 7 files changed, 31 insertions(+), 45 deletions(-)

diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
index 7b59855..734c0b7 100644
--- a/arch/arm/mach-s5pv210/Kconfig
+++ b/arch/arm/mach-s5pv210/Kconfig
@@ -33,6 +33,7 @@ config S5PV210_SETUP_IDE
 	  Common setup code for S5PV210 IDE GPIO configurations
 
 config S5PV210_SETUP_FB_24BPP
+	select S3C_DEV_FB
 	bool
 	help
           Common setup code for S5PV210 with an 24bpp RGB display helper.
@@ -77,7 +78,6 @@ config MACH_AQUILA
 	bool "Aquila"
 	select CPU_S5PV210
 	select ARCH_SPARSEMEM_ENABLE
-	select S3C_DEV_FB
 	select S5P_DEV_FIMC0
 	select S5P_DEV_FIMC1
 	select S5P_DEV_FIMC2
@@ -92,7 +92,6 @@ config MACH_GONI
 	bool "GONI"
 	select CPU_S5PV210
 	select ARCH_SPARSEMEM_ENABLE
-	select S3C_DEV_FB
 	select S5P_DEV_FIMC0
 	select S5P_DEV_FIMC1
 	select S5P_DEV_FIMC2
diff --git a/arch/arm/mach-s5pv210/dev-table.c b/arch/arm/mach-s5pv210/dev-table.c
index 86f3792..b88b43d 100644
--- a/arch/arm/mach-s5pv210/dev-table.c
+++ b/arch/arm/mach-s5pv210/dev-table.c
@@ -99,6 +99,14 @@ struct s3c_pdev_table s5pv210_dev_table[] __initdata = {
 		.res	= {S5PV210_PA_HSMMC(2), IRQ_HSMMC2},
 		.defpdata = s5pv210_hsmmc2_def_platdata_p,
 	}, {
+		.type	= SAMSUNG_DEVICE_FB,
+		.index	= -1,
+		.name	= "s3c-fb",
+		.res	= {
+			S5PV210_PA_FB,
+			IRQ_LCD_VSYNC, IRQ_LCD_FIFO, IRQ_LCD_SYSTEM,
+		},
+	}, {
 		.type	= SAMSUNG_DEVICE_ONENAND,
 		.name	= "s5pc110-onenand",
 		.index	= -1,
diff --git a/arch/arm/mach-s5pv210/mach-aquila.c b/arch/arm/mach-s5pv210/mach-aquila.c
index c4f5261..cb79256 100644
--- a/arch/arm/mach-s5pv210/mach-aquila.c
+++ b/arch/arm/mach-s5pv210/mach-aquila.c
@@ -475,13 +475,13 @@ static void aquila_setup_sdhci(void)
 static struct platform_device *aquila_devices[] __initdata = {
 	&aquila_i2c_gpio_pmic,
 	&aquila_device_gpiokeys,
-	&s3c_device_fb,
 	&s5p_device_fimc0,
 	&s5p_device_fimc1,
 	&s5p_device_fimc2,
 };
 
 static struct s3c_devtable aquila_devtable[] __initdata = {
+	{ .type = SAMSUNG_DEVICE_FB,		.index = -1, .pdata = &aquila_lcd_pdata},
 	{ .type = SAMSUNG_DEVICE_ONENAND,	.index = -1 },
 	{ .type = SAMSUNG_DEVICE_SDHCI,		.index = 0, .pdata = &aquila_hsmmc0_data},
 	{ .type = SAMSUNG_DEVICE_SDHCI,		.index = 1, .pdata = &aquila_hsmmc1_data},
@@ -508,9 +508,6 @@ static void __init aquila_machine_init(void)
 	s3c_fimc_setname(1, "s5p-fimc");
 	s3c_fimc_setname(2, "s5p-fimc");
 
-	/* FB */
-	s3c_fb_set_platdata(&aquila_lcd_pdata);
-
 	platform_add_devices(aquila_devices, ARRAY_SIZE(aquila_devices));
 	samsung_add_devices(aquila_devtable, ARRAY_SIZE(aquila_devtable));
 }
diff --git a/arch/arm/mach-s5pv210/mach-goni.c b/arch/arm/mach-s5pv210/mach-goni.c
index 9c9f6ca..23814cd 100644
--- a/arch/arm/mach-s5pv210/mach-goni.c
+++ b/arch/arm/mach-s5pv210/mach-goni.c
@@ -452,7 +452,6 @@ static void goni_setup_sdhci(void)
 };
 
 static struct platform_device *goni_devices[] __initdata = {
-	&s3c_device_fb,
 	&goni_i2c_gpio_pmic,
 	&goni_device_gpiokeys,
 	&s5p_device_fimc0,
@@ -461,6 +460,7 @@ static struct platform_device *goni_devices[] __initdata = {
 };
 
 static struct s3c_devtable goni_devtable[] __initdata = {
+	{ .type = SAMSUNG_DEVICE_FB,	.index = -1, .pdata = &goni_lcd_pdata},
 	{ .type = SAMSUNG_DEVICE_ONENAND, .index = -1, },
 	{ .type = SAMSUNG_DEVICE_SDHCI, .index = 0, .pdata = &goni_hsmmc0_data},
 	{ .type = SAMSUNG_DEVICE_SDHCI,	.index = 1, .pdata = &goni_hsmmc1_data},
@@ -483,9 +483,6 @@ static void __init goni_machine_init(void)
 	/* SDHCI */
 	goni_setup_sdhci();
 
-	/* FB */
-	s3c_fb_set_platdata(&goni_lcd_pdata);
-
 	platform_add_devices(goni_devices, ARRAY_SIZE(goni_devices));
 	samsung_add_devices(goni_devtable, ARRAY_SIZE(goni_devtable));
 }
diff --git a/arch/arm/plat-samsung/dev-fb.c b/arch/arm/plat-samsung/dev-fb.c
index bf60204..dc604c3 100644
--- a/arch/arm/plat-samsung/dev-fb.c
+++ b/arch/arm/plat-samsung/dev-fb.c
@@ -17,57 +17,31 @@
 #include <linux/fb.h>
 #include <linux/gfp.h>
 
-#include <mach/irqs.h>
-#include <mach/map.h>
-
 #include <plat/fb.h>
 #include <plat/devs.h>
-#include <plat/cpu.h>
+#include <plat/dev-core.h>
 
-static struct resource s3c_fb_resource[] = {
+static struct resource s3c_fb_resources[] __initdata = {
 	[0] = {
-		.start = S3C_PA_FB,
-		.end   = S3C_PA_FB + SZ_16K - 1,
+		.end   = SZ_16K - 1,
 		.flags = IORESOURCE_MEM,
 	},
 	[1] = {
-		.start = IRQ_LCD_VSYNC,
-		.end   = IRQ_LCD_VSYNC,
 		.flags = IORESOURCE_IRQ,
 	},
 	[2] = {
-		.start = IRQ_LCD_FIFO,
-		.end   = IRQ_LCD_FIFO,
 		.flags = IORESOURCE_IRQ,
 	},
 	[3] = {
-		.start = IRQ_LCD_SYSTEM,
-		.end   = IRQ_LCD_SYSTEM,
 		.flags = IORESOURCE_IRQ,
 	},
 };
 
-struct platform_device s3c_device_fb = {
-	.name		  = "s3c-fb",
-	.id		  = -1,
-	.num_resources	  = ARRAY_SIZE(s3c_fb_resource),
-	.resource	  = s3c_fb_resource,
-	.dev.dma_mask	  = &s3c_device_fb.dev.coherent_dma_mask,
-	.dev.coherent_dma_mask = 0xffffffffUL,
+struct s3c_pdev_template s3c_fb_template __initdata = {
+	.type = SAMSUNG_DEVICE_FB,
+	.resources = s3c_fb_resources,
+	.nr_res	= ARRAY_SIZE(s3c_fb_resources),
+	.pdata_size = sizeof(struct s3c_fb_platdata),
+	.dma = &samsung_std_dma_mask,
 };
 
-void __init s3c_fb_set_platdata(struct s3c_fb_platdata *pd)
-{
-	struct s3c_fb_platdata *npd;
-
-	if (!pd) {
-		printk(KERN_ERR "%s: no platform data\n", __func__);
-		return;
-	}
-
-	npd = kmemdup(pd, sizeof(struct s3c_fb_platdata), GFP_KERNEL);
-	if (!npd)
-		printk(KERN_ERR "%s: no memory for platform data\n", __func__);
-
-	s3c_device_fb.dev.platform_data = npd;
-}
diff --git a/arch/arm/plat-samsung/dev_templates.c b/arch/arm/plat-samsung/dev_templates.c
index 922c6e9..be06c19 100644
--- a/arch/arm/plat-samsung/dev_templates.c
+++ b/arch/arm/plat-samsung/dev_templates.c
@@ -22,6 +22,7 @@
 #include <plat/cpu.h>
 
 #include <plat/uart.h>
+#include <plat/fb.h>
 #include <plat/sdhci.h>
 
 #define TEMPLATE_ENTRY(_type, _res) \
@@ -45,6 +46,7 @@ static struct s3c_pdev_template *templates[] __initdata = {
 	s3c24xx_uart_template_p,
 	s3c64xx_uart_template_p,
 	s3c_hsmmc_template_p,
+	s3c_fb_template_p,
 };
 
 u64 samsung_std_dma_mask = 0xffffffffUL;
diff --git a/arch/arm/plat-samsung/include/plat/fb.h b/arch/arm/plat-samsung/include/plat/fb.h
index 27d3b49..6e64cb8 100644
--- a/arch/arm/plat-samsung/include/plat/fb.h
+++ b/arch/arm/plat-samsung/include/plat/fb.h
@@ -15,6 +15,8 @@
 #ifndef __PLAT_S3C_FB_H
 #define __PLAT_S3C_FB_H __FILE__
 
+#include <linux/fb.h>
+
 /* S3C_FB_MAX_WIN
  * Set to the maximum number of windows that any of the supported hardware
  * can use. Since the platform data uses this for an array size, having it
@@ -91,4 +93,11 @@ extern void s5pc100_fb_gpio_setup_24bpp(void);
  */
 extern void s5pv210_fb_gpio_setup_24bpp(void);
 
+#ifdef CONFIG_S3C_DEV_FB
+extern struct s3c_pdev_template s3c_fb_template;
+#define s3c_fb_template_p (&s3c_fb_template)
+#else
+#define s3c_fb_template_p NULL
+#endif
+
 #endif /* __PLAT_S3C_FB_H */
-- 
1.7.1.569.g6f426
