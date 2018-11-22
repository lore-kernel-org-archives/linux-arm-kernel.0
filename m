From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 22 Nov 2018 09:46:46 +0100
Subject: [PATCH 2/2] arm64/module: switch to ADRP/ADD sequences for PLT entries
In-Reply-To: <20181122084646.3247-1-ard.biesheuvel@linaro.org>
References: <20181122084646.3247-1-ard.biesheuvel@linaro.org>
Message-ID: <20181122084646.3247-3-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have switched to the small code model entirely, and
reduced the extended KASLR range to 4 GB, we can be sure that the
targets of relative branches that are out of range are in range
for a ADRP/ADD pair, which is one instruction shorter than our
current MOVN/MOVK/MOVK sequence, and is more idiomatic and so it
is more likely to be implemented efficiently by micro-architectures.

So switch over the ordinary PLT code and the special handling of
the Cortex-A53 ADRP errata, as well as the ftrace trampline
handling.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/module.h | 36 ++------
 arch/arm64/kernel/ftrace.c      |  2 +-
 arch/arm64/kernel/module-plts.c | 93 +++++++++++++++-----
 arch/arm64/kernel/module.c      |  4 +-
 4 files changed, 82 insertions(+), 53 deletions(-)

diff --git a/arch/arm64/include/asm/module.h b/arch/arm64/include/asm/module.h
index 97d0ef12e2ff..9ce31b056ac9 100644
--- a/arch/arm64/include/asm/module.h
+++ b/arch/arm64/include/asm/module.h
@@ -56,39 +56,19 @@ struct plt_entry {
 	 * is exactly what we are dealing with here, we are free to use x16
 	 * as a scratch register in the PLT veneers.
 	 */
-	__le32	mov0;	/* movn	x16, #0x....			*/
-	__le32	mov1;	/* movk	x16, #0x...., lsl #16		*/
-	__le32	mov2;	/* movk	x16, #0x...., lsl #32		*/
+	__le32	adrp;	/* adrp	x16, ....			*/
+	__le32	add;	/* add	x16, x16, #0x....		*/
 	__le32	br;	/* br	x16				*/
 };
 
-static inline struct plt_entry get_plt_entry(u64 val)
+static inline bool is_forbidden_offset_for_adrp(void *place)
 {
-	/*
-	 * MOVK/MOVN/MOVZ opcode:
-	 * +--------+------------+--------+-----------+-------------+---------+
-	 * | sf[31] | opc[30:29] | 100101 | hw[22:21] | imm16[20:5] | Rd[4:0] |
-	 * +--------+------------+--------+-----------+-------------+---------+
-	 *
-	 * Rd     := 0x10 (x16)
-	 * hw     := 0b00 (no shift), 0b01 (lsl #16), 0b10 (lsl #32)
-	 * opc    := 0b11 (MOVK), 0b00 (MOVN), 0b10 (MOVZ)
-	 * sf     := 1 (64-bit variant)
-	 */
-	return (struct plt_entry){
-		cpu_to_le32(0x92800010 | (((~val      ) & 0xffff)) << 5),
-		cpu_to_le32(0xf2a00010 | ((( val >> 16) & 0xffff)) << 5),
-		cpu_to_le32(0xf2c00010 | ((( val >> 32) & 0xffff)) << 5),
-		cpu_to_le32(0xd61f0200)
-	};
+	return IS_ENABLED(CONFIG_ARM64_ERRATUM_843419) &&
+	       cpus_have_const_cap(ARM64_WORKAROUND_843419) &&
+	       ((u64)place & 0xfff) >= 0xff8;
 }
 
-static inline bool plt_entries_equal(const struct plt_entry *a,
-				     const struct plt_entry *b)
-{
-	return a->mov0 == b->mov0 &&
-	       a->mov1 == b->mov1 &&
-	       a->mov2 == b->mov2;
-}
+struct plt_entry get_plt_entry(u64 dst, void *pc);
+bool plt_entries_equal(const struct plt_entry *a, const struct plt_entry *b);
 
 #endif /* __ASM_MODULE_H */
diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index 50986e388d2b..2135665a8ab3 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -104,7 +104,7 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 		 * is added in the future, but for now, the pr_err() below
 		 * deals with a theoretical issue only.
 		 */
-		trampoline = get_plt_entry(addr);
+		trampoline = get_plt_entry(addr, mod->arch.ftrace_trampoline);
 		if (!plt_entries_equal(mod->arch.ftrace_trampoline,
 				       &trampoline)) {
 			if (!plt_entries_equal(mod->arch.ftrace_trampoline,
diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
index f0690c2ca3e0..3c6e5f3a4973 100644
--- a/arch/arm64/kernel/module-plts.c
+++ b/arch/arm64/kernel/module-plts.c
@@ -11,6 +11,55 @@
 #include <linux/module.h>
 #include <linux/sort.h>
 
+static struct plt_entry __get_adrp_add_pair(u64 dst, u64 pc,
+					    enum aarch64_insn_register reg)
+{
+	u32 adrp, add;
+
+	adrp = aarch64_insn_gen_adr(pc, dst, reg, AARCH64_INSN_ADR_TYPE_ADRP);
+	add = aarch64_insn_gen_add_sub_imm(reg, reg, dst % SZ_4K,
+					   AARCH64_INSN_VARIANT_64BIT,
+					   AARCH64_INSN_ADSB_ADD);
+
+	return (struct plt_entry){ cpu_to_le32(adrp), cpu_to_le32(add) };
+}
+
+struct plt_entry get_plt_entry(u64 dst, void *pc)
+{
+	struct plt_entry plt;
+	static u32 br;
+
+	if (!br)
+		br = aarch64_insn_gen_branch_reg(AARCH64_INSN_REG_16,
+						 AARCH64_INSN_BRANCH_NOLINK);
+
+	plt = __get_adrp_add_pair(dst, (u64)pc, AARCH64_INSN_REG_16);
+	plt.br = cpu_to_le32(br);
+
+	return plt;
+}
+
+bool plt_entries_equal(const struct plt_entry *a, const struct plt_entry *b)
+{
+	u64 p, q;
+
+	/*
+	 * Check whether both entries refer to the same target:
+	 * do the cheapest checks first.
+	 */
+	if (a->add != b->add || a->br != b->br)
+		return false;
+
+	p = ALIGN_DOWN((u64)a, SZ_4K);
+	q = ALIGN_DOWN((u64)b, SZ_4K);
+
+	if (a->adrp == b->adrp && p == q)
+		return true;
+
+	return (p + aarch64_insn_adrp_get_offset(le32_to_cpu(a->adrp))) ==
+	       (q + aarch64_insn_adrp_get_offset(le32_to_cpu(b->adrp)));
+}
+
 static bool in_init(const struct module *mod, void *loc)
 {
 	return (u64)loc - (u64)mod->init_layout.base < mod->init_layout.size;
@@ -23,19 +72,23 @@ u64 module_emit_plt_entry(struct module *mod, void *loc, const Elf64_Rela *rela,
 							  &mod->arch.init;
 	struct plt_entry *plt = (struct plt_entry *)pltsec->plt->sh_addr;
 	int i = pltsec->plt_num_entries;
+	int j = i - 1;
 	u64 val = sym->st_value + rela->r_addend;
 
-	plt[i] = get_plt_entry(val);
+	if (is_forbidden_offset_for_adrp(&plt[i].adrp))
+		i++;
+
+	plt[i] = get_plt_entry(val, &plt[i]);
 
 	/*
 	 * Check if the entry we just created is a duplicate. Given that the
 	 * relocations are sorted, this will be the last entry we allocated.
 	 * (if one exists).
 	 */
-	if (i > 0 && plt_entries_equal(plt + i, plt + i - 1))
-		return (u64)&plt[i - 1];
+	if (j >= 0 && plt_entries_equal(plt + i, plt + j))
+		return (u64)&plt[j];
 
-	pltsec->plt_num_entries++;
+	pltsec->plt_num_entries += i - j;
 	if (WARN_ON(pltsec->plt_num_entries > pltsec->plt_max_entries))
 		return 0;
 
@@ -49,35 +102,24 @@ u64 module_emit_veneer_for_adrp(struct module *mod, void *loc, u64 val)
 							  &mod->arch.init;
 	struct plt_entry *plt = (struct plt_entry *)pltsec->plt->sh_addr;
 	int i = pltsec->plt_num_entries++;
-	u32 mov0, mov1, mov2, br;
+	u32 br;
 	int rd;
 
 	if (WARN_ON(pltsec->plt_num_entries > pltsec->plt_max_entries))
 		return 0;
 
+	if (is_forbidden_offset_for_adrp(&plt[i].adrp))
+		i = pltsec->plt_num_entries++;
+
 	/* get the destination register of the ADRP instruction */
 	rd = aarch64_insn_decode_register(AARCH64_INSN_REGTYPE_RD,
 					  le32_to_cpup((__le32 *)loc));
 
-	/* generate the veneer instructions */
-	mov0 = aarch64_insn_gen_movewide(rd, (u16)~val, 0,
-					 AARCH64_INSN_VARIANT_64BIT,
-					 AARCH64_INSN_MOVEWIDE_INVERSE);
-	mov1 = aarch64_insn_gen_movewide(rd, (u16)(val >> 16), 16,
-					 AARCH64_INSN_VARIANT_64BIT,
-					 AARCH64_INSN_MOVEWIDE_KEEP);
-	mov2 = aarch64_insn_gen_movewide(rd, (u16)(val >> 32), 32,
-					 AARCH64_INSN_VARIANT_64BIT,
-					 AARCH64_INSN_MOVEWIDE_KEEP);
 	br = aarch64_insn_gen_branch_imm((u64)&plt[i].br, (u64)loc + 4,
 					 AARCH64_INSN_BRANCH_NOLINK);
 
-	plt[i] = (struct plt_entry){
-			cpu_to_le32(mov0),
-			cpu_to_le32(mov1),
-			cpu_to_le32(mov2),
-			cpu_to_le32(br)
-		};
+	plt[i] = __get_adrp_add_pair(val, (u64)&plt[i], rd);
+	plt[i].br = cpu_to_le32(br);
 
 	return (u64)&plt[i];
 }
@@ -193,6 +235,15 @@ static unsigned int count_plts(Elf64_Sym *syms, Elf64_Rela *rela, int num,
 			break;
 		}
 	}
+
+	if (IS_ENABLED(CONFIG_ARM64_ERRATUM_843419) &&
+	    cpus_have_const_cap(ARM64_WORKAROUND_843419))
+		/*
+		 * Add some slack so we can skip PLT slots that may trigger
+		 * the erratum due to the placement of the ADRP instruction.
+		 */
+		ret += DIV_ROUND_UP(ret, (SZ_4K / sizeof(struct plt_entry)));
+
 	return ret;
 }
 
diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
index f0f27aeefb73..3b6dc4ce7ec7 100644
--- a/arch/arm64/kernel/module.c
+++ b/arch/arm64/kernel/module.c
@@ -202,9 +202,7 @@ static int reloc_insn_adrp(struct module *mod, __le32 *place, u64 val)
 {
 	u32 insn;
 
-	if (!IS_ENABLED(CONFIG_ARM64_ERRATUM_843419) ||
-	    !cpus_have_const_cap(ARM64_WORKAROUND_843419) ||
-	    ((u64)place & 0xfff) < 0xff8)
+	if (!is_forbidden_offset_for_adrp(place))
 		return reloc_insn_imm(RELOC_OP_PAGE, place, val, 12, 21,
 				      AARCH64_INSN_IMM_ADR);
 
-- 
2.17.1
