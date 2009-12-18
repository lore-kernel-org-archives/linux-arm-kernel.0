From: jpihet@mvista.com (Jean Pihet)
Date: Fri, 18 Dec 2009 18:05:29 +0100
Subject: Perf Event support for ARMv7 (was: Re: [PATCH 5/5] arm/perfevents:
	implement perf event support for ARMv6)
In-Reply-To: <1260875712-29712-6-git-send-email-jamie.iles@picochip.com>
References: <1260875712-29712-1-git-send-email-jamie.iles@picochip.com>
	<1260875712-29712-2-git-send-email-jamie.iles@picochip.com>
	<1260875712-29712-3-git-send-email-jamie.iles@picochip.com>
	<1260875712-29712-4-git-send-email-jamie.iles@picochip.com>
	<1260875712-29712-5-git-send-email-jamie.iles@picochip.com>
	<1260875712-29712-6-git-send-email-jamie.iles@picochip.com>
Message-ID: <1261155929.6094.11.camel@def-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Here is a patch that adds the support for ARMv7 processors, using the
PMNC HW unit.

The code is for review, it has been compiled and boot tested only, the
complete testing is in progress. Please let me know if the patch is
wrapped or garbled I will send it attached (20KB in size).

Feedback is welcome.

I had a question about the events mapping to user space. Although most
of the events are mapped in the kernel code, some of the exotic events
are not mapped (e.g. NEON or PMU related events). How to use those
events from user space? Is it done using the raw mappings?

Regards,
Jean

---
>From d48f736b380b0a05ab74743dcce4e662d71371d9 Mon Sep 17 00:00:00 2001
From: Jean Pihet <jpihet@mvista.com>
Date: Fri, 18 Dec 2009 17:46:21 +0100
Subject: [PATCH] arm/perfevents: add support for ARMv7

Adds the Performance Events support for ARMv7 processor, using
the PMNC unit in HW.

Signed-off-by: Jean Pihet <jpihet@mvista.com>
---
 arch/arm/Kconfig             |    2 +-
 arch/arm/kernel/perf_event.c |  708
+++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 708 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2ac6e8d..9dfc0ee 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1171,7 +1171,7 @@ config HIGHPTE
 
 config HW_PERF_EVENTS
 	bool "Enable hardware performance counter support for perf events"
-	depends on PERF_EVENTS && CPU_HAS_PMU && CPU_V6
+	depends on PERF_EVENTS && CPU_HAS_PMU && (CPU_V6 || CPU_V7)
 	default y
 	help
 	  Enable hardware performance counter support for perf events. If
diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index abb5267..79e92ce 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -4,6 +4,7 @@
  * ARM performance counter support.
  *
  * Copyright (C) 2009 picoChip Designs, Ltd., Jamie Iles
+ * ARMv7 support: Jean Pihet <jpihet@mvista.com>
  *
  * This code is based on the sparc64 perf event code, which is in turn
based
  * on the x86 code. Callchain code is based on the ARM OProfile
backtrace
@@ -35,8 +36,11 @@ DEFINE_SPINLOCK(pmu_lock);
  * ARMv6 supports a maximum of 3 events, starting from index 1. If we
add
  * another platform that supports more, we need to increase this to be
the
  * largest of all platforms.
+ *
+ * ARMv7 supports up to 5 events:
+ *  cycle counter CCNT + 4 events counters CNT0..3
  */
-#define ARMPMU_MAX_HWEVENTS		4
+#define ARMPMU_MAX_HWEVENTS		5
 
 /* The events for a given CPU. */
 struct cpu_hw_events {
@@ -965,6 +969,701 @@ static struct arm_pmu armv6pmu = {
 	.max_period		= (1LLU << 32) - 1,
 };
 
+/*
+ * ARMv7 Performance counter handling code.
+ *
+ * Copied from ARMv6 code, with the low level code inspired
+ *  by the ARMv7 Oprofile code.
+ *
+ * ARMv7 has 4 configurable performance counters and a single cycle
counter.
+ * All counters can be enabled/disabled and IRQ masked separately. The
cycle
+ *  counter and all 4 performance counters together can be reset
separately.
+ */
+
+enum armv7_perf_types {
+	ARMV7_PERFCTR_PMNC_SW_INCR		= 0x00,
+	ARMV7_PERFCTR_IFETCH_MISS		= 0x01,
+	ARMV7_PERFCTR_ITLB_MISS			= 0x02,
+	ARMV7_PERFCTR_DCACHE_REFILL		= 0x03,
+	ARMV7_PERFCTR_DCACHE_ACCESS		= 0x04,
+	ARMV7_PERFCTR_DTLB_REFILL		= 0x05,
+	ARMV7_PERFCTR_DREAD			= 0x06,
+	ARMV7_PERFCTR_DWRITE			= 0x07,
+	ARMV7_PERFCTR_INSTR_EXECUTED		= 0x08,
+	ARMV7_PERFCTR_EXC_TAKEN			= 0x09,
+	ARMV7_PERFCTR_EXC_EXECUTED		= 0x0A,
+	ARMV7_PERFCTR_CID_WRITE			= 0x0B,
+	ARMV7_PERFCTR_PC_WRITE			= 0x0C,
+	ARMV7_PERFCTR_PC_IMM_BRANCH		= 0x0D,
+	ARMV7_PERFCTR_PC_PROC_RETURN		= 0x0E,
+	ARMV7_PERFCTR_UNALIGNED_ACCESS		= 0x0F,
+	ARMV7_PERFCTR_PC_BRANCH_MIS_PRED	= 0x10,
+
+	ARMV7_PERFCTR_PC_BRANCH_MIS_USED	= 0x12,
+
+	ARMV7_PERFCTR_WRITE_BUFFER_FULL		= 0x40,
+	ARMV7_PERFCTR_L2_STORE_MERGED		= 0x41,
+	ARMV7_PERFCTR_L2_STORE_BUFF		= 0x42,
+	ARMV7_PERFCTR_L2_ACCESS			= 0x43,
+	ARMV7_PERFCTR_L2_CACH_MISS		= 0x44,
+	ARMV7_PERFCTR_AXI_READ_CYCLES		= 0x45,
+	ARMV7_PERFCTR_AXI_WRITE_CYCLES		= 0x46,
+	ARMV7_PERFCTR_MEMORY_REPLAY		= 0x47,
+	ARMV7_PERFCTR_UNALIGNED_ACCESS_REPLAY	= 0x48,
+	ARMV7_PERFCTR_L1_DATA_MISS		= 0x49,
+	ARMV7_PERFCTR_L1_INST_MISS		= 0x4A,
+	ARMV7_PERFCTR_L1_DATA_COLORING		= 0x4B,
+	ARMV7_PERFCTR_L1_NEON_DATA		= 0x4C,
+	ARMV7_PERFCTR_L1_NEON_CACH_DATA		= 0x4D,
+	ARMV7_PERFCTR_L2_NEON			= 0x4E,
+	ARMV7_PERFCTR_L2_NEON_HIT		= 0x4F,
+	ARMV7_PERFCTR_L1_INST			= 0x50,
+	ARMV7_PERFCTR_PC_RETURN_MIS_PRED	= 0x51,
+	ARMV7_PERFCTR_PC_BRANCH_FAILED		= 0x52,
+	ARMV7_PERFCTR_PC_BRANCH_TAKEN		= 0x53,
+	ARMV7_PERFCTR_PC_BRANCH_EXECUTED	= 0x54,
+	ARMV7_PERFCTR_OP_EXECUTED		= 0x55,
+	ARMV7_PERFCTR_CYCLES_INST_STALL		= 0x56,
+	ARMV7_PERFCTR_CYCLES_INST		= 0x57,
+	ARMV7_PERFCTR_CYCLES_NEON_DATA_STALL	= 0x58,
+	ARMV7_PERFCTR_CYCLES_NEON_INST_STALL	= 0x59,
+	ARMV7_PERFCTR_NEON_CYCLES		= 0x5A,
+
+	ARMV7_PERFCTR_PMU0_EVENTS		= 0x70,
+	ARMV7_PERFCTR_PMU1_EVENTS		= 0x71,
+	ARMV7_PERFCTR_PMU_EVENTS		= 0x72,
+
+	ARMV7_PERFCTR_CPU_CYCLES		= 0xFF
+};
+
+enum armv7_counters {
+	ARMV7_CYCLE_COUNTER = 1,
+	ARMV7_COUNTER0,
+	ARMV7_COUNTER1,
+	ARMV7_COUNTER2,
+	ARMV7_COUNTER3,
+};
+
+/*
+ * The hardware events that we support. We do support cache operations
but
+ * we have harvard caches and no way to combine instruction and data
+ * accesses/misses in hardware.
+ */
+static const unsigned armv7_perf_map[PERF_COUNT_HW_MAX] = {
+	[PERF_COUNT_HW_CPU_CYCLES]	    = ARMV7_PERFCTR_CPU_CYCLES,
+	[PERF_COUNT_HW_INSTRUCTIONS]	    = ARMV7_PERFCTR_INSTR_EXECUTED,
+	[PERF_COUNT_HW_CACHE_REFERENCES]    = HW_OP_UNSUPPORTED,
+	[PERF_COUNT_HW_CACHE_MISSES]	    = HW_OP_UNSUPPORTED,
+	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] = ARMV7_PERFCTR_PC_BRANCH_TAKEN,
+	[PERF_COUNT_HW_BRANCH_MISSES]	    = ARMV7_PERFCTR_PC_BRANCH_FAILED,
+	[PERF_COUNT_HW_BUS_CYCLES]	    = HW_OP_UNSUPPORTED,
+};
+
+static const unsigned armv7_perf_cache_map[PERF_COUNT_HW_CACHE_MAX]
+					  [PERF_COUNT_HW_CACHE_OP_MAX]
+					  [PERF_COUNT_HW_CACHE_RESULT_MAX] = {
+	[C(L1D)] = {
+		/*
+		 * The performance counters don't differentiate between read
+		 * and write accesses/misses so this isn't strictly correct,
+		 * but it's the best we can do. Writes and reads get
+		 * combined.
+		 */
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)]	= ARMV7_PERFCTR_DCACHE_ACCESS,
+			[C(RESULT_MISS)]	= ARMV7_PERFCTR_L1_DATA_MISS,
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)]	= ARMV7_PERFCTR_DCACHE_ACCESS,
+			[C(RESULT_MISS)]	= ARMV7_PERFCTR_L1_DATA_MISS,
+		},
+		[C(OP_PREFETCH)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+	},
+	[C(L1I)] = {
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)]	= ARMV7_PERFCTR_L1_INST,
+			[C(RESULT_MISS)]	= ARMV7_PERFCTR_L1_INST_MISS,
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)]	= ARMV7_PERFCTR_L1_INST,
+			[C(RESULT_MISS)]	= ARMV7_PERFCTR_L1_INST_MISS,
+		},
+		[C(OP_PREFETCH)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+	},
+	[C(LL)] = {
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)]	= ARMV7_PERFCTR_L2_ACCESS,
+			[C(RESULT_MISS)]	= ARMV7_PERFCTR_L2_CACH_MISS,
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)]	= ARMV7_PERFCTR_L2_ACCESS,
+			[C(RESULT_MISS)]	= ARMV7_PERFCTR_L2_CACH_MISS,
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
+	[C(ITLB)] = {
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= ARMV7_PERFCTR_ITLB_MISS,
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= ARMV7_PERFCTR_ITLB_MISS,
+		},
+		[C(OP_PREFETCH)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+	},
+	[C(BPU)] = {
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)]	= ARMV7_PERFCTR_PC_BRANCH_TAKEN,
+			[C(RESULT_MISS)]
+					= ARMV7_PERFCTR_PC_BRANCH_FAILED,
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)]	= ARMV7_PERFCTR_PC_BRANCH_TAKEN,
+			[C(RESULT_MISS)]
+					= ARMV7_PERFCTR_PC_BRANCH_FAILED,
+		},
+		[C(OP_PREFETCH)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+	},
+};
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
+#define	ARMV7_PMNC_MASK		0x3f	 /* Mask for writable bits */
+
+/*
+ * Available counters
+ */
+#define ARMV7_CCNT 		0
+#define ARMV7_CNT0 		1
+#define ARMV7_CNT1 		2
+#define ARMV7_CNT2 		3
+#define ARMV7_CNT3 		4
+#define ARMV7_CNTMAX 		5
+#define ARMV7_COUNTER_TO_CCNT	(ARMV7_CYCLE_COUNTER - ARMV7_CCNT)
+
+#define ARMV7_CPU_COUNTER(cpu, counter)	((cpu) * CNTMAX + (counter))
+
+/*
+ * CNTENS: counters enable reg
+ */
+#define ARMV7_CNTENS_P0		(1 << 0)
+#define ARMV7_CNTENS_P1		(1 << 1)
+#define ARMV7_CNTENS_P2		(1 << 2)
+#define ARMV7_CNTENS_P3		(1 << 3)
+#define ARMV7_CNTENS_C		(1 << 31)
+#define	ARMV7_CNTENS_MASK	0x8000000f	/* Mask for writable bits */
+
+/*
+ * CNTENC: counters disable reg
+ */
+#define ARMV7_CNTENC_P0		(1 << 0)
+#define ARMV7_CNTENC_P1		(1 << 1)
+#define ARMV7_CNTENC_P2		(1 << 2)
+#define ARMV7_CNTENC_P3		(1 << 3)
+#define ARMV7_CNTENC_C		(1 << 31)
+#define	ARMV7_CNTENC_MASK	0x8000000f	/* Mask for writable bits */
+
+/*
+ * INTENS: counters overflow interrupt enable reg
+ */
+#define ARMV7_INTENS_P0		(1 << 0)
+#define ARMV7_INTENS_P1		(1 << 1)
+#define ARMV7_INTENS_P2		(1 << 2)
+#define ARMV7_INTENS_P3		(1 << 3)
+#define ARMV7_INTENS_C		(1 << 31)
+#define	ARMV7_INTENS_MASK	0x8000000f	/* Mask for writable bits */
+
+/*
+ * INTENC: counters overflow interrupt disable reg
+ */
+#define ARMV7_INTENC_P0		(1 << 0)
+#define ARMV7_INTENC_P1		(1 << 1)
+#define ARMV7_INTENC_P2		(1 << 2)
+#define ARMV7_INTENC_P3		(1 << 3)
+#define ARMV7_INTENC_C		(1 << 31)
+#define	ARMV7_INTENC_MASK	0x8000000f	/* Mask for writable bits */
+
+/*
+ * EVTSEL: Event selection reg
+ */
+#define	ARMV7_EVTSEL_MASK	0x7f		/* Mask for writable bits */
+
+/*
+ * SELECT: Counter selection reg
+ */
+#define	ARMV7_SELECT_MASK	0x1f		/* Mask for writable bits */
+
+/*
+ * FLAG: counters overflow flag status reg
+ */
+#define ARMV7_FLAG_P0		(1 << 0)
+#define ARMV7_FLAG_P1		(1 << 1)
+#define ARMV7_FLAG_P2		(1 << 2)
+#define ARMV7_FLAG_P3		(1 << 3)
+#define ARMV7_FLAG_C		(1 << 31)
+#define	ARMV7_FLAG_MASK		0x8000000f	/* Mask for writable bits */
+#define	ARMV7_OVERFLOWED_MASK	ARMV7_FLAG_MASK
+
+static inline unsigned long armv7_pmnc_read(void)
+{
+	u32 val;
+	asm volatile("mrc p15, 0, %0, c9, c12, 0" : "=r"(val));
+	return val;
+}
+
+static inline void armv7_pmnc_write(unsigned long val)
+{
+	val &= ARMV7_PMNC_MASK;
+	asm volatile("mcr p15, 0, %0, c9, c12, 0" : : "r"(val));
+}
+
+static inline int armv7_pmnc_has_overflowed(unsigned long pmnc)
+{
+	return pmnc & ARMV7_OVERFLOWED_MASK;
+}
+
+static inline int armv7_pmnc_counter_has_overflowed(unsigned long pmnc,
+					enum armv7_counters counter)
+{
+	int ret;
+
+	if (ARMV7_CYCLE_COUNTER == counter)
+		ret = pmnc & ARMV7_FLAG_C;
+	else if (ARMV7_COUNTER0 == counter)
+		ret = pmnc & ARMV7_FLAG_P0;
+	else if (ARMV7_COUNTER1 == counter)
+		ret = pmnc & ARMV7_FLAG_P1;
+	else if (ARMV7_COUNTER2 == counter)
+		ret = pmnc & ARMV7_FLAG_P2;
+	else if (ARMV7_COUNTER3 == counter)
+		ret = pmnc & ARMV7_FLAG_P3;
+	else
+		BUG();
+
+	return ret;
+}
+
+static inline int armv7_pmnc_select_counter(unsigned int cnt)
+{
+	u32 val;
+
+	cnt -= ARMV7_COUNTER_TO_CCNT;
+
+	if ((cnt == ARMV7_CCNT) || (cnt >= ARMV7_CNTMAX)) {
+		printk(KERN_ERR "oprofile: CPU%u selecting wrong PMNC counter"
+			" %d\n", smp_processor_id(), cnt);
+		return -1;
+	}
+
+	val = (cnt - ARMV7_CNT0) & ARMV7_SELECT_MASK;
+	asm volatile("mcr p15, 0, %0, c9, c12, 5" : : "r" (val));
+
+	return cnt;
+}
+
+static inline u32 armv7pmu_read_counter(int counter)
+{
+	unsigned long value = 0;
+
+	switch (counter) {
+	case ARMV7_CYCLE_COUNTER:
+		asm volatile("mrc p15, 0, %0, c9, c13, 0" : "=r" (value));
+		break;
+	case ARMV7_COUNTER0:
+	case ARMV7_COUNTER1:
+	case ARMV7_COUNTER2:
+	case ARMV7_COUNTER3:
+		if (armv7_pmnc_select_counter(counter) == counter)
+			asm volatile("mrc p15, 0, %0, c9, c13, 2"
+				     : "=r" (value));
+		break;
+	default:
+		BUG();
+	}
+
+	return value;
+}
+
+static inline void armv7pmu_write_counter(int counter, u32 value)
+{
+	switch (counter) {
+	case ARMV7_CYCLE_COUNTER:
+		asm volatile("mcr p15, 0, %0, c9, c13, 0" : : "r" (value));
+		break;
+	case ARMV7_COUNTER0:
+	case ARMV7_COUNTER1:
+	case ARMV7_COUNTER2:
+	case ARMV7_COUNTER3:
+		if (armv7_pmnc_select_counter(counter) == counter)
+			asm volatile("mcr p15, 0, %0, c9, c13, 2"
+				     : : "r" (value));
+		break;
+	default:
+		BUG();
+	}
+}
+
+static inline void armv7_pmnc_write_evtsel(unsigned int cnt, u32 val)
+{
+	if (armv7_pmnc_select_counter(cnt) == cnt) {
+		val &= ARMV7_EVTSEL_MASK;
+		asm volatile("mcr p15, 0, %0, c9, c13, 1" : : "r" (val));
+	}
+}
+
+static inline u32 armv7_pmnc_enable_counter(unsigned int cnt)
+{
+	u32 val;
+
+	cnt -= ARMV7_COUNTER_TO_CCNT;
+
+	if (cnt >= ARMV7_CNTMAX) {
+		printk(KERN_ERR "oprofile: CPU%u enabling wrong PMNC counter"
+			" %d\n", smp_processor_id(), cnt);
+		return -1;
+	}
+
+	if (cnt == ARMV7_CCNT)
+		val = ARMV7_CNTENS_C;
+	else
+		val = (1 << (cnt - ARMV7_CNT0));
+
+	val &= ARMV7_CNTENS_MASK;
+	asm volatile("mcr p15, 0, %0, c9, c12, 1" : : "r" (val));
+
+	return cnt;
+}
+
+static inline u32 armv7_pmnc_disable_counter(unsigned int cnt)
+{
+	u32 val;
+
+	cnt -= ARMV7_COUNTER_TO_CCNT;
+
+	if (cnt >= ARMV7_CNTMAX) {
+		printk(KERN_ERR "oprofile: CPU%u disabling wrong PMNC counter"
+			" %d\n", smp_processor_id(), cnt);
+		return -1;
+	}
+
+	if (cnt == ARMV7_CCNT)
+		val = ARMV7_CNTENC_C;
+	else
+		val = (1 << (cnt - ARMV7_CNT0));
+
+	val &= ARMV7_CNTENC_MASK;
+	asm volatile("mcr p15, 0, %0, c9, c12, 2" : : "r" (val));
+
+	return cnt;
+}
+
+static inline u32 armv7_pmnc_enable_intens(unsigned int cnt)
+{
+	u32 val;
+
+	cnt -= ARMV7_COUNTER_TO_CCNT;
+
+	if (cnt >= ARMV7_CNTMAX) {
+		printk(KERN_ERR "oprofile: CPU%u enabling wrong PMNC counter"
+			" interrupt enable %d\n", smp_processor_id(), cnt);
+		return -1;
+	}
+
+	if (cnt == ARMV7_CCNT)
+		val = ARMV7_INTENS_C;
+	else
+		val = (1 << (cnt - ARMV7_CNT0));
+
+	val &= ARMV7_INTENS_MASK;
+	asm volatile("mcr p15, 0, %0, c9, c14, 1" : : "r" (val));
+
+	return cnt;
+}
+
+static inline u32 armv7_pmnc_disable_intens(unsigned int cnt)
+{
+	u32 val;
+
+	cnt -= ARMV7_COUNTER_TO_CCNT;
+
+	if (cnt >= ARMV7_CNTMAX) {
+		printk(KERN_ERR "oprofile: CPU%u disabling wrong PMNC counter"
+			" interrupt enable %d\n", smp_processor_id(), cnt);
+		return -1;
+	}
+
+	if (cnt == ARMV7_CCNT)
+		val = ARMV7_INTENC_C;
+	else
+		val = (1 << (cnt - ARMV7_CNT0));
+
+	val &= ARMV7_INTENC_MASK;
+	asm volatile("mcr p15, 0, %0, c9, c14, 2" : : "r" (val));
+
+	return cnt;
+}
+
+static inline u32 armv7_pmnc_getreset_flags(void)
+{
+	u32 val;
+
+	/* Read */
+	asm volatile("mrc p15, 0, %0, c9, c12, 3" : "=r" (val));
+
+	/* Write to clear flags */
+	val &= ARMV7_FLAG_MASK;
+	asm volatile("mcr p15, 0, %0, c9, c12, 3" : : "r" (val));
+
+	return val;
+}
+
+void armv7pmu_enable_event(struct hw_perf_event *hwc, int idx)
+{
+	unsigned long flags;
+
+	/*
+	 * Enable counter and interrupt, and set the counter to count
+	 * the event that we're interested in.
+	 */
+	spin_lock_irqsave(&pmu_lock, flags);
+
+	/*
+	 * Disable counter
+	 */
+	armv7_pmnc_disable_counter(idx);
+
+	/*
+	 * Set event (if destined for PMNx counters)
+	 * We don't need to set the event if it's a cycle count
+	 */
+	if (idx != ARMV7_CYCLE_COUNTER)
+		armv7_pmnc_write_evtsel(idx, hwc->config_base);
+
+	/*
+	 * Enable interrupt for this counter
+	 */
+	armv7_pmnc_enable_intens(idx);
+
+	/*
+	 * Enable counter
+	 */
+	armv7_pmnc_enable_counter(idx);
+
+	spin_unlock_irqrestore(&pmu_lock, flags);
+}
+
+static void armv7pmu_disable_event(struct hw_perf_event *hwc, int idx)
+{
+	unsigned long flags;
+
+	/*
+	 * Disable counter and interrupt
+	 */
+	spin_lock_irqsave(&pmu_lock, flags);
+
+	/*
+	 * Disable counter
+	 */
+	armv7_pmnc_disable_counter(idx);
+
+	/*
+	 * Disable interrupt for this counter
+	 */
+	armv7_pmnc_disable_intens(idx);
+
+	spin_unlock_irqrestore(&pmu_lock, flags);
+}
+
+static irqreturn_t armv7pmu_handle_irq(int irq_num, void *dev)
+{
+	unsigned long pmnc;
+	struct perf_sample_data data;
+	struct cpu_hw_events *cpuc;
+	struct pt_regs *regs;
+	int idx;
+
+	/*
+	 * Get and reset the IRQ flags
+	 */
+	pmnc = armv7_pmnc_getreset_flags();
+
+	/*
+	 * Did an overflow occur?
+	 */
+	if (!armv7_pmnc_has_overflowed(pmnc))
+		return IRQ_NONE;
+
+	/*
+	 * Handle the counter(s) overflow(s)
+	 */
+	regs = get_irq_regs();
+
+	data.addr = 0;
+
+	cpuc = &__get_cpu_var(cpu_hw_events);
+	for (idx = 0; idx <= armpmu->num_events; ++idx) {
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
+		if (!armv7_pmnc_counter_has_overflowed(pmnc, idx))
+			continue;
+
+		hwc = &event->hw;
+		armpmu_event_update(event, hwc, idx);
+		data.period = event->hw.last_period;
+		if (!armpmu_event_set_period(event, hwc, idx))
+			continue;
+
+		if (perf_event_overflow(event, 0, &data, regs))
+			armpmu->disable(hwc, idx);
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
+static void armv7pmu_start(void)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&pmu_lock, flags);
+	/* Enable all counters */
+	armv7_pmnc_write(armv7_pmnc_read() | ARMV7_PMNC_E);
+	spin_unlock_irqrestore(&pmu_lock, flags);
+}
+
+static void armv7pmu_stop(void)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&pmu_lock, flags);
+	/* Disable all counters */
+	armv7_pmnc_write(armv7_pmnc_read() & ~ARMV7_PMNC_E);
+	spin_unlock_irqrestore(&pmu_lock, flags);
+}
+
+static inline int armv7pmu_event_map(int config)
+{
+	int mapping = armv7_perf_map[config];
+	if (HW_OP_UNSUPPORTED == mapping)
+		mapping = -EOPNOTSUPP;
+	return mapping;
+}
+
+static u64 armv7pmu_raw_event(u64 config)
+{
+	return config & 0xff;
+}
+
+static int armv7pmu_get_event_idx(struct cpu_hw_events *cpuc,
+				  struct hw_perf_event *event)
+{
+	/* Always place a cycle counter into the cycle counter. */
+	if (ARMV7_PERFCTR_CPU_CYCLES == event->config_base) {
+		if (test_and_set_bit(ARMV7_CYCLE_COUNTER, cpuc->used_mask))
+			return -EAGAIN;
+
+		return ARMV7_CYCLE_COUNTER;
+	} else {
+		/*
+		 * For anything other than a cycle counter, try and use
+		 * counters 0..3
+		 */
+		if (!test_and_set_bit(ARMV7_COUNTER0, cpuc->used_mask))
+			return ARMV7_COUNTER0;
+
+		if (!test_and_set_bit(ARMV7_COUNTER1, cpuc->used_mask))
+			return ARMV7_COUNTER1;
+
+		if (!test_and_set_bit(ARMV7_COUNTER2, cpuc->used_mask))
+			return ARMV7_COUNTER2;
+
+		if (!test_and_set_bit(ARMV7_COUNTER3, cpuc->used_mask))
+			return ARMV7_COUNTER3;
+
+		/* The counters are all in use. */
+		return -EAGAIN;
+	}
+}
+
+static struct arm_pmu armv7pmu = {
+	.name			= "v7",
+	.handle_irq		= armv7pmu_handle_irq,
+	.enable			= armv7pmu_enable_event,
+	.disable		= armv7pmu_disable_event,
+	.event_map		= armv7pmu_event_map,
+	.raw_event		= armv7pmu_raw_event,
+	.read_counter		= armv7pmu_read_counter,
+	.write_counter		= armv7pmu_write_counter,
+	.get_event_idx		= armv7pmu_get_event_idx,
+	.start			= armv7pmu_start,
+	.stop			= armv7pmu_stop,
+	.num_events		= 5,
+	.max_period		= (1LLU << 32) - 1,
+};
+
 static int __init
 init_hw_perf_events(void)
 {
@@ -977,6 +1676,13 @@ init_hw_perf_events(void)
                 memcpy(armpmu_perf_cache_map, armv6_perf_cache_map,
                        sizeof(armv6_perf_cache_map));
                 perf_max_events	= armv6pmu.num_events;
+	} else if (cpu_architecture() == CPU_ARCH_ARMv7) {
+		armpmu = &armv7pmu;
+		memcpy(armpmu_perf_cache_map, armv7_perf_cache_map,
+			sizeof(armv7_perf_cache_map));
+		perf_max_events	= armv7pmu.num_events;
+		/* Initialize & Reset PMNC: C bit and P bit */
+		armv7_pmnc_write(ARMV7_PMNC_P | ARMV7_PMNC_C);
         } else {
                 pr_info("no hardware support available\n");
                 perf_max_events = -1;
-- 
1.6.0


---
On Tue, 2009-12-15@11:15 +0000, Jamie Iles wrote:
> This patch implements support for ARMv6 performance counters in the
> Linux performance events subsystem. ARMv6 architectures that have the
> performance counters should enable HW_PERF_EVENTS and define the
> interrupts for the counters in arch/arm/kernel/perf_event.c
> 
> This implementation also provides an ARM PMU abstraction layer to allow
> ARMv7 and others to be supported in the future by adding new a
> 'struct arm_pmu'.
> 
> Signed-off-by: Jamie Iles <jamie.iles@picochip.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@elte.hu>
> ---
>  arch/arm/Kconfig             |    8 +
>  arch/arm/kernel/Makefile     |    1 +
>  arch/arm/kernel/perf_event.c | 1125 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1134 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/kernel/perf_event.c
> 
...
