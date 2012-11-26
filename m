From: horms@verge.net.au (Simon Horman)
Date: Mon, 26 Nov 2012 09:16:50 +0900
Subject: [PATCH 3/7] sh: pfc: Allow device tree registration
In-Reply-To: <1353889014-17142-1-git-send-email-horms@verge.net.au>
References: <1353889014-17142-1-git-send-email-horms@verge.net.au>
Message-ID: <1353889014-17142-4-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a crude mechanism to allow the pfc driver to
be registered through device tree. The mofication of this
is to provide a way for pfc gpios to be looked up by
device tree for devices which use pfc gpios.

More specifically, the motivation is to allow the registration
of the card-detect gpio for the Micro-SD SDHI slot of the KZM9G board.

Cc: Paul Mundt <lethal@linux-sh.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 drivers/sh/pfc/gpio.c  |   15 +++++++++++++++
 include/linux/sh_pfc.h |    7 +++++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/sh/pfc/gpio.c b/drivers/sh/pfc/gpio.c
index 038fa07..322b927 100644
--- a/drivers/sh/pfc/gpio.c
+++ b/drivers/sh/pfc/gpio.c
@@ -136,6 +136,19 @@ static void sh_pfc_gpio_setup(struct sh_pfc_chip *chip)
 	gc->ngpio = (pfc->last_gpio - pfc->first_gpio) + 1;
 }
 
+#ifdef CONFIG_OF_GPIO
+static void
+sh_pfc_register_gpiochip_dt(struct sh_pfc *pfc, struct gpio_chip *chip)
+{
+	chip->of_node = pfc->of_node;
+	chip->of_gpio_n_cells = pfc->of_gpio_n_cells;
+	chip->of_xlate = pfc->of_xlate;
+}
+#else
+static void sh_pfc_register_gpiochip_dt(struct sh_pfc *pfc,
+					struct gpio_chip *chip) {}
+#endif
+
 int sh_pfc_register_gpiochip(struct sh_pfc *pfc)
 {
 	struct sh_pfc_chip *chip;
@@ -153,6 +166,8 @@ int sh_pfc_register_gpiochip(struct sh_pfc *pfc)
 	if (unlikely(ret < 0))
 		kfree(chip);
 
+	sh_pfc_register_gpiochip_dt(pfc, &chip->gpio_chip);
+
 	pr_info("%s handling gpio %d -> %d\n",
 		pfc->name, pfc->first_gpio, pfc->last_gpio);
 
diff --git a/include/linux/sh_pfc.h b/include/linux/sh_pfc.h
index c19a092..9963370 100644
--- a/include/linux/sh_pfc.h
+++ b/include/linux/sh_pfc.h
@@ -124,6 +124,13 @@ struct sh_pfc {
 	struct pfc_window *window;
 
 	unsigned long unlock_reg;
+
+#ifdef CONFIG_OF_GPIO
+	struct device_node *of_node;
+	int of_gpio_n_cells;
+	int (*of_xlate)(struct gpio_chip *gc,
+		        const struct of_phandle_args *gpiospec, u32 *flags);
+#endif
 };
 
 /* XXX compat for now */
-- 
1.7.10.4
