From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Wed, 28 Jun 2017 14:20:35 +0530
Subject: [PATCH] clocksource: timer-atlas7: Unmap region obtained by of_iomap.
Message-ID: <9f0111845863f80d4c04a62441c2f68a0d8a2eb0.1498639755.git.arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In case of error at init time, rollback iomapping.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/clocksource/timer-atlas7.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clocksource/timer-atlas7.c b/drivers/clocksource/timer-atlas7.c
index 50300ee..1811038 100644
--- a/drivers/clocksource/timer-atlas7.c
+++ b/drivers/clocksource/timer-atlas7.c
@@ -272,12 +272,14 @@ static int __init sirfsoc_of_timer_init(struct device_node *np)
 	sirfsoc_timer_irq.irq = irq_of_parse_and_map(np, 0);
 	if (!sirfsoc_timer_irq.irq) {
 		pr_err("No irq passed for timer0 via DT\n");
+		iounmap(sirfsoc_timer_base);
 		return -EINVAL;
 	}
 
 	sirfsoc_timer1_irq.irq = irq_of_parse_and_map(np, 1);
 	if (!sirfsoc_timer1_irq.irq) {
 		pr_err("No irq passed for timer1 via DT\n");
+		iounmap(sirfsoc_timer_base);
 		return -EINVAL;
 	}
 
-- 
1.9.1
