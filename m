From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sat, 20 Aug 2016 09:45:31 +0200
Subject: [PATCH 2/2] ARM: add interworking support to Thumb-2 kernel
In-Reply-To: <1471679131-3570-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1471679131-3570-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1471679131-3570-3-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM/Thumb interworking is currently not allowed in modules at all:
external module dependencies can only be fulfilled by symbols of the
same flavour, but even inside a module, jump and call relocations
between objects are rejected if they would incur a mode switch.

This patch relaxes that restriction, by allowing function calls ('bl')
from T32 into A32 code, and vice versa, by fixing up the bl instruction
to a blx instruction, with the appropriate rounding applied to the offset.

For jump ('b') instructions, this is not possible (the ISA does not
provide jump instructions that switch mode) and so a PLT entry emitted
instead, which is inherently interworking-aware since it uses a
'ldr pc, =xxx' instruction. Since this requires module PLT support,
add the 'select ARM_MODULE_PLTS ' to config THUMB2_KERNEL.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/Kconfig              |  1 +
 arch/arm/include/asm/module.h |  3 +-
 arch/arm/kernel/module-plts.c | 21 +++++---
 arch/arm/kernel/module.c      | 55 +++++++++++++++-----
 4 files changed, 61 insertions(+), 19 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a9c4e48bb7ec..c786337f3c8b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1544,6 +1544,7 @@ config THUMB2_KERNEL
 	select AEABI
 	select ARM_ASM_UNIFIED
 	select ARM_UNWIND
+	select ARM_MODULE_PLTS
 	help
 	  By enabling this option, the kernel will be compiled in
 	  Thumb-2 mode. A compiler/assembler that understand the unified
diff --git a/arch/arm/include/asm/module.h b/arch/arm/include/asm/module.h
index 464748b9fd7d..82ba2a82f9a3 100644
--- a/arch/arm/include/asm/module.h
+++ b/arch/arm/include/asm/module.h
@@ -28,7 +28,8 @@ struct mod_arch_specific {
 #endif
 };
 
-u32 get_module_plt(struct module *mod, unsigned long loc, Elf32_Addr val);
+u32 get_module_plt(struct module *mod, unsigned long loc, Elf32_Addr val,
+		   bool from_thumb);
 
 /*
  * Add the ARM architecture version to the version magic string
diff --git a/arch/arm/kernel/module-plts.c b/arch/arm/kernel/module-plts.c
index a910f1db0c14..c239bc92f81b 100644
--- a/arch/arm/kernel/module-plts.c
+++ b/arch/arm/kernel/module-plts.c
@@ -18,12 +18,15 @@
 #define PLT_ENT_COUNT		(PLT_ENT_STRIDE / sizeof(u32))
 #define PLT_ENT_SIZE		(sizeof(struct plt_entries) / PLT_ENT_COUNT)
 
-#ifdef CONFIG_THUMB2_KERNEL
-#define PLT_ENT_LDR		__opcode_to_mem_thumb32(0xf8dff000 | \
+#define PLT_ENT_LDR_ARM		__opcode_to_mem_arm(0xe59ff000 | \
+						    (PLT_ENT_STRIDE - 8))
+#define PLT_ENT_LDR_THUMB	__opcode_to_mem_thumb32(0xf8dff000 | \
 							(PLT_ENT_STRIDE - 4))
+
+#ifdef CONFIG_THUMB2_KERNEL
+#define PLT_ENT_LDR		PLT_ENT_LDR_THUMB
 #else
-#define PLT_ENT_LDR		__opcode_to_mem_arm(0xe59ff000 | \
-						    (PLT_ENT_STRIDE - 8))
+#define PLT_ENT_LDR		PLT_ENT_LDR_ARM
 #endif
 
 struct plt_entries {
@@ -31,7 +34,8 @@ struct plt_entries {
 	u32	lit[PLT_ENT_COUNT];
 };
 
-u32 get_module_plt(struct module *mod, unsigned long loc, Elf32_Addr val)
+u32 get_module_plt(struct module *mod, unsigned long loc, Elf32_Addr val,
+		   bool from_thumb)
 {
 	struct plt_entries *plt = (struct plt_entries *)mod->arch.plt->sh_addr;
 	int idx = 0;
@@ -45,7 +49,10 @@ u32 get_module_plt(struct module *mod, unsigned long loc, Elf32_Addr val)
 		plt += (mod->arch.plt_count - 1) / PLT_ENT_COUNT;
 		idx = (mod->arch.plt_count - 1) % PLT_ENT_COUNT;
 
-		if (plt->lit[idx] == val)
+		if (plt->lit[idx] == val &&
+		    (!IS_ENABLED(CONFIG_THUMB2_KERNEL) ||
+		     plt->ldr[idx] == from_thumb ? PLT_ENT_LDR_THUMB :
+						   PLT_ENT_LDR_ARM))
 			return (u32)&plt->ldr[idx];
 
 		idx = (idx + 1) % PLT_ENT_COUNT;
@@ -65,6 +72,8 @@ u32 get_module_plt(struct module *mod, unsigned long loc, Elf32_Addr val)
 	else
 		plt->lit[idx] = val;
 
+	if (IS_ENABLED(CONFIG_THUMB2_KERNEL) && !from_thumb)
+		plt->ldr[idx] = PLT_ENT_LDR_ARM;
 	return (u32)&plt->ldr[idx];
 }
 
diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index 6c22b13cbd12..f6c4059d0006 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -103,7 +103,8 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
 		case R_ARM_PC24:
 		case R_ARM_CALL:
 		case R_ARM_JUMP24:
-			if (sym->st_value & 3) {
+			if (!IS_ENABLED(CONFIG_THUMB2_KERNEL) &&
+			    sym->st_value & 3) {
 				pr_err("%s: section %u reloc %u sym '%s': unsupported interworking call (ARM -> Thumb)\n",
 				       module->name, relindex, i, symname);
 				return -ENOEXEC;
@@ -121,12 +122,17 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
 			 * supported range. Note that 'offset + loc + 8'
 			 * contains the absolute jump target, i.e.,
 			 * @sym + addend, corrected for the +8 PC bias.
+			 * Also emit PLT entries for interworking jumps,
+			 * and for conditional interworking call instructions.
 			 */
 			if (IS_ENABLED(CONFIG_ARM_MODULE_PLTS) &&
 			    (offset <= (s32)0xfe000000 ||
-			     offset >= (s32)0x02000000))
+			     offset >= (s32)0x02000000 ||
+			     ((sym->st_value & 1) != 0 &&
+			      (ELF32_R_TYPE(rel->r_info) != R_ARM_CALL ||
+			       __mem_to_opcode_arm(*(u32 *)loc) >> 28 != 0xe))))
 				offset = get_module_plt(module, loc,
-							offset + loc + 8)
+							offset + loc + 8, false)
 					 - loc - 8;
 
 			if (offset <= (s32)0xfe000000 ||
@@ -138,11 +144,19 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
 				return -ENOEXEC;
 			}
 
+			if (offset & 1) {
+				/* convert bl instruction to blx */
+				tmp = 0xf0000000 | (offset & 2) << 23;
+				*(u32 *)loc &= __opcode_to_mem_arm(~BIT(24));
+				*(u32 *)loc |= __opcode_to_mem_arm(tmp);
+			}
+
 			offset >>= 2;
 			offset &= 0x00ffffff;
 
 			*(u32 *)loc &= __opcode_to_mem_arm(0xff000000);
 			*(u32 *)loc |= __opcode_to_mem_arm(offset);
+
 			break;
 
 	       case R_ARM_V4BX:
@@ -180,8 +194,9 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
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
@@ -197,9 +212,9 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
 			     (ELF32_ST_TYPE(sym->st_info) == STT_NOTYPE &&
 			      sym->st_shndx == SHN_UNDEF)) &&
 			    !(sym->st_value & 1)) {
-				pr_err("%s: section %u reloc %u sym '%s': unsupported interworking call (Thumb -> ARM)\n",
-				       module->name, relindex, i, symname);
-				return -ENOEXEC;
+				tmp = sym->st_value;
+			} else {
+				tmp = sym->st_value | 1;
 			}
 
 			upper = __mem_to_opcode_thumb16(*(u16 *)loc);
@@ -227,18 +242,34 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
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
-			 * supported range.
+			 * supported range. Also emit PLT entries for
+			 * interworking jump instructions.
 			 */
 			if (IS_ENABLED(CONFIG_ARM_MODULE_PLTS) &&
 			    (offset <= (s32)0xff000000 ||
-			     offset >= (s32)0x01000000))
+			     offset >= (s32)0x01000000 ||
+			     (ELF32_R_TYPE(rel->r_info) != R_ARM_THM_CALL &&
+			      !(sym->st_value & 1))))
 				offset = get_module_plt(module, loc,
-							offset + loc + 4)
+							offset + tmp + 4, true)
 					 - loc - 4;
+			else if (!(offset & 1))
+				/* fix up bl -> blx */
+				lower &= ~(1 << 12);
 
 			if (offset <= (s32)0xff000000 ||
 			    offset >= (s32)0x01000000) {
-- 
2.7.4
