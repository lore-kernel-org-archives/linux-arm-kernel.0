From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 27 Feb 2015 17:21:34 +0530
Subject: [PATCH 3/3] clockevents: Don't validate dev->mode against
 CLOCK_EVT_MODE_UNUSED for new interface
In-Reply-To: <cover.1425037853.git.viresh.kumar@linaro.org>
References: <cover.1425037853.git.viresh.kumar@linaro.org>
Message-ID: <c6604fa1a77fe1fc8dcab87769857228fb1dadd5.1425037853.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It was a requirement in the legacy interface that drivers must initialize ->mode
field to 'CLOCK_EVT_MODE_UNUSED'. This field isn't used anymore by the new
interface and so should be only checked for the legacy interface.

Probably it can be dropped as well as core doesn't rely on it anymore, but lets
keep it to support legacy interface.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 kernel/time/clockevents.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index 6e53e9a0c2e8..73689df1e4b8 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -450,6 +450,8 @@ static int clockevents_sanity_check(struct clock_event_device *dev)
 		/* We shouldn't be supporting new modes now */
 		WARN_ON(dev->set_state_periodic || dev->set_state_oneshot ||
 			dev->set_state_shutdown || dev->tick_resume);
+
+		BUG_ON(dev->mode != CLOCK_EVT_MODE_UNUSED);
 		return 0;
 	}
 
@@ -479,7 +481,6 @@ void clockevents_register_device(struct clock_event_device *dev)
 {
 	unsigned long flags;
 
-	BUG_ON(dev->mode != CLOCK_EVT_MODE_UNUSED);
 	BUG_ON(clockevents_sanity_check(dev));
 
 	/* Initialize state to DETACHED */
-- 
2.3.0.rc0.44.ga94655d
