From: mike.looijmans@topic.nl (Mike Looijmans)
Date: Thu, 17 Mar 2016 08:15:33 +0100
Subject: [PATCH] clocksource/arm_global_timer.c: Reduce the rating from 300 to
 150
Message-ID: <1458198933-3397-1-git-send-email-mike.looijmans@topic.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The arm_global_timer clock runs on the CPU clock, and does not correct
for cpufreq scaling. This makes the clock not very suitable as a
clocksource, and basically any clock running on an independent
oscilator is preferable. Few clocksources have a rating over 300,
so this clock usually gets selected as clock source.

On the Zynq-7000 for example, the TTC clock on the chip is preferred
to the global timer, because the TTC can at least compensate for
cpufreq scaling. That makes the TTC (which rates itself 200) a much
better clock source than the ARM global timer.

Reduce the rating to 150 to make systems select the ARM global timer
as a last resort instead of a first choice.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---
 drivers/clocksource/arm_global_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm_global_timer.c
index 9df0d16..bb410eb 100644
--- a/drivers/clocksource/arm_global_timer.c
+++ b/drivers/clocksource/arm_global_timer.c
@@ -209,7 +209,7 @@ static void gt_resume(struct clocksource *cs)
 
 static struct clocksource gt_clocksource = {
 	.name	= "arm_global_timer",
-	.rating	= 300,
+	.rating	= 150,
 	.read	= gt_clocksource_read,
 	.mask	= CLOCKSOURCE_MASK(64),
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
-- 
1.9.1
