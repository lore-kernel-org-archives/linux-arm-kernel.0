From: ezequiel@vanguardiasur.com.ar (Ezequiel Garcia)
Date: Fri, 30 Oct 2015 17:00:35 -0300
Subject: [PATCH v2] ARM: v7-M: Set an early stack for __v7m_setup
Message-ID: <1446235235-18179-1-git-send-email-ezequiel@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ARM v7-M, when PROCINFO_INITFUNC (__v7m_setup) is called,
a stack is needed before calling the supervisor call (SVC),
which is used by the supervisor call to save the context.

Currently, __v7m_setup() prepares a temporary stack in the .text.init
section, which is is broken if the kernel is executing directly from
read-only memory.

In particular, this is the case for LPC43xx, which allows
to execute the kernel in-place from a serial flash through its SPIFI
controller.

This commit fixes the issue by seting an early stack to its usual location.

Also, __v7m_setup() is currently saving and restoring the previous
stack. That was bogus, because there's no stack previously set,
so this commit removes it.

Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Unless there are any further comments, I'll be pushing this
into Russell's tracker.

 arch/arm/mm/proc-v7m.S | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mm/proc-v7m.S b/arch/arm/mm/proc-v7m.S
index 67d9209077c6..7229d8d0be1a 100644
--- a/arch/arm/mm/proc-v7m.S
+++ b/arch/arm/mm/proc-v7m.S
@@ -12,6 +12,7 @@
  */
 #include <linux/linkage.h>
 #include <asm/assembler.h>
+#include <asm/memory.h>
 #include <asm/v7m.h>
 #include "proc-macros.S"
 
@@ -97,19 +98,19 @@ __v7m_setup:
 	mov	r5, #0x00800000
 	str	r5, [r0, V7M_SCB_SHPR3]	@ set PendSV priority
 
-	@ SVC to run the kernel in this mode
+	@ SVC to switch to handler mode. Notice that this requires sp to
+	@ point to writeable memory because the processor saves
+	@ some registers to the stack.
 	badr	r1, 1f
 	ldr	r5, [r12, #11 * 4]	@ read the SVC vector entry
 	str	r1, [r12, #11 * 4]	@ write the temporary SVC vector entry
 	mov	r6, lr			@ save LR
-	mov	r7, sp			@ save SP
-	ldr	sp, =__v7m_setup_stack_top
+	ldr	sp, =init_thread_union + THREAD_START_SP
 	cpsie	i
 	svc	#0
 1:	cpsid	i
 	str	r5, [r12, #11 * 4]	@ restore the original SVC vector entry
 	mov	lr, r6			@ restore LR
-	mov	sp, r7			@ restore SP
 
 	@ Special-purpose control register
 	mov	r1, #1
@@ -123,11 +124,6 @@ __v7m_setup:
 	ret	lr
 ENDPROC(__v7m_setup)
 
-	.align 2
-__v7m_setup_stack:
-	.space	4 * 8				@ 8 registers
-__v7m_setup_stack_top:
-
 	define_processor_functions v7m, dabort=nommu_early_abort, pabort=legacy_pabort, nommu=1
 
 	.section ".rodata"
-- 
2.5.2
