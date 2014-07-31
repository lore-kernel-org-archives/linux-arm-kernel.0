From: pawel.moll@arm.com (Pawel Moll)
Date: Thu, 31 Jul 2014 16:16:37 +0100
Subject: [PATCH] bus: arm-ccn: Fix error handling at event allocation
Message-ID: <1406819797-8372-1-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The bitfield allocation function returns error condition
as a negative value, but in two cases its result
was assigned to an unsigned member of the hw_perf_event
structure, thus the error would not be ever detected.

Fixed by using an intermediate, signed variable.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---

Dan discovered the problem using his static checker. Thanks, Dan!

Arnd, would you pick up the patch as it is or do you want me
to send a pull request for a "ccn/fixes" branch?

 drivers/bus/arm-ccn.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/arm-ccn.c b/drivers/bus/arm-ccn.c
index 4f86bbb..3266f8f 100644
--- a/drivers/bus/arm-ccn.c
+++ b/drivers/bus/arm-ccn.c
@@ -591,7 +591,7 @@ static int arm_ccn_pmu_event_init(struct perf_event *event)
 	struct arm_ccn *ccn;
 	struct hw_perf_event *hw = &event->hw;
 	u32 node_xp, type, event_id;
-	int valid;
+	int valid, bit;
 	struct arm_ccn_component *source;
 	int i;
 
@@ -713,17 +713,18 @@ static int arm_ccn_pmu_event_init(struct perf_event *event)
 
 	/* Allocate an event source or a watchpoint */
 	if (type == CCN_TYPE_XP && event_id == CCN_EVENT_WATCHPOINT)
-		hw->config_base = arm_ccn_pmu_alloc_bit(source->xp.dt_cmp_mask,
+		bit = arm_ccn_pmu_alloc_bit(source->xp.dt_cmp_mask,
 				CCN_NUM_XP_WATCHPOINTS);
 	else
-		hw->config_base = arm_ccn_pmu_alloc_bit(source->pmu_events_mask,
+		bit = arm_ccn_pmu_alloc_bit(source->pmu_events_mask,
 				CCN_NUM_PMU_EVENTS);
-	if (hw->config_base < 0) {
+	if (bit < 0) {
 		dev_warn(ccn->dev, "No more event sources/watchpoints on node/XP %d!\n",
 				node_xp);
 		clear_bit(hw->idx, ccn->dt.pmu_counters_mask);
 		return -EAGAIN;
 	}
+	hw->config_base = bit;
 
 	ccn->dt.pmu_counters[hw->idx].event = event;
 
-- 
1.9.1
