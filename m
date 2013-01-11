From: pgaikwad@nvidia.com (Prashant Gaikwad)
Date: Fri, 11 Jan 2013 13:31:25 +0530
Subject: [PATCH v2 06/10] ASoC: tegra: remove auxdata
In-Reply-To: <1357891289-23500-1-git-send-email-pgaikwad@nvidia.com>
References: <1357891289-23500-1-git-send-email-pgaikwad@nvidia.com>
Message-ID: <1357891289-23500-6-git-send-email-pgaikwad@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Configlink clock information is added to device tree. Get the clocks
using device node. Remove AUXDATA.

Signed-off-by: Prashant Gaikwad <pgaikwad@nvidia.com>
---
 sound/soc/tegra/tegra30_ahub.c |   14 ++------------
 1 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/sound/soc/tegra/tegra30_ahub.c b/sound/soc/tegra/tegra30_ahub.c
index bb31c41..2355630 100644
--- a/sound/soc/tegra/tegra30_ahub.c
+++ b/sound/soc/tegra/tegra30_ahub.c
@@ -299,15 +299,6 @@ static const char * const configlink_clocks[] = {
 	"spdif_in",
 };
 
-struct of_dev_auxdata ahub_auxdata[] = {
-	OF_DEV_AUXDATA("nvidia,tegra30-i2s", 0x70080300, "tegra30-i2s.0", NULL),
-	OF_DEV_AUXDATA("nvidia,tegra30-i2s", 0x70080400, "tegra30-i2s.1", NULL),
-	OF_DEV_AUXDATA("nvidia,tegra30-i2s", 0x70080500, "tegra30-i2s.2", NULL),
-	OF_DEV_AUXDATA("nvidia,tegra30-i2s", 0x70080600, "tegra30-i2s.3", NULL),
-	OF_DEV_AUXDATA("nvidia,tegra30-i2s", 0x70080700, "tegra30-i2s.4", NULL),
-	{}
-};
-
 #define LAST_REG(name) \
 	(TEGRA30_AHUB_##name + \
 	 (TEGRA30_AHUB_##name##_STRIDE * TEGRA30_AHUB_##name##_COUNT) - 4)
@@ -451,7 +442,7 @@ static int tegra30_ahub_probe(struct platform_device *pdev)
 	 * Ensure that here.
 	 */
 	for (i = 0; i < ARRAY_SIZE(configlink_clocks); i++) {
-		clk = clk_get_sys(NULL, configlink_clocks[i]);
+		clk = clk_get(&pdev->dev, configlink_clocks[i]);
 		if (IS_ERR(clk)) {
 			dev_err(&pdev->dev, "Can't get clock %s\n",
 				configlink_clocks[i]);
@@ -569,8 +560,7 @@ static int tegra30_ahub_probe(struct platform_device *pdev)
 			goto err_pm_disable;
 	}
 
-	of_platform_populate(pdev->dev.of_node, NULL, ahub_auxdata,
-			     &pdev->dev);
+	of_platform_populate(pdev->dev.of_node, NULL, NULL, &pdev->dev);
 
 	return 0;
 
-- 
1.7.4.1
