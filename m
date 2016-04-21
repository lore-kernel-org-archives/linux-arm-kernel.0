From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Thu, 21 Apr 2016 09:18:16 +0100
Subject: [PATCH RFC 04/10] ARM: V7M: Add support for reading the CTR with
 CPUID_CACHETYPE
In-Reply-To: <1461226702-27160-1-git-send-email-vladimir.murzin@arm.com>
References: <1461226702-27160-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1461226702-27160-5-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jonathan Austin <jonathan.austin@arm.com>

With the addition of caches to the V7M Architecture a new Cache Type Register
(CTR) is defined at 0xE000ED7C. This register serves the same purpose as the
V7A/R version, called CPUID_CACHETYPE in the kernel.

This patch adds appropriate definitions to the cpuid macros to allow the CTR to
be read with read_cpuid(reg).

Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/include/asm/cachetype.h |   15 +++++++++++++++
 arch/arm/include/asm/cputype.h   |    3 ++-
 arch/arm/kernel/setup.c          |    9 +++++----
 3 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/cachetype.h b/arch/arm/include/asm/cachetype.h
index 8609de8..d55b7de 100644
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
+#include <asm/io.h>
+#include "asm/v7m.h"
+
+static inline void set_csselr(unsigned int cache_selector)
+{
+	writel(cache_selector, (void *)(BASEADDR_V7M_SCB + V7M_SCB_CTR));
+}
+
+static inline unsigned int read_ccsidr(void)
+{
+	return readl(BASEADDR_V7M_SCB + V7M_SCB_CCSIDR);
+}
+#endif
 
 #endif
diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
index 2d46425..ea595db 100644
--- a/arch/arm/include/asm/cputype.h
+++ b/arch/arm/include/asm/cputype.h
@@ -7,7 +7,7 @@
 #ifdef CONFIG_CPU_V7M
 
 #define CPUID_ID	0x0
-#define CPUID_CACHETYPE	-1
+#define CPUID_CACHETYPE	0x7c
 #define CPUID_TCM	-1
 #define CPUID_TLBTYPE	-1
 #define CPUID_MPIDR	-1
@@ -126,6 +126,7 @@ static inline unsigned int __attribute_const__ read_cpuid(unsigned offset)
 {
 	switch (offset) {
 	case CPUID_ID:
+	case CPUID_CACHETYPE:
 		return readl(BASEADDR_V7M_SCB + offset);
 	default:
 		WARN_ON_ONCE(1);
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 163a90d..596be88 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -313,11 +313,12 @@ static void __init cacheid_init(void)
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
