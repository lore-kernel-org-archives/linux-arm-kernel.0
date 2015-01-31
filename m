From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sat, 31 Jan 2015 19:49:19 +0000
Subject: [PATCH resend 4/4] ARM: add partial interworking support to Thumb-2
 kernel
In-Reply-To: <1422733759-27236-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1422733759-27236-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1422733759-27236-5-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM/Thumb interworking is currently not allowed in modules at all:
external module dependencies can only be fulfilled by symbols of
the same flavour, but even inside a module, jumps and calls between
objects are rejected if they would incur a mode switch.

This patch relaxes that restriction somewhat, by allowing function
calls ('bl') from T32 into A32 code. If a non-Thumb function symbol
is encountered, a 'bl' instruction is converted into a 'blx'
instruction, with the appropriate rounding applied to the offset.

The most compelling argument for allowing this is that many modules,
especially accelerated crypto, follow the pattern of a core object
coded in assembly that is wired up to the kernel APIs using a glue
object coded in C. With this patch, such assembly core objects no
longer have to be developed, tested and maintained in both ARM and
Thumb-2 modes: just having an ARM version suffices.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/kernel/module.c | 40 +++++++++++++++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 7 deletions(-)

diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index 6c08b2188992..ceb1812c2bbc 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -180,8 +180,9 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
 		case R_ARM_THM_CALL:
 		case R_ARM_THM_JUMP24:
 			/*
-			 * For function symbols, only Thumb addresses are
-			 * allowed (no interworking).
+			 * For function symbols, we need to force a
+			 * Thumb -> ARM mode switch if the destination
+			 * address has its Thumb bit (bit 0) cleared.
 			 * This applies equally to untyped symbols that
 			 * resolve to external ksyms: EXPORT_SYMBOL()
 			 * strips the function annotation, but we can
@@ -197,9 +198,21 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
 			     (ELF32_ST_TYPE(sym->st_info) == STT_NOTYPE &&
 			      sym->st_shndx == SHN_UNDEF)) &&
 			    !(sym->st_value & 1)) {
-				pr_err("%s: section %u reloc %u sym '%s': unsupported interworking call (Thumb -> ARM)\n",
-				       module->name, relindex, i, symname);
-				return -ENOEXEC;
+
+				/*
+				 * Only interworking call relocations can
+				 * be supported, as long as the destination
+				 * is in range.
+				 */
+				if (ELF32_R_TYPE(rel->r_info) != R_ARM_THM_CALL) {
+					pr_err("%s: section %u reloc %u sym '%s': unsupported interworking call (Thumb -> ARM)\n",
+					       module->name, relindex, i,
+					       symname);
+					return -ENOEXEC;
+				}
+				tmp = sym->st_value;
+			} else {
+				tmp = sym->st_value | 1;
 			}
 
 			upper = __mem_to_opcode_thumb16(*(u16 *)loc);
@@ -227,7 +240,17 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
 				((lower & 0x07ff) << 1);
 			if (offset & 0x01000000)
 				offset -= 0x02000000;
-			offset += sym->st_value - loc;
+			offset += tmp;
+
+			/*
+			 * When fixing up a bl instruction to blx, the address
+			 * of the call site must be rounded down in the
+			 * calculation of 'offset'. As this could potentially
+			 * cause 'offset' to go out of range, we need to do
+			 * this before performing the range check.
+			 */
+			tmp = offset & 1 ? loc : loc & ~2;
+			offset -= tmp;
 
 			/*
 			 * Route through a PLT entry if 'offset' exceeds the
@@ -237,8 +260,11 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
 			    (offset <= (s32)0xff000000 ||
 			     offset >= (s32)0x01000000))
 				offset = get_module_plt(module, loc,
-							offset + loc + 4)
+							offset + tmp + 4)
 					 - loc - 4;
+			else if (!(offset & 1))
+				/* fix up bl -> blx */
+				lower &= ~(1 << 12);
 
 			if (offset <= (s32)0xff000000 ||
 			    offset >= (s32)0x01000000) {
-- 
1.8.3.2
