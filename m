From: pawel.moll@arm.com (Pawel Moll)
Date: Fri, 12 Aug 2016 17:25:53 +0100
Subject: [PATCH 2/5] bus: arm-ccn: Do not attempt to configure XPs for cycle
 counter
In-Reply-To: <1471019156-5485-1-git-send-email-pawel.moll@arm.com>
References: <1471019156-5485-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1471019156-5485-3-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fuzzing the CCN perf driver revealed a small but definitely dangerous
mistake in the event setup code. When a cycle counter is requested, the
driver should not reconfigure the events bus at all, otherwise it will
corrupt (in most but the simplest cases) its configuration and may end
up accessing XP array out of its bounds.

Reported-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>
Cc: stable at vger.kernel.org # 3.17+
Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 drivers/bus/arm-ccn.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/bus/arm-ccn.c b/drivers/bus/arm-ccn.c
index a11b9bb..9bbb0ab 100644
--- a/drivers/bus/arm-ccn.c
+++ b/drivers/bus/arm-ccn.c
@@ -897,6 +897,10 @@ static void arm_ccn_pmu_xp_dt_config(struct perf_event *event, int enable)
 	struct arm_ccn_component *xp;
 	u32 val, dt_cfg;
 
+	/* Nothing to do for cycle counter */
+	if (hw->idx == CCN_IDX_PMU_CYCLE_COUNTER)
+		return;
+
 	if (CCN_CONFIG_TYPE(event->attr.config) == CCN_TYPE_XP)
 		xp = &ccn->xp[CCN_CONFIG_XP(event->attr.config)];
 	else
-- 
2.7.4
