From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 14 Jun 2013 21:32:47 +0200
Subject: [PATCH 11/28] ARM: EXYNOS: common: Remove legacy mapping of chip ID
 block
In-Reply-To: <1371238384-1504-1-git-send-email-t.figa@samsung.com>
References: <1371238384-1504-1-git-send-email-t.figa@samsung.com>
Message-ID: <1371238384-1504-12-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes static mapping of chip ID block that was used when
booting with ATAGS, which is not supported on Exynos any more.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/common.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index 2c8527c..f81aa22 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -99,15 +99,6 @@ static struct cpu_table cpu_ids[] __initdata = {
 
 /* Initial IO mappings */
 
-static struct map_desc exynos_iodesc[] __initdata = {
-	{
-		.virtual	= (unsigned long)S5P_VA_CHIPID,
-		.pfn		= __phys_to_pfn(EXYNOS_PA_CHIPID),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE,
-	},
-};
-
 static struct map_desc exynos4_iodesc[] __initdata = {
 	{
 		.virtual	= (unsigned long)S3C_VA_SYS,
@@ -365,10 +356,7 @@ void __init exynos_init_io(struct map_desc *mach_desc, int size)
 {
 	debug_ll_io_init();
 
-	if (initial_boot_params)
-		of_scan_flat_dt(exynos_fdt_map_chipid, NULL);
-	else
-		iotable_init(exynos_iodesc, ARRAY_SIZE(exynos_iodesc));
+	of_scan_flat_dt(exynos_fdt_map_chipid, NULL);
 
 	if (mach_desc)
 		iotable_init(mach_desc, size);
-- 
1.8.2.1
