From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Sat, 1 Mar 2014 16:57:14 +0300
Subject: [patch] clocksource: exynos_mct: silence a static checker warning
Message-ID: <20140301135714.GD23929@elgon.mountain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

My guess is we aren't going to have a 2 digit cpuid here any time soon
but the static checkers don't know that and complain that the snprintf()
could overflow.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index ed49b25fa552..a6ee6d7cd63f 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -408,7 +408,7 @@ static int exynos4_local_timer_setup(struct clock_event_device *evt)
 	mevt = container_of(evt, struct mct_clock_event_device, evt);
 
 	mevt->base = EXYNOS4_MCT_L_BASE(cpu);
-	sprintf(mevt->name, "mct_tick%d", cpu);
+	snprintf(mevt->name, sizeof(mevt->name), "mct_tick%d", cpu);
 
 	evt->name = mevt->name;
 	evt->cpumask = cpumask_of(cpu);
