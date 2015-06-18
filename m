From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 18 Jun 2015 16:24:35 +0530
Subject: [PATCH 21/41] clocksource: sh_mtu2: Migrate to new 'set-state'
 interface
In-Reply-To: <cover.1434622147.git.viresh.kumar@linaro.org>
References: <cover.1434622147.git.viresh.kumar@linaro.org>
Message-ID: <b0ba582aafb8b505ee1c2d001d6e442d5532f701.1434622147.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Migrate sh_mtu2 driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

Cc: Magnus Damm <damm+renesas@opensource.se>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: Paul Mundt <lethal@linux-sh.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/clocksource/sh_mtu2.c | 42 ++++++++++++++++--------------------------
 1 file changed, 16 insertions(+), 26 deletions(-)

diff --git a/drivers/clocksource/sh_mtu2.c b/drivers/clocksource/sh_mtu2.c
index 3d88698cf2b8..f1985da8113f 100644
--- a/drivers/clocksource/sh_mtu2.c
+++ b/drivers/clocksource/sh_mtu2.c
@@ -276,36 +276,25 @@ static struct sh_mtu2_channel *ced_to_sh_mtu2(struct clock_event_device *ced)
 	return container_of(ced, struct sh_mtu2_channel, ced);
 }
 
-static void sh_mtu2_clock_event_mode(enum clock_event_mode mode,
-				    struct clock_event_device *ced)
+static int sh_mtu2_clock_event_shutdown(struct clock_event_device *ced)
 {
 	struct sh_mtu2_channel *ch = ced_to_sh_mtu2(ced);
-	int disabled = 0;
 
-	/* deal with old setting first */
-	switch (ced->mode) {
-	case CLOCK_EVT_MODE_PERIODIC:
+	sh_mtu2_disable(ch);
+	return 0;
+}
+
+static int sh_mtu2_clock_event_set_periodic(struct clock_event_device *ced)
+{
+	struct sh_mtu2_channel *ch = ced_to_sh_mtu2(ced);
+
+	if (clockevent_state_periodic(ced))
 		sh_mtu2_disable(ch);
-		disabled = 1;
-		break;
-	default:
-		break;
-	}
 
-	switch (mode) {
-	case CLOCK_EVT_MODE_PERIODIC:
-		dev_info(&ch->mtu->pdev->dev,
-			 "ch%u: used for periodic clock events\n", ch->index);
-		sh_mtu2_enable(ch);
-		break;
-	case CLOCK_EVT_MODE_UNUSED:
-		if (!disabled)
-			sh_mtu2_disable(ch);
-		break;
-	case CLOCK_EVT_MODE_SHUTDOWN:
-	default:
-		break;
-	}
+	dev_info(&ch->mtu->pdev->dev, "ch%u: used for periodic clock events\n",
+		 ch->index);
+	sh_mtu2_enable(ch);
+	return 0;
 }
 
 static void sh_mtu2_clock_event_suspend(struct clock_event_device *ced)
@@ -327,7 +316,8 @@ static void sh_mtu2_register_clockevent(struct sh_mtu2_channel *ch,
 	ced->features = CLOCK_EVT_FEAT_PERIODIC;
 	ced->rating = 200;
 	ced->cpumask = cpu_possible_mask;
-	ced->set_mode = sh_mtu2_clock_event_mode;
+	ced->set_state_shutdown = sh_mtu2_clock_event_shutdown;
+	ced->set_state_periodic = sh_mtu2_clock_event_set_periodic;
 	ced->suspend = sh_mtu2_clock_event_suspend;
 	ced->resume = sh_mtu2_clock_event_resume;
 
-- 
2.4.0
