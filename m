From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon,  6 Jul 2015 16:24:14 +0530
Subject: [PATCH 07/18] ARM/ixp4xx/timer: Migrate to new 'set-state' interface
In-Reply-To: <cover.1436178990.git.viresh.kumar@linaro.org>
References: <cover.1436178990.git.viresh.kumar@linaro.org>
Message-ID: <33e74a50c268fb18e80116443f603d1c205f1c0c.1436178990.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Migrate ixp4xx driver to the new 'set-state' interface provided by
clockevents core, the earlier 'set-mode' interface is marked obsolete
now.

This also enables us to implement callbacks for new states of clockevent
devices, for example: ONESHOT_STOPPED.

NOTE: ixp4xx_set_{oneshot|periodic} don't perform read operation on
'IXP4XX_OSRT1' register anymore.

Cc: Imre Kaloz <kaloz@openwrt.org>
Cc: Krzysztof Halasa <khalasa@piap.pl>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/mach-ixp4xx/common.c | 68 +++++++++++++++++++++++++------------------
 1 file changed, 40 insertions(+), 28 deletions(-)

diff --git a/arch/arm/mach-ixp4xx/common.c b/arch/arm/mach-ixp4xx/common.c
index 8537d4c41e34..70773b948e7e 100644
--- a/arch/arm/mach-ixp4xx/common.c
+++ b/arch/arm/mach-ixp4xx/common.c
@@ -521,43 +521,55 @@ static int ixp4xx_set_next_event(unsigned long evt,
 	return 0;
 }
 
-static void ixp4xx_set_mode(enum clock_event_mode mode,
-			    struct clock_event_device *evt)
+static int ixp4xx_shutdown(struct clock_event_device *evt)
 {
 	unsigned long opts = *IXP4XX_OSRT1 & IXP4XX_OST_RELOAD_MASK;
 	unsigned long osrt = *IXP4XX_OSRT1 & ~IXP4XX_OST_RELOAD_MASK;
 
-	switch (mode) {
-	case CLOCK_EVT_MODE_PERIODIC:
-		osrt = IXP4XX_LATCH & ~IXP4XX_OST_RELOAD_MASK;
- 		opts = IXP4XX_OST_ENABLE;
-		break;
-	case CLOCK_EVT_MODE_ONESHOT:
-		/* period set by 'set next_event' */
-		osrt = 0;
-		opts = IXP4XX_OST_ENABLE | IXP4XX_OST_ONE_SHOT;
-		break;
-	case CLOCK_EVT_MODE_SHUTDOWN:
-		opts &= ~IXP4XX_OST_ENABLE;
-		break;
-	case CLOCK_EVT_MODE_RESUME:
-		opts |= IXP4XX_OST_ENABLE;
-		break;
-	case CLOCK_EVT_MODE_UNUSED:
-	default:
-		osrt = opts = 0;
-		break;
-	}
+	opts &= ~IXP4XX_OST_ENABLE;
+	*IXP4XX_OSRT1 = osrt | opts;
+	return 0;
+}
 
+static int ixp4xx_set_oneshot(struct clock_event_device *evt)
+{
+	unsigned long opts = IXP4XX_OST_ENABLE | IXP4XX_OST_ONE_SHOT;
+	unsigned long osrt = 0;
+
+	/* period set by 'set next_event' */
 	*IXP4XX_OSRT1 = osrt | opts;
+	return 0;
+}
+
+static int ixp4xx_set_periodic(struct clock_event_device *evt)
+{
+	unsigned long opts = IXP4XX_OST_ENABLE;
+	unsigned long osrt = IXP4XX_LATCH & ~IXP4XX_OST_RELOAD_MASK;
+
+	*IXP4XX_OSRT1 = osrt | opts;
+	return 0;
+}
+
+static int ixp4xx_resume(struct clock_event_device *evt)
+{
+	unsigned long opts = *IXP4XX_OSRT1 & IXP4XX_OST_RELOAD_MASK;
+	unsigned long osrt = *IXP4XX_OSRT1 & ~IXP4XX_OST_RELOAD_MASK;
+
+	opts |= IXP4XX_OST_ENABLE;
+	*IXP4XX_OSRT1 = osrt | opts;
+	return 0;
 }
 
 static struct clock_event_device clockevent_ixp4xx = {
-	.name		= "ixp4xx timer1",
-	.features       = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
-	.rating         = 200,
-	.set_mode	= ixp4xx_set_mode,
-	.set_next_event	= ixp4xx_set_next_event,
+	.name			= "ixp4xx timer1",
+	.features		= CLOCK_EVT_FEAT_PERIODIC |
+				  CLOCK_EVT_FEAT_ONESHOT,
+	.rating			= 200,
+	.set_state_shutdown	= ixp4xx_shutdown,
+	.set_state_periodic	= ixp4xx_set_periodic,
+	.set_state_oneshot	= ixp4xx_set_oneshot,
+	.tick_resume		= ixp4xx_resume,
+	.set_next_event		= ixp4xx_set_next_event,
 };
 
 static void __init ixp4xx_clockevent_init(void)
-- 
2.4.0
