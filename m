From: cyril@ti.com (Cyril Chemparathy)
Date: Tue, 11 Sep 2012 12:19:00 -0400
Subject: [PATCH] ARM: avoid undef on ARCH_HAS_READ_CURRENT_TIMER
Message-ID: <1347380341-28145-1-git-send-email-cyril@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the inclusion of asm-generic/timex.h, the ARM arch timer implementation
breaks on build.  This is because asm/arch_timer.h now defines
ARCH_HAS_READ_CURRENT_TIMER, only to have this macro undefined by the
subsequent inclusion of asm-generic/timex.h.

This patch fixes the problem in asm/timex.h by including asm-generic/timex.h
early, and by defining get_cycles even earlier.

This patch has been tested against linux-next-20120910, both with and without
arch timer support.

Signed-off-by: Cyril Chemparathy <cyril@ti.com>
---
 arch/arm/include/asm/arch_timer.h |    1 +
 arch/arm/include/asm/timex.h      |   14 +++++++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/arch_timer.h b/arch/arm/include/asm/arch_timer.h
index 62e7547..6beb06a 100644
--- a/arch/arm/include/asm/arch_timer.h
+++ b/arch/arm/include/asm/arch_timer.h
@@ -7,6 +7,7 @@
 #define ARCH_HAS_READ_CURRENT_TIMER
 int arch_timer_of_register(void);
 int arch_timer_sched_clock_init(void);
+int read_current_timer(cycles_t *c);
 #else
 static inline int arch_timer_of_register(void)
 {
diff --git a/arch/arm/include/asm/timex.h b/arch/arm/include/asm/timex.h
index 5e71172..76f4217 100644
--- a/arch/arm/include/asm/timex.h
+++ b/arch/arm/include/asm/timex.h
@@ -12,13 +12,21 @@
 #ifndef _ASMARM_TIMEX_H
 #define _ASMARM_TIMEX_H
 
+#define get_cycles get_cycles
+
+#include <asm-generic/timex.h>
 #include <asm/arch_timer.h>
 #include <mach/timex.h>
 
+static inline cycles_t get_cycles(void)
+{
 #ifdef ARCH_HAS_READ_CURRENT_TIMER
-#define get_cycles()	({ cycles_t c; read_current_timer(&c) ? 0 : c; })
-#endif
+	cycles_t c;
 
-#include <asm-generic/timex.h>
+	if (!read_current_timer(&c))
+		return c;
+#endif
+	return 0;
+}
 
 #endif
-- 
1.7.9.5
