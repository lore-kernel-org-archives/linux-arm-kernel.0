From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 23 Oct 2012 23:22:55 +0800
Subject: [PATCH 06/10] ARM: imx6q: prepare imx6q_set_lpm for cpudile support
In-Reply-To: <1351005779-30347-1-git-send-email-shawn.guo@linaro.org>
References: <1351005779-30347-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1351005779-30347-7-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

WAIT_UNCLOCKED and WAIT_UNCLOCKED_POWER_OFF will be used to implement
cpuidle.  Get function imx6q_set_lpm for that.  The unused mode
STOP_POWER_ON is removed from there.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/clk-imx6q.c |   32 +++++++++++++++++++++++++++-----
 arch/arm/mach-imx/common.h    |    3 +++
 arch/arm/mach-imx/gpc.c       |   11 +++++------
 arch/arm/mach-imx/platsmp.c   |   14 ++++++++++++++
 4 files changed, 49 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index 5f9f591..5ac10a0 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -23,6 +23,10 @@
 #include "clk.h"
 #include "common.h"
 
+#define CCSR				0x0c
+#define BM_CCSR_PLL1_SW_CLK_SEL		(0x1 << 2)
+#define BM_CCSR_STEP_SEL		(0x1 << 8)
+
 #define CCGR0				0x68
 #define CCGR1				0x6c
 #define CCGR2				0x70
@@ -60,22 +64,27 @@ void __init imx6q_clock_map_io(void) { }
 
 int imx6q_set_lpm(enum mxc_cpu_pwr_mode mode)
 {
+	static enum mxc_cpu_pwr_mode last_mode;
+	static u32 ccsr;
 	u32 val = readl_relaxed(ccm_base + CLPCR);
 
 	val &= ~BM_CLPCR_LPM;
 	switch (mode) {
 	case WAIT_CLOCKED:
+		/* Restore CCSR changed by WAIT_UNCLOCKED */
+		if (last_mode == WAIT_UNCLOCKED)
+			writel_relaxed(ccsr, ccm_base + CCSR);
 		break;
 	case WAIT_UNCLOCKED:
 		val |= 0x1 << BP_CLPCR_LPM;
-		break;
-	case STOP_POWER_ON:
-		val |= 0x2 << BP_CLPCR_LPM;
+		val |= BM_CLPCR_ARM_CLK_DIS_ON_LPM;
+		/* Source arm clock from 24 MHz OSC */
+		ccsr = readl_relaxed(ccm_base + CCSR);
+		writel_relaxed((ccsr | BM_CCSR_PLL1_SW_CLK_SEL) &
+			       ~BM_CCSR_STEP_SEL, ccm_base + CCSR);
 		break;
 	case WAIT_UNCLOCKED_POWER_OFF:
 		val |= 0x1 << BP_CLPCR_LPM;
-		val &= ~BM_CLPCR_VSTBY;
-		val &= ~BM_CLPCR_SBYOS;
 		break;
 	case STOP_POWER_OFF:
 		val |= 0x2 << BP_CLPCR_LPM;
@@ -88,6 +97,19 @@ int imx6q_set_lpm(enum mxc_cpu_pwr_mode mode)
 	}
 
 	writel_relaxed(val, ccm_base + CLPCR);
+	last_mode = mode;
+
+	/* Need to enable SCU standby for entering WAIT modes */
+	if (mode == WAIT_UNCLOCKED || mode == WAIT_UNCLOCKED_POWER_OFF)
+		imx_scu_standby_enable(true);
+	else
+		imx_scu_standby_enable(false);
+
+	/* Tell GPC whether to power off ARM core */
+	if (mode == WAIT_UNCLOCKED_POWER_OFF || mode == STOP_POWER_OFF)
+		imx_gpc_cpu_pdn(true);
+	else
+		imx_gpc_cpu_pdn(false);
 
 	return 0;
 }
diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index ef8db6b..9ff0776 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -126,9 +126,11 @@ extern u32 *pl310_get_save_ptr(void);
 extern void v7_secondary_startup(void);
 extern void imx_scu_map_io(void);
 extern void imx_smp_prepare(void);
+extern void imx_scu_standby_enable(bool enable);
 #else
 static inline void imx_scu_map_io(void) {}
 static inline void imx_smp_prepare(void) {}
+static inline void imx_scu_standby_enable(bool enable) {}
 #endif
 extern void imx_enable_cpu(int cpu, bool enable);
 extern void imx_set_cpu_jump(int cpu, void *jump_addr);
@@ -137,6 +139,7 @@ extern void imx_src_prepare_restart(void);
 extern void imx_gpc_init(void);
 extern void imx_gpc_pre_suspend(void);
 extern void imx_gpc_post_resume(void);
+extern void imx_gpc_cpu_pdn(bool);
 extern int imx6q_set_lpm(enum mxc_cpu_pwr_mode mode);
 extern void imx6q_clock_map_io(void);
 
diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
index be9a6cb..897a5af 100644
--- a/arch/arm/mach-imx/gpc.c
+++ b/arch/arm/mach-imx/gpc.c
@@ -27,14 +27,16 @@ static void __iomem *gpc_base;
 static u32 gpc_wake_irqs[IMR_NUM];
 static u32 gpc_saved_imrs[IMR_NUM];
 
+void imx_gpc_cpu_pdn(bool pdn)
+{
+	writel_relaxed(pdn ? 0x1 : 0x0, gpc_base + GPC_PGC_CPU_PDN);
+}
+
 void imx_gpc_pre_suspend(void)
 {
 	void __iomem *reg_imr1 = gpc_base + GPC_IMR1;
 	int i;
 
-	/* Tell GPC to power off ARM core when suspend */
-	writel_relaxed(0x1, gpc_base + GPC_PGC_CPU_PDN);
-
 	for (i = 0; i < IMR_NUM; i++) {
 		gpc_saved_imrs[i] = readl_relaxed(reg_imr1 + i * 4);
 		writel_relaxed(~gpc_wake_irqs[i], reg_imr1 + i * 4);
@@ -46,9 +48,6 @@ void imx_gpc_post_resume(void)
 	void __iomem *reg_imr1 = gpc_base + GPC_IMR1;
 	int i;
 
-	/* Keep ARM core powered on for other low-power modes */
-	writel_relaxed(0x0, gpc_base + GPC_PGC_CPU_PDN);
-
 	for (i = 0; i < IMR_NUM; i++)
 		writel_relaxed(gpc_saved_imrs[i], reg_imr1 + i * 4);
 }
diff --git a/arch/arm/mach-imx/platsmp.c b/arch/arm/mach-imx/platsmp.c
index 3777b80..c739a8a 100644
--- a/arch/arm/mach-imx/platsmp.c
+++ b/arch/arm/mach-imx/platsmp.c
@@ -20,6 +20,8 @@
 #include "common.h"
 #include "hardware.h"
 
+#define SCU_STANDBY_ENABLE	(1 << 5)
+
 static void __iomem *scu_base;
 
 static struct map_desc scu_io_desc __initdata = {
@@ -42,6 +44,18 @@ void __init imx_scu_map_io(void)
 	scu_base = IMX_IO_ADDRESS(base);
 }
 
+void imx_scu_standby_enable(bool enable)
+{
+	u32 val = readl_relaxed(scu_base);
+
+	if (enable)
+		val |= SCU_STANDBY_ENABLE;
+	else
+		val &= ~SCU_STANDBY_ENABLE;
+
+	writel_relaxed(val, scu_base);
+}
+
 static void __cpuinit imx_secondary_init(unsigned int cpu)
 {
 	/*
-- 
1.7.9.5
