From: will.deacon@arm.com (Will Deacon)
Date: Fri, 24 Aug 2012 15:13:23 +0100
Subject: [PATCH 1/2] ARM: delay: set loops_per_jiffy when moving to
 timer-based loop
Message-ID: <1345817604-9004-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The delay functions may be called by some platforms between switching to
the timer-based delay loop but before calibration. In this case, the
initial loops_per_jiffy may not be suitable for the timer (although a
compromise may be achievable) and delay times may be considered too
inaccurate.

This patch updates loops_per_jiffy when switching to the timer-based
delay loop so that delays are consistent prior to calibration.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/lib/delay.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/lib/delay.c b/arch/arm/lib/delay.c
index d6dacc6..395d5fb 100644
--- a/arch/arm/lib/delay.c
+++ b/arch/arm/lib/delay.c
@@ -59,6 +59,7 @@ void __init init_current_timer_delay(unsigned long freq)
 {
 	pr_info("Switching to timer-based delay loop\n");
 	lpj_fine			= freq / HZ;
+	loops_per_jiffy			= lpj_fine;
 	arm_delay_ops.delay		= __timer_delay;
 	arm_delay_ops.const_udelay	= __timer_const_udelay;
 	arm_delay_ops.udelay		= __timer_udelay;
-- 
1.7.4.1
