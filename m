From: mark.rutland@arm.com (Mark Rutland)
Date: Thu,  9 Feb 2017 15:19:21 +0000
Subject: [PATCH 4/4] arm64/kprobes: consistently handle MRS/MSR with XZR
In-Reply-To: <1486653561-22357-1-git-send-email-mark.rutland@arm.com>
References: <1486653561-22357-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1486653561-22357-5-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have XZR-safe helpers for fiddling with registers, use these
in the arm64 kprobes code rather than open-coding the logic.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/probes/simulate-insn.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/kernel/probes/simulate-insn.c b/arch/arm64/kernel/probes/simulate-insn.c
index 357d3ef..be05868 100644
--- a/arch/arm64/kernel/probes/simulate-insn.c
+++ b/arch/arm64/kernel/probes/simulate-insn.c
@@ -17,6 +17,8 @@
 #include <linux/kernel.h>
 #include <linux/kprobes.h>
 
+#include <asm/ptrace.h>
+
 #include "simulate-insn.h"
 
 #define bbl_displacement(insn)		\
@@ -36,30 +38,22 @@
 
 static inline void set_x_reg(struct pt_regs *regs, int reg, u64 val)
 {
-	if (reg < 31)
-		regs->regs[reg] = val;
+	pt_regs_write_reg(regs, reg, val);
 }
 
 static inline void set_w_reg(struct pt_regs *regs, int reg, u64 val)
 {
-	if (reg < 31)
-		regs->regs[reg] = lower_32_bits(val);
+	pt_regs_write_reg(regs, reg, lower_32_bits(val));
 }
 
 static inline u64 get_x_reg(struct pt_regs *regs, int reg)
 {
-	if (reg < 31)
-		return regs->regs[reg];
-	else
-		return 0;
+	return pt_regs_read_reg(regs, reg);
 }
 
 static inline u32 get_w_reg(struct pt_regs *regs, int reg)
 {
-	if (reg < 31)
-		return lower_32_bits(regs->regs[reg]);
-	else
-		return 0;
+	return lower_32_bits(pt_regs_read_reg(regs, reg));
 }
 
 static bool __kprobes check_cbz(u32 opcode, struct pt_regs *regs)
-- 
1.9.1
