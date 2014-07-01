From: mark.rutland@arm.com (Mark Rutland)
Date: Tue,  1 Jul 2014 16:11:12 +0100
Subject: [PATCH 2/8] arm: perf: add macros for empty event mappings
In-Reply-To: <1404227478-9645-1-git-send-email-mark.rutland@arm.com>
References: <1404227478-9645-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1404227478-9645-3-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We currently map from userspace-ABI standard event numbers to
hardware-specific IDs by use of two arrays, *_perf_map and
*_perf_cache_map. While we use designated initializers to initialize the
events we care about, zero is typically a valid hardware event number,
and thus we have to explicitly initialize unsupported event mappings to a
nonzero value ({HW,CACHE}_OP_UNSUPPORTED).

In the case of the *_cache_map, this requires initialising almost every
entry in a 3-dimensional array to CACHE_OP_UNSUPPORTED, requiring over a
hundred lines to add eleven supported events in the case of Cortex A9.

So as to take up less space and make the tables easier to deal with,
this patch adds two new macros to initialize every entry in these tables
to the *_UNSUPPORTED values. Supported events can be overridden
individually through the use of designated initializers.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/pmu.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/include/asm/pmu.h b/arch/arm/include/asm/pmu.h
index 748d20d..0b648c5 100644
--- a/arch/arm/include/asm/pmu.h
+++ b/arch/arm/include/asm/pmu.h
@@ -51,6 +51,16 @@ struct arm_pmu_platdata {
 #define C(_x)				PERF_COUNT_HW_CACHE_##_x
 #define CACHE_OP_UNSUPPORTED		0xFFFF
 
+#define PERF_MAP_ALL_UNSUPPORTED					\
+	[0 ... PERF_COUNT_HW_MAX - 1] = HW_OP_UNSUPPORTED
+
+#define PERF_CACHE_MAP_ALL_UNSUPPORTED					\
+[0 ... C(MAX) - 1] = {							\
+	[0 ... C(OP_MAX) - 1] = {					\
+		[0 ... C(RESULT_MAX) - 1] = CACHE_OP_UNSUPPORTED,	\
+	},								\
+}
+
 /* The events for a given PMU register set. */
 struct pmu_hw_events {
 	/*
-- 
1.9.1
