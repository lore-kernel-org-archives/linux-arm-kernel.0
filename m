From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Wed, 21 Aug 2013 23:21:47 +0200
Subject: [PATCH v7 3/7] gpio: samsung: Skip initialization if device tree is
 present
In-Reply-To: <1377120111-25601-1-git-send-email-tomasz.figa@gmail.com>
References: <1377120111-25601-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <1377120111-25601-4-git-send-email-tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since this driver does not handle GPIO on device tree enabled platforms
any more, it should be bypassed whenever device tree is available, to
not conflict with the new pinctrl-samsung driver.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 drivers/gpio/gpio-samsung.c | 34 +++++++---------------------------
 1 file changed, 7 insertions(+), 27 deletions(-)

diff --git a/drivers/gpio/gpio-samsung.c b/drivers/gpio/gpio-samsung.c
index a1392f4..cc93b1b 100644
--- a/drivers/gpio/gpio-samsung.c
+++ b/drivers/gpio/gpio-samsung.c
@@ -2949,34 +2949,14 @@ static __init int samsung_gpiolib_init(void)
 	int i, nr_chips;
 	int group = 0;
 
-#if defined(CONFIG_PINCTRL_EXYNOS) || defined(CONFIG_PINCTRL_EXYNOS5440)
 	/*
-	* This gpio driver includes support for device tree support and there
-	* are platforms using it. In order to maintain compatibility with those
-	* platforms, and to allow non-dt Exynos4210 platforms to use this
-	* gpiolib support, a check is added to find out if there is a active
-	* pin-controller driver support available. If it is available, this
-	* gpiolib support is ignored and the gpiolib support available in
-	* pin-controller driver is used. This is a temporary check and will go
-	* away when all of the Exynos4210 platforms have switched to using
-	* device tree and the pin-ctrl driver.
-	*/
-	struct device_node *pctrl_np;
-	static const struct of_device_id exynos_pinctrl_ids[] = {
-		{ .compatible = "samsung,s3c2412-pinctrl", },
-		{ .compatible = "samsung,s3c2416-pinctrl", },
-		{ .compatible = "samsung,s3c2440-pinctrl", },
-		{ .compatible = "samsung,s3c2450-pinctrl", },
-		{ .compatible = "samsung,exynos4210-pinctrl", },
-		{ .compatible = "samsung,exynos4x12-pinctrl", },
-		{ .compatible = "samsung,exynos5250-pinctrl", },
-		{ .compatible = "samsung,exynos5440-pinctrl", },
-		{ }
-	};
-	for_each_matching_node(pctrl_np, exynos_pinctrl_ids)
-		if (pctrl_np && of_device_is_available(pctrl_np))
-			return -ENODEV;
-#endif
+	 * Currently there are two drivers that can provide GPIO support for
+	 * Samsung SoCs. For device tree enabled platforms, the new
+	 * pinctrl-samsung driver is used, providing both GPIO and pin control
+	 * interfaces. For legacy (non-DT) platforms this driver is used.
+	 */
+	if (of_have_populated_dt())
+		return -ENODEV;
 
 	samsung_gpiolib_set_cfg(samsung_gpio_cfgs, ARRAY_SIZE(samsung_gpio_cfgs));
 
-- 
1.8.3.2
