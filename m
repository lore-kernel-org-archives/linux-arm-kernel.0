From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 06 Nov 2011 17:52:10 +0000
Subject: [PATCH 36/41] ARM: restart: versatile: use new restart hook
In-Reply-To: <20111106173113.GI12913@n2100.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
Message-ID: <E1RN6t8-0001Z1-95@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hook these platforms restart code into the new restart hook rather
than using arch_reset().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-versatile/core.c                |   13 +++++++++++++
 arch/arm/mach-versatile/core.h                |    1 +
 arch/arm/mach-versatile/include/mach/system.h |   12 ------------
 arch/arm/mach-versatile/versatile_ab.c        |    1 +
 arch/arm/mach-versatile/versatile_dt.c        |    1 +
 arch/arm/mach-versatile/versatile_pb.c        |    1 +
 6 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index e340a54..b7a6a4b 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -745,6 +745,19 @@ static void versatile_leds_event(led_event_t ledevt)
 }
 #endif	/* CONFIG_LEDS */
 
+void versatile_restart(char mode, const char *cmd)
+{
+	void __iomem *sys = __io_address(VERSATILE_SYS_BASE);
+	u32 val;
+
+	val = __raw_readl(sys + VERSATILE_SYS_RESETCTL_OFFSET);
+	val |= 0x105;
+
+	__raw_writel(0xa05f, sys + VERSATILE_SYS_LOCK_OFFSET);
+	__raw_writel(val, sys + VERSATILE_SYS_RESETCTL_OFFSET);
+	__raw_writel(0, sys + VERSATILE_SYS_LOCK_OFFSET);
+}
+
 /* Early initializations */
 void __init versatile_init_early(void)
 {
diff --git a/arch/arm/mach-versatile/core.h b/arch/arm/mach-versatile/core.h
index e014227..2ef2f55 100644
--- a/arch/arm/mach-versatile/core.h
+++ b/arch/arm/mach-versatile/core.h
@@ -30,6 +30,7 @@ extern void __init versatile_init_early(void);
 extern void __init versatile_init_irq(void);
 extern void __init versatile_map_io(void);
 extern struct sys_timer versatile_timer;
+extern void versatile_restart(char, const char *);
 extern unsigned int mmc_status(struct device *dev);
 #ifdef CONFIG_OF
 extern struct of_dev_auxdata versatile_auxdata_lookup[];
diff --git a/arch/arm/mach-versatile/include/mach/system.h b/arch/arm/mach-versatile/include/mach/system.h
index 8ffc12a..335946a 100644
--- a/arch/arm/mach-versatile/include/mach/system.h
+++ b/arch/arm/mach-versatile/include/mach/system.h
@@ -21,10 +21,6 @@
 #ifndef __ASM_ARCH_SYSTEM_H
 #define __ASM_ARCH_SYSTEM_H
 
-#include <linux/io.h>
-#include <mach/hardware.h>
-#include <mach/platform.h>
-
 static inline void arch_idle(void)
 {
 	/*
@@ -36,14 +32,6 @@ static inline void arch_idle(void)
 
 static inline void arch_reset(char mode, const char *cmd)
 {
-	u32 val;
-
-	val = __raw_readl(IO_ADDRESS(VERSATILE_SYS_RESETCTL)) & ~0x7;
-	val |= 0x105;
-
-	__raw_writel(0xa05f, IO_ADDRESS(VERSATILE_SYS_LOCK));
-	__raw_writel(val, IO_ADDRESS(VERSATILE_SYS_RESETCTL));
-	__raw_writel(0, IO_ADDRESS(VERSATILE_SYS_LOCK));
 }
 
 #endif
diff --git a/arch/arm/mach-versatile/versatile_ab.c b/arch/arm/mach-versatile/versatile_ab.c
index fda4866..f1277ac 100644
--- a/arch/arm/mach-versatile/versatile_ab.c
+++ b/arch/arm/mach-versatile/versatile_ab.c
@@ -41,4 +41,5 @@ MACHINE_START(VERSATILE_AB, "ARM-Versatile AB")
 	.init_irq	= versatile_init_irq,
 	.timer		= &versatile_timer,
 	.init_machine	= versatile_init,
+	.restart	= versatile_restart,
 MACHINE_END
diff --git a/arch/arm/mach-versatile/versatile_dt.c b/arch/arm/mach-versatile/versatile_dt.c
index 54e037c..f48f2e4 100644
--- a/arch/arm/mach-versatile/versatile_dt.c
+++ b/arch/arm/mach-versatile/versatile_dt.c
@@ -48,4 +48,5 @@ DT_MACHINE_START(VERSATILE_PB, "ARM-Versatile (Device Tree Support)")
 	.timer		= &versatile_timer,
 	.init_machine	= versatile_dt_init,
 	.dt_compat	= versatile_dt_match,
+	.restart	= versatile_restart,
 MACHINE_END
diff --git a/arch/arm/mach-versatile/versatile_pb.c b/arch/arm/mach-versatile/versatile_pb.c
index feaf9cb..839bea6 100644
--- a/arch/arm/mach-versatile/versatile_pb.c
+++ b/arch/arm/mach-versatile/versatile_pb.c
@@ -109,4 +109,5 @@ MACHINE_START(VERSATILE_PB, "ARM-Versatile PB")
 	.init_irq	= versatile_init_irq,
 	.timer		= &versatile_timer,
 	.init_machine	= versatile_pb_init,
+	.restart	= versatile_restart,
 MACHINE_END
-- 
1.7.4.4
