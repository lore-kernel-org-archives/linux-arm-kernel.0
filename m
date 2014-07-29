From: mfuzzey@parkeon.com (Martin Fuzzey)
Date: Tue, 29 Jul 2014 14:32:59 +0200
Subject: [PATCH 1/4] ARM: perf: Set suniden bit.
In-Reply-To: <20140729123256.13347.79778.stgit@localhost>
References: <20140729123256.13347.79778.stgit@localhost>
Message-ID: <20140729123259.13347.33212.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Counters other than the CPU cycle counter only work if the security module
SUNIDEN bit is set.

Without this:
# perf stat -e cycles,instructions sleep 1

 Performance counter stats for 'sleep 1':

          14606094 cycles                    #    0.000 GHz
                 0 instructions              #    0.00  insns per cycle

Some platforms (eg i.MX53) may also need additional platform specific setup.

Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
---
 arch/arm/include/asm/pmu.h      |    7 +++++++
 arch/arm/kernel/perf_event_v7.c |   23 +++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/arm/include/asm/pmu.h b/arch/arm/include/asm/pmu.h
index ae1919b..0bd181f 100644
--- a/arch/arm/include/asm/pmu.h
+++ b/arch/arm/include/asm/pmu.h
@@ -60,6 +60,13 @@ struct pmu_hw_events {
 	 * read/modify/write sequences.
 	 */
 	raw_spinlock_t		pmu_lock;
+
+	/*
+	 * Bits indicating any CPU or platform specific activations that have
+	 * been done so we can undo them when stopping
+	 */
+	unsigned int		activated_flags;
+	#define ARM_PMU_ACTIVATED_SECURE_DEBUG	(1 << 0)
 };
 
 struct arm_pmu {
diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index 1d37568..91a41bd 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -1377,12 +1377,26 @@ static irqreturn_t armv7pmu_handle_irq(int irq_num, void *dev)
 	return IRQ_HANDLED;
 }
 
+#define SDER_SUNIDEN (1 << 1)
+
 static void armv7pmu_start(struct arm_pmu *cpu_pmu)
 {
 	unsigned long flags;
 	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
+	u32 sder;
 
 	raw_spin_lock_irqsave(&events->pmu_lock, flags);
+
+	/* Counters other than cycle counter require SUNIDEN bit set */
+	asm volatile("mrc p15, 0, %0, c1, c1, 1" : "=r" (sder));
+	if (sder & SDER_SUNIDEN) {
+		events->activated_flags &= ~ARM_PMU_ACTIVATED_SECURE_DEBUG;
+	} else {
+		sder |= SDER_SUNIDEN;
+		asm volatile("mcr p15, 0, %0, c1, c1, 1" : : "r" (sder));
+		events->activated_flags |= ARM_PMU_ACTIVATED_SECURE_DEBUG;
+	}
+
 	/* Enable all counters */
 	armv7_pmnc_write(armv7_pmnc_read() | ARMV7_PMNC_E);
 	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
@@ -1392,8 +1406,17 @@ static void armv7pmu_stop(struct arm_pmu *cpu_pmu)
 {
 	unsigned long flags;
 	struct pmu_hw_events *events = cpu_pmu->get_hw_events();
+	u32 sder;
 
 	raw_spin_lock_irqsave(&events->pmu_lock, flags);
+
+	if (events->activated_flags & ARM_PMU_ACTIVATED_SECURE_DEBUG) {
+		asm volatile("mrc p15, 0, %0, c1, c1, 1" : "=r" (sder));
+		sder &= ~SDER_SUNIDEN;
+		asm volatile("mcr p15, 0, %0, c1, c1, 1" : : "r" (sder));
+		events->activated_flags &= ~ARM_PMU_ACTIVATED_SECURE_DEBUG;
+	}
+
 	/* Disable all counters */
 	armv7_pmnc_write(armv7_pmnc_read() & ~ARMV7_PMNC_E);
 	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
