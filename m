From: rob.lee@linaro.org (Robert Lee)
Date: Fri, 16 Sep 2011 12:27:49 -0500
Subject: [PATCH v2 2/3] ARM: imx: Add cpuidle for mach-mx5
In-Reply-To: <1316194070-21889-1-git-send-email-rob.lee@linaro.org>
References: <1316194070-21889-1-git-send-email-rob.lee@linaro.org>
Message-ID: <1316194070-21889-3-git-send-email-rob.lee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add functionality for initialization and handling of a cpuidle driver
requests entering a cpu idle state.

Signed-off-by: Robert Lee <rob.lee@linaro.org>
---
 arch/arm/mach-mx5/system.c              |   35 +++++++++++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/system.h |    3 ++
 2 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx5/system.c b/arch/arm/mach-mx5/system.c
index 76ae8dc..85d6dd7 100644
--- a/arch/arm/mach-mx5/system.c
+++ b/arch/arm/mach-mx5/system.c
@@ -12,7 +12,11 @@
  */
 #include <linux/platform_device.h>
 #include <linux/io.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <asm/proc-fns.h>
 #include <mach/hardware.h>
+#include <mach/cpuidle.h>
 #include "crm_regs.h"
 
 /* set cpu low power mode before WFI instruction. This function is called
@@ -82,3 +86,34 @@ void mx5_cpu_lp_set(enum mxc_cpu_pwr_mode mode)
 		__raw_writel(empgc1, MXC_SRPG_EMPGC1_SRPGCR);
 	}
 }
+
+int mx5_cpuidle(struct cpuidle_device *dev, struct cpuidle_state *state)
+{
+	mx5_cpu_lp_set((enum mxc_cpu_pwr_mode)state->driver_data);
+
+	cpu_do_idle();
+
+	return 0;
+}
+
+int __init mx5_cpuidle_init(void * init_data)
+{
+	int ret;
+	struct clk *gpc_dvfs_clk;
+
+	gpc_dvfs_clk = clk_get(NULL, "gpc_dvfs");
+
+	if (IS_ERR(gpc_dvfs_clk)) {
+		pr_err("%s: Failed to get gpc_dvfs clock\n", __func__);
+		return (int)gpc_dvfs_clk;
+	}
+
+	ret = clk_enable(gpc_dvfs_clk);
+
+	if (IS_ERR(&ret)) {
+		pr_err("%s: Failed to enable gpc_dvfs clock\n", __func__);
+		return ret;
+	}
+
+	return 0;
+}
diff --git a/arch/arm/plat-mxc/include/mach/system.h b/arch/arm/plat-mxc/include/mach/system.h
index 51f02a9..f7c4be5 100644
--- a/arch/arm/plat-mxc/include/mach/system.h
+++ b/arch/arm/plat-mxc/include/mach/system.h
@@ -17,10 +17,13 @@
 #ifndef __ASM_ARCH_MXC_SYSTEM_H__
 #define __ASM_ARCH_MXC_SYSTEM_H__
 
+#include <linux/cpuidle.h>
 #include <mach/hardware.h>
 #include <mach/common.h>
 
 extern void mx5_cpu_lp_set(enum mxc_cpu_pwr_mode mode);
+extern int mx5_cpuidle_init(void *init_data);
+extern int mx5_cpuidle(struct cpuidle_device *dev, struct cpuidle_state *state);
 
 static inline void arch_idle(void)
 {
-- 
1.7.1
