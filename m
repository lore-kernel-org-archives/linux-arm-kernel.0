From: youngmin.nam@samsung.com (=?UTF-8?B?64Ko7JiB66+8?=)
Date: Thu, 21 Sep 2017 21:32:29 +0900
Subject: [PATCH] pinctrl: samsung: add pinctrl_force_sleep() for "sleep"
 pinctrl state
References: <CGME20170921123230epcas1p4d3c1de108af7d34053d2c4f40dd42119@epcas1p4.samsung.com>
Message-ID: <006801d332d5$b0ca09d0$125e1d70$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds pinctrl_for_sleep() in samsung_pinctrl_suspend()
to support configuration of "sleep" pinctrl state.

For example, we can configure "sleep" pinctrl state of "gpf1-6"
as "INPUT, PULL DOWN" by configuring power down mode register.

&pinctrl_5 {
	pinctrl-names = "default","sleep";
	pinctrl-0 = <&initial5>;
	pinctrl-1 = <&sleep5>;

	initial5: initial-state {
		samsung,pins = gpf1-6;
		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
	};
	sleep5: sleep-state {
		samsung,pins = gpf1-6;
		samsung,pin-con-pdn = <EXYNOS_PIN_PDN_INPUT>;
		samsung,pin-pud-pdn = <EXYNOS_PIN_PULL_DOWN>;
	};
};

Signed-off-by: Youngmin Nam <youngmin.nam@samsung.com>
---
 drivers/pinctrl/samsung/pinctrl-samsung.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
index e04f7fe0a65d..b4d12f8db475 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.c
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
@@ -1099,6 +1099,11 @@ static int __maybe_unused samsung_pinctrl_suspend(struct device *dev)
 {
 	struct samsung_pinctrl_drv_data *drvdata = dev_get_drvdata(dev);
 	int i;
+	int ret;
+
+	ret = pinctrl_force_sleep(drvdata->pctl_dev);
+	if (ret)
+		dev_err(dev, "could not set sleep pinstate %d\n", ret);
 
 	for (i = 0; i < drvdata->nr_banks; i++) {
 		struct samsung_pin_bank *bank = &drvdata->pin_banks[i];
@@ -1187,6 +1192,11 @@ static int __maybe_unused samsung_pinctrl_resume(struct device *dev)
 	if (drvdata->retention_ctrl && drvdata->retention_ctrl->disable)
 		drvdata->retention_ctrl->disable(drvdata);
 
+	/* For changing state without writing register. */
+	if (!IS_ERR(drvdata->pctl_dev->p) &&
+	    !IS_ERR(drvdata->pctl_dev->hog_default))
+		drvdata->pctl_dev->p->state = drvdata->pctl_dev->hog_default;
+
 	return 0;
 }
 
-- 
2.13.0
