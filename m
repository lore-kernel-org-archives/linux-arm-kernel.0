From: robherring2@gmail.com (Rob Herring)
Date: Thu,  7 Feb 2013 13:09:02 -0600
Subject: [PATCH 2/4] clocksource: bcm2835: use the device_node pointer passed
 to init
In-Reply-To: <1360264144-20714-1-git-send-email-robherring2@gmail.com>
References: <1360264144-20714-1-git-send-email-robherring2@gmail.com>
Message-ID: <1360264144-20714-3-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

We've already matched the node, so use the node pointer passed in.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: John Stultz <johnstul@us.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/clocksource/bcm2835_timer.c |   12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/clocksource/bcm2835_timer.c b/drivers/clocksource/bcm2835_timer.c
index 50c68fe..766611d 100644
--- a/drivers/clocksource/bcm2835_timer.c
+++ b/drivers/clocksource/bcm2835_timer.c
@@ -95,23 +95,13 @@ static irqreturn_t bcm2835_time_interrupt(int irq, void *dev_id)
 	}
 }
 
-static struct of_device_id bcm2835_time_match[] __initconst = {
-	{ .compatible = "brcm,bcm2835-system-timer" },
-	{}
-};
-
-static void __init bcm2835_timer_init(void)
+static void __init bcm2835_timer_init(struct device_node *node)
 {
-	struct device_node *node;
 	void __iomem *base;
 	u32 freq;
 	int irq;
 	struct bcm2835_timer *timer;
 
-	node = of_find_matching_node(NULL, bcm2835_time_match);
-	if (!node)
-		panic("No bcm2835 timer node");
-
 	base = of_iomap(node, 0);
 	if (!base)
 		panic("Can't remap registers");
-- 
1.7.10.4
