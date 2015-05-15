From: jenskuske@gmail.com (Jens Kuske)
Date: Fri, 15 May 2015 18:38:54 +0200
Subject: [PATCH v2 04/10] pinctrl: sunxi: Prepare for building SoC specific
 drivers as modules
In-Reply-To: <1431707940-19372-1-git-send-email-jenskuske@gmail.com>
References: <1431707940-19372-1-git-send-email-jenskuske@gmail.com>
Message-ID: <1431707940-19372-5-git-send-email-jenskuske@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a remove function and export the init and remove function
to allow us to build the SoC specific drivers as modules.

Signed-off-by: Jens Kuske <jenskuske@gmail.com>
---
 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 25 +++++++++++++++++++------
 drivers/pinctrl/sunxi/pinctrl-sunxi.h |  2 ++
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index f8e171b..4ef6b3d 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -856,7 +856,6 @@ int sunxi_pinctrl_init(struct platform_device *pdev,
 	struct sunxi_pinctrl *pctl;
 	struct resource *res;
 	int i, ret, last_pin;
-	struct clk *clk;
 
 	pctl = devm_kzalloc(&pdev->dev, sizeof(*pctl), GFP_KERNEL);
 	if (!pctl)
@@ -954,13 +953,13 @@ int sunxi_pinctrl_init(struct platform_device *pdev,
 			goto gpiochip_error;
 	}
 
-	clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(clk)) {
-		ret = PTR_ERR(clk);
+	pctl->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(pctl->clk)) {
+		ret = PTR_ERR(pctl->clk);
 		goto gpiochip_error;
 	}
 
-	ret = clk_prepare_enable(clk);
+	ret = clk_prepare_enable(pctl->clk);
 	if (ret)
 		goto gpiochip_error;
 
@@ -1015,10 +1014,24 @@ int sunxi_pinctrl_init(struct platform_device *pdev,
 	return 0;
 
 clk_error:
-	clk_disable_unprepare(clk);
+	clk_disable_unprepare(pctl->clk);
 gpiochip_error:
 	gpiochip_remove(pctl->chip);
 pinctrl_error:
 	pinctrl_unregister(pctl->pctl_dev);
 	return ret;
 }
+EXPORT_SYMBOL(sunxi_pinctrl_init);
+
+int sunxi_pinctrl_remove(struct platform_device *pdev)
+{
+	struct sunxi_pinctrl *pctl = platform_get_drvdata(pdev);
+
+	gpiochip_remove(pctl->chip);
+	pinctrl_unregister(pctl->pctl_dev);
+
+	clk_disable_unprepare(pctl->clk);
+
+	return 0;
+}
+EXPORT_SYMBOL(sunxi_pinctrl_remove);
diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.h b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
index e248e81..4442676 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.h
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
@@ -126,6 +126,7 @@ struct sunxi_pinctrl {
 	unsigned			*irq_array;
 	spinlock_t			lock;
 	struct pinctrl_dev		*pctl_dev;
+	struct clk			*clk;
 };
 
 #define SUNXI_PIN(_pin, ...)					\
@@ -285,5 +286,6 @@ static inline u32 sunxi_irq_status_offset(u16 irq)
 
 int sunxi_pinctrl_init(struct platform_device *pdev,
 		       const struct sunxi_pinctrl_desc *desc);
+int sunxi_pinctrl_remove(struct platform_device *pdev);
 
 #endif /* __PINCTRL_SUNXI_H */
-- 
2.4.0
