From: nm@ti.com (Nishanth Menon)
Date: Fri, 22 Jul 2011 00:55:53 -0500
Subject: [PATCH 2/2] OMAP2+: PM: SR: add suspend/resume handlers
In-Reply-To: <1311314153-23531-1-git-send-email-nm@ti.com>
References: <1311314153-23531-1-git-send-email-nm@ti.com>
Message-ID: <1311314153-23531-3-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Suspend and Resume paths are safe enough to do it in
the standard LDM suspend/resume handlers where one can
sleep. Add suspend/resume handlers for SmartReflex.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |   87 +++++++++++++++++++++++++++++++++++++
 1 files changed, 87 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 33a027f..fb90bd2 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -39,6 +39,7 @@ struct omap_sr {
 	int				ip_type;
 	int				nvalue_count;
 	bool				autocomp_active;
+	bool				is_suspended;
 	u32				clk_length;
 	u32				err_weight;
 	u32				err_minlimit;
@@ -684,6 +685,12 @@ void omap_sr_enable(struct voltagedomain *voltdm)
 	if (!sr->autocomp_active)
 		return;
 
+	if (sr->is_suspended) {
+		dev_dbg(&sr->pdev->dev, "%s: in suspended state\n", __func__);
+		return;
+	}
+
+
 	if (!sr_class || !(sr_class->enable) || !(sr_class->configure)) {
 		dev_warn(&sr->pdev->dev, "%s: smartreflex class driver not"
 			"registered\n", __func__);
@@ -717,6 +724,11 @@ void omap_sr_disable(struct voltagedomain *voltdm)
 	if (!sr->autocomp_active)
 		return;
 
+	if (sr->is_suspended) {
+		dev_dbg(&sr->pdev->dev, "%s: in suspended state\n", __func__);
+		return;
+	}
+
 	if (!sr_class || !(sr_class->disable)) {
 		dev_warn(&sr->pdev->dev, "%s: smartreflex class driver not"
 			"registered\n", __func__);
@@ -750,6 +762,11 @@ void omap_sr_disable_reset_volt(struct voltagedomain *voltdm)
 	if (!sr->autocomp_active)
 		return;
 
+	if (sr->is_suspended) {
+		dev_dbg(&sr->pdev->dev, "%s: in suspended state\n", __func__);
+		return;
+	}
+
 	if (!sr_class || !(sr_class->disable)) {
 		dev_warn(&sr->pdev->dev, "%s: smartreflex class driver not"
 			"registered\n", __func__);
@@ -808,6 +825,11 @@ static int omap_sr_autocomp_store(void *data, u64 val)
 		return -EINVAL;
 	}
 
+	if (sr_info->is_suspended) {
+		pr_warning("%s: in suspended state\n", __func__);
+		return -EBUSY;
+	}
+
 	if (!val)
 		sr_stop_vddautocomp(sr_info);
 	else
@@ -998,8 +1020,73 @@ static int __devexit omap_sr_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int omap_sr_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct omap_sr_data *pdata = pdev->dev.platform_data;
+	struct omap_sr *sr_info;
+
+	if (!pdata) {
+		dev_err(&pdev->dev, "%s: platform data missing\n", __func__);
+		return -EINVAL;
+	}
+
+	sr_info = _sr_lookup(pdata->voltdm);
+	if (IS_ERR(sr_info)) {
+		dev_warn(&pdev->dev, "%s: omap_sr struct not found\n",
+			__func__);
+		return -EINVAL;
+	}
+
+	if (!sr_info->autocomp_active)
+		return 0;
+
+	if (sr_info->is_suspended)
+		return 0;
+
+	omap_sr_disable_reset_volt(pdata->voltdm);
+	sr_info->is_suspended = true;
+	/* Flag the same info to the other CPUs */
+	smp_wmb();
+
+	return 0;
+}
+
+static int omap_sr_resume(struct platform_device *pdev)
+{
+	struct omap_sr_data *pdata = pdev->dev.platform_data;
+	struct omap_sr *sr_info;
+
+	if (!pdata) {
+		dev_err(&pdev->dev, "%s: platform data missing\n", __func__);
+		return -EINVAL;
+	}
+
+	sr_info = _sr_lookup(pdata->voltdm);
+	if (IS_ERR(sr_info)) {
+		dev_warn(&pdev->dev, "%s: omap_sr struct not found\n",
+			__func__);
+		return -EINVAL;
+	}
+
+	if (!sr_info->autocomp_active)
+		return 0;
+
+	if (!sr_info->is_suspended)
+		return 0;
+
+	sr_info->is_suspended = false;
+	/* Flag the same info to the other CPUs */
+	smp_wmb();
+	omap_sr_enable(pdata->voltdm);
+
+	return 0;
+}
+
+
 static struct platform_driver smartreflex_driver = {
 	.remove         = omap_sr_remove,
+	.suspend	= omap_sr_suspend,
+	.resume		= omap_sr_resume,
 	.driver		= {
 		.name	= "smartreflex",
 	},
-- 
1.7.4.1
