From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 12 Feb 2014 13:59:39 +0100
Subject: [PATCH 2/2] pinctrl: nomadik: Convert to modern pm_ops
In-Reply-To: <1392209979-31636-1-git-send-email-ulf.hansson@linaro.org>
References: <1392209979-31636-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1392209979-31636-2-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the SIMPLE_DEV_PM_OPS macro and convert to the modern pm ops.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pinctrl/pinctrl-nomadik.c |   17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-nomadik.c b/drivers/pinctrl/pinctrl-nomadik.c
index b6c5793..cec7762 100644
--- a/drivers/pinctrl/pinctrl-nomadik.c
+++ b/drivers/pinctrl/pinctrl-nomadik.c
@@ -2036,22 +2036,22 @@ static const struct of_device_id nmk_pinctrl_match[] = {
 };
 
 #ifdef CONFIG_PM_SLEEP
-static int nmk_pinctrl_suspend(struct platform_device *pdev, pm_message_t state)
+static int nmk_pinctrl_suspend(struct device *dev)
 {
 	struct nmk_pinctrl *npct;
 
-	npct = platform_get_drvdata(pdev);
+	npct = dev_get_drvdata(dev);
 	if (!npct)
 		return -EINVAL;
 
 	return pinctrl_force_sleep(npct->pctl);
 }
 
-static int nmk_pinctrl_resume(struct platform_device *pdev)
+static int nmk_pinctrl_resume(struct device *dev)
 {
 	struct nmk_pinctrl *npct;
 
-	npct = platform_get_drvdata(pdev);
+	npct = dev_get_drvdata(dev);
 	if (!npct)
 		return -EINVAL;
 
@@ -2146,17 +2146,18 @@ static struct platform_driver nmk_gpio_driver = {
 	.probe = nmk_gpio_probe,
 };
 
+static SIMPLE_DEV_PM_OPS(nmk_pinctrl_pm_ops,
+			nmk_pinctrl_suspend,
+			nmk_pinctrl_resume);
+
 static struct platform_driver nmk_pinctrl_driver = {
 	.driver = {
 		.owner = THIS_MODULE,
 		.name = "pinctrl-nomadik",
 		.of_match_table = nmk_pinctrl_match,
+		.pm = &nmk_pinctrl_pm_ops,
 	},
 	.probe = nmk_pinctrl_probe,
-#ifdef CONFIG_PM_SLEEP
-	.suspend = nmk_pinctrl_suspend,
-	.resume = nmk_pinctrl_resume,
-#endif
 };
 
 static int __init nmk_gpio_init(void)
-- 
1.7.9.5
