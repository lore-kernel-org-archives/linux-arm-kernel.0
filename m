From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 24 Sep 2012 16:28:31 +0200
Subject: [PATCH 4/6] ARM: EXYNOS: Add IO mapping for non-secure SYSRAM.
In-Reply-To: <1348496913-25422-1-git-send-email-t.figa@samsung.com>
References: <1348496913-25422-1-git-send-email-t.figa@samsung.com>
Message-ID: <1348496913-25422-5-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On TrustZone-enabled boards the non-secure SYSRAM is used for secondary
CPU bring-up, so add a mapping for it.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/mach-exynos/common.c                | 34 ++++++++++++++++++++++++++++
 arch/arm/mach-exynos/include/mach/map.h      |  3 +++
 arch/arm/plat-samsung/include/plat/map-s5p.h |  1 +
 3 files changed, 38 insertions(+)

diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index 4eb39cd..ddec3d5 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -214,6 +214,33 @@ static struct map_desc exynos4_iodesc1[] __initdata = {
 	},
 };
 
+static struct map_desc exynos4210_iodesc[] __initdata = {
+	{
+		.virtual	= (unsigned long)S5P_VA_SYSRAM_NS,
+		.pfn		= __phys_to_pfn(EXYNOS4210_PA_SYSRAM_NS),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	},
+};
+
+static struct map_desc exynos4x12_iodesc[] __initdata = {
+	{
+		.virtual	= (unsigned long)S5P_VA_SYSRAM_NS,
+		.pfn		= __phys_to_pfn(EXYNOS4x12_PA_SYSRAM_NS),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	},
+};
+
+static struct map_desc exynos5250_iodesc[] __initdata = {
+	{
+		.virtual	= (unsigned long)S5P_VA_SYSRAM_NS,
+		.pfn		= __phys_to_pfn(EXYNOS5250_PA_SYSRAM_NS),
+		.length		= SZ_4K,
+		.type		= MT_DEVICE,
+	},
+};
+
 static struct map_desc exynos5_iodesc[] __initdata = {
 	{
 		.virtual	= (unsigned long)S3C_VA_SYS,
@@ -321,6 +348,13 @@ static void __init exynos4_map_io(void)
 	else
 		iotable_init(exynos4_iodesc1, ARRAY_SIZE(exynos4_iodesc1));
 
+	if (soc_is_exynos4210())
+		iotable_init(exynos4210_iodesc, ARRAY_SIZE(exynos4210_iodesc));
+	if (soc_is_exynos4212() || soc_is_exynos4412())
+		iotable_init(exynos4x12_iodesc, ARRAY_SIZE(exynos4x12_iodesc));
+	if (soc_is_exynos5250())
+		iotable_init(exynos5250_iodesc, ARRAY_SIZE(exynos5250_iodesc));
+
 	/* initialize device information early */
 	exynos4_default_sdhci0();
 	exynos4_default_sdhci1();
diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
index c72b675..f4a8ac3 100644
--- a/arch/arm/mach-exynos/include/mach/map.h
+++ b/arch/arm/mach-exynos/include/mach/map.h
@@ -26,6 +26,9 @@
 #define EXYNOS4_PA_SYSRAM0		0x02025000
 #define EXYNOS4_PA_SYSRAM1		0x02020000
 #define EXYNOS5_PA_SYSRAM		0x02020000
+#define EXYNOS4210_PA_SYSRAM_NS		0x0203F000
+#define EXYNOS4x12_PA_SYSRAM_NS		0x0204F000
+#define EXYNOS5250_PA_SYSRAM_NS		0x0204F000
 
 #define EXYNOS4_PA_FIMC0		0x11800000
 #define EXYNOS4_PA_FIMC1		0x11810000
diff --git a/arch/arm/plat-samsung/include/plat/map-s5p.h b/arch/arm/plat-samsung/include/plat/map-s5p.h
index c2d7bda..c186786 100644
--- a/arch/arm/plat-samsung/include/plat/map-s5p.h
+++ b/arch/arm/plat-samsung/include/plat/map-s5p.h
@@ -22,6 +22,7 @@
 #define S5P_VA_GPIO3		S3C_ADDR(0x02280000)
 
 #define S5P_VA_SYSRAM		S3C_ADDR(0x02400000)
+#define S5P_VA_SYSRAM_NS	S3C_ADDR(0x02410000)
 #define S5P_VA_DMC0		S3C_ADDR(0x02440000)
 #define S5P_VA_DMC1		S3C_ADDR(0x02480000)
 #define S5P_VA_SROMC		S3C_ADDR(0x024C0000)
-- 
1.7.12
