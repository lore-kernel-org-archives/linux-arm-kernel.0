From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 31 May 2013 17:59:46 +0200
Subject: [PATCH] gpio/omap: omap_gpio_init_context stub must be inline
Message-ID: <2942784.trumtc2GjZ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The bug fix 352a2d5bf "gpio/omap: ensure gpio context is initialised"
has caused a new warning for omap1_defconfig:

drivers/gpio/gpio-omap.c:1465:13: warning: 'omap_gpio_init_context' defined but not used [-Wunused-function]
 static void omap_gpio_init_context(struct gpio_bank *p) {}
             ^

The solution is to mark the stub function as 'static inline' so
it gets left out of the build when unused.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index d3f7d2d..e5fba65 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1462,7 +1462,7 @@ static void omap_gpio_restore_context(struct gpio_bank *bank)
 #else
 #define omap_gpio_runtime_suspend NULL
 #define omap_gpio_runtime_resume NULL
-static void omap_gpio_init_context(struct gpio_bank *p) {}
+static inline void omap_gpio_init_context(struct gpio_bank *p) {}
 #endif
 
 static const struct dev_pm_ops gpio_pm_ops = {
