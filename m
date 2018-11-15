From: andrew.murray@arm.com (Andrew Murray)
Date: Thu, 15 Nov 2018 12:55:47 +0000
Subject: [PATCH 2/4] arm64: arm_pmu: Add support for
 exclude_host/exclude_guest attributes
In-Reply-To: <1542286549-4501-1-git-send-email-andrew.murray@arm.com>
References: <1542286549-4501-1-git-send-email-andrew.murray@arm.com>
Message-ID: <1542286549-4501-3-git-send-email-andrew.murray@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the :G and :H attributes in perf by handling the
exclude_host/exclude_guest event attributes.

We notify KVM of counters that we wish to be enabled or disabled on
guest entry/exit and thus defer from starting or stopping :G events
as per the events exclude_host attribute.

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
---
 arch/arm64/kernel/perf_event.c | 39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 8e38d52..89d444f 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -26,6 +26,7 @@
 
 #include <linux/acpi.h>
 #include <linux/clocksource.h>
+#include <linux/kvm_host.h>
 #include <linux/of.h>
 #include <linux/perf/arm_pmu.h>
 #include <linux/platform_device.h>
@@ -647,12 +648,24 @@ static inline int armv8pmu_enable_counter(int idx)
 
 static inline void armv8pmu_enable_event_counter(struct perf_event *event)
 {
+	struct perf_event_attr *attr = &event->attr;
 	int idx = event->hw.idx;
+	u32 counter_bits = BIT(ARMV8_IDX_TO_COUNTER(idx));
 
-	armv8pmu_enable_counter(idx);
 	if (armv8pmu_event_is_chained(event))
-		armv8pmu_enable_counter(idx - 1);
-	isb();
+		counter_bits |= BIT(ARMV8_IDX_TO_COUNTER(idx - 1));
+
+	if (attr->exclude_host)
+		kvm_set_clr_guest_pmu_events(0, counter_bits);
+	if (attr->exclude_guest)
+		kvm_set_clr_host_pmu_events(0, counter_bits);
+
+	if (!attr->exclude_host) {
+		armv8pmu_enable_counter(idx);
+		if (armv8pmu_event_is_chained(event))
+			armv8pmu_enable_counter(idx - 1);
+		isb();
+	}
 }
 
 static inline int armv8pmu_disable_counter(int idx)
@@ -665,11 +678,23 @@ static inline int armv8pmu_disable_counter(int idx)
 static inline void armv8pmu_disable_event_counter(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
+	struct perf_event_attr *attr = &event->attr;
 	int idx = hwc->idx;
+	u32 counter_bits = BIT(ARMV8_IDX_TO_COUNTER(idx));
 
 	if (armv8pmu_event_is_chained(event))
-		armv8pmu_disable_counter(idx - 1);
-	armv8pmu_disable_counter(idx);
+		counter_bits |= BIT(ARMV8_IDX_TO_COUNTER(idx - 1));
+
+	if (attr->exclude_host)
+		kvm_set_clr_guest_pmu_events(counter_bits, 0);
+	if (attr->exclude_guest)
+		kvm_set_clr_host_pmu_events(counter_bits, 0);
+
+	if (!attr->exclude_host) {
+		if (armv8pmu_event_is_chained(event))
+			armv8pmu_disable_counter(idx - 1);
+		armv8pmu_disable_counter(idx);
+	}
 }
 
 static inline int armv8pmu_enable_intens(int idx)
@@ -977,6 +1002,10 @@ static void armv8pmu_reset(void *info)
 		armv8pmu_disable_intens(idx);
 	}
 
+	/* Clear the counters we flip at guest entry/exit */
+	kvm_set_clr_host_pmu_events(U32_MAX, 0);
+	kvm_set_clr_guest_pmu_events(U32_MAX, 0);
+
 	/*
 	 * Initialize & Reset PMNC. Request overflow interrupt for
 	 * 64 bit cycle counter but cheat in armv8pmu_write_counter().
-- 
2.7.4
