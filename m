From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 28 Jul 2017 23:51:48 -0400
Subject: [PATCH 2/4] ARM: start_thread(): don't clear all regs with !MMU
In-Reply-To: <20170729035150.5214-1-nicolas.pitre@linaro.org>
References: <20170729035150.5214-1-nicolas.pitre@linaro.org>
Message-ID: <20170729035150.5214-3-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The elf_fdpic binary format driver has to initialize extra registers
other than the stack and program counter as required by the
corresponding ABI. So let's avoid clearing all registers in the !MMU
case. Only lr is still cleared in case some user space bug would
attempt a direct return which could turn out to be very confusing
indeed. There is no actual security argument with !MMU anyway so
potential leaks across executables here are irrelevant.

While at it let's get rid of start_thread_nommu().

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/include/asm/processor.h | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/arm/include/asm/processor.h b/arch/arm/include/asm/processor.h
index c3d5fc124a..527d44c8d2 100644
--- a/arch/arm/include/asm/processor.h
+++ b/arch/arm/include/asm/processor.h
@@ -47,15 +47,17 @@ struct thread_struct {
 
 #define INIT_THREAD  {	}
 
-#ifdef CONFIG_MMU
-#define nommu_start_thread(regs) do { } while (0)
-#else
-#define nommu_start_thread(regs) regs->ARM_r10 = current->mm->start_data
-#endif
-
 #define start_thread(regs,pc,sp)					\
 ({									\
-	memset(regs->uregs, 0, sizeof(regs->uregs));			\
+	if (!IS_ENABLED(CONFIG_MMU)) {					\
+		/*							\
+		 * Don't clear all regs as some binfmts have		\
+		 * initialized some of them already.			\
+		 */							\
+		regs->ARM_r10 = current->mm->start_data;		\
+		regs->ARM_lr = 0;					\
+	} else								\
+		memset(regs->uregs, 0, sizeof(regs->uregs));		\
 	if (current->personality & ADDR_LIMIT_32BIT)			\
 		regs->ARM_cpsr = USR_MODE;				\
 	else								\
@@ -65,7 +67,6 @@ struct thread_struct {
 	regs->ARM_cpsr |= PSR_ENDSTATE;					\
 	regs->ARM_pc = pc & ~1;		/* pc */			\
 	regs->ARM_sp = sp;		/* sp */			\
-	nommu_start_thread(regs);					\
 })
 
 /* Forward declaration, a strange C thing */
-- 
2.9.4
