From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Thu, 16 Aug 2012 01:27:35 +0530
Subject: [PATCH v2 3/4] gpio: exynos4: skip gpiolib registration if pinctrl
 driver is used
In-Reply-To: <1345060656-32201-1-git-send-email-thomas.abraham@linaro.org>
References: <1345060656-32201-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1345060656-32201-4-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pinctrl driver, when enabled, registers all the gpio pins and hence the
registration of gpio pins by this driver can be skipped.

Acked-by: Grant Likely <grant.likely@secretlab.ca>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 drivers/gpio/gpio-samsung.c |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/drivers/gpio/gpio-samsung.c b/drivers/gpio/gpio-samsung.c
index 92f7b2b..8e61053 100644
--- a/drivers/gpio/gpio-samsung.c
+++ b/drivers/gpio/gpio-samsung.c
@@ -2734,6 +2734,27 @@ static __init void exynos4_gpiolib_init(void)
 	int group = 0;
 	void __iomem *gpx_base;
 
+#ifdef CONFIG_OF
+		/*
+		 * This gpio driver includes support for device tree support and
+		 * there are platforms using it. In order to maintain
+		 * compatibility with those platforms, and to allow non-dt
+		 * Exynos4210 platforms to use this gpiolib support, a check
+		 * is added to find out if there is a active pin-controller
+		 * driver support available. If it is available, this gpiolib
+		 * support is ignored and the gpiolib support available in
+		 * pin-controller driver is used. This is a temporary check and
+		 * will go away when all of the Exynos4210 platforms have
+		 * switched to using device tree and the pin-ctrl driver.
+		 */
+		struct device_node *pctrl_np;
+		const char *pctrl_compat = "samsung,pinctrl-exynos4210";
+		pctrl_np = of_find_compatible_node(NULL, NULL, pctrl_compat);
+		if (pctrl_np)
+			if (of_device_is_available(pctrl_np))
+				return -ENODEV;
+#endif
+
 	/* gpio part1 */
 	gpio_base1 = ioremap(EXYNOS4_PA_GPIO1, SZ_4K);
 	if (gpio_base1 == NULL) {
-- 
1.6.6.rc2
