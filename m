From: kevin@bracey.fi (Kevin Bracey)
Date: Tue,  4 Feb 2014 22:19:06 +0200
Subject: [PATCH] ARM: enable IRQs in user undefined instruction vector
Message-ID: <1391545146-8320-1-git-send-email-kevin@bracey.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If an abort occurs while loading an instruction from user space in
__und_usr, the resulting do_page_fault() can output "sleeping function
called from invalid context" warnings, due to IRQs being disabled in
__und_usr, and hence in do_page_fault().

Avoid the problem by enabling IRQs in __und_usr before attempting to
load the instruction, and modify code and comments in the undefined
instruction handlers to note that IRQs are enabled on entry iff the
instruction was executed in user mode.

See http://comments.gmane.org/gmane.linux.ports.arm.omap/59256 for
an earlier report of the observed might_sleep() warning.

The proposed patch in that thread, which adds a "!irqs_disabled()" test
to do_page_fault(), has already been applied to Android, but that patch
causes an execution failure if another CPU ages the page between the
instruction execution and __und_usr; it prevents do_page_fault() from
attempting to handle the fault and __und_usr's fixup handler is called
instead, but the fixup handler just continues execution from the next
instruction, so the original instruction is silently skipped.

This patch modifies the fixup handler to attempt to re-execute the
original instruction, bringing it in line with the SWI fixup handler;
this also avoids the possibility of the instruction being skipped if
do_page_fault() doesn't handle a fault.

Signed-off-by: Kevin Bracey <kevin@bracey.fi>
---
 arch/arm/kernel/entry-armv.S       | 11 ++++++++---
 arch/arm/mach-ep93xx/crunch-bits.S |  7 ++++++-
 arch/arm/vfp/entry.S               |  2 +-
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index b3fb8c9..bed1567 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -399,6 +399,7 @@ ENDPROC(__irq_usr)
 	.align	5
 __und_usr:
 	usr_entry
+	enable_irq
 
 	mov	r2, r4
 	mov	r3, r5
@@ -478,11 +479,14 @@ __und_usr_thumb:
 ENDPROC(__und_usr)
 
 /*
- * The out of line fixup for the ldrt instructions above.
+ * The out of line fixup for the ldrt instructions above. Called when there
+ * was an unrecoverable fault accessing the instruction. Attempt to re-execute
+ * the instruction, which should trigger the user fault handling path.
  */
 	.pushsection .fixup, "ax"
 	.align	2
-4:	mov	pc, r9
+4:	str	r4, [sp, #S_PC]
+	mov	pc, r9
 	.popsection
 	.pushsection __ex_table,"a"
 	.long	1b, 4b
@@ -515,7 +519,8 @@ ENDPROC(__und_usr)
  *  r9  = normal "successful" return address
  *  r10 = this threads thread_info structure
  *  lr  = unrecognised instruction return address
- * IRQs disabled, FIQs enabled.
+ * IRQs enabled iff the instruction was executed in user mode.
+ * FIQs enabled.
  */
 	@
 	@ Fall-through from Thumb-2 __und_usr
diff --git a/arch/arm/mach-ep93xx/crunch-bits.S b/arch/arm/mach-ep93xx/crunch-bits.S
index 0ec9bb4..413d46c 100644
--- a/arch/arm/mach-ep93xx/crunch-bits.S
+++ b/arch/arm/mach-ep93xx/crunch-bits.S
@@ -62,9 +62,14 @@
  * r9  = ret_from_exception
  * lr  = undefined instr exit
  *
- * called from prefetch exception handler with interrupts disabled
+ * Called from undefined instruction handler.
+ * Interrupts enabled iff instruction executed in user mode.
  */
 ENTRY(crunch_task_enable)
+	mrs	r1, cpsr
+	orr	r2, r1, #PSR_I_BIT		@ disable interrupts
+	msr	cpsr_c, r2
+
 	ldr	r8, =(EP93XX_APB_VIRT_BASE + 0x00130000)	@ syscon addr
 
 	ldr	r1, [r8, #0x80]
diff --git a/arch/arm/vfp/entry.S b/arch/arm/vfp/entry.S
index 46e1749..e0e3a00 100644
--- a/arch/arm/vfp/entry.S
+++ b/arch/arm/vfp/entry.S
@@ -19,7 +19,7 @@
 @  r9  = normal "successful" return address
 @  r10 = this threads thread_info structure
 @  lr  = unrecognised instruction return address
-@  IRQs disabled.
+@  IRQs enabled iff the instruction was executed in user mode.
 @
 ENTRY(do_vfp)
 #ifdef CONFIG_PREEMPT_COUNT
-- 
1.8.4.dirty
