From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Wed, 23 Jan 2013 16:25:52 +0800
Subject: [PATCH 08/10] gpio: pxa: remove arch related macro
In-Reply-To: <1358929554-32265-1-git-send-email-haojian.zhuang@linaro.org>
References: <1358929554-32265-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1358929554-32265-9-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove macro CONFIG_ARCH_PXA.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 drivers/gpio/gpio-pxa.c |   30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index 5870944..21cf8fd 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -570,21 +570,21 @@ static int pxa_gpio_probe(struct platform_device *pdev)
 	}
 
 	if (!use_of) {
-#ifdef CONFIG_ARCH_PXA
-		irq = gpio_to_irq(0);
-		irq_set_chip_and_handler(irq, &pxa_muxed_gpio_chip,
-					 handle_edge_irq);
-		set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
-		irq_set_chained_handler(IRQ_GPIO0, pxa_gpio_demux_handler);
-
-		irq = gpio_to_irq(1);
-		irq_set_chip_and_handler(irq, &pxa_muxed_gpio_chip,
-					 handle_edge_irq);
-		set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
-		irq_set_chained_handler(IRQ_GPIO1, pxa_gpio_demux_handler);
-#endif
-
-		for (irq  = gpio_to_irq(gpio_offset);
+		if (irq0 > 0) {
+			irq = gpio_to_irq(0);
+			irq_set_chip_and_handler(irq, &pxa_muxed_gpio_chip,
+						 handle_edge_irq);
+			set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
+			irq_set_chained_handler(irq0, pxa_gpio_demux_handler);
+		}
+		if (irq1 > 0) {
+			irq = gpio_to_irq(1);
+			irq_set_chip_and_handler(irq, &pxa_muxed_gpio_chip,
+						 handle_edge_irq);
+			set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
+			irq_set_chained_handler(irq1, pxa_gpio_demux_handler);
+		}
+		for (irq = gpio_to_irq(gpio_offset);
 			irq <= gpio_to_irq(pxa_last_gpio); irq++) {
 			irq_set_chip_and_handler(irq, &pxa_muxed_gpio_chip,
 						 handle_edge_irq);
-- 
1.7.10.4
