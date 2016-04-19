From: andrew@aj.id.au (Andrew Jeffery)
Date: Tue, 19 Apr 2016 13:43:42 +0930
Subject: [PATCH] pinctrl-exynos5440: Use off-stack memory for
 pinctrl_gpio_range
Message-ID: <1461039222-26592-1-git-send-email-andrew@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The range is registered into a linked list which can be referenced
throughout the lifetime of the driver. Ensure the range's memory is useful
for the same lifetime by adding it to the driver's private data structure.

The bug was introduced in the driver's initial commit, which was present in
v3.10.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Fixes: f0b9a7e521fa ("pinctrl: exynos5440: add pinctrl driver for Samsung EXYNOS5440 SoC")
Cc: stable at vger.kernel.org
---
This is my first contribution to the kernel, so hopefully I've followed all the
relevant documentation. If not, please let me know and point me in the right
direction!

I don't have the means to test the patch, but it compiles. Someone with
appropriate hardware should probably give it a spin.

 drivers/pinctrl/samsung/pinctrl-exynos5440.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-exynos5440.c b/drivers/pinctrl/samsung/pinctrl-exynos5440.c
index 00ab63abf1d9..d45028a75c0f 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos5440.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos5440.c
@@ -117,6 +117,7 @@ struct exynos5440_pinctrl_priv_data {
 	unsigned int			nr_groups;
 	const struct exynos5440_pmx_func	*pmx_functions;
 	unsigned int			nr_functions;
+	struct pinctrl_gpio_range	range;
 };
 
 /**
@@ -742,7 +743,6 @@ static int exynos5440_pinctrl_register(struct platform_device *pdev,
 	struct pinctrl_desc *ctrldesc;
 	struct pinctrl_dev *pctl_dev;
 	struct pinctrl_pin_desc *pindesc, *pdesc;
-	struct pinctrl_gpio_range grange;
 	char *pin_names;
 	int pin, ret;
 
@@ -794,12 +794,12 @@ static int exynos5440_pinctrl_register(struct platform_device *pdev,
 		return PTR_ERR(pctl_dev);
 	}
 
-	grange.name = "exynos5440-pctrl-gpio-range";
-	grange.id = 0;
-	grange.base = 0;
-	grange.npins = EXYNOS5440_MAX_PINS;
-	grange.gc = priv->gc;
-	pinctrl_add_gpio_range(pctl_dev, &grange);
+	priv->range.name = "exynos5440-pctrl-gpio-range";
+	priv->range.id = 0;
+	priv->range.base = 0;
+	priv->range.npins = EXYNOS5440_MAX_PINS;
+	priv->range.gc = priv->gc;
+	pinctrl_add_gpio_range(pctl_dev, &priv->range);
 	return 0;
 }
 
-- 
2.5.0
