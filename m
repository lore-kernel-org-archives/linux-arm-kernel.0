From: behanw@converseincode.com (behanw at converseincode.com)
Date: Tue,  8 Jul 2014 13:16:12 -0700
Subject: [PATCH 2/6] arm: LLVMLinux: Use current_stack_pointer to calculate
 pt_regs address
In-Reply-To: <1404850576-2006-1-git-send-email-behanw@converseincode.com>
References: <1404850576-2006-1-git-send-email-behanw@converseincode.com>
Message-ID: <1404850576-2006-3-git-send-email-behanw@converseincode.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Behan Webster <behanw@converseincode.com>

Use the global current_stack_pointer to calculate the end of the stack for
current_pt_regs()

Signed-off-by: Behan Webster <behanw@converseincode.com>
Signed-off-by: Mark Charlebois <charlebm@gmail.com>
Reviewed-by: Jan-Simon M??ller <dl9pf@gmx.de>
---
 arch/arm/include/asm/ptrace.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/ptrace.h b/arch/arm/include/asm/ptrace.h
index c877654..45bc592 100644
--- a/arch/arm/include/asm/ptrace.h
+++ b/arch/arm/include/asm/ptrace.h
@@ -148,9 +148,8 @@ static inline unsigned long user_stack_pointer(struct pt_regs *regs)
 	return regs->ARM_sp;
 }
 
-#define current_pt_regs(void) ({				\
-	register unsigned long sp asm ("sp");			\
-	(struct pt_regs *)((sp | (THREAD_SIZE - 1)) - 7) - 1;	\
+#define current_pt_regs(void) ({					\
+	(struct pt_regs *)((current_stack_pointer | (THREAD_SIZE - 1)) - 7) - 1; \
 })
 
 #endif /* __ASSEMBLY__ */
-- 
1.9.1
