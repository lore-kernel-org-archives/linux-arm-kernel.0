From: ynorov@caviumnetworks.com (Yury Norov)
Date: Thu,  5 Apr 2018 20:17:58 +0300
Subject: [PATCH 3/5] arm64: early ISB at exit from extended quiescent state
In-Reply-To: <20180405171800.5648-1-ynorov@caviumnetworks.com>
References: <20180405171800.5648-1-ynorov@caviumnetworks.com>
Message-ID: <20180405171800.5648-4-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series enables delaying of kernel memory synchronization
for CPUs running in extended quiescent state (EQS) till the exit
of that state.

ARM64 uses IPI mechanism to notify all cores in  SMP system that
kernel text is changed; and IPI handler calls isb() to synchronize.

If we don't deliver IPI to EQS CPUs anymore, we should add ISB early
in EQS exit path.

There are 2 such paths. One starts in do_idle() loop, and other
in el0_svc entry. For do_idle(), isb() is added in
arch_cpu_idle_exit() hook. And for SVC handler, isb is called in
el0_svc_naked.

Suggested-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 arch/arm64/kernel/entry.S   | 16 +++++++++++++++-
 arch/arm64/kernel/process.c |  7 +++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index c8d9ec363ddd..b1e1c19b4432 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -48,7 +48,7 @@
 	.endm
 
 	.macro el0_svc_restore_syscall_args
-#if defined(CONFIG_CONTEXT_TRACKING)
+#if !defined(CONFIG_TINY_RCU) || defined(CONFIG_CONTEXT_TRACKING)
 	restore_syscall_args
 #endif
 	.endm
@@ -483,6 +483,19 @@ __bad_stack:
 	ASM_BUG()
 	.endm
 
+/*
+ * If CPU is in extended quiescent state we need isb to ensure that
+ * possible change of kernel text is visible by the core.
+ */
+	.macro	isb_if_eqs
+#ifndef CONFIG_TINY_RCU
+	bl	rcu_is_watching
+	cbnz	x0, 1f
+	isb 					// pairs with aarch64_insn_patch_text
+1:
+#endif
+	.endm
+
 el0_sync_invalid:
 	inv_entry 0, BAD_SYNC
 ENDPROC(el0_sync_invalid)
@@ -949,6 +962,7 @@ alternative_else_nop_endif
 
 el0_svc_naked:					// compat entry point
 	stp	x0, xscno, [sp, #S_ORIG_X0]	// save the original x0 and syscall number
+	isb_if_eqs
 	enable_daif
 	ct_user_exit
 	el0_svc_restore_syscall_args
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index f08a2ed9db0d..74cad496b07b 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -88,6 +88,13 @@ void arch_cpu_idle(void)
 	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, smp_processor_id());
 }
 
+void arch_cpu_idle_exit(void)
+{
+	/* Pairs with aarch64_insn_patch_text() for EQS CPUs. */
+	if (!rcu_is_watching())
+		isb();
+}
+
 #ifdef CONFIG_HOTPLUG_CPU
 void arch_cpu_idle_dead(void)
 {
-- 
2.14.1
