From: ynorov@caviumnetworks.com (Yury Norov)
Date: Sat,  5 Aug 2017 17:40:22 +0300
Subject: [PATCH 2/2] arm64: cleanup {COMPAT_,}SET_PERSONALITY() macro
In-Reply-To: <20170805144022.17260-1-ynorov@caviumnetworks.com>
References: <20170805144022.17260-1-ynorov@caviumnetworks.com>
Message-ID: <20170805144022.17260-3-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Originally {COMPAT_,}SET_PERSONALITY() only sets the 32-bit flag in thread_info
structure. But there is some work that should be done after setting the personality.
Currently it's done in the macro, which is not the best idea.

In this patch new arch_setup_new_exec() routine is introduced, and all setup code
is moved there, as suggested by Catalin:
https://lkml.org/lkml/2017/8/4/494

Note: mm->context.flags doesn't require the atomic strong ordered acceess to the
field, so use __set_bit() there;

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
CC: Pratyush Anand <panand@redhat.com>
CC: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/elf.h         | 15 +++++++++------
 arch/arm64/include/asm/thread_info.h |  3 +++
 arch/arm64/kernel/process.c          | 17 +++++++++++++++++
 3 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index de11ed1484e3..615953243961 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -137,11 +137,14 @@ typedef struct user_fpsimd_state elf_fpregset_t;
  */
 #define ELF_PLAT_INIT(_r, load_addr)	(_r)->regs[0] = 0
 
+/*
+ * Don't modify this macro unless you add new personality.
+ * All personality-related setup should be done at proper place.
+ * If not sure, consider the arch_setup_new_exec() function.
+ */
 #define SET_PERSONALITY(ex)						\
 ({									\
-	clear_bit(MMCF_AARCH32, &current->mm->context.flags);		\
 	clear_thread_flag(TIF_32BIT);					\
-	current->personality &= ~READ_IMPLIES_EXEC;			\
 })
 
 /* update AT_VECTOR_SIZE_ARCH if the number of NEW_AUX_ENT entries changes */
@@ -188,14 +191,14 @@ typedef compat_elf_greg_t		compat_elf_gregset_t[COMPAT_ELF_NGREG];
 					 ((x)->e_flags & EF_ARM_EABI_MASK))
 
 #define compat_start_thread		compat_start_thread
+
 /*
- * Unlike the native SET_PERSONALITY macro, the compat version inherits
- * READ_IMPLIES_EXEC across a fork() since this is the behaviour on
- * arch/arm/.
+ * Don't modify this macro unless you add new personality.
+ * All personality-related setup should be done at proper place.
+ * If not sure, consider the arch_setup_new_exec() function.
  */
 #define COMPAT_SET_PERSONALITY(ex)					\
 ({									\
-	set_bit(MMCF_AARCH32, &current->mm->context.flags);		\
 	set_thread_flag(TIF_32BIT);					\
  })
 #define COMPAT_ARCH_DLINFO
diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index 46c3b93cf865..c823d2f12b4c 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -68,6 +68,9 @@ struct thread_info {
 #define thread_saved_fp(tsk)	\
 	((unsigned long)(tsk->thread.cpu_context.fp))
 
+void arch_setup_new_exec(void);
+#define arch_setup_new_exec     arch_setup_new_exec
+
 #endif
 
 /*
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 659ae8094ed5..ebca9e4f62c7 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -417,3 +417,20 @@ unsigned long arch_randomize_brk(struct mm_struct *mm)
 	else
 		return randomize_page(mm->brk, SZ_1G);
 }
+
+/*
+ * Called immediately after a successful exec.
+ */
+void arch_setup_new_exec(void)
+{
+	current->mm->context.flags = 0;
+
+	/*
+	 * Unlike the native one, the compat version of exec() inherits
+	 * READ_IMPLIES_EXEC since this is the behaviour on arch/arm/.
+	 */
+	if (is_compat_task())
+		__set_bit(MMCF_AARCH32, &current->mm->context.flags);
+	else
+		current->personality &= ~READ_IMPLIES_EXEC;
+}
-- 
2.11.0
