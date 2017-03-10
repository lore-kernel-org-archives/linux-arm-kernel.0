From: will.deacon@arm.com (Will Deacon)
Date: Fri, 10 Mar 2017 20:32:21 +0000
Subject: [PATCH 2/6] arm64: cacheinfo: Remove CCSIDR-based cache information
 probing
In-Reply-To: <1489177945-8590-1-git-send-email-will.deacon@arm.com>
References: <1489177945-8590-1-git-send-email-will.deacon@arm.com>
Message-ID: <1489177945-8590-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CCSIDR_EL1.{NumSets,Associativity,LineSize} fields are only for use
in conjunction with set/way cache maintenance and are not guaranteed to
represent the actual microarchitectural features of a design.

The architecture explicitly states:

| You cannot make any inference about the actual sizes of caches based
| on these parameters.

Furthermore, CCSIDR_EL1.{WT,WB,RA,WA} have been removed retrospectively
from ARMv8 and are now considered to be UNKNOWN.

Since the kernel doesn't make use of set/way cache maintenance and it is
not possible for userspace to execute these instructions, we have no
need for the CCSIDR information in the kernel.

This patch removes the accessors, along with the related portions of the
cacheinfo support, which should instead be reintroduced when firmware has
a mechanism to provide us with reliable information.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/cachetype.h | 24 ------------------------
 arch/arm64/kernel/cacheinfo.c      | 38 --------------------------------------
 2 files changed, 62 deletions(-)

diff --git a/arch/arm64/include/asm/cachetype.h b/arch/arm64/include/asm/cachetype.h
index 4dbf3d10022d..212a0f3d4ecb 100644
--- a/arch/arm64/include/asm/cachetype.h
+++ b/arch/arm64/include/asm/cachetype.h
@@ -40,30 +40,6 @@
 extern unsigned long __icache_flags;
 
 /*
- * NumSets, bits[27:13] - (Number of sets in cache) - 1
- * Associativity, bits[12:3] - (Associativity of cache) - 1
- * LineSize, bits[2:0] - (Log2(Number of words in cache line)) - 2
- */
-#define CCSIDR_EL1_WRITE_THROUGH	BIT(31)
-#define CCSIDR_EL1_WRITE_BACK		BIT(30)
-#define CCSIDR_EL1_READ_ALLOCATE	BIT(29)
-#define CCSIDR_EL1_WRITE_ALLOCATE	BIT(28)
-#define CCSIDR_EL1_LINESIZE_MASK	0x7
-#define CCSIDR_EL1_LINESIZE(x)		((x) & CCSIDR_EL1_LINESIZE_MASK)
-#define CCSIDR_EL1_ASSOCIATIVITY_SHIFT	3
-#define CCSIDR_EL1_ASSOCIATIVITY_MASK	0x3ff
-#define CCSIDR_EL1_ASSOCIATIVITY(x)	\
-	(((x) >> CCSIDR_EL1_ASSOCIATIVITY_SHIFT) & CCSIDR_EL1_ASSOCIATIVITY_MASK)
-#define CCSIDR_EL1_NUMSETS_SHIFT	13
-#define CCSIDR_EL1_NUMSETS_MASK		0x7fff
-#define CCSIDR_EL1_NUMSETS(x) \
-	(((x) >> CCSIDR_EL1_NUMSETS_SHIFT) & CCSIDR_EL1_NUMSETS_MASK)
-
-#define CACHE_LINESIZE(x)	(16 << CCSIDR_EL1_LINESIZE(x))
-#define CACHE_NUMSETS(x)	(CCSIDR_EL1_NUMSETS(x) + 1)
-#define CACHE_ASSOCIATIVITY(x)	(CCSIDR_EL1_ASSOCIATIVITY(x) + 1)
-
-/*
  * Whilst the D-side always behaves as PIPT on AArch64, aliasing is
  * permitted in the I-cache.
  */
diff --git a/arch/arm64/kernel/cacheinfo.c b/arch/arm64/kernel/cacheinfo.c
index 3f2250fc391b..380f2e2fbed5 100644
--- a/arch/arm64/kernel/cacheinfo.c
+++ b/arch/arm64/kernel/cacheinfo.c
@@ -17,15 +17,9 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
-#include <linux/bitops.h>
 #include <linux/cacheinfo.h>
-#include <linux/cpu.h>
-#include <linux/compiler.h>
 #include <linux/of.h>
 
-#include <asm/cachetype.h>
-#include <asm/processor.h>
-
 #define MAX_CACHE_LEVEL			7	/* Max 7 level supported */
 /* Ctypen, bits[3(n - 1) + 2 : 3(n - 1)], for n = 1 to 7 */
 #define CLIDR_CTYPE_SHIFT(level)	(3 * (level - 1))
@@ -43,43 +37,11 @@ static inline enum cache_type get_cache_type(int level)
 	return CLIDR_CTYPE(clidr, level);
 }
 
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
-	write_sysreg(csselr, csselr_el1);
-	isb();
-	ccsidr = read_sysreg(ccsidr_el1);
-
-	return ccsidr;
-}
-
 static void ci_leaf_init(struct cacheinfo *this_leaf,
 			 enum cache_type type, unsigned int level)
 {
-	bool is_icache = type & CACHE_TYPE_INST;
-	u64 tmp = cache_get_ccsidr((level - 1) << 1 | is_icache);
-
 	this_leaf->level = level;
 	this_leaf->type = type;
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
 }
 
 static int __init_cache_level(unsigned int cpu)
-- 
2.1.4
