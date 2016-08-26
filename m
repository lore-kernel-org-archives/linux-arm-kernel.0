From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Fri, 26 Aug 2016 10:23:14 +0100
Subject: [PATCH v2 5/9] arm64: insn: Add helpers for adrp offsets
In-Reply-To: <1472203398-8751-1-git-send-email-suzuki.poulose@arm.com>
References: <1472203398-8751-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1472203398-8751-6-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds helpers for decoding/encoding the PC relative addresses for adrp.
This will be used for handling dynamic patching of 'adrp' instructions
in alternative code patching.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Changes since V1:
 - Replace adr_adrp with seperate handlers for adr and adrp (Marc Zyngier)
---
 arch/arm64/include/asm/insn.h | 11 ++++++++++-
 arch/arm64/kernel/insn.c      | 13 +++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index 1dbaa90..bc85366 100644
--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -246,7 +246,8 @@ static __always_inline bool aarch64_insn_is_##abbr(u32 code) \
 static __always_inline u32 aarch64_insn_get_##abbr##_value(void) \
 { return (val); }
 
-__AARCH64_INSN_FUNCS(adr_adrp,	0x1F000000, 0x10000000)
+__AARCH64_INSN_FUNCS(adr,	0x9F000000, 0x10000000)
+__AARCH64_INSN_FUNCS(adrp,	0x9F000000, 0x90000000)
 __AARCH64_INSN_FUNCS(prfm_lit,	0xFF000000, 0xD8000000)
 __AARCH64_INSN_FUNCS(str_reg,	0x3FE0EC00, 0x38206800)
 __AARCH64_INSN_FUNCS(ldr_reg,	0x3FE0EC00, 0x38606800)
@@ -318,6 +319,11 @@ __AARCH64_INSN_FUNCS(msr_reg,	0xFFF00000, 0xD5100000)
 bool aarch64_insn_is_nop(u32 insn);
 bool aarch64_insn_is_branch_imm(u32 insn);
 
+static inline bool aarch64_insn_is_adr_adrp(u32 insn)
+{
+	return aarch64_insn_is_adr(insn) || aarch64_insn_is_adrp(insn);
+}
+
 int aarch64_insn_read(void *addr, u32 *insnp);
 int aarch64_insn_write(void *addr, u32 insn);
 enum aarch64_insn_encoding_class aarch64_get_insn_class(u32 insn);
@@ -398,6 +404,9 @@ int aarch64_insn_patch_text_nosync(void *addr, u32 insn);
 int aarch64_insn_patch_text_sync(void *addrs[], u32 insns[], int cnt);
 int aarch64_insn_patch_text(void *addrs[], u32 insns[], int cnt);
 
+s32 aarch64_insn_adrp_get_offset(u32 insn);
+u32 aarch64_insn_adrp_set_offset(u32 insn, s32 offset);
+
 bool aarch32_insn_is_wide(u32 insn);
 
 #define A32_RN_OFFSET	16
diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
index 63f9432..f022af4 100644
--- a/arch/arm64/kernel/insn.c
+++ b/arch/arm64/kernel/insn.c
@@ -1202,6 +1202,19 @@ u32 aarch64_set_branch_offset(u32 insn, s32 offset)
 	BUG();
 }
 
+s32 aarch64_insn_adrp_get_offset(u32 insn)
+{
+	BUG_ON(!aarch64_insn_is_adrp(insn));
+	return aarch64_insn_decode_immediate(AARCH64_INSN_IMM_ADR, insn) << 12;
+}
+
+u32 aarch64_insn_adrp_set_offset(u32 insn, s32 offset)
+{
+	BUG_ON(!aarch64_insn_is_adrp(insn));
+	return aarch64_insn_encode_immediate(AARCH64_INSN_IMM_ADR, insn,
+						offset >> 12);
+}
+
 /*
  * Extract the Op/CR data from a msr/mrs instruction.
  */
-- 
2.7.4
