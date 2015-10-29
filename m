From: ezequiel@vanguardiasur.com.ar (Ezequiel Garcia)
Date: Thu, 29 Oct 2015 14:31:20 -0300
Subject: [PATCH] ARM: v7-M: Fix the stack set by __v7m_setup
Message-ID: <1446139880-17311-1-git-send-email-ezequiel@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ARM v7-M, when PROCINFO_INITFUNC (__v7m_setup) is called,
a stack is needed before calling the supervisor call (SVC),
which is used by the supervisor call to save the context.

Currently, __v7m_setup() prepares a temporary stack in the .text.init
section, which is is broken if the kernel is executing directly from
read-only memory.

This commit fixes this by seting an early stack to its usual location.

Also, __v7m_setup() is currently saving and restoring the previous
stack. That was bogus, because there's no stack previously set,
so this commit removes it.

Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
---
As suggested by Uwe, this commit tries to set a proper stack
before calling the SVC in __v7m_setup.

Instead of putting that in a .data section, I'm just using
the usual stack location.

The stack will be reset to the same place in __mmap_switched.
This means the stack is set twice in the v7-M case, but
for simplicity I figure we can just leave this that way.

 arch/arm/mm/proc-v7m.S | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mm/proc-v7m.S b/arch/arm/mm/proc-v7m.S
index 67d9209077c6..f42d4e2774c7 100644
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
+	@ SVC to run the kernel in this mode,
+	@ notice that we need to set a stack for SVC to save
+	@ the context.
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
