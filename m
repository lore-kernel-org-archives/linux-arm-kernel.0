From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 21 Feb 2012 17:39:37 -0800
Subject: [PATCH] msm: timer: Support sched_clock()
Message-ID: <1329874777-12758-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that sched_clock is mandatory on ARM it's simple to add
sched_clock support to the MSM timer code. Add it so that we get
more accurate sched_clock output than the jiffies based version
that's provided by default.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: David Brown <davidb@codeaurora.org>
---

This is based on Marc's mandatory sched_clock patch series
located at

 git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git sched_clock-v3.3-rc3

 arch/arm/mach-msm/timer.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-msm/timer.c b/arch/arm/mach-msm/timer.c
index 11d0d8f..61983da 100644
--- a/arch/arm/mach-msm/timer.c
+++ b/arch/arm/mach-msm/timer.c
@@ -24,6 +24,7 @@
 #include <asm/mach/time.h>
 #include <asm/hardware/gic.h>
 #include <asm/localtimer.h>
+#include <asm/sched_clock.h>
 
 #include <mach/msm_iomap.h>
 #include <mach/cpu.h>
@@ -105,12 +106,12 @@ static union {
 
 static void __iomem *source_base;
 
-static cycle_t msm_read_timer_count(struct clocksource *cs)
+static notrace cycle_t msm_read_timer_count(struct clocksource *cs)
 {
 	return readl_relaxed(source_base + TIMER_COUNT_VAL);
 }
 
-static cycle_t msm_read_timer_count_shift(struct clocksource *cs)
+static notrace cycle_t msm_read_timer_count_shift(struct clocksource *cs)
 {
 	/*
 	 * Shift timer count down by a constant due to unreliable lower bits
@@ -127,6 +128,11 @@ static struct clocksource msm_clocksource = {
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
+static notrace u32 msm_sched_clock_read(void)
+{
+	return msm_clocksource.read(&msm_clocksource);
+}
+
 static void __init msm_timer_init(void)
 {
 	struct clock_event_device *ce = &msm_clockevent;
@@ -189,6 +195,8 @@ err:
 	res = clocksource_register_hz(cs, dgt_hz);
 	if (res)
 		pr_err("clocksource_register failed\n");
+	setup_sched_clock(msm_sched_clock_read,
+			cpu_is_msm7x01() ? 32 - MSM_DGT_SHIFT : 32, dgt_hz);
 }
 
 #ifdef CONFIG_LOCAL_TIMERS
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
