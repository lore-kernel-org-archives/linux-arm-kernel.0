From: kevin.brodsky@arm.com (Kevin Brodsky)
Date: Tue,  6 Dec 2016 16:03:51 +0000
Subject: [RFC PATCH v3 09/11] arm64: elf: Set AT_SYSINFO_EHDR in compat
 processes
In-Reply-To: <20161206160353.14581-1-kevin.brodsky@arm.com>
References: <20161206160353.14581-1-kevin.brodsky@arm.com>
Message-ID: <20161206160353.14581-10-kevin.brodsky@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the compat vDSO is enabled, we need to set AT_SYSINFO_EHDR in the
auxiliary vector of compat processes to the address of the vDSO code
page, so that the dynamic linker can find it (just like the regular vDSO).

Note that we cast context.vdso to unsigned long, instead of elf_addr_t,
because elf_addr_t is 32-bit in compat_binfmt_elf.c, and casting to u32
would trigger a pointer narrowing warning.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Nathan Lynch <nathan_lynch@mentor.com>
Cc: Christopher Covington <cov@codeaurora.org>
Cc: Dmitry Safonov <dsafonov@virtuozzo.com>
Cc: Jisheng Zhang <jszhang@marvell.com>
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/arm64/include/asm/elf.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index 7da9452596ad..765c633950b7 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -141,11 +141,12 @@ typedef struct user_fpsimd_state elf_fpregset_t;
 #define SET_PERSONALITY(ex)		clear_thread_flag(TIF_32BIT);
 
 /* update AT_VECTOR_SIZE_ARCH if the number of NEW_AUX_ENT entries changes */
-#define ARCH_DLINFO							\
+#define _SET_AUX_ENT_VDSO						\
 do {									\
 	NEW_AUX_ENT(AT_SYSINFO_EHDR,					\
-		    (elf_addr_t)current->mm->context.vdso);		\
+		    (unsigned long)current->mm->context.vdso);		\
 } while (0)
+#define ARCH_DLINFO _SET_AUX_ENT_VDSO
 
 #define ARCH_HAS_SETUP_ADDITIONAL_PAGES
 struct linux_binprm;
@@ -184,7 +185,11 @@ typedef compat_elf_greg_t		compat_elf_gregset_t[COMPAT_ELF_NGREG];
 
 #define compat_start_thread		compat_start_thread
 #define COMPAT_SET_PERSONALITY(ex)	set_thread_flag(TIF_32BIT);
+#ifdef CONFIG_VDSO32
+#define COMPAT_ARCH_DLINFO		_SET_AUX_ENT_VDSO
+#else
 #define COMPAT_ARCH_DLINFO
+#endif
 extern int aarch32_setup_additional_pages(struct linux_binprm *bprm,
 					  int uses_interp);
 #define compat_arch_setup_additional_pages \
-- 
2.10.2
