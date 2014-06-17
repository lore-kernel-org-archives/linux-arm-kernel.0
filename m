From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 17 Jun 2014 18:04:31 +0100
Subject: [PATCHv2 1/4] arm64: add MIDR_EL1 field accessors
In-Reply-To: <1403024674-25108-1-git-send-email-mark.rutland@arm.com>
References: <1403024674-25108-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1403024674-25108-2-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MIDR_EL1 register is composed of a number of bitfields, and uses of
the fields has so far involved open-coding of the shifts and masks
required.

This patch adds shifts and masks for each of the MIDR_EL1 subfields, and
also provides accessors built atop of these. Existing uses within
cputype.h are updated to use these accessors.

The read_cpuid_part_number macro is modified to return the extracted
bitfield rather than returning the value in-place with all other fields
(including revision) masked out, to better match the other accessors.
As the value is only used in comparison with the *_CPU_PART_* macros
which are similarly updated, and these values are never exposed to
userspace, this change should not affect any functionality.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/include/asm/cputype.h | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 27f54a7..ec5e41c 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -36,15 +36,34 @@
 	__val;								\
 })
 
+#define MIDR_REVISION_MASK	0xf
+#define MIDR_REVISION(midr)	((midr) & MIDR_REVISION_MASK)
+#define MIDR_PARTNUM_SHIFT	4
+#define MIDR_PARTNUM_MASK	(0xfff << MIDR_PARTNUM_SHIFT)
+#define MIDR_PARTNUM(midr)	\
+	(((midr) & MIDR_PARTNUM_MASK) >> MIDR_PARTNUM_SHIFT)
+#define MIDR_ARCHITECTURE_SHIFT	16
+#define MIDR_ARCHITECTURE_MASK	(0xf << MIDR_ARCHITECTURE_SHIFT)
+#define MIDR_ARCHITECTURE(midr)	\
+	(((midr) & MIDR_ARCHITECTURE_MASK) >> MIDR_ARCHITECTURE_SHIFT)
+#define MIDR_VARIANT_SHIFT	20
+#define MIDR_VARIANT_MASK	(0xf << MIDR_VARIANT_SHIFT)
+#define MIDR_VARIANT(midr)	\
+	(((midr) & MIDR_VARIANT_MASK) >> MIDR_VARIANT_SHIFT)
+#define MIDR_IMPLEMENTOR_SHIFT	24
+#define MIDR_IMPLEMENTOR_MASK	(0xff << MIDR_IMPLEMENTOR_SHIFT)
+#define MIDR_IMPLEMENTOR(midr)	\
+	(((midr) & MIDR_IMPLEMENTOR_MASK) >> MIDR_IMPLEMENTOR_SHIFT)
+
 #define ARM_CPU_IMP_ARM		0x41
 #define ARM_CPU_IMP_APM		0x50
 
-#define ARM_CPU_PART_AEM_V8	0xD0F0
-#define ARM_CPU_PART_FOUNDATION	0xD000
-#define ARM_CPU_PART_CORTEX_A53	0xD030
-#define ARM_CPU_PART_CORTEX_A57	0xD070
+#define ARM_CPU_PART_AEM_V8	0xD0F
+#define ARM_CPU_PART_FOUNDATION	0xD00
+#define ARM_CPU_PART_CORTEX_A57	0xD07
+#define ARM_CPU_PART_CORTEX_A53	0xD03
 
-#define APM_CPU_PART_POTENZA	0x0000
+#define APM_CPU_PART_POTENZA	0x000
 
 #ifndef __ASSEMBLY__
 
@@ -65,12 +84,12 @@ static inline u64 __attribute_const__ read_cpuid_mpidr(void)
 
 static inline unsigned int __attribute_const__ read_cpuid_implementor(void)
 {
-	return (read_cpuid_id() & 0xFF000000) >> 24;
+	return MIDR_IMPLEMENTOR(read_cpuid_id());
 }
 
 static inline unsigned int __attribute_const__ read_cpuid_part_number(void)
 {
-	return (read_cpuid_id() & 0xFFF0);
+	return MIDR_PARTNUM(read_cpuid_id());
 }
 
 static inline u32 __attribute_const__ read_cpuid_cachetype(void)
-- 
1.9.1
