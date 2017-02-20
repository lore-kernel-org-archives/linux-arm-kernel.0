From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 20 Feb 2017 22:00:41 +0000
Subject: [RFT PATCH 2/2] arm64: module: split core and init PLT sections
In-Reply-To: <1487628041-2147-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1487628041-2147-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1487628041-2147-3-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The arm64 module PLT code allocates all PLT entries in a single core
section, since the overhead of having a separate init PLT section is
not justified by the small number of PLT entries usually required for
init code.

However, the core and init module regions are allocated independently,
and there is a corner case where the core region may be allocated from
the VMALLOC region if the dedicated module region is exhausted, but the
init region, being much smaller, can still be allocated from the module
region. This leads to relocation failures if the distance between those
regions exceeds 128 MB. (In fact, this corner case is highly unlikely to
occur on arm64, but the issue has been observed on ARM, whose module
region is much smaller).

So split the core and init PLT regions, and name the latter ".init.plt"
so it gets allocated along with (and sufficiently close to) the .init
sections that it serves.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/module.h |  9 +++-
 arch/arm64/kernel/module-plts.c | 56 ++++++++++++++------
 arch/arm64/kernel/module.c      |  2 +-
 arch/arm64/kernel/module.lds    |  1 +
 4 files changed, 48 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/include/asm/module.h b/arch/arm64/include/asm/module.h
index 06ff7fd9e81f..b6c6fa29fe56 100644
--- a/arch/arm64/include/asm/module.h
+++ b/arch/arm64/include/asm/module.h
@@ -22,14 +22,19 @@
 #define MODULE_ARCH_VERMAGIC	"aarch64"
 
 #ifdef CONFIG_ARM64_MODULE_PLTS
-struct mod_arch_specific {
+struct mod_plt_sec {
 	struct elf64_shdr	*plt;
 	int			plt_num_entries;
 	int			plt_max_entries;
 };
+
+struct mod_arch_specific {
+	struct mod_plt_sec	core;
+	struct mod_plt_sec	init;
+};
 #endif
 
-u64 module_emit_plt_entry(struct module *mod, const Elf64_Rela *rela,
+u64 module_emit_plt_entry(struct module *mod, void *loc, const Elf64_Rela *rela,
 			  Elf64_Sym *sym);
 
 #ifdef CONFIG_RANDOMIZE_BASE
diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
index 1ce90d8450ae..0d396ffd3d08 100644
--- a/arch/arm64/kernel/module-plts.c
+++ b/arch/arm64/kernel/module-plts.c
@@ -26,11 +26,19 @@ struct plt_entry {
 	__le32	br;	/* br	x16				*/
 };
 
-u64 module_emit_plt_entry(struct module *mod, const Elf64_Rela *rela,
+static bool in_init(const struct module *mod, void *loc)
+{
+	return (u64)loc - (u64)mod->init_layout.base < mod->init_layout.size;
+}
+
+u64 module_emit_plt_entry(struct module *mod, void *loc, const Elf64_Rela *rela,
 			  Elf64_Sym *sym)
 {
-	struct plt_entry *plt = (struct plt_entry *)mod->arch.plt->sh_addr;
-	int i = mod->arch.plt_num_entries;
+	struct mod_plt_sec *pltsec = !in_init(mod, loc) ? &mod->arch.core :
+							  &mod->arch.init;
+
+	struct plt_entry *plt = (struct plt_entry *)pltsec->plt->sh_addr;
+	int i = pltsec->plt_num_entries;
 	u64 val = sym->st_value + rela->r_addend;
 
 	/*
@@ -51,8 +59,8 @@ u64 module_emit_plt_entry(struct module *mod, const Elf64_Rela *rela,
 		return sym->st_size;
 	}
 
-	mod->arch.plt_num_entries++;
-	BUG_ON(mod->arch.plt_num_entries > mod->arch.plt_max_entries);
+	pltsec->plt_num_entries++;
+	BUG_ON(pltsec->plt_num_entries > pltsec->plt_max_entries);
 
 	/*
 	 * MOVK/MOVN/MOVZ opcode:
@@ -149,7 +157,8 @@ static unsigned int count_plts(Elf64_Sym *syms, Elf64_Rela *rela, int num)
 int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 			      char *secstrings, struct module *mod)
 {
-	unsigned long plt_max_entries = 0;
+	unsigned long plt_max_core = 0;
+	unsigned long plt_max_init = 0;
 	Elf64_Sym *syms = NULL;
 	int i;
 
@@ -158,14 +167,16 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 	 * entries. Record the symtab address as well.
 	 */
 	for (i = 0; i < ehdr->e_shnum; i++) {
-		if (strcmp(".plt", secstrings + sechdrs[i].sh_name) == 0)
-			mod->arch.plt = sechdrs + i;
+		if (!strcmp(secstrings + sechdrs[i].sh_name, ".plt"))
+			mod->arch.core.plt = sechdrs + i;
+		else if (!strcmp(secstrings + sechdrs[i].sh_name, ".init.plt"))
+			mod->arch.init.plt = sechdrs + i;
 		else if (sechdrs[i].sh_type == SHT_SYMTAB)
 			syms = (Elf64_Sym *)sechdrs[i].sh_addr;
 	}
 
-	if (!mod->arch.plt) {
-		pr_err("%s: module PLT section missing\n", mod->name);
+	if (!mod->arch.core.plt || !mod->arch.init.plt) {
+		pr_err("%s: module PLT section(s) missing\n", mod->name);
 		return -ENOEXEC;
 	}
 	if (!syms) {
@@ -188,14 +199,25 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 		/* sort by type, symbol index and addend */
 		sort(rels, numrels, sizeof(Elf64_Rela), cmp_rela, NULL);
 
-		plt_max_entries += count_plts(syms, rels, numrels);
+		if (strncmp(secstrings + dstsec->sh_name, ".init", 5) != 0)
+			plt_max_core += count_plts(syms, rels, numrels);
+		else
+			plt_max_init += count_plts(syms, rels, numrels);
 	}
 
-	mod->arch.plt->sh_type = SHT_NOBITS;
-	mod->arch.plt->sh_flags = SHF_EXECINSTR | SHF_ALLOC;
-	mod->arch.plt->sh_addralign = L1_CACHE_BYTES;
-	mod->arch.plt->sh_size = plt_max_entries * sizeof(struct plt_entry);
-	mod->arch.plt_num_entries = 0;
-	mod->arch.plt_max_entries = plt_max_entries;
+	mod->arch.core.plt->sh_type = SHT_NOBITS;
+	mod->arch.core.plt->sh_flags = SHF_EXECINSTR | SHF_ALLOC;
+	mod->arch.core.plt->sh_addralign = L1_CACHE_BYTES;
+	mod->arch.core.plt->sh_size = plt_max_core * sizeof(struct plt_entry);
+	mod->arch.core.plt_num_entries = 0;
+	mod->arch.core.plt_max_entries = plt_max_core;
+
+	mod->arch.init.plt->sh_type = SHT_NOBITS;
+	mod->arch.init.plt->sh_flags = SHF_EXECINSTR | SHF_ALLOC;
+	mod->arch.init.plt->sh_addralign = L1_CACHE_BYTES;
+	mod->arch.init.plt->sh_size = plt_max_init * sizeof(struct plt_entry);
+	mod->arch.init.plt_num_entries = 0;
+	mod->arch.init.plt_max_entries = plt_max_init;
+
 	return 0;
 }
diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
index 7f316982ce00..c9a2ab446dc6 100644
--- a/arch/arm64/kernel/module.c
+++ b/arch/arm64/kernel/module.c
@@ -380,7 +380,7 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 
 			if (IS_ENABLED(CONFIG_ARM64_MODULE_PLTS) &&
 			    ovf == -ERANGE) {
-				val = module_emit_plt_entry(me, &rel[i], sym);
+				val = module_emit_plt_entry(me, loc, &rel[i], sym);
 				ovf = reloc_insn_imm(RELOC_OP_PREL, loc, val, 2,
 						     26, AARCH64_INSN_IMM_26);
 			}
diff --git a/arch/arm64/kernel/module.lds b/arch/arm64/kernel/module.lds
index 8949f6c6f729..f7c9781a9d48 100644
--- a/arch/arm64/kernel/module.lds
+++ b/arch/arm64/kernel/module.lds
@@ -1,3 +1,4 @@
 SECTIONS {
 	.plt (NOLOAD) : { BYTE(0) }
+	.init.plt (NOLOAD) : { BYTE(0) }
 }
-- 
2.7.4
