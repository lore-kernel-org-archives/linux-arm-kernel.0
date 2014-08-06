From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed,  6 Aug 2014 17:46:05 +0200
Subject: [PATCH v3 1/2] arm64: add helper functions to read I-cache attributes
Message-ID: <1407339966-29351-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds helper functions and #defines to <asm/cachetype.h> to read the
line size and the number of sets from the level 1 instruction cache.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
v3: add WARN_ON(preemptible()), move icache_get_ccsidr() to cpuinfo.c to
    prevent #include header recursion hell
v2: put () around macro args, use 64-bit types for asm() mrs/msr calls

 arch/arm64/include/asm/cachetype.h | 20 ++++++++++++++++++++
 arch/arm64/kernel/cpuinfo.c        | 14 ++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/arch/arm64/include/asm/cachetype.h b/arch/arm64/include/asm/cachetype.h
index 7a2e0762cb40..4c631a0a3609 100644
--- a/arch/arm64/include/asm/cachetype.h
+++ b/arch/arm64/include/asm/cachetype.h
@@ -39,6 +39,26 @@
 
 extern unsigned long __icache_flags;
 
+#define CCSIDR_EL1_LINESIZE_MASK	0x7
+#define CCSIDR_EL1_LINESIZE(x)		((x) & CCSIDR_EL1_LINESIZE_MASK)
+
+#define CCSIDR_EL1_NUMSETS_SHIFT	13
+#define CCSIDR_EL1_NUMSETS_MASK		(0x7fff << CCSIDR_EL1_NUMSETS_SHIFT)
+#define CCSIDR_EL1_NUMSETS(x) \
+	(((x) & CCSIDR_EL1_NUMSETS_MASK) >> CCSIDR_EL1_NUMSETS_SHIFT)
+
+extern u64 __attribute_const__ icache_get_ccsidr(void);
+
+static inline int icache_get_linesize(void)
+{
+	return 16 << CCSIDR_EL1_LINESIZE(icache_get_ccsidr());
+}
+
+static inline int icache_get_numsets(void)
+{
+	return 1 + CCSIDR_EL1_NUMSETS(icache_get_ccsidr());
+}
+
 /*
  * Whilst the D-side always behaves as PIPT on AArch64, aliasing is
  * permitted in the I-cache.
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index f798f66634af..319255ff536d 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -20,8 +20,10 @@
 #include <asm/cputype.h>
 
 #include <linux/bitops.h>
+#include <linux/bug.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/preempt.h>
 #include <linux/printk.h>
 #include <linux/smp.h>
 
@@ -190,3 +192,15 @@ void __init cpuinfo_store_boot_cpu(void)
 
 	boot_cpu_data = *info;
 }
+
+u64 __attribute_const__ icache_get_ccsidr(void)
+{
+	u64 ccsidr;
+
+	WARN_ON(preemptible());
+
+	/* Select L1 I-cache and read its size ID register */
+	asm("msr csselr_el1, %1; isb; mrs %0, ccsidr_el1"
+	    : "=r"(ccsidr) : "r"(1L));
+	return ccsidr;
+}
-- 
1.8.3.2
