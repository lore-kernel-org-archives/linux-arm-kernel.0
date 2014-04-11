From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Fri, 11 Apr 2014 23:31:49 +0530
Subject: [PATCH 3/5] ARM: EXYNOS5420: Add IO mapping for non-secure SYSRAM
In-Reply-To: <1397239311-27717-1-git-send-email-a.kesavan@samsung.com>
References: <1397239311-27717-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <1397239311-27717-4-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the Exynos5420 non-secure SYSRAM is used for secondary CPU bring-up,
so add a mapping for it.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 arch/arm/mach-exynos/exynos.c           |   11 +++++++++++
 arch/arm/mach-exynos/include/mach/map.h |    1 +
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index b32a907..b1cf9d5 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -159,6 +159,15 @@ static struct map_desc exynos5250_iodesc[] __initdata = {
 	},
 };
 
+static struct map_desc exynos5420_iodesc[] __initdata = {
+	{
+		.virtual	= (unsigned long)S5P_VA_SYSRAM_NS,
+		.pfn		= __phys_to_pfn(EXYNOS5420_PA_SYSRAM_NS),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	},
+};
+
 static struct map_desc exynos5_iodesc[] __initdata = {
 	{
 		.virtual	= (unsigned long)S3C_VA_SYS,
@@ -294,6 +303,8 @@ static void __init exynos_map_io(void)
 		iotable_init(exynos4x12_iodesc, ARRAY_SIZE(exynos4x12_iodesc));
 	if (soc_is_exynos5250())
 		iotable_init(exynos5250_iodesc, ARRAY_SIZE(exynos5250_iodesc));
+	if (soc_is_exynos5420())
+		iotable_init(exynos5420_iodesc, ARRAY_SIZE(exynos5420_iodesc));
 }
 
 void __init exynos_init_io(void)
diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
index 7b046b5..8c5be19 100644
--- a/arch/arm/mach-exynos/include/mach/map.h
+++ b/arch/arm/mach-exynos/include/mach/map.h
@@ -29,6 +29,7 @@
 #define EXYNOS4210_PA_SYSRAM_NS		0x0203F000
 #define EXYNOS4x12_PA_SYSRAM_NS		0x0204F000
 #define EXYNOS5250_PA_SYSRAM_NS		0x0204F000
+#define EXYNOS5420_PA_SYSRAM_NS		0x02073000
 
 #define EXYNOS_PA_CHIPID		0x10000000
 
-- 
1.7.9.5
