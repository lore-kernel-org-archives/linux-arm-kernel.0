From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 23 Sep 2015 15:24:09 +0100
Subject: [PATCH 3/4] arm: Reduce the number of #ifdef CONFIG_CPU_SW_DOMAIN_PAN
In-Reply-To: <1443018250-22893-1-git-send-email-catalin.marinas@arm.com>
References: <1443018250-22893-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1443018250-22893-4-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a clean-up patch aimed at reducing the number of checks on
CONFIG_CPU_SW_DOMAIN_PAN, together with some empty lines for better
clarity once the CONFIG_CPU_TTBR0_PAN is introduced.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/include/asm/assembler.h   | 26 ++++++++++++++++++--------
 arch/arm/include/asm/uaccess.h     | 27 +++++++++++++++++++++------
 arch/arm/lib/csumpartialcopyuser.S |  6 +++++-
 3 files changed, 44 insertions(+), 15 deletions(-)

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index b2bc8e11471d..26b4c697c857 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -449,8 +449,9 @@ THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
 #endif
 	.endm
 
+#if defined(CONFIG_CPU_SW_DOMAIN_PAN)
+
 	.macro	uaccess_disable, tmp, isb=1
-#ifdef CONFIG_CPU_SW_DOMAIN_PAN
 	/*
 	 * Whenever we re-enter userspace, the domains should always be
 	 * set appropriately.
@@ -460,11 +461,9 @@ THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
 	.if	\isb
 	instr_sync
 	.endif
-#endif
 	.endm
 
 	.macro	uaccess_enable, tmp, isb=1
-#ifdef CONFIG_CPU_SW_DOMAIN_PAN
 	/*
 	 * Whenever we re-enter userspace, the domains should always be
 	 * set appropriately.
@@ -474,23 +473,34 @@ THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
 	.if	\isb
 	instr_sync
 	.endif
-#endif
 	.endm
 
 	.macro	uaccess_save, tmp
-#ifdef CONFIG_CPU_SW_DOMAIN_PAN
 	mrc	p15, 0, \tmp, c3, c0, 0
 	str	\tmp, [sp, #S_FRAME_SIZE]
-#endif
 	.endm
 
 	.macro	uaccess_restore
-#ifdef CONFIG_CPU_SW_DOMAIN_PAN
 	ldr	r0, [sp, #S_FRAME_SIZE]
 	mcr	p15, 0, r0, c3, c0, 0
-#endif
 	.endm
 
+#else
+
+	.macro	uaccess_disable, tmp, isb=1
+	.endm
+
+	.macro	uaccess_enable, tmp, isb=1
+	.endm
+
+	.macro	uaccess_save, tmp
+	.endm
+
+	.macro	uaccess_restore
+	.endm
+
+#endif
+
 	.irp	c,,eq,ne,cs,cc,mi,pl,vs,vc,hi,ls,ge,lt,gt,le,hs,lo
 	.macro	ret\c, reg
 #if __LINUX_ARM_ARCH__ < 6
diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
index 8cc85a4ebec2..711c9877787b 100644
--- a/arch/arm/include/asm/uaccess.h
+++ b/arch/arm/include/asm/uaccess.h
@@ -55,9 +55,10 @@ extern int fixup_exception(struct pt_regs *regs);
  * perform such accesses (eg, via list poison values) which could then
  * be exploited for priviledge escalation.
  */
+#if defined(CONFIG_CPU_SW_DOMAIN_PAN)
+
 static inline unsigned int uaccess_save_and_enable(void)
 {
-#ifdef CONFIG_CPU_SW_DOMAIN_PAN
 	unsigned int old_domain = get_domain();
 
 	/* Set the current domain access to permit user accesses */
@@ -65,19 +66,33 @@ static inline unsigned int uaccess_save_and_enable(void)
 		   domain_val(DOMAIN_USER, DOMAIN_CLIENT));
 
 	return old_domain;
-#else
-	return 0;
-#endif
 }
 
 static inline void uaccess_restore(unsigned int flags)
 {
-#ifdef CONFIG_CPU_SW_DOMAIN_PAN
 	/* Restore the user access mask */
 	set_domain(flags);
-#endif
 }
 
+
+#else
+
+static inline unsigned int uaccess_save_and_enable(void)
+{
+	return 0;
+}
+
+static inline void uaccess_restore(unsigned int flags)
+{
+}
+
+static inline bool uaccess_disabled(struct pt_regs *regs)
+{
+	return false;
+}
+
+#endif
+
 /*
  * These two are intentionally not defined anywhere - if the kernel
  * code generates any references to them, that's a bug.
diff --git a/arch/arm/lib/csumpartialcopyuser.S b/arch/arm/lib/csumpartialcopyuser.S
index 1712f132b80d..d50fe3c07615 100644
--- a/arch/arm/lib/csumpartialcopyuser.S
+++ b/arch/arm/lib/csumpartialcopyuser.S
@@ -17,7 +17,8 @@
 
 		.text
 
-#ifdef CONFIG_CPU_SW_DOMAIN_PAN
+#if defined(CONFIG_CPU_SW_DOMAIN_PAN)
+
 		.macro	save_regs
 		mrc	p15, 0, ip, c3, c0, 0
 		stmfd	sp!, {r1, r2, r4 - r8, ip, lr}
@@ -29,7 +30,9 @@
 		mcr	p15, 0, ip, c3, c0, 0
 		ret	lr
 		.endm
+
 #else
+
 		.macro	save_regs
 		stmfd	sp!, {r1, r2, r4 - r8, lr}
 		.endm
@@ -37,6 +40,7 @@
 		.macro	load_regs
 		ldmfd	sp!, {r1, r2, r4 - r8, pc}
 		.endm
+
 #endif
 
 		.macro	load1b,	reg1
