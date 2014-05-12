From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 12 May 2014 15:37:48 +0100
Subject: [PATCH 1/3] arm64: add MIDR_EL1 field accessors
In-Reply-To: <1399905470-26500-1-git-send-email-mark.rutland@arm.com>
References: <1399905470-26500-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1399905470-26500-2-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MIDR_EL1 register is composed of a number of bitfields, and uses of
the fields has so far involved open-coding of the shifts and masks
required.

This patch adds shifts and masks for each of the MIDR_EL1 subfields, and
also provides accessors built atop of these. Existing uses within
cputype.h are updated to use these accessors.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/include/asm/cputype.h | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index c404fb0..541b829 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -36,6 +36,25 @@
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
 
@@ -64,12 +83,16 @@ static inline u64 __attribute_const__ read_cpuid_mpidr(void)
 
 static inline unsigned int __attribute_const__ read_cpuid_implementor(void)
 {
-	return (read_cpuid_id() & 0xFF000000) >> 24;
+	return MIDR_IMPLEMENTOR(read_cpuid_id());
 }
 
 static inline unsigned int __attribute_const__ read_cpuid_part_number(void)
 {
-	return (read_cpuid_id() & 0xFFF0);
+	/*
+	 * The part number field is used in-place as a userspace ABI, so we
+	 * cannot use MIDR_PARTNUM() here.
+	 */
+	return (read_cpuid_id() & MIDR_PARTNUM_MASK);
 }
 
 static inline u32 __attribute_const__ read_cpuid_cachetype(void)
-- 
1.8.1.1
