From: jeyu@kernel.org (Jessica Yu)
Date: Tue, 23 Oct 2018 19:55:54 +0200
Subject: [PATCH] arm64/module: use mod->klp_info section header information
In-Reply-To: <20181001141652.5478C68BE1@newverein.lst.de>
References: <20181001140910.086E768BC7@newverein.lst.de>
 <20181001141652.5478C68BE1@newverein.lst.de>
Message-ID: <20181023175553.gaobskk26koft6s2@linux-8ccs>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The arm64 module loader keeps a pointer into info->sechdrs to keep track
of section header information for .plt section(s). A pointer to the
relevent section header (struct elf64_shdr) in info->sechdrs is stored
in mod->arch.{init,core}.plt. This pointer may be accessed while
applying relocations in apply_relocate_add() for example. And unlike
normal modules, livepatch modules can call apply_relocate_add() after
module load. But the info struct (and therefore info->sechdrs) gets
freed at the end of load_module() and so mod->arch.{init,core}.plt
becomes an invalid pointer after the module is done loading.

Luckily, livepatch modules already keep a copy of Elf section header
information in mod->klp_info. So make sure livepatch modules on arm64
have access to the section headers in klp_info and set
mod->arch.{init,core}.plt to the appropriate section header in
mod->klp_info so that they can call apply_relocate_add() even after
module load.

Signed-off-by: Jessica Yu <jeyu@kernel.org>
---

Hi!

This patch may be applied on top or merged with the 3rd patch. I
incoporated Miroslav's suggestions from the discussion. It's needed in
order for livepatch modules on arm64 to be able to call
apply_relocate_add() post-module-load, otherwise we could end up
accessing invalid pointers from apply_relocate_add().

 arch/arm64/include/asm/module.h |  1 +
 arch/arm64/kernel/module-plts.c | 10 ++++++++--
 arch/arm64/kernel/module.c      | 10 ++++++++++
 kernel/module.c                 | 22 +++++++++++++---------
 4 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/module.h b/arch/arm64/include/asm/module.h
index fef773c94e9d..ac9b97f9ae5e 100644
--- a/arch/arm64/include/asm/module.h
+++ b/arch/arm64/include/asm/module.h
@@ -25,6 +25,7 @@ struct mod_plt_sec {
 	struct elf64_shdr	*plt;
 	int			plt_num_entries;
 	int			plt_max_entries;
+	int			plt_shndx;
 };
 
 struct mod_arch_specific {
diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
index f0690c2ca3e0..05067717dfc5 100644
--- a/arch/arm64/kernel/module-plts.c
+++ b/arch/arm64/kernel/module-plts.c
@@ -210,9 +210,15 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 	 * entries. Record the symtab address as well.
 	 */
 	for (i = 0; i < ehdr->e_shnum; i++) {
-		if (!strcmp(secstrings + sechdrs[i].sh_name, ".plt"))
+		if (!strcmp(secstrings + sechdrs[i].sh_name, ".plt")) {
 			mod->arch.core.plt = sechdrs + i;
-		else if (!strcmp(secstrings + sechdrs[i].sh_name, ".init.plt"))
+			/*
+			 * Keep the section index for the .plt section for
+			 * livepatching. Note that .init.plt is irrelevant to
+			 * livepatch, so only the shndx for .plt is saved.
+			 */
+			mod->arch.core.plt_shndx = i;
+		} else if (!strcmp(secstrings + sechdrs[i].sh_name, ".init.plt"))
 			mod->arch.init.plt = sechdrs + i;
 		else if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE) &&
 			 !strcmp(secstrings + sechdrs[i].sh_name,
diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
index dd23655fda3a..490e56070a7e 100644
--- a/arch/arm64/kernel/module.c
+++ b/arch/arm64/kernel/module.c
@@ -461,5 +461,15 @@ int module_finalize(const Elf_Ehdr *hdr,
 #endif
 	}
 
+#ifdef CONFIG_LIVEPATCH
+	/*
+	 * For livepatching, switch to the saved section header info for .plt
+	 * stored in mod->klp_info. This is needed so that livepatch is able to
+	 * call apply_relocate_add() after patch module load.
+	 */
+	if (is_livepatch_module(me))
+		me->arch.core.plt = me->klp_info->sechdrs + me->arch.core.plt_shndx;
+#endif
+
 	return 0;
 }
diff --git a/kernel/module.c b/kernel/module.c
index f475f30eed8c..f3ac04cc9fc3 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3367,6 +3367,8 @@ int __weak module_finalize(const Elf_Ehdr *hdr,
 
 static int post_relocation(struct module *mod, const struct load_info *info)
 {
+	int err;
+
 	/* Sort exception table now relocations are done. */
 	sort_extable(mod->extable, mod->extable + mod->num_exentries);
 
@@ -3377,8 +3379,18 @@ static int post_relocation(struct module *mod, const struct load_info *info)
 	/* Setup kallsyms-specific fields. */
 	add_kallsyms(mod, info);
 
+	if (is_livepatch_module(mod)) {
+		err = copy_module_elf(mod, info);
+		if (err < 0)
+			return err;
+	}
+
 	/* Arch-specific module finalizing. */
-	return module_finalize(info->hdr, info->sechdrs, mod);
+	err = module_finalize(info->hdr, info->sechdrs, mod);
+	if (err < 0)
+		free_module_elf(mod);
+
+	return err;
 }
 
 /* Is this module of this name done loading?  No locks held. */
@@ -3770,12 +3782,6 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	if (err < 0)
 		goto coming_cleanup;
 
-	if (is_livepatch_module(mod)) {
-		err = copy_module_elf(mod, info);
-		if (err < 0)
-			goto sysfs_cleanup;
-	}
-
 	/* Get rid of temporary copy. */
 	free_copy(info);
 
@@ -3784,8 +3790,6 @@ static int load_module(struct load_info *info, const char __user *uargs,
 
 	return do_init_module(mod);
 
- sysfs_cleanup:
-	mod_sysfs_teardown(mod);
  coming_cleanup:
 	mod->state = MODULE_STATE_GOING;
 	destroy_params(mod->kp, mod->num_kp);
-- 
2.16.4
