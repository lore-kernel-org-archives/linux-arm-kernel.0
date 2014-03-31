From: jslaby@suse.cz (Jiri Slaby)
Date: Mon, 31 Mar 2014 14:35:41 +0200
Subject: [PATCH 3.12 20/48] clocksource: vf_pit_timer: use complement for
 sched_clock reading
In-Reply-To: <3d316682dc951d54ac0c9927968fdfe372d47c37.1396269188.git.jslaby@suse.cz>
References: <3d316682dc951d54ac0c9927968fdfe372d47c37.1396269188.git.jslaby@suse.cz>
Message-ID: <07a2f05ccb2b392a0360653eb6f9d32906e2d516.1396269188.git.jslaby@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stefan Agner <stefan@agner.ch>

3.12-stable review patch.  If anyone has any objections, please let me know.

===============

commit 224aa3ed45c8735ae02bb2ecca002409fa6aa772 upstream.

Vybrids PIT register is monitonic decreasing. However, sched_clock
reading needs to be monitonic increasing. Use bitwise not to get
the complement of the clock register. This fixes the clock going
backward. Also, the clock now starts at 0 since we load the
register with the maximum value at start.

Signed-off-by: Stefan Agner <stefan@agner.ch>
Acked-by: Shawn Guo <shawn.guo@linaro.org>
Cc: daniel.lezcano at linaro.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux at arm.linux.org.uk
Link: http://lkml.kernel.org/r/d25af915993aec1b486be653eb86f748ddef54fe.1394057313.git.stefan at agner.ch
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/clocksource/vf_pit_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/vf_pit_timer.c b/drivers/clocksource/vf_pit_timer.c
index 587e0202a70b..e5590953630e 100644
--- a/drivers/clocksource/vf_pit_timer.c
+++ b/drivers/clocksource/vf_pit_timer.c
@@ -54,7 +54,7 @@ static inline void pit_irq_acknowledge(void)
 
 static unsigned int pit_read_sched_clock(void)
 {
-	return __raw_readl(clksrc_base + PITCVAL);
+	return ~__raw_readl(clksrc_base + PITCVAL);
 }
 
 static int __init pit_clocksource_init(unsigned long rate)
-- 
1.9.1
