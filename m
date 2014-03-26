From: jslaby@suse.cz (Jiri Slaby)
Date: Wed, 26 Mar 2014 10:46:35 +0100
Subject: [patch added to the 3.12 stable tree] clocksource: vf_pit_timer: use
 complement for sched_clock reading
In-Reply-To: <1395827220-11701-1-git-send-email-jslaby@suse.cz>
References: <1395827220-11701-1-git-send-email-jslaby@suse.cz>
Message-ID: <1395827220-11701-8-git-send-email-jslaby@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stefan Agner <stefan@agner.ch>

This patch has been added to the 3.12 stable tree. If you have any
objections, please let us know.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
