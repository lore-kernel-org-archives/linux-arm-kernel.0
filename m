From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Mon, 5 Oct 2015 10:58:56 +0200
Subject: [PATCH] twd: Don't set CLOCK_EVT_FEAT_C3STOP unconditionally
Message-ID: <56123BD0.8010005@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In 5388a6b266 ("ARM: SMP: Always enable clock event broadcast support")
Russell noted that "the TWD local timers are unable to wake up the CPU
when it is placed into a low power mode".

However, some platforms do not stop the TWD block in low-power mode,
and can thus use it without setting up a broadcast device.

Make the driver check for the "twd_never_stops" property, and set the
CLOCK_EVT_FEAT_C3STOP flag accordingly.

Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
---
 arch/arm/kernel/smp_twd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index e8f6d241881f..0ca825e24d9c 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -33,6 +33,7 @@ static unsigned long twd_timer_rate;
 static DEFINE_PER_CPU(bool, percpu_setup_called);
 
 static struct clock_event_device __percpu *twd_evt;
+static int feat_c3stop;
 static int twd_ppi;
 
 static void twd_set_mode(enum clock_event_mode mode,
@@ -293,7 +294,7 @@ static void twd_timer_setup(void)
 
 	clk->name = "local_timer";
 	clk->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT |
-			CLOCK_EVT_FEAT_C3STOP;
+			feat_c3stop;
 	clk->rating = 350;
 	clk->set_mode = twd_set_mode;
 	clk->set_next_event = twd_set_next_event;
@@ -345,6 +346,8 @@ static int __init twd_local_timer_common_register(struct device_node *np)
 		goto out_irq;
 
 	twd_get_clock(np);
+	if (!of_property_read_bool(np, "twd_never_stops"))
+		feat_c3stop = CLOCK_EVT_FEAT_C3STOP;
 
 	/*
 	 * Immediately configure the timer on the boot CPU, unless we need
-- 
2.4.5
