From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 20 Jan 2012 17:42:32 +0000
Subject: [PATCH v3 6/6] ARM: Remove __ARCH_WANT_INTERRUPTS_ON_CTXSW on
 pre-ARMv6 CPUs
In-Reply-To: <1327081352-13178-1-git-send-email-catalin.marinas@arm.com>
References: <1327081352-13178-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1327081352-13178-7-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes the __ARCH_WANT_INTERRUPTS_ON_CTXSW definition for
ARMv5 and earlier processors. On such processors, the context switch
requires a full cache flush. To avoid high interrupt latencies, this
patch defers the mm switching to the post-lock switch hook if the
interrupts are disabled.

Reviewed-by: Will Deacon <will.deacon@arm.com>
Reviewed-by: Frank Rowand <frank.rowand@am.sony.com>
Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/include/asm/mmu_context.h |   31 ++++++++++++++++++++++++++-----
 arch/arm/include/asm/system.h      |    9 ---------
 2 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/arch/arm/include/asm/mmu_context.h b/arch/arm/include/asm/mmu_context.h
index 6c42d51..a8b5e37 100644
--- a/arch/arm/include/asm/mmu_context.h
+++ b/arch/arm/include/asm/mmu_context.h
@@ -104,19 +104,40 @@ static inline void finish_arch_post_lock_switch(void)
 
 #else	/* !CONFIG_CPU_HAS_ASID */
 
+#ifdef CONFIG_MMU
+
 static inline void check_and_switch_context(struct mm_struct *mm,
 					    struct task_struct *tsk)
 {
-#ifdef CONFIG_MMU
 	if (unlikely(mm->context.kvm_seq != init_mm.context.kvm_seq))
 		__check_kvm_seq(mm);
-	cpu_switch_mm(mm->pgd, mm);
-#endif
+
+	if (irqs_disabled())
+		/*
+		 * cpu_switch_mm() needs to flush the VIVT caches. To avoid
+		 * high interrupt latencies, defer the call and continue
+		 * running with the old mm. Since we only support UP systems
+		 * on non-ASID CPUs, the old mm will remain valid until the
+		 * finish_arch_post_lock_switch() call.
+		 */
+		set_ti_thread_flag(task_thread_info(tsk), TIF_SWITCH_MM);
+	else
+		cpu_switch_mm(mm->pgd, mm);
 }
 
-#define init_new_context(tsk,mm)	0
+#define finish_arch_post_lock_switch \
+	finish_arch_post_lock_switch
+static inline void finish_arch_post_lock_switch(void)
+{
+	if (test_and_clear_thread_flag(TIF_SWITCH_MM)) {
+		struct mm_struct *mm = current->mm;
+		cpu_switch_mm(mm->pgd, mm);
+	}
+}
 
-#define finish_arch_post_lock_switch()	do { } while (0)
+#endif	/* CONFIG_MMU */
+
+#define init_new_context(tsk,mm)	0
 
 #endif	/* CONFIG_CPU_HAS_ASID */
 
diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index e4b41dd..4f85ced 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -226,15 +226,6 @@ static inline void set_copro_access(unsigned int val)
 }
 
 /*
- * switch_mm() may do a full cache flush over the context switch,
- * so enable interrupts over the context switch to avoid high
- * latency.
- */
-#ifndef CONFIG_CPU_HAS_ASID
-#define __ARCH_WANT_INTERRUPTS_ON_CTXSW
-#endif
-
-/*
  * switch_to(prev, next) should switch from task `prev' to `next'
  * `prev' will never be the same as `next'.  schedule() itself
  * contains the memory barrier to tell GCC not to cache `current'.
