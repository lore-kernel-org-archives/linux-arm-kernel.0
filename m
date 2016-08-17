From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 17 Aug 2016 13:59:36 +0200
Subject: [PATCH v2 3/3] ARM: kernel: sort relocation sections before
 allocating PLTs
In-Reply-To: <1471435176-13146-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1471435176-13146-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1471435176-13146-4-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PLT allocation routines try to establish an upper bound on the
number of PLT entries that will be required at relocation time, and
optimize this by disregarding duplicates (i.e., PLT entries that will
end up pointing to the same function). This is currently a O(n^2)
algorithm, but we can greatly simplify this by
- sorting the relocation section so that relocations that can use the
  same PLT entry will be listed adjacently,
- disregard jump/call relocations with addends; these are highly unusual,
  for relocations against SHN_UNDEF symbols, and so we can simply allocate
  a PLT entry for each one we encounter, without trying to optimize away
  duplicates.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/kernel/module-plts.c | 108 ++++++++++++++------
 1 file changed, 79 insertions(+), 29 deletions(-)

diff --git a/arch/arm/kernel/module-plts.c b/arch/arm/kernel/module-plts.c
index 59d2fcaff7d2..7221d888b138 100644
--- a/arch/arm/kernel/module-plts.c
+++ b/arch/arm/kernel/module-plts.c
@@ -9,6 +9,7 @@
 #include <linux/elf.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/sort.h>
 
 #include <asm/cache.h>
 #include <asm/opcodes.h>
@@ -63,28 +64,28 @@ u32 get_module_plt(struct module *mod, unsigned long loc, Elf32_Addr val)
 	BUG();
 }
 
-static int duplicate_rel(Elf32_Addr base, const Elf32_Rel *rel, int num,
-			   u32 mask)
+#define cmp_3way(a,b)	((a) < (b) ? -1 : (a) > (b))
+
+static int cmp_rel(const void *a, const void *b)
 {
-	u32 *loc1, *loc2;
+	const Elf32_Rel *x = a, *y = b;
 	int i;
 
-	for (i = 0; i < num; i++) {
-		if (rel[i].r_info != rel[num].r_info)
-			continue;
+	/* sort by type and symbol index */
+	i = cmp_3way(ELF32_R_TYPE(x->r_info), ELF32_R_TYPE(y->r_info));
+	if (i == 0)
+		i = cmp_3way(ELF32_R_SYM(x->r_info), ELF32_R_SYM(y->r_info));
+	return i;
+}
 
-		/*
-		 * Identical relocation types against identical symbols can
-		 * still result in different PLT entries if the addend in the
-		 * place is different. So resolve the target of the relocation
-		 * to compare the values.
-		 */
-		loc1 = (u32 *)(base + rel[i].r_offset);
-		loc2 = (u32 *)(base + rel[num].r_offset);
-		if (((*loc1 ^ *loc2) & mask) == 0)
-			return 1;
-	}
-	return 0;
+static int duplicate_rel(Elf32_Addr base, const Elf32_Rel *rel, int num)
+{
+	/*
+	 * Entries are sorted by type and symbol index. That means that,
+	 * if a duplicate entry exists, it must be in the preceding
+	 * slot.
+	 */
+	return num > 0 && cmp_rel(rel + num, rel + num - 1) == 0;
 }
 
 /* Count how many PLT entries we may need */
@@ -94,11 +95,11 @@ static unsigned int count_plts(const Elf32_Sym *syms, Elf32_Addr base,
 	unsigned int ret = 0;
 	int i;
 
-	/*
-	 * Sure, this is order(n^2), but it's usually short, and not
-	 * time critical
-	 */
 	for (i = 0; i < num; i++) {
+		u32 *tval;
+		s32 offset;
+		u32 upper, lower, sign, j1, j2;
+
 		/*
 		 * We only have to consider branch targets that resolve
 		 * to undefined symbols. This is not simply a heuristic,
@@ -109,21 +110,67 @@ static unsigned int count_plts(const Elf32_Sym *syms, Elf32_Addr base,
 		if (syms[ELF32_R_SYM(rel[i].r_info)].st_shndx != SHN_UNDEF)
 			continue;
 
+		/*
+		 * Jump relocations with non-zero addends against
+		 * undefined symbols are supported by the ELF spec, but
+		 * do not occur in practice (e.g., 'jump n bytes past
+		 * the entry point of undefined function symbol f').
+		 * So we need to support them, but there is no need to
+		 * take them into consideration when trying to optimize
+		 * this code. So let's only check for duplicates when
+		 * the addend is zero.
+		 * Note that a zero-addend jump/call relocation is encoded
+		 * taking the PC bias into account, i.e., -8 for ARM and
+		 * -4 for Thumb2.
+		 */
+		tval = (u32 *)(base + rel[i].r_offset);
+
 		switch (ELF32_R_TYPE(rel[i].r_info)) {
 		case R_ARM_CALL:
 		case R_ARM_PC24:
 		case R_ARM_JUMP24:
-			if (!duplicate_rel(base, rel, i,
-					   __opcode_to_mem_arm(0x00ffffff)))
+			offset = (__mem_to_opcode_arm(*tval) & 0x00ffffff) << 2;
+			if (offset & 0x02000000)
+				offset -= 0x04000000;
+			if (offset != -8 ||
+			    !duplicate_rel(base, rel, i))
 				ret++;
 			break;
-#ifdef CONFIG_THUMB2_KERNEL
+
 		case R_ARM_THM_CALL:
 		case R_ARM_THM_JUMP24:
-			if (!duplicate_rel(base, rel, i,
-					   __opcode_to_mem_thumb32(0x07ff2fff)))
+			BUG_ON(!IS_ENABLED(CONFIG_THUMB2_KERNEL));
+
+			upper = __mem_to_opcode_thumb16(((u16 *)tval)[0]);
+			lower = __mem_to_opcode_thumb16(((u16 *)tval)[1]);
+
+			/*
+			 * 25 bit signed address range (Thumb-2 BL and
+			 * B.W instructions):
+			 *   S:I1:I2:imm10:imm11:0
+			 * where:
+			 *   S     = upper[10]   = offset[24]
+			 *   I1    = ~(J1 ^ S)   = offset[23]
+			 *   I2    = ~(J2 ^ S)   = offset[22]
+			 *   imm10 = upper[9:0]  = offset[21:12]
+			 *   imm11 = lower[10:0] = offset[11:1]
+			 *   J1    = lower[13]
+			 *   J2    = lower[11]
+			 */
+			sign = (upper >> 10) & 1;
+			j1 = (lower >> 13) & 1;
+			j2 = (lower >> 11) & 1;
+			offset = (sign << 24) |
+				 ((~(j1 ^ sign) & 1) << 23) |
+				 ((~(j2 ^ sign) & 1) << 22) |
+				 ((upper & 0x03ff) << 12) |
+				 ((lower & 0x07ff) << 1);
+			if (offset & 0x01000000)
+				offset -= 0x02000000;
+
+			if (offset != -4 ||
+			    !duplicate_rel(base, rel, i))
 				ret++;
-#endif
 		}
 	}
 	return ret;
@@ -157,7 +204,7 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 	}
 
 	for (s = sechdrs + 1; s < sechdrs_end; ++s) {
-		const Elf32_Rel *rels = (void *)ehdr + s->sh_offset;
+		Elf32_Rel *rels = (void *)ehdr + s->sh_offset;
 		int numrels = s->sh_size / sizeof(Elf32_Rel);
 		Elf32_Shdr *dstsec = sechdrs + s->sh_info;
 
@@ -168,6 +215,9 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 		if (!(dstsec->sh_flags & SHF_EXECINSTR))
 			continue;
 
+		/* sort by type and symbol index */
+		sort(rels, numrels, sizeof(Elf32_Rel), cmp_rel, NULL);
+
 		plts += count_plts(syms, dstsec->sh_addr, rels, numrels);
 	}
 
-- 
2.7.4
