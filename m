From: gilles.chanteperdrix@xenomai.org (Gilles Chanteperdrix)
Date: Thu,  1 Oct 2009 23:34:11 +0200
Subject: [PATCH] FCSE: pid life cycle.
In-Reply-To: <1254432860-11511-1-git-send-email-gilles.chanteperdrix@xenomai.org>
References: <1254432860-11511-1-git-send-email-gilles.chanteperdrix@xenomai.org>
Message-ID: <1254432860-11511-2-git-send-email-gilles.chanteperdrix@xenomai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a pid member to the mm_context_t structure, allocate this pid in
the init_new_context, free it in the destroy_context, switch it in
switch_mm.

A bitfield is maintained to know what pids are currently in use.

Signed-off-by: Richard Cochran <richard.cochran@omicron.at>
Signed-off-by: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
---
 arch/arm/include/asm/fcse.h        |   44 +++++++++++++++++++++++++++
 arch/arm/include/asm/mmu.h         |    3 ++
 arch/arm/include/asm/mmu_context.h |   24 ++++++++++++++-
 arch/arm/kernel/fcse.c             |   57 ++++++++++++++++++++++++++++++++++++
 4 files changed, 126 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/include/asm/fcse.h
 create mode 100644 arch/arm/kernel/fcse.c

diff --git a/arch/arm/include/asm/fcse.h b/arch/arm/include/asm/fcse.h
new file mode 100644
index 0000000..b44e866
--- /dev/null
+++ b/arch/arm/include/asm/fcse.h
@@ -0,0 +1,44 @@
+/*
+ * Filename:    arch/arm/include/asm/fcse.h
+ * Description: ARM Process ID (PID) includes for Fast Address Space Switching
+ *              (FASS) in ARM Linux.
+ * Created:     14/10/2001
+ * Changes:     19/02/2002 - Macros added.
+ *              03/08/2007 - Adapted to kernel 2.6.21 (ssm)
+ *              Feb 2008   - Simplified a bit (rco)
+ *
+ * Copyright:   (C) 2001, 2002 Adam Wiggins <awiggins@cse.unsw.edu.au>
+ *              (C) 2007 Sebastian Smolorz <ssm@emlix.com>
+ *              (C) 2008 Richard Cochran
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of teh GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef __ASM_ARM_FCSE_H
+#define __ASM_ARM_FCSE_H
+
+#ifdef CONFIG_ARM_FCSE
+
+#include <linux/mm_types.h>	/* For struct mm_struct */
+
+#define FCSE_PID_SHIFT 25
+
+/* Size of PID relocation area */
+#define FCSE_PID_TASK_SIZE (1UL << FCSE_PID_SHIFT)
+
+/* Sets the CPU's PID Register */
+static inline void fcse_pid_set(unsigned long pid)
+{
+	__asm__ __volatile__ ("mcr p15, 0, %0, c13, c0, 0"
+			      : /* */: "r" (pid) : "memory");
+}
+
+int fcse_pid_alloc(void);
+void fcse_pid_free(unsigned pid);
+
+#else /* ! CONFIG_ARM_FCSE */
+#define fcse_pid_set(pid) do { } while (0)
+#endif /* ! CONFIG_ARM_FCSE */
+
+#endif /* __ASM_ARM_FCSE_H */
diff --git a/arch/arm/include/asm/mmu.h b/arch/arm/include/asm/mmu.h
index b561584..4a5a8db 100644
--- a/arch/arm/include/asm/mmu.h
+++ b/arch/arm/include/asm/mmu.h
@@ -7,6 +7,9 @@ typedef struct {
 #ifdef CONFIG_CPU_HAS_ASID
 	unsigned int id;
 #endif
+#ifdef CONFIG_ARM_FCSE
+	unsigned long pid;
+#endif /* CONFIG_ARM_FCSE */
 	unsigned int kvm_seq;
 } mm_context_t;
 
diff --git a/arch/arm/include/asm/mmu_context.h b/arch/arm/include/asm/mmu_context.h
index de6cefb..ec7a84d 100644
--- a/arch/arm/include/asm/mmu_context.h
+++ b/arch/arm/include/asm/mmu_context.h
@@ -19,6 +19,7 @@
 #include <asm/cachetype.h>
 #include <asm/proc-fns.h>
 #include <asm-generic/mm_hooks.h>
+#include <asm/fcse.h>
 
 void __check_kvm_seq(struct mm_struct *mm);
 
@@ -68,11 +69,29 @@ static inline void check_context(struct mm_struct *mm)
 #endif
 }
 
-#define init_new_context(tsk,mm)	0
+static inline int
+init_new_context(struct task_struct *tsk, struct mm_struct *mm)
+{
+#ifdef CONFIG_ARM_FCSE
+	int pid;
+
+	pid = fcse_pid_alloc();
+	if (pid < 0)
+		return pid;
+	mm->context.pid = pid << FCSE_PID_SHIFT;
+#endif /* CONFIG_ARM_FCSE */
+
+	return 0;
+}
 
 #endif
 
-#define destroy_context(mm)		do { } while(0)
+static inline void destroy_context(struct mm_struct *mm)
+{
+#ifdef CONFIG_ARM_FCSE
+	fcse_pid_free(mm->context.pid >> FCSE_PID_SHIFT);
+#endif /* CONFIG_ARM_FCSE */
+}
 
 /*
  * This is called when "tsk" is about to enter lazy TLB mode.
@@ -109,6 +128,7 @@ switch_mm(struct mm_struct *prev, struct mm_struct *next,
 #endif
 	if (!cpumask_test_and_set_cpu(cpu, mm_cpumask(next)) || prev != next) {
 		check_context(next);
+		fcse_pid_set(next->context.pid);
 		cpu_switch_mm(next->pgd, next);
 		if (cache_is_vivt())
 			cpumask_clear_cpu(cpu, mm_cpumask(prev));
diff --git a/arch/arm/kernel/fcse.c b/arch/arm/kernel/fcse.c
new file mode 100644
index 0000000..da074b8
--- /dev/null
+++ b/arch/arm/kernel/fcse.c
@@ -0,0 +1,57 @@
+#include <linux/bitops.h>
+#include <linux/memory.h>
+#include <linux/spinlock.h>
+#include <linux/mm.h>
+
+#include <asm/fcse.h>
+#include <asm/cacheflush.h>
+#include <asm/tlbflush.h>
+
+#define NR_PIDS (TASK_SIZE / FCSE_PID_TASK_SIZE)
+#define PIDS_LONGS ((NR_PIDS + BITS_PER_LONG - 1) / BITS_PER_LONG)
+
+static DEFINE_SPINLOCK(fcse_lock);
+static unsigned long fcse_pids_bits[PIDS_LONGS];
+
+static void fcse_pid_reference_inner(unsigned pid)
+{
+	__set_bit(pid, fcse_pids_bits);
+}
+
+static void fcse_pid_dereference(unsigned pid)
+{
+	__clear_bit(pid, fcse_pids_bits);
+}
+
+int fcse_pid_alloc(void)
+{
+	unsigned long flags;
+	unsigned pid;
+
+	spin_lock_irqsave(&fcse_lock, flags);
+	pid = find_next_zero_bit(fcse_pids_bits, NR_PIDS, 1);
+	if (pid == NR_PIDS) {
+		/* Allocate zero pid last, since zero pid is also used by
+		   processes with address space larger than 32MB in
+		   best-effort mode. */
+		if (!test_bit(0, fcse_pids_bits))
+			pid = 0;
+		else {
+			spin_unlock_irqrestore(&fcse_lock, flags);
+			return -EAGAIN;
+		}
+	}
+	fcse_pid_reference_inner(pid);
+	spin_unlock_irqrestore(&fcse_lock, flags);
+
+	return pid;
+}
+
+void fcse_pid_free(unsigned pid)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&fcse_lock, flags);
+	fcse_pid_dereference(pid);
+	spin_unlock_irqrestore(&fcse_lock, flags);
+}
-- 
1.5.6.5
