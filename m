From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Tue, 19 Sep 2017 21:04:56 +0200
Subject: [PATCH] pinctrl: bcm2835: fix build warning in
 bcm2835_gpio_irq_handle_bank
Message-ID: <20170919190456.26522-1-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fix the following build warning:
drivers/pinctrl/bcm/pinctrl-bcm2835.c:376:15: warning: variable 'type' set but not used [-Wunused-but-set-variable]

Furthermore, it is unused for a long time, at least since commit 85ae9e512f43 ("pinctrl: bcm2835: switch to GPIOLIB_IRQCHIP")
where a "FIXME no clue why the code looks up the type here" was added.
A year after, nobody answeered this question, so its time to remove it.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 drivers/pinctrl/bcm/pinctrl-bcm2835.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/pinctrl/bcm/pinctrl-bcm2835.c b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
index 0944310225db..ff782445dfb7 100644
--- a/drivers/pinctrl/bcm/pinctrl-bcm2835.c
+++ b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
@@ -373,16 +373,12 @@ static void bcm2835_gpio_irq_handle_bank(struct bcm2835_pinctrl *pc,
 	unsigned long events;
 	unsigned offset;
 	unsigned gpio;
-	unsigned int type;
 
 	events = bcm2835_gpio_rd(pc, GPEDS0 + bank * 4);
 	events &= mask;
 	events &= pc->enabled_irq_map[bank];
 	for_each_set_bit(offset, &events, 32) {
 		gpio = (32 * bank) + offset;
-		/* FIXME: no clue why the code looks up the type here */
-		type = pc->irq_type[gpio];
-
 		generic_handle_irq(irq_linear_revmap(pc->gpio_chip.irqdomain,
 						     gpio));
 	}
-- 
2.13.5
