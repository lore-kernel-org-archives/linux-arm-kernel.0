From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Mon,  4 Apr 2016 17:26:02 +0100
Subject: [PATCH 02/17] arm64: Cleanup VTCR_EL2 and VTTBR field values
In-Reply-To: <1459787177-12767-1-git-send-email-suzuki.poulose@arm.com>
References: <1459787177-12767-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1459787177-12767-3-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We share most of the bits for VTCR_EL2 for different page sizes,
except for the TG0 value and the entry level value. This patch
makes the definitions a bit more cleaner to reflect this fact.

Also cleans up the VTTBR_X calculation. No funcational changes.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/kvm_arm.h |   23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index c460cfe..d5d5fdf 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -144,32 +144,31 @@
  * The magic numbers used for VTTBR_X in this patch can be found in Tables
  * D4-23 and D4-25 in ARM DDI 0487A.b.
  */
+#define VTCR_EL2_T0SZ_IPA	VTCR_EL2_T0SZ_40B
+#define VTCR_EL2_COMMON_BITS	(VTCR_EL2_SH0_INNER | VTCR_EL2_ORGN0_WBWA | \
+				 VTCR_EL2_IRGN0_WBWA | VTCR_EL2_SL0_LVL1 | \
+				 VTCR_EL2_RES1 | VTCR_EL2_T0SZ_IPA)
 #ifdef CONFIG_ARM64_64K_PAGES
 /*
  * Stage2 translation configuration:
- * 40bits input  (T0SZ = 24)
  * 64kB pages (TG0 = 1)
  * 2 level page tables (SL = 1)
  */
-#define VTCR_EL2_FLAGS		(VTCR_EL2_TG0_64K | VTCR_EL2_SH0_INNER | \
-				 VTCR_EL2_ORGN0_WBWA | VTCR_EL2_IRGN0_WBWA | \
-				 VTCR_EL2_SL0_LVL1 | VTCR_EL2_T0SZ_40B | \
-				 VTCR_EL2_RES1)
-#define VTTBR_X		(38 - VTCR_EL2_T0SZ_40B)
+#define VTCR_EL2_TGRAN_FLAGS	(VTCR_EL2_TG0_64K | VTCR_EL2_SL0_LVL1)
+#define VTTBR_X_TGRAN_MAGIC		38
 #else
 /*
  * Stage2 translation configuration:
- * 40bits input  (T0SZ = 24)
  * 4kB pages (TG0 = 0)
  * 3 level page tables (SL = 1)
  */
-#define VTCR_EL2_FLAGS		(VTCR_EL2_TG0_4K | VTCR_EL2_SH0_INNER | \
-				 VTCR_EL2_ORGN0_WBWA | VTCR_EL2_IRGN0_WBWA | \
-				 VTCR_EL2_SL0_LVL1 | VTCR_EL2_T0SZ_40B | \
-				 VTCR_EL2_RES1)
-#define VTTBR_X		(37 - VTCR_EL2_T0SZ_40B)
+#define VTCR_EL2_TGRAN_FLAGS		(VTCR_EL2_TG0_4K | VTCR_EL2_SL0_LVL1)
+#define VTTBR_X_TGRAN_MAGIC		37
 #endif
 
+#define VTCR_EL2_FLAGS		(VTCR_EL2_TGRAN_FLAGS | VTCR_EL2_COMMON_BITS)
+#define VTTBR_X			(VTTBR_X_TGRAN_MAGIC - VTCR_EL2_T0SZ_IPA)
+
 #define VTTBR_BADDR_SHIFT (VTTBR_X - 1)
 #define VTTBR_BADDR_MASK  (((UL(1) << (PHYS_MASK_SHIFT - VTTBR_X)) - 1) << VTTBR_BADDR_SHIFT)
 #define VTTBR_VMID_SHIFT  (UL(48))
-- 
1.7.9.5
