From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 17 Jun 2013 18:33:51 +0200
Subject: [PATCH v2 06/38] ARM: EXYNOS: common: Remove legacy UART
 initialization code
In-Reply-To: <1371486863-12398-1-git-send-email-t.figa@samsung.com>
References: <1371486863-12398-1-git-send-email-t.figa@samsung.com>
Message-ID: <1371486863-12398-7-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes legacy UART initialization code that was used to
set up UART platform devices when booting with ATAGS, which is not
supported on Exynos any more.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/common.c | 17 -----------------
 arch/arm/plat-samsung/init.c  |  8 +++++---
 2 files changed, 5 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index 488d9bd..598e4b8 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -69,7 +69,6 @@ static const char name_exynos5440[] = "EXYNOS5440";
 static void exynos4_map_io(void);
 static void exynos5_map_io(void);
 static void exynos5440_map_io(void);
-static void exynos4_init_uarts(struct s3c2410_uartcfg *cfg, int no);
 static int exynos_init(void);
 
 unsigned long xxti_f = 0, xusbxti_f = 0;
@@ -79,21 +78,18 @@ static struct cpu_table cpu_ids[] __initdata = {
 		.idcode		= EXYNOS4210_CPU_ID,
 		.idmask		= EXYNOS4_CPU_MASK,
 		.map_io		= exynos4_map_io,
-		.init_uarts	= exynos4_init_uarts,
 		.init		= exynos_init,
 		.name		= name_exynos4210,
 	}, {
 		.idcode		= EXYNOS4212_CPU_ID,
 		.idmask		= EXYNOS4_CPU_MASK,
 		.map_io		= exynos4_map_io,
-		.init_uarts	= exynos4_init_uarts,
 		.init		= exynos_init,
 		.name		= name_exynos4212,
 	}, {
 		.idcode		= EXYNOS4412_CPU_ID,
 		.idmask		= EXYNOS4_CPU_MASK,
 		.map_io		= exynos4_map_io,
-		.init_uarts	= exynos4_init_uarts,
 		.init		= exynos_init,
 		.name		= name_exynos4412,
 	}, {
@@ -602,16 +598,3 @@ static int __init exynos_init(void)
 
 	return device_register(&exynos4_dev);
 }
-
-/* uart registration process */
-
-static void __init exynos4_init_uarts(struct s3c2410_uartcfg *cfg, int no)
-{
-	struct s3c2410_uartcfg *tcfg = cfg;
-	u32 ucnt;
-
-	for (ucnt = 0; ucnt < no; ucnt++, tcfg++)
-		tcfg->has_fracval = 1;
-
-	s3c24xx_init_uartdevs("exynos4210-uart", exynos4_uart_resources, cfg, no);
-}
diff --git a/arch/arm/plat-samsung/init.c b/arch/arm/plat-samsung/init.c
index 79d10fc..3e5c461 100644
--- a/arch/arm/plat-samsung/init.c
+++ b/arch/arm/plat-samsung/init.c
@@ -87,7 +87,7 @@ void __init s3c24xx_init_clocks(int xtal)
 }
 
 /* uart management */
-
+#if IS_ENABLED(CONFIG_SAMSUNG_ATAGS)
 static int nr_uarts __initdata = 0;
 
 static struct s3c2410_uartcfg uart_cfgs[CONFIG_SERIAL_SAMSUNG_UARTS];
@@ -134,11 +134,12 @@ void __init s3c24xx_init_uarts(struct s3c2410_uartcfg *cfg, int no)
 	if (cpu == NULL)
 		return;
 
-	if (cpu->init_uarts == NULL) {
+	if (cpu->init_uarts == NULL && IS_ENABLED(CONFIG_SAMSUNG_ATAGS)) {
 		printk(KERN_ERR "s3c24xx_init_uarts: cpu has no uart init\n");
 	} else
 		(cpu->init_uarts)(cfg, no);
 }
+#endif
 
 static int __init s3c_arch_init(void)
 {
@@ -152,8 +153,9 @@ static int __init s3c_arch_init(void)
 	ret = (cpu->init)();
 	if (ret != 0)
 		return ret;
-
+#if IS_ENABLED(CONFIG_SAMSUNG_ATAGS)
 	ret = platform_add_devices(s3c24xx_uart_devs, nr_uarts);
+#endif
 	return ret;
 }
 
-- 
1.8.2.1
