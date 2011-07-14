From: wolfgang.betz@st.com (Wolfgang BETZ)
Date: Thu, 14 Jul 2011 11:33:10 +0200
Subject: [PATCH 1/1 V2] Add Thread Support for the Context ID Register of
	ARM v6 & v7 Architectures
In-Reply-To: <cover.1310544641.git.wolfgang.betz@st.com>
References: <cover.1310544641.git.wolfgang.betz@st.com>
Message-ID: <a4ef7565bd6013f56c5c10071bd36739c59768b7.1310544641.git.wolfgang.betz@st.com>
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
In order to achieve this, this patch modifies 6 files of the kernel as described
hereafter:
- First a new configuration variable THREAD_CONTEXTID has been introduced in
  file "arch/arm/Kconfig.debug", which basically enables the patch (if not
  enabled, the kernel behaves as if it would not have been modified at all).
  This configuration variable depends obviously on the presence of a context
  ID register and automatically selects TRACING as the patch is partially based
  on tracepoints. Furthermore it enables both DEBUG_KERNEL and DEBUG_INFO as it
  is supposed that a backend tool which will analyze the generated trace will
  require access to debugging information like e.g. the debug symbols of the
  kernel and modules.
- The major part of the modifications of this patch are concentrated in file
  "arch/arm/include/asm/mmu_context.h", where a new function, i.e.
  "calc_context_id", has been introduced. The objective of this function is to
  calculate the contents of the context ID register (CONTEXTIDR), as described
  above, which should be moved into this register on the next context switch.
  Furthermore, there is a new convenience function, i.e. "set_context_id",
  which allows to set the CONTEXTIDR based on the outcome of a call to
  "calc_context_id". Finally, function "switch_mm" has been modified similarly
  by replacing the second argument in the call to "cpu_switch_mm" with the
  outcome of a call to "calc_context_id". The very same modification was
  necessary also in function "secondary_start_kernel" of file
  "arch/arm/kernel/smp.c".
- File "arch/arm/mm/context.c" has been modified for one thing to make use of the
  new convenience function "set_context_id", for another thing to register a new
  "sched_switch" tracepoint function to trace thread switches not already covered
  by "switch_mm".
- Finally, functions "cpu_v6_switch_mm" and "cpu_v7_switch_mm", in files
  "arch/arm/mm/proc-v6.S" and "arch/arm/mm/proc-v7.S" respectively, have been
  modified so that these expect now the content to be moved into CONTEXTIDR to be
  directly passed as second argument (i.e. within "r1").

Signed-off-by: Wolfgang Betz <wolfgang.betz@st.com>
---
 arch/arm/Kconfig.debug             |   13 +++++++
 arch/arm/include/asm/mmu_context.h |   63 +++++++++++++++++++++++++++++++----
 arch/arm/kernel/smp.c              |    2 +-
 arch/arm/mm/context.c              |   42 +++++++++++++++++++++++-
 arch/arm/mm/proc-v6.S              |    1 -
 arch/arm/mm/proc-v7.S              |    1 -
 6 files changed, 109 insertions(+), 13 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 81cbe40..0b20c04 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -129,4 +129,17 @@ config DEBUG_S3C_UART
 	  The uncompressor code port configuration is now handled
 	  by CONFIG_S3C_LOWLEVEL_UART_PORT.
 
+config THREAD_CONTEXTID
+	bool "Enable thread support for the Context ID Register"
+	depends on CPU_HAS_ASID
+	default n
+	select DEBUG_KERNEL
+	select DEBUG_INFO
+	select TRACING
+	help
+	  Say Y here if you want to enable thread support for the trace logic
+	  of tools such as Lauterbach's TRACE32 tool.
+	  This thread tracing support is based on the CONTEXTIDR register of
+	  architectures like the ARM v6 or v7.
+
 endmenu
diff --git a/arch/arm/include/asm/mmu_context.h b/arch/arm/include/asm/mmu_context.h
index 71605d9..299cff4 100644
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
@@ -68,7 +69,53 @@ static inline void check_context(struct mm_struct *mm)
 
 #define init_new_context(tsk,mm)	(__init_new_context(tsk,mm),0)
 
-#else
+#ifdef CONFIG_THREAD_CONTEXTID
+/*
+ * Calculate context ID for task and mm
+ */
+static inline
+struct mm_struct *calc_context_id(struct task_struct *tsk,
+				  struct mm_struct *mm)
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
+	return (struct mm_struct *)((mm->context.id & ~ASID_MASK) | ret);
+}
+#else /* !CONFIG_THREAD_CONTEXTID */
+/*
+ * Calculate context ID for task and mm
+ */
+static inline
+struct mm_struct *calc_context_id(struct task_struct *tsk,
+				  struct mm_struct *mm)
+{
+	return (struct mm_struct *)(mm->context.id);
+}
+#endif /* !CONFIG_THREAD_CONTEXTID */
+
+/*
+ * Set context ID for task and mm
+ */
+static inline
+void set_context_id(struct task_struct *tsk, struct mm_struct *mm)
+{
+	unsigned int ctxid = (unsigned int)calc_context_id(tsk, mm);
+
+	/* set the new ContextID */
+	asm("mcr	p15, 0, %0, c13, c0, 1\n" : : "r" (ctxid));
+	isb();
+}
+
+#else /* !CONFIG_CPU_HAS_ASID */
 
 static inline void check_context(struct mm_struct *mm)
 {
@@ -78,9 +125,9 @@ static inline void check_context(struct mm_struct *mm)
 #endif
 }
 
-#define init_new_context(tsk,mm)	0
-
-#endif
+#define init_new_context(tsk, mm)	0
+#define calc_context_id(tsk, mm)	(mm)
+#endif /* !CONFIG_CPU_HAS_ASID */
 
 #define destroy_context(mm)		do { } while(0)
 
@@ -123,7 +170,7 @@ switch_mm(struct mm_struct *prev, struct mm_struct *next,
 		*crt_mm = next;
 #endif
 		check_context(next);
-		cpu_switch_mm(next->pgd, next);
+		cpu_switch_mm(next->pgd, calc_context_id(tsk, next));
 		if (cache_is_vivt())
 			cpumask_clear_cpu(cpu, mm_cpumask(prev));
 	}
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index e7f92a4..a50725e 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -288,7 +288,7 @@ asmlinkage void __cpuinit secondary_start_kernel(void)
 	atomic_inc(&mm->mm_count);
 	current->active_mm = mm;
 	cpumask_set_cpu(cpu, mm_cpumask(mm));
-	cpu_switch_mm(mm->pgd, mm);
+	cpu_switch_mm(mm->pgd, calc_context_id(current, mm));
 	enter_lazy_tlb(mm, current);
 	local_flush_tlb_all();
 
diff --git a/arch/arm/mm/context.c b/arch/arm/mm/context.c
index b0ee9ba..8f63718 100644
--- a/arch/arm/mm/context.c
+++ b/arch/arm/mm/context.c
@@ -16,6 +16,10 @@
 #include <asm/mmu_context.h>
 #include <asm/tlbflush.h>
 
+#ifdef CONFIG_THREAD_CONTEXTID
+#include <trace/events/sched.h>
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
+	set_context_id(current, mm);
 }
 
 #else
@@ -155,3 +158,38 @@ void __new_context(struct mm_struct *mm)
 	set_mm_context(mm, asid);
 	spin_unlock(&cpu_asid_lock);
 }
+
+#ifdef CONFIG_THREAD_CONTEXTID
+/*
+ * Add support for threads in CONTEXTIDR by registering a
+ * 'sched_switch' tracepoint event function
+ */
+static void thrctx_sched_switch(void *ignore, struct task_struct *prev,
+				struct task_struct *next)
+{
+	struct mm_struct *mm, *oldmm;
+
+	mm = next->mm;
+	oldmm = prev->active_mm;
+
+	if (!mm) {
+		set_context_id(next, oldmm);
+	} else {
+		if (oldmm == mm)
+			set_context_id(next, mm);
+	}
+}
+
+static int __init init_thread_contextid(void)
+{
+	int ret;
+
+	ret = register_trace_sched_switch(thrctx_sched_switch, NULL);
+	if (ret)
+		pr_info("ftrace_graph: Couldn't activate tracepoint"
+			" probe to kernel_sched_switch\n");
+
+	return ret;
+}
+device_initcall(init_thread_contextid);
+#endif /* CONFIG_THREAD_CONTEXTID */
diff --git a/arch/arm/mm/proc-v6.S b/arch/arm/mm/proc-v6.S
index 1d2b845..57f3574 100644
--- a/arch/arm/mm/proc-v6.S
+++ b/arch/arm/mm/proc-v6.S
@@ -93,7 +93,6 @@ ENTRY(cpu_v6_dcache_clean_area)
 ENTRY(cpu_v6_switch_mm)
 #ifdef CONFIG_MMU
 	mov	r2, #0
-	ldr	r1, [r1, #MM_CONTEXT_ID]	@ get mm->context.id
 	ALT_SMP(orr	r0, r0, #TTB_FLAGS_SMP)
 	ALT_UP(orr	r0, r0, #TTB_FLAGS_UP)
 	mcr	p15, 0, r2, c7, c5, 6		@ flush BTAC/BTB
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 089c0b5..f725698 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -102,7 +102,6 @@ ENDPROC(cpu_v7_dcache_clean_area)
 ENTRY(cpu_v7_switch_mm)
 #ifdef CONFIG_MMU
 	mov	r2, #0
-	ldr	r1, [r1, #MM_CONTEXT_ID]	@ get mm->context.id
 	ALT_SMP(orr	r0, r0, #TTB_FLAGS_SMP)
 	ALT_UP(orr	r0, r0, #TTB_FLAGS_UP)
 #ifdef CONFIG_ARM_ERRATA_430973
-- 
1.7.4.4
