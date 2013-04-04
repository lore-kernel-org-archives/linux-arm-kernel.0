From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 04 Apr 2013 18:37:09 +0200
Subject: [PATCH v4 12/14] clocksource: samsung-time: Use master driver to
 control PWM channels
In-Reply-To: <1365093431-30621-1-git-send-email-t.figa@samsung.com>
References: <1365093431-30621-1-git-send-email-t.figa@samsung.com>
Message-ID: <1365093431-30621-13-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch modifies the driver to use functions provided by the master
driver to control status of PWM channels instead of modifying shared
registers directly.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/clocksource/samsung-time.c | 168 ++++---------------------------------
 1 file changed, 15 insertions(+), 153 deletions(-)

diff --git a/drivers/clocksource/samsung-time.c b/drivers/clocksource/samsung-time.c
index 7674882..9425955 100644
--- a/drivers/clocksource/samsung-time.c
+++ b/drivers/clocksource/samsung-time.c
@@ -76,153 +76,11 @@ static struct samsung_timer_source timer_source;
 static unsigned long clock_count_per_tick;
 static void samsung_timer_resume(void);
 
-static void samsung_time_stop(enum samsung_timer_mode mode)
-{
-	unsigned long tcon;
-
-	tcon = __raw_readl(S3C2410_TCON);
-
-	switch (mode) {
-	case SAMSUNG_PWM0:
-		tcon &= ~S3C2410_TCON_T0START;
-		break;
-
-	case SAMSUNG_PWM1:
-		tcon &= ~S3C2410_TCON_T1START;
-		break;
-
-	case SAMSUNG_PWM2:
-		tcon &= ~S3C2410_TCON_T2START;
-		break;
-
-	case SAMSUNG_PWM3:
-		tcon &= ~S3C2410_TCON_T3START;
-		break;
-
-	case SAMSUNG_PWM4:
-		tcon &= ~S3C2410_TCON_T4START;
-		break;
-
-	default:
-		printk(KERN_ERR "Invalid Timer %d\n", mode);
-		break;
-	}
-	__raw_writel(tcon, S3C2410_TCON);
-}
-
-static void samsung_time_setup(enum samsung_timer_mode mode, unsigned long tcnt)
-{
-	unsigned long tcon;
-
-	tcon = __raw_readl(S3C2410_TCON);
-
-	tcnt--;
-
-	switch (mode) {
-	case SAMSUNG_PWM0:
-		tcon &= ~(0x0f << 0);
-		tcon |= S3C2410_TCON_T0MANUALUPD;
-		break;
-
-	case SAMSUNG_PWM1:
-		tcon &= ~(0x0f << 8);
-		tcon |= S3C2410_TCON_T1MANUALUPD;
-		break;
-
-	case SAMSUNG_PWM2:
-		tcon &= ~(0x0f << 12);
-		tcon |= S3C2410_TCON_T2MANUALUPD;
-		break;
-
-	case SAMSUNG_PWM3:
-		tcon &= ~(0x0f << 16);
-		tcon |= S3C2410_TCON_T3MANUALUPD;
-		break;
-
-	case SAMSUNG_PWM4:
-		tcon &= ~(0x07 << 20);
-		tcon |= S3C2410_TCON_T4MANUALUPD;
-		break;
-
-	default:
-		printk(KERN_ERR "Invalid Timer %d\n", mode);
-		break;
-	}
-
-	__raw_writel(tcnt, S3C2410_TCNTB(mode));
-	__raw_writel(tcnt, S3C2410_TCMPB(mode));
-	__raw_writel(tcon, S3C2410_TCON);
-}
-
-static void samsung_time_start(enum samsung_timer_mode mode, bool periodic)
-{
-	unsigned long tcon;
-
-	tcon  = __raw_readl(S3C2410_TCON);
-
-	switch (mode) {
-	case SAMSUNG_PWM0:
-		tcon |= S3C2410_TCON_T0START;
-		tcon &= ~S3C2410_TCON_T0MANUALUPD;
-
-		if (periodic)
-			tcon |= S3C2410_TCON_T0RELOAD;
-		else
-			tcon &= ~S3C2410_TCON_T0RELOAD;
-		break;
-
-	case SAMSUNG_PWM1:
-		tcon |= S3C2410_TCON_T1START;
-		tcon &= ~S3C2410_TCON_T1MANUALUPD;
-
-		if (periodic)
-			tcon |= S3C2410_TCON_T1RELOAD;
-		else
-			tcon &= ~S3C2410_TCON_T1RELOAD;
-		break;
-
-	case SAMSUNG_PWM2:
-		tcon |= S3C2410_TCON_T2START;
-		tcon &= ~S3C2410_TCON_T2MANUALUPD;
-
-		if (periodic)
-			tcon |= S3C2410_TCON_T2RELOAD;
-		else
-			tcon &= ~S3C2410_TCON_T2RELOAD;
-		break;
-
-	case SAMSUNG_PWM3:
-		tcon |= S3C2410_TCON_T3START;
-		tcon &= ~S3C2410_TCON_T3MANUALUPD;
-
-		if (periodic)
-			tcon |= S3C2410_TCON_T3RELOAD;
-		else
-			tcon &= ~S3C2410_TCON_T3RELOAD;
-		break;
-
-	case SAMSUNG_PWM4:
-		tcon |= S3C2410_TCON_T4START;
-		tcon &= ~S3C2410_TCON_T4MANUALUPD;
-
-		if (periodic)
-			tcon |= S3C2410_TCON_T4RELOAD;
-		else
-			tcon &= ~S3C2410_TCON_T4RELOAD;
-		break;
-
-	default:
-		printk(KERN_ERR "Invalid Timer %d\n", mode);
-		break;
-	}
-	__raw_writel(tcon, S3C2410_TCON);
-}
-
 static int samsung_set_next_event(unsigned long cycles,
 				struct clock_event_device *evt)
 {
-	samsung_time_setup(timer_source.event_id, cycles);
-	samsung_time_start(timer_source.event_id, false);
+	samsung_pwm_setup(pwm, timer_source.event_id, cycles - 1, cycles - 1);
+	samsung_pwm_start(pwm, timer_source.event_id, false);
 
 	return 0;
 }
@@ -230,12 +88,13 @@ static int samsung_set_next_event(unsigned long cycles,
 static void samsung_set_mode(enum clock_event_mode mode,
 				struct clock_event_device *evt)
 {
-	samsung_time_stop(timer_source.event_id);
+	samsung_pwm_stop(pwm, timer_source.event_id);
 
 	switch (mode) {
 	case CLOCK_EVT_MODE_PERIODIC:
-		samsung_time_setup(timer_source.event_id, clock_count_per_tick);
-		samsung_time_start(timer_source.event_id, true);
+		samsung_pwm_setup(pwm, timer_source.event_id,
+			clock_count_per_tick - 1, clock_count_per_tick - 1);
+		samsung_pwm_start(pwm, timer_source.event_id, true);
 		break;
 
 	case CLOCK_EVT_MODE_ONESHOT:
@@ -254,12 +113,14 @@ static void samsung_set_mode(enum clock_event_mode mode,
 static void samsung_timer_resume(void)
 {
 	/* event timer restart */
-	samsung_time_setup(timer_source.event_id, clock_count_per_tick);
-	samsung_time_start(timer_source.event_id, true);
+	samsung_pwm_setup(pwm, timer_source.event_id,
+			clock_count_per_tick - 1, clock_count_per_tick - 1);
+	samsung_pwm_start(pwm, timer_source.event_id, true);
 
 	/* source timer restart */
-	samsung_time_setup(timer_source.source_id, timer_source.tcnt_max);
-	samsung_time_start(timer_source.source_id, true);
+	samsung_pwm_setup(pwm, timer_source.source_id,
+				timer_source.tcnt_max, timer_source.tcnt_max);
+	samsung_pwm_start(pwm, timer_source.source_id, true);
 }
 
 static struct clock_event_device time_event_device = {
@@ -364,8 +225,9 @@ static void __init samsung_clocksource_init(void)
 
 	clock_rate = pclk / (timer_source.tscaler_div * timer_source.tdiv);
 
-	samsung_time_setup(timer_source.source_id, timer_source.tcnt_max);
-	samsung_time_start(timer_source.source_id, true);
+	samsung_pwm_setup(pwm, timer_source.source_id,
+				timer_source.tcnt_max, timer_source.tcnt_max);
+	samsung_pwm_start(pwm, timer_source.source_id, true);
 
 	setup_sched_clock(samsung_read_sched_clock,
 						pwm->variant.bits, clock_rate);
-- 
1.8.1.5
