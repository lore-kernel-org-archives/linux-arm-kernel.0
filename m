From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Tue,  5 May 2015 12:49:02 +0100
Subject: [PATCH 1/7] drivers: CCI: fix used_mask init in validate_group()
In-Reply-To: <1430826548-29960-1-git-send-email-suzuki.poulose@arm.com>
References: <1430826548-29960-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1430826548-29960-2-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Salter <msalter@redhat.com>

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
 drivers/bus/arm-cci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index b854125..941b831 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -660,7 +660,7 @@ validate_group(struct perf_event *event)
 		 * Initialise the fake PMU. We only need to populate the
 		 * used_mask for the purposes of validation.
 		 */
-		.used_mask = CPU_BITS_NONE,
+		.used_mask =  { 0 },
 	};
 
 	if (!validate_event(event->pmu, &fake_pmu, leader))
-- 
1.7.9.5
