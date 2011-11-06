From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 06 Nov 2011 17:41:59 +0000
Subject: [PATCH 06/41] ARM: restart: cns3xxx: use new restart hook
In-Reply-To: <20111106173113.GI12913@n2100.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
Message-ID: <E1RN6jH-0001Wy-5x@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hook these platforms restart code into the new restart hook rather
than using arch_reset().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-cns3xxx/cns3420vb.c           |    1 +
 arch/arm/mach-cns3xxx/core.h                |    1 +
 arch/arm/mach-cns3xxx/include/mach/system.h |    5 +++--
 arch/arm/mach-cns3xxx/pm.c                  |    2 +-
 4 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-cns3xxx/cns3420vb.c b/arch/arm/mach-cns3xxx/cns3420vb.c
index 55f7b4b..9b8c3d5 100644
--- a/arch/arm/mach-cns3xxx/cns3420vb.c
+++ b/arch/arm/mach-cns3xxx/cns3420vb.c
@@ -202,4 +202,5 @@ MACHINE_START(CNS3420VB, "Cavium Networks CNS3420 Validation Board")
 	.init_irq	= cns3xxx_init_irq,
 	.timer		= &cns3xxx_timer,
 	.init_machine	= cns3420_init,
+	.restart	= cns3xxx_restart,
 MACHINE_END
diff --git a/arch/arm/mach-cns3xxx/core.h b/arch/arm/mach-cns3xxx/core.h
index fcd2253..4894b8c 100644
--- a/arch/arm/mach-cns3xxx/core.h
+++ b/arch/arm/mach-cns3xxx/core.h
@@ -22,5 +22,6 @@ static inline void cns3xxx_l2x0_init(void) {}
 void __init cns3xxx_map_io(void);
 void __init cns3xxx_init_irq(void);
 void cns3xxx_power_off(void);
+void cns3xxx_restart(char, const char *);
 
 #endif /* __CNS3XXX_CORE_H */
diff --git a/arch/arm/mach-cns3xxx/include/mach/system.h b/arch/arm/mach-cns3xxx/include/mach/system.h
index 4f16c9b..f92540d 100644
--- a/arch/arm/mach-cns3xxx/include/mach/system.h
+++ b/arch/arm/mach-cns3xxx/include/mach/system.h
@@ -11,7 +11,6 @@
 #ifndef __MACH_SYSTEM_H
 #define __MACH_SYSTEM_H
 
-#include <linux/io.h>
 #include <asm/proc-fns.h>
 
 static inline void arch_idle(void)
@@ -23,6 +22,8 @@ static inline void arch_idle(void)
 	cpu_do_idle();
 }
 
-void arch_reset(char mode, const char *cmd);
+static inline void arch_reset(char mode, const char *cmd)
+{
+}
 
 #endif
diff --git a/arch/arm/mach-cns3xxx/pm.c b/arch/arm/mach-cns3xxx/pm.c
index 0c04678..5136c4c 100644
--- a/arch/arm/mach-cns3xxx/pm.c
+++ b/arch/arm/mach-cns3xxx/pm.c
@@ -89,7 +89,7 @@ void cns3xxx_pwr_soft_rst(unsigned int block)
 }
 EXPORT_SYMBOL(cns3xxx_pwr_soft_rst);
 
-void arch_reset(char mode, const char *cmd)
+void cns3xxx_restart(char mode, const char *cmd)
 {
 	/*
 	 * To reset, we hit the on-board reset register
-- 
1.7.4.4
