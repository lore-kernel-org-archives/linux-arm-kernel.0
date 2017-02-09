From: mark.rutland@arm.com (Mark Rutland)
Date: Thu,  9 Feb 2017 15:19:19 +0000
Subject: [PATCH 2/4] arm64: traps: correctly handle MRS/MSR with XZR
In-Reply-To: <1486653561-22357-1-git-send-email-mark.rutland@arm.com>
References: <1486653561-22357-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1486653561-22357-3-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently we hand-roll XZR-safe register handling in
user_cache_maint_handler(), though we forget to do the same in
ctr_read_handler(), and may erroneously write back to the user SP rather
than XZR.

Use the new helpers to handle these cases correctly and consistently.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Fixes: 116c81f427ff6c53 ("arm64: Work around systems with mismatched cache line sizes")
Cc: Andre Przywara <andre.przywara@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/traps.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Note: this is dependent on patch 1, but I couldn't fill in a Cc line for stable
as patch 1 doesn't (yet) have a stable commit id.

Mark.

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 7c3fc06..350179be 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -466,7 +466,7 @@ static void user_cache_maint_handler(unsigned int esr, struct pt_regs *regs)
 	int crm = (esr & ESR_ELx_SYS64_ISS_CRM_MASK) >> ESR_ELx_SYS64_ISS_CRM_SHIFT;
 	int ret = 0;
 
-	address = (rt == 31) ? 0 : regs->regs[rt];
+	address = pt_regs_read_reg(regs, rt);
 
 	switch (crm) {
 	case ESR_ELx_SYS64_ISS_CRM_DC_CVAU:	/* DC CVAU, gets promoted */
@@ -495,8 +495,10 @@ static void user_cache_maint_handler(unsigned int esr, struct pt_regs *regs)
 static void ctr_read_handler(unsigned int esr, struct pt_regs *regs)
 {
 	int rt = (esr & ESR_ELx_SYS64_ISS_RT_MASK) >> ESR_ELx_SYS64_ISS_RT_SHIFT;
+	unsigned long val = arm64_ftr_reg_user_value(&arm64_ftr_reg_ctrel0);
+
+	pt_regs_write_reg(regs, rt, val);
 
-	regs->regs[rt] = arm64_ftr_reg_user_value(&arm64_ftr_reg_ctrel0);
 	regs->pc += 4;
 }
 
-- 
1.9.1
