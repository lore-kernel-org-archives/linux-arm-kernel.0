From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 16 Aug 2016 17:51:46 +0200
Subject: [PATCH 2/2] ARM: kernel: allocate PLT entries only for external
 symbols
In-Reply-To: <1471362706-29859-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1471362706-29859-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1471362706-29859-3-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When CONFIG_ARM_MODULE_PLTS is enabled, jump and call instructions in
modules no longer need to be within 16 MB (8 MB for Thumb2) of their
targets. If they are further away, a PLT entry will be generated on the
fly for each of them, which extends the range to the entire 32-bit
address space.

However, since these PLT entries will become the branch targets of the
original jump and call instructions, the PLT itself needs to be in
range, or we end up in the same situation we started in. Since the PLT
is in a separate section, this essentially means that all jumps and calls
inside the same module must be resolvable without PLT entries.

The PLT allocation code executes before the module itself is loaded in
its final location, and so it has to use a worst-case estimate for
which jumps and calls will require an entry in the PLT at relocation
time. As an optimization, this code deduplicates entries pointing to
the same symbol, using a O(n^2) algorithm. However, it does not take
the above into account, i.e., that PLT entries will only be needed for
jump and call relocations against symbols that are not defined in the
module.

So disregard relocations against symbols that are defined in the module
itself.

As an additional minor optimization, ignore input sections that lack
the SHF_EXECINSTR flag. Since jump and call relocations operate on
executable instructions only, there is no need to look in sections that
do not contain executable code.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/kernel/module-plts.c | 32 +++++++++++++++++---
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/module-plts.c b/arch/arm/kernel/module-plts.c
index 6832d1d6444e..59d2fcaff7d2 100644
--- a/arch/arm/kernel/module-plts.c
+++ b/arch/arm/kernel/module-plts.c
@@ -88,7 +88,8 @@ static int duplicate_rel(Elf32_Addr base, const Elf32_Rel *rel, int num,
 }
 
 /* Count how many PLT entries we may need */
-static unsigned int count_plts(Elf32_Addr base, const Elf32_Rel *rel, int num)
+static unsigned int count_plts(const Elf32_Sym *syms, Elf32_Addr base,
+			       const Elf32_Rel *rel, int num)
 {
 	unsigned int ret = 0;
 	int i;
@@ -97,7 +98,17 @@ static unsigned int count_plts(Elf32_Addr base, const Elf32_Rel *rel, int num)
 	 * Sure, this is order(n^2), but it's usually short, and not
 	 * time critical
 	 */
-	for (i = 0; i < num; i++)
+	for (i = 0; i < num; i++) {
+		/*
+		 * We only have to consider branch targets that resolve
+		 * to undefined symbols. This is not simply a heuristic,
+		 * it is a fundamental limitation, since the PLT itself
+		 * is part of the module, and needs to be within range
+		 * as well, so modules can never grow beyond that limit.
+		 */
+		if (syms[ELF32_R_SYM(rel[i].r_info)].st_shndx != SHN_UNDEF)
+			continue;
+
 		switch (ELF32_R_TYPE(rel[i].r_info)) {
 		case R_ARM_CALL:
 		case R_ARM_PC24:
@@ -114,6 +125,7 @@ static unsigned int count_plts(Elf32_Addr base, const Elf32_Rel *rel, int num)
 				ret++;
 #endif
 		}
+	}
 	return ret;
 }
 
@@ -122,19 +134,27 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 {
 	unsigned long plts = 0;
 	Elf32_Shdr *s, *sechdrs_end = sechdrs + ehdr->e_shnum;
+	Elf32_Sym *syms = NULL;
 
 	/*
 	 * To store the PLTs, we expand the .text section for core module code
 	 * and for initialization code.
 	 */
-	for (s = sechdrs; s < sechdrs_end; ++s)
+	for (s = sechdrs; s < sechdrs_end; ++s) {
 		if (strcmp(".plt", secstrings + s->sh_name) == 0)
 			mod->arch.plt = s;
+		else if (s->sh_type == SHT_SYMTAB)
+			syms = (Elf32_Sym *)s->sh_addr;
+	}
 
 	if (!mod->arch.plt) {
 		pr_err("%s: module PLT section missing\n", mod->name);
 		return -ENOEXEC;
 	}
+	if (!syms) {
+		pr_err("%s: module symtab section missing\n", mod->name);
+		return -ENOEXEC;
+	}
 
 	for (s = sechdrs + 1; s < sechdrs_end; ++s) {
 		const Elf32_Rel *rels = (void *)ehdr + s->sh_offset;
@@ -144,7 +164,11 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 		if (s->sh_type != SHT_REL)
 			continue;
 
-		plts += count_plts(dstsec->sh_addr, rels, numrels);
+		/* ignore relocations that operate on non-exec sections */
+		if (!(dstsec->sh_flags & SHF_EXECINSTR))
+			continue;
+
+		plts += count_plts(syms, dstsec->sh_addr, rels, numrels);
 	}
 
 	mod->arch.plt->sh_type = SHT_NOBITS;
-- 
2.7.4
