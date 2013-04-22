From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 22 Apr 2013 17:05:07 +0530
Subject: [PATCH v2 1/2] ARM: Exynos: Create virtual I/O mapping for Chip-ID
 controller using device tree
In-Reply-To: <1366630508-26101-1-git-send-email-thomas.abraham@linaro.org>
References: <1366630508-26101-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1366630508-26101-2-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On device tree enabled exynos platforms, retrieve the physical base address
of the chip-id controller from device tree and create a virtual I/O mapping
for the chip-id controller. This helps to remove the chip-id controller entry
from the statically defined I/O mapping tables.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/mach-exynos/common.c           |   53 +++++++++++++++++-------------
 arch/arm/mach-exynos/include/mach/map.h |    1 -
 2 files changed, 30 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index 8419190..64ef39e 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -120,17 +120,6 @@ static struct map_desc exynos_iodesc[] __initdata = {
 	},
 };
 
-#ifdef CONFIG_ARCH_EXYNOS5
-static struct map_desc exynos5440_iodesc[] __initdata = {
-	{
-		.virtual	= (unsigned long)S5P_VA_CHIPID,
-		.pfn		= __phys_to_pfn(EXYNOS5440_PA_CHIPID),
-		.length		= SZ_4K,
-		.type		= MT_DEVICE,
-	},
-};
-#endif
-
 static struct map_desc exynos4_iodesc[] __initdata = {
 	{
 		.virtual	= (unsigned long)S3C_VA_SYS,
@@ -348,6 +337,31 @@ void __init exynos_init_late(void)
 	exynos_pm_late_initcall();
 }
 
+#ifdef CONFIG_OF
+int __init exynos_fdt_map_chipid(unsigned long node, const char *uname,
+					int depth, void *data)
+{
+	struct map_desc iodesc;
+	__be32 *reg;
+	unsigned long len;
+
+	if (!of_flat_dt_is_compatible(node, "samsung,exynos4210-chipid") &&
+		!of_flat_dt_is_compatible(node, "samsung,exynos5440-clock"))
+		return 0;
+
+	reg = of_get_flat_dt_prop(node, "reg", &len);
+	if (reg == NULL || len != (sizeof(unsigned long) * 2))
+		return 0;
+
+	iodesc.pfn = __phys_to_pfn(be32_to_cpu(reg[0]));
+	iodesc.length = be32_to_cpu(reg[1]) - 1;
+	iodesc.virtual = (unsigned long)S5P_VA_CHIPID;
+	iodesc.type = MT_DEVICE;
+	iotable_init(&iodesc, 1);
+	return 1;
+}
+#endif
+
 /*
  * exynos_map_io
  *
@@ -356,19 +370,12 @@ void __init exynos_init_late(void)
 
 void __init exynos_init_io(struct map_desc *mach_desc, int size)
 {
-	struct map_desc *iodesc = exynos_iodesc;
-	int iodesc_sz = ARRAY_SIZE(exynos_iodesc);
-#if defined(CONFIG_OF) && defined(CONFIG_ARCH_EXYNOS5)
-	unsigned long root = of_get_flat_dt_root();
-
-	/* initialize the io descriptors we need for initialization */
-	if (of_flat_dt_is_compatible(root, "samsung,exynos5440")) {
-		iodesc = exynos5440_iodesc;
-		iodesc_sz = ARRAY_SIZE(exynos5440_iodesc);
-	}
+#ifdef CONFIG_OF
+	if (initial_boot_params)
+		of_scan_flat_dt(exynos_fdt_map_chipid, NULL);
+	else
 #endif
-
-	iotable_init(iodesc, iodesc_sz);
+		iotable_init(exynos_iodesc, ARRAY_SIZE(exynos_iodesc));
 
 	if (mach_desc)
 		iotable_init(mach_desc, size);
diff --git a/arch/arm/mach-exynos/include/mach/map.h b/arch/arm/mach-exynos/include/mach/map.h
index 99e0a79..92b29bb 100644
--- a/arch/arm/mach-exynos/include/mach/map.h
+++ b/arch/arm/mach-exynos/include/mach/map.h
@@ -56,7 +56,6 @@
 #define EXYNOS4_PA_ONENAND_DMA		0x0C600000
 
 #define EXYNOS_PA_CHIPID		0x10000000
-#define EXYNOS5440_PA_CHIPID		0x00160000
 
 #define EXYNOS4_PA_SYSCON		0x10010000
 #define EXYNOS5_PA_SYSCON		0x10050100
-- 
1.6.6.rc2
