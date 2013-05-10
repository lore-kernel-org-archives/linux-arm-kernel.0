From: pranavkumar@linaro.org (Pranavkumar Sawargaonkar)
Date: Fri, 10 May 2013 12:53:50 +0530
Subject: [PATCH V2] arm64: KVM: Fix HCR_EL2 and VTCR_EL2 configuration bits
Message-ID: <1368170630-19567-1-git-send-email-pranavkumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch does following fixes:

1. Make HCR_* flags as unsigned long long constants
Reason : By default, compiler assumes numeric constants as
signed hence sign extending it when assigned to unsigned variable
such as hcr_el2 (in VCPU context). This accidently sets HCR_ID and
HCR_CD making entire guest memory non-cacheable. On real HW, this
breaks Stage2 ttbl walks and also breaks VirtIO.

2. VTCR_EL2_ORGN0_WBWA and VTCR_EL2_IRGN0_WBWA macros.

Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
Signed-off-by: Anup Patel <anup.patel@linaro.org>
---
 arch/arm64/include/asm/kvm_arm.h |   73 +++++++++++++++++++-------------------
 1 file changed, 37 insertions(+), 36 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index 8ced0ca..14ead69 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -18,44 +18,45 @@
 #ifndef __ARM64_KVM_ARM_H__
 #define __ARM64_KVM_ARM_H__
 
+#include <linux/const.h>
 #include <asm/types.h>
 
 /* Hyp Configuration Register (HCR) bits */
-#define HCR_ID		(1 << 33)
-#define HCR_CD		(1 << 32)
+#define HCR_ID		(UL(0x1) << 33)
+#define HCR_CD		(UL(0x1) << 32)
 #define HCR_RW_SHIFT	31
-#define HCR_RW		(1 << HCR_RW_SHIFT)
-#define HCR_TRVM	(1 << 30)
-#define HCR_HCD		(1 << 29)
-#define HCR_TDZ		(1 << 28)
-#define HCR_TGE		(1 << 27)
-#define HCR_TVM		(1 << 26)
-#define HCR_TTLB	(1 << 25)
-#define HCR_TPU		(1 << 24)
-#define HCR_TPC		(1 << 23)
-#define HCR_TSW		(1 << 22)
-#define HCR_TAC		(1 << 21)
-#define HCR_TIDCP	(1 << 20)
-#define HCR_TSC		(1 << 19)
-#define HCR_TID3	(1 << 18)
-#define HCR_TID2	(1 << 17)
-#define HCR_TID1	(1 << 16)
-#define HCR_TID0	(1 << 15)
-#define HCR_TWE		(1 << 14)
-#define HCR_TWI		(1 << 13)
-#define HCR_DC		(1 << 12)
-#define HCR_BSU		(3 << 10)
-#define HCR_BSU_IS	(1 << 10)
-#define HCR_FB		(1 << 9)
-#define HCR_VA		(1 << 8)
-#define HCR_VI		(1 << 7)
-#define HCR_VF		(1 << 6)
-#define HCR_AMO		(1 << 5)
-#define HCR_IMO		(1 << 4)
-#define HCR_FMO		(1 << 3)
-#define HCR_PTW		(1 << 2)
-#define HCR_SWIO	(1 << 1)
-#define HCR_VM		(1)
+#define HCR_RW		(UL(0x1) << HCR_RW_SHIFT)
+#define HCR_TRVM	(UL(0x1) << 30)
+#define HCR_HCD		(UL(0x1) << 29)
+#define HCR_TDZ		(UL(0x1) << 28)
+#define HCR_TGE		(UL(0x1) << 27)
+#define HCR_TVM		(UL(0x1) << 26)
+#define HCR_TTLB	(UL(0x1) << 25)
+#define HCR_TPU		(UL(0x1) << 24)
+#define HCR_TPC		(UL(0x1) << 23)
+#define HCR_TSW		(UL(0x1) << 22)
+#define HCR_TAC		(UL(0x1) << 21)
+#define HCR_TIDCP	(UL(0x1) << 20)
+#define HCR_TSC		(UL(0x1) << 19)
+#define HCR_TID3	(UL(0x1) << 18)
+#define HCR_TID2	(UL(0x1) << 17)
+#define HCR_TID1	(UL(0x1) << 16)
+#define HCR_TID0	(UL(0x1) << 15)
+#define HCR_TWE		(UL(0x1) << 14)
+#define HCR_TWI		(UL(0x1) << 13)
+#define HCR_DC		(UL(0x1) << 12)
+#define HCR_BSU		(UL(0x3) << 10)
+#define HCR_BSU_IS	(UL(0x1) << 10)
+#define HCR_FB		(UL(0x1) << 9)
+#define HCR_VA		(UL(0x1) << 8)
+#define HCR_VI		(UL(0x1) << 7)
+#define HCR_VF		(UL(0x1) << 6)
+#define HCR_AMO		(UL(0x1) << 5)
+#define HCR_IMO		(UL(0x1) << 4)
+#define HCR_FMO		(UL(0x1) << 3)
+#define HCR_PTW		(UL(0x1) << 2)
+#define HCR_SWIO	(UL(0x1) << 1)
+#define HCR_VM		(UL(0x1))
 
 /*
  * The bits we set in HCR:
@@ -111,9 +112,9 @@
 #define VTCR_EL2_SH0_MASK	(3 << 12)
 #define VTCR_EL2_SH0_INNER	(3 << 12)
 #define VTCR_EL2_ORGN0_MASK	(3 << 10)
-#define VTCR_EL2_ORGN0_WBWA	(3 << 10)
+#define VTCR_EL2_ORGN0_WBWA	(1 << 10)
 #define VTCR_EL2_IRGN0_MASK	(3 << 8)
-#define VTCR_EL2_IRGN0_WBWA	(3 << 8)
+#define VTCR_EL2_IRGN0_WBWA	(1 << 8)
 #define VTCR_EL2_SL0_MASK	(3 << 6)
 #define VTCR_EL2_SL0_LVL1	(1 << 6)
 #define VTCR_EL2_T0SZ_MASK	0x3f
-- 
1.7.9.5
