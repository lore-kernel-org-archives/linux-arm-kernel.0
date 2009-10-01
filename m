From: gilles.chanteperdrix@xenomai.org (Gilles Chanteperdrix)
Date: Thu,  1 Oct 2009 23:34:16 +0200
Subject: [PATCH] "Best-effort" FCSE: choose whether to flush cache at run-time.
In-Reply-To: <1254432860-11511-6-git-send-email-gilles.chanteperdrix@xenomai.org>
References: <1254432860-11511-1-git-send-email-gilles.chanteperdrix@xenomai.org>
	<1254432860-11511-2-git-send-email-gilles.chanteperdrix@xenomai.org>
	<1254432860-11511-3-git-send-email-gilles.chanteperdrix@xenomai.org>
	<1254432860-11511-4-git-send-email-gilles.chanteperdrix@xenomai.org>
	<1254432860-11511-5-git-send-email-gilles.chanteperdrix@xenomai.org>
	<1254432860-11511-6-git-send-email-gilles.chanteperdrix@xenomai.org>
Message-ID: <1254432860-11511-7-git-send-email-gilles.chanteperdrix@xenomai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The implementation of the FCSE "best-effort" mode requires to decide,
when switching contexts, whether to flush the cache. So, we add a
parameter to the mm switching function telling whether we want to
flush the cache, and the switch_mm macro uses the fcse_needs_flush
to get the value of this parameter.

Signed-off-by: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
---
 arch/arm/include/asm/cpu-multi32.h |    5 +++--
 arch/arm/include/asm/cpu-single.h  |    3 ++-
 arch/arm/include/asm/fcse.h        |    6 ++++++
 arch/arm/include/asm/mmu_context.h |    2 +-
 arch/arm/include/asm/proc-fns.h    |    3 ++-
 arch/arm/kernel/fcse.c             |   11 +++++++++++
 arch/arm/mm/proc-arm920.S          |    9 +++++++++
 arch/arm/mm/proc-arm926.S          |    9 +++++++++
 arch/arm/mm/proc-xscale.S          |    9 +++++++++
 9 files changed, 52 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/cpu-multi32.h b/arch/arm/include/asm/cpu-multi32.h
index e2b5b0b..18ca8a0 100644
--- a/arch/arm/include/asm/cpu-multi32.h
+++ b/arch/arm/include/asm/cpu-multi32.h
@@ -52,7 +52,8 @@ extern struct processor {
 	/*
 	 * Set the page table
 	 */
-	void (*switch_mm)(unsigned long pgd_phys, struct mm_struct *mm);
+	void (*switch_mm)(unsigned long pgd_phys,
+			  struct mm_struct *mm, unsigned flush);
 	/*
 	 * Set a possibly extended PTE.  Non-extended PTEs should
 	 * ignore 'ext'.
@@ -66,4 +67,4 @@ extern struct processor {
 #define cpu_do_idle()			processor._do_idle()
 #define cpu_dcache_clean_area(addr,sz)	processor.dcache_clean_area(addr,sz)
 #define cpu_set_pte_ext(ptep,pte,ext)	processor.set_pte_ext(ptep,pte,ext)
-#define cpu_do_switch_mm(pgd,mm)	processor.switch_mm(pgd,mm)
+#define cpu_do_switch_mm(pgd,mm,flush)	processor.switch_mm(pgd,mm,flush)
diff --git a/arch/arm/include/asm/cpu-single.h b/arch/arm/include/asm/cpu-single.h
index f073a6d..ec556e3 100644
--- a/arch/arm/include/asm/cpu-single.h
+++ b/arch/arm/include/asm/cpu-single.h
@@ -39,6 +39,7 @@ extern void cpu_proc_init(void);
 extern void cpu_proc_fin(void);
 extern int cpu_do_idle(void);
 extern void cpu_dcache_clean_area(void *, int);
-extern void cpu_do_switch_mm(unsigned long pgd_phys, struct mm_struct *mm);
+extern void cpu_do_switch_mm(unsigned long pgd_phys,
+			     struct mm_struct *mm, unsigned flush);
 extern void cpu_set_pte_ext(pte_t *ptep, pte_t pte, unsigned int ext);
 extern void cpu_reset(unsigned long addr) __attribute__((noreturn));
diff --git a/arch/arm/include/asm/fcse.h b/arch/arm/include/asm/fcse.h
index 4e9503d..d769a29 100644
--- a/arch/arm/include/asm/fcse.h
+++ b/arch/arm/include/asm/fcse.h
@@ -66,6 +66,11 @@ fcse_va_to_mva(struct mm_struct *mm, unsigned long va)
 
 int fcse_pid_alloc(void);
 void fcse_pid_free(unsigned pid);
+#ifdef CONFIG_ARM_FCSE_BEST_EFFORT
+int fcse_needs_flush(struct mm_struct *prev, struct mm_struct *next);
+#else /* CONFIG_ARM_FCSE_GUARANTEED */
+#define fcse_needs_flush(prev, next) (0)
+#endif /* CONFIG_ARM_FCSE_GUARANTEED */
 
 #else /* ! CONFIG_ARM_FCSE */
 #define fcse_pid_set(pid) do { } while (0)
@@ -73,6 +78,7 @@ void fcse_pid_free(unsigned pid);
 #define fcse_va_to_mva(mm, x) ({ (void)(mm); (x); })
 #define fcse_tlb_mask(mm) mm_cpumask(mm)
 #define fcse_cpu_set_vm_mask(cpu, mm) do { } while (0)
+#define fcse_needs_flush(prev, next) (1)
 #endif /* ! CONFIG_ARM_FCSE */
 
 #endif /* __ASM_ARM_FCSE_H */
diff --git a/arch/arm/include/asm/mmu_context.h b/arch/arm/include/asm/mmu_context.h
index 042a26d..ad1bbb4 100644
--- a/arch/arm/include/asm/mmu_context.h
+++ b/arch/arm/include/asm/mmu_context.h
@@ -132,7 +132,7 @@ switch_mm(struct mm_struct *prev, struct mm_struct *next,
 		fcse_cpu_set_vm_mask(cpu, next);
 		check_context(next);
 		fcse_pid_set(next->context.pid);
-		cpu_switch_mm(next->pgd, next);
+		cpu_switch_mm(next->pgd, next, fcse_needs_flush(prev, next));
 		if (cache_is_vivt())
 			cpumask_clear_cpu(cpu, fcse_tlb_mask(prev));
 	}
diff --git a/arch/arm/include/asm/proc-fns.h b/arch/arm/include/asm/proc-fns.h
index 3976412..86f3131 100644
--- a/arch/arm/include/asm/proc-fns.h
+++ b/arch/arm/include/asm/proc-fns.h
@@ -239,7 +239,8 @@
 
 #ifdef CONFIG_MMU
 
-#define cpu_switch_mm(pgd,mm) cpu_do_switch_mm(virt_to_phys(pgd),mm)
+#define cpu_switch_mm(pgd,mm,flush) \
+	cpu_do_switch_mm(virt_to_phys(pgd), (mm), (flush))
 
 #define cpu_get_pgd()	\
 	({						\
diff --git a/arch/arm/kernel/fcse.c b/arch/arm/kernel/fcse.c
index da074b8..7918be6 100644
--- a/arch/arm/kernel/fcse.c
+++ b/arch/arm/kernel/fcse.c
@@ -55,3 +55,14 @@ void fcse_pid_free(unsigned pid)
 	fcse_pid_dereference(pid);
 	spin_unlock_irqrestore(&fcse_lock, flags);
 }
+
+#ifdef CONFIG_ARM_FCSE_BEST_EFFORT
+int fcse_needs_flush(struct mm_struct *prev, struct mm_struct *next)
+{
+	unsigned res;
+
+	res = 0;
+
+	return res;
+}
+#endif /* CONFIG_ARM_FCSE_BEST_EFFORT */
diff --git a/arch/arm/mm/proc-arm920.S b/arch/arm/mm/proc-arm920.S
index 914d688..3eff19c 100644
--- a/arch/arm/mm/proc-arm920.S
+++ b/arch/arm/mm/proc-arm920.S
@@ -321,6 +321,11 @@ ENTRY(cpu_arm920_dcache_clean_area)
 ENTRY(cpu_arm920_switch_mm)
 #ifdef CONFIG_MMU
 	mov	ip, #0
+#ifdef CONFIG_ARM_FCSE_BEST_EFFORT
+	cmp	r2, #0
+	beq	3f
+#endif /* CONFIG_ARM_FCSE_BEST_EFFORT */
+#ifndef CONFIG_ARM_FCSE_GUARANTEED
 #ifdef CONFIG_CPU_DCACHE_WRITETHROUGH
 	mcr	p15, 0, ip, c7, c6, 0		@ invalidate D cache
 #else
@@ -338,6 +343,10 @@ ENTRY(cpu_arm920_switch_mm)
 #endif
 	mcr	p15, 0, ip, c7, c5, 0		@ invalidate I cache
 	mcr	p15, 0, ip, c7, c10, 4		@ drain WB
+#endif /* !CONFIG_ARM_FCSE_GUARANTEED */
+#ifdef CONFIG_ARM_FCSE_BEST_EFFORT
+3:
+#endif /* CONFIG_ARM_FCSE_BEST_EFFORT */
 	mcr	p15, 0, r0, c2, c0, 0		@ load page table pointer
 	mcr	p15, 0, ip, c8, c7, 0		@ invalidate I & D TLBs
 #endif
diff --git a/arch/arm/mm/proc-arm926.S b/arch/arm/mm/proc-arm926.S
index 5446693..f7a6021 100644
--- a/arch/arm/mm/proc-arm926.S
+++ b/arch/arm/mm/proc-arm926.S
@@ -337,6 +337,11 @@ ENTRY(cpu_arm926_dcache_clean_area)
 ENTRY(cpu_arm926_switch_mm)
 #ifdef CONFIG_MMU
 	mov	ip, #0
+#ifdef CONFIG_ARM_FCSE_BEST_EFFORT
+	cmp	r2, #0
+	beq	2f
+#endif /* CONFIG_ARM_FCSE_BEST_EFFORT */
+#ifndef CONFIG_ARM_FCSE_GUARANTEED
 #ifdef CONFIG_CPU_DCACHE_WRITETHROUGH
 	mcr	p15, 0, ip, c7, c6, 0		@ invalidate D cache
 #else
@@ -346,6 +351,10 @@ ENTRY(cpu_arm926_switch_mm)
 #endif
 	mcr	p15, 0, ip, c7, c5, 0		@ invalidate I cache
 	mcr	p15, 0, ip, c7, c10, 4		@ drain WB
+#endif /* CONFIG_ARM_FCSE_GUARANTEED */
+#ifdef CONFIG_ARM_FCSE_BEST_EFFORT
+2:
+#endif /* CONFIG_ARM_FCSE_BEST_EFFORT */
 	mcr	p15, 0, r0, c2, c0, 0		@ load page table pointer
 	mcr	p15, 0, ip, c8, c7, 0		@ invalidate I & D TLBs
 #endif
diff --git a/arch/arm/mm/proc-xscale.S b/arch/arm/mm/proc-xscale.S
index 4233942..f09d135 100644
--- a/arch/arm/mm/proc-xscale.S
+++ b/arch/arm/mm/proc-xscale.S
@@ -415,9 +415,18 @@ ENTRY(cpu_xscale_dcache_clean_area)
  */
 	.align	5
 ENTRY(cpu_xscale_switch_mm)
+#ifdef CONFIG_ARM_FCSE_BEST_EFFORT
+	cmp	r2, #0
+	beq	2f
+#endif /* CONFIG_ARM_FCSE_BEST_EFFORT */
+#ifndef CONFIG_ARM_FCSE_GUARANTEED
 	clean_d_cache r1, r2
 	mcr	p15, 0, ip, c7, c5, 0		@ Invalidate I cache & BTB
 	mcr	p15, 0, ip, c7, c10, 4		@ Drain Write (& Fill) Buffer
+#endif /* CONFIG_ARM_FCSE_GUARANTEED */
+#ifdef CONFIG_ARM_FCSE_BEST_EFFORT
+2:
+#endif /* CONFIG_ARM_FCSE_BEST_EFFORT */
 	mcr	p15, 0, r0, c2, c0, 0		@ load page table pointer
 	mcr	p15, 0, ip, c8, c7, 0		@ invalidate I & D TLBs
 	cpwait_ret lr, ip
-- 
1.5.6.5
