From: kevin.brodsky@arm.com (Kevin Brodsky)
Date: Thu,  8 Sep 2016 14:53:22 +0100
Subject: [PATCH 6/8] arm64: elf: Set AT_SYSINFO_EHDR in compat processes
In-Reply-To: <20160908135324.7112-1-kevin.brodsky@arm.com>
References: <20160908135324.7112-1-kevin.brodsky@arm.com>
Message-ID: <20160908135324.7112-7-kevin.brodsky@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the compat vDSO is enabled, we need to set AT_SYSINFO_EHDR in the
auxiliary vector of compat processes to the address of the vDSO, so
that userspace (libc) can find it (just like the regular vDSO).

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/arm64/include/asm/elf.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index d811f81bdd11..c0e9156ebc75 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -140,11 +140,12 @@ typedef struct user_fpsimd_state elf_fpregset_t;
 
 #define SET_PERSONALITY(ex)		clear_thread_flag(TIF_32BIT);
 
-#define ARCH_DLINFO							\
+#define _SET_AUX_ENT_VDSO						\
 do {									\
 	NEW_AUX_ENT(AT_SYSINFO_EHDR,					\
 		    (elf_addr_t)current->mm->context.vdso);		\
 } while (0)
+#define ARCH_DLINFO _SET_AUX_ENT_VDSO
 
 #define ARCH_HAS_SETUP_ADDITIONAL_PAGES
 struct linux_binprm;
@@ -182,7 +183,11 @@ typedef compat_elf_greg_t		compat_elf_gregset_t[COMPAT_ELF_NGREG];
 
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
2.8.2
