From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 16 Oct 2012 17:46:40 +0100
Subject: [PATCH 4/4] arm64: No need to set the x0-x2 registers in
 start_thread()
In-Reply-To: <1350406000-30882-1-git-send-email-catalin.marinas@arm.com>
References: <1350406000-30882-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1350406000-30882-5-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For historical reasons, ARM used to set r0-r2 in start_thread() to the
first values on the user stack when starting a new user application. The
same logic has been inherited in AArch64. The x0 register is overridden
by the sys_execve() return value so it's always zero on success. The x1
and x2 registers are ignored by AArch64 and EABI AArch32 applications,
so we can safely remove the register setting for both native and compat
user space.

This also fixes a potential fault with the kernel accessing user space
stack directly.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Reported-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/arm64/include/asm/processor.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 39a208a..5d81004 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -92,30 +92,20 @@ static inline void start_thread_common(struct pt_regs *regs, unsigned long pc)
 static inline void start_thread(struct pt_regs *regs, unsigned long pc,
 				unsigned long sp)
 {
-	unsigned long *stack = (unsigned long *)sp;
-
 	start_thread_common(regs, pc);
 	regs->pstate = PSR_MODE_EL0t;
 	regs->sp = sp;
-	regs->regs[2] = stack[2];	/* x2 (envp) */
-	regs->regs[1] = stack[1];	/* x1 (argv) */
-	regs->regs[0] = stack[0];	/* x0 (argc) */
 }
 
 #ifdef CONFIG_COMPAT
 static inline void compat_start_thread(struct pt_regs *regs, unsigned long pc,
 				       unsigned long sp)
 {
-	unsigned int *stack = (unsigned int *)sp;
-
 	start_thread_common(regs, pc);
 	regs->pstate = COMPAT_PSR_MODE_USR;
 	if (pc & 1)
 		regs->pstate |= COMPAT_PSR_T_BIT;
 	regs->compat_sp = sp;
-	regs->regs[2] = stack[2];	/* x2 (envp) */
-	regs->regs[1] = stack[1];	/* x1 (argv) */
-	regs->regs[0] = stack[0];	/* x0 (argc) */
 }
 #endif
 
