From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu,  6 May 2010 16:24:20 -0700
Subject: [PATCH 29/34] Davinci: watchdog reset separation across socs
In-Reply-To: <1273188265-12782-1-git-send-email-khilman@deeprootsystems.com>
References: <1273188265-12782-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1273188265-12782-30-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cyril Chemparathy <cyril@ti.com>

The earlier watchdog reset mechanism had a couple of limitations.  First, it
embedded a reference to "davinci_wdt_device" inside common code.  This
forced all derived platforms (da8xx and tnetv107x) to define such a device.
This also would have caused problems in including multiple socs in a single
build due to symbol redefinition.

With this patch, davinci_watchdog_reset() now takes the platform device as an
argument.  The davinci_soc_info struct has been extended to include a reset
function and a watchdog platform_device.  arch_reset() then uses these
elements to reset the system in a SoC specific fashion.

Signed-off-by: Cyril Chemparathy <cyril@ti.com>
Tested-by: Sandeep Paulraj <s-paulraj@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/clock.h               |    1 +
 arch/arm/mach-davinci/common.c              |    3 +++
 arch/arm/mach-davinci/da830.c               |    1 +
 arch/arm/mach-davinci/da850.c               |    1 +
 arch/arm/mach-davinci/devices-da8xx.c       |    4 ++--
 arch/arm/mach-davinci/dm355.c               |    1 +
 arch/arm/mach-davinci/dm365.c               |    1 +
 arch/arm/mach-davinci/dm644x.c              |    1 +
 arch/arm/mach-davinci/dm646x.c              |    1 +
 arch/arm/mach-davinci/include/mach/common.h |    2 ++
 arch/arm/mach-davinci/include/mach/da8xx.h  |    2 ++
 arch/arm/mach-davinci/include/mach/system.h |    5 +++--
 arch/arm/mach-davinci/time.c                |    9 ++++++---
 13 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-davinci/clock.h b/arch/arm/mach-davinci/clock.h
index ce26015..01e3648 100644
--- a/arch/arm/mach-davinci/clock.h
+++ b/arch/arm/mach-davinci/clock.h
@@ -120,6 +120,7 @@ int davinci_set_pllrate(struct pll_data *pll, unsigned int prediv,
 				unsigned int mult, unsigned int postdiv);
 
 extern struct platform_device davinci_wdt_device;
+extern void davinci_watchdog_reset(struct platform_device *);
 
 #endif
 
diff --git a/arch/arm/mach-davinci/common.c b/arch/arm/mach-davinci/common.c
index 94f27cb..f8221c5 100644
--- a/arch/arm/mach-davinci/common.c
+++ b/arch/arm/mach-davinci/common.c
@@ -77,6 +77,9 @@ void __init davinci_common_init(struct davinci_soc_info *soc_info)
 	local_flush_tlb_all();
 	flush_cache_all();
 
+	if (!davinci_soc_info.reset)
+		davinci_soc_info.reset = davinci_watchdog_reset;
+
 	/*
 	 * We want to check CPU revision early for cpu_is_xxxx() macros.
 	 * IO space mapping must be initialized before we can do that.
diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index 68e5233..83879f8 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -1206,6 +1206,7 @@ static struct davinci_soc_info davinci_soc_info_da830 = {
 	.gpio_irq		= IRQ_DA8XX_GPIO0,
 	.serial_dev		= &da8xx_serial_device,
 	.emac_pdata		= &da8xx_emac_pdata,
+	.reset_device		= &da8xx_wdt_device,
 };
 
 void __init da830_init(void)
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 8aefcff..2b6dd59 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -1093,6 +1093,7 @@ static struct davinci_soc_info davinci_soc_info_da850 = {
 	.emac_pdata		= &da8xx_emac_pdata,
 	.sram_dma		= DA8XX_ARM_RAM_BASE,
 	.sram_len		= SZ_8K,
+	.reset_device		= &da8xx_wdt_device,
 };
 
 void __init da850_init(void)
diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index 0a96791..67a6fbc 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -326,7 +326,7 @@ static struct resource da8xx_watchdog_resources[] = {
 	},
 };
 
-struct platform_device davinci_wdt_device = {
+struct platform_device da8xx_wdt_device = {
 	.name		= "watchdog",
 	.id		= -1,
 	.num_resources	= ARRAY_SIZE(da8xx_watchdog_resources),
@@ -335,7 +335,7 @@ struct platform_device davinci_wdt_device = {
 
 int __init da8xx_register_watchdog(void)
 {
-	return platform_device_register(&davinci_wdt_device);
+	return platform_device_register(&da8xx_wdt_device);
 }
 
 static struct resource da8xx_emac_resources[] = {
diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index f91e9a1..0c62a68 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -861,6 +861,7 @@ static struct davinci_soc_info davinci_soc_info_dm355 = {
 	.serial_dev		= &dm355_serial_device,
 	.sram_dma		= 0x00010000,
 	.sram_len		= SZ_32K,
+	.reset_device		= &davinci_wdt_device,
 };
 
 void __init dm355_init_asp1(u32 evt_enable, struct snd_platform_data *pdata)
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index f2b1d93..ed76450 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -1068,6 +1068,7 @@ static struct davinci_soc_info davinci_soc_info_dm365 = {
 	.emac_pdata		= &dm365_emac_pdata,
 	.sram_dma		= 0x00010000,
 	.sram_len		= SZ_32K,
+	.reset_device		= &davinci_wdt_device,
 };
 
 void __init dm365_init_asp(struct snd_platform_data *pdata)
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 85c88ec..7f36c22 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -753,6 +753,7 @@ static struct davinci_soc_info davinci_soc_info_dm644x = {
 	.emac_pdata		= &dm644x_emac_pdata,
 	.sram_dma		= 0x00008000,
 	.sram_len		= SZ_16K,
+	.reset_device		= &davinci_wdt_device,
 };
 
 void __init dm644x_init_asp(struct snd_platform_data *pdata)
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index a8189c9..8dd0afe 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -837,6 +837,7 @@ static struct davinci_soc_info davinci_soc_info_dm646x = {
 	.emac_pdata		= &dm646x_emac_pdata,
 	.sram_dma		= 0x10010000,
 	.sram_len		= SZ_32K,
+	.reset_device		= &davinci_wdt_device,
 };
 
 void __init dm646x_init_mcasp0(struct snd_platform_data *pdata)
diff --git a/arch/arm/mach-davinci/include/mach/common.h b/arch/arm/mach-davinci/include/mach/common.h
index 8ffef5b..a58bd88 100644
--- a/arch/arm/mach-davinci/include/mach/common.h
+++ b/arch/arm/mach-davinci/include/mach/common.h
@@ -70,6 +70,8 @@ struct davinci_soc_info {
 	struct emac_platform_data	*emac_pdata;
 	dma_addr_t			sram_dma;
 	unsigned			sram_len;
+	struct platform_device		*reset_device;
+	void				(*reset)(struct platform_device *);
 };
 
 extern struct davinci_soc_info davinci_soc_info;
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index dbb4ebe..1b31a9a 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -87,6 +87,8 @@ extern struct emac_platform_data da8xx_emac_pdata;
 extern struct da8xx_lcdc_platform_data sharp_lcd035q3dg01_pdata;
 extern struct da8xx_lcdc_platform_data sharp_lk043t1dg01_pdata;
 
+extern struct platform_device da8xx_wdt_device;
+
 extern const short da830_emif25_pins[];
 extern const short da830_spi0_pins[];
 extern const short da830_spi1_pins[];
diff --git a/arch/arm/mach-davinci/include/mach/system.h b/arch/arm/mach-davinci/include/mach/system.h
index 5a7d758..e65629c 100644
--- a/arch/arm/mach-davinci/include/mach/system.h
+++ b/arch/arm/mach-davinci/include/mach/system.h
@@ -11,7 +11,7 @@
 #ifndef __ASM_ARCH_SYSTEM_H
 #define __ASM_ARCH_SYSTEM_H
 
-extern void davinci_watchdog_reset(void);
+#include <mach/common.h>
 
 static inline void arch_idle(void)
 {
@@ -20,7 +20,8 @@ static inline void arch_idle(void)
 
 static inline void arch_reset(char mode, const char *cmd)
 {
-	davinci_watchdog_reset();
+	if (davinci_soc_info.reset)
+		davinci_soc_info.reset(davinci_soc_info.reset_device);
 }
 
 #endif /* __ASM_ARCH_SYSTEM_H */
diff --git a/arch/arm/mach-davinci/time.c b/arch/arm/mach-davinci/time.c
index b21f763..e5c598a 100644
--- a/arch/arm/mach-davinci/time.c
+++ b/arch/arm/mach-davinci/time.c
@@ -399,13 +399,16 @@ struct sys_timer davinci_timer = {
 
 
 /* reset board using watchdog timer */
-void davinci_watchdog_reset(void)
+void davinci_watchdog_reset(struct platform_device *pdev)
 {
 	u32 tgcr, wdtcr;
-	struct platform_device *pdev = &davinci_wdt_device;
-	void __iomem *base = IO_ADDRESS(pdev->resource[0].start);
+	void __iomem *base;
 	struct clk *wd_clk;
 
+	base = ioremap(pdev->resource[0].start, SZ_4K);
+	if (WARN_ON(!base))
+		return;
+
 	wd_clk = clk_get(&pdev->dev, NULL);
 	if (WARN_ON(IS_ERR(wd_clk)))
 		return;
-- 
1.7.0.2
