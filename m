From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 27 Aug 2012 14:18:39 -0700
Subject: [PATCH] ARM: MSM: Implement read_current_timer for msm timers
In-Reply-To: <1345817604-9004-2-git-send-email-will.deacon@arm.com>
Message-ID: <1346102319-24497-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Setup the same timer used as the clocksource to be used as the
read_current_timer implementation. This allows us to support a
stable udelay implementation on MSMs where it's possible for the
CPUs to scale speeds independently of one another.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

I have some patches to send that add DT support to the MSM timer that
this conflicts with slightly. I'm not too concerned though, but we may
want to decide what tree this goes through when I send out those patches.

 arch/arm/mach-msm/timer.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/mach-msm/timer.c b/arch/arm/mach-msm/timer.c
index 81280825..1997ab1 100644
--- a/arch/arm/mach-msm/timer.c
+++ b/arch/arm/mach-msm/timer.c
@@ -25,6 +25,7 @@
 #include <asm/hardware/gic.h>
 #include <asm/localtimer.h>
 #include <asm/sched_clock.h>
+#include <asm/delay.h>
 
 #include <mach/msm_iomap.h>
 #include <mach/cpu.h>
@@ -172,6 +173,16 @@ static notrace u32 msm_sched_clock_read(void)
 	return msm_clocksource.read(&msm_clocksource);
 }
 
+static int msm_read_current_timer(unsigned long *timer_val)
+{
+	*timer_val = msm_clocksource.read(&msm_clocksource);
+	return 0;
+}
+
+static struct delay_timer msm_delay_timer = {
+	.read_current_timer = msm_read_current_timer,
+};
+
 static void __init msm_timer_init(void)
 {
 	struct clock_event_device *ce = &msm_clockevent;
@@ -240,6 +251,8 @@ err:
 		pr_err("clocksource_register failed\n");
 	setup_sched_clock(msm_sched_clock_read,
 			cpu_is_msm7x01() ? 32 - MSM_DGT_SHIFT : 32, dgt_hz);
+	msm_delay_timer.freq = dgt_hz;
+	register_current_timer_delay(&msm_delay_timer);
 }
 
 struct sys_timer msm_timer = {
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
