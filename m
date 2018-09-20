From: anshuman.khandual@arm.com (Anshuman Khandual)
Date: Thu, 20 Sep 2018 09:36:20 +0530
Subject: [PATCH V2 2/3] arm64/cpufeatures: Factorize emulate_mrs()
In-Reply-To: <1537416381-13674-1-git-send-email-anshuman.khandual@arm.com>
References: <1537416381-13674-1-git-send-email-anshuman.khandual@arm.com>
Message-ID: <1537416381-13674-3-git-send-email-anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MRS emulation gets triggered with exception class (0x00 or 0x18) eventually
calling the function emulate_mrs() which fetches the user space instruction
and analyses it's encodings (OP0, OP1, OP2, CRN, CRM, RT). The kernel tries
to emulate the given instruction looking into the encoding details. Going
forward these encodings can also be parsed from ESR_ELx.ISS fields without
requiring to fetch/decode faulting userspace instruction which can improve
performance. This factorizes emulate_mrs() function in a way that it can be
called directly with MRS encodings (OP0, OP1, OP2, CRN, CRM) for any given
target register which can then be used directly from 0x18 exception class.

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/cpufeature.h |  1 +
 arch/arm64/kernel/cpufeature.c      | 25 +++++++++++++++----------
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 1717ba1..7fcaaa4 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -530,6 +530,7 @@ void arm64_set_ssbd_mitigation(bool state);
 static inline void arm64_set_ssbd_mitigation(bool state) {}
 #endif
 
+extern int do_emulate_mrs(struct pt_regs *regs, u32 sys_reg, u32 rt);
 #endif /* __ASSEMBLY__ */
 
 #endif
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index e238b79..6126583 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1719,27 +1719,32 @@ static int emulate_sys_reg(u32 id, u64 *valp)
 	return 0;
 }
 
-static int emulate_mrs(struct pt_regs *regs, u32 insn)
+int do_emulate_mrs(struct pt_regs *regs, u32 sys_reg, u32 rt)
 {
 	int rc;
-	u32 sys_reg, dst;
 	u64 val;
 
-	/*
-	 * sys_reg values are defined as used in mrs/msr instruction.
-	 * shift the imm value to get the encoding.
-	 */
-	sys_reg = (u32)aarch64_insn_decode_immediate(AARCH64_INSN_IMM_16, insn) << 5;
 	rc = emulate_sys_reg(sys_reg, &val);
 	if (!rc) {
-		dst = aarch64_insn_decode_register(AARCH64_INSN_REGTYPE_RT, insn);
-		pt_regs_write_reg(regs, dst, val);
+		pt_regs_write_reg(regs, rt, val);
 		arm64_skip_faulting_instruction(regs, AARCH64_INSN_SIZE);
 	}
-
 	return rc;
 }
 
+static int emulate_mrs(struct pt_regs *regs, u32 insn)
+{
+	u32 sys_reg, rt;
+
+	/*
+	 * sys_reg values are defined as used in mrs/msr instruction.
+	 * shift the imm value to get the encoding.
+	 */
+	sys_reg = (u32)aarch64_insn_decode_immediate(AARCH64_INSN_IMM_16, insn) << 5;
+	rt = aarch64_insn_decode_register(AARCH64_INSN_REGTYPE_RT, insn);
+	return do_emulate_mrs(regs, sys_reg, rt);
+}
+
 static struct undef_hook mrs_hook = {
 	.instr_mask = 0xfff00000,
 	.instr_val  = 0xd5300000,
-- 
2.7.4
