From: will.deacon@arm.com (Will Deacon)
Date: Fri, 22 Jun 2012 16:09:33 +0100
Subject: [PATCH 1/2] ARM: arch timer: implement read_current_timer and
 get_cycles
In-Reply-To: <1340377774-17173-1-git-send-email-will.deacon@arm.com>
References: <1340377774-17173-1-git-send-email-will.deacon@arm.com>
Message-ID: <1340377774-17173-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch implements read_current_timer using the architected timers
when they are selected via CONFIG_ARM_ARCH_TIMER. If they are detected
not to be usable at runtime, we return -ENXIO to the caller.

Furthermore, if read_current_timer is exported then we can implement
get_cycles in terms of it for use as both an entropy source and for
implementing __udelay and friends.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/arch_timer.h |    1 +
 arch/arm/include/asm/timex.h      |   10 ++++++----
 arch/arm/kernel/arch_timer.c      |    8 ++++++++
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/arch_timer.h b/arch/arm/include/asm/arch_timer.h
index ed2e95d..7b0fe68 100644
--- a/arch/arm/include/asm/arch_timer.h
+++ b/arch/arm/include/asm/arch_timer.h
@@ -2,6 +2,7 @@
 #define __ASMARM_ARCH_TIMER_H
 
 #ifdef CONFIG_ARM_ARCH_TIMER
+#define ARCH_HAS_READ_CURRENT_TIMER
 int arch_timer_of_register(void);
 int arch_timer_sched_clock_init(void);
 #else
diff --git a/arch/arm/include/asm/timex.h b/arch/arm/include/asm/timex.h
index 3be8de3..ce11944 100644
--- a/arch/arm/include/asm/timex.h
+++ b/arch/arm/include/asm/timex.h
@@ -12,13 +12,15 @@
 #ifndef _ASMARM_TIMEX_H
 #define _ASMARM_TIMEX_H
 
+#include <asm/arch_timer.h>
 #include <mach/timex.h>
 
 typedef unsigned long cycles_t;
 
-static inline cycles_t get_cycles (void)
-{
-	return 0;
-}
+#ifdef ARCH_HAS_READ_CURRENT_TIMER
+#define get_cycles()	({ cycles_t c; read_current_timer(&c) ? 0 : c; })
+#else
+#define get_cycles()	(0)
+#endif
 
 #endif
diff --git a/arch/arm/kernel/arch_timer.c b/arch/arm/kernel/arch_timer.c
index dd58035..dbbeec4 100644
--- a/arch/arm/kernel/arch_timer.c
+++ b/arch/arm/kernel/arch_timer.c
@@ -223,6 +223,14 @@ static cycle_t arch_counter_read(struct clocksource *cs)
 	return arch_counter_get_cntpct();
 }
 
+int read_current_timer(unsigned long *timer_val)
+{
+	if (!arch_timer_rate)
+		return -ENXIO;
+	*timer_val = arch_counter_get_cntpct();
+	return 0;
+}
+
 static struct clocksource clocksource_counter = {
 	.name	= "arch_sys_counter",
 	.rating	= 400,
-- 
1.7.4.1
