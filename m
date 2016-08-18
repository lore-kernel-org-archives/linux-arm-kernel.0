From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Thu, 18 Aug 2016 13:45:53 +0100
Subject: [PATCH v2 1/8] ARM: factor out CSSELR/CCSIDR operations that use cp15
 directly
In-Reply-To: <1471524360-31554-1-git-send-email-vladimir.murzin@arm.com>
References: <1471524360-31554-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1471524360-31554-2-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jonathan Austin <jonathan.austin@arm.com>

Currently we use raw cp15 operations to access the cache setup data.

This patch abstracts the CSSELR and CCSIDR accessors out to a header so
that the implementation for them can be switched out as we do with other
cpu/cachetype operations.

Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/include/asm/cachetype.h |   24 ++++++++++++++++++++++++
 arch/arm/kernel/setup.c          |    7 ++-----
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/cachetype.h b/arch/arm/include/asm/cachetype.h
index 7ea7814..8609de8 100644
--- a/arch/arm/include/asm/cachetype.h
+++ b/arch/arm/include/asm/cachetype.h
@@ -56,4 +56,28 @@ static inline unsigned int __attribute__((pure)) cacheid_is(unsigned int mask)
 	       (~__CACHEID_NEVER & __CACHEID_ARCH_MIN & mask & cacheid);
 }
 
+#define CSSELR_ICACHE	1
+#define CSSELR_DCACHE	0
+
+#define CSSELR_L1	(0 << 1)
+#define CSSELR_L2	(1 << 1)
+#define CSSELR_L3	(2 << 1)
+#define CSSELR_L4	(3 << 1)
+#define CSSELR_L5	(4 << 1)
+#define CSSELR_L6	(5 << 1)
+#define CSSELR_L7	(6 << 1)
+
+static inline void set_csselr(unsigned int cache_selector)
+{
+	asm volatile("mcr p15, 2, %0, c0, c0, 0" : : "r" (cache_selector));
+}
+
+static inline unsigned int read_ccsidr(void)
+{
+	unsigned int val;
+
+	asm volatile("mrc p15, 1, %0, c0, c0, 0" : "=r" (val));
+	return val;
+}
+
 #endif
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index df7f2a7..2055490 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -290,12 +290,9 @@ static int cpu_has_aliasing_icache(unsigned int arch)
 	/* arch specifies the register format */
 	switch (arch) {
 	case CPU_ARCH_ARMv7:
-		asm("mcr	p15, 2, %0, c0, c0, 0 @ set CSSELR"
-		    : /* No output operands */
-		    : "r" (1));
+		set_csselr(CSSELR_ICACHE | CSSELR_L1);
 		isb();
-		asm("mrc	p15, 1, %0, c0, c0, 0 @ read CCSIDR"
-		    : "=r" (id_reg));
+		id_reg = read_ccsidr();
 		line_size = 4 << ((id_reg & 0x7) + 2);
 		num_sets = ((id_reg >> 13) & 0x7fff) + 1;
 		aliasing_icache = (line_size * num_sets) > PAGE_SIZE;
-- 
1.7.9.5
