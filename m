From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 21 Nov 2014 16:55:26 +0100
Subject: [PATCH] ARM: allow modules outside of bl range
Message-ID: <1416585326-3838-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Loading modules far away from the kernel in memory is problematic
because the 'bl' instruction only has limited reach, and modules are not
built with PLTs. Instead of using the -mlong-calls option (which affects
all compiler emitted bl instructions, but not the ones in assembler),
this patch allocates some additional space at module load time, and
populates it with PLT like entries when encountering relocations that
are out of reach.

This should work with all relocations against symbols exported by the
kernel, including those resulting from GCC generated function calls for
ftrace etc.

The module memory needs increase by about 5% on average, regardless of
whether any PLT entries were actually emitted. However, due to the page
based rounding that occurs when allocating module memory, the typical
memory footprint increase is negligible.

This is largely based on the ia64 implementation.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
Now with support for Thumb-2, and back to using the module area at
first and switching to the vmalloc area only when needed.

Estimation of 5% bloat based on random sample of 46 modules built in
Thumb-2 mode, using a L1 line size of 64 bytes (see table below).
Note that there is only a single instance (*) where the size increase
results in one additional page to be allocated.

MODULE			SIZE	#PLT	PLTSIZE	BLOAT
xfrm6_mode_transport	1264	2	128	11.27%
seqiv			2628	17	256	10.79%
lcd			2735	20	256	10.33%
xfrm6_mode_tunnel	1432	5	128	9.82%
ctr			2905	19	256	9.66%
deflate			1513	8	128	9.24%
md5			1591	4	128	8.75%
xfrm_ipcomp		3186	21	256	8.74%
arc4			1606	3	128	8.66%
xfrm6_mode_beet		1612	4	128	8.63%
sha1_generic		1640	6	128	8.47%
tunnel6			1717	8	128	8.06%
snd_soc_tegra20_spdif	3532	22	256	7.81%
tunnel4			1822	8	128	7.56%
exynos_rng		1837	15	128	7.49%
ipcomp6			1856	10	128	7.41%
omap3_rom_rng		1877	11	128	7.32%
rng_core		3761	23	256	7.30%
cbc			1926	13	128	7.12%
msm_rng			2052	10	128	6.65%
hmac			2267	16	128	5.98%
esp6			4652	27	256	5.82%
ah6			4785	27	256	5.65%
authenc			4865	22	256	5.55%
ip_tunnel		10223	52	512	5.27%
authencesn		5313	21	256	5.06%
ccm			5656	27	256	4.74%
xfrm6_tunnel		2999	11	128	4.46%
sit			12063	56	512	4.43%
ansi_cprng		3146	9	128	4.24%
rt2x00usb		6731	26	256	3.95%
ip6_tunnel		13977	53	512	3.80%
brcmutil		3581	10	128	3.71%
omap_rng		3678	14	128	3.61%
xfrm_algo		4005	2	128	3.30%
mip6			4225	15	128	3.12%
rt2x00lib		27173	56	512	1.92%
ipv6			219496	330	2688	1.24% (*) 53 -> 54 pages
rt2800usb		12894	15	128	1.00%
brcmfmac		125129	138	1152	0.93%
zlib_deflate		14598	2	128	0.88%
des_generic		16971	2	128	0.76%
cfg80211		132574	111	896	0.68%
mac80211		211721	155	1280	0.61%
rt2800lib		50751	20	256	0.51%
crc_ccitt		1086	0	0	0.00%

 arch/arm/Makefile             |   1 +
 arch/arm/include/asm/module.h |   6 +-
 arch/arm/kernel/module.c      | 204 +++++++++++++++++++++++++++++++++++++++++-
 arch/arm/kernel/module.lds    |   4 +
 4 files changed, 212 insertions(+), 3 deletions(-)
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
index ed690c49ef93..bdd0dc0b4d8f 100644
--- a/arch/arm/include/asm/module.h
+++ b/arch/arm/include/asm/module.h
@@ -18,7 +18,11 @@ enum {
 };
 
 struct mod_arch_specific {
-	struct unwind_table *unwind[ARM_SEC_MAX];
+	struct unwind_table	*unwind[ARM_SEC_MAX];
+	struct elf32_shdr	*core_plt;
+	struct elf32_shdr	*init_plt;
+	int			core_plt_count;
+	int			init_plt_count;
 };
 #endif
 
diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index 6a4dffefd357..138201c1ff5f 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -40,12 +40,85 @@
 #ifdef CONFIG_MMU
 void *module_alloc(unsigned long size)
 {
-	return __vmalloc_node_range(size, 1, MODULES_VADDR, MODULES_END,
+	void *p = __vmalloc_node_range(size, 1, MODULES_VADDR, MODULES_END,
+				GFP_KERNEL | __GFP_NOWARN, PAGE_KERNEL_EXEC,
+				NUMA_NO_NODE, __builtin_return_address(0));
+	if (p)
+		return p;
+	return __vmalloc_node_range(size, 1,  VMALLOC_START, VMALLOC_END,
 				GFP_KERNEL, PAGE_KERNEL_EXEC, NUMA_NO_NODE,
 				__builtin_return_address(0));
 }
 #endif
 
+#define PLT_ENT_STRIDE		L1_CACHE_BYTES
+#define PLT_ENT_COUNT		(PLT_ENT_STRIDE / sizeof(u32))
+#define PLT_ENT_SIZE		(sizeof(struct plt_entries) / PLT_ENT_COUNT)
+
+#ifdef CONFIG_THUMB2_KERNEL
+#define PLT_ENT_LDR		__opcode_to_mem_thumb32(0xf8dff000 | \
+							(PLT_ENT_STRIDE - 4))
+#else
+#define PLT_ENT_LDR		__opcode_to_mem_arm(0xe59ff000 | \
+						    (PLT_ENT_STRIDE - 8))
+#endif
+
+struct plt_entries {
+	u32	ldr[PLT_ENT_COUNT];
+	u32	lit[PLT_ENT_COUNT];
+};
+
+static inline int in_init(const struct module *mod, u32 addr)
+{
+	return addr - (u32)mod->module_init < mod->init_size;
+}
+
+static inline int in_core(const struct module *mod, u32 addr)
+{
+	return addr - (u32)mod->module_core < mod->core_size;
+}
+
+static u32 get_plt(struct module *mod, unsigned long loc, Elf32_Addr val)
+{
+	struct plt_entries *plt, *plt_end;
+	int c, *count;
+
+	if (in_init(mod, loc)) {
+		plt = (void *)mod->arch.init_plt->sh_addr;
+		plt_end = (void *)plt + mod->arch.init_plt->sh_size;
+		count = &mod->arch.init_plt_count;
+	} else {
+		plt = (void *)mod->arch.core_plt->sh_addr;
+		plt_end = (void *)plt + mod->arch.core_plt->sh_size;
+		count = &mod->arch.core_plt_count;
+	}
+
+	/* Look for an existing entry pointing to 'val' */
+	for (c = *count; plt < plt_end; c -= PLT_ENT_COUNT, plt++) {
+		int i;
+
+		if (!c) {
+			/* Populate a new set of entries */
+			*plt = (struct plt_entries){
+				{ [0 ... PLT_ENT_COUNT - 1] = PLT_ENT_LDR, },
+				{ val, }
+			};
+			++*count;
+			return (u32)plt->ldr;
+		}
+		for (i = 0; i < PLT_ENT_COUNT; i++) {
+			if (!plt->lit[i]) {
+				plt->lit[i] = val;
+				++*count;
+			}
+			if (plt->lit[i] == val)
+				return (u32)&plt->ldr[i];
+		}
+	}
+	BUG();
+	return 0;
+}
+
 int
 apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
 	       unsigned int relindex, struct module *module)
@@ -104,6 +177,19 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
 				offset -= 0x04000000;
 
 			offset += sym->st_value - loc;
+
+			/*
+			 * Route through a PLT entry if 'offset' exceeds the
+			 * supported range. Note that 'offset + loc + 8'
+			 * contains the absolute jump target, i.e.,
+			 * @sym + addend, corrected for the +8 PC bias.
+			 */
+			if (!(offset & 3) &&
+			    (offset <= (s32)0xfe000000 ||
+			     offset >= (s32)0x02000000))
+				offset = get_plt(module, loc, offset + loc + 8)
+					 - loc - 8;
+
 			if (offset & 3 ||
 			    offset <= (s32)0xfe000000 ||
 			    offset >= (s32)0x02000000) {
@@ -183,6 +269,15 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
 			offset += sym->st_value - loc;
 
 			/*
+			 * Route through a PLT entry if 'offset' exceeds the
+			 * supported range.
+			 */
+			if (offset <= (s32)0xff000000 ||
+			    offset >= (s32)0x01000000)
+				offset = (get_plt(module, loc, offset + loc + 4)
+					  - loc - 4) | 1;
+
+			/*
 			 * For function symbols, only Thumb addresses are
 			 * allowed (no interworking).
 			 *
@@ -192,7 +287,7 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
 			 * that interworking is not required.
 			 */
 			if ((ELF32_ST_TYPE(sym->st_info) == STT_FUNC &&
-				!(offset & 1)) ||
+				!(sym->st_value & 1)) ||
 			    offset <= (s32)0xff000000 ||
 			    offset >= (s32)0x01000000) {
 				pr_err("%s: section %u reloc %u sym '%s': relocation %u out of range (%#lx -> %#x)\n",
@@ -354,3 +449,108 @@ module_arch_cleanup(struct module *mod)
 			unwind_table_del(mod->arch.unwind[i]);
 #endif
 }
+
+static int duplicate_rel(Elf32_Addr base, const Elf32_Rel *rel, int num,
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
+		switch (ELF32_R_TYPE(rel[i].r_info)) {
+		case R_ARM_CALL:
+		case R_ARM_PC24:
+		case R_ARM_JUMP24:
+			if (!duplicate_rel(base, rel, i,
+					   __opcode_to_mem_arm(0x00ffffff)))
+				ret++;
+			break;
+		case R_ARM_THM_CALL:
+		case R_ARM_THM_JUMP24:
+			if (!duplicate_rel(base, rel, i,
+					   __opcode_to_mem_thumb32(0x07ff2fff)))
+				ret++;
+		}
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
+		pr_err("%s: sections missing\n", mod->name);
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
+	mod->arch.core_plt->sh_size = round_up(core_plts * PLT_ENT_SIZE,
+					       sizeof(struct plt_entries));
+	mod->arch.core_plt_count = 0;
+
+	mod->arch.init_plt->sh_type = SHT_NOBITS;
+	mod->arch.init_plt->sh_flags = SHF_EXECINSTR | SHF_ALLOC;
+	mod->arch.init_plt->sh_addralign = L1_CACHE_BYTES;
+	mod->arch.init_plt->sh_size = round_up(init_plts * PLT_ENT_SIZE,
+					       sizeof(struct plt_entries));
+	mod->arch.init_plt_count = 0;
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
