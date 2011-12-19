From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 19 Dec 2011 04:47:41 -0500
Subject: [PATCH 12/20] ARM: mach-msm: hook special idle handlers to arm_pm_idle
In-Reply-To: <1324288069-21940-1-git-send-email-nico@fluxnic.net>
References: <1324288069-21940-1-git-send-email-nico@fluxnic.net>
Message-ID: <1324288069-21940-13-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-msm/idle.S                |   36 ----------------------
 arch/arm/mach-msm/idle.c                |   49 +++++++++++++++++++++++++++++++
 arch/arm/mach-msm/include/mach/system.h |    5 ++-
 3 files changed, 53 insertions(+), 37 deletions(-)
 delete mode 100644 arch/arm/mach-msm/idle.S
 create mode 100644 arch/arm/mach-msm/idle.c

diff --git a/arch/arm/mach-msm/idle.S b/arch/arm/mach-msm/idle.S
deleted file mode 100644
index 6a94f05271..0000000000
--- a/arch/arm/mach-msm/idle.S
+++ /dev/null
@@ -1,36 +0,0 @@
-/* arch/arm/mach-msm/include/mach/idle.S
- *
- * Idle processing for MSM7K - work around bugs with SWFI.
- *
- * Copyright (c) 2007 QUALCOMM Incorporated.
- * Copyright (C) 2007 Google, Inc. 
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- */ 
-		
-#include <linux/linkage.h>
-#include <asm/assembler.h>
-
-ENTRY(arch_idle)
-#ifdef CONFIG_MSM7X00A_IDLE
-	mrc     p15, 0, r1, c1, c0, 0    /* read current CR    */
-	bic     r0, r1, #(1 << 2)        /* clear dcache bit   */
-	bic     r0, r0, #(1 << 12)       /* clear icache bit   */
-	mcr     p15, 0, r0, c1, c0, 0    /* disable d/i cache  */
-
-	mov     r0, #0                   /* prepare wfi value  */
-	mcr     p15, 0, r0, c7, c10, 0   /* flush the cache    */
-	mcr     p15, 0, r0, c7, c10, 4   /* memory barrier     */
-	mcr     p15, 0, r0, c7, c0, 4    /* wait for interrupt */
-
-	mcr     p15, 0, r1, c1, c0, 0    /* restore d/i cache  */
-#endif
-	mov     pc, lr
diff --git a/arch/arm/mach-msm/idle.c b/arch/arm/mach-msm/idle.c
new file mode 100644
index 0000000000..f9c955f37f
--- /dev/null
+++ b/arch/arm/mach-msm/idle.c
@@ -0,0 +1,49 @@
+/* arch/arm/mach-msm/idle.c
+ *
+ * Idle processing for MSM7K - work around bugs with SWFI.
+ *
+ * Copyright (c) 2007 QUALCOMM Incorporated.
+ * Copyright (C) 2007 Google, Inc. 
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */ 
+
+#include <linux/init.h>
+#include <asm/system.h>
+
+static void msm_idle(void)
+{
+#ifdef CONFIG_MSM7X00A_IDLE
+	asm volatile (
+
+	"mrc     p15, 0, r1, c1, c0, 0    /* read current CR    */ \n\t"
+	"bic     r0, r1, #(1 << 2)        /* clear dcache bit   */ \n\t"
+	"bic     r0, r0, #(1 << 12)       /* clear icache bit   */ \n\t"
+	"mcr     p15, 0, r0, c1, c0, 0    /* disable d/i cache  */ \n\t"
+
+	"mov     r0, #0                   /* prepare wfi value  */ \n\t"
+	"mcr     p15, 0, r0, c7, c10, 0   /* flush the cache    */ \n\t"
+	"mcr     p15, 0, r0, c7, c10, 4   /* memory barrier     */ \n\t"
+	"mcr     p15, 0, r0, c7, c0, 4    /* wait for interrupt */ \n\t"
+
+	"mcr     p15, 0, r1, c1, c0, 0    /* restore d/i cache  */ \n\t"
+
+	: : : "r0","r1" );
+#endif
+}
+
+static int __init msm_idle_init(void)
+{
+	arm_pm_idle = msm_idle;
+	return 0;
+}
+
+arch_initcall(msm_idle_init);
diff --git a/arch/arm/mach-msm/include/mach/system.h b/arch/arm/mach-msm/include/mach/system.h
index 311db2b35d..f2c049526b 100644
--- a/arch/arm/mach-msm/include/mach/system.h
+++ b/arch/arm/mach-msm/include/mach/system.h
@@ -12,7 +12,10 @@
  * GNU General Public License for more details.
  *
  */
-void arch_idle(void);
+static inline void arch_idle(void)
+{
+	cpu_do_idle();
+}
 
 /* low level hardware reset hook -- for example, hitting the
  * PSHOLD line on the PMIC to hard reset the system
-- 
1.7.7.1.431.g10b2a
