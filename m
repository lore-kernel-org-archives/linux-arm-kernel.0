From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sat, 15 Oct 2016 10:16:08 +0100
Subject: [PATCH] modversions: treat symbol CRCs as 32 bit quantities on 64 bit
 archs
Message-ID: <1476522968-20156-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The symbol CRCs are emitted as ELF symbols, which allows us to easily
populate the kcrctab sections by relying on the linker to associate
each kcrctab slot with the correct value.

This has two downsides:
- given that the CRCs are treated as pointers, we waste 4 bytes for
  each CRC on 64 bit architectures,
- on architectures that support runtime relocation, a relocation entry is
  emitted for each CRC value, which may take up 24 bytes of __init space
  (on ELF64 systems)

This comes down to a x8 overhead in [uncompressed] kernel size. In addition,
each relocation has to be reverted before the CRC value can be used, which
has resulted in an ugly workaround involving ARCH_RELOCATES_KCRCTAB, and an
even uglier workaround around the workaround involving the "TOC." symbol on
PPC64. This patch gets rid of all of that.

So switch to explicit 32 bit values on 64 bit architectures. This fixes
both issues, given that 32 bit values are not treated as runtime relocatable
quantities on ELF64 systems, even if they ultimately resolve to linker
supplied values. Also note that the only two architectures affected by the
runtime relocation issue are PPC and arm64, both of which rely on the
toolchain's PIE routines to create a runtime relocatable vmlinux. While x86
also implements CONFIG_RELOCATABLE, it relies on its own build tools, which
disregard kcrctab entries explicitly.

So redefine all CRC fields and variables as u32, and redefine the
__CRC_SYMBOL() macro for 64 bit builds to emit the CRC reference using
inline assembler (which is necessary since 64-bit C code cannot use
32-bit types to hold memory addresses, even if they are ultimately
resolved using values that do no exceed 0xffffffff).

Also remove the special handling for PPC64, this should no longer be
required.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---

I received some feedback on draft versions of this patch from the kbuild
test robot, but none of it regarding the inline asm in this patch.
Hopefully, that means it works on all 64 bit architectures we support,
but I have not been able to test that exhaustively myself.

On an arm64 defconfig build with CONFIG_RELOCATABLE=y, this patch reduces
the CRC footprint by 24 KB for .rodata, and by 217 KB for .init

Before:
  [ 9] __kcrctab         PROGBITS         ffff000008b992a8  00b292a8
       0000000000009440  0000000000000000   A       0     0     8
  [10] __kcrctab_gpl     PROGBITS         ffff000008ba26e8  00b326e8
       0000000000008d40  0000000000000000   A       0     0     8
  ...
  [22] .rela             RELA             ffff000008c96e20  00c26e20
       00000000001cc758  0000000000000018   A       0     0     8

After:
  [ 9] __kcrctab         PROGBITS         ffff000008b728a8  00b028a8
       0000000000004a20  0000000000000000   A       0     0     1
  [10] __kcrctab_gpl     PROGBITS         ffff000008b772c8  00b072c8
       00000000000046a0  0000000000000000   A       0     0     1
  ...
  [22] .rela             RELA             ffff000008c66e20  00bf6e20
       00000000001962d8  0000000000000018   A       0     0     8

 arch/powerpc/include/asm/module.h |  4 --
 arch/powerpc/kernel/module_64.c   |  8 ----
 include/linux/export.h            |  8 ++++
 include/linux/module.h            | 16 ++++----
 kernel/module.c                   | 39 +++++++-------------
 5 files changed, 30 insertions(+), 45 deletions(-)

diff --git a/arch/powerpc/include/asm/module.h b/arch/powerpc/include/asm/module.h
index cd4ffd86765f..94a7f7aa3ae8 100644
--- a/arch/powerpc/include/asm/module.h
+++ b/arch/powerpc/include/asm/module.h
@@ -94,9 +94,5 @@ struct exception_table_entry;
 void sort_ex_table(struct exception_table_entry *start,
 		   struct exception_table_entry *finish);
 
-#if defined(CONFIG_MODVERSIONS) && defined(CONFIG_PPC64)
-#define ARCH_RELOCATES_KCRCTAB
-#define reloc_start PHYSICAL_START
-#endif
 #endif /* __KERNEL__ */
 #endif	/* _ASM_POWERPC_MODULE_H */
diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index 183368e008cf..be9b2d5ff846 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -286,14 +286,6 @@ static void dedotify_versions(struct modversion_info *vers,
 	for (end = (void *)vers + size; vers < end; vers++)
 		if (vers->name[0] == '.') {
 			memmove(vers->name, vers->name+1, strlen(vers->name));
-#ifdef ARCH_RELOCATES_KCRCTAB
-			/* The TOC symbol has no CRC computed. To avoid CRC
-			 * check failing, we must force it to the expected
-			 * value (see CRC check in module.c).
-			 */
-			if (!strcmp(vers->name, "TOC."))
-				vers->crc = -(unsigned long)reloc_start;
-#endif
 		}
 }
 
diff --git a/include/linux/export.h b/include/linux/export.h
index d7df4922da1d..1d2f841e8368 100644
--- a/include/linux/export.h
+++ b/include/linux/export.h
@@ -40,6 +40,7 @@ extern struct module __this_module;
 
 #if defined(__KERNEL__) && !defined(__GENKSYMS__)
 #ifdef CONFIG_MODVERSIONS
+#ifndef CONFIG_64BIT
 /* Mark the CRC weak since genksyms apparently decides not to
  * generate a checksums for some symbols */
 #define __CRC_SYMBOL(sym, sec)					\
@@ -49,6 +50,13 @@ extern struct module __this_module;
 	__attribute__((section("___kcrctab" sec "+" #sym), unused))	\
 	= (unsigned long) &__crc_##sym;
 #else
+#define __CRC_SYMBOL(sym, sec)						\
+	asm("	.section \"___kcrctab" sec "+" #sym "\", \"a\"	\n"	\
+	    "	.weak	" VMLINUX_SYMBOL_STR(__crc_##sym) "	\n"	\
+	    "	.word	" VMLINUX_SYMBOL_STR(__crc_##sym) "	\n"	\
+	    "	.previous					\n");
+#endif
+#else
 #define __CRC_SYMBOL(sym, sec)
 #endif
 
diff --git a/include/linux/module.h b/include/linux/module.h
index 0c3207d26ac0..a51b70fcbc6b 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -33,7 +33,7 @@
 #define MODULE_NAME_LEN MAX_PARAM_PREFIX_LEN
 
 struct modversion_info {
-	unsigned long crc;
+	u32 crc;
 	char name[MODULE_NAME_LEN];
 };
 
@@ -346,7 +346,7 @@ struct module {
 
 	/* Exported symbols */
 	const struct kernel_symbol *syms;
-	const unsigned long *crcs;
+	const u32 *crcs;
 	unsigned int num_syms;
 
 	/* Kernel parameters. */
@@ -359,18 +359,18 @@ struct module {
 	/* GPL-only exported symbols. */
 	unsigned int num_gpl_syms;
 	const struct kernel_symbol *gpl_syms;
-	const unsigned long *gpl_crcs;
+	const u32 *gpl_crcs;
 
 #ifdef CONFIG_UNUSED_SYMBOLS
 	/* unused exported symbols. */
 	const struct kernel_symbol *unused_syms;
-	const unsigned long *unused_crcs;
+	const u32 *unused_crcs;
 	unsigned int num_unused_syms;
 
 	/* GPL-only, unused exported symbols. */
 	unsigned int num_unused_gpl_syms;
 	const struct kernel_symbol *unused_gpl_syms;
-	const unsigned long *unused_gpl_crcs;
+	const u32 *unused_gpl_crcs;
 #endif
 
 #ifdef CONFIG_MODULE_SIG
@@ -382,7 +382,7 @@ struct module {
 
 	/* symbols that will be GPL-only in the near future. */
 	const struct kernel_symbol *gpl_future_syms;
-	const unsigned long *gpl_future_crcs;
+	const u32 *gpl_future_crcs;
 	unsigned int num_gpl_future_syms;
 
 	/* Exception table */
@@ -523,7 +523,7 @@ struct module *find_module(const char *name);
 
 struct symsearch {
 	const struct kernel_symbol *start, *stop;
-	const unsigned long *crcs;
+	const u32 *crcs;
 	enum {
 		NOT_GPL_ONLY,
 		GPL_ONLY,
@@ -539,7 +539,7 @@ struct symsearch {
  */
 const struct kernel_symbol *find_symbol(const char *name,
 					struct module **owner,
-					const unsigned long **crc,
+					const u32 **crc,
 					bool gplok,
 					bool warn);
 
diff --git a/kernel/module.c b/kernel/module.c
index f57dd63186e6..f2d39148814a 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -386,16 +386,16 @@ extern const struct kernel_symbol __start___ksymtab_gpl[];
 extern const struct kernel_symbol __stop___ksymtab_gpl[];
 extern const struct kernel_symbol __start___ksymtab_gpl_future[];
 extern const struct kernel_symbol __stop___ksymtab_gpl_future[];
-extern const unsigned long __start___kcrctab[];
-extern const unsigned long __start___kcrctab_gpl[];
-extern const unsigned long __start___kcrctab_gpl_future[];
+extern const u32 __start___kcrctab[];
+extern const u32 __start___kcrctab_gpl[];
+extern const u32 __start___kcrctab_gpl_future[];
 #ifdef CONFIG_UNUSED_SYMBOLS
 extern const struct kernel_symbol __start___ksymtab_unused[];
 extern const struct kernel_symbol __stop___ksymtab_unused[];
 extern const struct kernel_symbol __start___ksymtab_unused_gpl[];
 extern const struct kernel_symbol __stop___ksymtab_unused_gpl[];
-extern const unsigned long __start___kcrctab_unused[];
-extern const unsigned long __start___kcrctab_unused_gpl[];
+extern const u32 __start___kcrctab_unused[];
+extern const u32 __start___kcrctab_unused_gpl[];
 #endif
 
 #ifndef CONFIG_MODVERSIONS
@@ -494,7 +494,7 @@ struct find_symbol_arg {
 
 	/* Output */
 	struct module *owner;
-	const unsigned long *crc;
+	const u32 *crc;
 	const struct kernel_symbol *sym;
 };
 
@@ -560,7 +560,7 @@ static bool find_symbol_in_section(const struct symsearch *syms,
  * (optional) module which owns it.  Needs preempt disabled or module_mutex. */
 const struct kernel_symbol *find_symbol(const char *name,
 					struct module **owner,
-					const unsigned long **crc,
+					const u32 **crc,
 					bool gplok,
 					bool warn)
 {
@@ -1257,22 +1257,11 @@ static int try_to_force_load(struct module *mod, const char *reason)
 }
 
 #ifdef CONFIG_MODVERSIONS
-/* If the arch applies (non-zero) relocations to kernel kcrctab, unapply it. */
-static unsigned long maybe_relocated(unsigned long crc,
-				     const struct module *crc_owner)
-{
-#ifdef ARCH_RELOCATES_KCRCTAB
-	if (crc_owner == NULL)
-		return crc - (unsigned long)reloc_start;
-#endif
-	return crc;
-}
-
 static int check_version(Elf_Shdr *sechdrs,
 			 unsigned int versindex,
 			 const char *symname,
 			 struct module *mod,
-			 const unsigned long *crc,
+			 const u32 *crc,
 			 const struct module *crc_owner)
 {
 	unsigned int i, num_versions;
@@ -1294,10 +1283,10 @@ static int check_version(Elf_Shdr *sechdrs,
 		if (strcmp(versions[i].name, symname) != 0)
 			continue;
 
-		if (versions[i].crc == maybe_relocated(*crc, crc_owner))
+		if (versions[i].crc == *crc)
 			return 1;
-		pr_debug("Found checksum %lX vs module %lX\n",
-		       maybe_relocated(*crc, crc_owner), versions[i].crc);
+		pr_debug("Found checksum %X vs module %X\n",
+		       *crc, versions[i].crc);
 		goto bad_version;
 	}
 
@@ -1314,7 +1303,7 @@ static inline int check_modstruct_version(Elf_Shdr *sechdrs,
 					  unsigned int versindex,
 					  struct module *mod)
 {
-	const unsigned long *crc;
+	const u32 *crc;
 
 	/*
 	 * Since this should be found in kernel (which can't be removed), no
@@ -1347,7 +1336,7 @@ static inline int check_version(Elf_Shdr *sechdrs,
 				unsigned int versindex,
 				const char *symname,
 				struct module *mod,
-				const unsigned long *crc,
+				const u32 *crc,
 				const struct module *crc_owner)
 {
 	return 1;
@@ -1375,7 +1364,7 @@ static const struct kernel_symbol *resolve_symbol(struct module *mod,
 {
 	struct module *owner;
 	const struct kernel_symbol *sym;
-	const unsigned long *crc;
+	const u32 *crc;
 	int err;
 
 	/*
-- 
2.7.4
