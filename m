From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Tue, 21 Jul 2015 15:50:55 +0200
Subject: [RFC PATCH 13/16] tegra-sor: Use devm_resource
In-Reply-To: <1437486658-28365-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1437486658-28365-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1437486658-28365-14-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

 drivers/gpu/drm/tegra/sor.c | 60 ++++++++++++---------------------------------
 1 file changed, 15 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/tegra/sor.c b/drivers/gpu/drm/tegra/sor.c
index 7591d8901f9a..ec540ecda601 100644
--- a/drivers/gpu/drm/tegra/sor.c
+++ b/drivers/gpu/drm/tegra/sor.c
@@ -1579,55 +1579,13 @@ static const struct host1x_client_ops sor_client_ops = {
 
 static int tegra_sor_probe(struct platform_device *pdev)
 {
-	struct device_node *np;
 	struct tegra_sor *sor;
-	struct resource *regs;
 	int err;
 
-	sor = devm_kzalloc(&pdev->dev, sizeof(*sor), GFP_KERNEL);
-	if (!sor)
-		return -ENOMEM;
+	sor = platform_get_drvdata(pdev);
 
 	sor->output.dev = sor->dev = &pdev->dev;
 
-	np = of_parse_phandle(pdev->dev.of_node, "nvidia,dpaux", 0);
-	if (np) {
-		sor->dpaux = tegra_dpaux_find_by_of_node(np);
-		of_node_put(np);
-
-		if (!sor->dpaux)
-			return -EPROBE_DEFER;
-	}
-
-	err = tegra_output_probe(&sor->output);
-	if (err < 0)
-		return err;
-
-	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	sor->regs = devm_ioremap_resource(&pdev->dev, regs);
-	if (IS_ERR(sor->regs))
-		return PTR_ERR(sor->regs);
-
-	sor->rst = devm_reset_control_get(&pdev->dev, "sor");
-	if (IS_ERR(sor->rst))
-		return PTR_ERR(sor->rst);
-
-	sor->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(sor->clk))
-		return PTR_ERR(sor->clk);
-
-	sor->clk_parent = devm_clk_get(&pdev->dev, "parent");
-	if (IS_ERR(sor->clk_parent))
-		return PTR_ERR(sor->clk_parent);
-
-	sor->clk_safe = devm_clk_get(&pdev->dev, "safe");
-	if (IS_ERR(sor->clk_safe))
-		return PTR_ERR(sor->clk_safe);
-
-	sor->clk_dp = devm_clk_get(&pdev->dev, "dp");
-	if (IS_ERR(sor->clk_dp))
-		return PTR_ERR(sor->clk_dp);
-
 	INIT_LIST_HEAD(&sor->client.list);
 	sor->client.ops = &sor_client_ops;
 	sor->client.dev = &pdev->dev;
@@ -1641,8 +1599,6 @@ static int tegra_sor_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	platform_set_drvdata(pdev, sor);
-
 	return 0;
 }
 
@@ -1669,10 +1625,24 @@ static const struct of_device_id tegra_sor_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, tegra_sor_of_match);
 
+static const struct devm_resource tegra_sor_resources[] = {
+	DEVM_ALLOC(tegra_sor),
+	DEVM_TEGRA_DPAUX(tegra_sor, dpaux, "nvidia,dpaux"),
+	DEVM_TEGRA_OUTPUT(tegra_sor, output),
+	DEVM_IOMAP(tegra_sor, regs, 0, 0),
+	DEVM_RESET(tegra_sor, rst, "sor"),
+	DEVM_CLOCK(tegra_sor, clk, NULL),
+	DEVM_CLOCK(tegra_sor, clk_parent, "parent"),
+	DEVM_CLOCK(tegra_sor, clk_safe, "safe"),
+	DEVM_CLOCK(tegra_sor, clk_dp, "dp"),
+	{},
+};
+
 struct platform_driver tegra_sor_driver = {
 	.driver = {
 		.name = "tegra-sor",
 		.of_match_table = tegra_sor_of_match,
+		.resources = tegra_sor_resources,
 	},
 	.probe = tegra_sor_probe,
 	.remove = tegra_sor_remove,
-- 
2.4.3
