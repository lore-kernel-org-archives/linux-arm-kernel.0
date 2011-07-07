From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu,  7 Jul 2011 16:50:21 +0100
Subject: [RFC PATCH 08/17] ARM: kernel: save/restore arch runtime support
In-Reply-To: <1310053830-23779-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1310053830-23779-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1310053830-23779-9-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces a simple infrastructure to initialize
save/restore at run-time depending on the HW processor id.

It defines an array of structures containing function pointers that
can be called to manage low power state.

The arch pointer is initialized at run-time in lookup_arch() on id matching.

Fully tested on A9 dual core CPU. A8, A5 support compile tested.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm/kernel/sr_arch.c |   74 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 74 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/kernel/sr_arch.c

diff --git a/arch/arm/kernel/sr_arch.c b/arch/arm/kernel/sr_arch.c
new file mode 100644
index 0000000..c9f7dbe
--- /dev/null
+++ b/arch/arm/kernel/sr_arch.c
@@ -0,0 +1,74 @@
+/*
+ * Copyright (C) 2008-2011 ARM Limited
+ * Author(s): Jon Callan, Lorenzo Pieralisi
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/pm.h>
+#include <linux/cache.h>
+#include <linux/compiler.h>
+#include <linux/errno.h>
+
+#include <asm/cacheflush.h>
+#include <asm/system.h>
+#include <asm/cputype.h>
+#include <asm/cpu_pm.h>
+#include <asm/lb_lock.h>
+#include <asm/sr_platform_api.h>
+#include "sr_helpers.h"
+#include "sr.h"
+
+
+#include "sr_v7.c"
+
+extern void platform_a8_reset_handler(void);
+extern void platform_a9_reset_handler(void);
+
+struct sr_arch *arch;
+
+struct sr_arch archs[] = {
+	{
+	 .cpu_val = CPU_A8,
+	 .cpu_mask = 0xff0ffff0,
+	 .init = sr_platform_a8_init,
+	 .save_context = sr_platform_a8_save_context,
+	 .restore_context = sr_platform_a8_restore_context,
+	 .enter_cstate = sr_platform_a8_enter_cstate,
+	 .leave_cstate = sr_platform_a8_leave_cstate,
+	 .reset = platform_a8_reset_handler},
+	{
+	 .cpu_val = CPU_A9,
+	 .cpu_mask = 0xff0ffff0,
+	 .init = sr_platform_a9_init,
+	 .save_context = sr_platform_a9_save_context,
+	 .restore_context = sr_platform_a9_restore_context,
+	 .enter_cstate = sr_platform_a9_enter_cstate,
+	 .leave_cstate = sr_platform_a9_leave_cstate,
+	 .reset = platform_a9_reset_handler},
+	{
+	 .cpu_val = CPU_A5,
+	 .cpu_mask = 0xff0ffff0,
+	 .init = sr_platform_a9_init,
+	 .save_context = sr_platform_a9_save_context,
+	 .restore_context = sr_platform_a9_restore_context,
+	 .enter_cstate = sr_platform_a9_enter_cstate,
+	 .leave_cstate = sr_platform_a9_leave_cstate,
+	 .reset = platform_a9_reset_handler},
+	{
+	 .cpu_val = 0x0}
+};
+
+int lookup_arch(void)
+{
+	struct sr_arch *ap = NULL;
+	for (ap = archs; ap->cpu_val; ap++)
+		if ((read_cpuid_id() & ap->cpu_mask) == ap->cpu_val) {
+			arch = ap;
+			return 0;
+		}
+	return -ENXIO;
+}
-- 
1.7.4.4
