From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Thu, 18 Aug 2016 13:45:55 +0100
Subject: [PATCH v2 3/8] ARM: V7M: Add support for reading the CTR with
 read_cpuid_cachetype()
In-Reply-To: <1471524360-31554-1-git-send-email-vladimir.murzin@arm.com>
References: <1471524360-31554-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1471524360-31554-4-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jonathan Austin <jonathan.austin@arm.com>

With the addition of caches to the V7M Architecture a new Cache Type
Register (CTR) is defined at 0xE000ED7C. This register serves the same
purpose as the V7A/R version and accessed via the read_cpuid_cachetype.

Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/include/asm/cachetype.h |   15 +++++++++++++++
 arch/arm/include/asm/cputype.h   |   15 ++++++++++-----
 arch/arm/kernel/setup.c          |    9 +++++----
 3 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/arch/arm/include/asm/cachetype.h b/arch/arm/include/asm/cachetype.h
index 8609de8..01509ae 100644
--- a/arch/arm/include/asm/cachetype.h
+++ b/arch/arm/include/asm/cachetype.h
@@ -67,6 +67,7 @@ static inline unsigned int __attribute__((pure)) cacheid_is(unsigned int mask)
 #define CSSELR_L6	(5 << 1)
 #define CSSELR_L7	(6 << 1)
 
+#ifndef CONFIG_CPU_V7M
 static inline void set_csselr(unsigned int cache_selector)
 {
 	asm volatile("mcr p15, 2, %0, c0, c0, 0" : : "r" (cache_selector));
@@ -79,5 +80,19 @@ static inline unsigned int read_ccsidr(void)
 	asm volatile("mrc p15, 1, %0, c0, c0, 0" : "=r" (val));
 	return val;
 }
+#else /* CONFIG_CPU_V7M */
+#include <linux/io.h>
+#include "asm/v7m.h"
+
+static inline void set_csselr(unsigned int cache_selector)
+{
+	writel(cache_selector, BASEADDR_V7M_SCB + V7M_SCB_CTR);
+}
+
+static inline unsigned int read_ccsidr(void)
+{
+	return readl(BASEADDR_V7M_SCB + V7M_SCB_CCSIDR);
+}
+#endif
 
 #endif
diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
index 1ee94c7..bd753ff 100644
--- a/arch/arm/include/asm/cputype.h
+++ b/arch/arm/include/asm/cputype.h
@@ -152,6 +152,11 @@ static inline unsigned int __attribute_const__ read_cpuid_id(void)
 	return read_cpuid(CPUID_ID);
 }
 
+static inline unsigned int __attribute_const__ read_cpuid_cachetype(void)
+{
+	return read_cpuid(CPUID_CACHETYPE);
+}
+
 #elif defined(CONFIG_CPU_V7M)
 
 static inline unsigned int __attribute_const__ read_cpuid_id(void)
@@ -159,6 +164,11 @@ static inline unsigned int __attribute_const__ read_cpuid_id(void)
 	return readl(BASEADDR_V7M_SCB + V7M_SCB_CPUID);
 }
 
+static inline unsigned int __attribute_const__ read_cpuid_cachetype(void)
+{
+	return readl(BASEADDR_V7M_SCB + V7M_SCB_CTR);
+}
+
 #else /* ifdef CONFIG_CPU_CP15 / elif defined(CONFIG_CPU_V7M) */
 
 static inline unsigned int __attribute_const__ read_cpuid_id(void)
@@ -193,11 +203,6 @@ static inline unsigned int __attribute_const__ xscale_cpu_arch_version(void)
 	return read_cpuid_id() & ARM_CPU_XSCALE_ARCH_MASK;
 }
 
-static inline unsigned int __attribute_const__ read_cpuid_cachetype(void)
-{
-	return read_cpuid(CPUID_CACHETYPE);
-}
-
 static inline unsigned int __attribute_const__ read_cpuid_tcmstatus(void)
 {
 	return read_cpuid(CPUID_TCM);
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 2055490..f35f9eb 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -312,11 +312,12 @@ static void __init cacheid_init(void)
 {
 	unsigned int arch = cpu_architecture();
 
-	if (arch == CPU_ARCH_ARMv7M) {
-		cacheid = 0;
-	} else if (arch >= CPU_ARCH_ARMv6) {
+	if (arch >= CPU_ARCH_ARMv6) {
 		unsigned int cachetype = read_cpuid_cachetype();
-		if ((cachetype & (7 << 29)) == 4 << 29) {
+
+		if ((arch == CPU_ARCH_ARMv7M) && !cachetype) {
+			cacheid = 0;
+		} else if ((cachetype & (7 << 29)) == 4 << 29) {
 			/* ARMv7 register format */
 			arch = CPU_ARCH_ARMv7;
 			cacheid = CACHEID_VIPT_NONALIASING;
-- 
1.7.9.5
