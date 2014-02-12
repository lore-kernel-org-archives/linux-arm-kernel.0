From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 12 Feb 2014 13:59:38 +0100
Subject: [PATCH 1/2] pinctrl: nomadik: Silence compiler warn for !CONFIG_PM
Message-ID: <1392209979-31636-1-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The static suspend/resume functions were not being used while
!CONFIG_PM. Fix it and convert to CONFIG_PM_SLEEP.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pinctrl/pinctrl-nomadik.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-nomadik.c b/drivers/pinctrl/pinctrl-nomadik.c
index 53a1111..b6c5793 100644
--- a/drivers/pinctrl/pinctrl-nomadik.c
+++ b/drivers/pinctrl/pinctrl-nomadik.c
@@ -2035,6 +2035,7 @@ static const struct of_device_id nmk_pinctrl_match[] = {
 	{},
 };
 
+#ifdef CONFIG_PM_SLEEP
 static int nmk_pinctrl_suspend(struct platform_device *pdev, pm_message_t state)
 {
 	struct nmk_pinctrl *npct;
@@ -2056,6 +2057,7 @@ static int nmk_pinctrl_resume(struct platform_device *pdev)
 
 	return pinctrl_force_default(npct->pctl);
 }
+#endif
 
 static int nmk_pinctrl_probe(struct platform_device *pdev)
 {
@@ -2151,7 +2153,7 @@ static struct platform_driver nmk_pinctrl_driver = {
 		.of_match_table = nmk_pinctrl_match,
 	},
 	.probe = nmk_pinctrl_probe,
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 	.suspend = nmk_pinctrl_suspend,
 	.resume = nmk_pinctrl_resume,
 #endif
-- 
1.7.9.5
