From: luis.henriques@canonical.com (Luis Henriques)
Date: Tue, 25 Mar 2014 12:09:08 +0000
Subject: [3.11.y.z extended stable] Patch "clocksource: vf_pit_timer: use
 complement for sched_clock reading" has been added to staging queue
Message-ID: <1395749348-23679-1-git-send-email-luis.henriques@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a note to let you know that I have just added a patch titled

    clocksource: vf_pit_timer: use complement for sched_clock reading

to the linux-3.11.y-queue branch of the 3.11.y.z extended stable tree 
which can be found at:

 http://kernel.ubuntu.com/git?p=ubuntu/linux.git;a=shortlog;h=refs/heads/linux-3.11.y-queue

If you, or anyone else, feels it should not be added to this tree, please 
reply to this email.

For more information about the 3.11.y.z tree, see
https://wiki.ubuntu.com/Kernel/Dev/ExtendedStable

Thanks.
-Luis

------

>From 1a35c24db888b0a2b48933680ed8fd490bddf680 Mon Sep 17 00:00:00 2001
From: Stefan Agner <stefan@agner.ch>
Date: Wed, 5 Mar 2014 23:11:08 +0100
Subject: clocksource: vf_pit_timer: use complement for sched_clock reading

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
Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
---
 drivers/clocksource/vf_pit_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/vf_pit_timer.c b/drivers/clocksource/vf_pit_timer.c
index 587e020..e559095 100644
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
