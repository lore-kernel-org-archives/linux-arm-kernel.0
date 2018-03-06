From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue,  6 Mar 2018 17:15:33 +0000
Subject: [PATCH v4 3/5] arm64/kernel: don't ban ADRP to work around Cortex-A53
 erratum #843419
In-Reply-To: <20180306171535.25681-1-ard.biesheuvel@linaro.org>
References: <20180306171535.25681-1-ard.biesheuvel@linaro.org>
Message-ID: <20180306171535.25681-4-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Working around Cortex-A53 erratum #843419 involves special handling of
ADRP instructions that end up in the last two instruction slots of a
4k page, or whose output register gets overwritten without having been
read. (Note that the latter instruction sequence is never emitted by
a properly functioning compiler, which is why it is disregarded by the
handling of the same erratum in the bfd.ld linker which we rely on for
the core kernel)

Normally, this gets taken care of by the linker, which can spot such
sequences at final link time, and insert a veneer if the ADRP ends up
at a vulnerable offset. However, linux kernel modules are partially
linked ELF objects, and so there is no 'final link time' other than the
runtime loading of the module, at which time all the static relocations
are resolved.

For this reason, we have implemented the #843419 workaround for modules
by avoiding ADRP instructions altogether, by using the large C model,
and by passing -mpc-relative-literal-loads to recent versions of GCC
that may emit adrp/ldr pairs to perform literal loads. However, this
workaround forces us to keep literal data mixed with the instructions
in the executable .text segment, and literal data may inadvertently
turn into an exploitable speculative gadget depending on the relative
offsets of arbitrary symbols.

So let's reimplement this workaround in a way that allows us to switch
back to the small C model, and to drop the -mpc-relative-literal-loads
GCC switch, by patching affected ADRP instructions at runtime:
- ADRP instructions that do not appear at 4k relative offset 0xff8 or
  0xffc are ignored
- ADRP instructions that are within 1 MB of their target symbol are
  converted into ADR instructions
- remaining ADRP instructions are redirected via a veneer that performs
  the load using an unaffected movn/movk sequence.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/Kconfig                  | 11 +--
 arch/arm64/Makefile                 |  5 --
 arch/arm64/include/asm/module.h     |  2 +
 arch/arm64/kernel/module-plts.c     | 86 +++++++++++++++++++-
 arch/arm64/kernel/module.c          | 32 +++++++-
 arch/arm64/kernel/reloc_test_core.c |  4 +-
 arch/arm64/kernel/reloc_test_syms.S | 12 ++-
 7 files changed, 128 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index ae7d3d4c0bbe..1b11285cba36 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -455,12 +455,12 @@ config ARM64_ERRATUM_845719
 config ARM64_ERRATUM_843419
 	bool "Cortex-A53: 843419: A load or store might access an incorrect address"
 	default y
-	select ARM64_MODULE_CMODEL_LARGE if MODULES
+	select ARM64_MODULE_PLTS if MODULES
 	help
 	  This option links the kernel with '--fix-cortex-a53-843419' and
-	  builds modules using the large memory model in order to avoid the use
-	  of the ADRP instruction, which can cause a subsequent memory access
-	  to use an incorrect address on Cortex-A53 parts up to r0p4.
+	  enables PLT support to replace certain ADRP instructions, which can
+	  cause subsequent memory accesses to use an incorrect address on
+	  Cortex-A53 parts up to r0p4.
 
 	  If unsure, say Y.
 
@@ -1104,9 +1104,6 @@ config ARM64_SVE
 
 	  To enable use of this extension on CPUs that implement it, say Y.
 
-config ARM64_MODULE_CMODEL_LARGE
-	bool
-
 config ARM64_MODULE_PLTS
 	bool
 	select HAVE_MOD_ARCH_SPECIFIC
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index b481b4a7c011..811ad08c531d 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -51,7 +51,6 @@ endif
 
 KBUILD_CFLAGS	+= -mgeneral-regs-only $(lseinstr) $(brokengasinst)
 KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables
-KBUILD_CFLAGS	+= $(call cc-option, -mpc-relative-literal-loads)
 KBUILD_AFLAGS	+= $(lseinstr) $(brokengasinst)
 
 KBUILD_CFLAGS	+= $(call cc-option,-mabi=lp64)
@@ -77,10 +76,6 @@ endif
 
 CHECKFLAGS	+= -D__aarch64__ -m64
 
-ifeq ($(CONFIG_ARM64_MODULE_CMODEL_LARGE), y)
-KBUILD_CFLAGS_MODULE	+= -mcmodel=large
-endif
-
 ifeq ($(CONFIG_ARM64_MODULE_PLTS),y)
 KBUILD_LDFLAGS_MODULE	+= -T $(srctree)/arch/arm64/kernel/module.lds
 endif
diff --git a/arch/arm64/include/asm/module.h b/arch/arm64/include/asm/module.h
index 4f766178fa6f..b6dbbe3123a9 100644
--- a/arch/arm64/include/asm/module.h
+++ b/arch/arm64/include/asm/module.h
@@ -39,6 +39,8 @@ struct mod_arch_specific {
 u64 module_emit_plt_entry(struct module *mod, void *loc, const Elf64_Rela *rela,
 			  Elf64_Sym *sym);
 
+u64 module_emit_adrp_veneer(struct module *mod, void *loc, u64 val);
+
 #ifdef CONFIG_RANDOMIZE_BASE
 extern u64 module_alloc_base;
 #else
diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
index 6bf07c602bd4..534bf1d47119 100644
--- a/arch/arm64/kernel/module-plts.c
+++ b/arch/arm64/kernel/module-plts.c
@@ -42,6 +42,47 @@ u64 module_emit_plt_entry(struct module *mod, void *loc, const Elf64_Rela *rela,
 	return (u64)&plt[i];
 }
 
+#ifdef CONFIG_ARM64_ERRATUM_843419
+u64 module_emit_adrp_veneer(struct module *mod, void *loc, u64 val)
+{
+	struct mod_plt_sec *pltsec = !in_init(mod, loc) ? &mod->arch.core :
+							  &mod->arch.init;
+	struct plt_entry *plt = (struct plt_entry *)pltsec->plt->sh_addr;
+	int i = pltsec->plt_num_entries++;
+	u32 mov0, mov1, mov2, br;
+	int rd;
+
+	if (WARN_ON(pltsec->plt_num_entries > pltsec->plt_max_entries))
+		return 0;
+
+	/* get the destination register of the ADRP instruction */
+	rd = aarch64_insn_decode_register(AARCH64_INSN_REGTYPE_RD,
+					  le32_to_cpup((__le32 *)loc));
+
+	/* generate the veneer instructions */
+	mov0 = aarch64_insn_gen_movewide(rd, (u16)~val, 0,
+					 AARCH64_INSN_VARIANT_64BIT,
+					 AARCH64_INSN_MOVEWIDE_INVERSE);
+	mov1 = aarch64_insn_gen_movewide(rd, (u16)(val >> 16), 16,
+					 AARCH64_INSN_VARIANT_64BIT,
+					 AARCH64_INSN_MOVEWIDE_KEEP);
+	mov2 = aarch64_insn_gen_movewide(rd, (u16)(val >> 32), 32,
+					 AARCH64_INSN_VARIANT_64BIT,
+					 AARCH64_INSN_MOVEWIDE_KEEP);
+	br = aarch64_insn_gen_branch_imm((u64)&plt[i].br, (u64)loc + 4,
+					 AARCH64_INSN_BRANCH_NOLINK);
+
+	plt[i] = (struct plt_entry){
+			cpu_to_le32(mov0),
+			cpu_to_le32(mov1),
+			cpu_to_le32(mov2),
+			cpu_to_le32(br)
+		};
+
+	return (u64)&plt[i];
+}
+#endif
+
 #define cmp_3way(a,b)	((a) < (b) ? -1 : (a) > (b))
 
 static int cmp_rela(const void *a, const void *b)
@@ -69,16 +110,21 @@ static bool duplicate_rel(const Elf64_Rela *rela, int num)
 }
 
 static unsigned int count_plts(Elf64_Sym *syms, Elf64_Rela *rela, int num,
-			       Elf64_Word dstidx)
+			       Elf64_Word dstidx, Elf_Shdr *dstsec)
 {
 	unsigned int ret = 0;
 	Elf64_Sym *s;
 	int i;
 
 	for (i = 0; i < num; i++) {
+		u64 min_align;
+
 		switch (ELF64_R_TYPE(rela[i].r_info)) {
 		case R_AARCH64_JUMP26:
 		case R_AARCH64_CALL26:
+			if (!IS_ENABLED(CONFIG_RANDOMIZE_BASE))
+				break;
+
 			/*
 			 * We only have to consider branch targets that resolve
 			 * to symbols that are defined in a different section.
@@ -110,6 +156,40 @@ static unsigned int count_plts(Elf64_Sym *syms, Elf64_Rela *rela, int num,
 			if (rela[i].r_addend != 0 || !duplicate_rel(rela, i))
 				ret++;
 			break;
+		case R_AARCH64_ADR_PREL_PG_HI21_NC:
+		case R_AARCH64_ADR_PREL_PG_HI21:
+			if (!IS_ENABLED(CONFIG_ARM64_ERRATUM_843419))
+				break;
+
+			/*
+			 * Determine the minimal safe alignment for this ADRP
+			 * instruction: the section alignment at which it is
+			 * guaranteed not to appear at a vulnerable offset.
+			 *
+			 * This comes down to finding the least significant zero
+			 * bit in bits [11:3] of the section offset, and
+			 * increasing the section's alignment so that the
+			 * resulting address of this instruction is guaranteed
+			 * to equal the offset in that particular bit (as well
+			 * as all less signficant bits). This ensures that the
+			 * address modulo 4 KB != 0xfff8 or 0xfffc (which would
+			 * have all ones in bits [11:3])
+			 */
+			min_align = 2 << ffz(rela[i].r_offset | 0x7);
+
+			/*
+			 * Allocate veneer space for each ADRP that may appear
+			 *@a vulnerable offset nonetheless. At relocation
+			 * time, some of these will remain unused since some
+			 * ADRP instructions can be patched to ADR instructions
+			 * instead.
+			 */
+			if (min_align > SZ_4K)
+				ret++;
+			else
+				dstsec->sh_addralign = max(dstsec->sh_addralign,
+							   min_align);
+			break;
 		}
 	}
 	return ret;
@@ -167,10 +247,10 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 
 		if (strncmp(secstrings + dstsec->sh_name, ".init", 5) != 0)
 			core_plts += count_plts(syms, rels, numrels,
-						sechdrs[i].sh_info);
+						sechdrs[i].sh_info, dstsec);
 		else
 			init_plts += count_plts(syms, rels, numrels,
-						sechdrs[i].sh_info);
+						sechdrs[i].sh_info, dstsec);
 	}
 
 	mod->arch.core.plt->sh_type = SHT_NOBITS;
diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
index 70c3e5518e95..89217704944e 100644
--- a/arch/arm64/kernel/module.c
+++ b/arch/arm64/kernel/module.c
@@ -198,6 +198,31 @@ static int reloc_insn_imm(enum aarch64_reloc_op op, __le32 *place, u64 val,
 	return 0;
 }
 
+static int reloc_insn_adrp(struct module *mod, __le32 *place, u64 val)
+{
+	if (!IS_ENABLED(CONFIG_ARM64_ERRATUM_843419) ||
+	    ((u64)place & 0xfff) < 0xff8)
+		return reloc_insn_imm(RELOC_OP_PAGE, place, val, 12, 21,
+				      AARCH64_INSN_IMM_ADR);
+
+	/* patch ADRP to ADR if it is in range */
+	if (!reloc_insn_imm(RELOC_OP_PREL, place, val & ~0xfff, 0, 21,
+			    AARCH64_INSN_IMM_ADR)) {
+		((u8 *)place)[3] &= 0x7f; /* clear opcode bit 31 */
+	} else {
+		u32 insn;
+
+		/* out of range for ADR -> emit a veneer */
+		val = module_emit_adrp_veneer(mod, place, val & ~0xfff);
+		if (!val)
+			return -ENOEXEC;
+		insn = aarch64_insn_gen_branch_imm((u64)place, val,
+						   AARCH64_INSN_BRANCH_NOLINK);
+		*place = cpu_to_le32(insn);
+	}
+	return 0;
+}
+
 int apply_relocate_add(Elf64_Shdr *sechdrs,
 		       const char *strtab,
 		       unsigned int symindex,
@@ -337,14 +362,13 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 			ovf = reloc_insn_imm(RELOC_OP_PREL, loc, val, 0, 21,
 					     AARCH64_INSN_IMM_ADR);
 			break;
-#ifndef CONFIG_ARM64_ERRATUM_843419
 		case R_AARCH64_ADR_PREL_PG_HI21_NC:
 			overflow_check = false;
 		case R_AARCH64_ADR_PREL_PG_HI21:
-			ovf = reloc_insn_imm(RELOC_OP_PAGE, loc, val, 12, 21,
-					     AARCH64_INSN_IMM_ADR);
+			ovf = reloc_insn_adrp(me, loc, val);
+			if (ovf && ovf != -ERANGE)
+				return ovf;
 			break;
-#endif
 		case R_AARCH64_ADD_ABS_LO12_NC:
 		case R_AARCH64_LDST8_ABS_LO12_NC:
 			overflow_check = false;
diff --git a/arch/arm64/kernel/reloc_test_core.c b/arch/arm64/kernel/reloc_test_core.c
index c124752a8bd3..a70489c584c7 100644
--- a/arch/arm64/kernel/reloc_test_core.c
+++ b/arch/arm64/kernel/reloc_test_core.c
@@ -28,6 +28,7 @@ asmlinkage u64 absolute_data16(void);
 asmlinkage u64 signed_movw(void);
 asmlinkage u64 unsigned_movw(void);
 asmlinkage u64 relative_adrp(void);
+asmlinkage u64 relative_adrp_far(void);
 asmlinkage u64 relative_adr(void);
 asmlinkage u64 relative_data64(void);
 asmlinkage u64 relative_data32(void);
@@ -43,9 +44,8 @@ static struct {
 	{ "R_AARCH64_ABS16",		absolute_data16, UL(SYM16_ABS_VAL) },
 	{ "R_AARCH64_MOVW_SABS_Gn",	signed_movw, UL(SYM64_ABS_VAL) },
 	{ "R_AARCH64_MOVW_UABS_Gn",	unsigned_movw, UL(SYM64_ABS_VAL) },
-#ifndef CONFIG_ARM64_ERRATUM_843419
 	{ "R_AARCH64_ADR_PREL_PG_HI21",	relative_adrp, (u64)&sym64_rel },
-#endif
+	{ "R_AARCH64_ADR_PREL_PG_HI21",	relative_adrp_far, (u64)&printk },
 	{ "R_AARCH64_ADR_PREL_LO21",	relative_adr, (u64)&sym64_rel },
 	{ "R_AARCH64_PREL64",		relative_data64, (u64)&sym64_rel },
 	{ "R_AARCH64_PREL32",		relative_data32, (u64)&sym64_rel },
diff --git a/arch/arm64/kernel/reloc_test_syms.S b/arch/arm64/kernel/reloc_test_syms.S
index e1edcefeb02d..f333b4b7880d 100644
--- a/arch/arm64/kernel/reloc_test_syms.S
+++ b/arch/arm64/kernel/reloc_test_syms.S
@@ -43,15 +43,21 @@ ENTRY(unsigned_movw)
 	ret
 ENDPROC(unsigned_movw)
 
-#ifndef CONFIG_ARM64_ERRATUM_843419
-
+	.align	12
+	.space	0xff8
 ENTRY(relative_adrp)
 	adrp	x0, sym64_rel
 	add	x0, x0, #:lo12:sym64_rel
 	ret
 ENDPROC(relative_adrp)
 
-#endif
+	.align	12
+	.space	0xffc
+ENTRY(relative_adrp_far)
+	adrp	x0, printk
+	add	x0, x0, #:lo12:printk
+	ret
+ENDPROC(relative_adrp_far)
 
 ENTRY(relative_adr)
 	adr	x0, sym64_rel
-- 
2.11.0
