From: tony@atomide.com (Tony Lindgren)
Date: Tue, 02 Feb 2010 18:25:55 -0800
Subject: [PATCH 1/9] omap: define _toggle_gpio_edge_triggering only for OMAP1
In-Reply-To: <20100203022318.26347.34734.stgit@baageli.muru.com>
References: <20100203022318.26347.34734.stgit@baageli.muru.com>
Message-ID: <20100203022555.26347.62876.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

The only usage of _toggle_gpio_edge_triggering is in an
CONFIG_ARCH_OMAP1 is defined, too.

This fixes a compiler warning:

	arch/arm/plat-omap/gpio.c:758: warning: '_toggle_gpio_edge_triggering' defined but not used

when compiling for ARCH_OMAP2, ARCH_OMAP3 or ARCH_OMAP4.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/gpio.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index d17620c..d2422c7 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -750,6 +750,7 @@ static inline void set_24xx_gpio_triggering(struct gpio_bank *bank, int gpio,
 }
 #endif
 
+#ifdef CONFIG_ARCH_OMAP1
 /*
  * This only applies to chips that can't do both rising and falling edge
  * detection at once.  For all other chips, this function is a noop.
@@ -760,11 +761,9 @@ static void _toggle_gpio_edge_triggering(struct gpio_bank *bank, int gpio)
 	u32 l = 0;
 
 	switch (bank->method) {
-#ifdef CONFIG_ARCH_OMAP1
 	case METHOD_MPUIO:
 		reg += OMAP_MPUIO_GPIO_INT_EDGE;
 		break;
-#endif
 #ifdef CONFIG_ARCH_OMAP15XX
 	case METHOD_GPIO_1510:
 		reg += OMAP1510_GPIO_INT_CONTROL;
@@ -787,6 +786,7 @@ static void _toggle_gpio_edge_triggering(struct gpio_bank *bank, int gpio)
 
 	__raw_writel(l, reg);
 }
+#endif
 
 static int _set_gpio_triggering(struct gpio_bank *bank, int gpio, int trigger)
 {
