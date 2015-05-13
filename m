From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 13 May 2015 16:21:24 +0100
Subject: [PATCH] bus: arm-ccn: Use hrtimer_start()
In-Reply-To: <alpine.DEB.2.11.1505131712320.4225@nanos>
References: <alpine.DEB.2.11.1505131712320.4225@nanos>
Message-ID: <1431530484-3389-1-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hrtimer_start() does not longer defer already expired timers to the
softirq. Get rid of the __hrtimer_start_range_ns() invocation.

Reported-by: Mark Brown <mark.brown@arm.com>
Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---

Arnd, Olof, Kevin,

This patch solves the linux-next build issue reported by Mark Brown:

http://article.gmane.org/gmane.linux.kernel.next/35377

and is an equivalent of the following change:

http://marc.info/?l=linux-kernel&m=142904610220085

Could you, please, queue it?

Thanks!

 drivers/bus/arm-ccn.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/arm-ccn.c b/drivers/bus/arm-ccn.c
index df5f307..7d9879e 100644
--- a/drivers/bus/arm-ccn.c
+++ b/drivers/bus/arm-ccn.c
@@ -921,9 +921,8 @@ static void arm_ccn_pmu_event_start(struct perf_event *event, int flags)
 	 * attribute).
 	 */
 	if (!ccn->irq)
-		__hrtimer_start_range_ns(&ccn->dt.hrtimer,
-				arm_ccn_pmu_timer_period(), 0,
-				HRTIMER_MODE_REL_PINNED, 0);
+		hrtimer_start(&ccn->dt.hrtimer, arm_ccn_pmu_timer_period(),
+				HRTIMER_MODE_REL_PINNED);
 
 	/* Set the DT bus input, engaging the counter */
 	arm_ccn_pmu_xp_dt_config(event, 1);
-- 
2.1.0
