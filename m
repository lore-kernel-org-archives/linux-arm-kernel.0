From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 27 Sep 2018 17:15:28 +0100
Subject: [PATCH 1/7] arm64: Add decoding macros for CP15_32 and CP15_64 traps
In-Reply-To: <20180927161534.247926-1-marc.zyngier@arm.com>
References: <20180927161534.247926-1-marc.zyngier@arm.com>
Message-ID: <20180927161534.247926-2-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So far, we don't have anything to help decoding ESR_ELx when dealing
with ESR_ELx_EC_CP15_{32,64}. As we're about to handle some of those,
let's add some useful macros.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/esr.h | 52 ++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index ce70c3ffb993..bfd27753a59d 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -249,6 +249,58 @@
 
 #define ESR_ELx_FP_EXC_TFV	(UL(1) << 23)
 
+/*
+ * ISS field definitions for CP15 accesses
+ */
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
2.19.0
