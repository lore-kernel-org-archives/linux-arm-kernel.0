From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue,  6 Sep 2011 17:58:40 +0800
Subject: [PATCH 6/6] arm/imx6q: add suspend/resume support
In-Reply-To: <1315303120-24203-1-git-send-email-shawn.guo@linaro.org>
References: <1315303120-24203-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1315303120-24203-7-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It adds suspend/resume support for imx6q.

Signed-off-by: Anson Huang <b20788@freescale.com>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/Makefile              |    2 +-
 arch/arm/mach-imx/pm-imx6q.c            |   63 +++++++++++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/common.h |   12 ++++++
 3 files changed, 76 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-imx/pm-imx6q.c

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 84bd18c..531da76 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -70,5 +70,5 @@ obj-$(CONFIG_CPU_V7) += head-v7.o
 obj-$(CONFIG_SMP) += platsmp.o
 obj-$(CONFIG_HOTPLUG_CPU) += hotplug.o
 obj-$(CONFIG_LOCAL_TIMERS) += localtimer.o
-obj-$(CONFIG_SOC_IMX6Q) += clock-imx6q.o
+obj-$(CONFIG_SOC_IMX6Q) += clock-imx6q.o pm-imx6q.o
 obj-$(CONFIG_MACH_IMX6Q) += mach-imx6q.o
diff --git a/arch/arm/mach-imx/pm-imx6q.c b/arch/arm/mach-imx/pm-imx6q.c
new file mode 100644
index 0000000..cbbc3c8
--- /dev/null
+++ b/arch/arm/mach-imx/pm-imx6q.c
@@ -0,0 +1,63 @@
+/*
+ * Copyright 2011 Freescale Semiconductor, Inc.
+ * Copyright 2011 Linaro Ltd.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/suspend.h>
+#include <asm/proc-fns.h>
+#include <asm/suspend.h>
+#include <asm/hardware/cache-l2x0.h>
+#include <asm/hardware/gic.h>
+#include <mach/common.h>
+
+static int imx6q_suspend_finish(unsigned long val)
+{
+	cpu_do_idle();
+	return 0;
+}
+
+static int imx6q_pm_enter(suspend_state_t state)
+{
+	switch (state) {
+	case PM_SUSPEND_MEM:
+		imx_local_timer_pre_suspend();
+		imx_gpc_pre_suspend();
+		outer_flush_all();
+		outer_disable();
+		imx_set_cpu_jump(0, v7_cpu_resume);
+
+		/* Zzz ... */
+		cpu_suspend(0, imx6q_suspend_finish);
+
+		imx_smp_prepare();
+		l2x0_of_init(0, ~0UL);
+		imx_gpc_post_resume();
+		imx_local_timer_post_resume();
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct platform_suspend_ops imx6q_pm_ops = {
+	.enter = imx6q_pm_enter,
+	.valid = suspend_valid_only_mem,
+};
+
+static int __init imx6q_pm_init(void)
+{
+	suspend_set_ops(&imx6q_pm_ops);
+	return 0;
+}
+late_initcall(imx6q_pm_init);
diff --git a/arch/arm/plat-mxc/include/mach/common.h b/arch/arm/plat-mxc/include/mach/common.h
index ff86063..7c3d078 100644
--- a/arch/arm/plat-mxc/include/mach/common.h
+++ b/arch/arm/plat-mxc/include/mach/common.h
@@ -80,12 +80,24 @@ extern void imx_lluart_map_io(void);
 #else
 static inline void imx_lluart_map_io(void) {}
 #endif
+extern void v7_cpu_resume(void);
 #ifdef CONFIG_SMP
 extern void imx_scu_map_io(void);
+extern void imx_smp_prepare(void);
 #else
 static inline void imx_scu_map_io(void) {}
+static inline void imx_smp_prepare(void) {}
 #endif
 extern void imx_enable_cpu(int cpu, bool enable);
 extern void imx_set_cpu_jump(int cpu, void *jump_addr);
 extern void imx_gpc_init(void);
+extern void imx_gpc_pre_suspend(void);
+extern void imx_gpc_post_resume(void);
+#ifdef CONFIG_LOCAL_TIMERS
+extern void imx_local_timer_pre_suspend(void);
+extern void imx_local_timer_post_resume(void);
+#else
+static inline void imx_local_timer_pre_suspend(void) {}
+static inline void imx_local_timer_post_resume(void) {}
+#endif
 #endif
-- 
1.7.4.1
