From: mfuzzey@parkeon.com (Martin Fuzzey)
Date: Tue, 29 Jul 2014 14:33:03 +0200
Subject: [PATCH 3/4] ARM: i.MX53: Add Soc specific PMU setup.
In-Reply-To: <20140729123256.13347.79778.stgit@localhost>
References: <20140729123256.13347.79778.stgit@localhost>
Message-ID: <20140729123303.13347.12389.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On i.MX53 it is necessary to set the DBG_EN bit in the
platform GPC register to enable access to PMU counters other
than the cycle counter.

Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
---
 arch/arm/mach-imx/mach-imx53.c |   55 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/mach-imx53.c b/arch/arm/mach-imx/mach-imx53.c
index 2bad387..b2cc235 100644
--- a/arch/arm/mach-imx/mach-imx53.c
+++ b/arch/arm/mach-imx/mach-imx53.c
@@ -19,16 +19,69 @@
 #include <linux/of_platform.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
+#include <asm/pmu.h>
 
 #include "common.h"
 #include "hardware.h"
 #include "mx53.h"
+#include "crm-regs-imx5.h"
+
+#define GPC_DBG_EN (1 << 16)
+
+static void imx53_pmu_start(struct arm_pmu *arm_pmu)
+{
+	unsigned long flags;
+	struct pmu_hw_events *events = arm_pmu->get_hw_events();
+	u32 gpc;
+
+	raw_spin_lock_irqsave(&events->pmu_lock, flags);
+
+	gpc = __raw_readl(MXC_CORTEXA8_PLAT_GPC);
+	if (gpc & GPC_DBG_EN) {
+		events->activated_flags &= ~ARM_PMU_ACTIVATED_PLATFORM;
+	} else {
+		gpc |= GPC_DBG_EN;
+		__raw_writel(gpc, MXC_CORTEXA8_PLAT_GPC);
+		events->activated_flags |= ARM_PMU_ACTIVATED_PLATFORM;
+	}
+
+	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
+}
+
+static void imx53_pmu_stop(struct arm_pmu *arm_pmu)
+{
+	unsigned long flags;
+	struct pmu_hw_events *events = arm_pmu->get_hw_events();
+	u32 gpc;
+
+	raw_spin_lock_irqsave(&events->pmu_lock, flags);
+
+	if (events->activated_flags & ARM_PMU_ACTIVATED_PLATFORM) {
+		gpc = __raw_readl(MXC_CORTEXA8_PLAT_GPC);
+		gpc &= ~GPC_DBG_EN;
+		__raw_writel(gpc, MXC_CORTEXA8_PLAT_GPC);
+		events->activated_flags &= ~ARM_PMU_ACTIVATED_PLATFORM;
+	}
+
+	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
+}
+
+static struct arm_pmu_platdata imx53_pmu_platdata = {
+	.start		= imx53_pmu_start,
+	.stop		= imx53_pmu_stop,
+};
+
+static struct of_dev_auxdata imx53_auxdata_lookup[] __initdata = {
+	OF_DEV_AUXDATA("arm,cortex-a8-pmu", 0, "arm-pmu", &imx53_pmu_platdata),
+	{}
+};
 
 static void __init imx53_dt_init(void)
 {
 	mxc_arch_reset_init_dt();
 
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	of_platform_populate(NULL, of_default_bus_match_table,
+					imx53_auxdata_lookup, NULL);
 }
 
 static const char *imx53_dt_board_compat[] __initconst = {
