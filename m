From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 17 Feb 2016 17:58:43 +0000
Subject: [PATCH v4.1] arm64: hw_breakpoint: Allow EL2 breakpoints if running
 in HYP
In-Reply-To: <1455216004-19499-23-git-send-email-marc.zyngier@arm.com>
References: <1455216004-19499-23-git-send-email-marc.zyngier@arm.com>
Message-ID: <1455731923-26768-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With VHE, we place kernel {watch,break}-points at EL2 to get things
like kgdb and "perf -e mem:..." working.

This requires a bit of repainting in the low-level encore/decode,
but is otherwise pretty simple.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/hw_breakpoint.h | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/hw_breakpoint.h b/arch/arm64/include/asm/hw_breakpoint.h
index 9732908..115ea2a 100644
--- a/arch/arm64/include/asm/hw_breakpoint.h
+++ b/arch/arm64/include/asm/hw_breakpoint.h
@@ -18,6 +18,7 @@
 
 #include <asm/cputype.h>
 #include <asm/cpufeature.h>
+#include <asm/virt.h>
 
 #ifdef __KERNEL__
 
@@ -35,10 +36,21 @@ struct arch_hw_breakpoint {
 	struct arch_hw_breakpoint_ctrl ctrl;
 };
 
+/* Privilege Levels */
+#define AARCH64_BREAKPOINT_EL1	1
+#define AARCH64_BREAKPOINT_EL0	2
+
+#define DBG_HMC_HYP		(1 << 13)
+
 static inline u32 encode_ctrl_reg(struct arch_hw_breakpoint_ctrl ctrl)
 {
-	return (ctrl.len << 5) | (ctrl.type << 3) | (ctrl.privilege << 1) |
+	u32 val = (ctrl.len << 5) | (ctrl.type << 3) | (ctrl.privilege << 1) |
 		ctrl.enabled;
+
+	if (is_kernel_in_hyp_mode() && ctrl.privilege == AARCH64_BREAKPOINT_EL1)
+		val |= DBG_HMC_HYP;
+
+	return val;
 }
 
 static inline void decode_ctrl_reg(u32 reg,
@@ -61,10 +73,6 @@ static inline void decode_ctrl_reg(u32 reg,
 #define ARM_BREAKPOINT_STORE	2
 #define AARCH64_ESR_ACCESS_MASK	(1 << 6)
 
-/* Privilege Levels */
-#define AARCH64_BREAKPOINT_EL1	1
-#define AARCH64_BREAKPOINT_EL0	2
-
 /* Lengths */
 #define ARM_BREAKPOINT_LEN_1	0x1
 #define ARM_BREAKPOINT_LEN_2	0x3
-- 
2.1.4
