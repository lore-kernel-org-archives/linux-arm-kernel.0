From: jamie.iles@picochip.com (Jamie Iles)
Date: Mon, 14 Dec 2009 14:04:41 +0000
Subject: [PATCH 5/5] arm/perfevents: implement perf event support for ARMv6
In-Reply-To: <1260799481-29951-5-git-send-email-jamie.iles@picochip.com>
References: <1260799481-29951-1-git-send-email-jamie.iles@picochip.com>
	<1260799481-29951-2-git-send-email-jamie.iles@picochip.com>
	<1260799481-29951-3-git-send-email-jamie.iles@picochip.com>
	<1260799481-29951-4-git-send-email-jamie.iles@picochip.com>
	<1260799481-29951-5-git-send-email-jamie.iles@picochip.com>
Message-ID: <1260799481-29951-6-git-send-email-jamie.iles@picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch implements support for ARMv6 performance counters in the
Linux performance events subsystem. ARMv6 architectures that have the
performance counters should enable HW_PERF_EVENTS and define the
interrupts for the counters in arch/arm/kernel/perf_event.c

Signed-off-by: Jamie Iles <jamie.iles@picochip.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@elte.hu>
---
 arch/arm/kernel/Makefile     |    1 +
 arch/arm/kernel/perf_event.c | 1034 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mm/Kconfig          |    8 +
 3 files changed, 1043 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/kernel/perf_event.c

diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 286a276..44ebf36 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -47,6 +47,7 @@ obj-$(CONFIG_CPU_XSC3)		+= xscale-cp0.o
 obj-$(CONFIG_CPU_MOHAWK)	+= xscale-cp0.o
 obj-$(CONFIG_IWMMXT)		+= iwmmxt.o
 obj-$(CONFIG_CPU_HAS_PMU)	+= pmu.o
+obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event.o
 AFLAGS_iwmmxt.o			:= -Wa,-mcpu=iwmmxt
 
 ifneq ($(CONFIG_ARCH_EBSA110),y)
diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
new file mode 100644
index 0000000..358fd31
--- /dev/null
+++ b/arch/arm/kernel/perf_event.c
@@ -0,0 +1,1034 @@
+#undef DEBUG
+
+/*
+ * ARMv6 performance counter support.
+ *
+ * Copyright (C) 2009 picoChip Designs, Ltd., Jamie Iles
+ *
+ * This code is based on the sparc64 perf event code, which is in turn based
+ * on the x86 code. Callchain code is based on the ARM OProfile backtrace
+ * code.
+ */
+#define pr_fmt(fmt) "armv6_perfctr: " fmt
+
+#include <linux/kernel.h>
+#include <linux/perf_event.h>
+#include <linux/interrupt.h>
+#include <linux/spinlock.h>
+#include <linux/uaccess.h>
+
+#include <asm/irq_regs.h>
+#include <asm/stacktrace.h>
+#include <asm/irq.h>
+#include <asm/pmu.h>
+
+/*
+ * ARMv6 has 2 configurable performance counters and a single cycle counter.
+ * They all share a single reset bit but can be written to zero so we can use
+ * that for a reset.
+ *
+ * The counters can't be individually enabled or disabled so when we remove
+ * one event and replace it with another we could get spurious counts from the
+ * wrong event. However, we can take advantage of the fact that the
+ * performance counters can export events to the event bus, and the event bus
+ * itself can be monitored. This requires that we *don't* export the events to
+ * the event bus. The procedure for disabling a configurable counter is:
+ *	- change the counter to count the ETMEXTOUT[0] signal (0x20). This
+ *	  effectively stops the counter from counting.
+ *	- disable the counter's interrupt generation (each counter has it's
+ *	  own interrupt enable bit).
+ * Once stopped, the counter value can be written as 0 to reset.
+ *
+ * To enable a counter:
+ *	- enable the counter's interrupt generation.
+ *	- set the new event type.
+ *
+ * Note: the dedicated cycle counter only counts cycles and can't be
+ * enabled/disabled independently of the others. When we want to disable the
+ * cycle counter, we have to just disable the interrupt reporting and start
+ * ignoring that counter. When re-enabling, we have to reset the value and
+ * enable the interrupt.
+ */
+
+static const struct pmu_irqs *pmu_irqs;
+
+/*
+ * Hardware lock to serialize accesses to PMU registers. Needed for the
+ * read/modify/write sequences.
+ */
+DEFINE_SPINLOCK(pmu_lock);
+
+enum arm_perf_types {
+	ARM_PERFCTR_ICACHE_MISS		= 0x0,
+	ARM_PERFCTR_IBUF_STALL		= 0x1,
+	ARM_PERFCTR_DDEP_STALL		= 0x2,
+	ARM_PERFCTR_ITLB_MISS		= 0x3,
+	ARM_PERFCTR_DTLB_MISS		= 0x4,
+	ARM_PERFCTR_BR_EXEC		= 0x5,
+	ARM_PERFCTR_BR_MISPREDICT	= 0x6,
+	ARM_PERFCTR_INSTR_EXEC		= 0x7,
+	ARM_PERFCTR_DCACHE_HIT		= 0x9,
+	ARM_PERFCTR_DCACHE_ACCESS	= 0xA,
+	ARM_PERFCTR_DCACHE_MISS		= 0xB,
+	ARM_PERFCTR_DCACHE_WBACK	= 0xC,
+	ARM_PERFCTR_SW_PC_CHANGE	= 0xD,
+	ARM_PERFCTR_MAIN_TLB_MISS	= 0xF,
+	ARM_PERFCTR_EXPL_D_ACCESS	= 0x10,
+	ARM_PERFCTR_LSU_FULL_STALL	= 0x11,
+	ARM_PERFCTR_WBUF_DRAINED	= 0x12,
+	ARM_PERFCTR_CPU_CYCLES		= 0xFF,
+	ARM_PERFCTR_NOP			= 0x20,
+};
+
+/* We support using the full 32 bits of each counter. */
+#define MAX_PERIOD			((1LLU << 32) - 1)
+
+enum armv6_counters {
+	ARMV6_CYCLE_COUNTER = 1,
+	ARMV6_COUNTER0,
+	ARMV6_COUNTER1,
+};
+
+/* We support 3 simultaneous events, but they begin from 1. */
+#define ARMV6_MAX_HWEVENTS		4
+
+/* The events for a given CPU. */
+struct cpu_hw_events {
+	/*
+	 * The events that are active on the CPU for the given index. Index 0
+	 * is reserved.
+	 */
+	struct perf_event	*events[ARMV6_MAX_HWEVENTS];
+
+	/*
+	 * A 1 bit for an index indicates that the counter is being used for
+	 * an event. A 0 means that the counter can be used.
+	 */
+	unsigned long		used_mask[BITS_TO_LONGS(ARMV6_MAX_HWEVENTS)];
+
+	/*
+	 * A 1 bit for an index indicates that the counter is actively being
+	 * used.
+	 */
+	unsigned long		active_mask[BITS_TO_LONGS(ARMV6_MAX_HWEVENTS)];
+};
+DEFINE_PER_CPU(struct cpu_hw_events, cpu_hw_events);
+
+#define HW_OP_UNSUPPORTED		    0xFFFF
+
+/*
+ * The hardware events that we support. We do support cache operations but
+ * we have harvard caches and no way to combine instruction and data
+ * accesses/misses in hardware.
+ */
+static const unsigned v6_perf_map[PERF_COUNT_HW_MAX] = {
+	[PERF_COUNT_HW_CPU_CYCLES]	    = ARM_PERFCTR_CPU_CYCLES,
+	[PERF_COUNT_HW_INSTRUCTIONS]	    = ARM_PERFCTR_INSTR_EXEC,
+	[PERF_COUNT_HW_CACHE_REFERENCES]    = HW_OP_UNSUPPORTED,
+	[PERF_COUNT_HW_CACHE_MISSES]	    = HW_OP_UNSUPPORTED,
+	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] = ARM_PERFCTR_BR_EXEC,
+	[PERF_COUNT_HW_BRANCH_MISSES]	    = ARM_PERFCTR_BR_MISPREDICT,
+	[PERF_COUNT_HW_BUS_CYCLES]	    = HW_OP_UNSUPPORTED,
+};
+
+static inline int
+armv6_map_hw_event(u64 config)
+{
+	int mapping = v6_perf_map[config];
+	if (HW_OP_UNSUPPORTED == mapping)
+		mapping = -EOPNOTSUPP;
+	return mapping;
+}
+
+#define C(_x) \
+	PERF_COUNT_HW_CACHE_##_x
+
+#define CACHE_OP_UNSUPPORTED		0xFFFF
+
+static const unsigned v6_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
+				       [PERF_COUNT_HW_CACHE_OP_MAX]
+				       [PERF_COUNT_HW_CACHE_RESULT_MAX] = {
+	[C(L1D)] = {
+		/*
+		 * The performance counters don't differentiate between read
+		 * and write accesses/misses so this isn't strictly correct,
+		 * but it's the best we can do. Writes and reads get
+		 * combined.
+		 */
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)]	= ARM_PERFCTR_DCACHE_ACCESS,
+			[C(RESULT_MISS)]	= ARM_PERFCTR_DCACHE_MISS,
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)]	= ARM_PERFCTR_DCACHE_ACCESS,
+			[C(RESULT_MISS)]	= ARM_PERFCTR_DCACHE_MISS,
+		},
+		[C(OP_PREFETCH)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+	},
+	[C(L1I)] = {
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= ARM_PERFCTR_ICACHE_MISS,
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= ARM_PERFCTR_ICACHE_MISS,
+		},
+		[C(OP_PREFETCH)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+	},
+	[C(LL)] = {
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+		[C(OP_PREFETCH)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+	},
+	[C(DTLB)] = {
+		/*
+		 * The ARM performance counters can count micro DTLB misses,
+		 * micro ITLB misses and main TLB misses. There isn't an event
+		 * for TLB misses, so use the micro misses here and if users
+		 * want the main TLB misses they can use a raw counter.
+		 */
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= ARM_PERFCTR_DTLB_MISS,
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= ARM_PERFCTR_DTLB_MISS,
+		},
+		[C(OP_PREFETCH)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+	},
+	[C(ITLB)] = {
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= ARM_PERFCTR_ITLB_MISS,
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= ARM_PERFCTR_ITLB_MISS,
+		},
+		[C(OP_PREFETCH)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+	},
+	[C(BPU)] = {
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+		[C(OP_PREFETCH)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+	},
+};
+
+static const int
+armv6_map_cache_event(u64 config)
+{
+	unsigned int cache_type, cache_op, cache_result, ret;
+
+	cache_type = (config >>  0) & 0xff;
+	if (cache_type >= PERF_COUNT_HW_CACHE_MAX)
+		return -EINVAL;
+
+	cache_op = (config >>  8) & 0xff;
+	if (cache_op >= PERF_COUNT_HW_CACHE_OP_MAX)
+		return -EINVAL;
+
+	cache_result = (config >> 16) & 0xff;
+	if (cache_result >= PERF_COUNT_HW_CACHE_RESULT_MAX)
+		return -EINVAL;
+
+	ret = (int)v6_perf_cache_map[cache_type][cache_op][cache_result];
+
+	if (ret == CACHE_OP_UNSUPPORTED)
+		return -ENOENT;
+
+	return ret;
+}
+
+#define PMCR_ENABLE		(1 << 0)
+#define PMCR_CTR01_RESET    	(1 << 1)
+#define PMCR_CCOUNT_RESET   	(1 << 2)
+#define PMCR_CCOUNT_DIV	    	(1 << 3)
+#define PMCR_COUNT0_IEN	    	(1 << 4)
+#define PMCR_COUNT1_IEN	    	(1 << 5)
+#define PMCR_CCOUNT_IEN	    	(1 << 6)
+#define PMCR_COUNT0_OVERFLOW	(1 << 8)
+#define PMCR_COUNT1_OVERFLOW	(1 << 9)
+#define PMCR_CCOUNT_OVERFLOW	(1 << 10)
+#define PMCR_EVT_COUNT0_SHIFT	20
+#define PMCR_EVT_COUNT0_MASK	(0xFF << PMCR_EVT_COUNT0_SHIFT)
+#define PMCR_EVT_COUNT1_SHIFT	12
+#define PMCR_EVT_COUNT1_MASK	(0xFF << PMCR_EVT_COUNT1_SHIFT)
+
+static inline unsigned long
+pmcr_read(void)
+{
+	u32 val;
+	asm volatile("mrc   p15, 0, %0, c15, c12, 0" : "=r"(val));
+	return val;
+}
+
+static inline void
+pmcr_write(unsigned long val)
+{
+	asm volatile("mcr   p15, 0, %0, c15, c12, 0" : : "r"(val));
+}
+
+#define PMCR_OVERFLOWED_MASK \
+	(PMCR_COUNT0_OVERFLOW | PMCR_COUNT1_OVERFLOW | PMCR_CCOUNT_OVERFLOW)
+
+static inline int
+pmcr_has_overflowed(unsigned long pmcr)
+{
+	return (pmcr & PMCR_OVERFLOWED_MASK);
+}
+
+static inline int
+pmcr_counter_has_overflowed(unsigned long pmcr,
+			    enum armv6_counters counter)
+{
+	int ret;
+
+	if (ARMV6_CYCLE_COUNTER == counter)
+		ret = pmcr & PMCR_CCOUNT_OVERFLOW;
+	else if (ARMV6_COUNTER0 == counter)
+		ret = pmcr & PMCR_COUNT0_OVERFLOW;
+	else if (ARMV6_COUNTER1 == counter)
+		ret = pmcr & PMCR_COUNT1_OVERFLOW;
+	else
+		BUG();
+
+	return ret;
+}
+
+static inline unsigned long
+armv6pmu_read_counter(enum armv6_counters counter)
+{
+	unsigned long value;
+
+	if (ARMV6_CYCLE_COUNTER == counter)
+		asm volatile("mrc   p15, 0, %0, c15, c12, 1" : "=r"(value));
+	else if (ARMV6_COUNTER0 == counter)
+		asm volatile("mrc   p15, 0, %0, c15, c12, 2" : "=r"(value));
+	else if (ARMV6_COUNTER1 == counter)
+		asm volatile("mrc   p15, 0, %0, c15, c12, 3" : "=r"(value));
+	else
+		BUG();
+
+	return value;
+}
+
+static inline void
+armv6pmu_write_counter(enum armv6_counters counter,
+		       unsigned long value)
+{
+	if (ARMV6_CYCLE_COUNTER == counter)
+		asm volatile("mcr   p15, 0, %0, c15, c12, 1" : : "r"(value));
+	else if (ARMV6_COUNTER0 == counter)
+		asm volatile("mcr   p15, 0, %0, c15, c12, 2" : : "r"(value));
+	else if (ARMV6_COUNTER1 == counter)
+		asm volatile("mcr   p15, 0, %0, c15, c12, 3" : : "r"(value));
+	else
+		BUG();
+}
+
+static int
+armv6pmu_place_event(struct cpu_hw_events *cpuc,
+		     struct hw_perf_event *event)
+{
+	/* Always place a cycle counter into the cycle counter. */
+	if (ARM_PERFCTR_CPU_CYCLES == event->config_base) {
+		if (test_and_set_bit(ARMV6_CYCLE_COUNTER, cpuc->used_mask))
+			return -EAGAIN;
+
+		return ARMV6_CYCLE_COUNTER;
+	} else {
+		/*
+		 * For anything other than a cycle counter, try and use
+		 * counter0 and counter1.
+		 */
+		if (!test_and_set_bit(ARMV6_COUNTER1, cpuc->used_mask)) {
+			return ARMV6_COUNTER1;
+		}
+
+		if (!test_and_set_bit(ARMV6_COUNTER0, cpuc->used_mask)) {
+			return ARMV6_COUNTER0;
+		}
+
+		/* The counters are all in use. */
+		return -EAGAIN;
+	}
+}
+
+static void
+armv6pmu_disable_event(struct cpu_hw_events *cpuc,
+		       struct hw_perf_event *hwc,
+		       int idx)
+{
+	unsigned long val, mask, evt, flags;
+
+	if (ARMV6_CYCLE_COUNTER == idx) {
+		mask	= PMCR_CCOUNT_IEN;
+		evt	= 0;
+	} else if (ARMV6_COUNTER0 == idx) {
+		mask	= PMCR_COUNT0_IEN | PMCR_EVT_COUNT0_MASK;
+		evt	= ARM_PERFCTR_NOP << PMCR_EVT_COUNT0_SHIFT;
+	} else if (ARMV6_COUNTER1 == idx) {
+		mask	= PMCR_COUNT1_IEN | PMCR_EVT_COUNT1_MASK;
+		evt	= ARM_PERFCTR_NOP << PMCR_EVT_COUNT1_SHIFT;
+	} else {
+		BUG();
+	}
+
+	/*
+	 * Mask out the current event and set the counter to count the number
+	 * of ETM bus signal assertion cycles. The external reporting should
+	 * be disabled and so this should never increment.
+	 */
+	spin_lock_irqsave(&pmu_lock, flags);
+	val = pmcr_read();
+	val &= ~mask;
+	val |= evt;
+	pmcr_write(val);
+	spin_unlock_irqrestore(&pmu_lock, flags);
+}
+
+static void
+armv6pmu_enable_event(struct cpu_hw_events *cpuc,
+		      struct hw_perf_event *hwc,
+		      int idx)
+{
+	unsigned long val, mask, evt, flags;
+
+	if (ARMV6_CYCLE_COUNTER == idx) {
+		mask	= 0;
+		evt	= PMCR_CCOUNT_IEN;
+	} else if (ARMV6_COUNTER0 == idx) {
+		mask	= PMCR_EVT_COUNT0_MASK;
+		evt	= (hwc->config_base << PMCR_EVT_COUNT0_SHIFT) |
+			  PMCR_COUNT0_IEN;
+	} else if (ARMV6_COUNTER1 == idx) {
+		mask	= PMCR_EVT_COUNT1_MASK;
+		evt	= (hwc->config_base << PMCR_EVT_COUNT1_SHIFT) |
+			  PMCR_COUNT1_IEN;
+	} else {
+		BUG();
+	}
+
+	/*
+	 * Mask out the current event and set the counter to count the event
+	 * that we're interested in.
+	 */
+	spin_lock_irqsave(&pmu_lock, flags);
+	val = pmcr_read();
+	val &= ~mask;
+	val |= evt;
+	pmcr_write(val);
+	spin_unlock_irqrestore(&pmu_lock, flags);
+}
+
+static int
+armv6pmu_event_set_period(struct perf_event *event,
+			  struct hw_perf_event *hwc,
+			  int idx)
+{
+	s64 left = atomic64_read(&hwc->period_left);
+	s64 period = hwc->sample_period;
+	int ret = 0;
+
+	if (unlikely(left <= -period)) {
+		left = period;
+		atomic64_set(&hwc->period_left, left);
+		hwc->last_period = period;
+		ret = 1;
+	}
+
+	if (unlikely(left <= 0)) {
+		left += period;
+		atomic64_set(&hwc->period_left, left);
+		hwc->last_period = period;
+		ret = 1;
+	}
+
+	if (left > MAX_PERIOD)
+		left = MAX_PERIOD;
+
+	atomic64_set(&hwc->prev_count, (u64)-left);
+
+	armv6pmu_write_counter(idx, (u64)(-left) & 0xffffffff);
+
+	perf_event_update_userpage(event);
+
+	return ret;
+}
+
+static int
+armv6pmu_enable(struct perf_event *event)
+{
+	struct cpu_hw_events *cpuc = &__get_cpu_var(cpu_hw_events);
+	struct hw_perf_event *hwc = &event->hw;
+	int idx;
+	int err = 0;
+
+	/* If we don't have a space for the counter then finish early. */
+	idx = armv6pmu_place_event(cpuc, hwc);
+	if (idx < 0) {
+		err = idx;
+		goto out;
+	}
+
+	/*
+	 * If there is an event in the counter we are going to use then make
+	 * sure it is disabled.
+	 */
+	event->hw.idx = idx;
+	armv6pmu_disable_event(cpuc, hwc, idx);
+	cpuc->events[idx] = event;
+	set_bit(idx, cpuc->active_mask);
+
+	/* Set the period for the event. */
+	armv6pmu_event_set_period(event, hwc, idx);
+
+	/* Enable the event. */
+	armv6pmu_enable_event(cpuc, hwc, idx);
+
+	/* Propagate our changes to the userspace mapping. */
+	perf_event_update_userpage(event);
+
+out:
+	return err;
+}
+
+static u64
+armv6pmu_event_update(struct perf_event *event,
+		      struct hw_perf_event *hwc,
+		      int idx)
+{
+	int shift = 64 - 32;
+	u64 prev_raw_count, new_raw_count;
+	s64 delta;
+
+again:
+	prev_raw_count = atomic64_read(&hwc->prev_count);
+	new_raw_count = armv6pmu_read_counter(idx);
+
+	if (atomic64_cmpxchg(&hwc->prev_count, prev_raw_count,
+			     new_raw_count) != prev_raw_count)
+		goto again;
+
+	delta = (new_raw_count << shift) - (prev_raw_count << shift);
+	delta >>= shift;
+
+	atomic64_add(delta, &event->count);
+	atomic64_sub(delta, &hwc->period_left);
+
+	return new_raw_count;
+}
+
+static void
+armv6pmu_disable(struct perf_event *event)
+{
+	struct cpu_hw_events *cpuc = &__get_cpu_var(cpu_hw_events);
+	struct hw_perf_event *hwc = &event->hw;
+	int idx = hwc->idx;
+
+	WARN_ON(idx < 0);
+
+	clear_bit(idx, cpuc->active_mask);
+	armv6pmu_disable_event(cpuc, hwc, idx);
+
+	barrier();
+
+	armv6pmu_event_update(event, hwc, idx);
+	cpuc->events[idx] = NULL;
+	clear_bit(idx, cpuc->used_mask);
+
+	perf_event_update_userpage(event);
+}
+
+static void
+armv6pmu_read(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	/* Don't read disabled counters! */
+	if (hwc->idx < 0)
+		return;
+
+	armv6pmu_event_update(event, hwc, hwc->idx);
+}
+
+static void
+armv6pmu_unthrottle(struct perf_event *event)
+{
+	struct cpu_hw_events *cpuc = &__get_cpu_var(cpu_hw_events);
+	struct hw_perf_event *hwc = &event->hw;
+
+	armv6pmu_enable_event(cpuc, hwc, hwc->idx);
+}
+
+static irqreturn_t
+armv6_perfcounters_irq(int irq_num,
+		       void *dev)
+{
+	unsigned long pmcr = pmcr_read();
+	struct perf_sample_data data;
+	struct cpu_hw_events *cpuc;
+	struct pt_regs *regs;
+	int idx;
+
+	if (!pmcr_has_overflowed(pmcr))
+		return IRQ_NONE;
+
+	regs = get_irq_regs();
+
+	/*
+	 * The interrupts are cleared by writing the overflow flags back to
+	 * the control register. All of the other bits don't have any effect
+	 * if they are rewritten, so write the whole value back.
+	 */
+	pmcr_write(pmcr);
+
+	data.addr = 0;
+
+	cpuc = &__get_cpu_var(cpu_hw_events);
+	for (idx = 0; idx < ARMV6_MAX_HWEVENTS; ++idx) {
+		struct perf_event *event = cpuc->events[idx];
+		struct hw_perf_event *hwc;
+
+		if (!test_bit(idx, cpuc->active_mask))
+			continue;
+
+		/*
+		 * We have a single interrupt for all counters. Check that
+		 * each counter has overflowed before we process it.
+		 */
+		if (!pmcr_counter_has_overflowed(pmcr, idx))
+			continue;
+
+		hwc = &event->hw;
+		armv6pmu_event_update(event, hwc, idx);
+		data.period = event->hw.last_period;
+		if (!armv6pmu_event_set_period(event, hwc, idx))
+			continue;
+
+		if (perf_event_overflow(event, 0, &data, regs))
+			armv6pmu_disable_event(cpuc, hwc, idx);
+	}
+
+	/*
+	 * Handle the pending perf events.
+	 *
+	 * Note: this call *must* be run with interrupts enabled. For
+	 * platforms that can have the PMU interrupts raised as a PMI, this
+	 * will not work.
+	 */
+	perf_event_do_pending();
+
+	return IRQ_HANDLED;
+}
+
+void
+hw_perf_enable(void)
+{
+	/* Enable all of the perf events on hardware. */
+	int idx;
+	struct cpu_hw_events *cpuc = &__get_cpu_var(cpu_hw_events);
+	unsigned long flags, val;
+
+	for (idx = 0; idx < ARMV6_MAX_HWEVENTS; ++idx) {
+		struct perf_event *event = cpuc->events[idx];
+
+		if (!event)
+			continue;
+
+		armv6pmu_enable_event(cpuc, &event->hw, idx);
+	}
+
+	spin_lock_irqsave(&pmu_lock, flags);
+	val = pmcr_read();
+	val |= PMCR_ENABLE;
+	pmcr_write(val);
+	spin_unlock_irqrestore(&pmu_lock, flags);
+}
+
+void
+hw_perf_disable(void)
+{
+	unsigned long flags, val;
+
+	spin_lock_irqsave(&pmu_lock, flags);
+	val = pmcr_read();
+	val &= ~PMCR_ENABLE;
+	pmcr_write(val);
+	spin_unlock_irqrestore(&pmu_lock, flags);
+}
+
+static const struct pmu armv6pmu = {
+	.enable		= armv6pmu_enable,
+	.disable    	= armv6pmu_disable,
+	.read	    	= armv6pmu_read,
+	.unthrottle 	= armv6pmu_unthrottle,
+};
+
+static int
+validate_event(struct cpu_hw_events *cpuc,
+	       struct perf_event *event)
+{
+        struct hw_perf_event fake_event = event->hw;
+
+        if (event->pmu && event->pmu != &armv6pmu)
+                return 0;
+
+        return armv6pmu_place_event(cpuc, &fake_event) >= 0;
+}
+
+static int
+validate_group(struct perf_event *event)
+{
+        struct perf_event *sibling, *leader = event->group_leader;
+        struct cpu_hw_events fake_pmu;
+
+        memset(&fake_pmu, 0, sizeof(fake_pmu));
+
+        if (!validate_event(&fake_pmu, leader))
+                return -ENOSPC;
+
+        list_for_each_entry(sibling, &leader->sibling_list, group_entry) {
+                if (!validate_event(&fake_pmu, sibling))
+                        return -ENOSPC;
+        }
+
+        if (!validate_event(&fake_pmu, event))
+                return -ENOSPC;
+
+        return 0;
+}
+
+static int
+armv6_hw_perf_event_init(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	int mapping, err;
+
+	/* Decode the generic type into an ARM event identifier. */
+	if (PERF_TYPE_HARDWARE == event->attr.type) {
+		mapping = armv6_map_hw_event(event->attr.config);
+	} else if (PERF_TYPE_HW_CACHE == event->attr.type) {
+		mapping = armv6_map_cache_event(event->attr.config);
+	} else if (PERF_TYPE_RAW == event->attr.type) {
+		/* The EvtCountN field of the PMCR is 8 bits. */
+		mapping = event->attr.config & 0xFF;
+	} else {
+		pr_debug("event type %x not supported\n", event->attr.type);
+		return -EOPNOTSUPP;
+	}
+
+	if (mapping < 0) {
+		pr_debug("event %x:%llx not supported\n", event->attr.type,
+			 event->attr.config);
+		return mapping;
+	}
+
+	/*
+	 * Check whether we need to exclude the counter from certain modes.
+	 * The ARM performance counters are on all of the time so if someone
+	 * has asked us for some excludes then we have to fail.
+	 */
+	if (event->attr.exclude_kernel || event->attr.exclude_user ||
+	    event->attr.exclude_hv || event->attr.exclude_idle) {
+		pr_debug("ARM performance counters do not support "
+			 "mode exclusion\n");
+		return -EPERM;
+	}
+
+	/*
+	 * We don't assign an index until we actually place the event onto
+	 * hardware. Use -1 to signify that we haven't decided where to put it
+	 * yet. For SMP systems, each core has it's own PMU so we can't do any
+	 * clever allocation or constraints checking at this point.
+	 */
+	hwc->idx = -1;
+
+	/*
+	 * Store the event encoding into the config_base field. config and
+	 * event_base are unused as the only 2 things we need to know are
+	 * the event mapping and the counter to use. The counter to use is
+	 * also the indx and the config_base is the event type.
+	 */
+	hwc->config_base	    = (unsigned long)mapping;
+	hwc->config		    = 0;
+	hwc->event_base		    = 0;
+
+	if (!hwc->sample_period) {
+		hwc->sample_period  = MAX_PERIOD;
+		hwc->last_period    = hwc->sample_period;
+		atomic64_set(&hwc->period_left, hwc->sample_period);
+	}
+
+	err = 0;
+	if (event->group_leader != event) {
+		err = validate_group(event);
+		if (err)
+			return -EINVAL;
+	}
+
+	return err;
+}
+
+static int
+armv6pmu_reserve_hardware(void)
+{
+	int i;
+	int err;
+
+	pmu_irqs = reserve_pmu();
+	if (IS_ERR(pmu_irqs)) {
+		pr_warning("unable to reserve pmu\n");
+		return PTR_ERR(pmu_irqs);
+	}
+
+	init_pmu();
+
+	if (pmu_irqs->num_irqs < 1) {
+		pr_err("no irqs for PMUs defined\n");
+	}
+
+	for (i = 0; i < pmu_irqs->num_irqs; ++i) {
+		err = request_irq(pmu_irqs->irqs[i], armv6_perfcounters_irq,
+				  IRQF_DISABLED, "armv6_perfctr", NULL);
+		if (err) {
+			pr_warning("unable to request IRQ%d for ARMv6 "
+				   "perf counters\n", pmu_irqs->irqs[i]);
+			break;
+		}
+	}
+
+	if (err) {
+		for (i = i - 1; i >= 0; --i)
+			free_irq(pmu_irqs->irqs[i], NULL);
+		release_pmu(pmu_irqs);
+		pmu_irqs = NULL;
+	}
+
+	return err;
+}
+
+static void
+armv6pmu_release_hardware(void)
+{
+	int i;
+
+	for (i = pmu_irqs->num_irqs - 1; i >= 0; --i) {
+		free_irq(pmu_irqs->irqs[i], NULL);
+	}
+	pmcr_write(0);
+
+	release_pmu(pmu_irqs);
+	pmu_irqs = NULL;
+}
+
+static atomic_t active_events = ATOMIC_INIT(0);
+static DEFINE_MUTEX(pmu_reserve_mutex);
+
+static void
+hw_perf_event_destroy(struct perf_event *event)
+{
+	if (atomic_dec_and_mutex_lock(&active_events, &pmu_reserve_mutex)) {
+		armv6pmu_release_hardware();
+		mutex_unlock(&pmu_reserve_mutex);
+	}
+}
+
+const struct pmu *
+hw_perf_event_init(struct perf_event *event)
+{
+	int err = 0;
+
+	/* We support 3 events: one cycle counter and 2 programmable. */
+	perf_max_events	= 3;
+	event->destroy = hw_perf_event_destroy;
+
+	if (!atomic_inc_not_zero(&active_events)) {
+		if (atomic_read(&active_events) > perf_max_events) {
+			atomic_dec(&active_events);
+			return ERR_PTR(-ENOSPC);
+		}
+
+		mutex_lock(&pmu_reserve_mutex);
+		if (atomic_read(&active_events) == 0) {
+			err = armv6pmu_reserve_hardware();
+		}
+
+		if (!err)
+			atomic_inc(&active_events);
+		mutex_unlock(&pmu_reserve_mutex);
+	}
+
+	if (err)
+		return ERR_PTR(err);
+
+	err = armv6_hw_perf_event_init(event);
+	if (err)
+		hw_perf_event_destroy(event);
+
+	return err ? ERR_PTR(err) : &armv6pmu;
+}
+
+/* Callchain handling code. */
+static inline void
+callchain_store(struct perf_callchain_entry *entry,
+		u64 ip)
+{
+	if (entry->nr < PERF_MAX_STACK_DEPTH)
+		entry->ip[entry->nr++] = ip;
+}
+
+/*
+ * The registers we're interested in are at the end of the variable
+ * length saved register structure. The fp points at the end of this
+ * structure so the address of this struct is:
+ * (struct frame_tail *)(xxx->fp)-1
+ *
+ * This code has been adapted from the ARM OProfile support.
+ */
+struct frame_tail {
+	struct frame_tail   *fp;
+	unsigned long	    sp;
+	unsigned long	    lr;
+} __attribute__((packed));
+
+/*
+ * Get the return address for a single stackframe and return a pointer to the
+ * next frame tail.
+ */
+static struct frame_tail *
+user_backtrace(struct frame_tail *tail,
+	       struct perf_callchain_entry *entry)
+{
+	struct frame_tail buftail;
+
+	/* Also check accessibility of one struct frame_tail beyond */
+	if (!access_ok(VERIFY_READ, tail, sizeof(buftail)))
+		return NULL;
+	if (__copy_from_user_inatomic(&buftail, tail, sizeof(buftail)))
+		return NULL;
+
+	callchain_store(entry, buftail.lr);
+
+	/*
+	 * Frame pointers should strictly progress back up the stack
+	 * (towards higher addresses).
+	 */
+	if (tail >= buftail.fp)
+		return NULL;
+
+	return buftail.fp - 1;
+}
+
+static void
+perf_callchain_user(struct pt_regs *regs,
+		    struct perf_callchain_entry *entry)
+{
+	struct frame_tail *tail;
+
+	callchain_store(entry, PERF_CONTEXT_USER);
+
+	if (!user_mode(regs))
+		regs = task_pt_regs(current);
+
+	tail = (struct frame_tail *)regs->ARM_fp - 1;
+
+	while (tail && !((unsigned long)tail & 0x3))
+		tail = user_backtrace(tail, entry);
+}
+
+/*
+ * Gets called by walk_stackframe() for every stackframe. This will be called
+ * whist unwinding the stackframe and is like a subroutine return so we use
+ * the PC.
+ */
+static int
+callchain_trace(struct stackframe *fr,
+		void *data)
+{
+	struct perf_callchain_entry *entry = data;
+	callchain_store(entry, fr->pc);
+	return 0;
+}
+
+static void
+perf_callchain_kernel(struct pt_regs *regs,
+		      struct perf_callchain_entry *entry)
+{
+	struct stackframe fr;
+
+	callchain_store(entry, PERF_CONTEXT_KERNEL);
+	fr.fp = regs->ARM_fp;
+	fr.sp = regs->ARM_sp;
+	fr.lr = regs->ARM_lr;
+	fr.pc = regs->ARM_pc;
+	walk_stackframe(&fr, callchain_trace, entry);
+}
+
+static void
+perf_do_callchain(struct pt_regs *regs,
+		  struct perf_callchain_entry *entry)
+{
+	int is_user;
+
+	if (!regs)
+		return;
+
+	is_user = user_mode(regs);
+
+	if (!current || !current->pid)
+		return;
+
+	if (is_user && current->state != TASK_RUNNING)
+		return;
+
+	if (!is_user)
+		perf_callchain_kernel(regs, entry);
+
+	if (current->mm)
+		perf_callchain_user(regs, entry);
+}
+
+static DEFINE_PER_CPU(struct perf_callchain_entry, pmc_irq_entry);
+
+struct perf_callchain_entry *
+perf_callchain(struct pt_regs *regs)
+{
+	struct perf_callchain_entry *entry = &__get_cpu_var(pmc_irq_entry);
+
+	entry->nr = 0;
+	perf_do_callchain(regs, entry);
+	return entry;
+}
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index fc5c05b..89a26ea 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -791,3 +791,11 @@ config ARM_L1_CACHE_SHIFT
 	int
 	default 6 if ARCH_OMAP3 || ARCH_S5PC1XX
 	default 5
+
+config HW_PERF_EVENTS
+	bool "Enable hardware performance counter support for perf events"
+	depends on PERF_EVENTS && CPU_HAS_PMU && CPU_V6
+	default n
+	help
+	  Enable hardware performance counter support for perf events. If
+	  disabled, perf events will use software events only.
-- 
1.6.5.4
