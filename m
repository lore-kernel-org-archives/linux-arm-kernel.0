From: kuleshovmail@gmail.com (Alexander Kuleshov)
Date: Fri,  4 Sep 2015 00:11:51 +0600
Subject: [PATCH 1/3] arm64/cpufeature.h: Add macros for a cpu features testing
Message-ID: <1441303911-9421-1-git-send-email-kuleshovmail@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch provides a couple of macros for the testing of processor
features (crypto and FP/SIMD) like support of SHA1, AES instructions,
support for FPU and etc. There is already a couple of places in the
arch/arm64/kernel where these processor features are tested and these
macros are facilitate this.

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 arch/arm64/include/asm/cpufeature.h | 44 +++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index c104421..2919455 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -28,7 +28,50 @@
 
 #define ARM64_NCAPS				4
 
+/*
+ * ID_AA64ISAR0_EL1 AES, bits [7:4]
+ */
+#define ID_AA64ISAR0_EL1_AES_MASK	4
+#define ID_AA64ISAR0_EL1_AES(feature)	\
+	(((feature >> ID_AA64ISAR0_EL1_AES_MASK) & 0xf) & 1UL)
+#define ID_AA64ISAR0_EL1_PMULL(feature)	\
+	(((feature >> ID_AA64ISAR0_EL1_AES_MASK) & 0xf) & 2UL)
+
+/*
+ * ID_AA64ISAR0_EL1 SHA1, bits [11:8]
+ */
+#define ID_AA64ISAR0_EL1_SHA1_MASK	8
+#define ID_AA64ISAR0_EL1_SHA1(feature)	\
+	(((feature >> ID_AA64ISAR0_EL1_SHA1_MASK) & 0xf) & 1UL)
+
+/*
+ * ID_AA64ISAR0_EL1 SHA2, bits [15:12]
+ */
+#define ID_AA64ISAR0_EL1_SHA2_MASK	12
+#define ID_AA64ISAR0_EL1_SHA2(feature)	\
+	(((feature >> ID_AA64ISAR0_EL1_SHA2_MASK) & 0xf) & 1UL)
+
+/*
+ * ID_AA64ISAR0_EL1 CRC32, bits [19:16]
+ */
+#define ID_AA64ISAR0_EL1_CRC32_MASK	16
+#define ID_AA64ISAR0_EL1_CRC32(feature)	\
+	(((feature >> ID_AA64ISAR0_EL1_CRC32_MASK) & 0xf) & 1UL)
+
+/*
+ * ID_AA64PFR0_EL1 FP, bits [19:16]
+ */
+#define ID_AA64PFR0_EL1_FP_MASK		16
+#define ID_AA64PFR0_EL1_FP(ptr)		\
+	(ptr & (0xf << ID_AA64PFR0_EL1_FP_MASK))
+
+/*
+ * ID_AA64PFR0_EL1 AdvSIMD, bits [23:20]
+ */
+#define ID_AA64PFR0_EL1_ADV_SIMD_MASK	20
+#define ID_AA64PFR0_EL1_ADV_SIMD(ptr)	\
+	(ptr & (0xf << ID_AA64PFR0_EL1_ADV_SIMD_MASK))
+
 #ifndef __ASSEMBLY__
 
 struct arm64_cpu_capabilities {
-- 
2.5.0
