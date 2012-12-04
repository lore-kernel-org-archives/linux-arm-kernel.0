From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue,  4 Dec 2012 22:55:15 +0800
Subject: [PATCH v2 4/4] ARM: imx6q: support WAIT mode using cpuidle
In-Reply-To: <1354632915-27134-1-git-send-email-shawn.guo@linaro.org>
References: <1354632915-27134-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1354632915-27134-5-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add WAIT mode (ARM core clock gating) support to imx6q cpuidle driver.
As WAIT mode is broken on imx6q TO 1.0 and 1.1, it only enables the
support for revision 1.2 with chicken bit set.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/clk-imx6q.c     |   12 ++++++
 arch/arm/mach-imx/common.h        |    3 ++
 arch/arm/mach-imx/cpuidle-imx6q.c |   76 ++++++++++++++++++++++++++++++++++++-
 arch/arm/mach-imx/mach-imx6q.c    |    7 +++-
 arch/arm/mach-imx/platsmp.c       |   10 +++++
 5 files changed, 105 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index 7f2c10c..c714219 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -54,10 +54,21 @@
 #define BM_CLPCR_MASK_SCU_IDLE		(0x1 << 26)
 #define BM_CLPCR_MASK_L2CC_IDLE		(0x1 << 27)
 
+#define CGPR				0x64
+#define BM_CGPR_CHICKEN_BIT		(0x1 << 17)
+
 static void __iomem *ccm_base;
 
 void __init imx6q_clock_map_io(void) { }
 
+void imx6q_set_chicken_bit(void)
+{
+	u32 val = readl_relaxed(ccm_base + CGPR);
+
+	val |= BM_CGPR_CHICKEN_BIT;
+	writel_relaxed(val, ccm_base + CGPR);
+}
+
 int imx6q_set_lpm(enum mxc_cpu_pwr_mode mode)
 {
 	u32 val = readl_relaxed(ccm_base + CLPCR);
@@ -68,6 +79,7 @@ int imx6q_set_lpm(enum mxc_cpu_pwr_mode mode)
 		break;
 	case WAIT_UNCLOCKED:
 		val |= 0x1 << BP_CLPCR_LPM;
+		val |= BM_CLPCR_ARM_CLK_DIS_ON_LPM;
 		break;
 	case STOP_POWER_ON:
 		val |= 0x2 << BP_CLPCR_LPM;
diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index 7191ab4..7edd53d 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -127,9 +127,11 @@ extern u32 *pl310_get_save_ptr(void);
 extern void v7_secondary_startup(void);
 extern void imx_scu_map_io(void);
 extern void imx_smp_prepare(void);
+extern void imx_scu_standby_enable(void);
 #else
 static inline void imx_scu_map_io(void) {}
 static inline void imx_smp_prepare(void) {}
+static inline void imx_scu_standby_enable(void) {}
 #endif
 extern void imx_enable_cpu(int cpu, bool enable);
 extern void imx_set_cpu_jump(int cpu, void *jump_addr);
@@ -139,6 +141,7 @@ extern void imx_gpc_init(void);
 extern void imx_gpc_pre_suspend(void);
 extern void imx_gpc_post_resume(void);
 extern int imx6q_set_lpm(enum mxc_cpu_pwr_mode mode);
+extern void imx6q_set_chicken_bit(void);
 extern void imx6q_clock_map_io(void);
 
 extern void imx_cpu_die(unsigned int cpu);
diff --git a/arch/arm/mach-imx/cpuidle-imx6q.c b/arch/arm/mach-imx/cpuidle-imx6q.c
index 83facc9..ddc26c2 100644
--- a/arch/arm/mach-imx/cpuidle-imx6q.c
+++ b/arch/arm/mach-imx/cpuidle-imx6q.c
@@ -6,21 +6,93 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/clockchips.h>
 #include <linux/cpuidle.h>
 #include <linux/module.h>
 #include <asm/cpuidle.h>
+#include <asm/proc-fns.h>
 
+#include "common.h"
 #include "cpuidle.h"
 
+static atomic_t master = ATOMIC_INIT(0);
+static DEFINE_SPINLOCK(master_lock);
+
+static int imx6q_enter_wait(struct cpuidle_device *dev,
+			    struct cpuidle_driver *drv, int index)
+{
+	int cpu = dev->cpu;
+
+	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &cpu);
+
+	if (atomic_inc_return(&master) == num_online_cpus()) {
+		/*
+		 * With this lock, we prevent other cpu to exit and enter
+		 * this function again and become the master.
+		 */
+		if (!spin_trylock(&master_lock))
+			goto idle;
+		imx6q_set_lpm(WAIT_UNCLOCKED);
+		cpu_do_idle();
+		imx6q_set_lpm(WAIT_CLOCKED);
+		spin_unlock(&master_lock);
+		goto done;
+	}
+
+idle:
+	cpu_do_idle();
+done:
+	atomic_dec(&master);
+	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &cpu);
+
+	return index;
+}
+
+/*
+ * For each cpu, setup the broadcast timer because local timer
+ * stops for the states other than WFI.
+ */
+static void imx6q_setup_broadcast_timer(void *arg)
+{
+	int cpu = smp_processor_id();
+
+	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ON, &cpu);
+}
+
 static struct cpuidle_driver imx6q_cpuidle_driver = {
 	.name = "imx6q_cpuidle",
 	.owner = THIS_MODULE,
 	.en_core_tk_irqen = 1,
-	.states[0] = ARM_CPUIDLE_WFI_STATE,
-	.state_count = 1,
+	.states = {
+		/* WFI */
+		ARM_CPUIDLE_WFI_STATE,
+		/* WAIT */
+		{
+			.exit_latency = 50,
+			.target_residency = 75,
+			.flags = CPUIDLE_FLAG_TIME_VALID,
+			.enter = imx6q_enter_wait,
+			.name = "WAIT",
+			.desc = "Clock off",
+		},
+	},
+	.state_count = 2,
+	.safe_state_index = 0,
 };
 
 int __init imx6q_cpuidle_init(void)
 {
+	/* Set initial power mode */
+	imx6q_set_lpm(WAIT_CLOCKED);
+
+	/* Need to enable SCU standby for entering WAIT modes */
+	imx_scu_standby_enable();
+
+	/* Set chicken bit to get a reliable WAIT mode support */
+	imx6q_set_chicken_bit();
+
+	/* Configure the broadcast timer on each cpu */
+	on_each_cpu(imx6q_setup_broadcast_timer, NULL, 1);
+
 	return imx_cpuidle_init(&imx6q_cpuidle_driver);
 }
diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 4ea7ad9..cda7622 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -201,7 +201,12 @@ static void __init imx6q_init_machine(void)
 
 static void __init imx6q_init_late(void)
 {
-	imx6q_cpuidle_init();
+	/*
+	 * WAIT mode is broken on TO 1.0 and 1.1, so there is no point
+	 * to run cpuidle on them.
+	 */
+	if (imx6q_revision() > IMX_CHIP_REVISION_1_1)
+		imx6q_cpuidle_init();
 }
 
 static void __init imx6q_map_io(void)
diff --git a/arch/arm/mach-imx/platsmp.c b/arch/arm/mach-imx/platsmp.c
index 3777b80..a70b548 100644
--- a/arch/arm/mach-imx/platsmp.c
+++ b/arch/arm/mach-imx/platsmp.c
@@ -20,6 +20,8 @@
 #include "common.h"
 #include "hardware.h"
 
+#define SCU_STANDBY_ENABLE	(1 << 5)
+
 static void __iomem *scu_base;
 
 static struct map_desc scu_io_desc __initdata = {
@@ -42,6 +44,14 @@ void __init imx_scu_map_io(void)
 	scu_base = IMX_IO_ADDRESS(base);
 }
 
+void imx_scu_standby_enable(void)
+{
+	u32 val = readl_relaxed(scu_base);
+
+	val |= SCU_STANDBY_ENABLE;
+	writel_relaxed(val, scu_base);
+}
+
 static void __cpuinit imx_secondary_init(unsigned int cpu)
 {
 	/*
-- 
1.7.9.5
