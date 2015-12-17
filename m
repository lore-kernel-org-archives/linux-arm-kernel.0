From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Thu, 17 Dec 2015 17:49:11 +0000
Subject: [PATCH v4 04/12] arm-cci: Fix the flags for pmu_start called from
 pmu_add
In-Reply-To: <1450374559-23315-1-git-send-email-suzuki.poulose@arm.com>
References: <1450374559-23315-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1450374559-23315-5-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cci PMU always reprograms the counter value in pmu->start()
irrespective of the mode it is called from, making sure that
the hwc->state is PERF_HES_UPTODATE.

When pmu->add() is called with PERF_EF_START, we invoke
pmu->start() with PERF_EF_RELOAD removing the PERF_EF_START.
This makes it impossible to detect where the pmu->start()
is called from, i.e, PERF_EF_START or a real PERF_EF_RELOAD.

This patch fixes the issue by, passing the right flags down
to the pmu->start() when called from pmu->add().

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Punit Agrawal <punit.agrawal@arm.com>
Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 drivers/bus/arm-cci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index f6b8717..f00cbce 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -1020,7 +1020,7 @@ static int cci_pmu_add(struct perf_event *event, int flags)
 
 	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
 	if (flags & PERF_EF_START)
-		cci_pmu_start(event, PERF_EF_RELOAD);
+		cci_pmu_start(event, flags);
 
 	/* Propagate our changes to the userspace mapping. */
 	perf_event_update_userpage(event);
-- 
1.7.9.5
