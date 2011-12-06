From: rob.lee@linaro.org (Robert Lee)
Date: Mon,  5 Dec 2011 22:38:11 -0600
Subject: [RFC PATCH 8/8] ARM: imx: Add mx5 cpuidle implmentation
In-Reply-To: <1323146291-10676-1-git-send-email-rob.lee@linaro.org>
References: <1323146291-10676-1-git-send-email-rob.lee@linaro.org>
Message-ID: <1323146291-10676-9-git-send-email-rob.lee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add mx5 cpuidle implmentation based upon the common ARM cpuidle
initialization code.

Signed-off-by: Robert Lee <rob.lee@linaro.org>
---
 arch/arm/mach-mx5/Makefile  |    3 +-
 arch/arm/mach-mx5/cpuidle.c |   59 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-mx5/cpuidle.c

diff --git a/arch/arm/mach-mx5/Makefile b/arch/arm/mach-mx5/Makefile
index 0fc6080..2c348b4 100644
--- a/arch/arm/mach-mx5/Makefile
+++ b/arch/arm/mach-mx5/Makefile
@@ -3,8 +3,9 @@
 #
 
 # Object file lists.
-obj-y   := cpu.o mm.o clock-mx51-mx53.o ehci.o system.o
 
+obj-y   := cpu.o mm.o clock-mx51-mx53.o ehci.o system.o
+obj-$(CONFIG_CPU_IDLE) += cpuidle.o
 obj-$(CONFIG_PM) += pm-imx5.o
 obj-$(CONFIG_CPU_FREQ_IMX)    += cpu_op-mx51.o
 obj-$(CONFIG_MACH_MX51_BABBAGE) += board-mx51_babbage.o
diff --git a/arch/arm/mach-mx5/cpuidle.c b/arch/arm/mach-mx5/cpuidle.c
new file mode 100644
index 0000000..3584df5
--- /dev/null
+++ b/arch/arm/mach-mx5/cpuidle.c
@@ -0,0 +1,59 @@
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
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/export.h>
+#include <asm/proc-fns.h>
+#include <asm/cpuidle.h>
+#include <mach/common.h>
+
+static struct cpuidle_driver imx5_cpuidle_driver = {
+	.name	= "imx5_cpuidle",
+	.owner	= THIS_MODULE,
+	.states[0] = {
+		.exit_latency		= 12,
+		.flags			= CPUIDLE_FLAG_TIME_VALID,
+		.name			= "WFI",
+		.desc			= "idle cpu powered, unclocked.",
+	},
+	.states[1] = {
+		.exit_latency		= 20,
+		.flags			= CPUIDLE_FLAG_TIME_VALID,
+		.name			= "WFI SRPG",
+		.desc			= "idle cpu unpowered, unclocked.",
+	},
+	.state_count = 2,
+};
+
+int imx5_enter_idle(struct cpuidle_device *dev,
+			struct cpuidle_driver *drv,
+			      int index)
+{
+	if (likely(index))
+		mx5_cpu_lp_set(WAIT_UNCLOCKED_POWER_OFF);
+	else
+		mx5_cpu_lp_set(WAIT_UNCLOCKED);
+	cpu_do_idle();
+	return index;
+}
+
+static int __init imx5_init_cpuidle(void)
+{
+	int ret;
+
+	ret = arm_cpuidle_init(&imx5_cpuidle_driver,
+					imx5_enter_idle,
+					NULL);
+	return ret;
+}
+late_initcall(imx5_init_cpuidle);
-- 
1.7.1
