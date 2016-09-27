From: panand@redhat.com (Pratyush Anand)
Date: Tue, 27 Sep 2016 13:17:59 +0530
Subject: [PATCH V2 5/6] arm64: introduce mm context flag to keep 32 bit task
 information
In-Reply-To: <cover.1474960629.git.panand@redhat.com>
References: <cover.1474960629.git.panand@redhat.com>
Message-ID: <733fc72f15938b422bd0428be3b36d47e36afa26.1474960629.git.panand@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need to decide in some cases like uprobe instruction analysis that
whether the current mm context belongs to a 32 bit task or 64 bit.

This patch has introduced an unsigned flag variable in mm_context_t.
Currently, we set and clear TIF_32BIT depending on the condition that
whether an elf binary load sets personality for 32 bit or 64 bit
respectively.

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 arch/arm64/include/asm/elf.h | 12 ++++++++++--
 arch/arm64/include/asm/mmu.h |  1 +
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index a55384f4a5d7..5d1700425efe 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -138,7 +138,11 @@ typedef struct user_fpsimd_state elf_fpregset_t;
  */
 #define ELF_PLAT_INIT(_r, load_addr)	(_r)->regs[0] = 0
 
-#define SET_PERSONALITY(ex)		clear_thread_flag(TIF_32BIT);
+#define SET_PERSONALITY(ex)						\
+({									\
+	clear_bit(TIF_32BIT, &current->mm->context.flags);		\
+	clear_thread_flag(TIF_32BIT);					\
+})
 
 /* update AT_VECTOR_SIZE_ARCH if the number of NEW_AUX_ENT entries changes */
 #define ARCH_DLINFO							\
@@ -183,7 +187,11 @@ typedef compat_elf_greg_t		compat_elf_gregset_t[COMPAT_ELF_NGREG];
 					 ((x)->e_flags & EF_ARM_EABI_MASK))
 
 #define compat_start_thread		compat_start_thread
-#define COMPAT_SET_PERSONALITY(ex)	set_thread_flag(TIF_32BIT);
+#define COMPAT_SET_PERSONALITY(ex)					\
+({									\
+	set_bit(TIF_32BIT, &current->mm->context.flags);		\
+	set_thread_flag(TIF_32BIT);					\
+ })
 #define COMPAT_ARCH_DLINFO
 extern int aarch32_setup_vectors_page(struct linux_binprm *bprm,
 				      int uses_interp);
diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index 8d9fce037b2f..d4fa21543771 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -19,6 +19,7 @@
 typedef struct {
 	atomic64_t	id;
 	void		*vdso;
+	unsigned long	flags;
 } mm_context_t;
 
 /*
-- 
2.7.4
