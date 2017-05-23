From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 23 May 2017 20:41:41 +0200
Subject: [PATCH 3/3] pinctrl: samsung: Explicitly cast pointer returned by
 of_iomap() to iomem
In-Reply-To: <20170523184141.24284-1-krzk@kernel.org>
References: <20170523184141.24284-1-krzk@kernel.org>
Message-ID: <20170523184141.24284-3-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For S5Pv210 retention control, the driver stores the iomem pointer from
of_iomap() under void pointer priv member.  This makes sparse unhappy:

    drivers/pinctrl/samsung/pinctrl-exynos.c:664:36: warning: incorrect type in argument 1 (different address spaces)
    drivers/pinctrl/samsung/pinctrl-exynos.c:664:36:    expected void const volatile [noderef] <asn:2>*addr
    drivers/pinctrl/samsung/pinctrl-exynos.c:664:36:    got void *

The iomem pointer is used safely (stored under priv by
s5pv210_retention_init(), used by s5pv210_retention_disable() thus we
can add explicit casts to iomem silence the warning.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/pinctrl/samsung/pinctrl-exynos.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
index 66122627b3ed..a870af943bc7 100644
--- a/drivers/pinctrl/samsung/pinctrl-exynos.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
@@ -656,7 +656,7 @@ static void exynos_pinctrl_resume(struct samsung_pinctrl_drv_data *drvdata)
 
 static void s5pv210_retention_disable(struct samsung_pinctrl_drv_data *drvdata)
 {
-	void *clk_base = drvdata->retention_ctrl->priv;
+	void __iomem *clk_base = (void __iomem *)drvdata->retention_ctrl->priv;
 	u32 tmp;
 
 	tmp = __raw_readl(clk_base + S5P_OTHERS);
@@ -671,7 +671,7 @@ s5pv210_retention_init(struct samsung_pinctrl_drv_data *drvdata,
 {
 	struct samsung_retention_ctrl *ctrl;
 	struct device_node *np;
-	void *clk_base;
+	void __iomem *clk_base;
 
 	ctrl = devm_kzalloc(drvdata->dev, sizeof(*ctrl), GFP_KERNEL);
 	if (!ctrl)
@@ -690,7 +690,7 @@ s5pv210_retention_init(struct samsung_pinctrl_drv_data *drvdata,
 		return ERR_PTR(-EINVAL);
 	}
 
-	ctrl->priv = clk_base;
+	ctrl->priv = (void __force *)clk_base;
 	ctrl->disable = s5pv210_retention_disable;
 
 	return ctrl;
-- 
2.9.3
