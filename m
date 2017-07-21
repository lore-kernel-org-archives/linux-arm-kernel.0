From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 21 Jul 2017 18:15:28 +0100
Subject: [PATCH 02/16] arm64: Add decoding macros for CP15_32 and CP15_64 traps
In-Reply-To: <20170721171542.27639-1-marc.zyngier@arm.com>
References: <20170721171542.27639-1-marc.zyngier@arm.com>
Message-ID: <20170721171542.27639-3-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So far, we don't have anything to help decoding ESR_ELx when dealing
with ESR_ELx_EC_CP15_{32,64}. As we're about to handle some of those,
let's add some useful macros.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/esr.h | 52 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index 8cabd57b6348..fc71b89c99f9 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -206,6 +206,58 @@
 		(((e) & ESR_ELx_SYS64_ISS_OP2_MASK) >>		\
 		 ESR_ELx_SYS64_ISS_OP2_SHIFT))
 
+#define ESR_ELx_CP15_32_ISS_COND_SHIFT	20
+#define ESR_ELx_CP15_32_ISS_COND_MASK	(UL(0xf) << ESR_ELx_CP15_32_ISS_COND_SHIFT)
+
+#define ESR_ELx_CP15_32_ISS_DIR_MASK	0x1
+#define ESR_ELx_CP15_32_ISS_DIR_READ	0x1
+#define ESR_ELx_CP15_32_ISS_DIR_WRITE	0x0
+
+#define ESR_ELx_CP15_32_ISS_RT_SHIFT	5
+#define ESR_ELx_CP15_32_ISS_RT_MASK	(UL(0x1f) << ESR_ELx_CP15_32_ISS_RT_SHIFT)
+#define ESR_ELx_CP15_32_ISS_CRM_SHIFT	1
+#define ESR_ELx_CP15_32_ISS_CRM_MASK	(UL(0xf) << ESR_ELx_CP15_32_ISS_CRM_SHIFT)
+#define ESR_ELx_CP15_32_ISS_CRN_SHIFT	10
+#define ESR_ELx_CP15_32_ISS_CRN_MASK	(UL(0xf) << ESR_ELx_CP15_32_ISS_CRN_SHIFT)
+#define ESR_ELx_CP15_32_ISS_OP1_SHIFT	14
+#define ESR_ELx_CP15_32_ISS_OP1_MASK	(UL(0x7) << ESR_ELx_CP15_32_ISS_OP1_SHIFT)
+#define ESR_ELx_CP15_32_ISS_OP2_SHIFT	17
+#define ESR_ELx_CP15_32_ISS_OP2_MASK	(UL(0x7) << ESR_ELx_CP15_32_ISS_OP2_SHIFT)
+
+#define ESR_ELx_CP15_32_ISS_SYS_MASK	(ESR_ELx_CP15_32_ISS_OP1_MASK | \
+					 ESR_ELx_CP15_32_ISS_OP2_MASK | \
+					 ESR_ELx_CP15_32_ISS_CRN_MASK | \
+					 ESR_ELx_CP15_32_ISS_CRM_MASK | \
+					 ESR_ELx_CP15_32_ISS_DIR_MASK)
+#define ESR_ELx_CP15_32_ISS_SYS_VAL(op1, op2, crn, crm) \
+					(((op1) << ESR_ELx_CP15_32_ISS_OP1_SHIFT) | \
+					 ((op2) << ESR_ELx_CP15_32_ISS_OP2_SHIFT) | \
+					 ((crn) << ESR_ELx_CP15_32_ISS_CRN_SHIFT) | \
+					 ((crm) << ESR_ELx_CP15_32_ISS_CRM_SHIFT))
+
+#define ESR_ELx_CP15_64_ISS_DIR_MASK	0x1
+#define ESR_ELx_CP15_64_ISS_DIR_READ	0x1
+#define ESR_ELx_CP15_64_ISS_DIR_WRITE	0x0
+
+#define ESR_ELx_CP15_64_ISS_RT_SHIFT	5
+#define ESR_ELx_CP15_64_ISS_RT_MASK	(UL(0x1f) << ESR_ELx_CP15_64_ISS_RT_SHIFT)
+
+#define ESR_ELx_CP15_64_ISS_RT2_SHIFT	10
+#define ESR_ELx_CP15_64_ISS_RT2_MASK	(UL(0x1f) << ESR_ELx_CP15_64_ISS_RT2_SHIFT)
+
+#define ESR_ELx_CP15_64_ISS_OP1_SHIFT	16
+#define ESR_ELx_CP15_64_ISS_OP1_MASK	(UL(0xf) << ESR_ELx_CP15_64_ISS_OP1_SHIFT)
+#define ESR_ELx_CP15_64_ISS_CRM_SHIFT	1
+#define ESR_ELx_CP15_64_ISS_CRM_MASK	(UL(0xf) << ESR_ELx_CP15_64_ISS_CRM_SHIFT)
+
+#define ESR_ELx_CP15_64_ISS_SYS_VAL(op1, crm) \
+					(((op1) << ESR_ELx_CP15_64_ISS_OP1_SHIFT) | \
+					 ((crm) << ESR_ELx_CP15_64_ISS_CRM_SHIFT))
+
+#define ESR_ELx_CP15_64_ISS_SYS_MASK	(ESR_ELx_CP15_64_ISS_OP1_MASK |	\
+					 ESR_ELx_CP15_64_ISS_CRM_MASK | \
+					 ESR_ELx_CP15_64_ISS_DIR_MASK)
+
 #ifndef __ASSEMBLY__
 #include <asm/types.h>
 
-- 
2.11.0
