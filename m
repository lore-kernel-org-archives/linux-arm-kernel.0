From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sat, 31 Jan 2015 19:49:17 +0000
Subject: [PATCH resend 2/4] ARM: allow modules outside of bl range
In-Reply-To: <1422733759-27236-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1422733759-27236-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1422733759-27236-3-git-send-email-ard.biesheuvel@linaro.org>
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

The module memory size increases by about 5% on average, regardless of
whether any PLT entries were actually needed. However, due to the page
based rounding that occurs when allocating module memory, the average
memory footprint increase is negligible.

This is largely based on the ia64 implementation.

Reviewed-by: Nicolas Pitre <nico@linaro.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
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
ipv6			219496	330	2688	1.24% (*)
rt2800usb		12894	15	128	1.00%
brcmfmac		125129	138	1152	0.93%
zlib_deflate		14598	2	128	0.88%
des_generic		16971	2	128	0.76%
cfg80211		132574	111	896	0.68%
mac80211		211721	155	1280	0.61%
rt2800lib		50751	20	256	0.51%
crc_ccitt		1086	0	0	0.00%
---
 arch/arm/Kconfig              |  17 +++-
 arch/arm/Makefile             |   4 +
 arch/arm/include/asm/module.h |  12 ++-
 arch/arm/kernel/Makefile      |   1 +
 arch/arm/kernel/module-plts.c | 182 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm/kernel/module.c      |  32 +++++++-
 arch/arm/kernel/module.lds    |   4 +
 7 files changed, 249 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/kernel/module-plts.c
 create mode 100644 arch/arm/kernel/module.lds

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 89c4b5ccc68d..9edb69ff0d38 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -57,7 +57,7 @@ config ARM
 	select HAVE_KPROBES if !XIP_KERNEL
 	select HAVE_KRETPROBES if (HAVE_KPROBES)
 	select HAVE_MEMBLOCK
-	select HAVE_MOD_ARCH_SPECIFIC if ARM_UNWIND
+	select HAVE_MOD_ARCH_SPECIFIC
 	select HAVE_OPROFILE if (HAVE_PERF_EVENTS)
 	select HAVE_PERF_EVENTS
 	select HAVE_PERF_REGS
@@ -1705,6 +1705,21 @@ config HAVE_ARCH_TRANSPARENT_HUGEPAGE
 config ARCH_WANT_GENERAL_HUGETLB
 	def_bool y
 
+config ARM_MODULE_PLTS
+	bool "Use PLTs to allow module memory to spill over into vmalloc area"
+	depends on MODULES
+	help
+	  Allocate PLTs when loading modules so that jumps and calls whose
+	  targets are too far away for their relative offsets to be encoded
+	  in the instructions themselves can be bounced via veneers in the
+	  module's PLT. This allows modules to be allocated in the generic
+	  vmalloc area after the dedicated module memory area has been
+	  exhausted. The modules will use slightly more memory, but after
+	  rounding up to page size, the actual memory footprint is usually
+	  the same.
+
+	  Say y if you are getting out of memory errors while loading modules
+
 source "mm/Kconfig"
 
 config FORCE_MAX_ZONEORDER
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 034a94904d69..04c43ea7a031 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -19,6 +19,10 @@ LDFLAGS_vmlinux	+= --be8
 LDFLAGS_MODULE	+= --be8
 endif
 
+ifeq ($(CONFIG_ARM_MODULE_PLTS),y)
+LDFLAGS_MODULE	+= -T $(srctree)/arch/arm/kernel/module.lds
+endif
+
 OBJCOPYFLAGS	:=-O binary -R .comment -S
 GZFLAGS		:=-9
 #KBUILD_CFLAGS	+=-pipe
diff --git a/arch/arm/include/asm/module.h b/arch/arm/include/asm/module.h
index ed690c49ef93..e358b7966c06 100644
--- a/arch/arm/include/asm/module.h
+++ b/arch/arm/include/asm/module.h
@@ -16,11 +16,21 @@ enum {
 	ARM_SEC_UNLIKELY,
 	ARM_SEC_MAX,
 };
+#endif
 
 struct mod_arch_specific {
+#ifdef CONFIG_ARM_UNWIND
 	struct unwind_table *unwind[ARM_SEC_MAX];
-};
 #endif
+#ifdef CONFIG_ARM_MODULE_PLTS
+	struct elf32_shdr   *core_plt;
+	struct elf32_shdr   *init_plt;
+	int		    core_plt_count;
+	int		    init_plt_count;
+#endif
+};
+
+u32 get_module_plt(struct module *mod, unsigned long loc, Elf32_Addr val);
 
 /*
  * Add the ARM architecture version to the version magic string
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index bd2c12dabcab..575a5e424b0a 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
 obj-$(CONFIG_ISA_DMA_API)	+= dma.o
 obj-$(CONFIG_FIQ)		+= fiq.o fiqasm.o
 obj-$(CONFIG_MODULES)		+= armksyms.o module.o
+obj-$(CONFIG_ARM_MODULE_PLTS)	+= module-plts.o
 obj-$(CONFIG_ARTHUR)		+= arthur.o
 obj-$(CONFIG_ISA_DMA)		+= dma-isa.o
 obj-$(CONFIG_PCI)		+= bios32.o isa.o
diff --git a/arch/arm/kernel/module-plts.c b/arch/arm/kernel/module-plts.c
new file mode 100644
index 000000000000..498d24207ec7
--- /dev/null
+++ b/arch/arm/kernel/module-plts.c
@@ -0,0 +1,182 @@
+/*
+ * Copyright (C) 2014 Linaro Ltd. <ard.biesheuvel@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/elf.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+#include <asm/cache.h>
+#include <asm/opcodes.h>
+
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
+static bool in_init(const struct module *mod, u32 addr)
+{
+	return addr - (u32)mod->module_init < mod->init_size;
+}
+
+u32 get_module_plt(struct module *mod, unsigned long loc, Elf32_Addr val)
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
+}
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
+
diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index 16804df4857c..a68040989143 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -40,7 +40,12 @@
 #ifdef CONFIG_MMU
 void *module_alloc(unsigned long size)
 {
-	return __vmalloc_node_range(size, 1, MODULES_VADDR, MODULES_END,
+	void *p = __vmalloc_node_range(size, 1, MODULES_VADDR, MODULES_END,
+				GFP_KERNEL, PAGE_KERNEL_EXEC, NUMA_NO_NODE,
+				__builtin_return_address(0));
+	if (!IS_ENABLED(CONFIG_ARM_MODULE_PLTS) || p)
+		return p;
+	return __vmalloc_node_range(size, 1,  VMALLOC_START, VMALLOC_END,
 				GFP_KERNEL, PAGE_KERNEL_EXEC, NUMA_NO_NODE,
 				__builtin_return_address(0));
 }
@@ -110,6 +115,20 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
 				offset -= 0x04000000;
 
 			offset += sym->st_value - loc;
+
+			/*
+			 * Route through a PLT entry if 'offset' exceeds the
+			 * supported range. Note that 'offset + loc + 8'
+			 * contains the absolute jump target, i.e.,
+			 * @sym + addend, corrected for the +8 PC bias.
+			 */
+			if (IS_ENABLED(CONFIG_ARM_MODULE_PLTS) &&
+			    (offset <= (s32)0xfe000000 ||
+			     offset >= (s32)0x02000000))
+				offset = get_module_plt(module, loc,
+							offset + loc + 8)
+					 - loc - 8;
+
 			if (offset <= (s32)0xfe000000 ||
 			    offset >= (s32)0x02000000) {
 				pr_err("%s: section %u reloc %u sym '%s': relocation %u out of range (%#lx -> %#x)\n",
@@ -203,6 +222,17 @@ apply_relocate(Elf32_Shdr *sechdrs, const char *strtab, unsigned int symindex,
 				offset -= 0x02000000;
 			offset += sym->st_value - loc;
 
+			/*
+			 * Route through a PLT entry if 'offset' exceeds the
+			 * supported range.
+			 */
+			if (IS_ENABLED(CONFIG_ARM_MODULE_PLTS) &&
+			    (offset <= (s32)0xff000000 ||
+			     offset >= (s32)0x01000000))
+				offset = get_module_plt(module, loc,
+							offset + loc + 4)
+					 - loc - 4;
+
 			if (offset <= (s32)0xff000000 ||
 			    offset >= (s32)0x01000000) {
 				pr_err("%s: section %u reloc %u sym '%s': relocation %u out of range (%#lx -> %#x)\n",
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
