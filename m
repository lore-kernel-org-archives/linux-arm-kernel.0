From: ido@wizery.com (Ido Yariv)
Date: Tue, 12 Jul 2011 00:03:11 +0300
Subject: [PATCH v3 1/6] arm: davinci: Fix low level gpio irq handlers' argument
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024DA7A9DD@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB593024DA7A9DD@dbde02.ent.ti.com>
Message-ID: <1310418191-27009-1-git-send-email-ido@wizery.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 7416401 ("arm: davinci: Fix fallout from generic irq chip
conversion") introduced a bug, causing low level interrupt handlers to
get a bogus irq number as an argument. The gpio irq handler falsely
assumes that the handler data is the irq base number and that is no
longer true.

Set the irq handler data to be a pointer to the corresponding gpio
controller. The chained irq handler can then use it to extract both the
irq base number and the gpio registers structure.

Signed-off-by: Ido Yariv <ido@wizery.com>
CC: Thomas Gleixner <tglx@linutronix.de>
---
 arch/arm/mach-davinci/gpio.c |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-davinci/gpio.c b/arch/arm/mach-davinci/gpio.c
index e722139..7d64a07 100644
--- a/arch/arm/mach-davinci/gpio.c
+++ b/arch/arm/mach-davinci/gpio.c
@@ -254,8 +254,10 @@ gpio_irq_handler(unsigned irq, struct irq_desc *desc)
 {
 	struct davinci_gpio_regs __iomem *g;
 	u32 mask = 0xffff;
+	struct davinci_gpio_controller *ctl;
 
-	g = (__force struct davinci_gpio_regs __iomem *) irq_desc_get_handler_data(desc);
+	ctl = (struct davinci_gpio_controller *)irq_desc_get_handler_data(desc);
+	g = (struct davinci_gpio_regs __iomem *)ctl->regs;
 
 	/* we only care about one bank */
 	if (irq & 1)
@@ -278,7 +280,7 @@ gpio_irq_handler(unsigned irq, struct irq_desc *desc)
 			status >>= 16;
 
 		/* now demux them to the right lowlevel handler */
-		n = (int)irq_get_handler_data(irq);
+		n = ctl->irq_base;
 		while (status) {
 			res = ffs(status);
 			n += res;
@@ -424,7 +426,13 @@ static int __init davinci_gpio_irq_setup(void)
 
 		/* set up all irqs in this bank */
 		irq_set_chained_handler(bank_irq, gpio_irq_handler);
-		irq_set_handler_data(bank_irq, (__force void *)g);
+
+		/*
+		 * Each chip handles 32 gpios, and each irq bank consists of 16
+		 * gpio irqs. Pass the irq bank's corresponding controller to
+		 * the chained irq handler.
+		 */
+		irq_set_handler_data(bank_irq, &chips[bank * 16 / 32]);
 
 		for (i = 0; i < 16 && gpio < ngpio; i++, irq++, gpio++) {
 			irq_set_chip(irq, &gpio_irqchip);
-- 
1.7.4.1
