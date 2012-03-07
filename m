From: tarun.kanti@ti.com (Tarun Kanti DebBarma)
Date: Wed, 7 Mar 2012 16:45:55 +0530
Subject: [PATCH v3 05/13] gpio/omap: get rid of retrigger variable in
 gpio_irq_handler
In-Reply-To: <1331118963-26364-1-git-send-email-tarun.kanti@ti.com>
References: <1331118963-26364-1-git-send-email-tarun.kanti@ti.com>
Message-ID: <1331118963-26364-6-git-send-email-tarun.kanti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This local variable is just assigned zero and then OR'ed
with isr. It does not appear to serve any purpose and so
removing it.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Felipe Balbi <balbi@ti.com>
---
 drivers/gpio/gpio-omap.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 3765654..de5fe8f 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -626,7 +626,6 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 	u32 isr;
 	unsigned int gpio_irq, gpio_index;
 	struct gpio_bank *bank;
-	u32 retrigger = 0;
 	int unmasked = 0;
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 
@@ -663,8 +662,6 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 			chained_irq_exit(chip, desc);
 		}
 
-		isr |= retrigger;
-		retrigger = 0;
 		if (!isr)
 			break;
 
-- 
1.7.0.4
