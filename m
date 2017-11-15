From: salyzyn@android.com (Mark Salyzyn)
Date: Wed, 15 Nov 2017 14:05:12 -0800
Subject: [PATCH 2/6] arm64: elf: Set AT_SYSINFO_EHDR in compat processes
In-Reply-To: <20171115220529.14458-1-salyzyn@android.com>
References: <20171115220529.14458-1-salyzyn@android.com>
Message-ID: <20171115220529.14458-3-salyzyn@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Brodsky <kevin.brodsky@arm.com>

If the compat vDSO is enabled, we need to set AT_SYSINFO_EHDR in the
auxiliary vector of compat processes to the address of the vDSO code
page, so that the dynamic linker can find it (just like the regular vDSO).

Note that we cast context.vdso to Elf64_Off, instead of elf_addr_t,
because elf_addr_t is Elf32_Off in compat_binfmt_elf.c, and casting
context.vdso to u32 would trigger a pointer narrowing warning.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Dave Martin <Dave.Martin@arm.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm64/include/asm/elf.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index 33be513ef24c..675fa096d4a4 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -144,11 +144,12 @@ typedef struct user_fpsimd_state elf_fpregset_t;
 })
 
 /* update AT_VECTOR_SIZE_ARCH if the number of NEW_AUX_ENT entries changes */
-#define ARCH_DLINFO							\
+#define _SET_AUX_ENT_VDSO						\
 do {									\
 	NEW_AUX_ENT(AT_SYSINFO_EHDR,					\
-		    (elf_addr_t)current->mm->context.vdso);		\
+		    (Elf64_Off)current->mm->context.vdso);		\
 } while (0)
+#define ARCH_DLINFO _SET_AUX_ENT_VDSO
 
 #define ARCH_HAS_SETUP_ADDITIONAL_PAGES
 struct linux_binprm;
@@ -196,7 +197,11 @@ typedef compat_elf_greg_t		compat_elf_gregset_t[COMPAT_ELF_NGREG];
 ({									\
 	set_thread_flag(TIF_32BIT);					\
  })
+#ifdef CONFIG_VDSO32
+#define COMPAT_ARCH_DLINFO	_SET_AUX_ENT_VDSO
+#else
 #define COMPAT_ARCH_DLINFO
+#endif
 extern int aarch32_setup_vectors_page(struct linux_binprm *bprm,
 				      int uses_interp);
 #define compat_arch_setup_additional_pages \
-- 
2.15.0.448.gf294e3d99a-goog
