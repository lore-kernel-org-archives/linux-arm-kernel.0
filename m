From: will.deacon@arm.com (Will Deacon)
Date: Mon,  8 Aug 2011 18:16:05 +0100
Subject: [PATCH 04/10] ARM: perf: use u32 instead of unsigned long for PMNC
	register
In-Reply-To: <1312823771-9952-1-git-send-email-will.deacon@arm.com>
References: <1312823771-9952-1-git-send-email-will.deacon@arm.com>
Message-ID: <1312823771-9952-5-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARMv7 perf backend mixes up u32 and unsigned long, which is rather
ugly.

This patch makes the ARMv7 PMU code consistently use the u32 type
instead.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/perf_event_v7.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index 74f9119..f4f260d 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -758,26 +758,26 @@ enum armv7_counters {
 #define	ARMV7_FLAG_MASK		0xffffffff	/* Mask for writable bits */
 #define	ARMV7_OVERFLOWED_MASK	ARMV7_FLAG_MASK
 
-static inline unsigned long armv7_pmnc_read(void)
+static inline u32 armv7_pmnc_read(void)
 {
 	u32 val;
 	asm volatile("mrc p15, 0, %0, c9, c12, 0" : "=r"(val));
 	return val;
 }
 
-static inline void armv7_pmnc_write(unsigned long val)
+static inline void armv7_pmnc_write(u32 val)
 {
 	val &= ARMV7_PMNC_MASK;
 	isb();
 	asm volatile("mcr p15, 0, %0, c9, c12, 0" : : "r"(val));
 }
 
-static inline int armv7_pmnc_has_overflowed(unsigned long pmnc)
+static inline int armv7_pmnc_has_overflowed(u32 pmnc)
 {
 	return pmnc & ARMV7_OVERFLOWED_MASK;
 }
 
-static inline int armv7_pmnc_counter_has_overflowed(unsigned long pmnc,
+static inline int armv7_pmnc_counter_has_overflowed(u32 pmnc,
 					enum armv7_counters counter)
 {
 	int ret = 0;
@@ -812,7 +812,7 @@ static inline int armv7_pmnc_select_counter(unsigned int idx)
 
 static inline u32 armv7pmu_read_counter(int idx)
 {
-	unsigned long value = 0;
+	u32 value = 0;
 
 	if (idx == ARMV7_CYCLE_COUNTER)
 		asm volatile("mrc p15, 0, %0, c9, c13, 0" : "=r" (value));
@@ -1044,7 +1044,7 @@ static void armv7pmu_disable_event(struct hw_perf_event *hwc, int idx)
 
 static irqreturn_t armv7pmu_handle_irq(int irq_num, void *dev)
 {
-	unsigned long pmnc;
+	u32 pmnc;
 	struct perf_sample_data data;
 	struct cpu_hw_events *cpuc;
 	struct pt_regs *regs;
-- 
1.7.0.4
