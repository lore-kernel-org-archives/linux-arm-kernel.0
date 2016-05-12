From: ynorov@caviumnetworks.com (Yury Norov)
Date: Thu, 12 May 2016 14:26:54 +0300
Subject: [PATCH] arm64: fix current_thread_info()->addr_limit setup
Message-ID: <1463052414-29033-1-git-send-email-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At elf loading in flush_old_exec() in fs/exec.c, generic code sets
current_thread_info()->addr_limit to one that corresponds aarch64 value,
and ignores compat mode there as corresponding status setup happens
later on in load_elf_binary() by SET_PERSONALITY() macro. As result,
compat task has wrong addr_limit, and it may cause various bugs.

This patch fixes it. It also fixes USER_DS macro to return different
values depending on compat at runtime.

It was discovered during ilp32 development. See details here:
https://lkml.org/lkml/2016/5/11/975

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 arch/arm64/include/asm/elf.h     | 11 +++++++++--
 arch/arm64/include/asm/uaccess.h |  2 +-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index 24ed037..fda75ce 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -138,7 +138,10 @@ typedef struct user_fpsimd_state elf_fpregset_t;
  */
 #define ELF_PLAT_INIT(_r, load_addr)	(_r)->regs[0] = 0
 
-#define SET_PERSONALITY(ex)		clear_thread_flag(TIF_32BIT);
+#define SET_PERSONALITY(ex) do {					\
+	clear_thread_flag(TIF_32BIT);					\
+	set_fs(TASK_SIZE_64);						\
+} while (0)
 
 #define ARCH_DLINFO							\
 do {									\
@@ -181,7 +184,11 @@ typedef compat_elf_greg_t		compat_elf_gregset_t[COMPAT_ELF_NGREG];
 					 ((x)->e_flags & EF_ARM_EABI_MASK))
 
 #define compat_start_thread		compat_start_thread
-#define COMPAT_SET_PERSONALITY(ex)	set_thread_flag(TIF_32BIT);
+#define COMPAT_SET_PERSONALITY(ex) do {					\
+	set_thread_flag(TIF_32BIT);					\
+	set_fs(TASK_SIZE_32);						\
+} while (0)
+
 #define COMPAT_ARCH_DLINFO
 extern int aarch32_setup_vectors_page(struct linux_binprm *bprm,
 				      int uses_interp);
diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 0685d74..5b269e6 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -60,7 +60,7 @@ extern int fixup_exception(struct pt_regs *regs);
 #define KERNEL_DS	(-1UL)
 #define get_ds()	(KERNEL_DS)
 
-#define USER_DS		TASK_SIZE_64
+#define USER_DS		TASK_SIZE
 #define get_fs()	(current_thread_info()->addr_limit)
 
 static inline void set_fs(mm_segment_t fs)
-- 
2.5.0
