From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 10 Dec 2012 10:06:05 +0900
Subject: [PATCH] ARM: EXYNOS: fix build error when MFC is not selected
Message-ID: <030b01cdd672$89b21e60$9d165b20$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This fixes following:
arch/arm/mach-exynos/built-in.o: In function `exynos5_reserve':
arch/arm/mach-exynos/mach-exynos5-dt.c:177: undefined reference to `s5p_fdt_find_mfc_mem'
arch/arm/mach-exynos/mach-exynos5-dt.c:177: undefined reference to `s5p_fdt_find_mfc_mem'
arch/arm/mach-exynos/mach-exynos5-dt.c:178: undefined reference to `s5p_mfc_reserve_mem'

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-exynos/mach-exynos5-dt.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos/mach-exynos5-dt.c b/arch/arm/mach-exynos/mach-exynos5-dt.c
index f5c6976..133abfd 100644
--- a/arch/arm/mach-exynos/mach-exynos5-dt.c
+++ b/arch/arm/mach-exynos/mach-exynos5-dt.c
@@ -169,6 +169,7 @@ static char const *exynos5_dt_compat[] __initdata = {
 
 static void __init exynos5_reserve(void)
 {
+#ifdef CONFIG_S5P_DEV_MFC
 	struct s5p_mfc_dt_meminfo mfc_mem;
 
 	/* Reserve memory for MFC only if it's available */
@@ -176,6 +177,7 @@ static void __init exynos5_reserve(void)
 	if (of_scan_flat_dt(s5p_fdt_find_mfc_mem, &mfc_mem))
 		s5p_mfc_reserve_mem(mfc_mem.roff, mfc_mem.rsize, mfc_mem.loff,
 				mfc_mem.lsize);
+#endif
 }
 
 DT_MACHINE_START(EXYNOS5_DT, "SAMSUNG EXYNOS5 (Flattened Device Tree)")
-- 
1.7.4.1
