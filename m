From: will.deacon@arm.com (Will Deacon)
Date: Fri, 20 Jan 2012 11:22:20 +0000
Subject: [PATCH] ARM: mm: update CONTEXTIDR register to contain PID of current
 process
Message-ID: <1327058540-11824-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces a new Kconfig option which, when enabled, causes
the kernel to write the PID of the current task into the PROCID field
of the CONTEXTIDR on context switch. This is useful when analysing
hardware trace, since writes to this register can be configured to emit
an event into the trace stream.

The thread notifier for writing the PID is deliberately kept separate
from the ASID-writing code so that we can support newer processors using
LPAE, where the ASID is stored in TTBR0. As such, the switch_mm code is
updated to perform a read-modify-write sequence to ensure that we don't
clobber the PID on CPUs using the classic 2-level page tables.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---

Note: This patch has changed significantly from my original posting here:

 http://lists.infradead.org/pipermail/linux-arm-kernel/2011-November/071890.html

This is largely due to LPAE support arriving in mainline but means that I've
removed the original tested-by / acked-by tags.

 arch/arm/Kconfig.debug       |    9 +++++
 arch/arm/mm/context.c        |   67 +++++++++++++++++++++++++++++++++++++++--
 arch/arm/mm/proc-v6.S        |    6 ++++
 arch/arm/mm/proc-v7-2level.S |    6 ++++
 4 files changed, 84 insertions(+), 4 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index e0d236d..52e2432 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -316,4 +316,13 @@ config ARM_KPROBES_TEST
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
index ee9bb36..fc519df 100644
--- a/arch/arm/mm/context.c
+++ b/arch/arm/mm/context.c
@@ -14,6 +14,7 @@
 #include <linux/percpu.h>
 
 #include <asm/mmu_context.h>
+#include <asm/thread_notify.h>
 #include <asm/tlbflush.h>
 
 static DEFINE_RAW_SPINLOCK(cpu_asid_lock);
@@ -22,6 +23,14 @@ unsigned int cpu_last_asid = ASID_FIRST_VERSION;
 DEFINE_PER_CPU(struct mm_struct *, current_mm);
 #endif
 
+#define read_contextidr(contextidr)					\
+	asm("mrc	p15, 0, %0, c13, c0, 1" : "=r" (contextidr));
+
+#define write_contextidr(contextidr) {					\
+	asm("mcr	p15, 0, %0, c13, c0, 1" : : "r" (contextidr));	\
+	isb();								\
+}
+
 #ifdef CONFIG_ARM_LPAE
 #define cpu_set_asid(asid) {						\
 	unsigned long ttbl, ttbh;					\
@@ -31,10 +40,62 @@ DEFINE_PER_CPU(struct mm_struct *, current_mm);
 	"	mcrr	p15, 0, %0, %1, c2		@ set TTBR0\n"	\
 	: "=&r" (ttbl), "=&r" (ttbh)					\
 	: "r" (asid & ~ASID_MASK));					\
+	isb();								\
+}
+
+#define cpu_set_procid	write_contextidr
+#elif defined (CONFIG_PID_IN_CONTEXTIDR)
+static void cpu_set_asid(unsigned int asid)
+{
+	u32 contextidr;
+
+	read_contextidr(contextidr);
+	contextidr &= ASID_MASK;
+	contextidr |= asid & ~ASID_MASK;
+	write_contextidr(contextidr);
+}
+
+static void cpu_set_procid(unsigned int procid)
+{
+	u32 contextidr;
+
+	read_contextidr(contextidr);
+	contextidr &= ~ASID_MASK;
+	contextidr |= procid << ASID_BITS;
+	write_contextidr(contextidr);
 }
 #else
-#define cpu_set_asid(asid) \
-	asm("	mcr	p15, 0, %0, c13, c0, 1\n" : : "r" (asid))
+#define cpu_set_asid	write_contextidr
+#endif
+
+#ifdef CONFIG_PID_IN_CONTEXTIDR
+static int contextidr_notifier(struct notifier_block *unused, unsigned long cmd,
+			       void *t)
+{
+	unsigned long flags;
+	pid_t pid;
+	struct thread_info *thread = t;
+
+	if (cmd != THREAD_NOTIFY_SWITCH)
+		return NOTIFY_DONE;
+
+	pid = task_pid_nr(thread->task);
+	local_irq_save(flags);
+	cpu_set_procid(pid);
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
 #endif
 
 /*
@@ -53,7 +114,6 @@ static void flush_context(void)
 {
 	/* set the reserved ASID before flushing the TLB */
 	cpu_set_asid(0);
-	isb();
 	local_flush_tlb_all();
 	if (icache_is_vivt_asid_tagged()) {
 		__flush_icache_all();
@@ -115,7 +175,6 @@ static void reset_context(void *info)
 
 	/* set the new ASID */
 	cpu_set_asid(mm->context.id);
-	isb();
 }
 
 #else
diff --git a/arch/arm/mm/proc-v6.S b/arch/arm/mm/proc-v6.S
index 5900cd5..501397a 100644
--- a/arch/arm/mm/proc-v6.S
+++ b/arch/arm/mm/proc-v6.S
@@ -107,6 +107,12 @@ ENTRY(cpu_v6_switch_mm)
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
diff --git a/arch/arm/mm/proc-v7-2level.S b/arch/arm/mm/proc-v7-2level.S
index 3a4b3e7..1f2cfda 100644
--- a/arch/arm/mm/proc-v7-2level.S
+++ b/arch/arm/mm/proc-v7-2level.S
@@ -49,6 +49,12 @@ ENTRY(cpu_v7_switch_mm)
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
