From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 25 Jan 2013 22:44:11 +0000
Subject: [PATCH 12/19] pinctrl: exynos: don't mark probing functions as __init
In-Reply-To: <1359153858-31992-1-git-send-email-arnd@arndb.de>
References: <1359123276-15833-1-git-send-email-arnd@arndb.de>
 <1359153858-31992-1-git-send-email-arnd@arndb.de>
Message-ID: <1359153858-31992-13-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Functions called from a driver probe() method must not be
marked __init, because they may get called after the
init phase is done, when the device shows up late, or
because of deferred probing.

Without this patch, building exynos_defconfig results in
multiple warnings like:

WARNING: drivers/pinctrl/built-in.o(.text+0x51bc): Section mismatch in reference from the function exynos5440_pinctrl_probe() to the function .init.text:exynos5440_gpiolib_register()
The function exynos5440_pinctrl_probe() references
the function __init exynos5440_gpiolib_register().
This is often because exynos5440_pinctrl_probe lacks a __init
annotation or the annotation of exynos5440_gpiolib_register is wrong.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Tomasz Figa <t.figa@samsung.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>
---
 drivers/pinctrl/pinctrl-exynos5440.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-exynos5440.c b/drivers/pinctrl/pinctrl-exynos5440.c
index de05b64..1427299 100644
--- a/drivers/pinctrl/pinctrl-exynos5440.c
+++ b/drivers/pinctrl/pinctrl-exynos5440.c
@@ -599,7 +599,7 @@ static int exynos5440_gpio_direction_output(struct gpio_chip *gc, unsigned offse
 }
 
 /* parse the pin numbers listed in the 'samsung,exynos5440-pins' property */
-static int __init exynos5440_pinctrl_parse_dt_pins(struct platform_device *pdev,
+static int exynos5440_pinctrl_parse_dt_pins(struct platform_device *pdev,
 			struct device_node *cfg_np, unsigned int **pin_list,
 			unsigned int *npins)
 {
@@ -630,7 +630,7 @@ static int __init exynos5440_pinctrl_parse_dt_pins(struct platform_device *pdev,
  * Parse the information about all the available pin groups and pin functions
  * from device node of the pin-controller.
  */
-static int __init exynos5440_pinctrl_parse_dt(struct platform_device *pdev,
+static int exynos5440_pinctrl_parse_dt(struct platform_device *pdev,
 				struct exynos5440_pinctrl_priv_data *priv)
 {
 	struct device *dev = &pdev->dev;
@@ -723,7 +723,7 @@ static int __init exynos5440_pinctrl_parse_dt(struct platform_device *pdev,
 }
 
 /* register the pinctrl interface with the pinctrl subsystem */
-static int __init exynos5440_pinctrl_register(struct platform_device *pdev,
+static int exynos5440_pinctrl_register(struct platform_device *pdev,
 				struct exynos5440_pinctrl_priv_data *priv)
 {
 	struct device *dev = &pdev->dev;
@@ -798,7 +798,7 @@ static int __init exynos5440_pinctrl_register(struct platform_device *pdev,
 }
 
 /* register the gpiolib interface with the gpiolib subsystem */
-static int __init exynos5440_gpiolib_register(struct platform_device *pdev,
+static int exynos5440_gpiolib_register(struct platform_device *pdev,
 				struct exynos5440_pinctrl_priv_data *priv)
 {
 	struct gpio_chip *gc;
@@ -831,7 +831,7 @@ static int __init exynos5440_gpiolib_register(struct platform_device *pdev,
 }
 
 /* unregister the gpiolib interface with the gpiolib subsystem */
-static int __init exynos5440_gpiolib_unregister(struct platform_device *pdev,
+static int exynos5440_gpiolib_unregister(struct platform_device *pdev,
 				struct exynos5440_pinctrl_priv_data *priv)
 {
 	int ret = gpiochip_remove(priv->gc);
-- 
1.8.0
