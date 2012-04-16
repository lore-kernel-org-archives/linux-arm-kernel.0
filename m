From: rob.lee@linaro.org (Robert Lee)
Date: Mon, 16 Apr 2012 18:50:14 -0500
Subject: [PATCH 3/3] ARM: imx: Add imx6q cpuidle driver
In-Reply-To: <1334620214-25803-1-git-send-email-rob.lee@linaro.org>
References: <1334620214-25803-1-git-send-email-rob.lee@linaro.org>
Message-ID: <1334620214-25803-4-git-send-email-rob.lee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add basic imx6q cpuidle driver.  For now, only basic WFI state is
supported.  Deeper idle states will be added in the future.

Signed-off-by: Robert Lee <rob.lee@linaro.org>
---
 arch/arm/mach-imx/Makefile        |    2 +-
 arch/arm/mach-imx/cpuidle-imx6q.c |   33 +++++++++++++++++++++++++++++++++
 arch/arm/mach-imx/mach-imx6q.c    |    2 ++
 3 files changed, 36 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-imx/cpuidle-imx6q.c

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 84b8976..530f0fd 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -70,7 +70,7 @@ obj-$(CONFIG_CPU_V7) += head-v7.o
 AFLAGS_head-v7.o :=-Wa,-march=armv7-a
 obj-$(CONFIG_SMP) += platsmp.o
 obj-$(CONFIG_HOTPLUG_CPU) += hotplug.o
-obj-$(CONFIG_SOC_IMX6Q) += clock-imx6q.o mach-imx6q.o
+obj-$(CONFIG_SOC_IMX6Q) += clock-imx6q.o mach-imx6q.o cpuidle-imx6q.o
 
 ifeq ($(CONFIG_PM),y)
 obj-$(CONFIG_SOC_IMX6Q) += pm-imx6q.o
diff --git a/arch/arm/mach-imx/cpuidle-imx6q.c b/arch/arm/mach-imx/cpuidle-imx6q.c
new file mode 100644
index 0000000..b74557f
--- /dev/null
+++ b/arch/arm/mach-imx/cpuidle-imx6q.c
@@ -0,0 +1,33 @@
+/*
+ * Copyright 2012 Freescale Semiconductor, Inc.
+ * Copyright 2012 Linaro Ltd.
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
+#include <linux/cpuidle.h>
+#include <linux/export.h>
+#include <asm/cpuidle.h>
+#include <mach/cpuidle.h>
+
+static struct cpuidle_driver imx6q_cpuidle_driver = {
+	.name			= "imx6q_cpuidle",
+	.owner			= THIS_MODULE,
+	.en_core_tk_irqen	= 1,
+	.states[0]		= ARM_CPUIDLE_WFI_STATE,
+	.state_count		= 1,
+};
+
+int __init imx6q_cpuidle_init(void)
+{
+	imx_cpuidle_set_driver(&imx6q_cpuidle_driver);
+
+	return 0;
+}
diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index da6c1d9..6f31ca6 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -29,6 +29,7 @@
 #include <asm/system_misc.h>
 #include <mach/common.h>
 #include <mach/hardware.h>
+#include <mach/cpuidle.h>
 
 void imx6q_restart(char mode, const char *cmd)
 {
@@ -84,6 +85,7 @@ static void __init imx6q_init_machine(void)
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 
 	imx6q_pm_init();
+	imx6q_cpuidle_init();
 }
 
 static void __init imx6q_map_io(void)
-- 
1.7.10
