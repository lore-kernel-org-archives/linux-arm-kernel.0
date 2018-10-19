From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 19 Oct 2018 13:58:47 +0100
Subject: [PATCH 12/26] kvm: arm64: Configure VTCR_EL2.SL0 per VM
In-Reply-To: <20181019125901.185478-1-marc.zyngier@arm.com>
References: <20181019125901.185478-1-marc.zyngier@arm.com>
Message-ID: <20181019125901.185478-13-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

VTCR_EL2 holds the following key stage2 translation table
parameters:
  SL0  - Entry level in the page table lookup.
  T0SZ - Denotes the size of the memory addressed by the table.

We have been using fixed values for the SL0 depending on the
page size as we have a fixed IPA size. But since we are about
to make it dynamic, we need to calculate the SL0 at runtime
per VM. This patch adds a helper to compute the value of SL0
for a VM based on the IPA size.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Christoffer Dall <cdall@kernel.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/kvm_arm.h | 67 +++++++++++++++++++++++---------
 arch/arm64/kvm/reset.c           |  1 +
 2 files changed, 49 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index b236d90ca056..f913adb44f93 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -121,7 +121,6 @@
 #define VTCR_EL2_IRGN0_WBWA	TCR_IRGN0_WBWA
 #define VTCR_EL2_SL0_SHIFT	6
 #define VTCR_EL2_SL0_MASK	(3 << VTCR_EL2_SL0_SHIFT)
-#define VTCR_EL2_SL0_LVL1	(1 << VTCR_EL2_SL0_SHIFT)
 #define VTCR_EL2_T0SZ_MASK	0x3f
 #define VTCR_EL2_VS_SHIFT	19
 #define VTCR_EL2_VS_8BIT	(0 << VTCR_EL2_VS_SHIFT)
@@ -144,30 +143,60 @@
 #define VTCR_EL2_COMMON_BITS	(VTCR_EL2_SH0_INNER | VTCR_EL2_ORGN0_WBWA | \
 				 VTCR_EL2_IRGN0_WBWA | VTCR_EL2_RES1)
 
-#ifdef CONFIG_ARM64_64K_PAGES
 /*
- * Stage2 translation configuration:
- * 64kB pages (TG0 = 1)
- * 2 level page tables (SL = 1)
+ * VTCR_EL2:SL0 indicates the entry level for Stage2 translation.
+ * Interestingly, it depends on the page size.
+ * See D.10.2.121, VTCR_EL2, in ARM DDI 0487C.a
+ *
+ *	-----------------------------------------
+ *	| Entry level		|  4K  | 16K/64K |
+ *	------------------------------------------
+ *	| Level: 0		|  2   |   -     |
+ *	------------------------------------------
+ *	| Level: 1		|  1   |   2     |
+ *	------------------------------------------
+ *	| Level: 2		|  0   |   1     |
+ *	------------------------------------------
+ *	| Level: 3		|  -   |   0     |
+ *	------------------------------------------
+ *
+ * The table roughly translates to :
+ *
+ *	SL0(PAGE_SIZE, Entry_level) = TGRAN_SL0_BASE - Entry_Level
+ *
+ * Where TGRAN_SL0_BASE is a magic number depending on the page size:
+ * 	TGRAN_SL0_BASE(4K) = 2
+ *	TGRAN_SL0_BASE(16K) = 3
+ *	TGRAN_SL0_BASE(64K) = 3
+ * provided we take care of ruling out the unsupported cases and
+ * Entry_Level = 4 - Number_of_levels.
+ *
  */
-#define VTCR_EL2_TGRAN_FLAGS		(VTCR_EL2_TG0_64K | VTCR_EL2_SL0_LVL1)
+#ifdef CONFIG_ARM64_64K_PAGES
+
+#define VTCR_EL2_TGRAN			VTCR_EL2_TG0_64K
+#define VTCR_EL2_TGRAN_SL0_BASE		3UL
+
 #elif defined(CONFIG_ARM64_16K_PAGES)
-/*
- * Stage2 translation configuration:
- * 16kB pages (TG0 = 2)
- * 2 level page tables (SL = 1)
- */
-#define VTCR_EL2_TGRAN_FLAGS		(VTCR_EL2_TG0_16K | VTCR_EL2_SL0_LVL1)
+
+#define VTCR_EL2_TGRAN			VTCR_EL2_TG0_16K
+#define VTCR_EL2_TGRAN_SL0_BASE		3UL
+
 #else	/* 4K */
-/*
- * Stage2 translation configuration:
- * 4kB pages (TG0 = 0)
- * 3 level page tables (SL = 1)
- */
-#define VTCR_EL2_TGRAN_FLAGS		(VTCR_EL2_TG0_4K | VTCR_EL2_SL0_LVL1)
+
+#define VTCR_EL2_TGRAN			VTCR_EL2_TG0_4K
+#define VTCR_EL2_TGRAN_SL0_BASE		2UL
+
 #endif
 
-#define VTCR_EL2_FLAGS			(VTCR_EL2_COMMON_BITS | VTCR_EL2_TGRAN_FLAGS)
+#define VTCR_EL2_LVLS_TO_SL0(levels)	\
+	((VTCR_EL2_TGRAN_SL0_BASE - (4 - (levels))) << VTCR_EL2_SL0_SHIFT)
+#define VTCR_EL2_SL0_TO_LVLS(sl0)	\
+	((sl0) + 4 - VTCR_EL2_TGRAN_SL0_BASE)
+#define VTCR_EL2_LVLS(vtcr)		\
+	VTCR_EL2_SL0_TO_LVLS(((vtcr) & VTCR_EL2_SL0_MASK) >> VTCR_EL2_SL0_SHIFT)
+
+#define VTCR_EL2_FLAGS			(VTCR_EL2_COMMON_BITS | VTCR_EL2_TGRAN)
 /*
  * ARM VMSAv8-64 defines an algorithm for finding the translation table
  * descriptors in section D4.2.8 in ARM DDI 0487C.a.
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index 616120c4176b..1ced1e37374e 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -160,6 +160,7 @@ int kvm_arm_config_vm(struct kvm *kvm, unsigned long type)
 	if (phys_shift > KVM_PHYS_SHIFT)
 		phys_shift = KVM_PHYS_SHIFT;
 	vtcr |= VTCR_EL2_T0SZ(phys_shift);
+	vtcr |= VTCR_EL2_LVLS_TO_SL0(kvm_stage2_levels(kvm));
 
 	/*
 	 * Enable the Hardware Access Flag management, unconditionally
-- 
2.19.1
