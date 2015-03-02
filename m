From: wangnan0@huawei.com (Wang Nan)
Date: Mon, 2 Mar 2015 22:24:40 +0800
Subject: [RFC PATCH v4 02/34] x86,
 traps: separate set_intr_gate() and cleanup early_trap_init().
In-Reply-To: <1425306312-3437-1-git-send-email-wangnan0@huawei.com>
References: <1425306312-3437-1-git-send-email-wangnan0@huawei.com>
Message-ID: <1425306312-3437-3-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As early_trap_init() doesn't use IST, replace set_intr_gate_ist() and
set_system_intr_gate_ist() with their standard counterparts.

set_intr_gate() requires a trace_debug symbol which we don't have and
won't use. This patch seprates set_intr_gate() into 2 parts, and uses
base version in early_trap_init().

Signed-off-by: Wang Nan <wangnan0@huawei.com>
---
 arch/x86/include/asm/desc.h |  7 ++++++-
 arch/x86/kernel/traps.c     | 20 ++++++++++++--------
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/desc.h b/arch/x86/include/asm/desc.h
index a94b82e..a0bf89f 100644
--- a/arch/x86/include/asm/desc.h
+++ b/arch/x86/include/asm/desc.h
@@ -376,11 +376,16 @@ static inline void _set_gate(int gate, unsigned type, void *addr,
  * Pentium F0 0F bugfix can have resulted in the mapped
  * IDT being write-protected.
  */
-#define set_intr_gate(n, addr)						\
+#define set_intr_gate_notrace(n, addr)					\
 	do {								\
 		BUG_ON((unsigned)n > 0xFF);				\
 		_set_gate(n, GATE_INTERRUPT, (void *)addr, 0, 0,	\
 			  __KERNEL_CS);					\
+	} while (0)
+
+#define set_intr_gate(n, addr)						\
+	do {								\
+		set_intr_gate_notrace(n, addr);				\
 		_trace_set_gate(n, GATE_INTERRUPT, (void *)trace_##addr,\
 				0, 0, __KERNEL_CS);			\
 	} while (0)
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 4281988..9965bd1 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -926,16 +926,20 @@ dotraplinkage void do_iret_error(struct pt_regs *regs, long error_code)
 void __init early_trap_init(void)
 {
 	/*
-	 * Don't set ist to DEBUG_STACK as it doesn't work until TSS is
-	 * ready in cpu_init() <-- trap_init(). Before trap_init(), CPU
-	 * runs at ring 0 so it is impossible to hit an invalid stack.
-	 * Using the original stack works well enough at this early
-	 * stage. DEBUG_STACK will be equipped after cpu_init() in
+	 * Don't use IST to set DEBUG_STACK as it doesn't work until TSS
+	 * is ready in cpu_init() <-- trap_init(). Before trap_init(),
+	 * CPU runs at ring 0 so it is impossible to hit an invalid
+	 * stack.  Using the original stack works well enough@this
+	 * early stage. DEBUG_STACK will be equipped after cpu_init() in
 	 * trap_init().
+	 *
+	 * We don't need to set trace_idt_table like set_intr_gate(),
+	 * since we don't have trace_debug and it will be reset to
+	 * 'debug' in trap_init() by set_intr_gate_ist().
 	 */
-	set_intr_gate_ist(X86_TRAP_DB, &debug, 0);
+	set_intr_gate_notrace(X86_TRAP_DB, debug);
 	/* int3 can be called from all */
-	set_system_intr_gate_ist(X86_TRAP_BP, &int3, 0);
+	set_system_intr_gate(X86_TRAP_BP, &int3);
 #ifdef CONFIG_X86_32
 	set_intr_gate(X86_TRAP_PF, page_fault);
 #endif
@@ -1015,7 +1019,7 @@ void __init trap_init(void)
 
 	/*
 	 * X86_TRAP_DB and X86_TRAP_BP have been set
-	 * in early_trap_init(). However, DEBUG_STACK works only after
+	 * in early_trap_init(). However, ITS works only after
 	 * cpu_init() loads TSS. See comments in early_trap_init().
 	 */
 	set_intr_gate_ist(X86_TRAP_DB, &debug, DEBUG_STACK);
-- 
1.8.4
