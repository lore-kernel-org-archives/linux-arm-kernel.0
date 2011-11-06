From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 06 Nov 2011 17:44:21 +0000
Subject: [PATCH 13/41] ARM: restart: integrator: use new restart hook
In-Reply-To: <20111106173113.GI12913@n2100.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
Message-ID: <E1RN6lZ-0001XR-VU@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hook these platforms restart code into the new restart hook rather
than using arch_reset().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-integrator/common.h              |    1 +
 arch/arm/mach-integrator/core.c                |    8 ++++++++
 arch/arm/mach-integrator/include/mach/system.h |    7 -------
 arch/arm/mach-integrator/integrator_ap.c       |    1 +
 arch/arm/mach-integrator/integrator_cp.c       |    1 +
 5 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-integrator/common.h b/arch/arm/mach-integrator/common.h
index a08f9b0..899561d 100644
--- a/arch/arm/mach-integrator/common.h
+++ b/arch/arm/mach-integrator/common.h
@@ -1,2 +1,3 @@
 void integrator_init_early(void);
 void integrator_reserve(void);
+void integrator_restart(char, const char *);
diff --git a/arch/arm/mach-integrator/core.c b/arch/arm/mach-integrator/core.c
index 4b38e13..0a3e097 100644
--- a/arch/arm/mach-integrator/core.c
+++ b/arch/arm/mach-integrator/core.c
@@ -238,3 +238,11 @@ void __init integrator_reserve(void)
 {
 	memblock_reserve(PHYS_OFFSET, __pa(swapper_pg_dir) - PHYS_OFFSET);
 }
+
+/*
+ * To reset, we hit the on-board reset register in the system FPGA
+ */
+void integrator_restart(char mode, const char *cmd)
+{
+	cm_control(CM_CTRL_RESET, CM_CTRL_RESET);
+}
diff --git a/arch/arm/mach-integrator/include/mach/system.h b/arch/arm/mach-integrator/include/mach/system.h
index e1551b8..12fc8c3 100644
--- a/arch/arm/mach-integrator/include/mach/system.h
+++ b/arch/arm/mach-integrator/include/mach/system.h
@@ -21,8 +21,6 @@
 #ifndef __ASM_ARCH_SYSTEM_H
 #define __ASM_ARCH_SYSTEM_H
 
-#include <mach/cm.h>
-
 static inline void arch_idle(void)
 {
 	/*
@@ -34,11 +32,6 @@ static inline void arch_idle(void)
 
 static inline void arch_reset(char mode, const char *cmd)
 {
-	/*
-	 * To reset, we hit the on-board reset register
-	 * in the system FPGA
-	 */
-	cm_control(CM_CTRL_RESET, CM_CTRL_RESET);
 }
 
 #endif
diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
index a1769f3..21a1d6c 100644
--- a/arch/arm/mach-integrator/integrator_ap.c
+++ b/arch/arm/mach-integrator/integrator_ap.c
@@ -472,4 +472,5 @@ MACHINE_START(INTEGRATOR, "ARM-Integrator")
 	.init_irq	= ap_init_irq,
 	.timer		= &ap_timer,
 	.init_machine	= ap_init,
+	.restart	= integrator_restart,
 MACHINE_END
diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index 5de49c3..3a730d44 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -499,4 +499,5 @@ MACHINE_START(CINTEGRATOR, "ARM-IntegratorCP")
 	.init_irq	= intcp_init_irq,
 	.timer		= &cp_timer,
 	.init_machine	= intcp_init,
+	.restart	= integrator_restart,
 MACHINE_END
-- 
1.7.4.4
