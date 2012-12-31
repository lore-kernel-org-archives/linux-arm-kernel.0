From: vaibhav.bedia@ti.com (Vaibhav Bedia)
Date: Mon, 31 Dec 2012 18:37:05 +0530
Subject: [RFC v2 12/18] ARM: OMAP2+: timer: Add suspend-resume callbacks for
 clockevent device
In-Reply-To: <1356959231-17335-1-git-send-email-vaibhav.bedia@ti.com>
References: <1356959231-17335-1-git-send-email-vaibhav.bedia@ti.com>
Message-ID: <1356959231-17335-13-git-send-email-vaibhav.bedia@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current OMAP timer code registers two timers -
one as clocksource and one as clockevent.
AM33XX has only one usable timer in the WKUP domain
so one of the timers needs suspend-resume support
to restore the configuration to pre-suspend state.

commit adc78e6 (timekeeping: Add suspend and resume
of clock event devices) introduced .suspend and .resume
callbacks for clock event devices. Leverages these
callbacks to have AM33XX clockevent timer which is
in not in WKUP domain to behave properly across system
suspend.

Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Jon Hunter <jon-hunter@ti.com>
---
v1->v2:
	Get rid of harcoded timer id.
	Note: since a platform device is not created for these timer
	instances and because there's very minimal change needed for
	restarting the timer a full blown context save and restore
	has been skipped.

 arch/arm/mach-omap2/timer.c |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 691aa67..38f9cbc 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -128,6 +128,36 @@ static void omap2_gp_timer_set_mode(enum clock_event_mode mode,
 	}
 }
 
+static void omap_clkevt_suspend(struct clock_event_device *unused)
+{
+	char name[10];
+	struct omap_hwmod *oh;
+
+	sprintf(name, "timer%d", clkev.id);
+	oh = omap_hwmod_lookup(name);
+	if (!oh)
+		return;
+
+	__omap_dm_timer_stop(&clkev, 1, clkev.rate);
+	omap_hwmod_idle(oh);
+}
+
+static void omap_clkevt_resume(struct clock_event_device *unused)
+{
+	char name[10];
+	struct omap_hwmod *oh;
+
+	sprintf(name, "timer%d", clkev.id);
+	oh = omap_hwmod_lookup(name);
+	if (!oh)
+		return;
+
+	omap_hwmod_enable(oh);
+	__omap_dm_timer_load_start(&clkev,
+			OMAP_TIMER_CTRL_ST | OMAP_TIMER_CTRL_AR, 0, 1);
+	__omap_dm_timer_int_enable(&clkev, OMAP_TIMER_INT_OVERFLOW);
+}
+
 static struct clock_event_device clockevent_gpt = {
 	.name		= "gp_timer",
 	.features       = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
@@ -135,6 +165,8 @@ static struct clock_event_device clockevent_gpt = {
 	.rating		= 300,
 	.set_next_event	= omap2_gp_timer_set_next_event,
 	.set_mode	= omap2_gp_timer_set_mode,
+	.suspend	= omap_clkevt_suspend,
+	.resume		= omap_clkevt_resume,
 };
 
 static struct property device_disabled = {
@@ -323,6 +355,7 @@ static void __init omap2_gp_clockevent_init(int gptimer_id,
 	int res;
 
 	clkev.errata = omap_dm_timer_get_errata();
+	clkev.id = gptimer_id;
 
 	/*
 	 * For clock-event timers we never read the timer counter and
-- 
1.7.0.4
