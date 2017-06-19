From: ynorov@caviumnetworks.com (Yury Norov)
Date: Mon, 19 Jun 2017 18:49:53 +0300
Subject: [PATCH 10/20] arm64: ilp32: add is_ilp32_compat_{task,
 thread} and TIF_32BIT_AARCH64
In-Reply-To: <20170619155003.13218-1-ynorov@caviumnetworks.com>
References: <20170619155003.13218-1-ynorov@caviumnetworks.com>
Message-ID: <20170619155003.13218-11-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ILP32 tasks are needed to be distinguished from lp64 and aarch32.
This patch adds helper functions is_ilp32_compat_{task,thread} and
thread flag TIF_32BIT_AARCH64 to address it. This is a preparation
for following patches in ilp32 patchset.

For consistency, SET_PERSONALITY is changed here accordingly.

Signed-off-by: Andrew Pinski <Andrew.Pinski@caviumnetworks.com>
Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
Reviewed-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/arm64/include/asm/elf.h         |  2 ++
 arch/arm64/include/asm/is_compat.h   | 30 ++++++++++++++++++++++++++++--
 arch/arm64/include/asm/thread_info.h |  2 ++
 3 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index 6a37b6facc69..8f7bafa60d01 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -145,6 +145,7 @@ typedef struct user_fpsimd_state elf_fpregset_t;
 #define SET_PERSONALITY(ex)						\
 ({									\
 	clear_bit(TIF_32BIT, &current->mm->context.flags);		\
+	clear_thread_flag(TIF_32BIT_AARCH64);				\
 	clear_thread_flag(TIF_32BIT);					\
 	current->personality &= ~READ_IMPLIES_EXEC;			\
 })
@@ -196,6 +197,7 @@ typedef compat_elf_greg_t		compat_elf_gregset_t[COMPAT_ELF_NGREG];
 #define COMPAT_SET_PERSONALITY(ex)					\
 ({									\
 	set_bit(TIF_32BIT, &current->mm->context.flags);		\
+	clear_thread_flag(TIF_32BIT_AARCH64);				\
 	set_thread_flag(TIF_32BIT);					\
  })
 #define COMPAT_ARCH_DLINFO
diff --git a/arch/arm64/include/asm/is_compat.h b/arch/arm64/include/asm/is_compat.h
index 8dba5caaf5d1..7726bebc4115 100644
--- a/arch/arm64/include/asm/is_compat.h
+++ b/arch/arm64/include/asm/is_compat.h
@@ -45,18 +45,44 @@ static inline int is_a32_compat_thread(struct thread_info *thread)
 
 #endif /* CONFIG_AARCH32_EL0 */
 
+#ifdef CONFIG_ARM64_ILP32
+
+static inline int is_ilp32_compat_task(void)
+{
+	return test_thread_flag(TIF_32BIT_AARCH64);
+}
+
+static inline int is_ilp32_compat_thread(struct thread_info *thread)
+{
+	return test_ti_thread_flag(thread, TIF_32BIT_AARCH64);
+}
+
+#else
+
+static inline int is_ilp32_compat_task(void)
+{
+	return 0;
+}
+
+static inline int is_ilp32_compat_thread(struct thread_info *thread)
+{
+	return 0;
+}
+
+#endif /* CONFIG_ARM64_ILP32 */
+
 #ifdef CONFIG_COMPAT
 
 static inline int is_compat_task(void)
 {
-	return is_a32_compat_task();
+	return is_a32_compat_task() || is_ilp32_compat_task();
 }
 
 #endif /* CONFIG_COMPAT */
 
 static inline int is_compat_thread(struct thread_info *thread)
 {
-	return is_a32_compat_thread(thread);
+	return is_a32_compat_thread(thread) || is_ilp32_compat_thread(thread);
 }
 
 
diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index a7ffea24d94d..abb60b5fc9f4 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -96,6 +96,7 @@ struct thread_info {
 #define TIF_RESTORE_SIGMASK	20
 #define TIF_SINGLESTEP		21
 #define TIF_32BIT		22	/* AARCH32 process */
+#define TIF_32BIT_AARCH64	23	/* 32 bit process on AArch64(ILP32) */
 
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
@@ -108,6 +109,7 @@ struct thread_info {
 #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
 #define _TIF_UPROBE		(1 << TIF_UPROBE)
 #define _TIF_32BIT		(1 << TIF_32BIT)
+#define _TIF_32BIT_AARCH64	(1 << TIF_32BIT_AARCH64)
 
 #define _TIF_WORK_MASK		(_TIF_NEED_RESCHED | _TIF_SIGPENDING | \
 				 _TIF_NOTIFY_RESUME | _TIF_FOREIGN_FPSTATE | \
-- 
2.11.0
