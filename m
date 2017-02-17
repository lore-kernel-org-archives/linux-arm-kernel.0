From: andrew_gabbasov@mentor.com (Andrew Gabbasov)
Date: Fri, 17 Feb 2017 06:09:38 -0700
Subject: [PATCH 2/3] ARM: mm: Support VIPT aliasing but not coloring
 instruction cache
In-Reply-To: <1487336979-14245-1-git-send-email-andrew_gabbasov@mentor.com>
References: <1487336979-14245-1-git-send-email-andrew_gabbasov@mentor.com>
Message-ID: <1487336979-14245-3-git-send-email-andrew_gabbasov@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARMv7+ instruction cache can have virtual memory location aliases,
but, unlike ARMv6, does not have page coloring restrictions, and
instruction cache line invalidation does not affect all the aliases.
So, for ARMv7+ modification of instruction in memory requires
invalidation of the whole instruction cache (after flushing of
data cache line to the point of unification) to be sure all
the lines for alias memory locations are affected. This is
already implemented this way for arm64 architecture.

The cases of aliasing instruction cache supporting and not supporing
page coloring are marked by a separate flag in cacheid, and depending
on it different actions are taken for instruction cache invalidation.

Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
---
 arch/arm/include/asm/cachetype.h |  4 +++-
 arch/arm/kernel/setup.c          | 17 ++++++++---------
 arch/arm/mm/flush.c              | 11 ++++++++++-
 3 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/arch/arm/include/asm/cachetype.h b/arch/arm/include/asm/cachetype.h
index 01509ae..03fb2ca 100644
--- a/arch/arm/include/asm/cachetype.h
+++ b/arch/arm/include/asm/cachetype.h
@@ -8,6 +8,7 @@
 #define CACHEID_ASID_TAGGED		(1 << 3)
 #define CACHEID_VIPT_I_ALIASING		(1 << 4)
 #define CACHEID_PIPT			(1 << 5)
+#define CACHEID_VIPT_I_COLORING		(1 << 6)
 
 extern unsigned int cacheid;
 
@@ -18,12 +19,13 @@ extern unsigned int cacheid;
 #define icache_is_vivt_asid_tagged()	cacheid_is(CACHEID_ASID_TAGGED)
 #define icache_is_vipt_aliasing()	cacheid_is(CACHEID_VIPT_I_ALIASING)
 #define icache_is_pipt()		cacheid_is(CACHEID_PIPT)
+#define icache_is_vipt_coloring()	cacheid_is(CACHEID_VIPT_I_COLORING)
 
 /*
  * __LINUX_ARM_ARCH__ is the minimum supported CPU architecture
  * Mask out support which will never be present on newer CPUs.
  * - v6+ is never VIVT
- * - v7+ VIPT never aliases on D-side
+ * - v7+ VIPT never aliases on D-side and never colors
  */
 #if __LINUX_ARM_ARCH__ >= 7
 #define __CACHEID_ARCH_MIN	(CACHEID_VIPT_NONALIASING |\
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 34e3f3c..4c7a588 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -278,9 +278,9 @@ int __pure cpu_architecture(void)
 	return __cpu_architecture;
 }
 
-static int cpu_has_aliasing_icache(unsigned int arch)
+static int cpu_aliasing_icache(unsigned int arch)
 {
-	int aliasing_icache;
+	int aliasing_icache = 0;
 	unsigned int id_reg, num_sets, line_size;
 
 	/* PIPT caches never alias. */
@@ -295,14 +295,14 @@ static int cpu_has_aliasing_icache(unsigned int arch)
 		id_reg = read_ccsidr();
 		line_size = 4 << ((id_reg & 0x7) + 2);
 		num_sets = ((id_reg >> 13) & 0x7fff) + 1;
-		aliasing_icache = (line_size * num_sets) > PAGE_SIZE;
+		if ((line_size * num_sets) > PAGE_SIZE)
+			aliasing_icache = CACHEID_VIPT_I_ALIASING;
 		break;
 	case CPU_ARCH_ARMv6:
-		aliasing_icache = read_cpuid_cachetype() & (1 << 11);
+		if (read_cpuid_cachetype() & (1 << 11))
+			aliasing_icache = CACHEID_VIPT_I_ALIASING |
+					  CACHEID_VIPT_I_COLORING;
 		break;
-	default:
-		/* I-cache aliases will be handled by D-cache aliasing code */
-		aliasing_icache = 0;
 	}
 
 	return aliasing_icache;
@@ -336,8 +336,7 @@ static void __init cacheid_init(void)
 			else
 				cacheid = CACHEID_VIPT_NONALIASING;
 		}
-		if (cpu_has_aliasing_icache(arch))
-			cacheid |= CACHEID_VIPT_I_ALIASING;
+		cacheid |= cpu_aliasing_icache(arch);
 	} else {
 		cacheid = CACHEID_VIVT;
 	}
diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index 3cced84..3a46bba 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -63,6 +63,12 @@ static void flush_icache_alias(unsigned long pfn, unsigned long vaddr, unsigned
 	flush_icache_range(to, to + len);
 }
 
+static void flush_icache_alias_nocolor(unsigned long addr, unsigned long len)
+{
+	__cpuc_flush_dcache_area_pou((void *)addr, len);
+	__flush_icache_all();
+}
+
 void flush_cache_mm(struct mm_struct *mm)
 {
 	if (cache_is_vivt()) {
@@ -117,6 +123,7 @@ void flush_cache_page(struct vm_area_struct *vma, unsigned long user_addr, unsig
 #else
 #define flush_pfn_alias(pfn,vaddr)		do { } while (0)
 #define flush_icache_alias(pfn,vaddr,len)	do { } while (0)
+#define flush_icache_alias_nocolor(addr,len)	do { } while (0)
 #endif
 
 #define FLAG_PA_IS_EXEC 1
@@ -148,8 +155,10 @@ void __flush_ptrace_access(struct page *page, unsigned long uaddr, void *kaddr,
 	/* VIPT non-aliasing D-cache */
 	if (flags & FLAG_PA_IS_EXEC) {
 		unsigned long addr = (unsigned long)kaddr;
-		if (icache_is_vipt_aliasing())
+		if (icache_is_vipt_coloring())
 			flush_icache_alias(page_to_pfn(page), uaddr, len);
+		else if (icache_is_vipt_aliasing())
+			flush_icache_alias_nocolor(addr, len);
 		else
 			__cpuc_coherent_kern_range(addr, addr + len);
 		if (cache_ops_need_broadcast())
-- 
2.1.0
