From: jonathanh@nvidia.com (Jon Hunter)
Date: Tue, 28 Jul 2015 16:30:54 +0100
Subject: [PATCH V3 10/19] drm/tegra: dc: Prepare for generic PM domains
In-Reply-To: <20150728112030.GA10949@ulmo.nvidia.com>
References: <1436791197-32358-1-git-send-email-jonathanh@nvidia.com>
 <1436791197-32358-11-git-send-email-jonathanh@nvidia.com>
 <20150717104154.GM3057@ulmo> <55B73D8C.103@nvidia.com>
 <20150728112030.GA10949@ulmo.nvidia.com>
Message-ID: <55B7A02E.40506@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 28/07/15 12:20, Thierry Reding wrote:
> On Tue, Jul 28, 2015 at 09:30:04AM +0100, Jon Hunter wrote:
>> May be that would be a cleaner transition than trying to do it all in
>> one go.
> 
> I have a couple of patches in my tree to do this for DRM as part of an
> effort to restore DPMS. It's fairly tricky to get right in DRM and
> requires all sorts of changes to the driver.

Hmmm ... I was just thinking about moving what is currently there in the pm-runtime helpers ...

diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index a287e4fec865..0f1dc01215b1 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -10,6 +10,7 @@
 #include <linux/clk.h>
 #include <linux/debugfs.h>
 #include <linux/iommu.h>
+#include <linux/pm_runtime.h>
 #include <linux/reset.h>
 
 #include <soc/tegra/pmc.h>
@@ -1922,29 +1923,12 @@ static int tegra_dc_probe(struct platform_device *pdev)
 			dc->powergate = TEGRA_POWERGATE_DIS;
 		else
 			dc->powergate = TEGRA_POWERGATE_DISB;
+	}
 
-		err = tegra_powergate_sequence_power_up(dc->powergate, dc->clk,
-							dc->rst);
-		if (err < 0) {
-			dev_err(&pdev->dev, "failed to power partition: %d\n",
-				err);
-			return err;
-		}
-	} else {
-		err = clk_prepare_enable(dc->clk);
-		if (err < 0) {
-			dev_err(&pdev->dev, "failed to enable clock: %d\n",
-				err);
-			return err;
-		}
+	platform_set_drvdata(pdev, dc);
 
-		err = reset_control_deassert(dc->rst);
-		if (err < 0) {
-			dev_err(&pdev->dev, "failed to deassert reset: %d\n",
-				err);
-			return err;
-		}
-	}
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_get_sync(&pdev->dev);
 
 	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	dc->regs = devm_ioremap_resource(&pdev->dev, regs);
@@ -1978,8 +1962,6 @@ static int tegra_dc_probe(struct platform_device *pdev)
 	if (!dc->syncpt)
 		dev_warn(&pdev->dev, "failed to allocate syncpoint\n");
 
-	platform_set_drvdata(pdev, dc);
-
 	return 0;
 }
 
@@ -2003,6 +1985,17 @@ static int tegra_dc_remove(struct platform_device *pdev)
 		return err;
 	}
 
+	pm_runtime_put(&pdev->dev);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int tegra_dc_runtime_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct tegra_dc *dc = platform_get_drvdata(pdev);
+
 	reset_control_assert(dc->rst);
 
 	if (dc->soc->has_powergate)
@@ -2013,11 +2006,54 @@ static int tegra_dc_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int tegra_dc_runtime_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct tegra_dc *dc = platform_get_drvdata(pdev);
+	int err;
+
+	if (dc->soc->has_powergate) {
+		err = tegra_powergate_sequence_power_up(dc->powergate, dc->clk,
+							dc->rst);
+		if (err < 0) {
+			dev_err(&pdev->dev, "failed to power partition: %d\n",
+				err);
+			return err;
+		}
+	} else {
+		err = clk_prepare_enable(dc->clk);
+		if (err < 0) {
+			dev_err(&pdev->dev, "failed to enable clock: %d\n",
+				err);
+			return err;
+		}
+
+		err = reset_control_deassert(dc->rst);
+		if (err < 0) {
+			dev_err(&pdev->dev, "failed to deassert reset: %d\n",
+				err);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+static struct dev_pm_ops tegra_dc_pm_ops = {
+	SET_RUNTIME_PM_OPS(tegra_dc_runtime_suspend,
+			   tegra_dc_runtime_resume, NULL)
+};
+#define TEGRA_DC_PM_OPS (&tegra_dc_pm_ops)
+#else
+#define TEGRA_DC_PM_OPS NULL
+#endif /* CONFIG_PM */
+
 struct platform_driver tegra_dc_driver = {
 	.driver = {
 		.name = "tegra-dc",
 		.owner = THIS_MODULE,
 		.of_match_table = tegra_dc_of_match,
+		.pm = TEGRA_DC_PM_OPS,
 	},
 	.probe = tegra_dc_probe,
 	.remove = tegra_dc_remove,
-- 
2.1.4
