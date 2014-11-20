From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 20 Nov 2014 18:08:19 +0100
Subject: [PoC PATCH] arm: allow modules outside of bl range
Message-ID: <1416503299-17418-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Loading modules far away from the kernel in memory is problematic because
the 'bl' instruction only has limited reach, and modules are not built
with PLTs. Instead of using the -mlong-calls option (which affects *all*
emitted bl instructions), this patch allocates some additional space at
module load time, and populates it with PLT like entries when encountering
relocations that are out of reach.

Note that this patch is a proof of concept, and thus removes the implementation
of module_alloc() so that all modules are relocated using PLT entries.
Ideally, we would switch into PLT mode and start using the vmalloc area only
after we have exhausted the ordinary module space.

This should work with all relocation against symbols exported by the kernel,
including those resulting from GCC generated function calls for ftrace etc.

This is largely based on the ia64 implementation.
Thumb-2 kernels currently unsupported.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/Makefile             |   1 +
 arch/arm/include/asm/module.h |   2 +
 arch/arm/kernel/module.c      | 172 ++++++++++++++++++++++++++++++++++++++++--
 arch/arm/kernel/module.lds    |   4 +
 4 files changed, 173 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/kernel/module.lds

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 034a94904d69..dfb7ef1f2cc5 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -12,6 +12,7 @@
 
 # Ensure linker flags are correct
 LDFLAGS		:=
+LDFLAGS_MODULE	+= -T $(srctree)/arch/arm/kernel/module.lds
 
 LDFLAGS_vmlinux	:=-p --no-undefined -X
 ifeq ($(CONFIG_CPU_ENDIAN_BE8),y)
diff --git a/arch/arm/include/asm/module.h b/arch/arm/include/asm/module.h
index ed690c49ef93..4c6927976469 100644
--- a/arch/arm/include/asm/module.h
+++ b/arch/arm/include/asm/module.h
@@ -19,6 +19,8 @@ enum {
 
 struct mod_arch_specific {
 	struct unwind_table *unwind[ARM_SEC_MAX];
+	struct elf32_shdr   *core_plt;
+	struct elf32_shdr   *init_plt;
 };
 #endif
 
diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index 6a4dffefd357..5ec70c15a881 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -37,14 +37,62 @@
 #define MODULES_VADDR	(((unsigned long)_etext + ~PMD_MASK) & PMD_MASK)
 #endif
 
-#ifdef CONFIG_MMU
-void *module_alloc(unsigned long size)
+#define PLT_ENTRY_STRIDE	L1_CACHE_BYTES
+#define PLT_ENTRY_COUNT		(PLT_ENTRY_STRIDE / sizeof(u32))
+#define PLT_ENTRY_SIZE		(sizeof(struct plt_entries) / PLT_ENTRY_COUNT)
+#define PLT_ENTRY_LDR		__opcode_to_mem_arm(0xe59ff000 | (PLT_ENTRY_STRIDE - 8))
+
+struct plt_entries {
+	u32	ldr[PLT_ENTRY_COUNT];
+	u32	lit[PLT_ENTRY_COUNT];
+};
+
+static inline int in_init (const struct module *mod, u32 addr)
 {
-	return __vmalloc_node_range(size, 1, MODULES_VADDR, MODULES_END,
-				GFP_KERNEL, PAGE_KERNEL_EXEC, NUMA_NO_NODE,
-				__builtin_return_address(0));
+	return addr - (u32)mod->module_init < mod->init_size;
+}
+
+static inline int in_core (const struct module *mod, u32 addr)
+{
+	return addr - (u32)mod->module_core < mod->core_size;
+}
+
+static u32 get_plt(struct module *mod, unsigned long loc, Elf32_Addr val)
+{
+	struct plt_entries *plt, *plt_end;
+
+	if (in_init(mod, loc)) {
+		plt = (void *)mod->arch.init_plt->sh_addr;
+		plt_end = (void *)plt + mod->arch.init_plt->sh_size;
+	} else {
+		plt = (void *)mod->arch.core_plt->sh_addr;
+		plt_end = (void *)plt + mod->arch.core_plt->sh_size;
+	}
+
+	/* Look for an existing entry pointing to 'val' */
+	while (plt < plt_end) {
+		int i;
+
+		if (*plt->ldr != PLT_ENTRY_LDR) {
+			/* Populate a new set of entries */
+			*plt = (struct plt_entries){
+				{ [0 ... PLT_ENTRY_COUNT-1] = PLT_ENTRY_LDR, },
+				{ val, }
+			};
+			return (u32)plt->ldr;
+		}
+		for (i = 0; i < PLT_ENTRY_COUNT; i++) {
+			if (!plt->lit[i])
+				plt->lit[i] = val;
+			else if (plt->lit[i] != val)
+				continue;
+			return (u32)&plt->ldr[i];
+		}
+		plt++;
+	}
+	BUG();
+	return 0;
 }
-#endif
 
 int
 apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
@@ -107,6 +155,22 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
 			if (offset & 3 ||
 			    offset <= (s32)0xfe000000 ||
 			    offset >= (s32)0x02000000) {
+
+				/*
+				 * Route this call through a PLT entry that we
+				 * populate on the fly in the PLT section that
+				 * is part of the module memory area.
+				 * Note that 'offset + loc + 8' contains the
+				 * absolute jump target, i.e., @sym + addend,
+				 * corrected for the -8 PC bias.
+				 */
+				offset = get_plt(module, loc, offset + loc + 8)
+					 - loc - 8;
+			}
+
+			if (offset & 3 ||
+			    offset <= (s32)0xfe000000 ||
+			    offset >= (s32)0x02000000) {
 				pr_err("%s: section %u reloc %u sym '%s': relocation %u out of range (%#lx -> %#x)\n",
 				       module->name, relindex, i, symname,
 				       ELF32_R_TYPE(rel->r_info), loc,
@@ -354,3 +418,99 @@ module_arch_cleanup(struct module *mod)
 			unwind_table_del(mod->arch.unwind[i]);
 #endif
 }
+
+static int duplicate_reloc(Elf32_Addr base, const Elf32_Rel *rel, int num,
+			   u32 mask)
+{
+	u32 *loc1, *loc2;
+	int i;
+
+	for (i = 0; i < num; i++) {
+		if (rel[i].r_info != rel[num].r_info)
+			continue;
+
+		/*
+		 * Identical relocation types against identical symbols can
+		 * still result in different PLT entries if the addend in the
+		 * place is different. So resolve the target of the relocation
+		 * to compare the values.
+		 */
+		loc1 = (u32 *)(base + rel[i].r_offset);
+		loc2 = (u32 *)(base + rel[num].r_offset);
+		if (((*loc1 ^ *loc2) & mask) == 0)
+			return 1;
+	}
+	return 0;
+}
+
+/* Count how many PLT entries we may need */
+static unsigned int count_plts(Elf32_Addr base, const Elf32_Rel *rel, int num)
+{
+	unsigned int ret = 0;
+	int i;
+
+	/*
+	 * Sure, this is order(n^2), but it's usually short, and not
+	 * time critical
+	 */
+	for (i = 0; i < num; i++)
+		switch (ELF32_R_TYPE(rel[i].r_info))
+		case R_ARM_CALL:
+		case R_ARM_PC24:
+		case R_ARM_JUMP24:
+		case R_ARM_THM_CALL:
+		case R_ARM_THM_JUMP24:
+			if (!duplicate_reloc(base, rel, i, 0x00ffffff))
+				ret++;
+	return ret;
+}
+
+int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
+			      char *secstrings, struct module *mod)
+{
+	unsigned long core_plts = 0, init_plts = 0;
+	Elf32_Shdr *s, *sechdrs_end = sechdrs + ehdr->e_shnum;
+
+	/*
+	 * To store the PLTs, we expand the .text section for core module code
+	 * and the .init.text section for initialization code.
+	 */
+	for (s = sechdrs; s < sechdrs_end; ++s)
+		if (strcmp(".core.plt", secstrings + s->sh_name) == 0)
+			mod->arch.core_plt = s;
+		else if (strcmp(".init.plt", secstrings + s->sh_name) == 0)
+			mod->arch.init_plt = s;
+
+	if (!mod->arch.core_plt || !mod->arch.init_plt) {
+		printk(KERN_ERR "%s: sections missing\n", mod->name);
+		return -ENOEXEC;
+	}
+
+	for (s = sechdrs + 1; s < sechdrs_end; ++s) {
+		const Elf32_Rel *rels = (void *)ehdr + s->sh_offset;
+		int numrels = s->sh_size / sizeof(Elf32_Rel);
+		Elf32_Shdr *dstsec = sechdrs + s->sh_info;
+
+		if (s->sh_type != SHT_REL)
+			continue;
+
+		if (strstr(secstrings + s->sh_name, ".init"))
+			init_plts += count_plts(dstsec->sh_addr, rels, numrels);
+		else
+			core_plts += count_plts(dstsec->sh_addr, rels, numrels);
+	}
+
+	mod->arch.core_plt->sh_type = SHT_NOBITS;
+	mod->arch.core_plt->sh_flags = SHF_EXECINSTR | SHF_ALLOC;
+	mod->arch.core_plt->sh_addralign = L1_CACHE_BYTES;
+	mod->arch.core_plt->sh_size = round_up(core_plts * PLT_ENTRY_SIZE,
+					       sizeof(struct plt_entries));
+	mod->arch.init_plt->sh_type = SHT_NOBITS;
+	mod->arch.init_plt->sh_flags = SHF_EXECINSTR | SHF_ALLOC;
+	mod->arch.init_plt->sh_addralign = L1_CACHE_BYTES;
+	mod->arch.init_plt->sh_size = round_up(init_plts * PLT_ENTRY_SIZE,
+					       sizeof(struct plt_entries));
+	pr_debug("%s: core.plt=%x, init.plt=%x\n", __func__,
+		 mod->arch.core_plt->sh_size, mod->arch.init_plt->sh_size);
+	return 0;
+}
diff --git a/arch/arm/kernel/module.lds b/arch/arm/kernel/module.lds
new file mode 100644
index 000000000000..3682fa107918
--- /dev/null
+++ b/arch/arm/kernel/module.lds
@@ -0,0 +1,4 @@
+SECTIONS {
+        .core.plt : { BYTE(0) }
+        .init.plt : { BYTE(0) }
+}
-- 
1.8.3.2
