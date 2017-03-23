From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 23 Mar 2017 09:03:22 +0100
Subject: [PATCH v4 1/6] pinctrl: samsung: Ensure that pad retention is disabled
 on driver init
In-Reply-To: <1490256207-10061-1-git-send-email-m.szyprowski@samsung.com>
References: <1490256207-10061-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170323080347eucas1p2d0340709543b3ce128281e5a490216d4@eucas1p2.samsung.com>
Message-ID: <1490256207-10061-2-git-send-email-m.szyprowski@samsung.com>
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
index f9b49967f512..fa8bdd9ae198 100644
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
