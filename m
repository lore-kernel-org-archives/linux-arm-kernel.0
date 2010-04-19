From: will.deacon@arm.com (Will Deacon)
Date: Mon, 19 Apr 2010 17:42:38 +0100
Subject: [PATCH 3/6] ARM: perf-events: allow modules to query the number of
	hardware counters
In-Reply-To: <1271695361-7121-3-git-send-email-will.deacon@arm.com>
References: <1271695361-7121-1-git-send-email-will.deacon@arm.com>
	<1271695361-7121-2-git-send-email-will.deacon@arm.com>
	<1271695361-7121-3-git-send-email-will.deacon@arm.com>
Message-ID: <1271695361-7121-4-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For OProfile to initialise oprofilefs correctly, it needs to know
the number of counters it can represent.

This patch adds a function to the ARM perf-events backend to return
the number of hardware counters available for the current PMU.

Cc: Jamie Iles <jamie.iles@picochip.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/perf_event.h |    3 +++
 arch/arm/kernel/perf_event.c      |   12 ++++++++++++
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/perf_event.h b/arch/arm/include/asm/perf_event.h
index fa4b326..48837e6 100644
--- a/arch/arm/include/asm/perf_event.h
+++ b/arch/arm/include/asm/perf_event.h
@@ -42,4 +42,7 @@ enum arm_perf_pmu_ids {
 extern enum arm_perf_pmu_ids
 armpmu_get_pmu_id(void);
 
+extern int
+armpmu_get_max_events(void);
+
 #endif /* __ARM_PERF_EVENT_H__ */
diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index 381f121..c457686 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -111,6 +111,18 @@ armpmu_get_pmu_id(void)
 }
 EXPORT_SYMBOL_GPL(armpmu_get_pmu_id);
 
+int
+armpmu_get_max_events(void)
+{
+	int max_events = 0;
+
+	if (armpmu != NULL)
+		max_events = armpmu->num_events;
+
+	return max_events;
+}
+EXPORT_SYMBOL_GPL(armpmu_get_max_events);
+
 #define HW_OP_UNSUPPORTED		0xFFFF
 
 #define C(_x) \
-- 
1.6.3.3
