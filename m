From: will.deacon@arm.com (Will Deacon)
Date: Fri,  8 Jun 2012 16:16:46 +0100
Subject: [PATCH v3] ARM: mm: update CONTEXTIDR register to contain PID of
 current process
Message-ID: <1339168606-30060-1-git-send-email-will.deacon@arm.com>
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

It's been a while since I posted a version of this patch because I had
to rewrite most of it to fit with Catalin's changes to the context-switch
code. The new version is a fair bit cleaner than the old one and works
for both LPAE and classic MMU configurations.

 arch/arm/Kconfig.debug       |    9 +++++++++
 arch/arm/mm/context.c        |   35 +++++++++++++++++++++++++++++++++++
 arch/arm/mm/proc-v6.S        |    6 ++++++
 arch/arm/mm/proc-v7-2level.S |    5 +++++
 4 files changed, 55 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 01a1341..521e15b 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -369,4 +369,13 @@ config ARM_KPROBES_TEST
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
index 806cc4f..119bc52 100644
--- a/arch/arm/mm/context.c
+++ b/arch/arm/mm/context.c
@@ -14,6 +14,7 @@
 #include <linux/percpu.h>
 
 #include <asm/mmu_context.h>
+#include <asm/thread_notify.h>
 #include <asm/tlbflush.h>
 
 static DEFINE_RAW_SPINLOCK(cpu_asid_lock);
@@ -48,6 +49,40 @@ void cpu_set_reserved_ttbr0(void)
 }
 #endif
 
+#ifdef CONFIG_PID_IN_CONTEXTIDR
+static int contextidr_notifier(struct notifier_block *unused, unsigned long cmd,
+			       void *t)
+{
+	u32 contextidr;
+	pid_t pid;
+	struct thread_info *thread = t;
+
+	if (cmd != THREAD_NOTIFY_SWITCH)
+		return NOTIFY_DONE;
+
+	pid = task_pid_nr(thread->task) << ASID_BITS;
+	asm volatile(
+	"	mrc	p15, 0, %0, c13, c0, 1\n"
+	"	bfi	%1, %0, #0, %2\n"
+	"	mcr	p15, 0, %1, c13, c0, 1\n"
+	: "=r" (contextidr), "+r" (pid)
+	: "I" (ASID_BITS));
+	isb();
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
+#endif
+
 /*
  * We fork()ed a process, and we need a new context for the child
  * to run in.
diff --git a/arch/arm/mm/proc-v6.S b/arch/arm/mm/proc-v6.S
index 5900cd5..86b8b48 100644
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
+	orr	r1, r1, r2			@ insert into new context ID
+#endif
 	mcr	p15, 0, r1, c13, c0, 1		@ set context ID
 #endif
 	mov	pc, lr
diff --git a/arch/arm/mm/proc-v7-2level.S b/arch/arm/mm/proc-v7-2level.S
index 42ac069..fd045e7 100644
--- a/arch/arm/mm/proc-v7-2level.S
+++ b/arch/arm/mm/proc-v7-2level.S
@@ -46,6 +46,11 @@ ENTRY(cpu_v7_switch_mm)
 #ifdef CONFIG_ARM_ERRATA_430973
 	mcr	p15, 0, r2, c7, c5, 6		@ flush BTAC/BTB
 #endif
+#ifdef CONFIG_PID_IN_CONTEXTIDR
+	mrc	p15, 0, r2, c13, c0, 1		@ read current context ID
+	lsr	r2, r2, #8			@ extract the PID
+	bfi	r1, r2, #8, #24			@ insert into new context ID
+#endif
 #ifdef CONFIG_ARM_ERRATA_754322
 	dsb
 #endif
-- 
1.7.4.1
