From: behanw@converseincode.com (behanw at converseincode.com)
Date: Fri,  6 Sep 2013 17:42:41 -0400
Subject: [PATCH] arm: LLVMLinux: Calculate pt_regs address from fp
In-Reply-To: <1378503762-7236-1-git-send-email-behanw@converseincode.com>
References: <1378503762-7236-1-git-send-email-behanw@converseincode.com>
Message-ID: <1378503762-7236-2-git-send-email-behanw@converseincode.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Behan Webster <behanw@converseincode.com>

Use the frame pointer to calculate the end of the stack for current_pt_regs()
The existing code uses the stack pointer to do this calculation.
Using the frame pointer yeilds the same value in a more portable way.
This change supports being able to compile the kernel with gcc and clang.

Signed-off-by: Mark Charlebois <charlebm@gmail.com>
Signed-off-by: Behan Webster <behanw@converseincode.com>
Reviewed-by: Jan-Simon M?ller <dl9pf@gmx.de>
---
 arch/arm/include/asm/ptrace.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/ptrace.h b/arch/arm/include/asm/ptrace.h
index 04c99f3..8aec2db 100644
--- a/arch/arm/include/asm/ptrace.h
+++ b/arch/arm/include/asm/ptrace.h
@@ -138,9 +138,9 @@ static inline unsigned long user_stack_pointer(struct pt_regs *regs)
 	return regs->ARM_sp;
 }
 
-#define current_pt_regs(void) ({				\
-	register unsigned long sp asm ("sp");			\
-	(struct pt_regs *)((sp | (THREAD_SIZE - 1)) - 7) - 1;	\
+#define current_pt_regs(void) ({					\
+	(struct pt_regs *)(((unsigned long)(__builtin_frame_address(0))	\
+		| (THREAD_SIZE - 1)) - 7) - 1;				\
 })
 
 #endif /* __ASSEMBLY__ */
-- 
1.8.1.2
