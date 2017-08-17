From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 17 Aug 2017 03:23:42 -0400
Subject: [PATCH v2 3/8] ARM: start_thread(): don't always clear all regs
In-Reply-To: <20170817072347.19990-1-nicolas.pitre@linaro.org>
References: <20170817072347.19990-1-nicolas.pitre@linaro.org>
Message-ID: <20170817072347.19990-4-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The elf_fdpic binary format driver has to initialize extra registers
beside the stack and program counter as required by the corresponding
ABI. So reinstate them after the regs structure has been cleared.

While at it let's get rid of start_thread_nommu().

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/include/asm/processor.h | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/arm/include/asm/processor.h b/arch/arm/include/asm/processor.h
index c3d5fc124a..338cbe0a18 100644
--- a/arch/arm/include/asm/processor.h
+++ b/arch/arm/include/asm/processor.h
@@ -47,15 +47,24 @@ struct thread_struct {
 
 #define INIT_THREAD  {	}
 
-#ifdef CONFIG_MMU
-#define nommu_start_thread(regs) do { } while (0)
-#else
-#define nommu_start_thread(regs) regs->ARM_r10 = current->mm->start_data
-#endif
-
 #define start_thread(regs,pc,sp)					\
 ({									\
+	unsigned long r7, r8, r9;					\
+									\
+	if (IS_ENABLED(CONFIG_BINFMT_ELF_FDPIC)) {			\
+		r7 = regs->ARM_r7;					\
+		r8 = regs->ARM_r8;					\
+		r9 = regs->ARM_r9;					\
+	}								\
 	memset(regs->uregs, 0, sizeof(regs->uregs));			\
+	if (IS_ENABLED(CONFIG_BINFMT_ELF_FDPIC) &&			\
+	    current->personality & FDPIC_FUNCPTRS) {			\
+		regs->ARM_r7 = r7;					\
+		regs->ARM_r8 = r8;					\
+		regs->ARM_r9 = r9;					\
+		regs->ARM_r10 = current->mm->start_data;		\
+	} else if (!IS_ENABLED(CONFIG_MMU))				\
+		regs->ARM_r10 = current->mm->start_data;		\
 	if (current->personality & ADDR_LIMIT_32BIT)			\
 		regs->ARM_cpsr = USR_MODE;				\
 	else								\
@@ -65,7 +74,6 @@ struct thread_struct {
 	regs->ARM_cpsr |= PSR_ENDSTATE;					\
 	regs->ARM_pc = pc & ~1;		/* pc */			\
 	regs->ARM_sp = sp;		/* sp */			\
-	nommu_start_thread(regs);					\
 })
 
 /* Forward declaration, a strange C thing */
-- 
2.9.5
