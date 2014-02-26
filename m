From: mohun106@gmail.com (mohun106 at gmail.com)
Date: Wed, 26 Feb 2014 11:28:30 +0530
Subject: [RFC PATCH 1/1] arm64: Add support for 48-bit Physical Address
In-Reply-To: <1393394310-6138-1-git-send-email-mohun106@gmail.com>
References: <1393394310-6138-1-git-send-email-mohun106@gmail.com>
Message-ID: <1393394310-6138-2-git-send-email-mohun106@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>

Added support for ARMv8 platforms that have 48-bit physical address
implemented. There is no change in the VA bits and levels of
translation.

Signed-off-by: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>
---
 arch/arm64/Kconfig                     |    3 +++
 arch/arm64/include/asm/kvm_arm.h       |    9 ++++++++-
 arch/arm64/include/asm/pgtable-hwdef.h |   15 +++++++++++++++
 arch/arm64/mm/proc.S                   |    2 +-
 4 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 27bbcfc..4494327 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -106,6 +106,9 @@ config IOMMU_HELPER
 config KERNEL_MODE_NEON
 	def_bool y
 
+config ARCH_SUPPORTS_48BIT_PA
+	def_bool n
+
 source "init/Kconfig"
 
 source "kernel/Kconfig.freezer"
diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index 0eb3986..214b12d 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -107,6 +107,7 @@
 /* VTCR_EL2 Registers bits */
 #define VTCR_EL2_PS_MASK	(7 << 16)
 #define VTCR_EL2_PS_40B		(2 << 16)
+#define VTCR_EL2_PS_48B		(5 << 16)
 #define VTCR_EL2_TG0_MASK	(1 << 14)
 #define VTCR_EL2_TG0_4K		(0 << 14)
 #define VTCR_EL2_TG0_64K	(1 << 14)
@@ -121,6 +122,12 @@
 #define VTCR_EL2_T0SZ_MASK	0x3f
 #define VTCR_EL2_T0SZ_40B	24
 
+#ifdef CONFIG_ARCH_SUPPORTS_48BIT_PA
+#define VTCR_EL2_PS_BITS	VTCR_EL2_PS_48B
+#else
+#define VTCR_EL2_PS_BITS	VTCR_EL2_PS_40B
+#endif
+
 #ifdef CONFIG_ARM64_64K_PAGES
 /*
  * Stage2 translation configuration:
@@ -129,7 +136,7 @@
  * 64kB pages (TG0 = 1)
  * 2 level page tables (SL = 1)
  */
-#define VTCR_EL2_FLAGS		(VTCR_EL2_PS_40B | VTCR_EL2_TG0_64K | \
+#define VTCR_EL2_FLAGS		(VTCR_EL2_PS_BITS | VTCR_EL2_TG0_64K | \
 				 VTCR_EL2_SH0_INNER | VTCR_EL2_ORGN0_WBWA | \
 				 VTCR_EL2_IRGN0_WBWA | VTCR_EL2_SL0_LVL1 | \
 				 VTCR_EL2_T0SZ_40B)
diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index b1d2e26..6d93ba6 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -99,10 +99,18 @@
 #define PMD_HYP			PMD_SECT_USER
 #define PTE_HYP			PTE_USER
 
+#ifdef CONFIG_ARCH_SUPPORTS_48BIT_PA
+/*
+ * 48-bit physical address supported.
+ */
+#define PHYS_MASK_SHIFT		(48)
+#else
 /*
  * 40-bit physical address supported.
  */
 #define PHYS_MASK_SHIFT		(40)
+#endif
+
 #define PHYS_MASK		((UL(1) << PHYS_MASK_SHIFT) - 1)
 
 /*
@@ -123,7 +131,14 @@
 #define TCR_TG0_64K		(UL(1) << 14)
 #define TCR_TG1_64K		(UL(1) << 30)
 #define TCR_IPS_40BIT		(UL(2) << 32)
+#define TCR_IPS_48BIT		(UL(5) << 32)
 #define TCR_ASID16		(UL(1) << 36)
 #define TCR_TBI0		(UL(1) << 37)
 
+#ifdef CONFIG_ARCH_SUPPORTS_48BIT_PA
+#define TCR_IPS_BITS		TCR_IPS_48BIT
+#else
+#define TCR_IPS_BITS		TCR_IPS_40BIT
+#endif
+
 #endif
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 1333e6f..3d573a6 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -215,7 +215,7 @@ ENTRY(__cpu_setup)
 	 * Set/prepare TCR and TTBR. We use 512GB (39-bit) address range for
 	 * both user and kernel.
 	 */
-	ldr	x10, =TCR_TxSZ(VA_BITS) | TCR_FLAGS | TCR_IPS_40BIT | \
+	ldr	x10, =TCR_TxSZ(VA_BITS) | TCR_FLAGS | TCR_IPS_BITS | \
 		      TCR_ASID16 | TCR_TBI0 | (1 << 31)
 #ifdef CONFIG_ARM64_64K_PAGES
 	orr	x10, x10, TCR_TG0_64K
-- 
1.7.1
