From: will.deacon@arm.com (Will Deacon)
Date: Fri,  1 Apr 2011 15:50:40 +0100
Subject: [PATCH 5/6] ARM: nmk: update GPIO chained IRQ handler to entry/exit
	functions
In-Reply-To: <1301669441-13744-1-git-send-email-will.deacon@arm.com>
References: <1301669441-13744-1-git-send-email-will.deacon@arm.com>
Message-ID: <1301669441-13744-6-git-send-email-will.deacon@arm.com>
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
index f49748e..025a54c 100644
--- a/arch/arm/plat-nomadik/gpio.c
+++ b/arch/arm/plat-nomadik/gpio.c
@@ -681,13 +681,7 @@ static void __nmk_gpio_irq_handler(unsigned int irq, struct irq_desc *desc,
 	struct irq_chip *host_chip = irq_get_chip(irq);
 	unsigned int first_irq;
 
-	if (host_chip->irq_mask_ack)
-		host_chip->irq_mask_ack(&desc->irq_data);
-	else {
-		host_chip->irq_mask(&desc->irq_data);
-		if (host_chip->irq_ack)
-			host_chip->irq_ack(&desc->irq_data);
-	}
+	chained_irq_enter(host_chip, desc);
 
 	nmk_chip = irq_get_handler_data(irq);
 	first_irq = NOMADIK_GPIO_TO_IRQ(nmk_chip->chip.base);
@@ -698,7 +692,7 @@ static void __nmk_gpio_irq_handler(unsigned int irq, struct irq_desc *desc,
 		status &= ~BIT(bit);
 	}
 
-	host_chip->irq_unmask(&desc->irq_data);
+	chained_irq_exit(host_chip, desc);
 }
 
 static void nmk_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
-- 
1.7.0.4
