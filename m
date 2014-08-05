From: mfuzzey@parkeon.com (Martin Fuzzey)
Date: Tue, 05 Aug 2014 16:48:38 +0200
Subject: [PATCH V2 3/4] ARM: i.MX53: Add Soc specific PMU setup.
In-Reply-To: <20140805144831.25462.18149.stgit@localhost>
References: <20140805144831.25462.18149.stgit@localhost>
Message-ID: <20140805144837.25462.15001.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On i.MX53 it is necessary to set the DBG_EN bit in the
platform GPC register to enable access to PMU counters other
than the cycle counter.

Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
---
 arch/arm/mach-imx/mach-imx53.c |   50 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/mach-imx53.c b/arch/arm/mach-imx/mach-imx53.c
index 2bad387..74f6bf3 100644
--- a/arch/arm/mach-imx/mach-imx53.c
+++ b/arch/arm/mach-imx/mach-imx53.c
@@ -19,16 +19,64 @@
 #include <linux/of_platform.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
+#include <asm/pmu.h>
 
 #include "common.h"
+#include "crm-regs-imx5.h"
 #include "hardware.h"
 #include "mx53.h"
 
+#define GPC_DBG_EN (1 << 16)
+
+static int imx53_pmu_resume(struct device *dev)
+{
+	struct arm_pmu *arm_pmu = dev_get_drvdata(dev);
+	u32 gpc;
+
+	gpc = __raw_readl(MXC_CORTEXA8_PLAT_GPC);
+	if (gpc & GPC_DBG_EN) {
+		arm_pmu->activated_flags.platform_enabled = 0;
+	} else {
+		gpc |= GPC_DBG_EN;
+		__raw_writel(gpc, MXC_CORTEXA8_PLAT_GPC);
+		arm_pmu->activated_flags.platform_enabled = 1;
+	}
+
+	return 0;
+}
+
+static int imx53_pmu_suspend(struct device *dev)
+{
+	struct arm_pmu *arm_pmu = dev_get_drvdata(dev);
+	u32 gpc;
+
+	if (arm_pmu->activated_flags.platform_enabled) {
+		gpc = __raw_readl(MXC_CORTEXA8_PLAT_GPC);
+		gpc &= ~GPC_DBG_EN;
+		__raw_writel(gpc, MXC_CORTEXA8_PLAT_GPC);
+		arm_pmu->activated_flags.platform_enabled = 0;
+	}
+
+	return 0;
+}
+
+
+static struct arm_pmu_platdata imx53_pmu_platdata = {
+	.runtime_resume = imx53_pmu_resume,
+	.runtime_suspend = imx53_pmu_suspend,
+};
+
+static struct of_dev_auxdata imx53_auxdata_lookup[] __initdata = {
+	OF_DEV_AUXDATA("arm,cortex-a8-pmu", 0, "arm-pmu", &imx53_pmu_platdata),
+	{}
+};
+
 static void __init imx53_dt_init(void)
 {
 	mxc_arch_reset_init_dt();
 
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	of_platform_populate(NULL, of_default_bus_match_table,
+					imx53_auxdata_lookup, NULL);
 }
 
 static const char *imx53_dt_board_compat[] __initconst = {
