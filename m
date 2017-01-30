From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 30 Jan 2017 13:38:23 +0100
Subject: [PATCH v3 2/7] pinctrl: samsung: Ensure that pad retention is disabled
 on driver init
In-Reply-To: <1485779908-32147-1-git-send-email-m.szyprowski@samsung.com>
References: <1485779908-32147-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170130123838eucas1p12953af1e9af22e17ed9ca9c49dbd1e9d@eucas1p1.samsung.com>
Message-ID: <1485779908-32147-3-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When pin controller device is a part of power domain, there is no guarantee
that the power domain was not turned off and then on during boot process
before probing of the pin control driver. If it happened, then pin control
driver should ensure that pad retention is turned off during its probe call.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/pinctrl/samsung/pinctrl-exynos.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
index 63e51b56a22a..fa3802970570 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
@@ -777,6 +777,7 @@ static void exynos_retention_disable(struct samsung_pinctrl_drv_data *drvdata)
 {
 	struct samsung_retention_ctrl *ctrl;
 	struct regmap *pmu_regs;
+	int i;
 
 	ctrl = devm_kzalloc(drvdata->dev, sizeof(*ctrl), GFP_KERNEL);
 	if (!ctrl)
@@ -794,6 +795,10 @@ static void exynos_retention_disable(struct samsung_pinctrl_drv_data *drvdata)
 	ctrl->enable = exynos_retention_enable;
 	ctrl->disable = exynos_retention_disable;
 
+	/* Ensure that retention is disabled on driver init */
+	for (i = 0; i < ctrl->nr_regs; i++)
+		regmap_write(pmu_regs, ctrl->regs[i], ctrl->value);
+
 	return ctrl;
 }
 
-- 
1.9.1
