From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon,  4 Mar 2013 14:43:02 -0800
Subject: [PATCH 1/2] ARM: Consolidate preempt enable/disable assembly into
 macros
In-Reply-To: <1362436983-28988-1-git-send-email-sboyd@codeaurora.org>
References: <1362436983-28988-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1362436983-28988-2-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We duplicate the same few preempt enable and disable assembly
instructions in multiple places in the vfp code. Move the code to
a macro in entry-header.S so that we can modify the preempt
enable/disable assembly in one place in the future.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/kernel/entry-header.S | 17 +++++++++++++++++
 arch/arm/vfp/entry.S           | 20 +++-----------------
 arch/arm/vfp/vfphw.S           | 14 ++------------
 3 files changed, 22 insertions(+), 29 deletions(-)

diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
index 9a8531e..130e6a6 100644
--- a/arch/arm/kernel/entry-header.S
+++ b/arch/arm/kernel/entry-header.S
@@ -163,6 +163,23 @@
 	.endm
 #endif	/* !CONFIG_THUMB2_KERNEL */
 
+	.macro preempt_enable_no_resched, tsk, cnt
+#ifdef CONFIG_PREEMPT_COUNT
+	get_thread_info	\tsk
+	ldr	\cnt, [\tsk, #TI_PREEMPT]	@ get preempt count
+	sub	\cnt, \cnt, #1			@ decrement it
+	str	\cnt, [\tsk, #TI_PREEMPT]
+#endif
+	.endm
+
+	.macro preempt_disable, tsk, cnt
+#ifdef CONFIG_PREEMPT_COUNT
+	ldr	\cnt, [\tsk, #TI_PREEMPT]	@ get preempt count
+	add	\cnt, \cnt, #1			@ increment it
+	str	\cnt, [\tsk, #TI_PREEMPT]
+#endif
+	.endm
+
 /*
  * These are the registers used in the syscall handler, and allow us to
  * have in theory up to 7 arguments to a function - r0 to r6.
diff --git a/arch/arm/vfp/entry.S b/arch/arm/vfp/entry.S
index 323ce1a..e528709 100644
--- a/arch/arm/vfp/entry.S
+++ b/arch/arm/vfp/entry.S
@@ -22,11 +22,7 @@
 @  IRQs disabled.
 @
 ENTRY(do_vfp)
-#ifdef CONFIG_PREEMPT_COUNT
-	ldr	r4, [r10, #TI_PREEMPT]	@ get preempt count
-	add	r11, r4, #1		@ increment it
-	str	r11, [r10, #TI_PREEMPT]
-#endif
+	preempt_disable r10, r4
 	enable_irq
  	ldr	r4, .LCvfp
 	ldr	r11, [r10, #TI_CPU]	@ CPU number
@@ -35,12 +31,7 @@ ENTRY(do_vfp)
 ENDPROC(do_vfp)
 
 ENTRY(vfp_null_entry)
-#ifdef CONFIG_PREEMPT_COUNT
-	get_thread_info	r10
-	ldr	r4, [r10, #TI_PREEMPT]	@ get preempt count
-	sub	r11, r4, #1		@ decrement it
-	str	r11, [r10, #TI_PREEMPT]
-#endif
+	preempt_enable_no_resched r10, r4
 	mov	pc, lr
 ENDPROC(vfp_null_entry)
 
@@ -53,12 +44,7 @@ ENDPROC(vfp_null_entry)
 
 	__INIT
 ENTRY(vfp_testing_entry)
-#ifdef CONFIG_PREEMPT_COUNT
-	get_thread_info	r10
-	ldr	r4, [r10, #TI_PREEMPT]	@ get preempt count
-	sub	r11, r4, #1		@ decrement it
-	str	r11, [r10, #TI_PREEMPT]
-#endif
+	preempt_enable_no_resched r10, r4
 	ldr	r0, VFP_arch_address
 	str	r5, [r0]		@ known non-zero value
 	mov	pc, r9			@ we have handled the fault
diff --git a/arch/arm/vfp/vfphw.S b/arch/arm/vfp/vfphw.S
index dd5e56f..8bae250 100644
--- a/arch/arm/vfp/vfphw.S
+++ b/arch/arm/vfp/vfphw.S
@@ -168,12 +168,7 @@ vfp_hw_state_valid:
 					@ else it's one 32-bit instruction, so
 					@ always subtract 4 from the following
 					@ instruction address.
-#ifdef CONFIG_PREEMPT_COUNT
-	get_thread_info	r10
-	ldr	r4, [r10, #TI_PREEMPT]	@ get preempt count
-	sub	r11, r4, #1		@ decrement it
-	str	r11, [r10, #TI_PREEMPT]
-#endif
+	preempt_enable_no_resched r10, r4
 	mov	pc, r9			@ we think we have handled things
 
 
@@ -192,12 +187,7 @@ look_for_VFP_exceptions:
 	@ not recognised by VFP
 
 	DBGSTR	"not VFP"
-#ifdef CONFIG_PREEMPT_COUNT
-	get_thread_info	r10
-	ldr	r4, [r10, #TI_PREEMPT]	@ get preempt count
-	sub	r11, r4, #1		@ decrement it
-	str	r11, [r10, #TI_PREEMPT]
-#endif
+	preempt_enable_no_resched r10, r4
 	mov	pc, lr
 
 process_exception:
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
