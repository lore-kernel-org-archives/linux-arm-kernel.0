From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 27 May 2013 17:59:51 +0900
Subject: [PATCH 10/12] ARM: shmobile: r8a7740: Add CPUIdle
In-Reply-To: <1369645193-3595-1-git-send-email-horms+renesas@verge.net.au>
References: <1369645193-3595-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1369645193-3595-11-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bastian Hecht <hechtb@gmail.com>

We make use of the r8a7740 Suspend To Ram code to plug together a
CPUIdle driver.

Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-shmobile/Makefile               |    2 +-
 arch/arm/mach-shmobile/cpuidle-r8a7740.c      |   62 +++++++++++++++++++++++++
 arch/arm/mach-shmobile/include/mach/r8a7740.h |    1 +
 arch/arm/mach-shmobile/pm-r8a7740.c           |    1 +
 4 files changed, 65 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-shmobile/cpuidle-r8a7740.c

diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index 0568894..2852dcf 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -30,7 +30,7 @@ obj-$(CONFIG_SUSPEND)		+= suspend.o
 obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
 obj-$(CONFIG_ARCH_SHMOBILE)	+= pm-rmobile.o
 obj-$(CONFIG_ARCH_SH7372)	+= pm-sh7372.o sleep-sh7372.o
-obj-$(CONFIG_ARCH_R8A7740)	+= pm-r8a7740.o sleep-r8a7740.o
+obj-$(CONFIG_ARCH_R8A7740)	+= pm-r8a7740.o sleep-r8a7740.o cpuidle-r8a7740.o
 obj-$(CONFIG_ARCH_R8A7779)	+= pm-r8a7779.o
 obj-$(CONFIG_ARCH_SH73A0)	+= pm-sh73a0.o
 
diff --git a/arch/arm/mach-shmobile/cpuidle-r8a7740.c b/arch/arm/mach-shmobile/cpuidle-r8a7740.c
new file mode 100644
index 0000000..48c7a6c
--- /dev/null
+++ b/arch/arm/mach-shmobile/cpuidle-r8a7740.c
@@ -0,0 +1,62 @@
+/*
+ * CPUIdle code for SoC r8a7740
+ *
+ * Copyright (C) 2013 Bastian Hecht
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+#include <linux/cpuidle.h>
+#include <linux/module.h>
+#include <asm/cpuidle.h>
+#include <mach/common.h>
+#include <mach/r8a7740.h>
+
+#if defined(CONFIG_SUSPEND) && defined(CONFIG_CPU_IDLE)
+static int r8a7740_enter_a3sm_pll_on(struct cpuidle_device *dev,
+					struct cpuidle_driver *drv, int index)
+{
+	r8a7740_enter_a3sm_common(1);
+	return 1;
+}
+
+static int r8a7740_enter_a3sm_pll_off(struct cpuidle_device *dev,
+					struct cpuidle_driver *drv, int index)
+{
+	r8a7740_enter_a3sm_common(0);
+	return 2;
+}
+
+static struct cpuidle_driver r8a7740_cpuidle_driver = {
+	.name			= "r8a7740_cpuidle",
+	.owner			= THIS_MODULE,
+	.en_core_tk_irqen	= 1,
+	.state_count		= 3,
+	.safe_state_index	= 0, /* C1 */
+	.states[0] = ARM_CPUIDLE_WFI_STATE,
+	.states[1] = {
+		.name = "C2",
+		.desc = "A3SM PLL ON",
+		.exit_latency = 40,
+		.target_residency = 30 + 40,
+		.flags = CPUIDLE_FLAG_TIME_VALID,
+		.enter = r8a7740_enter_a3sm_pll_on,
+	},
+	.states[2] = {
+		.name = "C3",
+		.desc = "A3SM PLL OFF",
+		.exit_latency = 120,
+		.target_residency = 30 + 120,
+		.flags = CPUIDLE_FLAG_TIME_VALID,
+		.enter = r8a7740_enter_a3sm_pll_off,
+	},
+};
+
+void r8a7740_cpuidle_init(void)
+{
+	shmobile_cpuidle_set_driver(&r8a7740_cpuidle_driver);
+}
+#else
+void r8a7740_cpuidle_init(void) {}
+#endif
diff --git a/arch/arm/mach-shmobile/include/mach/r8a7740.h b/arch/arm/mach-shmobile/include/mach/r8a7740.h
index 5cfe5d9..3b538e3 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7740.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7740.h
@@ -545,6 +545,7 @@ extern void r8a7740_pinmux_init(void);
 extern void r8a7740_pm_init(void);
 extern void r8a7740_resume(void);
 extern void r8a7740_shutdown(void);
+extern void r8a7740_cpuidle_init(void);
 extern void r8a7740_enter_a3sm_common(int);
 
 #ifdef CONFIG_PM
diff --git a/arch/arm/mach-shmobile/pm-r8a7740.c b/arch/arm/mach-shmobile/pm-r8a7740.c
index fe3c867..2f196bd 100644
--- a/arch/arm/mach-shmobile/pm-r8a7740.c
+++ b/arch/arm/mach-shmobile/pm-r8a7740.c
@@ -237,4 +237,5 @@ static void r8a7740_suspend_init(void) {}
 void __init r8a7740_pm_init(void)
 {
 	r8a7740_suspend_init();
+	r8a7740_cpuidle_init();
 }
-- 
1.7.10.4
