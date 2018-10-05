From: kristina.martsenko@arm.com (Kristina Martsenko)
Date: Fri,  5 Oct 2018 09:47:51 +0100
Subject: [RFC 14/17] arm64: unwind: strip PAC from kernel addresses
In-Reply-To: <20181005084754.20950-1-kristina.martsenko@arm.com>
References: <20181005084754.20950-1-kristina.martsenko@arm.com>
Message-ID: <20181005084754.20950-15-kristina.martsenko@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Rutland <mark.rutland@arm.com>

When we enable pointer authentication in the kernel, LR values saved to
the stack will have a PAC which we must strip in order to retrieve the
real return address.

Strip PACs when unwinding the stack in order to account for this.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
---
 arch/arm64/include/asm/pointer_auth.h | 10 +++++++---
 arch/arm64/kernel/ptrace.c            |  2 +-
 arch/arm64/kernel/stacktrace.c        |  3 +++
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/pointer_auth.h b/arch/arm64/include/asm/pointer_auth.h
index 5e40533f4ea2..e60f225d9fa2 100644
--- a/arch/arm64/include/asm/pointer_auth.h
+++ b/arch/arm64/include/asm/pointer_auth.h
@@ -55,12 +55,16 @@ static inline void ptrauth_keys_switch(struct ptrauth_keys *keys)
  * The EL0 pointer bits used by a pointer authentication code.
  * This is dependent on TBI0 being enabled, or bits 63:56 would also apply.
  */
-#define ptrauth_pac_mask() 	GENMASK(54, VA_BITS)
+#define ptrauth_pac_mask_ttbr0()	GENMASK(54, VA_BITS)
+
+#define ptrauth_pac_mask_ttbr1()	(GENMASK(63, 56) | GENMASK(54, VA_BITS))
 
-/* Only valid for EL0 TTBR0 instruction pointers */
 static inline unsigned long ptrauth_strip_insn_pac(unsigned long ptr)
 {
-	return ptr & ~ptrauth_pac_mask();
+	if (ptr & BIT_ULL(55))
+		return ptr | ptrauth_pac_mask_ttbr1();
+	else
+		return ptr & ~ptrauth_pac_mask_ttbr0();
 }
 
 #define ptrauth_task_init_user(tsk)	\
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index cb8246f8c603..bf4d6d384e4f 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -970,7 +970,7 @@ static int pac_mask_get(struct task_struct *target,
 	 * depending on TCR_EL1.TBID*, which we may make use of in future, so
 	 * we expose separate masks.
 	 */
-	unsigned long mask = ptrauth_pac_mask();
+	unsigned long mask = ptrauth_pac_mask_ttbr0();
 	struct user_pac_mask uregs = {
 		.data_mask = mask,
 		.insn_mask = mask,
diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index 4989f7ea1e59..44f6a64a8006 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -24,6 +24,7 @@
 #include <linux/stacktrace.h>
 
 #include <asm/irq.h>
+#include <asm/pointer_auth.h>
 #include <asm/stack_pointer.h>
 #include <asm/stacktrace.h>
 
@@ -56,6 +57,8 @@ int notrace unwind_frame(struct task_struct *tsk, struct stackframe *frame)
 	frame->fp = READ_ONCE_NOCHECK(*(unsigned long *)(fp));
 	frame->pc = READ_ONCE_NOCHECK(*(unsigned long *)(fp + 8));
 
+	frame->pc = ptrauth_strip_insn_pac(frame->pc);
+
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	if (tsk->ret_stack &&
 			(frame->pc == (unsigned long)return_to_handler)) {
-- 
2.11.0
