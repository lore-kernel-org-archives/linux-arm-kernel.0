From: pullip.cho@samsung.com (KyongHo Cho)
Date: Mon,  4 Jul 2011 10:41:47 +0900
Subject: [PATCH 6/6] ARM: EXYNOS4: SYSMMU: Move clock gating functions to
	SYSMMU device driver.
In-Reply-To: <1309743708-1505-1-git-send-email-pullip.cho@samsung.com>
References: <1309743708-1505-1-git-send-email-pullip.cho@samsung.com>
Message-ID: <1309743708-1505-7-git-send-email-pullip.cho@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clock gating functions that was defined in mach/dev-sysmmu.c.
As with clkdev, clock gating is not dependent upon a specific platform,
thus, it is moved to system MMU driver.

Signed-off-by: KyongHo Cho <pullip.cho@samsung.com>
---
 arch/arm/mach-exynos4/dev-sysmmu.c          |   42 ---------------------------
 arch/arm/mach-exynos4/include/mach/sysmmu.h |    8 +----
 arch/arm/plat-s5p/sysmmu.c                  |   42 +++++++++++++++++++++++++++
 3 files changed, 44 insertions(+), 48 deletions(-)

diff --git a/arch/arm/mach-exynos4/dev-sysmmu.c b/arch/arm/mach-exynos4/dev-sysmmu.c
index 824a079..71be6bf 100644
--- a/arch/arm/mach-exynos4/dev-sysmmu.c
+++ b/arch/arm/mach-exynos4/dev-sysmmu.c
@@ -16,26 +16,6 @@
 #include <mach/map.h>
 #include <mach/irqs.h>
 #include <mach/sysmmu.h>
-#include <plat/s5p-clock.h>
-
-/* These names must be equal to the clock names in mach-exynos4/clock.c */
-const char *sysmmu_ips_name[EXYNOS4_SYSMMU_TOTAL_IPNUM] = {
-	"SYSMMU_SSS"	,
-	"SYSMMU_FIMC0"	,
-	"SYSMMU_FIMC1"	,
-	"SYSMMU_FIMC2"	,
-	"SYSMMU_FIMC3"	,
-	"SYSMMU_JPEG"	,
-	"SYSMMU_FIMD0"	,
-	"SYSMMU_FIMD1"	,
-	"SYSMMU_PCIe"	,
-	"SYSMMU_G2D"	,
-	"SYSMMU_ROTATOR",
-	"SYSMMU_MDMA"	,
-	"SYSMMU_TV"	,
-	"SYSMMU_MFC_L"	,
-	"SYSMMU_MFC_R"	,
-};
 
 #define SYSMMU_RESOURCE(name, irq) [SYSMMU_##name] = {\
 		[0] = {\
@@ -99,25 +79,3 @@ struct platform_device exynos4_device_sysmmu[S5P_SYSMMU_TOTAL_IPNUM] = {
 	SYSMMU_PLATFORM_DEVICE(MFC_L),
 	SYSMMU_PLATFORM_DEVICE(MFC_R),
 };
-
-static struct clk *sysmmu_clk[S5P_SYSMMU_TOTAL_IPNUM];
-void sysmmu_clk_init(struct device *dev, sysmmu_ips ips)
-{
-	sysmmu_clk[ips] = clk_get(dev, NULL);
-	if (IS_ERR(sysmmu_clk[ips]))
-		sysmmu_clk[ips] = NULL;
-	else
-		clk_put(sysmmu_clk[ips]);
-}
-
-void sysmmu_clk_enable(sysmmu_ips ips)
-{
-	if (sysmmu_clk[ips])
-		clk_enable(sysmmu_clk[ips]);
-}
-
-void sysmmu_clk_disable(sysmmu_ips ips)
-{
-	if (sysmmu_clk[ips])
-		clk_disable(sysmmu_clk[ips]);
-}
diff --git a/arch/arm/mach-exynos4/include/mach/sysmmu.h b/arch/arm/mach-exynos4/include/mach/sysmmu.h
index 05e282c..a973385 100644
--- a/arch/arm/mach-exynos4/include/mach/sysmmu.h
+++ b/arch/arm/mach-exynos4/include/mach/sysmmu.h
@@ -35,12 +35,8 @@ enum exynos4_sysmmu_ips {
 #define S5P_SYSMMU_TOTAL_IPNUM		EXYNOS4_SYSMMU_TOTAL_IPNUM
 #define SYSMMU_NONE			S5P_SYSMMU_TOTAL_IPNUM
 
-extern const char *sysmmu_ips_name[EXYNOS4_SYSMMU_TOTAL_IPNUM];
-
 typedef enum exynos4_sysmmu_ips sysmmu_ips;
 
-void sysmmu_clk_init(struct device *dev, sysmmu_ips ips);
-void sysmmu_clk_enable(sysmmu_ips ips);
-void sysmmu_clk_disable(sysmmu_ips ips);
-
+#else /*__ASM_ARM_ARCH_SYSMMU_H */
+#error mach/sysmmu.h must not be included by device drivers
 #endif /* __ASM_ARM_ARCH_SYSMMU_H */
diff --git a/arch/arm/plat-s5p/sysmmu.c b/arch/arm/plat-s5p/sysmmu.c
index 54f5edd..b3ceec9 100644
--- a/arch/arm/plat-s5p/sysmmu.c
+++ b/arch/arm/plat-s5p/sysmmu.c
@@ -11,6 +11,8 @@
 #include <linux/io.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/err.h>
 
 #include <asm/pgtable.h>
 
@@ -24,6 +26,46 @@
 
 static struct device *dev;
 
+const char *sysmmu_ips_name[EXYNOS4_SYSMMU_TOTAL_IPNUM] = {
+	"SYSMMU_SSS"	,
+	"SYSMMU_FIMC0"	,
+	"SYSMMU_FIMC1"	,
+	"SYSMMU_FIMC2"	,
+	"SYSMMU_FIMC3"	,
+	"SYSMMU_JPEG"	,
+	"SYSMMU_FIMD0"	,
+	"SYSMMU_FIMD1"	,
+	"SYSMMU_PCIe"	,
+	"SYSMMU_G2D"	,
+	"SYSMMU_ROTATOR",
+	"SYSMMU_MDMA"	,
+	"SYSMMU_TV"	,
+	"SYSMMU_MFC_L"	,
+	"SYSMMU_MFC_R"	,
+};
+
+static struct clk *sysmmu_clk[S5P_SYSMMU_TOTAL_IPNUM];
+void sysmmu_clk_init(struct device *dev, sysmmu_ips ips)
+{
+	sysmmu_clk[ips] = clk_get(dev, NULL);
+	if (IS_ERR(sysmmu_clk[ips]))
+		sysmmu_clk[ips] = NULL;
+	else
+		clk_put(sysmmu_clk[ips]);
+}
+
+void sysmmu_clk_enable(sysmmu_ips ips)
+{
+	if (sysmmu_clk[ips])
+		clk_enable(sysmmu_clk[ips]);
+}
+
+void sysmmu_clk_disable(sysmmu_ips ips)
+{
+	if (sysmmu_clk[ips])
+		clk_disable(sysmmu_clk[ips]);
+}
+
 static unsigned short fault_reg_offset[SYSMMU_FAULTS_NUM] = {
 	S5P_PAGE_FAULT_ADDR,
 	S5P_AR_FAULT_ADDR,
-- 
1.7.1
