From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 29 Mar 2013 17:00:57 +0800
Subject: [PATCH 1/3] ARM: mxs: call mxs_pm_init() as a machine_desc hook
In-Reply-To: <1364547659-30574-1-git-send-email-shawn.guo@linaro.org>
References: <1364547659-30574-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1364547659-30574-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The device_initcall is not a friend of multiplatform build.  Call
mxs_pm_init() as a machine_desc hook instead of device_initcall.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-mxs/mach-mxs.c |    3 +++
 arch/arm/mach-mxs/pm.c       |    4 +---
 arch/arm/mach-mxs/pm.h       |   14 ++++++++++++++
 3 files changed, 18 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/mach-mxs/pm.h

diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
index 2efe84b..59be54e 100644
--- a/arch/arm/mach-mxs/mach-mxs.c
+++ b/arch/arm/mach-mxs/mach-mxs.c
@@ -32,6 +32,8 @@
 #include <asm/mach/time.h>
 #include <asm/system_misc.h>
 
+#include "pm.h"
+
 /* MXS DIGCTL SAIF CLKMUX */
 #define MXS_DIGCTL_SAIF_CLKMUX_DIRECT		0x0
 #define MXS_DIGCTL_SAIF_CLKMUX_CROSSINPUT	0x1
@@ -607,6 +609,7 @@ DT_MACHINE_START(MXS, "Freescale MXS (Device Tree)")
 	.handle_irq	= icoll_handle_irq,
 	.init_time	= mxs_timer_init,
 	.init_machine	= mxs_machine_init,
+	.init_late      = mxs_pm_init,
 	.dt_compat	= mxs_dt_compat,
 	.restart	= mxs_restart,
 MACHINE_END
diff --git a/arch/arm/mach-mxs/pm.c b/arch/arm/mach-mxs/pm.c
index a9b4bbc..b2494d2 100644
--- a/arch/arm/mach-mxs/pm.c
+++ b/arch/arm/mach-mxs/pm.c
@@ -34,9 +34,7 @@ static struct platform_suspend_ops mxs_suspend_ops = {
 	.valid = suspend_valid_only_mem,
 };
 
-static int __init mxs_pm_init(void)
+void __init mxs_pm_init(void)
 {
 	suspend_set_ops(&mxs_suspend_ops);
-	return 0;
 }
-device_initcall(mxs_pm_init);
diff --git a/arch/arm/mach-mxs/pm.h b/arch/arm/mach-mxs/pm.h
new file mode 100644
index 0000000..f57e7cd
--- /dev/null
+++ b/arch/arm/mach-mxs/pm.h
@@ -0,0 +1,14 @@
+/*
+ * Copyright (C) 2013 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ARCH_MXS_PM_H
+#define __ARCH_MXS_PM_H
+
+void mxs_pm_init(void);
+
+#endif
-- 
1.7.9.5
