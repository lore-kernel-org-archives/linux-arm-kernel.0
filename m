From: will.deacon@arm.com (Will Deacon)
Date: Tue,  8 Nov 2011 15:00:14 +0000
Subject: [PATCH] ARM: mm: update CONTEXTIDR register to contain PID of current
 process
Message-ID: <1320764414-12599-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces a new Kconfig option which, when enabled, causes
the kernel to write the PID of the current task into the PROCID field
of the CONTEXTIDR on context switch. This is useful when analysing
hardware trace, since writes to this register can be configured to emit
an event into the trace stream.

The thread notifier for writing the PID is deliberately kept separate
from the ASID code, so that we can easily support newer processors (A15
onwards) which store the ASID in TTBR0. As such, the switch_mm code is
updated to perform a read-modify-write sequence to ensure that we don't
clobber the PID on older CPUs.

Cc: Wolfgang Betz <wolfgang.betz@st.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/Kconfig.debug |    9 ++++++
 arch/arm/mm/context.c  |   67 +++++++++++++++++++++++++++++++++++++++++++++---
 arch/arm/mm/proc-v6.S  |    6 ++++
 arch/arm/mm/proc-v7.S  |    6 ++++
 4 files changed, 84 insertions(+), 4 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index c5213e7..5b9eca2 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -271,4 +271,13 @@ config ARM_KPROBES_TEST
 	help
 	  Perform tests of kprobes API and instruction set simulation.
 
+config PID_IN_CONTEXTIDR
+	bool "Write the current PID to the CONTEXTIDR register"
+	depends on CPU_COPY_V6
+	help
+	  Enabling this option causes the kernel to write the current PID to
+	  the PROCID field of the CONTEXTIDR register, at the expense of some
+	  additional instructions during context switch. Say Y here only if you
+	  are planning to use hardware trace tools with this kernel.
+
 endmenu
diff --git a/arch/arm/mm/context.c b/arch/arm/mm/context.c
index 93aac06..14536f6 100644
--- a/arch/arm/mm/context.c
+++ b/arch/arm/mm/context.c
@@ -14,6 +14,7 @@
 #include <linux/percpu.h>
 
 #include <asm/mmu_context.h>
+#include <asm/thread_notify.h>
 #include <asm/tlbflush.h>
 
 static DEFINE_RAW_SPINLOCK(cpu_asid_lock);
@@ -22,6 +23,66 @@ unsigned int cpu_last_asid = ASID_FIRST_VERSION;
 DEFINE_PER_CPU(struct mm_struct *, current_mm);
 #endif
 
+static void write_contextidr(u32 contextidr)
+{
+	asm("mcr	p15, 0, %0, c13, c0, 1" : : "r" (contextidr));
+	isb();
+}
+
+#ifdef CONFIG_PID_IN_CONTEXTIDR
+static u32 read_contextidr(void)
+{
+	u32 contextidr;
+	asm("mrc	p15, 0, %0, c13, c0, 1" : "=r" (contextidr));
+	return contextidr;
+}
+
+static int contextidr_notifier(struct notifier_block *unused, unsigned long cmd,
+			       void *t)
+{
+	unsigned long flags;
+	u32 contextidr;
+	pid_t pid;
+	struct thread_info *thread = t;
+
+	if (cmd != THREAD_NOTIFY_SWITCH)
+		return NOTIFY_DONE;
+
+	pid = task_pid_nr(thread->task);
+	local_irq_save(flags);
+	contextidr = read_contextidr();
+	contextidr &= ~ASID_MASK;
+	contextidr |= pid << ASID_BITS;
+	write_contextidr(contextidr);
+	local_irq_restore(flags);
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block contextidr_notifier_block = {
+	.notifier_call = contextidr_notifier,
+};
+
+static int __init contextidr_notifier_init(void)
+{
+	return thread_register_notifier(&contextidr_notifier_block);
+}
+arch_initcall(contextidr_notifier_init);
+
+static void set_asid(unsigned int asid)
+{
+	u32 contextidr = read_contextidr();
+	contextidr &= ASID_MASK;
+	contextidr |= asid & ~ASID_MASK;
+	write_contextidr(contextidr);
+}
+#else
+static void set_asid(unsigned int asid)
+{
+	write_contextidr(asid);
+}
+#endif
+
 /*
  * We fork()ed a process, and we need a new context for the child
  * to run in.  We reserve version 0 for initial tasks so we will
@@ -37,8 +98,7 @@ void __init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 static void flush_context(void)
 {
 	/* set the reserved ASID before flushing the TLB */
-	asm("mcr	p15, 0, %0, c13, c0, 1\n" : : "r" (0));
-	isb();
+	set_asid(0);
 	local_flush_tlb_all();
 	if (icache_is_vivt_asid_tagged()) {
 		__flush_icache_all();
@@ -99,8 +159,7 @@ static void reset_context(void *info)
 	set_mm_context(mm, asid);
 
 	/* set the new ASID */
-	asm("mcr	p15, 0, %0, c13, c0, 1\n" : : "r" (mm->context.id));
-	isb();
+	set_asid(mm->context.id);
 }
 
 #else
diff --git a/arch/arm/mm/proc-v6.S b/arch/arm/mm/proc-v6.S
index d061d2f..8614eb3 100644
--- a/arch/arm/mm/proc-v6.S
+++ b/arch/arm/mm/proc-v6.S
@@ -104,6 +104,12 @@ ENTRY(cpu_v6_switch_mm)
 	mcr	p15, 0, r2, c7, c5, 6		@ flush BTAC/BTB
 	mcr	p15, 0, r2, c7, c10, 4		@ drain write buffer
 	mcr	p15, 0, r0, c2, c0, 0		@ set TTB 0
+#ifdef CONFIG_PID_IN_CONTEXTIDR
+	mrc	p15, 0, r2, c13, c0, 1		@ read current context ID
+	bic	r2, r2, #0xff			@ extract the PID
+	and	r1, r1, #0xff
+	orr	r1, r1, r2			@ insert the PID into r1
+#endif
 	mcr	p15, 0, r1, c13, c0, 1		@ set context ID
 #endif
 	mov	pc, lr
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 2c559ac..fe1075d 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -119,6 +119,12 @@ ENTRY(cpu_v7_switch_mm)
 #ifdef CONFIG_ARM_ERRATA_754322
 	dsb
 #endif
+#ifdef CONFIG_PID_IN_CONTEXTIDR
+	mrc	p15, 0, r2, c13, c0, 1		@ read current context ID
+	bic	r2, r2, #0xff			@ extract the PID
+	and	r1, r1, #0xff
+	orr	r1, r1, r2			@ insert the PID into r1
+#endif
 	mcr	p15, 0, r2, c13, c0, 1		@ set reserved context ID
 	isb
 1:	mcr	p15, 0, r0, c2, c0, 0		@ set TTB 0
-- 
1.7.4.1
