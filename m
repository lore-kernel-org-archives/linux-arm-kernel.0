From: kevin.brodsky@arm.com (Kevin Brodsky)
Date: Thu,  8 Sep 2016 15:01:00 +0100
Subject: [RFC PATCH 5/8] arm64: compat: 32-bit vDSO setup
In-Reply-To: <20160908140103.7468-1-kevin.brodsky@arm.com>
References: <20160908140103.7468-1-kevin.brodsky@arm.com>
Message-ID: <20160908140103.7468-6-kevin.brodsky@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the compat vDSO is enabled, install it in compat processes. In this
case, the compat vDSO replaces the vector page.

aarch32_setup_vectors_page has also been renamed to the more generic
aarch32_setup_additional_pages to reflect both use cases.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/arm64/include/asm/elf.h |  6 +++---
 arch/arm64/kernel/vdso.c     | 22 +++++++++++++++++++++-
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index a55384f4a5d7..7da9452596ad 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -185,10 +185,10 @@ typedef compat_elf_greg_t		compat_elf_gregset_t[COMPAT_ELF_NGREG];
 #define compat_start_thread		compat_start_thread
 #define COMPAT_SET_PERSONALITY(ex)	set_thread_flag(TIF_32BIT);
 #define COMPAT_ARCH_DLINFO
-extern int aarch32_setup_vectors_page(struct linux_binprm *bprm,
-				      int uses_interp);
+extern int aarch32_setup_additional_pages(struct linux_binprm *bprm,
+					  int uses_interp);
 #define compat_arch_setup_additional_pages \
-					aarch32_setup_vectors_page
+					aarch32_setup_additional_pages
 
 #endif /* CONFIG_COMPAT */
 
diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index d74f9ac7e336..97d37b64b146 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -139,6 +139,25 @@ up_fail:
 }
 
 #ifdef CONFIG_COMPAT
+#ifdef CONFIG_VDSO32
+extern char vdso32_start, vdso32_end;
+
+static struct vdso_mappings vdso32_mappings;
+
+static int __init vdso32_init(void)
+{
+	return setup_vdso_mappings("vdso32", &vdso32_start, &vdso32_end,
+				   &vdso32_mappings);
+}
+arch_initcall(vdso32_init);
+
+int aarch32_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
+{
+	return setup_vdso_pages(&vdso32_mappings);
+}
+
+#else /* CONFIG_VDSO32 */
+
 /*
  * Create and map the vectors page for AArch32 tasks.
  */
@@ -173,7 +192,7 @@ static int alloc_vectors_page(void)
 }
 arch_initcall(alloc_vectors_page);
 
-int aarch32_setup_vectors_page(struct linux_binprm *bprm, int uses_interp)
+int aarch32_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 {
 	struct mm_struct *mm = current->mm;
 	unsigned long addr = AARCH32_VECTORS_BASE;
@@ -197,6 +216,7 @@ int aarch32_setup_vectors_page(struct linux_binprm *bprm, int uses_interp)
 
 	return PTR_ERR_OR_ZERO(ret);
 }
+#endif /* CONFIG_VDSO32 */
 #endif /* CONFIG_COMPAT */
 
 extern char vdso_start, vdso_end;
-- 
2.9.3
