From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 23 Dec 2016 13:24:44 +0100
Subject: [PATCH 4/9] pinctrl: samsung: Use generic of_device_get_match_data
 helper
In-Reply-To: <1482495889-6201-1-git-send-email-m.szyprowski@samsung.com>
References: <1482495889-6201-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20161223122527epcas1p441f0ee34c5738645163ef40c94591183@epcas1p4.samsung.com>
Message-ID: <1482495889-6201-5-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace custom code with generic helper.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/pinctrl/samsung/pinctrl-samsung.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
index 4d9262051ff1..a6c2ea74e0f3 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.c
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
@@ -27,6 +27,7 @@
 #include <linux/err.h>
 #include <linux/gpio.h>
 #include <linux/irqdomain.h>
+#include <linux/of_device.h>
 #include <linux/spinlock.h>
 #include <linux/syscore_ops.h>
 
@@ -967,15 +968,13 @@ static int samsung_gpiolib_unregister(struct platform_device *pdev,
 	return 0;
 }
 
-static const struct of_device_id samsung_pinctrl_dt_match[];
-
 /* retrieve the soc specific data */
 static const struct samsung_pin_ctrl *
 samsung_pinctrl_get_soc_data(struct samsung_pinctrl_drv_data *d,
 			     struct platform_device *pdev)
 {
 	int id;
-	const struct of_device_id *match;
+	const struct samsung_pin_ctrl *match_data;
 	struct device_node *node = pdev->dev.of_node;
 	struct device_node *np;
 	const struct samsung_pin_bank_data *bdata;
@@ -990,8 +989,8 @@ static int samsung_gpiolib_unregister(struct platform_device *pdev,
 		dev_err(&pdev->dev, "failed to get alias id\n");
 		return ERR_PTR(-ENOENT);
 	}
-	match = of_match_node(samsung_pinctrl_dt_match, node);
-	ctrl = (struct samsung_pin_ctrl *)match->data + id;
+	match_data = of_device_get_match_data(&pdev->dev);
+	ctrl = match_data + id;
 
 	d->suspend = ctrl->suspend;
 	d->resume = ctrl->resume;
-- 
1.9.1
