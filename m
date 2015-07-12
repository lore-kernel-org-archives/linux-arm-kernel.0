From: robh@kernel.org (Rob Herring)
Date: Sun, 12 Jul 2015 09:26:42 -0500
Subject: [PATCH v2 04/13] gpio: kill off set_irq_flags usage
In-Reply-To: <1436711211-18223-1-git-send-email-robh@kernel.org>
References: <1436711211-18223-1-git-send-email-robh@kernel.org>
Message-ID: <1436711211-18223-5-git-send-email-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

set_irq_flags is ARM specific with custom flags which have genirq
equivalents. Convert drivers to use the genirq interfaces directly, so we
can kill off set_irq_flags. The translation of flags is as follows:

IRQF_VALID -> !IRQ_NOREQUEST
IRQF_PROBE -> !IRQ_NOPROBE
IRQF_NOAUTOEN -> IRQ_NOAUTOEN

For IRQs managed by an irqdomain, the irqdomain core code handles clearing
and setting IRQ_NOREQUEST already, so there is no need to do this in
.map() functions and we can simply remove the set_irq_flags calls. Some
users also set IRQ_NOPROBE and this has been maintained although it is not
clear that is really needed. There appears to be a great deal of blind
copy and paste of this code.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-gpio at vger.kernel.org
Cc: bcm-kernel-feedback-list at broadcom.com
Cc: linux-tegra at vger.kernel.org
---
 drivers/gpio/gpio-adp5588.c    | 10 +---------
 drivers/gpio/gpio-bcm-kona.c   | 15 ---------------
 drivers/gpio/gpio-davinci.c    |  1 -
 drivers/gpio/gpio-em.c         |  1 -
 drivers/gpio/gpio-ep93xx.c     |  2 +-
 drivers/gpio/gpio-grgpio.c     |  8 --------
 drivers/gpio/gpio-mcp23s08.c   |  4 ----
 drivers/gpio/gpio-msm-v2.c     |  1 -
 drivers/gpio/gpio-pxa.c        |  8 ++++----
 drivers/gpio/gpio-sa1100.c     |  2 +-
 drivers/gpio/gpio-sta2x11.c    |  2 +-
 drivers/gpio/gpio-tegra.c      |  1 -
 drivers/gpio/gpio-timberdale.c |  4 +---
 drivers/gpio/gpiolib.c         |  8 +-------
 14 files changed, 10 insertions(+), 57 deletions(-)

diff --git a/drivers/gpio/gpio-adp5588.c b/drivers/gpio/gpio-adp5588.c
index d3fe6a6..df7bb75 100644
--- a/drivers/gpio/gpio-adp5588.c
+++ b/drivers/gpio/gpio-adp5588.c
@@ -305,15 +305,7 @@ static int adp5588_irq_setup(struct adp5588_gpio *dev)
 		irq_set_chip_and_handler(irq, &adp5588_irq_chip,
 					 handle_level_irq);
 		irq_set_nested_thread(irq, 1);
-#ifdef CONFIG_ARM
-		/*
-		 * ARM needs us to explicitly flag the IRQ as VALID,
-		 * once we do so, it will also set the noprobe.
-		 */
-		set_irq_flags(irq, IRQF_VALID);
-#else
-		irq_set_noprobe(irq);
-#endif
+		irq_clear_status_flags(irq, IRQ_NOREQUEST | IRQ_NOPROBE);
 	}
 
 	ret = request_threaded_irq(client->irq,
diff --git a/drivers/gpio/gpio-bcm-kona.c b/drivers/gpio/gpio-bcm-kona.c
index 40343fa..af20bda 100644
--- a/drivers/gpio/gpio-bcm-kona.c
+++ b/drivers/gpio/gpio-bcm-kona.c
@@ -525,11 +525,7 @@ static int bcm_kona_gpio_irq_map(struct irq_domain *d, unsigned int irq,
 		return ret;
 	irq_set_lockdep_class(irq, &gpio_lock_class);
 	irq_set_chip_and_handler(irq, &bcm_gpio_irq_chip, handle_simple_irq);
-#ifdef CONFIG_ARM
-	set_irq_flags(irq, IRQF_VALID);
-#else
 	irq_set_noprobe(irq);
-#endif
 
 	return 0;
 }
@@ -644,17 +640,6 @@ static int bcm_kona_gpio_probe(struct platform_device *pdev)
 		dev_err(dev, "Couldn't add GPIO chip -- %d\n", ret);
 		goto err_irq_domain;
 	}
-	for (i = 0; i < chip->ngpio; i++) {
-		int irq = bcm_kona_gpio_to_irq(chip, i);
-		irq_set_lockdep_class(irq, &gpio_lock_class);
-		irq_set_chip_and_handler(irq, &bcm_gpio_irq_chip,
-					 handle_simple_irq);
-#ifdef CONFIG_ARM
-		set_irq_flags(irq, IRQF_VALID);
-#else
-		irq_set_noprobe(irq);
-#endif
-	}
 	for (i = 0; i < kona_gpio->num_bank; i++) {
 		bank = &kona_gpio->banks[i];
 		irq_set_chained_handler_and_data(bank->irq,
diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
index c5e05c8..59020a6 100644
--- a/drivers/gpio/gpio-davinci.c
+++ b/drivers/gpio/gpio-davinci.c
@@ -422,7 +422,6 @@ davinci_gpio_irq_map(struct irq_domain *d, unsigned int irq,
 	irq_set_irq_type(irq, IRQ_TYPE_NONE);
 	irq_set_chip_data(irq, (__force void *)g);
 	irq_set_handler_data(irq, (void *)__gpio_mask(hw));
-	set_irq_flags(irq, IRQF_VALID);
 
 	return 0;
 }
diff --git a/drivers/gpio/gpio-em.c b/drivers/gpio/gpio-em.c
index fbf2873..d42b166 100644
--- a/drivers/gpio/gpio-em.c
+++ b/drivers/gpio/gpio-em.c
@@ -262,7 +262,6 @@ static int em_gio_irq_domain_map(struct irq_domain *h, unsigned int irq,
 
 	irq_set_chip_data(irq, h->host_data);
 	irq_set_chip_and_handler(irq, &p->irq_chip, handle_level_irq);
-	set_irq_flags(irq, IRQF_VALID); /* kill me now */
 	return 0;
 }
 
diff --git a/drivers/gpio/gpio-ep93xx.c b/drivers/gpio/gpio-ep93xx.c
index 45684f3..4d35fdc 100644
--- a/drivers/gpio/gpio-ep93xx.c
+++ b/drivers/gpio/gpio-ep93xx.c
@@ -234,7 +234,7 @@ static void ep93xx_gpio_init_irq(void)
 	     gpio_irq <= gpio_to_irq(EP93XX_GPIO_LINE_MAX_IRQ); ++gpio_irq) {
 		irq_set_chip_and_handler(gpio_irq, &ep93xx_gpio_irq_chip,
 					 handle_level_irq);
-		set_irq_flags(gpio_irq, IRQF_VALID);
+		irq_clear_status_flags(gpio_irq, IRQ_NOREQUEST);
 	}
 
 	irq_set_chained_handler(IRQ_EP93XX_GPIO_AB,
diff --git a/drivers/gpio/gpio-grgpio.c b/drivers/gpio/gpio-grgpio.c
index 0a8f761..77053d6 100644
--- a/drivers/gpio/gpio-grgpio.c
+++ b/drivers/gpio/gpio-grgpio.c
@@ -281,12 +281,7 @@ static int grgpio_irq_map(struct irq_domain *d, unsigned int irq,
 	irq_set_chip_data(irq, priv);
 	irq_set_chip_and_handler(irq, &grgpio_irq_chip,
 				 handle_simple_irq);
-	irq_clear_status_flags(irq, IRQ_NOREQUEST);
-#ifdef CONFIG_ARM
-	set_irq_flags(irq, IRQF_VALID);
-#else
 	irq_set_noprobe(irq);
-#endif
 
 	return ret;
 }
@@ -301,9 +296,6 @@ static void grgpio_irq_unmap(struct irq_domain *d, unsigned int irq)
 	int ngpio = priv->bgc.gc.ngpio;
 	int i;
 
-#ifdef CONFIG_ARM
-	set_irq_flags(irq, 0);
-#endif
 	irq_set_chip_and_handler(irq, NULL, NULL);
 	irq_set_chip_data(irq, NULL);
 
diff --git a/drivers/gpio/gpio-mcp23s08.c b/drivers/gpio/gpio-mcp23s08.c
index 2fc7ff8..73db7ec 100644
--- a/drivers/gpio/gpio-mcp23s08.c
+++ b/drivers/gpio/gpio-mcp23s08.c
@@ -507,11 +507,7 @@ static int mcp23s08_irq_setup(struct mcp23s08 *mcp)
 		irq_set_chip_data(irq, mcp);
 		irq_set_chip(irq, &mcp23s08_irq_chip);
 		irq_set_nested_thread(irq, true);
-#ifdef CONFIG_ARM
-		set_irq_flags(irq, IRQF_VALID);
-#else
 		irq_set_noprobe(irq);
-#endif
 	}
 	return 0;
 }
diff --git a/drivers/gpio/gpio-msm-v2.c b/drivers/gpio/gpio-msm-v2.c
index 52ff182..4bbaeb36 100644
--- a/drivers/gpio/gpio-msm-v2.c
+++ b/drivers/gpio/gpio-msm-v2.c
@@ -363,7 +363,6 @@ static int msm_gpio_irq_domain_map(struct irq_domain *d, unsigned int irq,
 	irq_set_lockdep_class(irq, &msm_gpio_lock_class);
 	irq_set_chip_and_handler(irq, &msm_gpio_irq_chip,
 			handle_level_irq);
-	set_irq_flags(irq, IRQF_VALID);
 
 	return 0;
 }
diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index cdbbcf0..55a11de 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -524,7 +524,7 @@ static int pxa_irq_domain_map(struct irq_domain *d, unsigned int irq,
 {
 	irq_set_chip_and_handler(irq, &pxa_muxed_gpio_chip,
 				 handle_edge_irq);
-	set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
+	irq_set_noprobe(irq);
 	return 0;
 }
 
@@ -643,20 +643,20 @@ static int pxa_gpio_probe(struct platform_device *pdev)
 			irq = gpio_to_irq(0);
 			irq_set_chip_and_handler(irq, &pxa_muxed_gpio_chip,
 						 handle_edge_irq);
-			set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
+			irq_clear_status_flags(irq, IRQ_NOREQUEST | IRQ_NOPROBE);
 		}
 		if (irq1 > 0) {
 			irq = gpio_to_irq(1);
 			irq_set_chip_and_handler(irq, &pxa_muxed_gpio_chip,
 						 handle_edge_irq);
-			set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
+			irq_clear_status_flags(irq, IRQ_NOREQUEST | IRQ_NOPROBE);
 		}
 
 		for (irq  = gpio_to_irq(gpio_offset);
 			irq <= gpio_to_irq(pxa_last_gpio); irq++) {
 			irq_set_chip_and_handler(irq, &pxa_muxed_gpio_chip,
 						 handle_edge_irq);
-			set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
+			irq_clear_status_flags(irq, IRQ_NOREQUEST | IRQ_NOPROBE);
 		}
 	}
 
diff --git a/drivers/gpio/gpio-sa1100.c b/drivers/gpio/gpio-sa1100.c
index 3fa22da..1aaa340 100644
--- a/drivers/gpio/gpio-sa1100.c
+++ b/drivers/gpio/gpio-sa1100.c
@@ -155,7 +155,7 @@ static int sa1100_gpio_irqdomain_map(struct irq_domain *d,
 {
 	irq_set_chip_and_handler(irq, &sa1100_gpio_irq_chip,
 				 handle_edge_irq);
-	set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
+	irq_set_noprobe(irq);
 
 	return 0;
 }
diff --git a/drivers/gpio/gpio-sta2x11.c b/drivers/gpio/gpio-sta2x11.c
index 18579ac..55e47828 100644
--- a/drivers/gpio/gpio-sta2x11.c
+++ b/drivers/gpio/gpio-sta2x11.c
@@ -346,7 +346,7 @@ static void gsta_alloc_irq_chip(struct gsta_gpio *chip)
 			i = chip->irq_base + j;
 			irq_set_chip_and_handler(i, &ct->chip, ct->handler);
 			irq_set_chip_data(i, gc);
-			irq_modify_status(i, IRQ_NOREQUEST | IRQ_NOPROBE, 0);
+			irq_clear_status_flags(i, IRQ_NOREQUEST | IRQ_NOPROBE);
 		}
 		gc->irq_cnt = i - gc->irq_base;
 	}
diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
index 9b25c90..5b9163c 100644
--- a/drivers/gpio/gpio-tegra.c
+++ b/drivers/gpio/gpio-tegra.c
@@ -509,7 +509,6 @@ static int tegra_gpio_probe(struct platform_device *pdev)
 		irq_set_chip_data(irq, bank);
 		irq_set_chip_and_handler(irq, &tegra_gpio_irq_chip,
 					 handle_simple_irq);
-		set_irq_flags(irq, IRQF_VALID);
 	}
 
 	for (i = 0; i < tegra_gpio_bank_count; i++) {
diff --git a/drivers/gpio/gpio-timberdale.c b/drivers/gpio/gpio-timberdale.c
index e8f97e0..166fe1c 100644
--- a/drivers/gpio/gpio-timberdale.c
+++ b/drivers/gpio/gpio-timberdale.c
@@ -294,9 +294,7 @@ static int timbgpio_probe(struct platform_device *pdev)
 		irq_set_chip_and_handler(tgpio->irq_base + i,
 			&timbgpio_irqchip, handle_simple_irq);
 		irq_set_chip_data(tgpio->irq_base + i, tgpio);
-#ifdef CONFIG_ARM
-		set_irq_flags(tgpio->irq_base + i, IRQF_VALID | IRQF_PROBE);
-#endif
+		irq_clear_status_flags(tgpio->irq_base + i, IRQ_NOREQUEST | IRQ_NOPROBE);
 	}
 
 	irq_set_handler_data(irq, tgpio);
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index bf4bd1d..5af50d3 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -483,11 +483,8 @@ static int gpiochip_irq_map(struct irq_domain *d, unsigned int irq,
 	/* Chips that can sleep need nested thread handlers */
 	if (chip->can_sleep && !chip->irq_not_threaded)
 		irq_set_nested_thread(irq, 1);
-#ifdef CONFIG_ARM
-	set_irq_flags(irq, IRQF_VALID);
-#else
 	irq_set_noprobe(irq);
-#endif
+
 	/*
 	 * No set-up of the hardware will happen if IRQ_TYPE_NONE
 	 * is passed as default type.
@@ -502,9 +499,6 @@ static void gpiochip_irq_unmap(struct irq_domain *d, unsigned int irq)
 {
 	struct gpio_chip *chip = d->host_data;
 
-#ifdef CONFIG_ARM
-	set_irq_flags(irq, 0);
-#endif
 	if (chip->can_sleep)
 		irq_set_nested_thread(irq, 0);
 	irq_set_chip_and_handler(irq, NULL, NULL);
-- 
2.1.0
