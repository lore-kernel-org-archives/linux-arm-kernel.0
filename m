From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Tue, 07 Jan 2014 18:29:00 +0530
Subject: [PATCH V2 02/10] ARM: EXYNOS: initial board support for exynos5260 SoC
In-Reply-To: <1389099548-14649-1-git-send-email-rahul.sharma@samsung.com>
References: <1389099548-14649-1-git-send-email-rahul.sharma@samsung.com>
Message-ID: <1389099548-14649-3-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Pankaj Dubey <pankaj.dubey@samsung.com>

This patch add basic arch side support for exynos5260 SoC.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Arun Kumar K <arun.kk@samsung.com>
Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
---
 arch/arm/mach-exynos/Kconfig                 |    9 +++++++++
 arch/arm/mach-exynos/common.c                |   19 ++++++++++++++++++-
 arch/arm/mach-exynos/include/mach/map.h      |    1 +
 arch/arm/mach-exynos/mach-exynos5-dt.c       |    1 +
 arch/arm/plat-samsung/include/plat/cpu.h     |    8 ++++++++
 arch/arm/plat-samsung/include/plat/map-s5p.h |    1 +
 6 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 35c335d..60cbf03 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -101,6 +101,15 @@ config SOC_EXYNOS5410
 	help
 	  Enable EXYNOS5410 SoC support
 
+config SOC_EXYNOS5260
+	bool "SAMSUNG EXYNOS5260"
+	default y
+	depends on ARCH_EXYNOS5
+	select AUTO_ZRELADDR
+	select SAMSUNG_DMADEV
+	help
+	  Enable EXYNOS5260 SoC support
+
 config SOC_EXYNOS5420
 	bool "SAMSUNG EXYNOS5420"
 	default y
diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index 09e6898..e0c7108 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -52,6 +52,7 @@ static const char name_exynos4210[] = "EXYNOS4210";
 static const char name_exynos4212[] = "EXYNOS4212";
 static const char name_exynos4412[] = "EXYNOS4412";
 static const char name_exynos5250[] = "EXYNOS5250";
+static const char name_exynos5260[] = "EXYNOS5260";
 static const char name_exynos5410[] = "EXYNOS5410";
 static const char name_exynos5420[] = "EXYNOS5420";
 static const char name_exynos5440[] = "EXYNOS5440";
@@ -92,6 +93,12 @@ static struct cpu_table cpu_ids[] __initdata = {
 		.init		= exynos_init,
 		.name		= name_exynos5410,
 	}, {
+		.idcode		= EXYNOS5260_SOC_ID,
+		.idmask		= EXYNOS5_SOC_MASK,
+		.map_io		= exynos5_map_io,
+		.init		= exynos_init,
+		.name		= name_exynos5260,
+	}, {
 		.idcode		= EXYNOS5420_SOC_ID,
 		.idmask		= EXYNOS5_SOC_MASK,
 		.map_io		= exynos5_map_io,
@@ -279,6 +286,15 @@ static struct map_desc exynos5_iodesc[] __initdata = {
 	},
 };
 
+static struct map_desc exynos5260_iodesc[] __initdata = {
+	{
+		.virtual	= (unsigned long)S5P_VA_SYSRAM_NS,
+		.pfn		= __phys_to_pfn(EXYNOS5260_PA_SYSRAM_NS),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	},
+};
+
 void exynos4_restart(enum reboot_mode mode, const char *cmd)
 {
 	__raw_writel(0x1, S5P_SWRESET);
@@ -387,9 +403,10 @@ static void __init exynos4_map_io(void)
 static void __init exynos5_map_io(void)
 {
 	iotable_init(exynos5_iodesc, ARRAY_SIZE(exynos5_iodesc));
-
 	if (soc_is_exynos5250())
 		iotable_init(exynos5250_iodesc, ARRAY_SIZE(exynos5250_iodesc));
+	if (soc_is_exynos5260())
+		iotable_init(exynos5260_iodesc, ARRAY_SIZE(exynos5260_iodesc));
 	if (soc_is_exynos5410())
 		iotable_init(exynos5410_iodesc, ARRAY_SIZE(exynos5410_iodesc));
 }
diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
index 894f431..188bb78 100644
--- a/arch/arm/mach-exynos/include/mach/map.h
+++ b/arch/arm/mach-exynos/include/mach/map.h
@@ -30,6 +30,7 @@
 #define EXYNOS4x12_PA_SYSRAM_NS		0x0204F000
 #define EXYNOS5250_PA_SYSRAM_NS		0x0204F000
 #define EXYNOS5410_PA_SYSRAM_NS		0x02073000
+#define EXYNOS5260_PA_SYSRAM_NS		0x02073000
 
 #define EXYNOS_PA_CHIPID		0x10000000
 
diff --git a/arch/arm/mach-exynos/mach-exynos5-dt.c b/arch/arm/mach-exynos/mach-exynos5-dt.c
index 9bb6eac..7d3838a 100644
--- a/arch/arm/mach-exynos/mach-exynos5-dt.c
+++ b/arch/arm/mach-exynos/mach-exynos5-dt.c
@@ -50,6 +50,7 @@ static void __init exynos5_dt_machine_init(void)
 
 static char const *exynos5_dt_compat[] __initdata = {
 	"samsung,exynos5250",
+	"samsung,exynos5260",
 	"samsung,exynos5410",
 	"samsung,exynos5420",
 	"samsung,exynos5440",
diff --git a/arch/arm/plat-samsung/include/plat/cpu.h b/arch/arm/plat-samsung/include/plat/cpu.h
index 8f09488..4daa9b3 100644
--- a/arch/arm/plat-samsung/include/plat/cpu.h
+++ b/arch/arm/plat-samsung/include/plat/cpu.h
@@ -46,6 +46,7 @@ extern unsigned long samsung_cpu_id;
 #define EXYNOS4_CPU_MASK	0xFFFE0000
 
 #define EXYNOS5250_SOC_ID	0x43520000
+#define EXYNOS5260_SOC_ID	0xE5260000
 #define EXYNOS5410_SOC_ID	0xE5410000
 #define EXYNOS5420_SOC_ID	0xE5420000
 #define EXYNOS5440_SOC_ID	0xE5440000
@@ -69,6 +70,7 @@ IS_SAMSUNG_CPU(exynos4210, EXYNOS4210_CPU_ID, EXYNOS4_CPU_MASK)
 IS_SAMSUNG_CPU(exynos4212, EXYNOS4212_CPU_ID, EXYNOS4_CPU_MASK)
 IS_SAMSUNG_CPU(exynos4412, EXYNOS4412_CPU_ID, EXYNOS4_CPU_MASK)
 IS_SAMSUNG_CPU(exynos5250, EXYNOS5250_SOC_ID, EXYNOS5_SOC_MASK)
+IS_SAMSUNG_CPU(exynos5260, EXYNOS5260_SOC_ID, EXYNOS5_SOC_MASK)
 IS_SAMSUNG_CPU(exynos5410, EXYNOS5410_SOC_ID, EXYNOS5_SOC_MASK)
 IS_SAMSUNG_CPU(exynos5420, EXYNOS5420_SOC_ID, EXYNOS5_SOC_MASK)
 IS_SAMSUNG_CPU(exynos5440, EXYNOS5440_SOC_ID, EXYNOS5_SOC_MASK)
@@ -156,6 +158,12 @@ IS_SAMSUNG_CPU(exynos5440, EXYNOS5440_SOC_ID, EXYNOS5_SOC_MASK)
 # define soc_is_exynos5410()	0
 #endif
 
+#if defined(CONFIG_SOC_EXYNOS5260)
+# define soc_is_exynos5260()	is_samsung_exynos5260()
+#else
+# define soc_is_exynos5260()	0
+#endif
+
 #if defined(CONFIG_SOC_EXYNOS5420)
 # define soc_is_exynos5420()	is_samsung_exynos5420()
 #else
diff --git a/arch/arm/plat-samsung/include/plat/map-s5p.h b/arch/arm/plat-samsung/include/plat/map-s5p.h
index 31cac97..13c802b 100644
--- a/arch/arm/plat-samsung/include/plat/map-s5p.h
+++ b/arch/arm/plat-samsung/include/plat/map-s5p.h
@@ -23,6 +23,7 @@
 
 #define S5P_VA_SYSRAM		S3C_ADDR(0x02400000)
 #define S5P_VA_SYSRAM_NS	S3C_ADDR(0x02410000)
+
 #define S5P_VA_DMC0		S3C_ADDR(0x02440000)
 #define S5P_VA_DMC1		S3C_ADDR(0x02480000)
 #define S5P_VA_SROMC		S3C_ADDR(0x024C0000)
-- 
1.7.9.5
