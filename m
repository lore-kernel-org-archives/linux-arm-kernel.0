From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 15 Nov 2013 13:54:11 -0700
Subject: [PATCH 16/31] ASoC: tegra: use reset framework
In-Reply-To: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1384548866-13141-17-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Tegra's clock driver now provides an implementation of the common
reset API (include/linux/reset.h). Use this instead of the old Tegra-
specific API; that will soon be removed.

This change also renames "clock"/"clk" to "modules"/"mod" in symbols
related to entries in configlink_clocks[], since:
- We don't care about clock handles any more, but rather reset handles,
  so the old name isn't applicable.
- It really is a list of modules on the bus, about which we currently
  only care about reset handles.
If we start caring about any other aspect of the modules in the future,
we won't have to rename all these symbols again.

Cc: treding at nvidia.com
Cc: pdeschrijver at nvidia.com
Cc: linux-tegra at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: alsa-devel at alsa-project.org
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
This patch is part of a series with strong internal depdendencies. I'm
looking for an ack so that I can take the entire series through the Tegra
and arm-soc trees. The series will be part of a stable branch that can be
merged into other subsystems if needed to avoid/resolve dependencies.
---
 sound/soc/tegra/Kconfig        |  2 ++
 sound/soc/tegra/tegra30_ahub.c | 70 +++++++++++++++++++++++-------------------
 sound/soc/tegra/tegra30_ahub.h |  2 +-
 3 files changed, 41 insertions(+), 33 deletions(-)

diff --git a/sound/soc/tegra/Kconfig b/sound/soc/tegra/Kconfig
index 8fc653ca3ab4..896292bb853f 100644
--- a/sound/soc/tegra/Kconfig
+++ b/sound/soc/tegra/Kconfig
@@ -1,6 +1,8 @@
 config SND_SOC_TEGRA
 	tristate "SoC Audio for the Tegra System-on-Chip"
 	depends on (ARCH_TEGRA && TEGRA20_APB_DMA) || COMPILE_TEST
+	depends on COMMON_CLK
+	depends on RESET_CONTROLLER
 	select REGMAP_MMIO
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	help
diff --git a/sound/soc/tegra/tegra30_ahub.c b/sound/soc/tegra/tegra30_ahub.c
index 31154338c1eb..5ce00dc48c44 100644
--- a/sound/soc/tegra/tegra30_ahub.c
+++ b/sound/soc/tegra/tegra30_ahub.c
@@ -24,6 +24,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
+#include <linux/reset.h>
 #include <linux/slab.h>
 #include <linux/clk/tegra.h>
 #include <sound/soc.h>
@@ -301,27 +302,27 @@ int tegra30_ahub_unset_rx_cif_source(enum tegra30_ahub_rxcif rxcif)
 }
 EXPORT_SYMBOL_GPL(tegra30_ahub_unset_rx_cif_source);
 
-#define CLK_LIST_MASK_TEGRA30	BIT(0)
-#define CLK_LIST_MASK_TEGRA114	BIT(1)
+#define MOD_LIST_MASK_TEGRA30	BIT(0)
+#define MOD_LIST_MASK_TEGRA114	BIT(1)
 
-#define CLK_LIST_MASK_TEGRA30_OR_LATER \
-		(CLK_LIST_MASK_TEGRA30 | CLK_LIST_MASK_TEGRA114)
+#define MOD_LIST_MASK_TEGRA30_OR_LATER \
+		(MOD_LIST_MASK_TEGRA30 | MOD_LIST_MASK_TEGRA114)
 
 static const struct {
-	const char *clk_name;
-	u32 clk_list_mask;
-} configlink_clocks[] = {
-	{ "i2s0", CLK_LIST_MASK_TEGRA30_OR_LATER },
-	{ "i2s1", CLK_LIST_MASK_TEGRA30_OR_LATER },
-	{ "i2s2", CLK_LIST_MASK_TEGRA30_OR_LATER },
-	{ "i2s3", CLK_LIST_MASK_TEGRA30_OR_LATER },
-	{ "i2s4", CLK_LIST_MASK_TEGRA30_OR_LATER },
-	{ "dam0", CLK_LIST_MASK_TEGRA30_OR_LATER },
-	{ "dam1", CLK_LIST_MASK_TEGRA30_OR_LATER },
-	{ "dam2", CLK_LIST_MASK_TEGRA30_OR_LATER },
-	{ "spdif_in", CLK_LIST_MASK_TEGRA30_OR_LATER },
-	{ "amx", CLK_LIST_MASK_TEGRA114 },
-	{ "adx", CLK_LIST_MASK_TEGRA114 },
+	const char *rst_name;
+	u32 mod_list_mask;
+} configlink_mods[] = {
+	{ "i2s0", MOD_LIST_MASK_TEGRA30_OR_LATER },
+	{ "i2s1", MOD_LIST_MASK_TEGRA30_OR_LATER },
+	{ "i2s2", MOD_LIST_MASK_TEGRA30_OR_LATER },
+	{ "i2s3", MOD_LIST_MASK_TEGRA30_OR_LATER },
+	{ "i2s4", MOD_LIST_MASK_TEGRA30_OR_LATER },
+	{ "dam0", MOD_LIST_MASK_TEGRA30_OR_LATER },
+	{ "dam1", MOD_LIST_MASK_TEGRA30_OR_LATER },
+	{ "dam2", MOD_LIST_MASK_TEGRA30_OR_LATER },
+	{ "spdif", MOD_LIST_MASK_TEGRA30_OR_LATER },
+	{ "amx", MOD_LIST_MASK_TEGRA114 },
+	{ "adx", MOD_LIST_MASK_TEGRA114 },
 };
 
 #define LAST_REG(name) \
@@ -450,17 +451,17 @@ static const struct regmap_config tegra30_ahub_ahub_regmap_config = {
 };
 
 static struct tegra30_ahub_soc_data soc_data_tegra30 = {
-	.clk_list_mask = CLK_LIST_MASK_TEGRA30,
+	.mod_list_mask = MOD_LIST_MASK_TEGRA30,
 	.set_audio_cif = tegra30_ahub_set_cif,
 };
 
 static struct tegra30_ahub_soc_data soc_data_tegra114 = {
-	.clk_list_mask = CLK_LIST_MASK_TEGRA114,
+	.mod_list_mask = MOD_LIST_MASK_TEGRA114,
 	.set_audio_cif = tegra30_ahub_set_cif,
 };
 
 static struct tegra30_ahub_soc_data soc_data_tegra124 = {
-	.clk_list_mask = CLK_LIST_MASK_TEGRA114,
+	.mod_list_mask = MOD_LIST_MASK_TEGRA114,
 	.set_audio_cif = tegra124_ahub_set_cif,
 };
 
@@ -475,7 +476,7 @@ static int tegra30_ahub_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *match;
 	const struct tegra30_ahub_soc_data *soc_data;
-	struct clk *clk;
+	struct reset_control *rst;
 	int i;
 	struct resource *res0, *res1, *region;
 	u32 of_dma[2];
@@ -495,19 +496,24 @@ static int tegra30_ahub_probe(struct platform_device *pdev)
 	 * operate correctly, all devices on this bus must be out of reset.
 	 * Ensure that here.
 	 */
-	for (i = 0; i < ARRAY_SIZE(configlink_clocks); i++) {
-		if (!(configlink_clocks[i].clk_list_mask &
-					soc_data->clk_list_mask))
+	for (i = 0; i < ARRAY_SIZE(configlink_mods); i++) {
+		if (!(configlink_mods[i].mod_list_mask &
+					soc_data->mod_list_mask))
 			continue;
-		clk = clk_get(&pdev->dev, configlink_clocks[i].clk_name);
-		if (IS_ERR(clk)) {
-			dev_err(&pdev->dev, "Can't get clock %s\n",
-				configlink_clocks[i].clk_name);
-			ret = PTR_ERR(clk);
+
+		rst = reset_control_get(&pdev->dev,
+					configlink_mods[i].rst_name);
+		if (IS_ERR(rst)) {
+			dev_err(&pdev->dev, "Can't get reset %s\n",
+				configlink_mods[i].rst_name);
+			ret = PTR_ERR(rst);
 			goto err;
 		}
-		tegra_periph_reset_deassert(clk);
-		clk_put(clk);
+
+		ret = reset_control_deassert(rst);
+		reset_control_put(rst);
+		if (ret)
+			goto err;
 	}
 
 	ahub = devm_kzalloc(&pdev->dev, sizeof(struct tegra30_ahub),
diff --git a/sound/soc/tegra/tegra30_ahub.h b/sound/soc/tegra/tegra30_ahub.h
index d67321d90faa..1383f8cd3572 100644
--- a/sound/soc/tegra/tegra30_ahub.h
+++ b/sound/soc/tegra/tegra30_ahub.h
@@ -502,7 +502,7 @@ void tegra124_ahub_set_cif(struct regmap *regmap, unsigned int reg,
 			   struct tegra30_ahub_cif_conf *conf);
 
 struct tegra30_ahub_soc_data {
-	u32 clk_list_mask;
+	u32 mod_list_mask;
 	void (*set_audio_cif)(struct regmap *regmap,
 			      unsigned int reg,
 			      struct tegra30_ahub_cif_conf *conf);
-- 
1.8.1.5
