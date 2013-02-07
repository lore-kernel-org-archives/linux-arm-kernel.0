From: robherring2@gmail.com (Rob Herring)
Date: Thu,  7 Feb 2013 13:09:03 -0600
Subject: [PATCH 3/4] clocksource: vt8500: use the device_node pointer passed
 to init
In-Reply-To: <1360264144-20714-1-git-send-email-robherring2@gmail.com>
References: <1360264144-20714-1-git-send-email-robherring2@gmail.com>
Message-ID: <1360264144-20714-4-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

We've already matched the node, so use the node pointer passed in.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: John Stultz <johnstul@us.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/clocksource/vt8500_timer.c |   14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/clocksource/vt8500_timer.c b/drivers/clocksource/vt8500_timer.c
index 8efc86b..2422552 100644
--- a/drivers/clocksource/vt8500_timer.c
+++ b/drivers/clocksource/vt8500_timer.c
@@ -129,22 +129,10 @@ static struct irqaction irq = {
 	.dev_id  = &clockevent,
 };
 
-static struct of_device_id vt8500_timer_ids[] = {
-	{ .compatible = "via,vt8500-timer" },
-	{ }
-};
-
-static void __init vt8500_timer_init(void)
+static void __init vt8500_timer_init(struct device_node *np)
 {
-	struct device_node *np;
 	int timer_irq;
 
-	np = of_find_matching_node(NULL, vt8500_timer_ids);
-	if (!np) {
-		pr_err("%s: Timer description missing from Device Tree\n",
-								__func__);
-		return;
-	}
 	regbase = of_iomap(np, 0);
 	if (!regbase) {
 		pr_err("%s: Missing iobase description in Device Tree\n",
-- 
1.7.10.4
