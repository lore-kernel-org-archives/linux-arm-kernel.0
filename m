From: gilles.chanteperdrix@xenomai.org (Gilles Chanteperdrix)
Date: Thu,  1 Oct 2009 23:34:19 +0200
Subject: [PATCH] "Best-effort" FCSE: Handle mappings above 32 MB
In-Reply-To: <1254432860-11511-9-git-send-email-gilles.chanteperdrix@xenomai.org>
References: <1254432860-11511-1-git-send-email-gilles.chanteperdrix@xenomai.org>
	<1254432860-11511-2-git-send-email-gilles.chanteperdrix@xenomai.org>
	<1254432860-11511-3-git-send-email-gilles.chanteperdrix@xenomai.org>
	<1254432860-11511-4-git-send-email-gilles.chanteperdrix@xenomai.org>
	<1254432860-11511-5-git-send-email-gilles.chanteperdrix@xenomai.org>
	<1254432860-11511-6-git-send-email-gilles.chanteperdrix@xenomai.org>
	<1254432860-11511-7-git-send-email-gilles.chanteperdrix@xenomai.org>
	<1254432860-11511-8-git-send-email-gilles.chanteperdrix@xenomai.org>
	<1254432860-11511-9-git-send-email-gilles.chanteperdrix@xenomai.org>
Message-ID: <1254432860-11511-10-git-send-email-gilles.chanteperdrix@xenomai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In case an address larger than 32 MB is returned by
arch_get_unmapped_area(), relocate the calling process to the null
pid. When such a process forks, also give the child process a null
pid. Account for pages above 32 MB, and when a process with such pages
is switched in or out, flush the cache.

As in handling shared mappings, we use set_pte_at() to do the pages
accounting.

Signed-off-by: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
---
 arch/arm/include/asm/fcse.h        |    2 +
 arch/arm/include/asm/mmu.h         |    2 +
 arch/arm/include/asm/mmu_context.h |   17 +++++++++++++-
 arch/arm/include/asm/pgtable.h     |    7 ++++++
 arch/arm/kernel/fcse.c             |   41 +++++++++++++++++++++++++++++++++++-
 arch/arm/mm/mmap.c                 |    7 ++++++
 6 files changed, 73 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/fcse.h b/arch/arm/include/asm/fcse.h
index c8680c6..66fa9de 100644
--- a/arch/arm/include/asm/fcse.h
+++ b/arch/arm/include/asm/fcse.h
@@ -69,6 +69,8 @@ void fcse_pid_free(unsigned pid);
 #ifdef CONFIG_ARM_FCSE_BEST_EFFORT
 int fcse_needs_flush(struct mm_struct *prev, struct mm_struct *next);
 void fcse_notify_flush_all(void);
+void fcse_pid_reference(unsigned pid);
+void fcse_relocate_mm_to_null_pid(struct mm_struct *mm);
 #else /* CONFIG_ARM_FCSE_GUARANTEED */
 #define fcse_needs_flush(prev, next) (0)
 #define fcse_notify_flush_all() do { } while (0)
diff --git a/arch/arm/include/asm/mmu.h b/arch/arm/include/asm/mmu.h
index 9a2fb51..13c844f 100644
--- a/arch/arm/include/asm/mmu.h
+++ b/arch/arm/include/asm/mmu.h
@@ -12,6 +12,8 @@ typedef struct {
 	cpumask_t cpu_tlb_mask;
 #ifdef CONFIG_ARM_FCSE_BEST_EFFORT
 	unsigned shared_dirty_pages;
+	unsigned big;
+	unsigned high_pages;
 #endif /* CONFIG_ARM_FCSE_BEST_EFFORT */
 #endif /* CONFIG_ARM_FCSE */
 	unsigned int kvm_seq;
diff --git a/arch/arm/include/asm/mmu_context.h b/arch/arm/include/asm/mmu_context.h
index 035a9f2..85eac0a 100644
--- a/arch/arm/include/asm/mmu_context.h
+++ b/arch/arm/include/asm/mmu_context.h
@@ -77,13 +77,25 @@ init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 
 	cpus_clear(mm->context.cpu_tlb_mask);
 #ifdef CONFIG_ARM_FCSE_BEST_EFFORT
+	if (!mm->context.big) {
+		pid = fcse_pid_alloc();
+		mm->context.pid = pid << FCSE_PID_SHIFT;
+	} else {
+		/* We are normally forking a process vith a virtual address
+		   space larger than 32 MB, so its pid should be 0. */
+		BUG_ON(mm->context.pid);
+		fcse_pid_reference(0);
+	}
+	/* If we are forking, set_pte_at will restore the correct high pages
+	   count, and shared writable pages are write-protected again. */
 	mm->context.shared_dirty_pages = 0;
-#endif /* CONFIG_ARM_FCSE_BEST_EFFORT */
-
+	mm->context.high_pages = 0;
+#else /* CONFIG_ARM_FCSE_GUARANTEED */
 	pid = fcse_pid_alloc();
 	if (pid < 0)
 		return pid;
 	mm->context.pid = pid << FCSE_PID_SHIFT;
+#endif /* CONFIG_ARM_FCSE_GUARANTEED */
 #endif /* CONFIG_ARM_FCSE */
 
 	return 0;
@@ -96,6 +108,7 @@ static inline void destroy_context(struct mm_struct *mm)
 #ifdef CONFIG_ARM_FCSE
 #ifdef CONFIG_ARM_FCSE_BEST_EFFORT
 	BUG_ON(mm->context.shared_dirty_pages);
+	BUG_ON(mm->context.high_pages);
 #endif /* CONFIG_ARM_FCSE_BEST_EFFORT */
 	fcse_pid_free(mm->context.pid >> FCSE_PID_SHIFT);
 #endif /* CONFIG_ARM_FCSE */
diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index 7775c1b..6c79d71 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -257,6 +257,10 @@ extern pgprot_t		pgprot_kernel;
 	unsigned long _val = (val);				\
 	if (pte_present(_val) && ((_val) & L_PTE_SHARED))	\
 		--_mm->context.shared_dirty_pages;		\
+	if (pte_present(_val) && _addr < TASK_SIZE) {		\
+		if (_addr >= FCSE_TASK_SIZE)			\
+			--_mm->context.high_pages;		\
+	}							\
 } while (0)
 
 #define fcse_account_page_addition(mm, addr, val) ({			\
@@ -270,6 +274,9 @@ extern pgprot_t		pgprot_kernel;
 		else							\
 			++_mm->context.shared_dirty_pages;		\
 	}								\
+	if (pte_present(_val)						\
+	    && _addr < TASK_SIZE && _addr >= FCSE_TASK_SIZE)		\
+		++_mm->context.high_pages;				\
 	_val;								\
 })
 #else /* CONFIG_ARM_FCSE_GUARANTEED || !CONFIG_ARM_FCSE */
diff --git a/arch/arm/kernel/fcse.c b/arch/arm/kernel/fcse.c
index 5b257c9..d15ac30 100644
--- a/arch/arm/kernel/fcse.c
+++ b/arch/arm/kernel/fcse.c
@@ -119,7 +119,9 @@ int fcse_needs_flush(struct mm_struct *prev, struct mm_struct *next)
 	spin_unlock_irqrestore(&fcse_lock, flags);
 
 	res = reused_pid
-		|| prev->context.shared_dirty_pages;
+		|| prev->context.shared_dirty_pages
+		|| prev->context.high_pages
+		|| next->context.high_pages;
 
 	if (res) {
 		cpu_clear(smp_processor_id(), prev->cpu_vm_mask);
@@ -133,4 +135,41 @@ void fcse_notify_flush_all(void)
 {
 	fcse_notify_flush_all_inner(current->mm);
 }
+
+void fcse_pid_reference(unsigned pid)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&fcse_lock, flags);
+	fcse_pid_reference_inner(pid);
+	spin_unlock_irqrestore(&fcse_lock, flags);
+}
+
+/* Called with mm->mmap_sem write-locked. */
+void fcse_relocate_mm_to_null_pid(struct mm_struct *mm)
+{
+	pgd_t *to = mm->pgd + pgd_index(0);
+	pgd_t *from = pgd_offset(mm, 0);
+	unsigned len = pgd_index(FCSE_TASK_SIZE) * sizeof(*from);
+	unsigned long flags;
+
+	preempt_disable();
+
+	memcpy(to, from, len);
+	spin_lock_irqsave(&fcse_lock, flags);
+	fcse_pid_dereference(mm->context.pid >> FCSE_PID_SHIFT);
+	fcse_pid_reference_inner(0);
+	per_pid[0].last_mm = mm;
+	spin_unlock_irqrestore(&fcse_lock, flags);
+
+	mm->context.pid = 0;
+	fcse_pid_set(0);
+	memset(from, '\0', len);
+	mb();
+	flush_cache_mm(mm);
+	flush_tlb_mm(mm);
+
+	preempt_enable();
+}
+
 #endif /* CONFIG_ARM_FCSE_BEST_EFFORT */
diff --git a/arch/arm/mm/mmap.c b/arch/arm/mm/mmap.c
index e608bda..ac81369 100644
--- a/arch/arm/mm/mmap.c
+++ b/arch/arm/mm/mmap.c
@@ -125,7 +125,14 @@ found_addr:
 			mm->cached_hole_size = 0;
 			goto full_search;
 		}
+#ifdef CONFIG_ARM_FCSE_BEST_EFFORT
+		if (mm->context.pid) {
+			mm->context.big = 1;
+			fcse_relocate_mm_to_null_pid(mm);
+		}
+#else /* CONFIG_ARM_FCSE_GUARANTEED */
 		return -ENOMEM;
+#endif /* CONFIG_ARM_FCSE_GUARANTEED */
 	}
 #endif /* CONFIG_ARM_FCSE */
 	return addr;
-- 
1.5.6.5
