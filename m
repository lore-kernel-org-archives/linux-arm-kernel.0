From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 18 Aug 2016 12:02:40 +0200
Subject: [PATCH v3 1/4] ARM: kernel: merge core and init PLTs
In-Reply-To: <1471514563-28172-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1471514563-28172-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1471514563-28172-2-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PLT code uses a separate .init.plt section to allocate PLT entries
for jump and call instructions in __init code. However, even for fairly
sizable modules like mac80211.ko, we only end up with a couple of PLT
entries in the .init section, and so we can simplify the code
significantly by emitting all PLT entries into the same section.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/include/asm/module.h |  6 +-
 arch/arm/kernel/module-plts.c | 68 +++++++-------------
 arch/arm/kernel/module.lds    |  3 +-
 3 files changed, 25 insertions(+), 52 deletions(-)

diff --git a/arch/arm/include/asm/module.h b/arch/arm/include/asm/module.h
index e358b7966c06..464748b9fd7d 100644
--- a/arch/arm/include/asm/module.h
+++ b/arch/arm/include/asm/module.h
@@ -23,10 +23,8 @@ struct mod_arch_specific {
 	struct unwind_table *unwind[ARM_SEC_MAX];
 #endif
 #ifdef CONFIG_ARM_MODULE_PLTS
-	struct elf32_shdr   *core_plt;
-	struct elf32_shdr   *init_plt;
-	int		    core_plt_count;
-	int		    init_plt_count;
+	struct elf32_shdr   *plt;
+	int		    plt_count;
 #endif
 };
 
diff --git a/arch/arm/kernel/module-plts.c b/arch/arm/kernel/module-plts.c
index 0c7efc3446c0..6832d1d6444e 100644
--- a/arch/arm/kernel/module-plts.c
+++ b/arch/arm/kernel/module-plts.c
@@ -30,28 +30,16 @@ struct plt_entries {
 	u32	lit[PLT_ENT_COUNT];
 };
 
-static bool in_init(const struct module *mod, u32 addr)
-{
-	return addr - (u32)mod->init_layout.base < mod->init_layout.size;
-}
-
 u32 get_module_plt(struct module *mod, unsigned long loc, Elf32_Addr val)
 {
 	struct plt_entries *plt, *plt_end;
-	int c, *count;
-
-	if (in_init(mod, loc)) {
-		plt = (void *)mod->arch.init_plt->sh_addr;
-		plt_end = (void *)plt + mod->arch.init_plt->sh_size;
-		count = &mod->arch.init_plt_count;
-	} else {
-		plt = (void *)mod->arch.core_plt->sh_addr;
-		plt_end = (void *)plt + mod->arch.core_plt->sh_size;
-		count = &mod->arch.core_plt_count;
-	}
+	int c;
+
+	plt = (void *)mod->arch.plt->sh_addr;
+	plt_end = (void *)plt + mod->arch.plt->sh_size;
 
 	/* Look for an existing entry pointing to 'val' */
-	for (c = *count; plt < plt_end; c -= PLT_ENT_COUNT, plt++) {
+	for (c = mod->arch.plt_count; plt < plt_end; c -= PLT_ENT_COUNT, plt++) {
 		int i;
 
 		if (!c) {
@@ -60,13 +48,13 @@ u32 get_module_plt(struct module *mod, unsigned long loc, Elf32_Addr val)
 				{ [0 ... PLT_ENT_COUNT - 1] = PLT_ENT_LDR, },
 				{ val, }
 			};
-			++*count;
+			mod->arch.plt_count++;
 			return (u32)plt->ldr;
 		}
 		for (i = 0; i < PLT_ENT_COUNT; i++) {
 			if (!plt->lit[i]) {
 				plt->lit[i] = val;
-				++*count;
+				mod->arch.plt_count++;
 			}
 			if (plt->lit[i] == val)
 				return (u32)&plt->ldr[i];
@@ -132,21 +120,19 @@ static unsigned int count_plts(Elf32_Addr base, const Elf32_Rel *rel, int num)
 int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 			      char *secstrings, struct module *mod)
 {
-	unsigned long core_plts = 0, init_plts = 0;
+	unsigned long plts = 0;
 	Elf32_Shdr *s, *sechdrs_end = sechdrs + ehdr->e_shnum;
 
 	/*
 	 * To store the PLTs, we expand the .text section for core module code
-	 * and the .init.text section for initialization code.
+	 * and for initialization code.
 	 */
 	for (s = sechdrs; s < sechdrs_end; ++s)
-		if (strcmp(".core.plt", secstrings + s->sh_name) == 0)
-			mod->arch.core_plt = s;
-		else if (strcmp(".init.plt", secstrings + s->sh_name) == 0)
-			mod->arch.init_plt = s;
+		if (strcmp(".plt", secstrings + s->sh_name) == 0)
+			mod->arch.plt = s;
 
-	if (!mod->arch.core_plt || !mod->arch.init_plt) {
-		pr_err("%s: sections missing\n", mod->name);
+	if (!mod->arch.plt) {
+		pr_err("%s: module PLT section missing\n", mod->name);
 		return -ENOEXEC;
 	}
 
@@ -158,26 +144,16 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 		if (s->sh_type != SHT_REL)
 			continue;
 
-		if (strstr(secstrings + s->sh_name, ".init"))
-			init_plts += count_plts(dstsec->sh_addr, rels, numrels);
-		else
-			core_plts += count_plts(dstsec->sh_addr, rels, numrels);
+		plts += count_plts(dstsec->sh_addr, rels, numrels);
 	}
 
-	mod->arch.core_plt->sh_type = SHT_NOBITS;
-	mod->arch.core_plt->sh_flags = SHF_EXECINSTR | SHF_ALLOC;
-	mod->arch.core_plt->sh_addralign = L1_CACHE_BYTES;
-	mod->arch.core_plt->sh_size = round_up(core_plts * PLT_ENT_SIZE,
-					       sizeof(struct plt_entries));
-	mod->arch.core_plt_count = 0;
-
-	mod->arch.init_plt->sh_type = SHT_NOBITS;
-	mod->arch.init_plt->sh_flags = SHF_EXECINSTR | SHF_ALLOC;
-	mod->arch.init_plt->sh_addralign = L1_CACHE_BYTES;
-	mod->arch.init_plt->sh_size = round_up(init_plts * PLT_ENT_SIZE,
-					       sizeof(struct plt_entries));
-	mod->arch.init_plt_count = 0;
-	pr_debug("%s: core.plt=%x, init.plt=%x\n", __func__,
-		 mod->arch.core_plt->sh_size, mod->arch.init_plt->sh_size);
+	mod->arch.plt->sh_type = SHT_NOBITS;
+	mod->arch.plt->sh_flags = SHF_EXECINSTR | SHF_ALLOC;
+	mod->arch.plt->sh_addralign = L1_CACHE_BYTES;
+	mod->arch.plt->sh_size = round_up(plts * PLT_ENT_SIZE,
+					  sizeof(struct plt_entries));
+	mod->arch.plt_count = 0;
+
+	pr_debug("%s: plt=%x\n", __func__, mod->arch.plt->sh_size);
 	return 0;
 }
diff --git a/arch/arm/kernel/module.lds b/arch/arm/kernel/module.lds
index 3682fa107918..05881e2b414c 100644
--- a/arch/arm/kernel/module.lds
+++ b/arch/arm/kernel/module.lds
@@ -1,4 +1,3 @@
 SECTIONS {
-        .core.plt : { BYTE(0) }
-        .init.plt : { BYTE(0) }
+	.plt : { BYTE(0) }
 }
-- 
2.7.4
