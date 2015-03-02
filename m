From: wangnan0@huawei.com (Wang Nan)
Date: Mon, 2 Mar 2015 22:24:39 +0800
Subject: [RFC PATCH v4 01/34] x86,
 traps: Enable DEBUG_STACK after cpu_init() for TRAP_DB/BP.
In-Reply-To: <1425306312-3437-1-git-send-email-wangnan0@huawei.com>
References: <1425306312-3437-1-git-send-email-wangnan0@huawei.com>
Message-ID: <1425306312-3437-2-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Before this patch early_trap_init() installs DEBUG_STACK for X86_TRAP_BP
and X86_TRAP_DB. However, DEBUG_STACK doesn't work correctly until
cpu_init() <-- trap_init().

This patch passes 0 to set_intr_gate_ist() and
set_system_intr_gate_ist() instead of DEBUG_STACK to let it use same
stack as kernel, and installs DEBUG_STACK for them in trap_init().

As core runs at ring 0 between early_trap_init() and trap_init(), there
is no chance to get a bad stack before trap_init().

As NMI is also enabled in trap_init(), we don't need to care about
is_debug_stack() and related things used in arch/x86/kernel/nmi.c.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
---
 arch/x86/kernel/traps.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 9d2073e..4281988 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -925,9 +925,17 @@ dotraplinkage void do_iret_error(struct pt_regs *regs, long error_code)
 /* Set of traps needed for early debugging. */
 void __init early_trap_init(void)
 {
-	set_intr_gate_ist(X86_TRAP_DB, &debug, DEBUG_STACK);
+	/*
+	 * Don't set ist to DEBUG_STACK as it doesn't work until TSS is
+	 * ready in cpu_init() <-- trap_init(). Before trap_init(), CPU
+	 * runs at ring 0 so it is impossible to hit an invalid stack.
+	 * Using the original stack works well enough@this early
+	 * stage. DEBUG_STACK will be equipped after cpu_init() in
+	 * trap_init().
+	 */
+	set_intr_gate_ist(X86_TRAP_DB, &debug, 0);
 	/* int3 can be called from all */
-	set_system_intr_gate_ist(X86_TRAP_BP, &int3, DEBUG_STACK);
+	set_system_intr_gate_ist(X86_TRAP_BP, &int3, 0);
 #ifdef CONFIG_X86_32
 	set_intr_gate(X86_TRAP_PF, page_fault);
 #endif
@@ -1005,6 +1013,15 @@ void __init trap_init(void)
 	 */
 	cpu_init();
 
+	/*
+	 * X86_TRAP_DB and X86_TRAP_BP have been set
+	 * in early_trap_init(). However, DEBUG_STACK works only after
+	 * cpu_init() loads TSS. See comments in early_trap_init().
+	 */
+	set_intr_gate_ist(X86_TRAP_DB, &debug, DEBUG_STACK);
+	/* int3 can be called from all */
+	set_system_intr_gate_ist(X86_TRAP_BP, &int3, DEBUG_STACK);
+
 	x86_init.irqs.trap_init();
 
 #ifdef CONFIG_X86_64
-- 
1.8.4
