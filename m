From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sat, 31 Jan 2015 19:49:18 +0000
Subject: [PATCH resend 3/4] ARM: Thumb-2: infer function annotation for
 external ksyms
In-Reply-To: <1422733759-27236-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1422733759-27236-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1422733759-27236-4-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 9a00318eadbb ("Thumb-2: Relax relocation requirements for
non-function symbols") updated the Thumb-2 jump and call relocation
handling so that non-function symbols with the Thumb bit (bit 0)
cleared are not treated as A32 symbols requiring an interworking
mode switch.

However, since ksyms are stripped of their function annotation by
EXPORT_SYMBOL(), A32 symbols that do require an interworking mode
switch will be called in the wrong mode if the relocation is resolved
across a module boundary.

This patch enhances the function symbol check by including untyped
symbols that resolve to external ksyms.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/kernel/module.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index a68040989143..6c08b2188992 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -182,13 +182,20 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
 			/*
 			 * For function symbols, only Thumb addresses are
 			 * allowed (no interworking).
+			 * This applies equally to untyped symbols that
+			 * resolve to external ksyms: EXPORT_SYMBOL()
+			 * strips the function annotation, but we can
+			 * infer from the relocation type that the target
+			 * must be a function.
 			 *
 			 * For non-function symbols, the destination
 			 * has no specific ARM/Thumb disposition, so
 			 * the branch is resolved under the assumption
 			 * that interworking is not required.
 			 */
-			if (ELF32_ST_TYPE(sym->st_info) == STT_FUNC &&
+			if ((ELF32_ST_TYPE(sym->st_info) == STT_FUNC ||
+			     (ELF32_ST_TYPE(sym->st_info) == STT_NOTYPE &&
+			      sym->st_shndx == SHN_UNDEF)) &&
 			    !(sym->st_value & 1)) {
 				pr_err("%s: section %u reloc %u sym '%s': unsupported interworking call (Thumb -> ARM)\n",
 				       module->name, relindex, i, symname);
-- 
1.8.3.2
