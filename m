From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Mon, 19 Oct 2015 14:00:43 +0100
Subject: [PATCHv4 20/24] arm64: Define helper for sys_reg id manipulation
In-Reply-To: <1445259647-21541-1-git-send-email-suzuki.poulose@arm.com>
References: <1445259647-21541-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1445259647-21541-21-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define helper macros to extract op0, op1, CRn, CRm & op2
for a given sys_reg id.

Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/sysreg.h |   21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 83aceb58..22f1a88 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -32,8 +32,27 @@
  *	[11-8]  : CRm
  *	[7-5]   : Op2
  */
+#define Op0_shift	19
+#define Op0_mask	0x3
+#define Op1_shift	16
+#define Op1_mask	0x7
+#define CRn_shift	12
+#define CRn_mask	0xf
+#define CRm_shift	8
+#define CRm_mask	0xf
+#define Op2_shift	5
+#define Op2_mask	0x7
+
 #define sys_reg(op0, op1, crn, crm, op2) \
-	((((op0)&3)<<19)|((op1)<<16)|((crn)<<12)|((crm)<<8)|((op2)<<5))
+	((((op0) & Op0_mask) << Op0_shift) | \
+	 ((op1) << Op1_shift) | ((crn) << CRn_shift) | \
+	 ((crm) << CRm_shift) | ((op2) << Op2_shift))
+
+#define sys_reg_Op0(id)	(((id) >> Op0_shift) & Op0_mask)
+#define sys_reg_Op1(id)	(((id) >> Op1_shift) & Op1_mask)
+#define sys_reg_CRn(id)	(((id) >> CRn_shift) & CRn_mask)
+#define sys_reg_CRm(id)	(((id) >> CRm_shift) & CRm_mask)
+#define sys_reg_Op2(id)	(((id) >> Op2_shift) & Op2_mask)
 
 #define SYS_MIDR_EL1			sys_reg(3, 0, 0, 0, 0)
 #define SYS_MPIDR_EL1			sys_reg(3, 0, 0, 0, 5)
-- 
1.7.9.5
