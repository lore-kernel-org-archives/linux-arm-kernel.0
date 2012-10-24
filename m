From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 24 Oct 2012 16:37:35 +0200
Subject: [PATCH 2/4] gpio: samsung: Skip registration if pinctrl driver is
 present on Exynos4x12
In-Reply-To: <1351089457-8205-1-git-send-email-t.figa@samsung.com>
References: <1351089457-8205-1-git-send-email-t.figa@samsung.com>
Message-ID: <1351089457-8205-3-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch modifies the Samsung GPIO driver to check for pinctrl driver
presence earlier and use generic matching instead of a single compatible
value.

This allows us to fix warning about unrecognized SoC in case of
Exynos4x12, which is not supported by this driver.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/gpio/gpio-samsung.c | 43 ++++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/gpio/gpio-samsung.c b/drivers/gpio/gpio-samsung.c
index 43c4595..01f7fe9 100644
--- a/drivers/gpio/gpio-samsung.c
+++ b/drivers/gpio/gpio-samsung.c
@@ -2796,27 +2796,6 @@ static __init void exynos4_gpiolib_init(void)
 	int group = 0;
 	void __iomem *gpx_base;
 
-#ifdef CONFIG_PINCTRL_SAMSUNG
-		/*
-		 * This gpio driver includes support for device tree support and
-		 * there are platforms using it. In order to maintain
-		 * compatibility with those platforms, and to allow non-dt
-		 * Exynos4210 platforms to use this gpiolib support, a check
-		 * is added to find out if there is a active pin-controller
-		 * driver support available. If it is available, this gpiolib
-		 * support is ignored and the gpiolib support available in
-		 * pin-controller driver is used. This is a temporary check and
-		 * will go away when all of the Exynos4210 platforms have
-		 * switched to using device tree and the pin-ctrl driver.
-		 */
-		struct device_node *pctrl_np;
-		const char *pctrl_compat = "samsung,pinctrl-exynos4210";
-		pctrl_np = of_find_compatible_node(NULL, NULL, pctrl_compat);
-		if (pctrl_np)
-			if (of_device_is_available(pctrl_np))
-				return;
-#endif
-
 	/* gpio part1 */
 	gpio_base1 = ioremap(EXYNOS4_PA_GPIO1, SZ_4K);
 	if (gpio_base1 == NULL) {
@@ -3031,6 +3010,28 @@ static __init int samsung_gpiolib_init(void)
 	int i, nr_chips;
 	int group = 0;
 
+#ifdef CONFIG_PINCTRL_SAMSUNG
+	/*
+	* This gpio driver includes support for device tree support and there
+	* are platforms using it. In order to maintain compatibility with those
+	* platforms, and to allow non-dt Exynos4210 platforms to use this
+	* gpiolib support, a check is added to find out if there is a active
+	* pin-controller driver support available. If it is available, this
+	* gpiolib support is ignored and the gpiolib support available in
+	* pin-controller driver is used. This is a temporary check and will go
+	* away when all of the Exynos4210 platforms have switched to using
+	* device tree and the pin-ctrl driver.
+	*/
+	struct device_node *pctrl_np;
+	static const struct of_device_id exynos_pinctrl_ids[] = {
+		{ .compatible = "samsung,pinctrl-exynos4210", },
+		{ .compatible = "samsung,pinctrl-exynos4x12", },
+	};
+	for_each_matching_node(pctrl_np, exynos_pinctrl_ids)
+		if (pctrl_np && of_device_is_available(pctrl_np))
+			return -ENODEV;
+#endif
+
 	samsung_gpiolib_set_cfg(samsung_gpio_cfgs, ARRAY_SIZE(samsung_gpio_cfgs));
 
 	if (soc_is_s3c24xx()) {
-- 
1.7.12
