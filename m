From: mark.rutland@arm.com (Mark Rutland)
Date: Thu,  9 Feb 2017 15:19:20 +0000
Subject: [PATCH 3/4] arm64: cpufeature: correctly handle MRS to XZR
In-Reply-To: <1486653561-22357-1-git-send-email-mark.rutland@arm.com>
References: <1486653561-22357-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1486653561-22357-4-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In emulate_mrs() we may erroneously write back to the user SP rather
than XZR if we trap an MRS instruction where Xt == 31.

Use the new pt_regs_write_reg() helper to handle this correctly.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Fixes: 77c97b4ee21290f5 ("arm64: cpufeature: Expose CPUID registers by emulation")
Cc: Andre Przywara <andre.przywara@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/cpufeature.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 1ee5357..abda8e8 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1214,7 +1214,7 @@ static int emulate_mrs(struct pt_regs *regs, u32 insn)
 	rc = emulate_sys_reg(sys_reg, &val);
 	if (!rc) {
 		dst = aarch64_insn_decode_register(AARCH64_INSN_REGTYPE_RT, insn);
-		regs->user_regs.regs[dst] = val;
+		pt_regs_write_reg(regs, dst, val);
 		regs->pc += 4;
 	}
 
-- 
1.9.1
