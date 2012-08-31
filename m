From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 30 Aug 2012 17:00:22 -0700
Subject: [PATCHv2] ARM: msm: Implement read_current_timer for msm timers
Message-ID: <1346371222-7450-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Setup the same timer used as the clocksource to be used as the
read_current_timer implementation. This allows us to support a
stable udelay implementation on MSMs where it's possible for the
CPUs to scale speeds independently of one another.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

Changes since v1:
 * Updated for new function signature

 arch/arm/mach-msm/timer.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/mach-msm/timer.c b/arch/arm/mach-msm/timer.c
index ce6b008..6e3b91b 100644
--- a/arch/arm/mach-msm/timer.c
+++ b/arch/arm/mach-msm/timer.c
@@ -28,6 +28,7 @@
 #include <asm/hardware/gic.h>
 #include <asm/localtimer.h>
 #include <asm/sched_clock.h>
+#include <asm/delay.h>
 
 #include "common.h"
 
@@ -173,6 +174,15 @@ static notrace u32 msm_sched_clock_read(void)
 	return msm_clocksource.read(&msm_clocksource);
 }
 
+static unsigned long msm_read_current_timer(void)
+{
+	return msm_clocksource.read(&msm_clocksource);
+}
+
+static struct delay_timer msm_delay_timer = {
+	.read_current_timer = msm_read_current_timer,
+};
+
 static void __init msm_timer_init(u32 dgt_hz, int sched_bits, int irq,
 				  bool percpu)
 {
@@ -217,6 +227,8 @@ err:
 	if (res)
 		pr_err("clocksource_register failed\n");
 	setup_sched_clock(msm_sched_clock_read, sched_bits, dgt_hz);
+	msm_delay_timer.freq = dgt_hz;
+	register_current_timer_delay(&msm_delay_timer);
 }
 
 #ifdef CONFIG_OF
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
