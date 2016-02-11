From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 11 Feb 2016 18:40:02 +0000
Subject: [PATCH v4 21/23] arm64: hw_breakpoint: Allow EL2 breakpoints if
 running in HYP
In-Reply-To: <1455216004-19499-1-git-send-email-marc.zyngier@arm.com>
References: <1455216004-19499-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1455216004-19499-22-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With VHE, we place kernel {watch,break}-points at EL2 to get things
like kgdb and "perf -e mem:..." working.

This requires a bit of repainting in the low-level encore/decode,
but is otherwise pretty simple.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/hw_breakpoint.h | 49 +++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/include/asm/hw_breakpoint.h b/arch/arm64/include/asm/hw_breakpoint.h
index 9732908..4d8d5a8 100644
--- a/arch/arm64/include/asm/hw_breakpoint.h
+++ b/arch/arm64/include/asm/hw_breakpoint.h
@@ -18,6 +18,7 @@
 
 #include <asm/cputype.h>
 #include <asm/cpufeature.h>
+#include <asm/virt.h>
 
 #ifdef __KERNEL__
 
@@ -35,24 +36,6 @@ struct arch_hw_breakpoint {
 	struct arch_hw_breakpoint_ctrl ctrl;
 };
 
-static inline u32 encode_ctrl_reg(struct arch_hw_breakpoint_ctrl ctrl)
-{
-	return (ctrl.len << 5) | (ctrl.type << 3) | (ctrl.privilege << 1) |
-		ctrl.enabled;
-}
-
-static inline void decode_ctrl_reg(u32 reg,
-				   struct arch_hw_breakpoint_ctrl *ctrl)
-{
-	ctrl->enabled	= reg & 0x1;
-	reg >>= 1;
-	ctrl->privilege	= reg & 0x3;
-	reg >>= 2;
-	ctrl->type	= reg & 0x3;
-	reg >>= 2;
-	ctrl->len	= reg & 0xff;
-}
-
 /* Breakpoint */
 #define ARM_BREAKPOINT_EXECUTE	0
 
@@ -62,6 +45,7 @@ static inline void decode_ctrl_reg(u32 reg,
 #define AARCH64_ESR_ACCESS_MASK	(1 << 6)
 
 /* Privilege Levels */
+#define AARCH64_BREAKPOINT_EL2	0
 #define AARCH64_BREAKPOINT_EL1	1
 #define AARCH64_BREAKPOINT_EL0	2
 
@@ -76,6 +60,35 @@ static inline void decode_ctrl_reg(u32 reg,
 #define ARM_KERNEL_STEP_ACTIVE	1
 #define ARM_KERNEL_STEP_SUSPEND	2
 
+#define DBG_HMC_HYP		(1 << 13)
+#define DBG_SSC_HYP		(3 << 14)
+
+static inline u32 encode_ctrl_reg(struct arch_hw_breakpoint_ctrl ctrl)
+{
+	u32 val = (ctrl.len << 5) | (ctrl.type << 3) | ctrl.enabled;
+
+	if (is_kernel_in_hyp_mode() && ctrl.privilege == AARCH64_BREAKPOINT_EL1)
+		val |= DBG_HMC_HYP | DBG_SSC_HYP | (AARCH64_BREAKPOINT_EL2 << 1);
+	else
+		val |= ctrl.privilege << 1;
+
+	return val;
+}
+
+static inline void decode_ctrl_reg(u32 reg,
+				   struct arch_hw_breakpoint_ctrl *ctrl)
+{
+	ctrl->enabled	= reg & 0x1;
+	reg >>= 1;
+	ctrl->privilege	= reg & 0x3;
+	if (ctrl->privilege == AARCH64_BREAKPOINT_EL2)
+		ctrl->privilege	= AARCH64_BREAKPOINT_EL1;
+	reg >>= 2;
+	ctrl->type	= reg & 0x3;
+	reg >>= 2;
+	ctrl->len	= reg & 0xff;
+}
+
 /*
  * Limits.
  * Changing these will require modifications to the register accessors.
-- 
2.1.4
