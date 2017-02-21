From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 21 Feb 2017 22:12:57 +0000
Subject: [PATCH v2 2/2] arm64: module: split core and init PLT sections
In-Reply-To: <1487715177-30790-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1487715177-30790-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1487715177-30790-3-git-send-email-ard.biesheuvel@linaro.org>
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
sections that it serves. Also, given that init PLT entries may need to
be emitted for branches that target the core module, modify the logic
that disregards defined symbols to only disregard symbols that are
defined in the same section as the relocated branch instruction.

Since there may now be two PLT entries associated with each entry in
the symbol table, we can no longer hijack the symbol::st_size fields
to record the addresses of PLT entries as we emit them for zero-addend
relocations. So instead, perform an explicit comparison to check for
duplicate entries.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/module.h |   9 +-
 arch/arm64/kernel/module-plts.c | 108 ++++++++++++--------
 arch/arm64/kernel/module.c      |   2 +-
 arch/arm64/kernel/module.lds    |   1 +
 4 files changed, 72 insertions(+), 48 deletions(-)

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
index 1ce90d8450ae..d05dbe658409 100644
--- a/arch/arm64/kernel/module-plts.c
+++ b/arch/arm64/kernel/module-plts.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2014-2016 Linaro Ltd. <ard.biesheuvel@linaro.org>
+ * Copyright (C) 2014-2017 Linaro Ltd. <ard.biesheuvel@linaro.org>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -26,35 +26,21 @@ struct plt_entry {
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
+	struct plt_entry *plt = (struct plt_entry *)pltsec->plt->sh_addr;
+	int i = pltsec->plt_num_entries;
 	u64 val = sym->st_value + rela->r_addend;
 
 	/*
-	 * We only emit PLT entries against undefined (SHN_UNDEF) symbols,
-	 * which are listed in the ELF symtab section, but without a type
-	 * or a size.
-	 * So, similar to how the module loader uses the Elf64_Sym::st_value
-	 * field to store the resolved addresses of undefined symbols, let's
-	 * borrow the Elf64_Sym::st_size field (whose value is never used by
-	 * the module loader, even for symbols that are defined) to record
-	 * the address of a symbol's associated PLT entry as we emit it for a
-	 * zero addend relocation (which is the only kind we have to deal with
-	 * in practice). This allows us to find duplicates without having to
-	 * go through the table every time.
-	 */
-	if (rela->r_addend == 0 && sym->st_size != 0) {
-		BUG_ON(sym->st_size < (u64)plt || sym->st_size >= (u64)&plt[i]);
-		return sym->st_size;
-	}
-
-	mod->arch.plt_num_entries++;
-	BUG_ON(mod->arch.plt_num_entries > mod->arch.plt_max_entries);
-
-	/*
 	 * MOVK/MOVN/MOVZ opcode:
 	 * +--------+------------+--------+-----------+-------------+---------+
 	 * | sf[31] | opc[30:29] | 100101 | hw[22:21] | imm16[20:5] | Rd[4:0] |
@@ -72,8 +58,19 @@ u64 module_emit_plt_entry(struct module *mod, const Elf64_Rela *rela,
 		cpu_to_le32(0xd61f0200)
 	};
 
-	if (rela->r_addend == 0)
-		sym->st_size = (u64)&plt[i];
+	/*
+	 * Check if the entry we just created is a duplicate. Given that the
+	 * relocations are sorted, this will be the last entry we allocated.
+	 * (if one exists).
+	 */
+	if (i > 0 &&
+	    plt[i].mov0 == plt[i - 1].mov0 &&
+	    plt[i].mov1 == plt[i - 1].mov1 &&
+	    plt[i].mov2 == plt[i - 1].mov2)
+		return (u64)&plt[i - 1];
+
+	pltsec->plt_num_entries++;
+	BUG_ON(pltsec->plt_num_entries > pltsec->plt_max_entries);
 
 	return (u64)&plt[i];
 }
@@ -104,7 +101,8 @@ static bool duplicate_rel(const Elf64_Rela *rela, int num)
 	return num > 0 && cmp_rela(rela + num, rela + num - 1) == 0;
 }
 
-static unsigned int count_plts(Elf64_Sym *syms, Elf64_Rela *rela, int num)
+static unsigned int count_plts(Elf64_Sym *syms, Elf64_Rela *rela, int num,
+			       Elf64_Word dstidx)
 {
 	unsigned int ret = 0;
 	Elf64_Sym *s;
@@ -116,13 +114,17 @@ static unsigned int count_plts(Elf64_Sym *syms, Elf64_Rela *rela, int num)
 		case R_AARCH64_CALL26:
 			/*
 			 * We only have to consider branch targets that resolve
-			 * to undefined symbols. This is not simply a heuristic,
-			 * it is a fundamental limitation, since the PLT itself
-			 * is part of the module, and needs to be within 128 MB
-			 * as well, so modules can never grow beyond that limit.
+			 * to symbols that are defined in a different section.
+			 * This is not simply a heuristic, it is a fundamental
+			 * limitation, since there is no guaranteed way to emit
+			 * PLT entries sufficiently close to the branch if the
+			 * section size exceeds the range of a branch
+			 * instruction. So ignore relocations against defined
+			 * symbols if they live in the same section as the
+			 * relocation target.
 			 */
 			s = syms + ELF64_R_SYM(rela[i].r_info);
-			if (s->st_shndx != SHN_UNDEF)
+			if (s->st_shndx == dstidx)
 				break;
 
 			/*
@@ -149,7 +151,8 @@ static unsigned int count_plts(Elf64_Sym *syms, Elf64_Rela *rela, int num)
 int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 			      char *secstrings, struct module *mod)
 {
-	unsigned long plt_max_entries = 0;
+	unsigned long core_plts = 0;
+	unsigned long init_plts = 0;
 	Elf64_Sym *syms = NULL;
 	int i;
 
@@ -158,14 +161,16 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
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
@@ -188,14 +193,27 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 		/* sort by type, symbol index and addend */
 		sort(rels, numrels, sizeof(Elf64_Rela), cmp_rela, NULL);
 
-		plt_max_entries += count_plts(syms, rels, numrels);
+		if (strncmp(secstrings + dstsec->sh_name, ".init", 5) != 0)
+			core_plts += count_plts(syms, rels, numrels,
+						sechdrs[i].sh_info);
+		else
+			init_plts += count_plts(syms, rels, numrels,
+						sechdrs[i].sh_info);
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
+	mod->arch.core.plt->sh_size = (core_plts  + 1) * sizeof(struct plt_entry);
+	mod->arch.core.plt_num_entries = 0;
+	mod->arch.core.plt_max_entries = core_plts;
+
+	mod->arch.init.plt->sh_type = SHT_NOBITS;
+	mod->arch.init.plt->sh_flags = SHF_EXECINSTR | SHF_ALLOC;
+	mod->arch.init.plt->sh_addralign = L1_CACHE_BYTES;
+	mod->arch.init.plt->sh_size = (init_plts + 1) * sizeof(struct plt_entry);
+	mod->arch.init.plt_num_entries = 0;
+	mod->arch.init.plt_max_entries = init_plts;
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
