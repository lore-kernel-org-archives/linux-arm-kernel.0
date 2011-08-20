From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 20 Aug 2011 14:05:59 +0900
Subject: [PATCH 4/4] ARM: EXYNOS4: Use samsung_rev() to distinguish silicon
	revision
In-Reply-To: <1313816759-14564-1-git-send-email-kgene.kim@samsung.com>
References: <1313816759-14564-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1313816759-14564-5-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch uses samsung_rev() to support variable silicon revision of
EXYNOS4210 so that can support for EXYNOS4210 REV0, REV1.0 and REV1.1.

Note: Need to change timer setting on REV0.

Acked-by: Changhwan Youn <chaos.youn@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-exynos4/cpu.c              |   28 +++++++++++++++++++++++-----
 arch/arm/mach-exynos4/include/mach/map.h |    3 ++-
 arch/arm/mach-exynos4/platsmp.c          |    8 ++++++--
 arch/arm/plat-samsung/include/plat/cpu.h |    6 ++++++
 4 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-exynos4/cpu.c b/arch/arm/mach-exynos4/cpu.c
index 2d8a40c..f188c6d 100644
--- a/arch/arm/mach-exynos4/cpu.c
+++ b/arch/arm/mach-exynos4/cpu.c
@@ -43,11 +43,6 @@ static struct map_desc exynos4_iodesc[] __initdata = {
 		.length		= SZ_4K,
 		.type	 	= MT_DEVICE,
 	}, {
-		.virtual	= (unsigned long)S5P_VA_SYSRAM,
-		.pfn		= __phys_to_pfn(EXYNOS4_PA_SYSRAM),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE,
-	}, {
 		.virtual	= (unsigned long)S5P_VA_CMU,
 		.pfn		= __phys_to_pfn(EXYNOS4_PA_CMU),
 		.length		= SZ_128K,
@@ -128,6 +123,24 @@ static void exynos4_idle(void)
 	local_irq_enable();
 }
 
+static struct map_desc exynos4_iodesc0[] __initdata = {
+	{
+		.virtual	= (unsigned long)S5P_VA_SYSRAM,
+		.pfn		= __phys_to_pfn(EXYNOS4_PA_SYSRAM0),
+		.length		= SZ_4K,
+		.type	 	= MT_DEVICE,
+	},
+};
+
+static struct map_desc exynos4_iodesc1[] __initdata = {
+	{
+		.virtual	= (unsigned long)S5P_VA_SYSRAM,
+		.pfn		= __phys_to_pfn(EXYNOS4_PA_SYSRAM1),
+		.length		= SZ_4K,
+		.type	 	= MT_DEVICE,
+	},
+};
+
 /*
  * exynos4_map_io
  *
@@ -137,6 +150,11 @@ void __init exynos4_map_io(void)
 {
 	iotable_init(exynos4_iodesc, ARRAY_SIZE(exynos4_iodesc));
 
+	if (samsung_rev() == EXYNOS4210_REV_0)
+		iotable_init(exynos4_iodesc0, ARRAY_SIZE(exynos4_iodesc0));
+	else if (samsung_rev() == EXYNOS4210_REV_1_0)
+		iotable_init(exynos4_iodesc1, ARRAY_SIZE(exynos4_iodesc1));
+
 	/* initialize device information early */
 	exynos4_default_sdhci0();
 	exynos4_default_sdhci1();
diff --git a/arch/arm/mach-exynos4/include/mach/map.h b/arch/arm/mach-exynos4/include/mach/map.h
index d32296d..7073ac7 100644
--- a/arch/arm/mach-exynos4/include/mach/map.h
+++ b/arch/arm/mach-exynos4/include/mach/map.h
@@ -23,7 +23,8 @@
 
 #include <plat/map-s5p.h>
 
-#define EXYNOS4_PA_SYSRAM		0x02020000
+#define EXYNOS4_PA_SYSRAM0		0x02025000
+#define EXYNOS4_PA_SYSRAM1		0x02020000
 
 #define EXYNOS4_PA_FIMC0		0x11800000
 #define EXYNOS4_PA_FIMC1		0x11810000
diff --git a/arch/arm/mach-exynos4/platsmp.c b/arch/arm/mach-exynos4/platsmp.c
index 7c2282c..96cc651 100644
--- a/arch/arm/mach-exynos4/platsmp.c
+++ b/arch/arm/mach-exynos4/platsmp.c
@@ -30,9 +30,12 @@
 #include <mach/regs-clock.h>
 #include <mach/regs-pmu.h>
 
+#include <plat/cpu.h>
+
 extern void exynos4_secondary_startup(void);
 
-#define CPU1_BOOT_REG S5P_VA_SYSRAM
+#define CPU1_BOOT_REG		(samsung_rev() == EXYNOS4210_REV_1_1 ? \
+				S5P_INFORM5 : S5P_VA_SYSRAM)
 
 /*
  * control for which core is the next to come out of the secondary
@@ -216,5 +219,6 @@ void __init platform_smp_prepare_cpus(unsigned int max_cpus)
 	 * until it receives a soft interrupt, and then the
 	 * secondary CPU branches to this address.
 	 */
-	__raw_writel(BSYM(virt_to_phys(exynos4_secondary_startup)), S5P_VA_SYSRAM);
+	__raw_writel(BSYM(virt_to_phys(exynos4_secondary_startup)),
+			CPU1_BOOT_REG);
 }
diff --git a/arch/arm/plat-samsung/include/plat/cpu.h b/arch/arm/plat-samsung/include/plat/cpu.h
index 16238c8..b0d3d59 100644
--- a/arch/arm/plat-samsung/include/plat/cpu.h
+++ b/arch/arm/plat-samsung/include/plat/cpu.h
@@ -100,6 +100,10 @@ IS_SAMSUNG_CPU(exynos4210, EXYNOS4210_CPU_ID, EXYNOS4_CPU_MASK)
 # define cpu_is_exynos4210()	0
 #endif
 
+#define EXYNOS4210_REV_0	(0x0)
+#define EXYNOS4210_REV_1_0	(0x2)
+#define EXYNOS4210_REV_1_1	(0x3)
+
 #define IODESC_ENT(x) { (unsigned long)S3C24XX_VA_##x, __phys_to_pfn(S3C24XX_PA_##x), S3C24XX_SZ_##x, MT_DEVICE }
 
 #ifndef MHZ
@@ -144,6 +148,8 @@ extern void s3c24xx_init_cpu(void);
 extern void s3c64xx_init_cpu(void);
 extern void s5p_init_cpu(void __iomem *cpuid_addr);
 
+extern unsigned int samsung_rev(void);
+
 extern void s3c24xx_init_uarts(struct s3c2410_uartcfg *cfg, int no);
 
 extern void s3c24xx_init_clocks(int xtal);
-- 
1.7.1
