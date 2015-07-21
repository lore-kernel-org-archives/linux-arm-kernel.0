From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Tue, 21 Jul 2015 15:50:56 +0200
Subject: [RFC PATCH 14/16] tegra-dpaux: Use devm_resource
In-Reply-To: <1437486658-28365-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1437486658-28365-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1437486658-28365-15-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

 drivers/gpu/drm/tegra/dpaux.c | 57 ++++++++++++-------------------------------
 1 file changed, 15 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/tegra/dpaux.c b/drivers/gpu/drm/tegra/dpaux.c
index 512322c58c43..e82e57ca3dde 100644
--- a/drivers/gpu/drm/tegra/dpaux.c
+++ b/drivers/gpu/drm/tegra/dpaux.c
@@ -245,7 +245,8 @@ static void tegra_dpaux_hotplug(struct work_struct *work)
 
 static irqreturn_t tegra_dpaux_irq(int irq, void *data)
 {
-	struct tegra_dpaux *dpaux = data;
+	struct platform_device *pdev = to_platform_device(data);
+	struct tegra_dpaux *dpaux = platform_get_drvdata(pdev);
 	irqreturn_t ret = IRQ_HANDLED;
 	u32 value;
 
@@ -269,48 +270,22 @@ static irqreturn_t tegra_dpaux_irq(int irq, void *data)
 static int tegra_dpaux_probe(struct platform_device *pdev)
 {
 	struct tegra_dpaux *dpaux;
-	struct resource *regs;
 	u32 value;
 	int err;
 
-	dpaux = devm_kzalloc(&pdev->dev, sizeof(*dpaux), GFP_KERNEL);
-	if (!dpaux)
-		return -ENOMEM;
+	dpaux = platform_get_drvdata(pdev);
 
 	INIT_WORK(&dpaux->work, tegra_dpaux_hotplug);
 	init_completion(&dpaux->complete);
 	INIT_LIST_HEAD(&dpaux->list);
 	dpaux->dev = &pdev->dev;
 
-	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	dpaux->regs = devm_ioremap_resource(&pdev->dev, regs);
-	if (IS_ERR(dpaux->regs))
-		return PTR_ERR(dpaux->regs);
-
-	dpaux->irq = platform_get_irq(pdev, 0);
-	if (dpaux->irq < 0) {
-		dev_err(&pdev->dev, "failed to get IRQ\n");
-		return -ENXIO;
-	}
-
-	dpaux->rst = devm_reset_control_get(&pdev->dev, "dpaux");
-	if (IS_ERR(dpaux->rst))
-		return PTR_ERR(dpaux->rst);
-
-	dpaux->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(dpaux->clk))
-		return PTR_ERR(dpaux->clk);
-
 	err = clk_prepare_enable(dpaux->clk);
 	if (err < 0)
 		return err;
 
 	reset_control_deassert(dpaux->rst);
 
-	dpaux->clk_parent = devm_clk_get(&pdev->dev, "parent");
-	if (IS_ERR(dpaux->clk_parent))
-		return PTR_ERR(dpaux->clk_parent);
-
 	err = clk_prepare_enable(dpaux->clk_parent);
 	if (err < 0)
 		return err;
@@ -322,18 +297,6 @@ static int tegra_dpaux_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	dpaux->vdd = devm_regulator_get(&pdev->dev, "vdd");
-	if (IS_ERR(dpaux->vdd))
-		return PTR_ERR(dpaux->vdd);
-
-	err = devm_request_irq(dpaux->dev, dpaux->irq, tegra_dpaux_irq, 0,
-			       dev_name(dpaux->dev), dpaux);
-	if (err < 0) {
-		dev_err(dpaux->dev, "failed to request IRQ#%u: %d\n",
-			dpaux->irq, err);
-		return err;
-	}
-
 	dpaux->aux.transfer = tegra_dpaux_transfer;
 	dpaux->aux.dev = &pdev->dev;
 
@@ -351,8 +314,6 @@ static int tegra_dpaux_probe(struct platform_device *pdev)
 	list_add_tail(&dpaux->list, &dpaux_list);
 	mutex_unlock(&dpaux_lock);
 
-	platform_set_drvdata(pdev, dpaux);
-
 	return 0;
 }
 
@@ -381,10 +342,22 @@ static const struct of_device_id tegra_dpaux_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, tegra_dpaux_of_match);
 
+static const struct devm_resource tegra_dpaux_resources[] = {
+	DEVM_ALLOC(tegra_dpaux),
+	DEVM_IOMAP(tegra_dpaux, regs, 0, 0),
+	DEVM_RESET(tegra_dpaux, rst, "dpaux"),
+	DEVM_CLOCK(tegra_dpaux, clk, NULL),
+	DEVM_CLOCK(tegra_dpaux, clk_parent, "parent"),
+	DEVM_REGULATOR(tegra_dpaux, vdd, "vdd"),
+	DEVM_IRQ(tegra_dpaux, irq, 0, tegra_dpaux_irq, 0),
+	{},
+};
+
 struct platform_driver tegra_dpaux_driver = {
 	.driver = {
 		.name = "tegra-dpaux",
 		.of_match_table = tegra_dpaux_of_match,
+		.resources = tegra_dpaux_resources,
 	},
 	.probe = tegra_dpaux_probe,
 	.remove = tegra_dpaux_remove,
-- 
2.4.3
