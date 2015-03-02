From: wangnan0@huawei.com (Wang Nan)
Date: Mon, 2 Mar 2015 22:24:41 +0800
Subject: [RFC PATCH v4 03/34] x86,
 traps: install gates using IST after cpu_init().
In-Reply-To: <1425306312-3437-1-git-send-email-wangnan0@huawei.com>
References: <1425306312-3437-1-git-send-email-wangnan0@huawei.com>
Message-ID: <1425306312-3437-4-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

X86_TRAP_NMI, X86_TRAP_DF and X86_TRAP_MC use their own stack. Those
stacks are invalid until cpu_init() installs TSS.

This patch moves setting of the 3 gates after cpu_init().

Signed-off-by: Wang Nan <wangnan0@huawei.com>
---
 arch/x86/kernel/traps.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 9965bd1..4000b19 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -966,7 +966,6 @@ void __init trap_init(void)
 #endif
 
 	set_intr_gate(X86_TRAP_DE, divide_error);
-	set_intr_gate_ist(X86_TRAP_NMI, &nmi, NMI_STACK);
 	/* int4 can be called from all */
 	set_system_intr_gate(X86_TRAP_OF, &overflow);
 	set_intr_gate(X86_TRAP_BR, bounds);
@@ -974,8 +973,6 @@ void __init trap_init(void)
 	set_intr_gate(X86_TRAP_NM, device_not_available);
 #ifdef CONFIG_X86_32
 	set_task_gate(X86_TRAP_DF, GDT_ENTRY_DOUBLEFAULT_TSS);
-#else
-	set_intr_gate_ist(X86_TRAP_DF, &double_fault, DOUBLEFAULT_STACK);
 #endif
 	set_intr_gate(X86_TRAP_OLD_MF, coprocessor_segment_overrun);
 	set_intr_gate(X86_TRAP_TS, invalid_TSS);
@@ -985,9 +982,6 @@ void __init trap_init(void)
 	set_intr_gate(X86_TRAP_SPURIOUS, spurious_interrupt_bug);
 	set_intr_gate(X86_TRAP_MF, coprocessor_error);
 	set_intr_gate(X86_TRAP_AC, alignment_check);
-#ifdef CONFIG_X86_MCE
-	set_intr_gate_ist(X86_TRAP_MC, &machine_check, MCE_STACK);
-#endif
 	set_intr_gate(X86_TRAP_XF, simd_coprocessor_error);
 
 	/* Reserve all the builtin and the syscall vector: */
@@ -1017,6 +1011,14 @@ void __init trap_init(void)
 	 */
 	cpu_init();
 
+	set_intr_gate_ist(X86_TRAP_NMI, &nmi, NMI_STACK);
+#ifndef CONFIG_X86_32
+	set_intr_gate_ist(X86_TRAP_DF, &double_fault, DOUBLEFAULT_STACK);
+#endif
+#ifdef CONFIG_X86_MCE
+	set_intr_gate_ist(X86_TRAP_MC, &machine_check, MCE_STACK);
+#endif
+
 	/*
 	 * X86_TRAP_DB and X86_TRAP_BP have been set
 	 * in early_trap_init(). However, ITS works only after
-- 
1.8.4
