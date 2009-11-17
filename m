From: giometti@linux.it (Rodolfo Giometti)
Date: Tue, 17 Nov 2009 12:21:46 +0100
Subject: [PATCH] arm pxa: remove "direction input" forcing for IRQ GPIOs
Message-ID: <1258456906-12338-1-git-send-email-giometti@linux.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PXA CPUs may use their GPIOs as IRQ lines even if they are selected as
outputs (see for example figure 24-1 into PXA27x Processor Family
Developer's Manual). So forcing GPIOs IRQ lines as inputs is not
correct.

Programmers should set up GPIOs direction according to their usage and
the function pxa_gpio_irq_type() should simply enable the IRQ
detection.

Signed-off-by: Rodolfo Giometti <giometti@linux.it>
Cc: raffaele.recalcati at bticino.it
---
 arch/arm/plat-pxa/gpio.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/arch/arm/plat-pxa/gpio.c b/arch/arm/plat-pxa/gpio.c
index 98548c6..3f17221 100644
--- a/arch/arm/plat-pxa/gpio.c
+++ b/arch/arm/plat-pxa/gpio.c
@@ -176,13 +176,6 @@ static int pxa_gpio_irq_type(unsigned int irq, unsigned int type)
 		type = IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING;
 	}
 
-	gpdr = __raw_readl(c->regbase + GPDR_OFFSET);
-
-	if (__gpio_is_inverted(gpio))
-		__raw_writel(gpdr | mask,  c->regbase + GPDR_OFFSET);
-	else
-		__raw_writel(gpdr & ~mask, c->regbase + GPDR_OFFSET);
-
 	if (type & IRQ_TYPE_EDGE_RISING)
 		c->irq_edge_rise |= mask;
 	else
-- 
1.6.3.3
