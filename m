From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue, 12 Nov 2013 22:41:03 +0100
Subject: [PATCH 1/4] ARM: sa1100: stop using mach/timex.h
In-Reply-To: <1384292466-31725-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1384292466-31725-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1384292466-31725-2-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mach/timex.h is the last remaining header that is unused for multiarch
builds but necessary for singlearch builds. To allow to get rid of it
for singlearch builds, too, drop its usage in sa1100 arch code by
substituting CLOCK_TICK_RATE by a local cpp symbol.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-sa1100/time.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-sa1100/time.c b/arch/arm/mach-sa1100/time.c
index 713c86c..83be0d6 100644
--- a/arch/arm/mach-sa1100/time.c
+++ b/arch/arm/mach-sa1100/time.c
@@ -20,6 +20,8 @@
 #include <mach/hardware.h>
 #include <mach/irqs.h>
 
+#define SA1100_CLOCK_FREQ 3686400
+
 static u32 notrace sa1100_read_sched_clock(void)
 {
 	return readl_relaxed(OSCR);
@@ -128,7 +130,7 @@ void __init sa1100_timer_init(void)
 
 	setup_irq(IRQ_OST0, &sa1100_timer_irq);
 
-	clocksource_mmio_init(OSCR, "oscr", CLOCK_TICK_RATE, 200, 32,
+	clocksource_mmio_init(OSCR, "oscr", SA1100_CLOCK_FREQ, 200, 32,
 		clocksource_mmio_readl_up);
 	clockevents_config_and_register(&ckevt_sa1100_osmr0, 3686400,
 					MIN_OSCR_DELTA * 2, 0x7fffffff);
-- 
1.8.4.2
