From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Sat, 03 May 2014 15:11:37 +0900
Subject: [PATCH 1/4] ARM: EXYNOS: remove soc_is_exynos4/5 from exynos.c
In-Reply-To: <1399097500-4052-1-git-send-email-pankaj.dubey@samsung.com>
References: <1399097500-4052-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1399097500-4052-2-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for checking soc compatibility based on
compatibility match. It will help us in removing soc_is_exynos4
and soc_is_exynos5 function usage and definition.

CC: Russell King <linux@arm.linux.org.uk>
CC: Heiko Stuebner <heiko@sntech.de>
CC: Thomas Abraham <thomas.abraham@linaro.org>
Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 arch/arm/mach-exynos/exynos.c            |   30 +++++++++++++++++++++++++++---
 arch/arm/plat-samsung/include/plat/cpu.h |    3 ---
 2 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index 59eb1f1..93ae076 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -212,6 +212,30 @@ static const struct of_device_id exynos_dt_pmu_match[] = {
 	{},
 };
 
+static const struct of_device_id exynos5_device_ids[] = {
+	{ .compatible = "samsung,exynos5250", },
+	{ .compatible = "samsung,exynos5420", },
+	{},
+};
+
+static const struct of_device_id exynos4_device_ids[] = {
+	{ .compatible = "samsung,exynos4210", },
+	{ .compatible = "samsung,exynos4212", },
+	{ .compatible = "samsung,exynos4412", },
+	{},
+};
+
+static inline bool soc_is_compatible(const struct of_device_id *device_ids)
+{
+	unsigned long root = of_get_flat_dt_root();
+	const struct of_device_id *matches = device_ids;
+	for (; matches->compatible[0]; matches++) {
+		if (of_flat_dt_is_compatible(root, matches->compatible))
+			return true;
+	}
+	return false;
+}
+
 /*
  * exynos_map_io
  *
@@ -219,10 +243,10 @@ static const struct of_device_id exynos_dt_pmu_match[] = {
  */
 static void __init exynos_map_io(void)
 {
-	if (soc_is_exynos4())
+	if (soc_is_compatible(exynos4_device_ids))
 		iotable_init(exynos4_iodesc, ARRAY_SIZE(exynos4_iodesc));
 
-	if (soc_is_exynos5())
+	if (soc_is_compatible(exynos5_device_ids))
 		iotable_init(exynos5_iodesc, ARRAY_SIZE(exynos5_iodesc));
 }
 
@@ -306,7 +330,7 @@ static void __init exynos_dt_machine_init(void)
 	 * are available then re-configure the interrupts via the
 	 * system register.
 	 */
-	if (soc_is_exynos5()) {
+	if (soc_is_compatible(exynos5_device_ids)) {
 		for_each_compatible_node(i2c_np, NULL, i2c_compat) {
 			if (of_device_is_available(i2c_np)) {
 				id = of_alias_get_id(i2c_np, "i2c");
diff --git a/arch/arm/plat-samsung/include/plat/cpu.h b/arch/arm/plat-samsung/include/plat/cpu.h
index 5992b8d..18a9a00 100644
--- a/arch/arm/plat-samsung/include/plat/cpu.h
+++ b/arch/arm/plat-samsung/include/plat/cpu.h
@@ -166,9 +166,6 @@ IS_SAMSUNG_CPU(exynos5440, EXYNOS5440_SOC_ID, EXYNOS5_SOC_MASK)
 # define soc_is_exynos5440()	0
 #endif
 
-#define soc_is_exynos4() (soc_is_exynos4210() || soc_is_exynos4212() || \
-			  soc_is_exynos4412())
-#define soc_is_exynos5() (soc_is_exynos5250() || soc_is_exynos5420())
 
 #define IODESC_ENT(x) { (unsigned long)S3C24XX_VA_##x, __phys_to_pfn(S3C24XX_PA_##x), S3C24XX_SZ_##x, MT_DEVICE }
 
-- 
1.7.10.4
