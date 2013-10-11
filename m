From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 10 Oct 2013 20:15:22 -0400
Subject: [PATCH v2 4/4] ARM: keystone: add PM bus support for clock
 management
In-Reply-To: <1377819404-9671-5-git-send-email-santosh.shilimkar@ti.com>
References: <1377819404-9671-1-git-send-email-santosh.shilimkar@ti.com>
 <1377819404-9671-5-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <5257431A.5090301@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 29 August 2013 07:36 PM, Santosh Shilimkar wrote:
> Add runtime PM core support to Keystone SOCs by using the pm_clk
> infrastructure of the PM core. Patch is based on Kevin's pm_domain
> work on DaVinci SOCs.
> 
> Keystone SOC doesn't have depedency to enable clocks in early
> in the boot and hence the clock and PM bus initialisation is done
> at subsys_init() level.
> 
> Cc: Kevin Hilman <khilman@linaro.org>
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
For record, updated patch end of the email as discussed here [1]

Regards,
Santosh

[1] http://www.spinics.net/lists/arm-kernel/msg278991.html


>From fc20ffe1213beb09bb7fb6687b404fe48183a55e Mon Sep 17 00:00:00 2001
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Sun, 14 Jul 2013 17:17:39 -0400
Subject: [PATCH 4/4] ARM: keystone: add PM domain support for clock
 management

Add runtime PM core support to Keystone SOCs by using the pm_clk
infrastructure of the PM core. Patch is based on Kevin's pm_domain
work on DaVinci SOCs.

Keystone SOC doesn't have dependency to enable clocks in early
in the boot and hence the clock and PM domain initialisation is done
at subsys_init() level.

Cc: Kevin Hilman <khilman@linaro.org>

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-keystone/Makefile    |    3 ++
 arch/arm/mach-keystone/pm_domain.c |   70 ++++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+)
 create mode 100644 arch/arm/mach-keystone/pm_domain.c

diff --git a/arch/arm/mach-keystone/Makefile b/arch/arm/mach-keystone/Makefile
index ddc52b0..25d9239 100644
--- a/arch/arm/mach-keystone/Makefile
+++ b/arch/arm/mach-keystone/Makefile
@@ -4,3 +4,6 @@ plus_sec := $(call as-instr,.arch_extension sec,+sec)
 AFLAGS_smc.o				:=-Wa,-march=armv7-a$(plus_sec)
 
 obj-$(CONFIG_SMP)			+= platsmp.o
+
+# PM domain driver for Keystone SOCs
+obj-$(CONFIG_ARCH_KEYSTONE)		+= pm_domain.o
diff --git a/arch/arm/mach-keystone/pm_domain.c b/arch/arm/mach-keystone/pm_domain.c
new file mode 100644
index 0000000..beac3fb
--- /dev/null
+++ b/arch/arm/mach-keystone/pm_domain.c
@@ -0,0 +1,70 @@
+/*
+ * PM domain driver for Keystone2 devices
+ *
+ * Copyright 2013 Texas Instruments, Inc.
+ *	Santosh Shilimkar <santosh.shillimkar@ti.com>
+ *
+ * Based on Kevins work on DAVINCI SOCs
+ *	Kevin Hilman <khilman@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/pm_runtime.h>
+#include <linux/pm_clock.h>
+#include <linux/platform_device.h>
+#include <linux/clk-provider.h>
+
+#ifdef CONFIG_PM_RUNTIME
+static int keystone_pm_runtime_suspend(struct device *dev)
+{
+	int ret;
+
+	dev_dbg(dev, "%s\n", __func__);
+
+	ret = pm_generic_runtime_suspend(dev);
+	if (ret)
+		return ret;
+
+	ret = pm_clk_suspend(dev);
+	if (ret) {
+		pm_generic_runtime_resume(dev);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int keystone_pm_runtime_resume(struct device *dev)
+{
+	dev_dbg(dev, "%s\n", __func__);
+
+	pm_clk_resume(dev);
+
+	return pm_generic_runtime_resume(dev);
+}
+#endif
+
+static struct dev_pm_domain keystone_pm_domain = {
+	.ops = {
+		SET_RUNTIME_PM_OPS(keystone_pm_runtime_suspend,
+				   keystone_pm_runtime_resume, NULL)
+		USE_PLATFORM_PM_SLEEP_OPS
+	},
+};
+
+static struct pm_clk_notifier_block platform_domain_notifier = {
+	.pm_domain = &keystone_pm_domain,
+};
+
+int __init keystone_pm_runtime_init(void)
+{
+	of_clk_init(NULL);
+	pm_clk_add_notifier(&platform_bus_type, &platform_domain_notifier);
+
+	return 0;
+}
+subsys_initcall(keystone_pm_runtime_init);
-- 
1.7.9.5
