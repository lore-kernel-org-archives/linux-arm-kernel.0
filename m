From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Fri,  8 Jul 2016 12:37:14 +0100
Subject: [PATCH 4/8] arm64/insn: Add helpers for pc relative data processing
 instructions
In-Reply-To: <1467977839-27543-1-git-send-email-suzuki.poulose@arm.com>
References: <1467977839-27543-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1467977839-27543-6-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds helpers for decoding/encoding the PC relative addresses for
Data processing instructions (i.e, adr and adrp). This will be used
for handling dynamic patching of 'adr/adrp' instructions in alternative
code patching.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/insn.h |  5 +++++
 arch/arm64/kernel/insn.c      | 23 +++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index 30e50eb..03dc4c2 100644
--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -277,6 +277,8 @@ __AARCH64_INSN_FUNCS(hint,	0xFFFFF01F, 0xD503201F)
 __AARCH64_INSN_FUNCS(br,	0xFFFFFC1F, 0xD61F0000)
 __AARCH64_INSN_FUNCS(blr,	0xFFFFFC1F, 0xD63F0000)
 __AARCH64_INSN_FUNCS(ret,	0xFFFFFC1F, 0xD65F0000)
+__AARCH64_INSN_FUNCS(adrp,	0x9F000000, 0x90000000)
+__AARCH64_INSN_FUNCS(adr,	0x9F000000, 0x10000000)
 
 #undef	__AARCH64_INSN_FUNCS
 
@@ -355,6 +357,9 @@ u32 aarch64_insn_gen_logical_shifted_reg(enum aarch64_insn_register dst,
 s32 aarch64_get_branch_offset(u32 insn);
 u32 aarch64_set_branch_offset(u32 insn, s32 offset);
 
+s32 aarch64_get_addr_offset(u32 insn);
+u32 aarch64_set_addr_offset(u32 insn, s32 offset);
+
 bool aarch64_insn_hotpatch_safe(u32 old_insn, u32 new_insn);
 
 int aarch64_insn_patch_text_nosync(void *addr, u32 insn);
diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
index 368c082..3edd741 100644
--- a/arch/arm64/kernel/insn.c
+++ b/arch/arm64/kernel/insn.c
@@ -1175,6 +1175,29 @@ u32 aarch64_set_branch_offset(u32 insn, s32 offset)
 	BUG();
 }
 
+s32 aarch64_get_addr_offset(u32 insn)
+{
+	if (aarch64_insn_is_adr(insn))
+		return aarch64_insn_decode_immediate(AARCH64_INSN_IMM_ADR, insn);
+	if (aarch64_insn_is_adrp(insn))
+		return aarch64_insn_decode_immediate(AARCH64_INSN_IMM_ADR, insn) << 12;
+
+	/* Unhandled instruction */
+	BUG();
+}
+
+u32 aarch64_set_addr_offset(u32 insn, s32 offset)
+{
+	if (aarch64_insn_is_adr(insn))
+		return aarch64_insn_encode_immediate(AARCH64_INSN_IMM_ADR, insn,
+									offset);
+	if (aarch64_insn_is_adrp(insn))
+		return aarch64_insn_encode_immediate(AARCH64_INSN_IMM_ADR, insn,
+									offset >> 12);
+	/* Unhandled instruction */
+	BUG();
+}
+
 bool aarch32_insn_is_wide(u32 insn)
 {
 	return insn >= 0xe800;
-- 
2.7.4
