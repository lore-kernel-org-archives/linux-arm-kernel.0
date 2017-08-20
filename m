From: ynorov@caviumnetworks.com (Yury Norov)
Date: Sun, 20 Aug 2017 13:20:48 +0300
Subject: [PATCH 2/2] arm64: cleanup {COMPAT_,}SET_PERSONALITY() macro
In-Reply-To: <20170820102048.7537-1-ynorov@caviumnetworks.com>
References: <20170820102048.7537-1-ynorov@caviumnetworks.com>
Message-ID: <20170820102048.7537-3-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is some work that should be done after setting the personality.
Currently it's done in the macro, which is not the best idea.

In this patch new arch_setup_new_exec() routine is introduced, and all
setup code is moved there, as suggested by Catalin:
https://lkml.org/lkml/2017/8/4/494

v2:
 - don't move clearing READ_IMPLIES_EXEC flag from SET_PERSONALITY()

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
CC: Pratyush Anand <panand@redhat.com>
CC: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/elf.h         | 7 +++++--
 arch/arm64/include/asm/thread_info.h | 3 +++
 arch/arm64/kernel/process.c          | 8 ++++++++
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index 517b9ff0456c..9c4434b8a9a8 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -137,9 +137,13 @@ typedef struct user_fpsimd_state elf_fpregset_t;
  */
 #define ELF_PLAT_INIT(_r, load_addr)	(_r)->regs[0] = 0
 
+/*
+ * Don't modify this macro unless you add new personality.
+ * All personality-related setup should be done at proper place.
+ * If not sure, consider the arch_setup_new_exec() function.
+ */
 #define SET_PERSONALITY(ex)						\
 ({									\
-	current->mm->context.flags = 0;					\
 	clear_thread_flag(TIF_32BIT);					\
 	current->personality &= ~READ_IMPLIES_EXEC;			\
 })
@@ -195,7 +199,6 @@ typedef compat_elf_greg_t		compat_elf_gregset_t[COMPAT_ELF_NGREG];
  */
 #define COMPAT_SET_PERSONALITY(ex)					\
 ({									\
-	current->mm->context.flags = MMCF_AARCH32;			\
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
index 659ae8094ed5..e99012c4803a 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -417,3 +417,11 @@ unsigned long arch_randomize_brk(struct mm_struct *mm)
 	else
 		return randomize_page(mm->brk, SZ_1G);
 }
+
+/*
+ * Called immediately after a successful exec.
+ */
+void arch_setup_new_exec(void)
+{
+	current->mm->context.flags = is_compat_task() ? MMCF_AARCH32 : 0;
+}
-- 
2.11.0
