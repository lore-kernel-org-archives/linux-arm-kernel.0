From: gilles.chanteperdrix@xenomai.org (Gilles Chanteperdrix)
Date: Thu,  1 Oct 2009 23:34:17 +0200
Subject: [PATCH] "Best-effort" FCSE: Allow PID re-use.
In-Reply-To: <1254432860-11511-7-git-send-email-gilles.chanteperdrix@xenomai.org>
References: <1254432860-11511-1-git-send-email-gilles.chanteperdrix@xenomai.org>
	<1254432860-11511-2-git-send-email-gilles.chanteperdrix@xenomai.org>
	<1254432860-11511-3-git-send-email-gilles.chanteperdrix@xenomai.org>
	<1254432860-11511-4-git-send-email-gilles.chanteperdrix@xenomai.org>
	<1254432860-11511-5-git-send-email-gilles.chanteperdrix@xenomai.org>
	<1254432860-11511-6-git-send-email-gilles.chanteperdrix@xenomai.org>
	<1254432860-11511-7-git-send-email-gilles.chanteperdrix@xenomai.org>
Message-ID: <1254432860-11511-8-git-send-email-gilles.chanteperdrix@xenomai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In addition to the bit telling whether or not a pid is allocated,
maintain:
- a count of processes using a pid;
- the current process using a given pid;
- a bitfield telling whether or not the cache may contain entries for a
given pid.

A function fcse_notify_flush_all() is called upon calls to
flush_cache_mm() and clears all bits in this last bitfield, in order
to avoid that fcse_needs_flush() believe that a pid is reused whereas
the cache has been cleaned.

Signed-off-by: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
---
 arch/arm/include/asm/cacheflush.h |    4 ++-
 arch/arm/include/asm/fcse.h       |    3 ++
 arch/arm/kernel/fcse.c            |   73 +++++++++++++++++++++++++++++++++++--
 arch/arm/mm/flush.c               |    4 ++-
 4 files changed, 79 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index db43631..7ced6d6 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -335,8 +335,10 @@ static inline void outer_flush_range(unsigned long start, unsigned long end)
 #ifndef CONFIG_CPU_CACHE_VIPT
 static inline void flush_cache_mm(struct mm_struct *mm)
 {
-	if (cpumask_test_cpu(smp_processor_id(), mm_cpumask(mm)))
+	if (cpumask_test_cpu(smp_processor_id(), mm_cpumask(mm))) {
+		fcse_notify_flush_all();
 		__cpuc_flush_user_all();
+	}
 }
 
 static inline void
diff --git a/arch/arm/include/asm/fcse.h b/arch/arm/include/asm/fcse.h
index d769a29..c8680c6 100644
--- a/arch/arm/include/asm/fcse.h
+++ b/arch/arm/include/asm/fcse.h
@@ -68,8 +68,10 @@ int fcse_pid_alloc(void);
 void fcse_pid_free(unsigned pid);
 #ifdef CONFIG_ARM_FCSE_BEST_EFFORT
 int fcse_needs_flush(struct mm_struct *prev, struct mm_struct *next);
+void fcse_notify_flush_all(void);
 #else /* CONFIG_ARM_FCSE_GUARANTEED */
 #define fcse_needs_flush(prev, next) (0)
+#define fcse_notify_flush_all() do { } while (0)
 #endif /* CONFIG_ARM_FCSE_GUARANTEED */
 
 #else /* ! CONFIG_ARM_FCSE */
@@ -79,6 +81,7 @@ int fcse_needs_flush(struct mm_struct *prev, struct mm_struct *next);
 #define fcse_tlb_mask(mm) mm_cpumask(mm)
 #define fcse_cpu_set_vm_mask(cpu, mm) do { } while (0)
 #define fcse_needs_flush(prev, next) (1)
+#define fcse_notify_flush_all() do { } while (0)
 #endif /* ! CONFIG_ARM_FCSE */
 
 #endif /* __ASM_ARM_FCSE_H */
diff --git a/arch/arm/kernel/fcse.c b/arch/arm/kernel/fcse.c
index 7918be6..774717c 100644
--- a/arch/arm/kernel/fcse.c
+++ b/arch/arm/kernel/fcse.c
@@ -13,14 +13,33 @@
 static DEFINE_SPINLOCK(fcse_lock);
 static unsigned long fcse_pids_bits[PIDS_LONGS];
 
+#ifdef CONFIG_ARM_FCSE_BEST_EFFORT
+static unsigned long fcse_pids_cache_dirty[PIDS_LONGS];
+static unsigned random_pid;
+struct {
+	struct mm_struct *last_mm;
+	unsigned count;
+} per_pid[NR_PIDS];
+#endif /* CONFIG_ARM_FCSE_BEST_EFFORT */
+
 static void fcse_pid_reference_inner(unsigned pid)
 {
-	__set_bit(pid, fcse_pids_bits);
+#ifdef CONFIG_ARM_FCSE_BEST_EFFORT
+	if (++per_pid[pid].count == 1)
+#endif /* CONFIG_ARM_FCSE_BEST_EFFORT */
+		__set_bit(pid, fcse_pids_bits);
 }
 
 static void fcse_pid_dereference(unsigned pid)
 {
+#ifdef CONFIG_ARM_FCSE_BEST_EFFORT
+	if (--per_pid[pid].count == 0) {
+		__clear_bit(pid, fcse_pids_bits);
+		per_pid[pid].last_mm = NULL;
+	}
+#else /* CONFIG_ARM_FCSE_BEST_EFFORT */
 	__clear_bit(pid, fcse_pids_bits);
+#endif /* CONFIG_ARM_FCSE_BEST_EFFORT */
 }
 
 int fcse_pid_alloc(void)
@@ -37,8 +56,14 @@ int fcse_pid_alloc(void)
 		if (!test_bit(0, fcse_pids_bits))
 			pid = 0;
 		else {
+#ifdef CONFIG_ARM_FCSE_BEST_EFFORT
+			if (++random_pid == NR_PIDS)
+				random_pid = 0;
+			pid = random_pid;
+#else /* CONFIG_ARM_FCSE_GUARANTEED */
 			spin_unlock_irqrestore(&fcse_lock, flags);
 			return -EAGAIN;
+#endif /* CONFIG_ARM_FCSE_GUARANTEED */
 		}
 	}
 	fcse_pid_reference_inner(pid);
@@ -57,12 +82,54 @@ void fcse_pid_free(unsigned pid)
 }
 
 #ifdef CONFIG_ARM_FCSE_BEST_EFFORT
+static void fcse_notify_flush_all_inner(struct mm_struct *next)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&fcse_lock, flags);
+	switch (ARRAY_SIZE(fcse_pids_cache_dirty)) {
+	case 4:
+		fcse_pids_cache_dirty[3] = 0UL;
+	case 3:
+		fcse_pids_cache_dirty[2] = 0UL;
+	case 2:
+		fcse_pids_cache_dirty[1] = 0UL;
+	case 1:
+		fcse_pids_cache_dirty[0] = 0UL;
+	}
+	if (next != &init_mm && next) {
+		unsigned pid = next->context.pid >> FCSE_PID_SHIFT;
+		__set_bit(pid, fcse_pids_cache_dirty);
+	}
+	spin_unlock_irqrestore(&fcse_lock, flags);
+}
+
 int fcse_needs_flush(struct mm_struct *prev, struct mm_struct *next)
 {
-	unsigned res;
+	unsigned res, reused_pid = 0, pid = next->context.pid >> FCSE_PID_SHIFT;
+	unsigned long flags;
+
+	spin_lock_irqsave(&fcse_lock, flags);
+	if (per_pid[pid].last_mm != next) {
+		if (per_pid[pid].last_mm)
+			reused_pid = test_bit(pid, fcse_pids_cache_dirty);
+		per_pid[pid].last_mm = next;
+	}
+	__set_bit(pid, fcse_pids_cache_dirty);
+	spin_unlock_irqrestore(&fcse_lock, flags);
 
-	res = 0;
+	res = reused_pid;
+
+	if (res) {
+		cpu_clear(smp_processor_id(), prev->cpu_vm_mask);
+		fcse_notify_flush_all_inner(next);
+	}
 
 	return res;
 }
+
+void fcse_notify_flush_all(void)
+{
+	fcse_notify_flush_all_inner(current->mm);
+}
 #endif /* CONFIG_ARM_FCSE_BEST_EFFORT */
diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index ec6fcda..fba8619 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -50,8 +50,10 @@ static void flush_pfn_alias(unsigned long pfn, unsigned long vaddr)
 void flush_cache_mm(struct mm_struct *mm)
 {
 	if (cache_is_vivt()) {
-		if (cpumask_test_cpu(smp_processor_id(), mm_cpumask(mm)))
+		if (cpumask_test_cpu(smp_processor_id(), mm_cpumask(mm))) {
+			fcse_notify_flush_all();
 			__cpuc_flush_user_all();
+		}
 		return;
 	}
 
-- 
1.5.6.5
