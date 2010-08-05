From: will.deacon@arm.com (Will Deacon)
Date: Thu,  5 Aug 2010 11:36:48 +0100
Subject: [PATCH 1/2] ARM: setup: detect aliasing I-cache when D-cache is
	non-aliasing
In-Reply-To: <1281004609-7563-1-git-send-email-will.deacon@arm.com>
References: <1281004609-7563-1-git-send-email-will.deacon@arm.com>
Message-ID: <1281004609-7563-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, the Kernel assumes that if a CPU has a non-aliasing D-cache
then the I-cache is also non-aliasing. This may not be true on ARM cores
from v6 onwards, which may have aliasing I-caches but non-aliasing
D-caches.

This patch adds a cpu_has_aliasing_icache function, which is called from
cacheid_init and adds CACHEID_VIPT_I_ALIASING to the cacheid when
appropriate. A utility macro, icache_is_vipt_aliasing(), is also
provided.

Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/cachetype.h |    8 ++++++--
 arch/arm/kernel/setup.c          |   38 +++++++++++++++++++++++++++++++++++---
 2 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/cachetype.h b/arch/arm/include/asm/cachetype.h
index d3a4c2c..c023db0 100644
--- a/arch/arm/include/asm/cachetype.h
+++ b/arch/arm/include/asm/cachetype.h
@@ -6,6 +6,7 @@
 #define CACHEID_VIPT_ALIASING		(1 << 2)
 #define CACHEID_VIPT			(CACHEID_VIPT_ALIASING|CACHEID_VIPT_NONALIASING)
 #define CACHEID_ASID_TAGGED		(1 << 3)
+#define CACHEID_VIPT_I_ALIASING		(1 << 4)
 
 extern unsigned int cacheid;
 
@@ -14,15 +15,18 @@ extern unsigned int cacheid;
 #define cache_is_vipt_nonaliasing()	cacheid_is(CACHEID_VIPT_NONALIASING)
 #define cache_is_vipt_aliasing()	cacheid_is(CACHEID_VIPT_ALIASING)
 #define icache_is_vivt_asid_tagged()	cacheid_is(CACHEID_ASID_TAGGED)
+#define icache_is_vipt_aliasing()	cacheid_is(CACHEID_VIPT_I_ALIASING)
 
 /*
  * __LINUX_ARM_ARCH__ is the minimum supported CPU architecture
  * Mask out support which will never be present on newer CPUs.
  * - v6+ is never VIVT
- * - v7+ VIPT never aliases
+ * - v7+ VIPT never aliases on D-side
  */
 #if __LINUX_ARM_ARCH__ >= 7
-#define __CACHEID_ARCH_MIN	(CACHEID_VIPT_NONALIASING | CACHEID_ASID_TAGGED)
+#define __CACHEID_ARCH_MIN	(CACHEID_VIPT_NONALIASING |\
+				 CACHEID_ASID_TAGGED |\
+				 CACHEID_VIPT_I_ALIASING)
 #elif __LINUX_ARM_ARCH__ >= 6
 #define	__CACHEID_ARCH_MIN	(~CACHEID_VIVT)
 #else
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 122d999..cf8e590 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -233,6 +233,33 @@ int cpu_architecture(void)
 	return cpu_arch;
 }
 
+static int cpu_has_aliasing_icache(unsigned int arch)
+{
+	int aliasing_icache;
+	unsigned int id_reg, num_sets, line_size;
+
+	/* arch specifies the register format */
+	switch (arch) {
+	case CPU_ARCH_ARMv7:
+		asm("mcr	p15, 2, %1, c0, c0, 0	@ set CSSELR\n"
+		    "mrc	p15, 1, %0, c0, c0, 0	@ read CCSIDR"
+		    : "=r" (id_reg)
+		    : "r" (1));
+		line_size = 4 << ((id_reg & 0x7) + 2);
+		num_sets = ((id_reg >> 13) & 0x7fff) + 1;
+		aliasing_icache = (line_size * num_sets) > PAGE_SIZE;
+		break;
+	case CPU_ARCH_ARMv6:
+		aliasing_icache = read_cpuid_cachetype() & (1 << 11);
+		break;
+	default:
+		/* I-cache aliases will be handled by D-cache aliasing code */
+		aliasing_icache = 0;
+	}
+
+	return aliasing_icache;
+}
+
 static void __init cacheid_init(void)
 {
 	unsigned int cachetype = read_cpuid_cachetype();
@@ -244,10 +271,15 @@ static void __init cacheid_init(void)
 			cacheid = CACHEID_VIPT_NONALIASING;
 			if ((cachetype & (3 << 14)) == 1 << 14)
 				cacheid |= CACHEID_ASID_TAGGED;
-		} else if (cachetype & (1 << 23))
+			else if (cpu_has_aliasing_icache(CPU_ARCH_ARMv7))
+				cacheid |= CACHEID_VIPT_I_ALIASING;
+		} else if (cachetype & (1 << 23)) {
 			cacheid = CACHEID_VIPT_ALIASING;
-		else
+		} else {
 			cacheid = CACHEID_VIPT_NONALIASING;
+			if (cpu_has_aliasing_icache(CPU_ARCH_ARMv6))
+				cacheid |= CACHEID_VIPT_I_ALIASING;
+		}
 	} else {
 		cacheid = CACHEID_VIVT;
 	}
@@ -258,7 +290,7 @@ static void __init cacheid_init(void)
 		cache_is_vipt_nonaliasing() ? "VIPT nonaliasing" : "unknown",
 		cache_is_vivt() ? "VIVT" :
 		icache_is_vivt_asid_tagged() ? "VIVT ASID tagged" :
-		cache_is_vipt_aliasing() ? "VIPT aliasing" :
+		icache_is_vipt_aliasing() ? "VIPT aliasing" :
 		cache_is_vipt_nonaliasing() ? "VIPT nonaliasing" : "unknown");
 }
 
-- 
1.6.3.3
