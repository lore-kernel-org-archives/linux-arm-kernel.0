From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 19 Mar 2015 13:59:32 +0000
Subject: [PATCH 1/5] arm64: insn: Add aarch64_insn_decode_immediate
In-Reply-To: <1426773576-14062-1-git-send-email-marc.zyngier@arm.com>
References: <1426773576-14062-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1426773576-14062-2-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patching an instruction sometimes requires extracting the immediate
field from this instruction. To facilitate this, and avoid
potential duplication of code, add aarch64_insn_decode_immediate
as the reciprocal to aarch64_insn_encode_immediate.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/insn.h |  1 +
 arch/arm64/kernel/insn.c      | 81 ++++++++++++++++++++++++++++++++++---------
 2 files changed, 66 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index d2f4942..f81b328 100644
--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -285,6 +285,7 @@ bool aarch64_insn_is_nop(u32 insn);
 int aarch64_insn_read(void *addr, u32 *insnp);
 int aarch64_insn_write(void *addr, u32 insn);
 enum aarch64_insn_encoding_class aarch64_get_insn_class(u32 insn);
+u64 aarch64_insn_decode_immediate(enum aarch64_insn_imm_type type, u32 insn);
 u32 aarch64_insn_encode_immediate(enum aarch64_insn_imm_type type,
 				  u32 insn, u64 imm);
 u32 aarch64_insn_gen_branch_imm(unsigned long pc, unsigned long addr,
diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
index c8eca88..9249020 100644
--- a/arch/arm64/kernel/insn.c
+++ b/arch/arm64/kernel/insn.c
@@ -265,23 +265,13 @@ int __kprobes aarch64_insn_patch_text(void *addrs[], u32 insns[], int cnt)
 	return aarch64_insn_patch_text_sync(addrs, insns, cnt);
 }
 
-u32 __kprobes aarch64_insn_encode_immediate(enum aarch64_insn_imm_type type,
-				  u32 insn, u64 imm)
+static int __kprobes aarch64_get_imm_shift_mask(enum aarch64_insn_imm_type type,
+						u32 *maskp, int *shiftp)
 {
-	u32 immlo, immhi, lomask, himask, mask;
+	u32 mask;
 	int shift;
 
 	switch (type) {
-	case AARCH64_INSN_IMM_ADR:
-		lomask = 0x3;
-		himask = 0x7ffff;
-		immlo = imm & lomask;
-		imm >>= 2;
-		immhi = imm & himask;
-		imm = (immlo << 24) | (immhi);
-		mask = (lomask << 24) | (himask);
-		shift = 5;
-		break;
 	case AARCH64_INSN_IMM_26:
 		mask = BIT(26) - 1;
 		shift = 0;
@@ -320,9 +310,68 @@ u32 __kprobes aarch64_insn_encode_immediate(enum aarch64_insn_imm_type type,
 		shift = 16;
 		break;
 	default:
-		pr_err("aarch64_insn_encode_immediate: unknown immediate encoding %d\n",
-			type);
-		return 0;
+		return -EINVAL;
+	}
+
+	*maskp = mask;
+	*shiftp = shift;
+
+	return 0;
+}
+
+#define ADR_IMM_HILOSPLIT	2
+#define ADR_IMM_SIZE		SZ_2M
+#define ADR_IMM_LOMASK		((1 << ADR_IMM_HILOSPLIT) - 1)
+#define ADR_IMM_HIMASK		((ADR_IMM_SIZE >> ADR_IMM_HILOSPLIT) - 1)
+#define ADR_IMM_LOSHIFT		29
+#define ADR_IMM_HISHIFT		5
+
+u64 aarch64_insn_decode_immediate(enum aarch64_insn_imm_type type, u32 insn)
+{
+	u32 immlo, immhi, mask;
+	int shift;
+
+	switch (type) {
+	case AARCH64_INSN_IMM_ADR:
+		shift = 0;
+		immlo = (insn >> ADR_IMM_LOSHIFT) & ADR_IMM_LOMASK;
+		immhi = (insn >> ADR_IMM_HISHIFT) & ADR_IMM_HIMASK;
+		insn = (immhi << ADR_IMM_HILOSPLIT) | immlo;
+		mask = ADR_IMM_SIZE - 1;
+		break;
+	default:
+		if (aarch64_get_imm_shift_mask(type, &mask, &shift) < 0) {
+			pr_err("aarch64_insn_decode_immediate: unknown immediate encoding %d\n",
+			       type);
+			return 0;
+		}
+	}
+
+	return (insn >> shift) & mask;
+}
+
+u32 __kprobes aarch64_insn_encode_immediate(enum aarch64_insn_imm_type type,
+				  u32 insn, u64 imm)
+{
+	u32 immlo, immhi, mask;
+	int shift;
+
+	switch (type) {
+	case AARCH64_INSN_IMM_ADR:
+		shift = 0;
+		immlo = (imm & ADR_IMM_LOMASK) << ADR_IMM_LOSHIFT;
+		imm >>= ADR_IMM_HILOSPLIT;
+		immhi = (imm & ADR_IMM_HIMASK) << ADR_IMM_HISHIFT;
+		imm = immlo | immhi;
+		mask = ((ADR_IMM_LOMASK << ADR_IMM_LOSHIFT) |
+			(ADR_IMM_HIMASK << ADR_IMM_HISHIFT));
+		break;
+	default:
+		if (aarch64_get_imm_shift_mask(type, &mask, &shift) < 0) {
+			pr_err("aarch64_insn_encode_immediate: unknown immediate encoding %d\n",
+			       type);
+			return 0;
+		}
 	}
 
 	/* Update the immediate field. */
-- 
2.1.4
