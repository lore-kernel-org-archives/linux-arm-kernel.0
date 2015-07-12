From: robh@kernel.org (Rob Herring)
Date: Sun, 12 Jul 2015 09:26:48 -0500
Subject: [PATCH v2 10/13] pinctrl: kill off set_irq_flags usage
In-Reply-To: <1436711211-18223-1-git-send-email-robh@kernel.org>
References: <1436711211-18223-1-git-send-email-robh@kernel.org>
Message-ID: <1436711211-18223-11-git-send-email-robh@kernel.org>
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
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Lee Jones <lee@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Thomas Abraham <thomas.abraham@linaro.org>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: linux-gpio at vger.kernel.org
Cc: linux-rpi-kernel at lists.infradead.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-mediatek at lists.infradead.org
Cc: linux-samsung-soc at vger.kernel.org
---
 drivers/pinctrl/bcm/pinctrl-bcm2835.c         | 1 -
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 2 --
 drivers/pinctrl/pinctrl-single.c              | 5 -----
 drivers/pinctrl/samsung/pinctrl-exynos.c      | 1 -
 drivers/pinctrl/samsung/pinctrl-exynos5440.c  | 1 -
 drivers/pinctrl/samsung/pinctrl-s3c24xx.c     | 2 --
 drivers/pinctrl/samsung/pinctrl-s3c64xx.c     | 2 --
 7 files changed, 14 deletions(-)

diff --git a/drivers/pinctrl/bcm/pinctrl-bcm2835.c b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
index efcf2a2..0cfdbb5 100644
--- a/drivers/pinctrl/bcm/pinctrl-bcm2835.c
+++ b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
@@ -987,7 +987,6 @@ static int bcm2835_pinctrl_probe(struct platform_device *pdev)
 		irq_set_chip_and_handler(irq, &bcm2835_gpio_irq_chip,
 				handle_level_irq);
 		irq_set_chip_data(irq, pc);
-		set_irq_flags(irq, IRQF_VALID);
 	}
 
 	for (i = 0; i < BCM2835_NUM_BANKS; i++) {
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index ad1ea16..661677c 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -1348,11 +1348,9 @@ int mtk_pctrl_init(struct platform_device *pdev,
 		irq_set_chip_and_handler(virq, &mtk_pinctrl_irq_chip,
 			handle_level_irq);
 		irq_set_chip_data(virq, pctl);
-		set_irq_flags(virq, IRQF_VALID);
 	};
 
 	irq_set_chained_handler_and_data(irq, mtk_eint_irq_handler, pctl);
-	set_irq_flags(irq, IRQF_VALID);
 	return 0;
 
 chip_error:
diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index b2de09d..d00a990 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -1716,12 +1716,7 @@ static int pcs_irqdomain_map(struct irq_domain *d, unsigned int irq,
 	irq_set_chip_data(irq, pcs_soc);
 	irq_set_chip_and_handler(irq, &pcs->chip,
 				 handle_level_irq);
-
-#ifdef CONFIG_ARM
-	set_irq_flags(irq, IRQF_VALID);
-#else
 	irq_set_noprobe(irq);
-#endif
 
 	return 0;
 }
diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
index b18dabb..0e8add9 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
@@ -256,7 +256,6 @@ static int exynos_eint_irq_map(struct irq_domain *h, unsigned int virq,
 	irq_set_chip_data(virq, b);
 	irq_set_chip_and_handler(virq, &b->irq_chip->chip,
 					handle_level_irq);
-	set_irq_flags(virq, IRQF_VALID);
 	return 0;
 }
 
diff --git a/drivers/pinctrl/samsung/pinctrl-exynos5440.c b/drivers/pinctrl/samsung/pinctrl-exynos5440.c
index f5619fb..e7d1c9e 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos5440.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos5440.c
@@ -929,7 +929,6 @@ static int exynos5440_gpio_irq_map(struct irq_domain *h, unsigned int virq,
 	irq_set_chip_data(virq, d);
 	irq_set_chip_and_handler(virq, &exynos5440_gpio_irq_chip,
 					handle_level_irq);
-	set_irq_flags(virq, IRQF_VALID);
 	return 0;
 }
 
diff --git a/drivers/pinctrl/samsung/pinctrl-s3c24xx.c b/drivers/pinctrl/samsung/pinctrl-s3c24xx.c
index 01b43db..f218be7 100644
--- a/drivers/pinctrl/samsung/pinctrl-s3c24xx.c
+++ b/drivers/pinctrl/samsung/pinctrl-s3c24xx.c
@@ -437,7 +437,6 @@ static int s3c24xx_gpf_irq_map(struct irq_domain *h, unsigned int virq,
 					 handle_edge_irq);
 	}
 	irq_set_chip_data(virq, bank);
-	set_irq_flags(virq, IRQF_VALID);
 	return 0;
 }
 
@@ -457,7 +456,6 @@ static int s3c24xx_gpg_irq_map(struct irq_domain *h, unsigned int virq,
 
 	irq_set_chip_and_handler(virq, &s3c24xx_eint_chip, handle_edge_irq);
 	irq_set_chip_data(virq, bank);
-	set_irq_flags(virq, IRQF_VALID);
 	return 0;
 }
 
diff --git a/drivers/pinctrl/samsung/pinctrl-s3c64xx.c b/drivers/pinctrl/samsung/pinctrl-s3c64xx.c
index ec8cc3b..1a4dd01 100644
--- a/drivers/pinctrl/samsung/pinctrl-s3c64xx.c
+++ b/drivers/pinctrl/samsung/pinctrl-s3c64xx.c
@@ -395,7 +395,6 @@ static int s3c64xx_gpio_irq_map(struct irq_domain *h, unsigned int virq,
 	irq_set_chip_and_handler(virq,
 				&s3c64xx_gpio_irq_chip, handle_level_irq);
 	irq_set_chip_data(virq, bank);
-	set_irq_flags(virq, IRQF_VALID);
 
 	return 0;
 }
@@ -673,7 +672,6 @@ static int s3c64xx_eint0_irq_map(struct irq_domain *h, unsigned int virq,
 	irq_set_chip_and_handler(virq,
 				&s3c64xx_eint0_irq_chip, handle_level_irq);
 	irq_set_chip_data(virq, ddata);
-	set_irq_flags(virq, IRQF_VALID);
 
 	return 0;
 }
-- 
2.1.0
