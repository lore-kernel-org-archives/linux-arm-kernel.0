From: vincent.whitchurch@axis.com (Vincent Whitchurch)
Date: Thu, 1 Nov 2018 16:29:13 +0100
Subject: [PATCH v2] ARM: module: Fix function kallsyms on Thumb-2
In-Reply-To: <20181031155341.GA27878@linux-8ccs>
References: <20181031084253.9650-1-vincent.whitchurch@axis.com>
 <20181031155341.GA27878@linux-8ccs>
Message-ID: <20181101152913.r2isskngiahi6o2u@axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 31, 2018 at 04:53:41PM +0100, Jessica Yu wrote:
> Could this be done in modpost? I'm guessing the answer is no as some
> relocations may rely on that bit being set in st_value, right?
> Therefore we can only clear the bit _after_ relocations to the module
> are applied at runtime, correct?

Yes, that's correct, it needs to be done after the relocations.

> I'm not against having an arch-specific kallsyms fixup function, my
> only concern would be if this would interfere with the delayed
> relocations livepatching does, if there are plans in the future to
> have livepatching on arm (IIRC there was an attempt at a port in
> 2016). If there exists some Thumb-2 relocation types that rely on that
> lowest bit in st_value being set in order to be applied, and we clear
> it permanently from the symtab, then livepatching wouldn't be able to
> apply those types of relocations anymore. If this is a legitimate
> concern, then perhaps an alternative solution would be to have an
> arch-specific kallsyms symbol-value-fixup function for accesses to
> sym.st_value, without modifying the module symtab.

I'm not familiar with livepatching, but yes, if it needs to do
relocations later I guess we should preserve the original value.

I gave the alternative solution a go and it seems to work.
add_kallsyms() currently overwrites st_info so I had to move the
elf_type to the unused st_other field instead to preserve st_info:

diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index 3ff571c2c71c..f443d0ccd1a0 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -336,6 +336,16 @@ static const Elf_Shdr *find_mod_section(const Elf32_Ehdr *hdr,
 extern void fixup_pv_table(const void *, unsigned long);
 extern void fixup_smp(const void *, unsigned long);
 
+#ifdef CONFIG_THUMB2_KERNEL
+unsigned long symbol_value(Elf_Sym *sym)
+{
+	if (ELF_ST_TYPE(sym->st_info) == STT_FUNC)
+		return sym->st_value & ~1;
+
+	return sym->st_value;
+}
+#endif
+
 int module_finalize(const Elf32_Ehdr *hdr, const Elf_Shdr *sechdrs,
 		    struct module *mod)
 {
diff --git a/include/linux/moduleloader.h b/include/linux/moduleloader.h
index 31013c2effd3..6bf6118db37f 100644
--- a/include/linux/moduleloader.h
+++ b/include/linux/moduleloader.h
@@ -86,6 +86,8 @@ void module_arch_cleanup(struct module *mod);
 /* Any cleanup before freeing mod->module_init */
 void module_arch_freeing_init(struct module *mod);
 
+unsigned long symbol_value(Elf_Sym *sym);
+
 #ifdef CONFIG_KASAN
 #include <linux/kasan.h>
 #define MODULE_ALIGN (PAGE_SIZE << KASAN_SHADOW_SCALE_SHIFT)
diff --git a/kernel/module.c b/kernel/module.c
index 49a405891587..871bf4450e9d 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2682,7 +2682,7 @@ static void add_kallsyms(struct module *mod, const struct load_info *info)
 
 	/* Set types up while we still have access to sections. */
 	for (i = 0; i < mod->kallsyms->num_symtab; i++)
-		mod->kallsyms->symtab[i].st_info
+		mod->kallsyms->symtab[i].st_other
 			= elf_type(&mod->kallsyms->symtab[i], info);
 
 	/* Now populate the cut down core kallsyms for after init. */
@@ -3916,6 +3916,11 @@ static const char *symname(struct mod_kallsyms *kallsyms, unsigned int symnum)
 	return kallsyms->strtab + kallsyms->symtab[symnum].st_name;
 }
 
+unsigned long __weak symbol_value(Elf_Sym *sym)
+{
+	return sym->st_value;
+}
+
 static const char *get_ksymbol(struct module *mod,
 			       unsigned long addr,
 			       unsigned long *size,
@@ -3934,6 +3939,9 @@ static const char *get_ksymbol(struct module *mod,
 	/* Scan for closest preceding symbol, and next symbol. (ELF
 	   starts real symbols at 1). */
 	for (i = 1; i < kallsyms->num_symtab; i++) {
+		unsigned long thisval = symbol_value(&kallsyms->symtab[i]);
+		unsigned long bestval = symbol_value(&kallsyms->symtab[best]);
+
 		if (kallsyms->symtab[i].st_shndx == SHN_UNDEF)
 			continue;
 
@@ -3943,21 +3951,21 @@ static const char *get_ksymbol(struct module *mod,
 		    || is_arm_mapping_symbol(symname(kallsyms, i)))
 			continue;
 
-		if (kallsyms->symtab[i].st_value <= addr
-		    && kallsyms->symtab[i].st_value > kallsyms->symtab[best].st_value)
+		if (thisval <= addr
+		    && thisval > bestval)
 			best = i;
-		if (kallsyms->symtab[i].st_value > addr
-		    && kallsyms->symtab[i].st_value < nextval)
-			nextval = kallsyms->symtab[i].st_value;
+		if (thisval > addr
+		    && thisval < nextval)
+			nextval = thisval;
 	}
 
 	if (!best)
 		return NULL;
 
 	if (size)
-		*size = nextval - kallsyms->symtab[best].st_value;
+		*size = nextval - symbol_value(&kallsyms->symtab[best]);
 	if (offset)
-		*offset = addr - kallsyms->symtab[best].st_value;
+		*offset = addr - symbol_value(&kallsyms->symtab[best]);
 	return symname(kallsyms, best);
 }
 
@@ -4060,8 +4068,8 @@ int module_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
 			continue;
 		kallsyms = rcu_dereference_sched(mod->kallsyms);
 		if (symnum < kallsyms->num_symtab) {
-			*value = kallsyms->symtab[symnum].st_value;
-			*type = kallsyms->symtab[symnum].st_info;
+			*value = symbol_value(&kallsyms->symtab[symnum]);
+			*type = kallsyms->symtab[symnum].st_other;
 			strlcpy(name, symname(kallsyms, symnum), KSYM_NAME_LEN);
 			strlcpy(module_name, mod->name, MODULE_NAME_LEN);
 			*exported = is_exported(name, *value, mod);
@@ -4082,7 +4090,7 @@ static unsigned long mod_find_symname(struct module *mod, const char *name)
 	for (i = 0; i < kallsyms->num_symtab; i++)
 		if (strcmp(name, symname(kallsyms, i)) == 0 &&
 		    kallsyms->symtab[i].st_shndx != SHN_UNDEF)
-			return kallsyms->symtab[i].st_value;
+			return symbol_value(&kallsyms->symtab[i]);
 	return 0;
 }
 
@@ -4132,7 +4140,7 @@ int module_kallsyms_on_each_symbol(int (*fn)(void *, const char *,
 				continue;
 
 			ret = fn(data, symname(kallsyms, i),
-				 mod, kallsyms->symtab[i].st_value);
+				 mod, symbol_value(&kallsyms->symtab[i]));
 			if (ret != 0)
 				return ret;
 		}
