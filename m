From: will.deacon@arm.com (Will Deacon)
Date: Thu, 23 Jul 2015 14:07:52 +0100
Subject: [PATCH v4] arm64: kernel: Add support for Privileged Access Never
In-Reply-To: <1437588354-31278-1-git-send-email-james.morse@arm.com>
References: <20150722170140.GR6650@arm.com>
 <1437588354-31278-1-git-send-email-james.morse@arm.com>
Message-ID: <20150723130752.GC445@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

First off, thanks for rebasing this patch.

On Wed, Jul 22, 2015 at 07:05:54PM +0100, James Morse wrote:
> 'Privileged Access Never' is a new arm8.1 feature which prevents
> privileged code from accessing any virtual address where read or write
> access is also permitted at EL0.
> 
> This patch enables the PAN feature on all CPUs, and modifies {get,put}_user
> helpers temporarily to permit access.
> 
> This will catch kernel bugs where user memory is accessed directly.
> 'Unprivileged loads and stores' using ldtrb et al are unaffected by PAN.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
> This version is rebased against the arm64 'devel' branch, somewhere
> after Suzuki's "arm64: Generalise msr_s/mrs_s operations" patch.

Now, having spoken with Catalin, we reckon that it's probably best to
bite the bullet and add the enable parameter to the conditional alternative
asm macros anyway; it's still fairly early days for 4.3 so we've got time
to get this right.

In that light, I've got the following diff against this patch (see below)
and then another patch on top of that adding the extra parameters.

Could you take a look please? Sorry for messing you about.

Will

--->8

diff --git a/arch/arm64/lib/clear_user.S b/arch/arm64/lib/clear_user.S
index 96ed5cfecb7f..a9723c71c52b 100644
--- a/arch/arm64/lib/clear_user.S
+++ b/arch/arm64/lib/clear_user.S
@@ -33,7 +33,8 @@
  * Alignment fixed up by hardware.
  */
 ENTRY(__clear_user)
-alternative_insn "nop", __stringify(SET_PSTATE_PAN(0)), ARM64_HAS_PAN
+ALTERNATIVE("nop", __stringify(SET_PSTATE_PAN(0)), ARM64_HAS_PAN, \
+	    CONFIG_ARM64_PAN)
 	mov	x2, x1			// save the size for fixup return
 	subs	x1, x1, #8
 	b.mi	2f
@@ -53,7 +54,8 @@ USER(9f, strh	wzr, [x0], #2	)
 	b.mi	5f
 USER(9f, strb	wzr, [x0]	)
 5:	mov	x0, #0
-alternative_insn "nop", __stringify(SET_PSTATE_PAN(1)), ARM64_HAS_PAN
+ALTERNATIVE("nop", __stringify(SET_PSTATE_PAN(1)), ARM64_HAS_PAN, \
+	    CONFIG_ARM64_PAN)
 	ret
 ENDPROC(__clear_user)
 
diff --git a/arch/arm64/lib/copy_from_user.S b/arch/arm64/lib/copy_from_user.S
index e73819dd47d2..1be9ef27be97 100644
--- a/arch/arm64/lib/copy_from_user.S
+++ b/arch/arm64/lib/copy_from_user.S
@@ -32,7 +32,8 @@
  *	x0 - bytes not copied
  */
 ENTRY(__copy_from_user)
-alternative_insn "nop", __stringify(SET_PSTATE_PAN(0)), ARM64_HAS_PAN
+ALTERNATIVE("nop", __stringify(SET_PSTATE_PAN(0)), ARM64_HAS_PAN, \
+	    CONFIG_ARM64_PAN)
 	add	x5, x1, x2			// upper user buffer boundary
 	subs	x2, x2, #16
 	b.mi	1f
@@ -61,7 +62,8 @@ USER(9f, ldrh	w3, [x1], #2	)
 USER(9f, ldrb	w3, [x1]	)
 	strb	w3, [x0]
 5:	mov	x0, #0
-alternative_insn "nop", __stringify(SET_PSTATE_PAN(1)), ARM64_HAS_PAN
+ALTERNATIVE("nop", __stringify(SET_PSTATE_PAN(1)), ARM64_HAS_PAN, \
+	    CONFIG_ARM64_PAN)
 	ret
 ENDPROC(__copy_from_user)
 
diff --git a/arch/arm64/lib/copy_in_user.S b/arch/arm64/lib/copy_in_user.S
index 9e6376a3e247..1b94661e22b3 100644
--- a/arch/arm64/lib/copy_in_user.S
+++ b/arch/arm64/lib/copy_in_user.S
@@ -34,7 +34,8 @@
  *	x0 - bytes not copied
  */
 ENTRY(__copy_in_user)
-alternative_insn "nop", __stringify(SET_PSTATE_PAN(0)), ARM64_HAS_PAN
+ALTERNATIVE("nop", __stringify(SET_PSTATE_PAN(0)), ARM64_HAS_PAN, \
+	    CONFIG_ARM64_PAN)
 	add	x5, x0, x2			// upper user buffer boundary
 	subs	x2, x2, #16
 	b.mi	1f
@@ -63,7 +64,8 @@ USER(9f, strh	w3, [x0], #2	)
 USER(9f, ldrb	w3, [x1]	)
 USER(9f, strb	w3, [x0]	)
 5:	mov	x0, #0
-alternative_insn "nop", __stringify(SET_PSTATE_PAN(1)), ARM64_HAS_PAN
+ALTERNATIVE("nop", __stringify(SET_PSTATE_PAN(1)), ARM64_HAS_PAN, \
+	    CONFIG_ARM64_PAN)
 	ret
 ENDPROC(__copy_in_user)
 
diff --git a/arch/arm64/lib/copy_to_user.S b/arch/arm64/lib/copy_to_user.S
index 936199faba3f..a257b47e2dc4 100644
--- a/arch/arm64/lib/copy_to_user.S
+++ b/arch/arm64/lib/copy_to_user.S
@@ -32,7 +32,8 @@
  *	x0 - bytes not copied
  */
 ENTRY(__copy_to_user)
-alternative_insn "nop", __stringify(SET_PSTATE_PAN(0)), ARM64_HAS_PAN
+ALTERNATIVE("nop", __stringify(SET_PSTATE_PAN(0)), ARM64_HAS_PAN, \
+	    CONFIG_ARM64_PAN)
 	add	x5, x0, x2			// upper user buffer boundary
 	subs	x2, x2, #16
 	b.mi	1f
@@ -61,7 +62,8 @@ USER(9f, strh	w3, [x0], #2	)
 	ldrb	w3, [x1]
 USER(9f, strb	w3, [x0]	)
 5:	mov	x0, #0
-alternative_insn "nop", __stringify(SET_PSTATE_PAN(1)), ARM64_HAS_PAN
+ALTERNATIVE("nop", __stringify(SET_PSTATE_PAN(1)), ARM64_HAS_PAN, \
+	    CONFIG_ARM64_PAN)
 	ret
 ENDPROC(__copy_to_user)
 
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 5fe96ef31e0e..ce591211434e 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -149,13 +149,6 @@ static void do_bad_area(unsigned long addr, unsigned int esr, struct pt_regs *re
 		__do_kernel_fault(mm, addr, esr, regs);
 }
 
-static bool pan_enabled(struct pt_regs *regs)
-{
-	if (IS_ENABLED(CONFIG_ARM64_PAN))
-		return (regs->pstate & PSR_PAN_BIT) != 0;
-	return false;
-}
-
 #define VM_FAULT_BADMAP		0x010000
 #define VM_FAULT_BADACCESS	0x020000
 
@@ -236,7 +229,7 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 	 * PAN bit set implies the fault happened in kernel space, but not
 	 * in the arch's user access functions.
 	 */
-	if (pan_enabled(regs))
+	if (IS_ENABLED(CONFIG_ARM64_PAN) && (regs->pstate & PSR_PAN_BIT))
 		goto no_context;
 
 	/*
