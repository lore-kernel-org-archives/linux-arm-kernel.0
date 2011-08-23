From: wolfgang.betz@st.com (Wolfgang BETZ)
Date: Tue, 23 Aug 2011 18:12:02 +0200
Subject: [RFC][PATCH 1/1 v1] Using Thread Notifiers to Add Thread Support
	for the Context ID Register of ARM v6 & v7 Architectures
In-Reply-To: <cover.1314115617.git.wolfgang.betz@st.com>
References: <cover.1314115617.git.wolfgang.betz@st.com>
Message-ID: <d375082dabe4a6133dc97c027219a7a0c1f24b70.1314115617.git.wolfgang.betz@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfgang Betz <wolfgang.betz@st.com>

The aim of this patch is to enable thread support in the context ID register
(CONTEXTIDR) as it comes with ARM architectures v6 & v7.

 On ARMv6 & v7, we have the following structure in the context ID:

   31                         7          0
   +-------------------------+-----------+
   |      process ID         |   ASID    |
   +-------------------------+-----------+
   |              context ID             |
   +-------------------------------------+

- The ASID is used to tag entries in the CPU caches and TLBs.
- The process ID must be programmed with a unique value that identifies the
  current process. It is used by the trace logic and the debug logic to
  identify the process that is running currently.

Currently the Linux kernel does correctly support the ASID field of the register,
but does not make use of the process ID in a way that would allow trace logic to
efficiently identify context switches.
In order to achieve this, this patch modifies 7 files of the kernel as described
hereafter:
- First a new configuration variable THREAD_CONTEXTID has been introduced in
  file "arch/arm/Kconfig.debug", which basically enables the patch (if not
  enabled, the kernel behaves as if it would not have been modified at all).
  This configuration variable depends obviously on the presence of a context
  ID register and automatically selects both DEBUG_KERNEL and DEBUG_INFO as it
  is supposed that a backend tool which will analyze the generated trace will
  require access to debugging information like e.g. the debug symbols of the
  kernel and modules.
- The major part of the modifications of this patch are concentrated in file
  "arch/arm/include/asm/mmu_context.h", where a new function, i.e. "context_id",
  has been introduced. The objective of this function is to calculate the contents
  of the context ID register (CONTEXTIDR), as described above, which should be
  moved into this register on the next context switch.
  Furthermore, there are two new convenience functions, i.e. "set_context_id",
  which allows to set the CONTEXTIDR, and "get_context_id", which retrieves the
  current value of the CONTEXTIDR.
  Finally, function "switch_mm" has been modified to adapt to the new signature of
  macro "cpu_switch_mm". The very same modification was necessary also in function
  "secondary_start_kernel" of file "arch/arm/kernel/smp.c".
- In file "arch/arm/include/asm/proc-fns.h" the prototypes of all CPU specific
  context switch functions have been modified into
  "void (*switch_mm)(unsigned long pgd_phys, unsigned int context_id)",
  while macro "cpu_switch_mm" has now an additional third parameter for the task
  structure of the task we are going to switch to.
- File "arch/arm/mm/context.c" has been modified for one thing to make use of the
  new convenience function "set_context_id", for another thing to register a new
  'notify switch' thread notifier function to handle thread switches not already
  covered by "switch_mm".
- Finally, functions "cpu_v6_switch_mm" and "cpu_v7_switch_mm", in files
  "arch/arm/mm/proc-v6.S" and "arch/arm/mm/proc-v7.S" respectively, have been
  modified so that these expect now the content to be moved into CONTEXTIDR to be
  directly passed as second argument (i.e. within "r1").

Signed-off-by: Wolfgang Betz <wolfgang.betz@st.com>
---
 arch/arm/Kconfig.debug             |   12 ++++++
 arch/arm/include/asm/mmu_context.h |   75 ++++++++++++++++++++++++++++++++----
 arch/arm/include/asm/proc-fns.h    |    9 ++--
 arch/arm/kernel/smp.c              |    2 +-
 arch/arm/mm/context.c              |   54 +++++++++++++++++++++++++-
 arch/arm/mm/proc-v6.S              |    4 +-
 arch/arm/mm/proc-v7.S              |    4 +-
 7 files changed, 140 insertions(+), 20 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 81cbe40..80dc6d0 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -129,4 +129,16 @@ config DEBUG_S3C_UART
 	  The uncompressor code port configuration is now handled
 	  by CONFIG_S3C_LOWLEVEL_UART_PORT.
 
+config THREAD_CONTEXTID
+	bool "Enable thread support for the Context ID Register"
+	depends on CPU_HAS_ASID
+	default n
+	select DEBUG_KERNEL
+	select DEBUG_INFO
+	help
+	  Say Y here if you want to enable thread support for the trace logic
+	  of tools such as Lauterbach's TRACE32 tool.
+	  This thread tracing support is based on the CONTEXTIDR register of
+	  architectures like the ARM v6 or v7.
+
 endmenu
diff --git a/arch/arm/include/asm/mmu_context.h b/arch/arm/include/asm/mmu_context.h
index 71605d9..b172325 100644
--- a/arch/arm/include/asm/mmu_context.h
+++ b/arch/arm/include/asm/mmu_context.h
@@ -24,7 +24,7 @@ void __check_kvm_seq(struct mm_struct *mm);
 #ifdef CONFIG_CPU_HAS_ASID
 
 /*
- * On ARMv6, we have the following structure in the Context ID:
+ * On ARMv6 & v7, we have the following structure in the Context ID:
  *
  * 31                         7          0
  * +-------------------------+-----------+
@@ -34,8 +34,9 @@ void __check_kvm_seq(struct mm_struct *mm);
  * +-------------------------------------+
  *
  * The ASID is used to tag entries in the CPU caches and TLBs.
- * The context ID is used by debuggers and trace logic, and
- * should be unique within all running processes.
+ * The process ID must be programmed with a unique value that identifies the
+ * current process. It is used by the trace logic and the debug logic
+ * to identify the process that is running currently.
  */
 #define ASID_BITS		8
 #define ASID_MASK		((~0) << ASID_BITS)
@@ -68,7 +69,65 @@ static inline void check_context(struct mm_struct *mm)
 
 #define init_new_context(tsk,mm)	(__init_new_context(tsk,mm),0)
 
-#else
+#ifdef CONFIG_THREAD_CONTEXTID
+/*
+ * Calculate context ID for task and mm
+ */
+static inline
+unsigned int context_id(struct task_struct *tsk,
+			struct mm_struct *mm)
+{
+	unsigned int ret;
+
+	if (unlikely(tsk == NULL))
+		ret = (current->pid << ASID_BITS);
+	else
+		ret = (tsk->pid << ASID_BITS);
+
+
+	if (unlikely(!ret))
+		ret = (0xFFFFFFFF << ASID_BITS);
+
+	return (mm->context.id & ~ASID_MASK) | ret;
+}
+#else /* !CONFIG_THREAD_CONTEXTID */
+/*
+ * Calculate context ID for task and mm
+ */
+static inline
+unsigned int context_id(struct task_struct *tsk,
+			struct mm_struct *mm)
+{
+	return mm->context.id;
+}
+#endif /* !CONFIG_THREAD_CONTEXTID */
+
+/*
+ * Get the context ID from register
+ */
+static inline
+unsigned int get_context_id(void)
+{
+	unsigned int ctxid;
+
+	/* get the contents of the ContextID register */
+	asm("mrc	p15, 0, %0, c13, c0, 1\n" : "=r" (ctxid));
+
+	return ctxid;
+}
+
+/*
+ * Set context ID into register
+ */
+static inline
+void set_context_id(unsigned int ctxid)
+{
+	/* set the new ContextID */
+	asm("mcr	p15, 0, %0, c13, c0, 1\n" : : "r" (ctxid));
+	isb();
+}
+
+#else /* !CONFIG_CPU_HAS_ASID */
 
 static inline void check_context(struct mm_struct *mm)
 {
@@ -78,9 +137,9 @@ static inline void check_context(struct mm_struct *mm)
 #endif
 }
 
-#define init_new_context(tsk,mm)	0
-
-#endif
+#define init_new_context(tsk, mm)	0
+#define context_id(tsk, mm)	        0
+#endif /* !CONFIG_CPU_HAS_ASID */
 
 #define destroy_context(mm)		do { } while(0)
 
@@ -123,7 +182,7 @@ switch_mm(struct mm_struct *prev, struct mm_struct *next,
 		*crt_mm = next;
 #endif
 		check_context(next);
-		cpu_switch_mm(next->pgd, next);
+		cpu_switch_mm(next->pgd, next, tsk);
 		if (cache_is_vivt())
 			cpumask_clear_cpu(cpu, mm_cpumask(prev));
 	}
diff --git a/arch/arm/include/asm/proc-fns.h b/arch/arm/include/asm/proc-fns.h
index 633d1cb..0b82c8c 100644
--- a/arch/arm/include/asm/proc-fns.h
+++ b/arch/arm/include/asm/proc-fns.h
@@ -18,8 +18,6 @@
 
 #ifndef __ASSEMBLY__
 
-struct mm_struct;
-
 /*
  * Don't change this structure - ASM code relies on it.
  */
@@ -60,7 +58,7 @@ extern struct processor {
 	/*
 	 * Set the page table
 	 */
-	void (*switch_mm)(unsigned long pgd_phys, struct mm_struct *mm);
+	void (*switch_mm)(unsigned long pgd_phys, unsigned int context_id);
 	/*
 	 * Set a possibly extended PTE.  Non-extended PTEs should
 	 * ignore 'ext'.
@@ -78,7 +76,7 @@ extern void cpu_proc_init(void);
 extern void cpu_proc_fin(void);
 extern int cpu_do_idle(void);
 extern void cpu_dcache_clean_area(void *, int);
-extern void cpu_do_switch_mm(unsigned long pgd_phys, struct mm_struct *mm);
+extern void cpu_do_switch_mm(unsigned long pgd_phys, unsigned int context_id);
 extern void cpu_set_pte_ext(pte_t *ptep, pte_t pte, unsigned int ext);
 extern void cpu_reset(unsigned long addr) __attribute__((noreturn));
 #else
@@ -97,7 +95,8 @@ extern void cpu_resume(void);
 
 #ifdef CONFIG_MMU
 
-#define cpu_switch_mm(pgd,mm) cpu_do_switch_mm(virt_to_phys(pgd),mm)
+#define cpu_switch_mm(pgd, mm, tsk) cpu_do_switch_mm(virt_to_phys(pgd),	\
+						     context_id(tsk, mm))
 
 #define cpu_get_pgd()	\
 	({						\
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index d88ff02..e3adf22 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -288,7 +288,7 @@ asmlinkage void __cpuinit secondary_start_kernel(void)
 	atomic_inc(&mm->mm_count);
 	current->active_mm = mm;
 	cpumask_set_cpu(cpu, mm_cpumask(mm));
-	cpu_switch_mm(mm->pgd, mm);
+	cpu_switch_mm(mm->pgd, mm, current);
 	enter_lazy_tlb(mm, current);
 	local_flush_tlb_all();
 
diff --git a/arch/arm/mm/context.c b/arch/arm/mm/context.c
index b0ee9ba..a4bf065 100644
--- a/arch/arm/mm/context.c
+++ b/arch/arm/mm/context.c
@@ -16,6 +16,10 @@
 #include <asm/mmu_context.h>
 #include <asm/tlbflush.h>
 
+#ifdef CONFIG_THREAD_CONTEXTID
+#include <asm/thread_notify.h>
+#endif
+
 static DEFINE_SPINLOCK(cpu_asid_lock);
 unsigned int cpu_last_asid = ASID_FIRST_VERSION;
 #ifdef CONFIG_SMP
@@ -99,8 +103,7 @@ static void reset_context(void *info)
 	set_mm_context(mm, asid);
 
 	/* set the new ASID */
-	asm("mcr	p15, 0, %0, c13, c0, 1\n" : : "r" (mm->context.id));
-	isb();
+	set_context_id(context_id(current, mm));
 }
 
 #else
@@ -155,3 +158,50 @@ void __new_context(struct mm_struct *mm)
 	set_mm_context(mm, asid);
 	spin_unlock(&cpu_asid_lock);
 }
+
+#ifdef CONFIG_THREAD_CONTEXTID
+/*
+ * Add support for threads in CONTEXTIDR by registering a
+ * 'notify switch' thread notifier function
+ */
+static int contextidr_notifier(struct notifier_block *unused,
+			       unsigned long cmd, void *t)
+{
+	unsigned long flags;
+	unsigned int ctx_pid, ctxid_reg, ctxid;
+	struct thread_info *thread = t;
+
+	if (cmd != THREAD_NOTIFY_SWITCH)
+		return NOTIFY_DONE;
+
+	ctx_pid = (thread->task->pid << ASID_BITS);
+	if (unlikely(!ctx_pid))
+		ctx_pid = (0xFFFFFFFF << ASID_BITS);
+
+	local_irq_save(flags);
+	ctxid_reg = get_context_id();
+	ctxid = (ctxid_reg & ~ASID_MASK) | ctx_pid;
+	if (ctxid_reg != ctxid)
+		set_context_id(ctxid);
+	local_irq_restore(flags);
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block contextidr_notifier_block = {
+	.notifier_call = contextidr_notifier,
+};
+
+static int __init contextidr_init(void)
+{
+	int ret;
+
+	ret = thread_register_notifier(&contextidr_notifier_block);
+	if (ret)
+		pr_info("thread notfier: Couldn't activate thread notfier"
+			" function for 'notify switch'\n");
+
+	return ret;
+}
+late_initcall(contextidr_init);
+#endif /* CONFIG_THREAD_CONTEXTID */
diff --git a/arch/arm/mm/proc-v6.S b/arch/arm/mm/proc-v6.S
index 219138d..5ef9245 100644
--- a/arch/arm/mm/proc-v6.S
+++ b/arch/arm/mm/proc-v6.S
@@ -86,11 +86,12 @@ ENTRY(cpu_v6_dcache_clean_area)
 	mov	pc, lr
 
 /*
- *	cpu_arm926_switch_mm(pgd_phys, tsk)
+ *	cpu_v6_switch_mm(pgd_phys, context_id)
  *
  *	Set the translation table base pointer to be pgd_phys
  *
  *	- pgd_phys - physical address of new TTB
+ *      - context_id - context ID to be written into CONTEXTIDR
  *
  *	It is assumed that:
  *	- we are not using split page tables
@@ -98,7 +99,6 @@ ENTRY(cpu_v6_dcache_clean_area)
 ENTRY(cpu_v6_switch_mm)
 #ifdef CONFIG_MMU
 	mov	r2, #0
-	ldr	r1, [r1, #MM_CONTEXT_ID]	@ get mm->context.id
 	ALT_SMP(orr	r0, r0, #TTB_FLAGS_SMP)
 	ALT_UP(orr	r0, r0, #TTB_FLAGS_UP)
 	mcr	p15, 0, r2, c7, c5, 6		@ flush BTAC/BTB
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index a30e785..fdf0f32 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -97,11 +97,12 @@ ENTRY(cpu_v7_dcache_clean_area)
 ENDPROC(cpu_v7_dcache_clean_area)
 
 /*
- *	cpu_v7_switch_mm(pgd_phys, tsk)
+ *	cpu_v7_switch_mm(pgd_phys, context_id)
  *
  *	Set the translation table base pointer to be pgd_phys
  *
  *	- pgd_phys - physical address of new TTB
+ *      - context_id - context ID to be written into CONTEXTIDR
  *
  *	It is assumed that:
  *	- we are not using split page tables
@@ -109,7 +110,6 @@ ENDPROC(cpu_v7_dcache_clean_area)
 ENTRY(cpu_v7_switch_mm)
 #ifdef CONFIG_MMU
 	mov	r2, #0
-	ldr	r1, [r1, #MM_CONTEXT_ID]	@ get mm->context.id
 	ALT_SMP(orr	r0, r0, #TTB_FLAGS_SMP)
 	ALT_UP(orr	r0, r0, #TTB_FLAGS_UP)
 #ifdef CONFIG_ARM_ERRATA_430973
-- 
1.7.6
