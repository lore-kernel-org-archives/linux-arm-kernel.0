From: pawel.moll@arm.com (Pawel Moll)
Date: Mon, 15 Sep 2014 15:33:48 +0100
Subject: [PATCH] bus: arm-ccn: Fix spurious warning message
Message-ID: <1410791628-30038-1-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Because CCN's cycle counter always runs, it will generate
an interrupt on overflow even if the relevant perf event
was not requested, causing a spurious warning message.

Fixed now by warning on only normal counter unwanted
overflows. Also cleaning the overflow mask at init now,
not to warn on event previously requested by firmware.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 drivers/bus/arm-ccn.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/arm-ccn.c b/drivers/bus/arm-ccn.c
index a60f264..aaa0f2a 100644
--- a/drivers/bus/arm-ccn.c
+++ b/drivers/bus/arm-ccn.c
@@ -57,6 +57,7 @@
 #define CCN_DT_PMCCNTRSR		0x0190
 #define CCN_DT_PMOVSR			0x0198
 #define CCN_DT_PMOVSR_CLR		0x01a0
+#define CCN_DT_PMOVSR_CLR__MASK				0x1f
 #define CCN_DT_PMCR			0x01a8
 #define CCN_DT_PMCR__OVFL_INTR_EN			(1 << 6)
 #define CCN_DT_PMCR__PMU_EN				(1 << 0)
@@ -1051,7 +1052,8 @@ static irqreturn_t arm_ccn_pmu_overflow_handler(struct arm_ccn_dt *dt)
 		struct perf_event *event = dt->pmu_counters[idx].event;
 		int overflowed = pmovsr & BIT(idx);
 
-		WARN_ON_ONCE(overflowed && !event);
+		WARN_ON_ONCE(overflowed && !event &&
+				idx != CCN_IDX_PMU_CYCLE_COUNTER);
 
 		if (!event || !overflowed)
 			continue;
@@ -1087,6 +1089,7 @@ static int arm_ccn_pmu_init(struct arm_ccn *ccn)
 	/* Initialize DT subsystem */
 	ccn->dt.base = ccn->base + CCN_REGION_SIZE;
 	spin_lock_init(&ccn->dt.config_lock);
+	writel(CCN_DT_PMOVSR_CLR__MASK, ccn->dt.base + CCN_DT_PMOVSR_CLR);
 	writel(CCN_DT_CTL__DT_EN, ccn->dt.base + CCN_DT_CTL);
 	writel(CCN_DT_PMCR__OVFL_INTR_EN | CCN_DT_PMCR__PMU_EN,
 			ccn->dt.base + CCN_DT_PMCR);
-- 
1.9.1
