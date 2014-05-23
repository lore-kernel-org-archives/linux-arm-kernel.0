From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 23 May 2014 12:42:59 +0200
Subject: [PATCH 1/2] clocksource: marco: Fix the affinity set for local timer
 of CPU1
In-Reply-To: <537F2589.5050807@linaro.org>
References: <537F2589.5050807@linaro.org>
Message-ID: <1400841780-7119-1-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Zhiwu Song <Zhiwu.Song@csr.com>

irqchip will reject the affinity set to CPUs which is not online
yet. but in the CPU1 wakeup stage, OS only sets CPU1 to be online
after local timer is set, so that causes the irq_set_affinity not
work. this patch moves to irq_force_affinity() for the low level
boot stage.

Signed-off-by: Zhiwu Song <Zhiwu.Song@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-marco.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-marco.c b/drivers/clocksource/timer-marco.c
index b52e1c0..7f5374d 100644
--- a/drivers/clocksource/timer-marco.c
+++ b/drivers/clocksource/timer-marco.c
@@ -199,7 +199,7 @@ static int sirfsoc_local_timer_setup(struct clock_event_device *ce)
 
 	action->dev_id = ce;
 	BUG_ON(setup_irq(ce->irq, action));
-	irq_set_affinity(action->irq, cpumask_of(cpu));
+	irq_force_affinity(action->irq, cpumask_of(cpu));
 
 	clockevents_register_device(ce);
 	return 0;
-- 
1.7.9.5
