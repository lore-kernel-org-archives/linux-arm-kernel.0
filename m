From: huawei.libin@huawei.com (Li Bin)
Date: Mon, 14 Dec 2015 20:49:37 +0800
Subject: [RFC PATCH 2/3] livepatch: module: arm64: extract the relocation code
 for reuse
In-Reply-To: <1450097378-3780-1-git-send-email-huawei.libin@huawei.com>
References: <1450097378-3780-1-git-send-email-huawei.libin@huawei.com>
Message-ID: <1450097378-3780-3-git-send-email-huawei.libin@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Livepatch can reuse the relocation codes of module loader, this
patch extract it.

Signed-off-by: Li Bin <huawei.libin@huawei.com>
---
 arch/arm64/include/asm/module.h |    3 +
 arch/arm64/kernel/module.c      |  360 ++++++++++++++++++++-------------------
 2 files changed, 187 insertions(+), 176 deletions(-)

diff --git a/arch/arm64/include/asm/module.h b/arch/arm64/include/asm/module.h
index e80e232..78ac36e 100644
--- a/arch/arm64/include/asm/module.h
+++ b/arch/arm64/include/asm/module.h
@@ -20,4 +20,7 @@
 
 #define MODULE_ARCH_VERMAGIC	"aarch64"
 
+extern int static_relocate(struct module *mod, unsigned long type,
+			   void * loc, unsigned long value);
+
 #endif /* __ASM_MODULE_H */
diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
index f4bc779..6d1a1e3 100644
--- a/arch/arm64/kernel/module.c
+++ b/arch/arm64/kernel/module.c
@@ -203,6 +203,184 @@ static int reloc_insn_imm(enum aarch64_reloc_op op, void *place, u64 val,
 	return 0;
 }
 
+int static_relocate(struct module *me, unsigned long type, void *loc,
+		    unsigned long val)
+{
+	int ovf = 0;
+	bool overflow_check = true;
+	/* Perform the static relocation. */
+	switch (type) {
+	/* Null relocations. */
+	case R_ARM_NONE:
+	case R_AARCH64_NONE:
+		ovf = 0;
+		break;
+
+		/* Data relocations. */
+	case R_AARCH64_ABS64:
+		overflow_check = false;
+		ovf = reloc_data(RELOC_OP_ABS, loc, val, 64);
+		break;
+	case R_AARCH64_ABS32:
+		ovf = reloc_data(RELOC_OP_ABS, loc, val, 32);
+		break;
+	case R_AARCH64_ABS16:
+		ovf = reloc_data(RELOC_OP_ABS, loc, val, 16);
+		break;
+	case R_AARCH64_PREL64:
+		overflow_check = false;
+		ovf = reloc_data(RELOC_OP_PREL, loc, val, 64);
+		break;
+	case R_AARCH64_PREL32:
+		ovf = reloc_data(RELOC_OP_PREL, loc, val, 32);
+		break;
+	case R_AARCH64_PREL16:
+		ovf = reloc_data(RELOC_OP_PREL, loc, val, 16);
+		break;
+
+		/* MOVW instruction relocations. */
+	case R_AARCH64_MOVW_UABS_G0_NC:
+		overflow_check = false;
+	case R_AARCH64_MOVW_UABS_G0:
+		ovf = reloc_insn_movw(RELOC_OP_ABS, loc, val, 0,
+				      AARCH64_INSN_IMM_16);
+		break;
+	case R_AARCH64_MOVW_UABS_G1_NC:
+		overflow_check = false;
+	case R_AARCH64_MOVW_UABS_G1:
+		ovf = reloc_insn_movw(RELOC_OP_ABS, loc, val, 16,
+				      AARCH64_INSN_IMM_16);
+		break;
+	case R_AARCH64_MOVW_UABS_G2_NC:
+		overflow_check = false;
+	case R_AARCH64_MOVW_UABS_G2:
+		ovf = reloc_insn_movw(RELOC_OP_ABS, loc, val, 32,
+				      AARCH64_INSN_IMM_16);
+		break;
+	case R_AARCH64_MOVW_UABS_G3:
+		/* We're using the top bits so we can't overflow. */
+		overflow_check = false;
+		ovf = reloc_insn_movw(RELOC_OP_ABS, loc, val, 48,
+				      AARCH64_INSN_IMM_16);
+		break;
+	case R_AARCH64_MOVW_SABS_G0:
+		ovf = reloc_insn_movw(RELOC_OP_ABS, loc, val, 0,
+				      AARCH64_INSN_IMM_MOVNZ);
+		break;
+	case R_AARCH64_MOVW_SABS_G1:
+		ovf = reloc_insn_movw(RELOC_OP_ABS, loc, val, 16,
+				      AARCH64_INSN_IMM_MOVNZ);
+		break;
+	case R_AARCH64_MOVW_SABS_G2:
+		ovf = reloc_insn_movw(RELOC_OP_ABS, loc, val, 32,
+				      AARCH64_INSN_IMM_MOVNZ);
+		break;
+	case R_AARCH64_MOVW_PREL_G0_NC:
+		overflow_check = false;
+		ovf = reloc_insn_movw(RELOC_OP_PREL, loc, val, 0,
+				      AARCH64_INSN_IMM_MOVK);
+		break;
+	case R_AARCH64_MOVW_PREL_G0:
+		ovf = reloc_insn_movw(RELOC_OP_PREL, loc, val, 0,
+				      AARCH64_INSN_IMM_MOVNZ);
+		break;
+	case R_AARCH64_MOVW_PREL_G1_NC:
+		overflow_check = false;
+		ovf = reloc_insn_movw(RELOC_OP_PREL, loc, val, 16,
+				      AARCH64_INSN_IMM_MOVK);
+		break;
+	case R_AARCH64_MOVW_PREL_G1:
+		ovf = reloc_insn_movw(RELOC_OP_PREL, loc, val, 16,
+				      AARCH64_INSN_IMM_MOVNZ);
+		break;
+	case R_AARCH64_MOVW_PREL_G2_NC:
+		overflow_check = false;
+		ovf = reloc_insn_movw(RELOC_OP_PREL, loc, val, 32,
+				      AARCH64_INSN_IMM_MOVK);
+		break;
+	case R_AARCH64_MOVW_PREL_G2:
+		ovf = reloc_insn_movw(RELOC_OP_PREL, loc, val, 32,
+				      AARCH64_INSN_IMM_MOVNZ);
+		break;
+	case R_AARCH64_MOVW_PREL_G3:
+		/* We're using the top bits so we can't overflow. */
+		overflow_check = false;
+		ovf = reloc_insn_movw(RELOC_OP_PREL, loc, val, 48,
+				      AARCH64_INSN_IMM_MOVNZ);
+		break;
+
+		/* Immediate instruction relocations. */
+	case R_AARCH64_LD_PREL_LO19:
+		ovf = reloc_insn_imm(RELOC_OP_PREL, loc, val, 2, 19,
+				     AARCH64_INSN_IMM_19);
+		break;
+	case R_AARCH64_ADR_PREL_LO21:
+		ovf = reloc_insn_imm(RELOC_OP_PREL, loc, val, 0, 21,
+				     AARCH64_INSN_IMM_ADR);
+		break;
+#ifndef CONFIG_ARM64_ERRATUM_843419
+	case R_AARCH64_ADR_PREL_PG_HI21_NC:
+		overflow_check = false;
+	case R_AARCH64_ADR_PREL_PG_HI21:
+		ovf = reloc_insn_imm(RELOC_OP_PAGE, loc, val, 12, 21,
+				     AARCH64_INSN_IMM_ADR);
+		break;
+#endif
+	case R_AARCH64_ADD_ABS_LO12_NC:
+	case R_AARCH64_LDST8_ABS_LO12_NC:
+		overflow_check = false;
+		ovf = reloc_insn_imm(RELOC_OP_ABS, loc, val, 0, 12,
+				     AARCH64_INSN_IMM_12);
+		break;
+	case R_AARCH64_LDST16_ABS_LO12_NC:
+		overflow_check = false;
+		ovf = reloc_insn_imm(RELOC_OP_ABS, loc, val, 1, 11,
+				     AARCH64_INSN_IMM_12);
+		break;
+	case R_AARCH64_LDST32_ABS_LO12_NC:
+		overflow_check = false;
+		ovf = reloc_insn_imm(RELOC_OP_ABS, loc, val, 2, 10,
+				     AARCH64_INSN_IMM_12);
+		break;
+	case R_AARCH64_LDST64_ABS_LO12_NC:
+		overflow_check = false;
+		ovf = reloc_insn_imm(RELOC_OP_ABS, loc, val, 3, 9,
+				     AARCH64_INSN_IMM_12);
+		break;
+	case R_AARCH64_LDST128_ABS_LO12_NC:
+		overflow_check = false;
+		ovf = reloc_insn_imm(RELOC_OP_ABS, loc, val, 4, 8,
+				     AARCH64_INSN_IMM_12);
+		break;
+	case R_AARCH64_TSTBR14:
+		ovf = reloc_insn_imm(RELOC_OP_PREL, loc, val, 2, 14,
+				     AARCH64_INSN_IMM_14);
+		break;
+	case R_AARCH64_CONDBR19:
+		ovf = reloc_insn_imm(RELOC_OP_PREL, loc, val, 2, 19,
+				     AARCH64_INSN_IMM_19);
+		break;
+	case R_AARCH64_JUMP26:
+	case R_AARCH64_CALL26:
+		ovf = reloc_insn_imm(RELOC_OP_PREL, loc, val, 2, 26,
+				     AARCH64_INSN_IMM_26);
+		break;
+
+	default:
+		pr_err("module %s: unsupported RELA relocation: %lu\n",
+			me->name, type);
+		return -ENOEXEC;
+	}
+
+	if (overflow_check && ovf == -ERANGE) {
+		pr_err("module %s: overflow in relocation type %lu val %lx\n",
+			me->name, type, val);
+		return -ENOEXEC;
+	}
+
+	return 0;
+}
+
 int apply_relocate_add(Elf64_Shdr *sechdrs,
 		       const char *strtab,
 		       unsigned int symindex,
@@ -210,12 +388,11 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 		       struct module *me)
 {
 	unsigned int i;
-	int ovf;
-	bool overflow_check;
 	Elf64_Sym *sym;
 	void *loc;
 	u64 val;
 	Elf64_Rela *rel = (void *)sechdrs[relsec].sh_addr;
+	int type, ret;
 
 	for (i = 0; i < sechdrs[relsec].sh_size / sizeof(*rel); i++) {
 		/* loc corresponds to P in the AArch64 ELF document. */
@@ -229,184 +406,15 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 		/* val corresponds to (S + A) in the AArch64 ELF document. */
 		val = sym->st_value + rel[i].r_addend;
 
-		/* Check for overflow by default. */
-		overflow_check = true;
-
-		/* Perform the static relocation. */
-		switch (ELF64_R_TYPE(rel[i].r_info)) {
-		/* Null relocations. */
-		case R_ARM_NONE:
-		case R_AARCH64_NONE:
-			ovf = 0;
-			break;
-
-		/* Data relocations. */
-		case R_AARCH64_ABS64:
-			overflow_check = false;
-			ovf = reloc_data(RELOC_OP_ABS, loc, val, 64);
-			break;
-		case R_AARCH64_ABS32:
-			ovf = reloc_data(RELOC_OP_ABS, loc, val, 32);
-			break;
-		case R_AARCH64_ABS16:
-			ovf = reloc_data(RELOC_OP_ABS, loc, val, 16);
-			break;
-		case R_AARCH64_PREL64:
-			overflow_check = false;
-			ovf = reloc_data(RELOC_OP_PREL, loc, val, 64);
-			break;
-		case R_AARCH64_PREL32:
-			ovf = reloc_data(RELOC_OP_PREL, loc, val, 32);
-			break;
-		case R_AARCH64_PREL16:
-			ovf = reloc_data(RELOC_OP_PREL, loc, val, 16);
-			break;
-
-		/* MOVW instruction relocations. */
-		case R_AARCH64_MOVW_UABS_G0_NC:
-			overflow_check = false;
-		case R_AARCH64_MOVW_UABS_G0:
-			ovf = reloc_insn_movw(RELOC_OP_ABS, loc, val, 0,
-					      AARCH64_INSN_IMM_16);
-			break;
-		case R_AARCH64_MOVW_UABS_G1_NC:
-			overflow_check = false;
-		case R_AARCH64_MOVW_UABS_G1:
-			ovf = reloc_insn_movw(RELOC_OP_ABS, loc, val, 16,
-					      AARCH64_INSN_IMM_16);
-			break;
-		case R_AARCH64_MOVW_UABS_G2_NC:
-			overflow_check = false;
-		case R_AARCH64_MOVW_UABS_G2:
-			ovf = reloc_insn_movw(RELOC_OP_ABS, loc, val, 32,
-					      AARCH64_INSN_IMM_16);
-			break;
-		case R_AARCH64_MOVW_UABS_G3:
-			/* We're using the top bits so we can't overflow. */
-			overflow_check = false;
-			ovf = reloc_insn_movw(RELOC_OP_ABS, loc, val, 48,
-					      AARCH64_INSN_IMM_16);
-			break;
-		case R_AARCH64_MOVW_SABS_G0:
-			ovf = reloc_insn_movw(RELOC_OP_ABS, loc, val, 0,
-					      AARCH64_INSN_IMM_MOVNZ);
-			break;
-		case R_AARCH64_MOVW_SABS_G1:
-			ovf = reloc_insn_movw(RELOC_OP_ABS, loc, val, 16,
-					      AARCH64_INSN_IMM_MOVNZ);
-			break;
-		case R_AARCH64_MOVW_SABS_G2:
-			ovf = reloc_insn_movw(RELOC_OP_ABS, loc, val, 32,
-					      AARCH64_INSN_IMM_MOVNZ);
-			break;
-		case R_AARCH64_MOVW_PREL_G0_NC:
-			overflow_check = false;
-			ovf = reloc_insn_movw(RELOC_OP_PREL, loc, val, 0,
-					      AARCH64_INSN_IMM_MOVK);
-			break;
-		case R_AARCH64_MOVW_PREL_G0:
-			ovf = reloc_insn_movw(RELOC_OP_PREL, loc, val, 0,
-					      AARCH64_INSN_IMM_MOVNZ);
-			break;
-		case R_AARCH64_MOVW_PREL_G1_NC:
-			overflow_check = false;
-			ovf = reloc_insn_movw(RELOC_OP_PREL, loc, val, 16,
-					      AARCH64_INSN_IMM_MOVK);
-			break;
-		case R_AARCH64_MOVW_PREL_G1:
-			ovf = reloc_insn_movw(RELOC_OP_PREL, loc, val, 16,
-					      AARCH64_INSN_IMM_MOVNZ);
-			break;
-		case R_AARCH64_MOVW_PREL_G2_NC:
-			overflow_check = false;
-			ovf = reloc_insn_movw(RELOC_OP_PREL, loc, val, 32,
-					      AARCH64_INSN_IMM_MOVK);
-			break;
-		case R_AARCH64_MOVW_PREL_G2:
-			ovf = reloc_insn_movw(RELOC_OP_PREL, loc, val, 32,
-					      AARCH64_INSN_IMM_MOVNZ);
-			break;
-		case R_AARCH64_MOVW_PREL_G3:
-			/* We're using the top bits so we can't overflow. */
-			overflow_check = false;
-			ovf = reloc_insn_movw(RELOC_OP_PREL, loc, val, 48,
-					      AARCH64_INSN_IMM_MOVNZ);
-			break;
-
-		/* Immediate instruction relocations. */
-		case R_AARCH64_LD_PREL_LO19:
-			ovf = reloc_insn_imm(RELOC_OP_PREL, loc, val, 2, 19,
-					     AARCH64_INSN_IMM_19);
-			break;
-		case R_AARCH64_ADR_PREL_LO21:
-			ovf = reloc_insn_imm(RELOC_OP_PREL, loc, val, 0, 21,
-					     AARCH64_INSN_IMM_ADR);
-			break;
-#ifndef CONFIG_ARM64_ERRATUM_843419
-		case R_AARCH64_ADR_PREL_PG_HI21_NC:
-			overflow_check = false;
-		case R_AARCH64_ADR_PREL_PG_HI21:
-			ovf = reloc_insn_imm(RELOC_OP_PAGE, loc, val, 12, 21,
-					     AARCH64_INSN_IMM_ADR);
-			break;
-#endif
-		case R_AARCH64_ADD_ABS_LO12_NC:
-		case R_AARCH64_LDST8_ABS_LO12_NC:
-			overflow_check = false;
-			ovf = reloc_insn_imm(RELOC_OP_ABS, loc, val, 0, 12,
-					     AARCH64_INSN_IMM_12);
-			break;
-		case R_AARCH64_LDST16_ABS_LO12_NC:
-			overflow_check = false;
-			ovf = reloc_insn_imm(RELOC_OP_ABS, loc, val, 1, 11,
-					     AARCH64_INSN_IMM_12);
-			break;
-		case R_AARCH64_LDST32_ABS_LO12_NC:
-			overflow_check = false;
-			ovf = reloc_insn_imm(RELOC_OP_ABS, loc, val, 2, 10,
-					     AARCH64_INSN_IMM_12);
-			break;
-		case R_AARCH64_LDST64_ABS_LO12_NC:
-			overflow_check = false;
-			ovf = reloc_insn_imm(RELOC_OP_ABS, loc, val, 3, 9,
-					     AARCH64_INSN_IMM_12);
-			break;
-		case R_AARCH64_LDST128_ABS_LO12_NC:
-			overflow_check = false;
-			ovf = reloc_insn_imm(RELOC_OP_ABS, loc, val, 4, 8,
-					     AARCH64_INSN_IMM_12);
-			break;
-		case R_AARCH64_TSTBR14:
-			ovf = reloc_insn_imm(RELOC_OP_PREL, loc, val, 2, 14,
-					     AARCH64_INSN_IMM_14);
-			break;
-		case R_AARCH64_CONDBR19:
-			ovf = reloc_insn_imm(RELOC_OP_PREL, loc, val, 2, 19,
-					     AARCH64_INSN_IMM_19);
-			break;
-		case R_AARCH64_JUMP26:
-		case R_AARCH64_CALL26:
-			ovf = reloc_insn_imm(RELOC_OP_PREL, loc, val, 2, 26,
-					     AARCH64_INSN_IMM_26);
-			break;
-
-		default:
-			pr_err("module %s: unsupported RELA relocation: %llu\n",
-			       me->name, ELF64_R_TYPE(rel[i].r_info));
-			return -ENOEXEC;
-		}
-
-		if (overflow_check && ovf == -ERANGE)
-			goto overflow;
+		type = ELF64_R_TYPE(rel[i].r_info);
 
+		/* Check for overflow by default. */
+		ret = static_relocate(me, type, loc, val);
+		if (ret)
+			return ret;
 	}
 
 	return 0;
-
-overflow:
-	pr_err("module %s: overflow in relocation type %d val %Lx\n",
-	       me->name, (int)ELF64_R_TYPE(rel[i].r_info), val);
-	return -ENOEXEC;
 }
 
 int module_finalize(const Elf_Ehdr *hdr,
-- 
1.7.1
