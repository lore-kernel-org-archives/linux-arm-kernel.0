From: vijay.kilari@gmail.com (vijay.kilari at gmail.com)
Date: Mon, 16 Sep 2013 14:25:50 +0530
Subject: [RFC PATCH 2/2] Aarch64: KGDB: Add Step debugging support
In-Reply-To: <1379321750-907-1-git-send-email-vijay.kilari@gmail.com>
References: <1379321750-907-1-git-send-email-vijay.kilari@gmail.com>
Message-ID: <1379321750-907-3-git-send-email-vijay.kilari@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>

Add KGDB software step debugging support for EL1 debug
in Aarch64 mode.

KGDB registers step debug handler with debug monitor.
On receiving 'step' command from GDB tool, target enables
software step debugging and step address is written to ELR
register. If not step address is received from GDB tool,
target assumes next step address is PC and ERET is
executed as part of exception return.

ELR register content is protected against context restore in
exception return by checking against Software Step debug
bit MDSCR.SS

Software Step debugging is disabled when 'continue' command
is received

Signed-off-by: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>
---
 arch/arm64/include/asm/debug-monitors.h |    3 +++
 arch/arm64/kernel/debug-monitors.c      |   15 +++++++++++++
 arch/arm64/kernel/entry.S               |    9 +++++++-
 arch/arm64/kernel/kgdb.c                |   36 +++++++++++++++++++++++++++++++
 4 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/asm/debug-monitors.h
index aff3a76..3e4ac0d 100644
--- a/arch/arm64/include/asm/debug-monitors.h
+++ b/arch/arm64/include/asm/debug-monitors.h
@@ -94,6 +94,9 @@ void kernel_enable_single_step(struct pt_regs *regs);
 void kernel_disable_single_step(void);
 int kernel_active_single_step(void);
 
+void elr_write(unsigned long elr);
+unsigned long elr_read(void);
+
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
 int reinstall_suspended_bps(struct pt_regs *regs);
 #else
diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index f8b90c0..0408490 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -64,6 +64,21 @@ static u32 mdscr_read(void)
 	return mdscr;
 }
 
+void elr_write(unsigned long elr)
+{
+	unsigned long flags;
+	local_dbg_save(flags);
+	asm volatile("msr elr_el1, %0" :: "r" (elr));
+	local_dbg_restore(flags);
+}
+
+unsigned long elr_read(void)
+{
+	unsigned long elr;
+	asm volatile("mrs %0, elr_el1" : "=r" (elr));
+	return elr;
+}
+
 /*
  * Allow root to disable self-hosted debug from userspace.
  * This is useful if you want to connect an external JTAG debugger.
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 226be77..23d91f1 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -100,7 +100,14 @@
 	pop	x4, x5
 	pop	x6, x7
 	pop	x8, x9
-	msr	elr_el1, x21			// set up the return data
+	.if     \el == 1
+	mrs     x10, mdscr_el1			// check if step debug is enabled
+	tbnz    x10, #0, 1f
+	msr     elr_el1, x21
+	.else
+	msr     elr_el1, x21			// set up the return data
+	.endif
+1:
 	msr	spsr_el1, x22
 	.if	\el == 0
 	msr	sp_el0, x23
diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
index a3a7712..d5e5884 100644
--- a/arch/arm64/kernel/kgdb.c
+++ b/arch/arm64/kernel/kgdb.c
@@ -164,9 +164,31 @@ int kgdb_arch_handle_exception(int exception_vector, int signo, int err_code,
 			linux_regs->pc += 4;
 
 		compiled_break = 0;
+
+		/* Disable single step if enabled */
+		if (kernel_active_single_step())
+			kernel_disable_single_step();
+
 		err = 0;
 		break;
+	case 's':
+		/* 
+		 * Update ESR value with step address passed
+		 */
+		ptr = &remcom_in_buffer[1];
+		if (kgdb_hex2long(&ptr, &addr))
+			elr_write(addr);
+		else
+			elr_write(linux_regs->pc);
+
+		if (compiled_break == 1)
+			compiled_break = 0;
 
+		/* Enable step handling if not enabled */
+		if (!kernel_active_single_step())
+			kernel_enable_single_step(linux_regs);
+		err = 0;
+		break;
 	default:
 		err = -1;
 	}
@@ -188,6 +210,14 @@ static int kgdb_compiled_brk_fn(struct pt_regs *regs, unsigned int esr,
 
 	return 0;
 }
+
+static int kgdb_step_brk_fn(struct pt_regs *regs, unsigned int esr,
+			    unsigned long addr)
+{
+	kgdb_handle_exception(1, SIGTRAP, 0, regs);
+	return 0;
+}
+
 static struct break_hook kgdb_brkpt_hook = {
 	.esr_mask		= 0xffffffff,
 	.esr_magic		= KGDB_BREAKINST_ESR_VAL,
@@ -200,6 +230,10 @@ static struct break_hook kgdb_compiled_brkpt_hook = {
 	.fn			= kgdb_compiled_brk_fn
 };
 
+static struct step_hook kgdb_step_hook = {
+	.fn			= kgdb_step_brk_fn
+};
+
 static void kgdb_call_nmi_hook(void *ignored)
 {
 	kgdb_nmicallback(raw_smp_processor_id(), get_irq_regs());
@@ -254,6 +288,7 @@ int kgdb_arch_init(void)
 
 	register_break_hook(&kgdb_brkpt_hook);
 	register_break_hook(&kgdb_compiled_brkpt_hook);
+	register_step_hook(&kgdb_step_hook);
 
 	return 0;
 }
@@ -268,6 +303,7 @@ void kgdb_arch_exit(void)
 {
 	unregister_break_hook(&kgdb_brkpt_hook);
 	unregister_break_hook(&kgdb_compiled_brkpt_hook);
+	unregister_step_hook(&kgdb_step_hook);
 	unregister_die_notifier(&kgdb_notifier);
 }
 
-- 
1.7.9.5
