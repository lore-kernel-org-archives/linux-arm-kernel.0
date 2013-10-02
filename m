From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 2 Oct 2013 12:55:28 -0400
Subject: [PATCH] sched_clock: fix postinit no sched_clock function check
Message-ID: <1380732928-13897-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sched_clock code uses 2 levels of function pointers, sched_clock_func()
and read_sched_clock() but the no sched_clock check in postinit() just
checks read_sched_clock().

This leads to kernel falling back to jiffy based sched clock even in
presence of sched_clock_func() which is not desirable.

Fix the postinit() check to avoid the issue. Probably the issue is hidden
so far on most of the arm SOCs because of already existing sched_clock
registrations apart from arch_timer sched_clock. One can reproduce the
issue by just have arch_timer as sched_clock

Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Thomas Gleixner <tglx@linutronix.de>

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 kernel/time/sched_clock.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
index 0b479a6..15c4d78 100644
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -179,7 +179,8 @@ void __init sched_clock_postinit(void)
 	 * If no sched_clock function has been provided at that point,
 	 * make it the final one one.
 	 */
-	if (read_sched_clock == jiffy_sched_clock_read)
+	if ((read_sched_clock == jiffy_sched_clock_read) &&
+			(sched_clock_func == sched_clock_32))
 		setup_sched_clock(jiffy_sched_clock_read, 32, HZ);
 
 	sched_clock_poll(sched_clock_timer.data);
-- 
1.7.9.5
