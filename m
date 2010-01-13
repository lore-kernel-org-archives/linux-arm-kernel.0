From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 14 Jan 2010 08:45:47 +0900
Subject: [PATCH v2 3/3] ARM: SAMSUNG: Add idle support
Message-ID: <1263426347-13668-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds common idle functionality for all Samsung SoC's.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/plat-samsung/include/mach/idle.h   |   19 +++++++++++++
 arch/arm/plat-samsung/include/mach/system.h |   39 +++++++++++++++++++++++++++
 2 files changed, 58 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-samsung/include/mach/idle.h
 create mode 100644 arch/arm/plat-samsung/include/mach/system.h

diff --git a/arch/arm/plat-samsung/include/mach/idle.h b/arch/arm/plat-samsung/include/mach/idle.h
new file mode 100644
index 0000000..b5b92d2
--- /dev/null
+++ b/arch/arm/plat-samsung/include/mach/idle.h
@@ -0,0 +1,19 @@
+/* linux/arch/arm/plat-samsung/include/mach/idle.h
+ *
+ * Copyright (c) 2009 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * Idle support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_PLAT_IDLE_H
+#define __ASM_PLAT_IDLE_H __FILE__
+
+extern void (*s3c_idle_fn)(void);
+extern void samsung_idle(void);
+
+#endif /* __ASM_PLAT_IDLE_H */
diff --git a/arch/arm/plat-samsung/include/mach/system.h b/arch/arm/plat-samsung/include/mach/system.h
new file mode 100644
index 0000000..1e49fb3
--- /dev/null
+++ b/arch/arm/plat-samsung/include/mach/system.h
@@ -0,0 +1,39 @@
+/* linux/arch/arm/plat-samsung/include/mach/idle.h
+ *
+ * Copyright (c) 2009 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * Idle support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_PLAT_SYSTEM_H
+#define __ASM_PLAT_SYSTEM_H __FILE__
+
+void (*s3c_idle_fn)(void);
+
+void samsung_idle(void)
+{
+	/* can add generic idle functionality here, if any */
+
+	if (!need_resched()) {
+		if (s3c_idle_fn != NULL)
+			(s3c_idle_fn)();
+	}
+	local_irq_enable();
+}
+
+static void arch_idle(void)
+{
+	/* nothing */
+}
+
+static void arch_reset(char mode, const char *cmd)
+{
+	/* nothing here yet */
+}
+
+#endif /* __ASM_PLAT_SYSTEM_H */
-- 
1.6.2.5
