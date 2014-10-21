From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 21 Oct 2014 14:11:19 +0100
Subject: [PATCH 3/8] arm: perf: use IDR types for CPU PMUs
In-Reply-To: <1413897084-19715-1-git-send-email-mark.rutland@arm.com>
References: <1413897084-19715-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1413897084-19715-4-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For systems with heterogeneous CPUs (e.g. big.LITTLE systems) the PMUs
can be different in each cluster, and not all events can be migrated
between clusters. To allow userspace to deal with this, it must be
possible to address each PMU independently.

This patch changes PMUs to be registered with dynamic (IDR) types,
allowing them to be targeted individually. Each PMU's type can be found
in ${SYSFS_ROOT}/bus/event_source/devices/${PMU_NAME}/type.

>From userspace, raw events can be targeted at a specific PMU:
$ perf stat -e ${PMU_NAME}/config=V,config1=V1,.../

Doing this does not break existing tools which use existing perf types:
when perf core can't find a PMU of matching type (in perf_init_event)
it'll iterate over the set of all PMUs. If a compatible PMU exists,
it'll be found eventually. If more than one compatible PMU exists, the
event will be handled by whichever PMU happens to be earlier in the pmus
list (which currently will be the last compatible PMU registered).

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/perf_event.c     | 6 +++++-
 arch/arm/kernel/perf_event_cpu.c | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
index ae96b98..f0bbd3d 100644
--- a/arch/arm/kernel/perf_event.c
+++ b/arch/arm/kernel/perf_event.c
@@ -77,8 +77,12 @@ armpmu_map_event(struct perf_event *event,
 		 u32 raw_event_mask)
 {
 	u64 config = event->attr.config;
+	int type = event->attr.type;
 
-	switch (event->attr.type) {
+	if (type >= PERF_TYPE_MAX && type == event->pmu->type)
+		return armpmu_map_raw_event(raw_event_mask, config);
+
+	switch (type) {
 	case PERF_TYPE_HARDWARE:
 		return armpmu_map_hw_event(event_map, config);
 	case PERF_TYPE_HW_CACHE:
diff --git a/arch/arm/kernel/perf_event_cpu.c b/arch/arm/kernel/perf_event_cpu.c
index 79c1cf4..ed7bb04f 100644
--- a/arch/arm/kernel/perf_event_cpu.c
+++ b/arch/arm/kernel/perf_event_cpu.c
@@ -311,7 +311,7 @@ static int cpu_pmu_device_probe(struct platform_device *pdev)
 	}
 
 	cpu_pmu_init(cpu_pmu);
-	ret = armpmu_register(cpu_pmu, PERF_TYPE_RAW);
+	ret = armpmu_register(cpu_pmu, -1);
 
 	if (!ret)
 		return 0;
-- 
1.9.1
