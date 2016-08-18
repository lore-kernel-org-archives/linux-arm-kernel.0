From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 18 Aug 2016 12:02:42 +0200
Subject: [PATCH v3 3/4] ARM: kernel: sort relocation sections before
 allocating PLTs
In-Reply-To: <1471514563-28172-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1471514563-28172-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1471514563-28172-4-git-send-email-ard.biesheuvel@linaro.org>
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
 arch/arm/kernel/module-plts.c | 93 ++++++++++++++------
 1 file changed, 64 insertions(+), 29 deletions(-)

diff --git a/arch/arm/kernel/module-plts.c b/arch/arm/kernel/module-plts.c
index 59255d8c9510..5b000ea64fa4 100644
--- a/arch/arm/kernel/module-plts.c
+++ b/arch/arm/kernel/module-plts.c
@@ -9,6 +9,7 @@
 #include <linux/elf.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/sort.h>
 
 #include <asm/cache.h>
 #include <asm/opcodes.h>
@@ -63,28 +64,54 @@ u32 get_module_plt(struct module *mod, unsigned long loc, Elf32_Addr val)
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
+static bool is_zero_addend_relocation(u32 *tval)
+{
+	/*
+	 * Do a bitwise compare on the raw addend rather than fully decoding
+	 * the offset and doing an arithmetic comparison.
+	 * Note that a zero-addend jump/call relocation is encoded taking the
+	 * PC bias into account, i.e., -8 for ARM and -4 for Thumb2.
+	 */
+	if (IS_ENABLED(CONFIG_THUMB2_KERNEL)) {
+		u16 upper, lower;
+
+		upper = __mem_to_opcode_thumb16(((u16 *)tval)[0]);
+		lower = __mem_to_opcode_thumb16(((u16 *)tval)[1]);
+
+		return (upper & 0x7ff) == 0x7ff && (lower & 0x2fff) == 0x2ffe;
 	}
-	return 0;
+	return (__mem_to_opcode_arm(*tval) & 0xffffff) == 0xfffffe;
+}
+
+static bool duplicate_rel(Elf32_Addr base, const Elf32_Rel *rel, int num)
+{
+	const Elf32_Rel *prev;
+
+	/*
+	 * Entries are sorted by type and symbol index. That means that,
+	 * if a duplicate entry exists, it must be in the preceding
+	 * slot.
+	 */
+	if (!num)
+		return false;
+
+	prev = rel + num - 1;
+	return cmp_rel(rel + num, prev) == 0 &&
+	       is_zero_addend_relocation((u32 *)(base + prev->r_offset));
 }
 
 /* Count how many PLT entries we may need */
@@ -93,20 +120,12 @@ static unsigned int count_plts(const Elf32_Sym *syms, Elf32_Addr base,
 {
 	unsigned int ret = 0;
 	const Elf32_Sym *s;
-	u32 mask;
 	int i;
 
-	if (IS_ENABLED(CONFIG_THUMB2_KERNEL))
-		mask = __opcode_to_mem_thumb32(0x07ff2fff);
-	else
-		mask = __opcode_to_mem_arm(0x00ffffff);
-
-	/*
-	 * Sure, this is order(n^2), but it's usually short, and not
-	 * time critical
-	 */
 	for (i = 0; i < num; i++) {
 		switch (ELF32_R_TYPE(rel[i].r_info)) {
+			u32 *tval;
+
 		case R_ARM_THM_CALL:
 		case R_ARM_THM_JUMP24:
 			BUG_ON(!IS_ENABLED(CONFIG_THUMB2_KERNEL));
@@ -125,7 +144,20 @@ static unsigned int count_plts(const Elf32_Sym *syms, Elf32_Addr base,
 			if (s->st_shndx != SHN_UNDEF)
 				break;
 
-			if (!duplicate_rel(base, rel, i, mask))
+			/*
+			 * Jump relocations with non-zero addends against
+			 * undefined symbols are supported by the ELF spec, but
+			 * do not occur in practice (e.g., 'jump n bytes past
+			 * the entry point of undefined function symbol f').
+			 * So we need to support them, but there is no need to
+			 * take them into consideration when trying to optimize
+			 * this code. So let's only check for duplicates when
+			 * the addend is zero.
+			 */
+			tval = (u32 *)(base + rel[i].r_offset);
+
+			if (!is_zero_addend_relocation(tval) ||
+			    !duplicate_rel(base, rel, i))
 				ret++;
 		}
 	}
@@ -160,7 +192,7 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 	}
 
 	for (s = sechdrs + 1; s < sechdrs_end; ++s) {
-		const Elf32_Rel *rels = (void *)ehdr + s->sh_offset;
+		Elf32_Rel *rels = (void *)ehdr + s->sh_offset;
 		int numrels = s->sh_size / sizeof(Elf32_Rel);
 		Elf32_Shdr *dstsec = sechdrs + s->sh_info;
 
@@ -171,6 +203,9 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 		if (!(dstsec->sh_flags & SHF_EXECINSTR))
 			continue;
 
+		/* sort by type and symbol index */
+		sort(rels, numrels, sizeof(Elf32_Rel), cmp_rel, NULL);
+
 		plts += count_plts(syms, dstsec->sh_addr, rels, numrels);
 	}
 
-- 
2.7.4
