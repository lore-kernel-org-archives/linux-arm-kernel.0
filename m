From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 22 Jan 2014 14:31:07 +0100
Subject: [PATCH 1/5] irqchip: vic: update the base IRQ member correctly
In-Reply-To: <1390397471-6802-1-git-send-email-linus.walleij@linaro.org>
References: <1390397471-6802-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1390397471-6802-2-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When passing 0 as the irq base the VIC driver will dynamically
allocate a number of consecutive interrupt descriptors at some
available number range. Make sure this number is recorded in
the state container rather than the passed-in zero argument
in this case.

Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
tglx: if you're happy with this pls ACK it so I can take this
through the ARM SoC tree.
---
 drivers/irqchip/irq-vic.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-vic.c b/drivers/irqchip/irq-vic.c
index 8e21ae0bab46..70108c1491bc 100644
--- a/drivers/irqchip/irq-vic.c
+++ b/drivers/irqchip/irq-vic.c
@@ -273,7 +273,6 @@ static void __init vic_register(void __iomem *base, unsigned int irq,
 	v->base = base;
 	v->valid_sources = valid_sources;
 	v->resume_sources = resume_sources;
-	v->irq = irq;
 	set_handle_irq(vic_handle_irq);
 	vic_id++;
 	v->domain = irq_domain_add_simple(node, fls(valid_sources), irq,
@@ -282,6 +281,11 @@ static void __init vic_register(void __iomem *base, unsigned int irq,
 	for (i = 0; i < fls(valid_sources); i++)
 		if (valid_sources & (1 << i))
 			irq_create_mapping(v->domain, i);
+	/* If no base IRQ was passed, figure out our allocated base */
+	if (irq)
+		v->irq = irq;
+	else
+		v->irq = irq_find_mapping(v->domain, 0);
 }
 
 static void vic_ack_irq(struct irq_data *d)
-- 
1.8.4.2
