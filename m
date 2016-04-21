From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Thu, 21 Apr 2016 09:18:14 +0100
Subject: [PATCH RFC 02/10] ARM: V7M: Make read_cpuid() generally available on
 V7M.
In-Reply-To: <1461226702-27160-1-git-send-email-vladimir.murzin@arm.com>
References: <1461226702-27160-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1461226702-27160-3-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jonathan Austin <jonathan.austin@arm.com>

Previously V7M had a custom definition for read_cpuid_id that didn't use the
underlying read_cpuid() macro and a stub definition for read_cpuid().

This requires a custom specialisation for each of the CPUID_* registers, and
as more than just CPUID_ID may be implemented in the future this doesn't
make much sense.

This patch creates a generic implementation of read_cpuid for V7M and
removes the custom read_cpuid_id implementation.

Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/include/asm/cputype.h |   50 ++++++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 22 deletions(-)

diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
index b23c6c8..2d46425 100644
--- a/arch/arm/include/asm/cputype.h
+++ b/arch/arm/include/asm/cputype.h
@@ -4,15 +4,15 @@
 #include <linux/stringify.h>
 #include <linux/kernel.h>
 
-#define CPUID_ID	0
-#define CPUID_CACHETYPE	1
-#define CPUID_TCM	2
-#define CPUID_TLBTYPE	3
-#define CPUID_MPUIR	4
-#define CPUID_MPIDR	5
-#define CPUID_REVIDR	6
-
 #ifdef CONFIG_CPU_V7M
+
+#define CPUID_ID	0x0
+#define CPUID_CACHETYPE	-1
+#define CPUID_TCM	-1
+#define CPUID_TLBTYPE	-1
+#define CPUID_MPIDR	-1
+#define CPUID_REVIDR	-1
+
 #define CPUID_EXT_PFR0	0x40
 #define CPUID_EXT_PFR1	0x44
 #define CPUID_EXT_DFR0	0x48
@@ -28,6 +28,14 @@
 #define CPUID_EXT_ISAR4	0x70
 #define CPUID_EXT_ISAR5	0x74
 #else
+#define CPUID_ID	0
+#define CPUID_CACHETYPE	1
+#define CPUID_TCM	2
+#define CPUID_TLBTYPE	3
+#define CPUID_MPUIR	4
+#define CPUID_MPIDR	5
+#define CPUID_REVIDR	6
+
 #define CPUID_EXT_PFR0	"c1, 0"
 #define CPUID_EXT_PFR1	"c1, 1"
 #define CPUID_EXT_DFR0	"c1, 2"
@@ -114,11 +122,16 @@ extern unsigned int processor_id;
 #include <asm/io.h>
 #include <asm/v7m.h>
 
-#define read_cpuid(reg)							\
-	({								\
-		WARN_ON_ONCE(1);					\
-		0;							\
-	})
+static inline unsigned int __attribute_const__ read_cpuid(unsigned offset)
+{
+	switch (offset) {
+	case CPUID_ID:
+		return readl(BASEADDR_V7M_SCB + offset);
+	default:
+		WARN_ON_ONCE(1);
+		return 0;
+	}
+}
 
 static inline unsigned int __attribute_const__ read_cpuid_ext(unsigned offset)
 {
@@ -141,7 +154,7 @@ static inline unsigned int __attribute_const__ read_cpuid_ext(unsigned offset)
 
 #endif /* ifdef CONFIG_CPU_CP15 / else */
 
-#ifdef CONFIG_CPU_CP15
+#if defined(CONFIG_CPU_CP15) || defined(CONFIG_CPU_V7M)
 /*
  * The CPU ID never changes at run time, so we might as well tell the
  * compiler that it's constant.  Use this function to read the CPU ID
@@ -152,14 +165,7 @@ static inline unsigned int __attribute_const__ read_cpuid_id(void)
 	return read_cpuid(CPUID_ID);
 }
 
-#elif defined(CONFIG_CPU_V7M)
-
-static inline unsigned int __attribute_const__ read_cpuid_id(void)
-{
-	return readl(BASEADDR_V7M_SCB + V7M_SCB_CPUID);
-}
-
-#else /* ifdef CONFIG_CPU_CP15 / elif defined(CONFIG_CPU_V7M) */
+#else /* if defined(CONFIG_CPU_CP15) || defined(CONFIG_CPU_V7M) */
 
 static inline unsigned int __attribute_const__ read_cpuid_id(void)
 {
-- 
1.7.9.5
