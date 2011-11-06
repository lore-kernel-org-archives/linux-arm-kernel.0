From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 06 Nov 2011 17:43:41 +0000
Subject: [PATCH 11/41] ARM: restart: h720x: use new restart hook
In-Reply-To: <20111106173113.GI12913@n2100.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
Message-ID: <E1RN6kv-0001XJ-2l@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hook these platforms restart code into the new restart hook rather
than using arch_reset().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-h720x/common.c              |    5 +++++
 arch/arm/mach-h720x/common.h              |    1 +
 arch/arm/mach-h720x/h7201-eval.c          |    1 +
 arch/arm/mach-h720x/h7202-eval.c          |    1 +
 arch/arm/mach-h720x/include/mach/system.h |    4 +---
 5 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-h720x/common.c b/arch/arm/mach-h720x/common.c
index 51d4e44..f8a2f6b 100644
--- a/arch/arm/mach-h720x/common.c
+++ b/arch/arm/mach-h720x/common.c
@@ -242,3 +242,8 @@ void __init h720x_map_io(void)
 {
 	iotable_init(h720x_io_desc,ARRAY_SIZE(h720x_io_desc));
 }
+
+void h720x_restart(char mode, const char *cmd)
+{
+	CPU_REG (PMU_BASE, PMU_STAT) |= PMU_WARMRESET;
+}
diff --git a/arch/arm/mach-h720x/common.h b/arch/arm/mach-h720x/common.h
index 7dd5fa6..2489537 100644
--- a/arch/arm/mach-h720x/common.h
+++ b/arch/arm/mach-h720x/common.h
@@ -16,6 +16,7 @@
 extern unsigned long h720x_gettimeoffset(void);
 extern void __init h720x_init_irq(void);
 extern void __init h720x_map_io(void);
+extern void h720x_restart(char, const char *);
 
 #ifdef CONFIG_ARCH_H7202
 extern struct sys_timer h7202_timer;
diff --git a/arch/arm/mach-h720x/h7201-eval.c b/arch/arm/mach-h720x/h7201-eval.c
index 9886f19..5fdb20c 100644
--- a/arch/arm/mach-h720x/h7201-eval.c
+++ b/arch/arm/mach-h720x/h7201-eval.c
@@ -34,4 +34,5 @@ MACHINE_START(H7201, "Hynix GMS30C7201")
 	.init_irq	= h720x_init_irq,
 	.timer		= &h7201_timer,
 	.dma_zone_size	= SZ_256M,
+	.restart	= h720x_restart,
 MACHINE_END
diff --git a/arch/arm/mach-h720x/h7202-eval.c b/arch/arm/mach-h720x/h7202-eval.c
index 284a134..1696730 100644
--- a/arch/arm/mach-h720x/h7202-eval.c
+++ b/arch/arm/mach-h720x/h7202-eval.c
@@ -77,4 +77,5 @@ MACHINE_START(H7202, "Hynix HMS30C7202")
 	.timer		= &h7202_timer,
 	.init_machine	= init_eval_h7202,
 	.dma_zone_size	= SZ_256M,
+	.restart	= h720x_restart,
 MACHINE_END
diff --git a/arch/arm/mach-h720x/include/mach/system.h b/arch/arm/mach-h720x/include/mach/system.h
index a708d24..b04f08d 100644
--- a/arch/arm/mach-h720x/include/mach/system.h
+++ b/arch/arm/mach-h720x/include/mach/system.h
@@ -24,10 +24,8 @@ static void arch_idle(void)
 	nop();
 }
 
-
-static __inline__ void arch_reset(char mode, const char *cmd)
+static inline void arch_reset(char mode, const char *cmd)
 {
-	CPU_REG (PMU_BASE, PMU_STAT) |= PMU_WARMRESET;
 }
 
 #endif
-- 
1.7.4.4
