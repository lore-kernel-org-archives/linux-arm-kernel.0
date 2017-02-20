From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 20 Feb 2017 22:00:40 +0000
Subject: [RFT PATCH 1/2] ARM: module: split core and init PLT sections
In-Reply-To: <1487628041-2147-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1487628041-2147-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1487628041-2147-2-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit 35fa91eed817 ("ARM: kernel: merge core and init PLTs"),
the ARM module PLT code allocates all PLT entries in a single core
section, since the overhead of having a separate init PLT section is
not justified by the small number of PLT entries usually required for
init code.

However, the core and init module regions are allocated independently,
and there is a corner case where the core region may be allocated from
the VMALLOC region if the dedicated module region is exhausted, but the
init region, being much smaller, can still be allocated from the module
region. This puts the PLT entries out of reach of the relocated branch
instructions, defeating the whole purpose of PLTs.

So split the core and init PLT regions, and name the latter ".init.plt"
so it gets allocated along with (and sufficiently close to) the .init
sections that it serves. This is not a straight revert, given that the
PLT code was heavily modified since the commit in question was merged.

Fixes: 35fa91eed817 ("ARM: kernel: merge core and init PLTs")
Reported-by: Angus Clark <angus@angusclark.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/include/asm/module.h |  9 ++-
 arch/arm/kernel/module-plts.c | 62 ++++++++++++++------
 arch/arm/kernel/module.lds    |  1 +
 3 files changed, 51 insertions(+), 21 deletions(-)

diff --git a/arch/arm/include/asm/module.h b/arch/arm/include/asm/module.h
index 464748b9fd7d..ed2319663a1e 100644
--- a/arch/arm/include/asm/module.h
+++ b/arch/arm/include/asm/module.h
@@ -18,13 +18,18 @@ enum {
 };
 #endif
 
+struct mod_plt_sec {
+	struct elf32_shdr	*plt;
+	int			plt_count;
+};
+
 struct mod_arch_specific {
 #ifdef CONFIG_ARM_UNWIND
 	struct unwind_table *unwind[ARM_SEC_MAX];
 #endif
 #ifdef CONFIG_ARM_MODULE_PLTS
-	struct elf32_shdr   *plt;
-	int		    plt_count;
+	struct mod_plt_sec	core;
+	struct mod_plt_sec	init;
 #endif
 };
 
diff --git a/arch/arm/kernel/module-plts.c b/arch/arm/kernel/module-plts.c
index 3a5cba90c971..1a79f2789325 100644
--- a/arch/arm/kernel/module-plts.c
+++ b/arch/arm/kernel/module-plts.c
@@ -31,9 +31,17 @@ struct plt_entries {
 	u32	lit[PLT_ENT_COUNT];
 };
 
+static bool in_init(const struct module *mod, void *loc)
+{
+	return (u32)loc - (u32)mod->init_layout.base < mod->init_layout.size;
+}
+
 u32 get_module_plt(struct module *mod, unsigned long loc, Elf32_Addr val)
 {
-	struct plt_entries *plt = (struct plt_entries *)mod->arch.plt->sh_addr;
+	struct mod_plt_sec *pltsec = !in_init(mod, loc) ? &mod->arch.core :
+							  &mod->arch.init;
+
+	struct plt_entries *plt = (struct plt_entries *)pltsec->plt->sh_addr;
 	int idx = 0;
 
 	/*
@@ -41,9 +49,9 @@ u32 get_module_plt(struct module *mod, unsigned long loc, Elf32_Addr val)
 	 * relocations are sorted, this will be the last entry we allocated.
 	 * (if one exists).
 	 */
-	if (mod->arch.plt_count > 0) {
-		plt += (mod->arch.plt_count - 1) / PLT_ENT_COUNT;
-		idx = (mod->arch.plt_count - 1) % PLT_ENT_COUNT;
+	if (pltsec->plt_count > 0) {
+		plt += (pltsec->plt_count - 1) / PLT_ENT_COUNT;
+		idx = (pltsec->plt_count - 1) % PLT_ENT_COUNT;
 
 		if (plt->lit[idx] == val)
 			return (u32)&plt->ldr[idx];
@@ -53,8 +61,8 @@ u32 get_module_plt(struct module *mod, unsigned long loc, Elf32_Addr val)
 			plt++;
 	}
 
-	mod->arch.plt_count++;
-	BUG_ON(mod->arch.plt_count * PLT_ENT_SIZE > mod->arch.plt->sh_size);
+	pltsec->plt_count++;
+	BUG_ON(pltsec->plt_count * PLT_ENT_SIZE > pltsec->plt->sh_size);
 
 	if (!idx)
 		/* Populate a new set of entries */
@@ -174,7 +182,8 @@ static unsigned int count_plts(const Elf32_Sym *syms, Elf32_Addr base,
 int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 			      char *secstrings, struct module *mod)
 {
-	unsigned long plts = 0;
+	unsigned long core_plts = 0;
+	unsigned long init_plts = 0;
 	Elf32_Shdr *s, *sechdrs_end = sechdrs + ehdr->e_shnum;
 	Elf32_Sym *syms = NULL;
 
@@ -184,13 +193,15 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 	 */
 	for (s = sechdrs; s < sechdrs_end; ++s) {
 		if (strcmp(".plt", secstrings + s->sh_name) == 0)
-			mod->arch.plt = s;
+			mod->arch.core.plt = s;
+		else if (strcmp(".init.plt", secstrings + s->sh_name) == 0)
+			mod->arch.init.plt = s;
 		else if (s->sh_type == SHT_SYMTAB)
 			syms = (Elf32_Sym *)s->sh_addr;
 	}
 
-	if (!mod->arch.plt) {
-		pr_err("%s: module PLT section missing\n", mod->name);
+	if (!mod->arch.core.plt || !mod->arch.init.plt) {
+		pr_err("%s: module PLT section(s) missing\n", mod->name);
 		return -ENOEXEC;
 	}
 	if (!syms) {
@@ -213,16 +224,29 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 		/* sort by type and symbol index */
 		sort(rels, numrels, sizeof(Elf32_Rel), cmp_rel, NULL);
 
-		plts += count_plts(syms, dstsec->sh_addr, rels, numrels);
+		if (strncmp(secstrings + dstsec->sh_name, ".init", 5) != 0)
+			core_plts += count_plts(syms, dstsec->sh_addr, rels,
+						numrels);
+		else
+			init_plts += count_plts(syms, dstsec->sh_addr, rels,
+						numrels);
 	}
 
-	mod->arch.plt->sh_type = SHT_NOBITS;
-	mod->arch.plt->sh_flags = SHF_EXECINSTR | SHF_ALLOC;
-	mod->arch.plt->sh_addralign = L1_CACHE_BYTES;
-	mod->arch.plt->sh_size = round_up(plts * PLT_ENT_SIZE,
-					  sizeof(struct plt_entries));
-	mod->arch.plt_count = 0;
-
-	pr_debug("%s: plt=%x\n", __func__, mod->arch.plt->sh_size);
+	mod->arch.core.plt->sh_type = SHT_NOBITS;
+	mod->arch.core.plt->sh_flags = SHF_EXECINSTR | SHF_ALLOC;
+	mod->arch.core.plt->sh_addralign = L1_CACHE_BYTES;
+	mod->arch.core.plt->sh_size = round_up(core_plts * PLT_ENT_SIZE,
+					       sizeof(struct plt_entries));
+	mod->arch.core.plt_count = 0;
+
+	mod->arch.init.plt->sh_type = SHT_NOBITS;
+	mod->arch.init.plt->sh_flags = SHF_EXECINSTR | SHF_ALLOC;
+	mod->arch.init.plt->sh_addralign = L1_CACHE_BYTES;
+	mod->arch.init.plt->sh_size = round_up(init_plts * PLT_ENT_SIZE,
+					       sizeof(struct plt_entries));
+	mod->arch.init.plt_count = 0;
+
+	pr_debug("%s: plt=%x, init.plt=%x\n", __func__,
+		 mod->arch.core.plt->sh_size, mod->arch.init.plt->sh_size);
 	return 0;
 }
diff --git a/arch/arm/kernel/module.lds b/arch/arm/kernel/module.lds
index 05881e2b414c..eacb5c67f61e 100644
--- a/arch/arm/kernel/module.lds
+++ b/arch/arm/kernel/module.lds
@@ -1,3 +1,4 @@
 SECTIONS {
 	.plt : { BYTE(0) }
+	.init.plt : { BYTE(0) }
 }
-- 
2.7.4
