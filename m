From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 23 Jul 2010 21:43:58 +0900
Subject: [PATCH 1/2] ARM: S5P: Add s5p_reset_hook() for perform reset using
	SWRESET on S5P SoCs
In-Reply-To: <1279889039-9718-1-git-send-email-kgene.kim@samsung.com>
References: <1279889039-9718-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1279889039-9718-2-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jongpill Lee <boyko.lee@samsung.com>

This patch adds s5p_reset_hook() which includes software reset
by using SWRESET.

Signed-off-by: Jongpill Lee <boyko.lee@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/plat-s5p/include/plat/reset.h        |   16 ++++++++++++++++
 arch/arm/plat-s5p/include/plat/system-reset.h |   11 +++++++++--
 2 files changed, 25 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/plat-s5p/include/plat/reset.h

diff --git a/arch/arm/plat-s5p/include/plat/reset.h b/arch/arm/plat-s5p/include/plat/reset.h
new file mode 100644
index 0000000..335e978
--- /dev/null
+++ b/arch/arm/plat-s5p/include/plat/reset.h
@@ -0,0 +1,16 @@
+/* linux/arch/arm/plat-s5p/include/plat/reset.h
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_PLAT_S5P_RESET_H
+#define __ASM_PLAT_S5P_RESET_H __FILE__
+
+extern void (*s5p_reset_hook)(void);
+
+#endif /* __ASM_PLAT_S5P_RESET_H */
diff --git a/arch/arm/plat-s5p/include/plat/system-reset.h b/arch/arm/plat-s5p/include/plat/system-reset.h
index 7f76a16..f307f34 100644
--- a/arch/arm/plat-s5p/include/plat/system-reset.h
+++ b/arch/arm/plat-s5p/include/plat/system-reset.h
@@ -14,10 +14,17 @@
 
 #include <plat/watchdog-reset.h>
 
+void (*s5p_reset_hook)(void);
+
 static void arch_reset(char mode, const char *cmd)
 {
-	/* Perform reset using Watchdog reset.
-	 * SWRESET support will be added later.
+	/* SWRESET support in s5p_reset_hook() */
+
+	if (s5p_reset_hook)
+		s5p_reset_hook();
+
+	/* Perform reset using Watchdog reset
+	 * if there is no s5p_reset_hook()
 	 */
 
 	arch_wdt_reset();
-- 
1.6.2.5
