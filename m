From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Mon, 1 Mar 2010 15:04:27 +0530
Subject: [PATCH 2/5] nomadik-gpio: fix spinlock usage
In-Reply-To: <1267436070-10631-1-git-send-email-rabin.vincent@stericsson.com>
References: <1267436070-10631-1-git-send-email-rabin.vincent@stericsson.com>
Message-ID: <1267436070-10631-3-git-send-email-rabin.vincent@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the incorrect spinlock usage which leads to these compiler warnings:

arch/arm/plat-nomadik/gpio.c:60: warning: passing argument 1 of `spinlock_check' from incompatible pointer type
arch/arm/plat-nomadik/gpio.c:69: warning: passing argument 1 of `spin_unlock_irqrestore' from incompatible pointer type

Acked-by: Alessandro Rubini <rubini@unipv.it>
Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 arch/arm/plat-nomadik/gpio.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-nomadik/gpio.c b/arch/arm/plat-nomadik/gpio.c
index 9a09b27..a9ee988 100644
--- a/arch/arm/plat-nomadik/gpio.c
+++ b/arch/arm/plat-nomadik/gpio.c
@@ -36,7 +36,7 @@ struct nmk_gpio_chip {
 	struct gpio_chip chip;
 	void __iomem *addr;
 	unsigned int parent_irq;
-	spinlock_t *lock;
+	spinlock_t lock;
 	/* Keep track of configured edges */
 	u32 edge_rising;
 	u32 edge_falling;
@@ -321,6 +321,7 @@ static int __init nmk_gpio_probe(struct amba_device *dev, struct amba_id *id)
 	nmk_chip->addr = io_p2v(dev->res.start);
 	nmk_chip->chip = nmk_gpio_template;
 	nmk_chip->parent_irq = pdata->parent_irq;
+	spin_lock_init(&nmk_chip->lock);
 
 	chip = &nmk_chip->chip;
 	chip->base = pdata->first_gpio;
-- 
1.7.0
