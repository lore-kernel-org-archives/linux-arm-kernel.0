From: will.deacon@arm.com (Will Deacon)
Date: Tue,  8 Mar 2011 17:13:24 +0000
Subject: [PATCH 6/7] ARM: nmk: update GPIO chained IRQ handler to entry/exit
	functions
In-Reply-To: <1299604405-12960-1-git-send-email-will.deacon@arm.com>
References: <1299604405-12960-1-git-send-email-will.deacon@arm.com>
Message-ID: <1299604405-12960-7-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates the Nomadik gpio chained IRQ handler to use the
chained IRQ enter/exit functions in order to function correctly on
primary controllers with different methods of flow control.

Cc: Rabin Vincent <rabin@rab.in>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/plat-nomadik/gpio.c |   10 ++--------
 1 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/arm/plat-nomadik/gpio.c b/arch/arm/plat-nomadik/gpio.c
index 1e88ecb..f4e80c9 100644
--- a/arch/arm/plat-nomadik/gpio.c
+++ b/arch/arm/plat-nomadik/gpio.c
@@ -522,13 +522,7 @@ static void nmk_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 	u32 pending;
 	unsigned int first_irq;
 
-	if (host_chip->irq_mask_ack)
-		host_chip->irq_mask_ack(&desc->irq_data);
-	else {
-		host_chip->irq_mask(&desc->irq_data);
-		if (host_chip->irq_ack)
-			host_chip->irq_ack(&desc->irq_data);
-	}
+	chained_irq_enter(host_chip, desc);
 
 	nmk_chip = get_irq_data(irq);
 	first_irq = NOMADIK_GPIO_TO_IRQ(nmk_chip->chip.base);
@@ -537,7 +531,7 @@ static void nmk_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 		generic_handle_irq(gpio_irq);
 	}
 
-	host_chip->irq_unmask(&desc->irq_data);
+	chained_irq_exit(host_chip, desc);
 }
 
 static int nmk_gpio_init_irq(struct nmk_gpio_chip *nmk_chip)
-- 
1.7.0.4
