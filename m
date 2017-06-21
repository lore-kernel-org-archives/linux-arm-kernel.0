From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Wed, 21 Jun 2017 20:20:04 +0200
Subject: [PATCH] pinctrl: bcm2835: Avoid warning from __irq_do_set_handler
Message-ID: <1498069204-28154-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We get a warning during boot with enabled EARLY_PRINTK that
we try to set a irq_chip without data. This is caused by ignoring
the return value of irq_of_parse_and_map(). So avoid calling
gpiochip_set_chained_irqchip() in error case.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Fixes: 85ae9e512f43 ("pinctrl: bcm2835: switch to GPIOLIB_IRQCHIP")
---
 drivers/pinctrl/bcm/pinctrl-bcm2835.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pinctrl/bcm/pinctrl-bcm2835.c b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
index 1eb7a1a..2308831 100644
--- a/drivers/pinctrl/bcm/pinctrl-bcm2835.c
+++ b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
@@ -1048,6 +1048,10 @@ static int bcm2835_pinctrl_probe(struct platform_device *pdev)
 	for (i = 0; i < BCM2835_NUM_IRQS; i++) {
 		pc->irq[i] = irq_of_parse_and_map(np, i);
 		pc->irq_group[i] = i;
+
+		if (pc->irq[i] == 0)
+			continue;
+
 		/*
 		 * Use the same handler for all groups: this is necessary
 		 * since we use one gpiochip to cover all lines - the
-- 
2.7.4
