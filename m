From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sat, 31 Jan 2015 19:49:16 +0000
Subject: [PATCH resend 1/4] ARM: handle interworking and out-of-range
 relocations separately
In-Reply-To: <1422733759-27236-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1422733759-27236-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1422733759-27236-2-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, interworking calls on module boundaries are not supported,
and are handled by the same error handling code path as non-interworking
calls whose targets are simply out of range.

Before modifying the handling of those out-of-range jump and call
relocations in a subsequent patch, move the handling of interworking
restrictions out of it.

Acked-by: Nicolas Pitre <nico@linaro.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/kernel/module.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index 6a4dffefd357..16804df4857c 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -98,14 +98,19 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
 		case R_ARM_PC24:
 		case R_ARM_CALL:
 		case R_ARM_JUMP24:
+			if (sym->st_value & 3) {
+				pr_err("%s: section %u reloc %u sym '%s': unsupported interworking call (ARM -> Thumb)\n",
+				       module->name, relindex, i, symname);
+				return -ENOEXEC;
+			}
+
 			offset = __mem_to_opcode_arm(*(u32 *)loc);
 			offset = (offset & 0x00ffffff) << 2;
 			if (offset & 0x02000000)
 				offset -= 0x04000000;
 
 			offset += sym->st_value - loc;
-			if (offset & 3 ||
-			    offset <= (s32)0xfe000000 ||
+			if (offset <= (s32)0xfe000000 ||
 			    offset >= (s32)0x02000000) {
 				pr_err("%s: section %u reloc %u sym '%s': relocation %u out of range (%#lx -> %#x)\n",
 				       module->name, relindex, i, symname,
@@ -155,6 +160,22 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
 #ifdef CONFIG_THUMB2_KERNEL
 		case R_ARM_THM_CALL:
 		case R_ARM_THM_JUMP24:
+			/*
+			 * For function symbols, only Thumb addresses are
+			 * allowed (no interworking).
+			 *
+			 * For non-function symbols, the destination
+			 * has no specific ARM/Thumb disposition, so
+			 * the branch is resolved under the assumption
+			 * that interworking is not required.
+			 */
+			if (ELF32_ST_TYPE(sym->st_info) == STT_FUNC &&
+			    !(sym->st_value & 1)) {
+				pr_err("%s: section %u reloc %u sym '%s': unsupported interworking call (Thumb -> ARM)\n",
+				       module->name, relindex, i, symname);
+				return -ENOEXEC;
+			}
+
 			upper = __mem_to_opcode_thumb16(*(u16 *)loc);
 			lower = __mem_to_opcode_thumb16(*(u16 *)(loc + 2));
 
@@ -182,18 +203,7 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
 				offset -= 0x02000000;
 			offset += sym->st_value - loc;
 
-			/*
-			 * For function symbols, only Thumb addresses are
-			 * allowed (no interworking).
-			 *
-			 * For non-function symbols, the destination
-			 * has no specific ARM/Thumb disposition, so
-			 * the branch is resolved under the assumption
-			 * that interworking is not required.
-			 */
-			if ((ELF32_ST_TYPE(sym->st_info) == STT_FUNC &&
-				!(offset & 1)) ||
-			    offset <= (s32)0xff000000 ||
+			if (offset <= (s32)0xff000000 ||
 			    offset >= (s32)0x01000000) {
 				pr_err("%s: section %u reloc %u sym '%s': relocation %u out of range (%#lx -> %#x)\n",
 				       module->name, relindex, i, symname,
-- 
1.8.3.2
