From: avanbrunt@nvidia.com (Alex Van Brunt)
Date: Wed, 28 Oct 2015 14:43:55 -0700
Subject: [PATCH 1/3] Revert "arm64: kernel: add support for cpu cache
 information"
In-Reply-To: <1446068637-11509-1-git-send-email-avanbrunt@nvidia.com>
References: <1446068637-11509-1-git-send-email-avanbrunt@nvidia.com>
Message-ID: <1446068637-11509-2-git-send-email-avanbrunt@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit 5d425c18653731af62831d30a4fa023d532657a9.

Change-Id: Ie34bbade5183d0c6b5b578dfaaa3ee1e898fcd9a
Signed-off-by: Alex Van Brunt <avanbrunt@nvidia.com>
---
 arch/arm64/include/asm/cachetype.h |  29 ++-------
 arch/arm64/kernel/Makefile         |   2 +-
 arch/arm64/kernel/cacheinfo.c      | 128 -------------------------------------
 arch/arm64/kernel/cpuinfo.c        |  12 ++++
 4 files changed, 19 insertions(+), 152 deletions(-)
 delete mode 100644 arch/arm64/kernel/cacheinfo.c

diff --git a/arch/arm64/include/asm/cachetype.h b/arch/arm64/include/asm/cachetype.h
index da2fc9e..4c631a0 100644
--- a/arch/arm64/include/asm/cachetype.h
+++ b/arch/arm64/include/asm/cachetype.h
@@ -39,41 +39,24 @@
 
 extern unsigned long __icache_flags;
 
-/*
- * NumSets, bits[27:13] - (Number of sets in cache) - 1
- * Associativity, bits[12:3] - (Associativity of cache) - 1
- * LineSize, bits[2:0] - (Log2(Number of words in cache line)) - 2
- */
-#define CCSIDR_EL1_WRITE_THROUGH	BIT(31)
-#define CCSIDR_EL1_WRITE_BACK		BIT(30)
-#define CCSIDR_EL1_READ_ALLOCATE	BIT(29)
-#define CCSIDR_EL1_WRITE_ALLOCATE	BIT(28)
 #define CCSIDR_EL1_LINESIZE_MASK	0x7
 #define CCSIDR_EL1_LINESIZE(x)		((x) & CCSIDR_EL1_LINESIZE_MASK)
-#define CCSIDR_EL1_ASSOCIATIVITY_SHIFT	3
-#define CCSIDR_EL1_ASSOCIATIVITY_MASK	0x3ff
-#define CCSIDR_EL1_ASSOCIATIVITY(x)	\
-	(((x) >> CCSIDR_EL1_ASSOCIATIVITY_SHIFT) & CCSIDR_EL1_ASSOCIATIVITY_MASK)
+
 #define CCSIDR_EL1_NUMSETS_SHIFT	13
-#define CCSIDR_EL1_NUMSETS_MASK		0x7fff
+#define CCSIDR_EL1_NUMSETS_MASK		(0x7fff << CCSIDR_EL1_NUMSETS_SHIFT)
 #define CCSIDR_EL1_NUMSETS(x) \
-	(((x) >> CCSIDR_EL1_NUMSETS_SHIFT) & CCSIDR_EL1_NUMSETS_MASK)
-
-#define CACHE_LINESIZE(x)	(16 << CCSIDR_EL1_LINESIZE(x))
-#define CACHE_NUMSETS(x)	(CCSIDR_EL1_NUMSETS(x) + 1)
-#define CACHE_ASSOCIATIVITY(x)	(CCSIDR_EL1_ASSOCIATIVITY(x) + 1)
+	(((x) & CCSIDR_EL1_NUMSETS_MASK) >> CCSIDR_EL1_NUMSETS_SHIFT)
 
-extern u64 __attribute_const__ cache_get_ccsidr(u64 csselr);
+extern u64 __attribute_const__ icache_get_ccsidr(void);
 
-/* Helpers for Level 1 Instruction cache csselr = 1L */
 static inline int icache_get_linesize(void)
 {
-	return CACHE_LINESIZE(cache_get_ccsidr(1L));
+	return 16 << CCSIDR_EL1_LINESIZE(icache_get_ccsidr());
 }
 
 static inline int icache_get_numsets(void)
 {
-	return CACHE_NUMSETS(cache_get_ccsidr(1L));
+	return 1 + CCSIDR_EL1_NUMSETS(icache_get_ccsidr());
 }
 
 /*
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 22dc9bc..abcf663 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -17,7 +17,7 @@ arm64-obj-y		:= debug-monitors.o entry.o irq.o fpsimd.o		\
 			   sys.o stacktrace.o time.o traps.o io.o vdso.o	\
 			   hyp-stub.o psci.o psci-call.o cpu_ops.o insn.o	\
 			   return_address.o cpuinfo.o cpu_errata.o		\
-			   cpufeature.o alternative.o cacheinfo.o		\
+			   cpufeature.o alternative.o				\
 			   smp.o smp_spin_table.o topology.o
 
 arm64-obj-$(CONFIG_COMPAT)		+= sys32.o kuser32.o signal32.o 	\
diff --git a/arch/arm64/kernel/cacheinfo.c b/arch/arm64/kernel/cacheinfo.c
deleted file mode 100644
index b8629d5..0000000
--- a/arch/arm64/kernel/cacheinfo.c
+++ /dev/null
@@ -1,128 +0,0 @@
-/*
- *  ARM64 cacheinfo support
- *
- *  Copyright (C) 2015 ARM Ltd.
- *  All Rights Reserved
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed "as is" WITHOUT ANY WARRANTY of any
- * kind, whether express or implied; without even the implied warranty
- * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- */
-
-#include <linux/bitops.h>
-#include <linux/cacheinfo.h>
-#include <linux/cpu.h>
-#include <linux/compiler.h>
-#include <linux/of.h>
-
-#include <asm/cachetype.h>
-#include <asm/processor.h>
-
-#define MAX_CACHE_LEVEL			7	/* Max 7 level supported */
-/* Ctypen, bits[3(n - 1) + 2 : 3(n - 1)], for n = 1 to 7 */
-#define CLIDR_CTYPE_SHIFT(level)	(3 * (level - 1))
-#define CLIDR_CTYPE_MASK(level)		(7 << CLIDR_CTYPE_SHIFT(level))
-#define CLIDR_CTYPE(clidr, level)	\
-	(((clidr) & CLIDR_CTYPE_MASK(level)) >> CLIDR_CTYPE_SHIFT(level))
-
-static inline enum cache_type get_cache_type(int level)
-{
-	u64 clidr;
-
-	if (level > MAX_CACHE_LEVEL)
-		return CACHE_TYPE_NOCACHE;
-	asm volatile ("mrs     %x0, clidr_el1" : "=r" (clidr));
-	return CLIDR_CTYPE(clidr, level);
-}
-
-/*
- * Cache Size Selection Register(CSSELR) selects which Cache Size ID
- * Register(CCSIDR) is accessible by specifying the required cache
- * level and the cache type. We need to ensure that no one else changes
- * CSSELR by calling this in non-preemtible context
- */
-u64 __attribute_const__ cache_get_ccsidr(u64 csselr)
-{
-	u64 ccsidr;
-
-	WARN_ON(preemptible());
-
-	/* Put value into CSSELR */
-	asm volatile("msr csselr_el1, %x0" : : "r" (csselr));
-	isb();
-	/* Read result out of CCSIDR */
-	asm volatile("mrs %x0, ccsidr_el1" : "=r" (ccsidr));
-
-	return ccsidr;
-}
-
-static void ci_leaf_init(struct cacheinfo *this_leaf,
-			 enum cache_type type, unsigned int level)
-{
-	bool is_icache = type & CACHE_TYPE_INST;
-	u64 tmp = cache_get_ccsidr((level - 1) << 1 | is_icache);
-
-	this_leaf->level = level;
-	this_leaf->type = type;
-	this_leaf->coherency_line_size = CACHE_LINESIZE(tmp);
-	this_leaf->number_of_sets = CACHE_NUMSETS(tmp);
-	this_leaf->ways_of_associativity = CACHE_ASSOCIATIVITY(tmp);
-	this_leaf->size = this_leaf->number_of_sets *
-	    this_leaf->coherency_line_size * this_leaf->ways_of_associativity;
-	this_leaf->attributes =
-		((tmp & CCSIDR_EL1_WRITE_THROUGH) ? CACHE_WRITE_THROUGH : 0) |
-		((tmp & CCSIDR_EL1_WRITE_BACK) ? CACHE_WRITE_BACK : 0) |
-		((tmp & CCSIDR_EL1_READ_ALLOCATE) ? CACHE_READ_ALLOCATE : 0) |
-		((tmp & CCSIDR_EL1_WRITE_ALLOCATE) ? CACHE_WRITE_ALLOCATE : 0);
-}
-
-static int __init_cache_level(unsigned int cpu)
-{
-	unsigned int ctype, level, leaves;
-	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
-
-	for (level = 1, leaves = 0; level <= MAX_CACHE_LEVEL; level++) {
-		ctype = get_cache_type(level);
-		if (ctype == CACHE_TYPE_NOCACHE) {
-			level--;
-			break;
-		}
-		/* Separate instruction and data caches */
-		leaves += (ctype == CACHE_TYPE_SEPARATE) ? 2 : 1;
-	}
-
-	this_cpu_ci->num_levels = level;
-	this_cpu_ci->num_leaves = leaves;
-	return 0;
-}
-
-static int __populate_cache_leaves(unsigned int cpu)
-{
-	unsigned int level, idx;
-	enum cache_type type;
-	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
-	struct cacheinfo *this_leaf = this_cpu_ci->info_list;
-
-	for (idx = 0, level = 1; level <= this_cpu_ci->num_levels &&
-	     idx < this_cpu_ci->num_leaves; idx++, level++) {
-		type = get_cache_type(level);
-		if (type == CACHE_TYPE_SEPARATE) {
-			ci_leaf_init(this_leaf++, CACHE_TYPE_DATA, level);
-			ci_leaf_init(this_leaf++, CACHE_TYPE_INST, level);
-		} else {
-			ci_leaf_init(this_leaf++, type, level);
-		}
-	}
-	return 0;
-}
-
-DEFINE_SMP_CALL_CACHE_FUNCTION(init_cache_level)
-DEFINE_SMP_CALL_CACHE_FUNCTION(populate_cache_leaves)
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 75d5a86..540177a 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -254,3 +254,15 @@ void __init cpuinfo_store_boot_cpu(void)
 
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
2.1.4
