From: linux@roeck-us.net (Guenter Roeck)
Date: Fri, 10 Oct 2014 18:15:34 -0700
Subject: [PATCH] arm64: Fix compile error seen in non-SMP builds
Message-ID: <1412990134-31186-1-git-send-email-linux@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix:

In file included from ./arch/arm64/include/asm/irq_work.h:4:0,
        from include/linux/irq_work.h:46,
        from include/linux/perf_event.h:49,
        from include/linux/ftrace_event.h:9,
        from include/trace/syscall.h:6,
        from include/linux/syscalls.h:81,
        from init/main.c:18:
./arch/arm64/include/asm/smp.h:24:3:
	error: #error "<asm/smp.h> included in non-SMP build"
 # error "<asm/smp.h> included in non-SMP build"
   ^
./arch/arm64/include/asm/smp.h:27:0: warning: "raw_smp_processor_id" redefined
 #define raw_smp_processor_id() (current_thread_info()->cpu)
 ^

and:

In file included from ./arch/arm64/include/asm/irq_work.h:4:0,
        from include/linux/irq_work.h:46,
        from kernel/irq_work.c:11:
./arch/arm64/include/asm/smp_plat.h:56:30:
        error: ?NR_CPUS? undeclared here (not in a function)
        extern u64 __cpu_logical_map[NR_CPUS];

by providing a helper function in smp_plat.h, similar to the arm implementation,
and by removing NR_CPUS from smp_plat.h.

Fixes: 3631073659d0 ("arm64: Tell irq work about self IPI support")
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Compile tested and booted in qemu for both SMP and non-SMP builds.

 arch/arm64/include/asm/irq_work.h |  4 ++--
 arch/arm64/include/asm/smp.h      |  2 --
 arch/arm64/include/asm/smp_plat.h | 17 ++++++++++++++++-
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/irq_work.h b/arch/arm64/include/asm/irq_work.h
index 8e24ef3..33199a9 100644
--- a/arch/arm64/include/asm/irq_work.h
+++ b/arch/arm64/include/asm/irq_work.h
@@ -1,11 +1,11 @@
 #ifndef __ASM_IRQ_WORK_H
 #define __ASM_IRQ_WORK_H
 
-#include <asm/smp.h>
+#include <asm/smp_plat.h>
 
 static inline bool arch_irq_work_has_interrupt(void)
 {
-	return !!__smp_cross_call;
+	return have_smp_crosscall();
 }
 
 #endif /* __ASM_IRQ_WORK_H */
diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
index 780f82c..a498f2c 100644
--- a/arch/arm64/include/asm/smp.h
+++ b/arch/arm64/include/asm/smp.h
@@ -48,8 +48,6 @@ extern void smp_init_cpus(void);
  */
 extern void set_smp_cross_call(void (*)(const struct cpumask *, unsigned int));
 
-extern void (*__smp_cross_call)(const struct cpumask *, unsigned int);
-
 /*
  * Called from the secondary holding pen, this is the secondary CPU entry point.
  */
diff --git a/arch/arm64/include/asm/smp_plat.h b/arch/arm64/include/asm/smp_plat.h
index 59e2823..9ae4fde 100644
--- a/arch/arm64/include/asm/smp_plat.h
+++ b/arch/arm64/include/asm/smp_plat.h
@@ -21,6 +21,21 @@
 
 #include <asm/types.h>
 
+/*
+ * Return true if we are running on a SMP platform
+ * and __smp_cross_call is installed.
+ */
+static inline bool have_smp_crosscall(void)
+{
+#ifndef CONFIG_SMP
+	return false;
+#else
+	extern void (*__smp_cross_call)(const struct cpumask *, unsigned int);
+
+	return !!__smp_cross_call;
+#endif
+}
+
 struct mpidr_hash {
 	u64	mask;
 	u32	shift_aff[4];
@@ -37,7 +52,7 @@ static inline u32 mpidr_hash_size(void)
 /*
  * Logical CPU mapping.
  */
-extern u64 __cpu_logical_map[NR_CPUS];
+extern u64 __cpu_logical_map[];
 #define cpu_logical_map(cpu)    __cpu_logical_map[cpu]
 
 #endif /* __ASM_SMP_PLAT_H */
-- 
1.9.1
