From: will.deacon@arm.com (Will Deacon)
Date: Mon,  6 Jun 2011 17:55:53 +0100
Subject: [PATCH 09/11] ARM: perf: add PMUv2 common event definitions
In-Reply-To: <1307379355-13802-1-git-send-email-will.deacon@arm.com>
References: <1307379355-13802-1-git-send-email-will.deacon@arm.com>
Message-ID: <1307379355-13802-10-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PMUv2 specification reserves a number of event encodings
for common events.

This patch adds these events to the common event enumeration
in preparation for PMUv2 cores, such as Cortex-A15.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/perf_event_v7.c |   35 +++++++++++++++++++++++++----------
 1 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index 554eba3..01b1145 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -17,17 +17,23 @@
  */
 
 #ifdef CONFIG_CPU_V7
-/* Common ARMv7 event types */
+/*
+ * Common ARMv7 event types
+ *
+ * Note: An implementation may not be able to count all of these events
+ * but the encodings are considered to be `reserved' in the case that
+ * they are not available.
+ */
 enum armv7_perf_types {
 	ARMV7_PERFCTR_PMNC_SW_INCR		= 0x00,
 	ARMV7_PERFCTR_IFETCH_MISS		= 0x01,
 	ARMV7_PERFCTR_ITLB_MISS			= 0x02,
-	ARMV7_PERFCTR_DCACHE_REFILL		= 0x03,
-	ARMV7_PERFCTR_DCACHE_ACCESS		= 0x04,
+	ARMV7_PERFCTR_DCACHE_REFILL		= 0x03,	/* L1 */
+	ARMV7_PERFCTR_DCACHE_ACCESS		= 0x04,	/* L1 */
 	ARMV7_PERFCTR_DTLB_REFILL		= 0x05,
 	ARMV7_PERFCTR_DREAD			= 0x06,
 	ARMV7_PERFCTR_DWRITE			= 0x07,
-
+	ARMV7_PERFCTR_INSTR_EXECUTED		= 0x08,
 	ARMV7_PERFCTR_EXC_TAKEN			= 0x09,
 	ARMV7_PERFCTR_EXC_EXECUTED		= 0x0A,
 	ARMV7_PERFCTR_CID_WRITE			= 0x0B,
@@ -39,21 +45,30 @@ enum armv7_perf_types {
 	 */
 	ARMV7_PERFCTR_PC_WRITE			= 0x0C,
 	ARMV7_PERFCTR_PC_IMM_BRANCH		= 0x0D,
+	ARMV7_PERFCTR_PC_PROC_RETURN		= 0x0E,
 	ARMV7_PERFCTR_UNALIGNED_ACCESS		= 0x0F,
+
+	/* These events are defined by the PMUv2 supplement (ARM DDI 0457A). */
 	ARMV7_PERFCTR_PC_BRANCH_MIS_PRED	= 0x10,
 	ARMV7_PERFCTR_CLOCK_CYCLES		= 0x11,
-
-	ARMV7_PERFCTR_PC_BRANCH_MIS_USED	= 0x12,
+	ARMV7_PERFCTR_PC_BRANCH_PRED		= 0x12,
+	ARMV7_PERFCTR_MEM_ACCESS		= 0x13,
+	ARMV7_PERFCTR_L1_ICACHE_ACCESS		= 0x14,
+	ARMV7_PERFCTR_L1_DCACHE_WB		= 0x15,
+	ARMV7_PERFCTR_L2_DCACHE_ACCESS		= 0x16,
+	ARMV7_PERFCTR_L2_DCACHE_REFILL		= 0x17,
+	ARMV7_PERFCTR_L2_DCACHE_WB		= 0x18,
+	ARMV7_PERFCTR_BUS_ACCESS		= 0x19,
+	ARMV7_PERFCTR_MEMORY_ERROR		= 0x1A,
+	ARMV7_PERFCTR_INSTR_SPEC		= 0x1B,
+	ARMV7_PERFCTR_TTBR_WRITE		= 0x1C,
+	ARMV7_PERFCTR_BUS_CYCLES		= 0x1D,
 
 	ARMV7_PERFCTR_CPU_CYCLES		= 0xFF
 };
 
 /* ARMv7 Cortex-A8 specific event types */
 enum armv7_a8_perf_types {
-	ARMV7_PERFCTR_INSTR_EXECUTED		= 0x08,
-
-	ARMV7_PERFCTR_PC_PROC_RETURN		= 0x0E,
-
 	ARMV7_PERFCTR_WRITE_BUFFER_FULL		= 0x40,
 	ARMV7_PERFCTR_L2_STORE_MERGED		= 0x41,
 	ARMV7_PERFCTR_L2_STORE_BUFF		= 0x42,
-- 
1.7.0.4
