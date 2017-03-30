From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Thu, 30 Mar 2017 18:47:02 +0530
Subject: [PATCH v9 08/12] ARM: EXYNOS: move exynos_boot_vector_{addr, flag} ops
 to exynos_s2r_data
In-Reply-To: <1490879826-16754-1-git-send-email-pankaj.dubey@samsung.com>
References: <1490879826-16754-1-git-send-email-pankaj.dubey@samsung.com>
 <CGME20170330131436epcas1p4a4f8bf7b64b4a5ff9ee692adc4e7d001@epcas1p4.samsung.com>
Message-ID: <1490879826-16754-9-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Various Exynos SoC needs different boot addresses and flags. Currently we
are handling this difference by adding lots of soc_is_exynosMMM checks in
the code, in an attempt to remove the dependency of such helper functions
specific to each SoC, let's separate helper functions for these helper
functions by moving them into SoC specific hooks in struct exynos_s2r_data.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 arch/arm/mach-exynos/pm.c | 60 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 50 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index fa24098..c3fa537 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -32,26 +32,56 @@
 #include "common.h"
 
 struct exynos_s2r_data {
+	void __iomem* (*boot_vector_addr)(void);
+	void __iomem* (*boot_vector_flag)(void);
 	void (*enter_aftr)(void);
 };
 
 static const struct exynos_s2r_data *s2r_data;
 
-static inline void __iomem *exynos_boot_vector_addr(void)
+static void __iomem *exynos_boot_vector_addr(void)
+{
+	if (s2r_data && s2r_data->boot_vector_addr)
+		return s2r_data->boot_vector_addr();
+
+	return NULL;
+}
+
+static inline void __iomem *exynos4210_rev11_boot_vector_addr(void)
+{
+	return pmu_base_addr + S5P_INFORM7;
+}
+
+static inline void __iomem *exynos4210_rev10_boot_vector_addr(void)
+{
+	return sysram_base_addr + 0x24;
+}
+
+static inline void __iomem *exynos_common_boot_vector_addr(void)
 {
-	if (samsung_rev() == EXYNOS4210_REV_1_1)
-		return pmu_base_addr + S5P_INFORM7;
-	else if (samsung_rev() == EXYNOS4210_REV_1_0)
-		return sysram_base_addr + 0x24;
 	return pmu_base_addr + S5P_INFORM0;
 }
 
-static inline void __iomem *exynos_boot_vector_flag(void)
+static void __iomem *exynos_boot_vector_flag(void)
+{
+	if (s2r_data && s2r_data->boot_vector_flag)
+		return s2r_data->boot_vector_flag();
+
+	return NULL;
+}
+
+static inline void __iomem *exynos4210_rev11_boot_vector_flag(void)
+{
+	return pmu_base_addr + S5P_INFORM6;
+}
+
+static inline void __iomem *exynos4210_rev10_boot_vector_flag(void)
+{
+	return sysram_base_addr + 0x20;
+}
+
+static inline void __iomem *exynos_common_boot_vector_flag(void)
 {
-	if (samsung_rev() == EXYNOS4210_REV_1_1)
-		return pmu_base_addr + S5P_INFORM6;
-	else if (samsung_rev() == EXYNOS4210_REV_1_0)
-		return sysram_base_addr + 0x20;
 	return pmu_base_addr + S5P_INFORM1;
 }
 
@@ -218,22 +248,32 @@ static void exynos5_enter_aftr(void)
 }
 
 static const struct exynos_s2r_data exynos_common_s2r_data = {
+	.boot_vector_addr	= exynos_common_boot_vector_addr,
+	.boot_vector_flag	= exynos_common_boot_vector_flag,
 	.enter_aftr		= exynos5_enter_aftr,
 };
 
 static const struct exynos_s2r_data exynos3250_s2r_data = {
+	.boot_vector_addr	= exynos_common_boot_vector_addr,
+	.boot_vector_flag	= exynos_common_boot_vector_flag,
 	.enter_aftr		= exynos3_enter_aftr,
 };
 
 static const struct exynos_s2r_data exynos4210_rev11_s2r_data = {
+	.boot_vector_addr	= exynos4210_rev11_boot_vector_addr,
+	.boot_vector_flag	= exynos4210_rev11_boot_vector_flag,
 	.enter_aftr		= exynos4_enter_aftr,
 };
 
 static const struct exynos_s2r_data exynos4210_rev10_s2r_data = {
+	.boot_vector_addr	= exynos4210_rev10_boot_vector_addr,
+	.boot_vector_flag	= exynos4210_rev10_boot_vector_flag,
 	.enter_aftr		= exynos4_enter_aftr,
 };
 
 static const struct exynos_s2r_data exynos4x12_s2r_data = {
+	.boot_vector_addr	= exynos_common_boot_vector_addr,
+	.boot_vector_flag	= exynos_common_boot_vector_flag,
 	.enter_aftr		= exynos4_enter_aftr,
 };
 
-- 
2.7.4
