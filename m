From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 28 Aug 2013 12:34:24 +0100
Subject: [PATCH 5/5] arm: Enable IRQs before attempting to read user space in
 __und_usr
In-Reply-To: <1377689664-27614-1-git-send-email-catalin.marinas@arm.com>
References: <1377689664-27614-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1377689664-27614-6-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Undef abort handler in the kernel reads the undefined instruction
from user space. If the page table was modified from another CPU, the
user access could fail and do_page_fault() will be executed with
interrupts disabled. This can potentially deadlock on ARM11MPCore or on
Cortex-A15 with erratum 798181 workaround enabled (both implying IPI for
TLB maintenance with page table lock held).

This patch enables the IRQs in __und_usr before attempting to read the
instruction from user space.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/kernel/entry-armv.S       | 11 +++++++----
 arch/arm/kernel/iwmmxt.S           |  2 +-
 arch/arm/mach-ep93xx/crunch-bits.S |  2 +-
 arch/arm/vfp/entry.S               |  3 +--
 4 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index d40d0ef..c82ca96 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -411,6 +411,11 @@ __und_usr:
 	@
 	adr	r9, BSYM(ret_from_exception)
 
+	@ IRQs must be enabled before attempting to read the instruction from
+	@ user space since that could cause a page/translation fault if the
+	@ page table was modified by another CPU.
+	enable_irq
+
 	tst	r3, #PSR_T_BIT			@ Thumb mode?
 	bne	__und_usr_thumb
 	sub	r4, r2, #4			@ ARM instr at LR - 4
@@ -514,7 +519,7 @@ ENDPROC(__und_usr)
  *  r9  = normal "successful" return address
  *  r10 = this threads thread_info structure
  *  lr  = unrecognised instruction return address
- * IRQs disabled, FIQs enabled.
+ * IRQs enabled, FIQs enabled.
  */
 	@
 	@ Fall-through from Thumb-2 __und_usr
@@ -621,7 +626,6 @@ call_fpe:
 #endif
 
 do_fpe:
-	enable_irq
 	ldr	r4, .LCfp
 	add	r10, r10, #TI_FPSTATE		@ r10 = workspace
 	ldr	pc, [r4]			@ Call FP module USR entry point
@@ -649,8 +653,7 @@ __und_usr_fault_32:
 	b	1f
 __und_usr_fault_16:
 	mov	r1, #2
-1:	enable_irq
-	mov	r0, sp
+1:	mov	r0, sp
 	adr	lr, BSYM(ret_from_exception)
 	b	__und_fault
 ENDPROC(__und_usr_fault_32)
diff --git a/arch/arm/kernel/iwmmxt.S b/arch/arm/kernel/iwmmxt.S
index c52f3e2..da31170 100644
--- a/arch/arm/kernel/iwmmxt.S
+++ b/arch/arm/kernel/iwmmxt.S
@@ -61,7 +61,7 @@
  * r9  = ret_from_exception
  * lr  = undefined instr exit
  *
- * called from prefetch exception handler with interrupts disabled
+ * called from prefetch exception handler with interrupts enabled
  */
 
 ENTRY(iwmmxt_task_enable)
diff --git a/arch/arm/mach-ep93xx/crunch-bits.S b/arch/arm/mach-ep93xx/crunch-bits.S
index 890c5df..85e7655 100644
--- a/arch/arm/mach-ep93xx/crunch-bits.S
+++ b/arch/arm/mach-ep93xx/crunch-bits.S
@@ -62,7 +62,7 @@
  * r9  = ret_from_exception
  * lr  = undefined instr exit
  *
- * called from prefetch exception handler with interrupts disabled
+ * called from prefetch exception handler with interrupts enabled
  */
 ENTRY(crunch_task_enable)
 	inc_preempt_count r10, r3
diff --git a/arch/arm/vfp/entry.S b/arch/arm/vfp/entry.S
index f0759e7..fe6ca57 100644
--- a/arch/arm/vfp/entry.S
+++ b/arch/arm/vfp/entry.S
@@ -22,11 +22,10 @@
 @  r9  = normal "successful" return address
 @  r10 = this threads thread_info structure
 @  lr  = unrecognised instruction return address
-@  IRQs disabled.
+@  IRQs enabled.
 @
 ENTRY(do_vfp)
 	inc_preempt_count r10, r4
-	enable_irq
  	ldr	r4, .LCvfp
 	ldr	r11, [r10, #TI_CPU]	@ CPU number
 	add	r10, r10, #TI_VFPSTATE	@ r10 = workspace
