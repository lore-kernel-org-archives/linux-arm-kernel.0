From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Sat, 15 Sep 2012 11:35:02 -0400
Subject: [PATCH 05/15] ARM: Expose PMNC bitfields for KVM use
In-Reply-To: <20120915153359.21241.86002.stgit@ubuntu>
References: <20120915153359.21241.86002.stgit@ubuntu>
Message-ID: <20120915153502.21241.13218.stgit@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rusty Russell <rusty.russell@linaro.org>

We want some of these for use in KVM, so pull them out of
arch/arm/kernel/perf_event_v7.c into their own asm/perf_bits.h.

Signed-off-by: Rusty Russell <rusty.russell@linaro.org>
Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
---
 arch/arm/include/asm/perf_bits.h |   56 ++++++++++++++++++++++++++++++++++++++
 arch/arm/kernel/perf_event_v7.c  |   51 +----------------------------------
 2 files changed, 57 insertions(+), 50 deletions(-)
 create mode 100644 arch/arm/include/asm/perf_bits.h

diff --git a/arch/arm/include/asm/perf_bits.h b/arch/arm/include/asm/perf_bits.h
new file mode 100644
index 0000000..eeb266a
--- /dev/null
+++ b/arch/arm/include/asm/perf_bits.h
@@ -0,0 +1,56 @@
+#ifndef __ARM_PERF_BITS_H__
+#define __ARM_PERF_BITS_H__
+
+/*
+ * ARMv7 low level PMNC access
+ */
+
+/*
+ * Per-CPU PMNC: config reg
+ */
+#define ARMV7_PMNC_E		(1 << 0) /* Enable all counters */
+#define ARMV7_PMNC_P		(1 << 1) /* Reset all counters */
+#define ARMV7_PMNC_C		(1 << 2) /* Cycle counter reset */
+#define ARMV7_PMNC_D		(1 << 3) /* CCNT counts every 64th cpu cycle */
+#define ARMV7_PMNC_X		(1 << 4) /* Export to ETM */
+#define ARMV7_PMNC_DP		(1 << 5) /* Disable CCNT if non-invasive debug*/
+#define	ARMV7_PMNC_N_SHIFT	11	 /* Number of counters supported */
+#define	ARMV7_PMNC_N_MASK	0x1f
+#define	ARMV7_PMNC_MASK		0x3f	 /* Mask for writable bits */
+
+/*
+ * FLAG: counters overflow flag status reg
+ */
+#define	ARMV7_FLAG_MASK		0xffffffff	/* Mask for writable bits */
+#define	ARMV7_OVERFLOWED_MASK	ARMV7_FLAG_MASK
+
+/*
+ * PMXEVTYPER: Event selection reg
+ */
+#define	ARMV7_EVTYPE_MASK	0xc00000ff	/* Mask for writable bits */
+#define	ARMV7_EVTYPE_EVENT	0xff		/* Mask for EVENT bits */
+
+/*
+ * Event filters for PMUv2
+ */
+#define	ARMV7_EXCLUDE_PL1	(1 << 31)
+#define	ARMV7_EXCLUDE_USER	(1 << 30)
+#define	ARMV7_INCLUDE_HYP	(1 << 27)
+
+#ifndef __ASSEMBLY__
+static inline u32 armv7_pmnc_read(void)
+{
+	u32 val;
+	asm volatile("mrc p15, 0, %0, c9, c12, 0" : "=r"(val));
+	return val;
+}
+
+static inline void armv7_pmnc_write(u32 val)
+{
+	val &= ARMV7_PMNC_MASK;
+	isb();
+	asm volatile("mcr p15, 0, %0, c9, c12, 0" : : "r"(val));
+}
+#endif
+
+#endif /* __ARM_PERF_BITS_H__ */
diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index f04070b..09851b3 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -17,6 +17,7 @@
  */
 
 #ifdef CONFIG_CPU_V7
+#include <asm/perf_bits.h>
 
 static struct arm_pmu armv7pmu;
 
@@ -744,61 +745,11 @@ static const unsigned armv7_a7_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
 #define	ARMV7_COUNTER_MASK	(ARMV7_MAX_COUNTERS - 1)
 
 /*
- * ARMv7 low level PMNC access
- */
-
-/*
  * Perf Event to low level counters mapping
  */
 #define	ARMV7_IDX_TO_COUNTER(x)	\
 	(((x) - ARMV7_IDX_COUNTER0) & ARMV7_COUNTER_MASK)
 
-/*
- * Per-CPU PMNC: config reg
- */
-#define ARMV7_PMNC_E		(1 << 0) /* Enable all counters */
-#define ARMV7_PMNC_P		(1 << 1) /* Reset all counters */
-#define ARMV7_PMNC_C		(1 << 2) /* Cycle counter reset */
-#define ARMV7_PMNC_D		(1 << 3) /* CCNT counts every 64th cpu cycle */
-#define ARMV7_PMNC_X		(1 << 4) /* Export to ETM */
-#define ARMV7_PMNC_DP		(1 << 5) /* Disable CCNT if non-invasive debug*/
-#define	ARMV7_PMNC_N_SHIFT	11	 /* Number of counters supported */
-#define	ARMV7_PMNC_N_MASK	0x1f
-#define	ARMV7_PMNC_MASK		0x3f	 /* Mask for writable bits */
-
-/*
- * FLAG: counters overflow flag status reg
- */
-#define	ARMV7_FLAG_MASK		0xffffffff	/* Mask for writable bits */
-#define	ARMV7_OVERFLOWED_MASK	ARMV7_FLAG_MASK
-
-/*
- * PMXEVTYPER: Event selection reg
- */
-#define	ARMV7_EVTYPE_MASK	0xc00000ff	/* Mask for writable bits */
-#define	ARMV7_EVTYPE_EVENT	0xff		/* Mask for EVENT bits */
-
-/*
- * Event filters for PMUv2
- */
-#define	ARMV7_EXCLUDE_PL1	(1 << 31)
-#define	ARMV7_EXCLUDE_USER	(1 << 30)
-#define	ARMV7_INCLUDE_HYP	(1 << 27)
-
-static inline u32 armv7_pmnc_read(void)
-{
-	u32 val;
-	asm volatile("mrc p15, 0, %0, c9, c12, 0" : "=r"(val));
-	return val;
-}
-
-static inline void armv7_pmnc_write(u32 val)
-{
-	val &= ARMV7_PMNC_MASK;
-	isb();
-	asm volatile("mcr p15, 0, %0, c9, c12, 0" : : "r"(val));
-}
-
 static inline int armv7_pmnc_has_overflowed(u32 pmnc)
 {
 	return pmnc & ARMV7_OVERFLOWED_MASK;
