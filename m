From: 21cnbao@gmail.com (Barry Song)
Date: Wed,  7 May 2014 14:46:44 +0800
Subject: [PATCH] clocksource: marco: fix the affinity set for local timer of
 CPU1
Message-ID: <1399445204-22159-1-git-send-email-21cnbao@gmail.com>
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
---
 drivers/clocksource/timer-marco.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/clocksource/timer-marco.c b/drivers/clocksource/timer-marco.c
index 571d109..dbd3039 100644
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
1.7.5.4
