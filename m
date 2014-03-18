From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 18 Mar 2014 10:20:27 +0000
Subject: [PATCH RFC 3/4] drivers: cpuidle: CPU idle ARM64 driver
In-Reply-To: <1395138028-19630-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1395138028-19630-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1395138028-19630-4-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch implements a generic CPU idle driver for ARM64 machines.

It relies on the ARM idle states infrastructure to initialize idle
states count and respective parameters. Current code assumes the driver
is managing idle states on all possible CPUs but can be easily
generalized to support heterogenous systems and build cpumasks at
runtime using MIDRs or DT cpu nodes compatible properties.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 drivers/cpuidle/Kconfig         |  5 +++++
 drivers/cpuidle/Kconfig.arm64   | 13 +++++++++++++
 drivers/cpuidle/Makefile        |  4 ++++
 drivers/cpuidle/cpuidle-arm64.c | 41 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 63 insertions(+)
 create mode 100644 drivers/cpuidle/Kconfig.arm64
 create mode 100644 drivers/cpuidle/cpuidle-arm64.c

diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
index f04e25f..9b3f613 100644
--- a/drivers/cpuidle/Kconfig
+++ b/drivers/cpuidle/Kconfig
@@ -35,6 +35,11 @@ depends on ARM
 source "drivers/cpuidle/Kconfig.arm"
 endmenu
 
+menu "ARM64 CPU Idle Drivers"
+depends on ARM64
+source "drivers/cpuidle/Kconfig.arm64"
+endmenu
+
 menu "POWERPC CPU Idle Drivers"
 depends on PPC
 source "drivers/cpuidle/Kconfig.powerpc"
diff --git a/drivers/cpuidle/Kconfig.arm64 b/drivers/cpuidle/Kconfig.arm64
new file mode 100644
index 0000000..42af83a
--- /dev/null
+++ b/drivers/cpuidle/Kconfig.arm64
@@ -0,0 +1,13 @@
+#
+# ARM64 CPU Idle drivers
+#
+
+config ARM64_CPUIDLE
+	bool "Generic ARM64 CPU idle Driver"
+	select ARM64_IDLE_STATES
+	help
+	  Select this to enable generic cpuidle driver for ARM v8.
+	  It provides a generic idle driver whose idle states are configured
+	  at run-time through DT nodes. Idle protocol backends are initialized
+	  by the device tree parsing code on matching the entry method for
+	  the respective protocol.
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index f71ae1b..4051b37 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -15,6 +15,10 @@ obj-$(CONFIG_ARM_U8500_CPUIDLE)         += cpuidle-ux500.o
 obj-$(CONFIG_ARM_AT91_CPUIDLE)          += cpuidle-at91.o
 
 ###############################################################################
+# ARM64 drivers
+obj-$(CONFIG_ARM64_CPUIDLE)		+= cpuidle-arm64.o
+
+###############################################################################
 # POWERPC drivers
 obj-$(CONFIG_PSERIES_CPUIDLE)		+= cpuidle-pseries.o
 obj-$(CONFIG_POWERNV_CPUIDLE)		+= cpuidle-powernv.o
diff --git a/drivers/cpuidle/cpuidle-arm64.c b/drivers/cpuidle/cpuidle-arm64.c
new file mode 100644
index 0000000..08ffe16
--- /dev/null
+++ b/drivers/cpuidle/cpuidle-arm64.c
@@ -0,0 +1,41 @@
+/*
+ * ARM64 generic CPU idle driver.
+ *
+ * Copyright (C) 2014 ARM Ltd.
+ * Author: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/cpuidle.h>
+#include <linux/cpumask.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+#include <asm/idle_states.h>
+
+struct cpuidle_driver arm64_idle_driver = {
+	.name = "arm64_idle",
+	.owner = THIS_MODULE,
+};
+
+/*
+ * arm64_idle_init
+ *
+ * Registers the arm specific cpuidle driver with the cpuidle
+ * framework. It relies on core code to parse the idle states
+ * and initialize them in the driver accordingly.
+ */
+static int __init arm64_idle_init(void)
+{
+	int ret;
+
+	arm64_idle_driver.cpumask = (struct cpumask *) cpu_possible_mask;
+	ret = arm_init_idle_driver(&arm64_idle_driver);
+	if (ret)
+		return ret;
+	return cpuidle_register(&arm64_idle_driver, NULL);
+}
+device_initcall(arm64_idle_init);
-- 
1.8.4
