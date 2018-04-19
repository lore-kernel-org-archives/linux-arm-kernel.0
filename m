From: liwei1412@163.com (Wei Li)
Date: Thu, 19 Apr 2018 20:23:41 +0800 (CST)
Subject: [PATCH] arm64: fix single step issue in kgdb
Message-ID: <3a4aff03.a762.162dddc3d1b.Coremail.liwei1412@163.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Li <liwei1412@163.com>

In kdb, as the frontend for kgdb, cmd "ss" does not work well. It can only take effects once and the single step exception is reported as oops after a breakpoint triggered in kdb. Then the cmd "go" does not work well either due to this. Refer to the DDI0487C_a_armv8_arm.pdf (D2.12), i set the SPSR.SS=1 every time. It has been verified in qemu.

Signed-off-by: Wei Li <liwei1412@163.com>
---
?include/asm/debug-monitors.h |??? 3 +++
?kernel/debug-monitors.c????? |??? 4 ++--
?kernel/kgdb.c??????????????? |??? 3 ++-
?3 files changed, 7 insertions(+), 3 deletions(-)
?
diff -uprN linux-4.16.2_org/arch/arm64/include/asm/debug-monitors.h linux-4.16.2_mod/arch/arm64/include/asm/debug-monitors.h
--- linux-4.16.2_org/arch/arm64/include/asm/debug-monitors.h?? ?2018-04-12 18:30:01.000000000 +0800
+++ linux-4.16.2_mod/arch/arm64/include/asm/debug-monitors.h?? ?2018-04-19 00:19:10.134999268 +0800
@@ -135,6 +135,9 @@ static inline int reinstall_suspended_bp
?
?int aarch32_break_handler(struct pt_regs *regs);
?
+void set_regs_spsr_ss(struct pt_regs *regs);
+void clear_regs_spsr_ss(struct pt_regs *regs);
+
?#endif?? ?/* __ASSEMBLY */
?#endif?? ?/* __KERNEL__ */
?#endif?? ?/* __ASM_DEBUG_MONITORS_H */
diff -uprN linux-4.16.2_org/arch/arm64/kernel/debug-monitors.c linux-4.16.2_mod/arch/arm64/kernel/debug-monitors.c
--- linux-4.16.2_org/arch/arm64/kernel/debug-monitors.c?? ?2018-04-12 18:30:01.000000000 +0800
+++ linux-4.16.2_mod/arch/arm64/kernel/debug-monitors.c?? ?2018-04-19 00:19:19.435189356 +0800
@@ -150,13 +150,13 @@ postcore_initcall(debug_monitors_init);
?/*
? * Single step API and exception handling.
? */
-static void set_regs_spsr_ss(struct pt_regs *regs)
+void set_regs_spsr_ss(struct pt_regs *regs)
?{
??? ?regs->pstate |= DBG_SPSR_SS;
?}
?NOKPROBE_SYMBOL(set_regs_spsr_ss);
?
-static void clear_regs_spsr_ss(struct pt_regs *regs)
+void clear_regs_spsr_ss(struct pt_regs *regs)
?{
??? ?regs->pstate &= ~DBG_SPSR_SS;
?}
diff -uprN linux-4.16.2_org/arch/arm64/kernel/kgdb.c linux-4.16.2_mod/arch/arm64/kernel/kgdb.c
--- linux-4.16.2_org/arch/arm64/kernel/kgdb.c?? ?2018-04-12 18:30:01.000000000 +0800
+++ linux-4.16.2_mod/arch/arm64/kernel/kgdb.c?? ?2018-04-19 00:19:40.892911795 +0800
@@ -221,6 +221,7 @@ int kgdb_arch_handle_exception(int excep
??? ??? ?/*
??? ??? ? * Enable single step handling
??? ??? ? */
+??????? set_regs_spsr_ss(linux_regs);
??? ??? ?if (!kernel_active_single_step())
??? ??? ??? ?kernel_enable_single_step(linux_regs);
??? ??? ?err = 0;
@@ -252,7 +253,7 @@ static int kgdb_step_brk_fn(struct pt_re
??? ?if (!kgdb_single_step)
??? ??? ?return DBG_HOOK_ERROR;
?
-?? ?kgdb_handle_exception(1, SIGTRAP, 0, regs);
+?? ?kgdb_handle_exception(0, SIGTRAP, 0, regs);
??? ?return 0;
?}
?NOKPROBE_SYMBOL(kgdb_step_brk_fn);
