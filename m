From: msalter@redhat.com (Mark Salter)
Date: Wed,  8 Apr 2015 14:21:24 -0400
Subject: [PATCH] drivers: CCI: fix used_mask init in validate_group()
Message-ID: <1428517284-7951-1-git-send-email-msalter@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently in validate_group(), there is a static initializer
for fake_pmu.used_mask which is based on CPU_BITS_NONE but
the used_mask array size is based on CCI_PMU_MAX_HW_EVENTS.
CCI_PMU_MAX_HW_EVENTS is not based on NR_CPUS, so CPU_BITS_NONE
is not correct and will cause a build failure if NR_CPUS
is set high enough to make CPU_BITS_NONE larger than used_mask.
This patch changes the used_mask initialization to be runtime
based on the actual size of the array.

Signed-off-by: Mark Salter <msalter@redhat.com>
---
 drivers/bus/arm-cci.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index 84fd660..1d83072 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -679,13 +679,13 @@ static int
 validate_group(struct perf_event *event)
 {
 	struct perf_event *sibling, *leader = event->group_leader;
-	struct cci_pmu_hw_events fake_pmu = {
-		/*
-		 * Initialise the fake PMU. We only need to populate the
-		 * used_mask for the purposes of validation.
-		 */
-		.used_mask = CPU_BITS_NONE,
-	};
+	struct cci_pmu_hw_events fake_pmu;
+
+	/*
+	 * Initialise the fake PMU. We only need to populate the
+	 * used_mask for the purposes of validation.
+	 */
+	memset(fake_pmu.used_mask, 0, sizeof(fake_pmu.used_mask));
 
 	if (!validate_event(&fake_pmu, leader))
 		return -EINVAL;
-- 
1.9.3
