From: broonie@kernel.org (Mark Brown)
Date: Sat, 17 Nov 2018 03:29:03 +0000 (GMT)
Subject: Applied "ASoC: Convert a few more users to using %pOFn instead of
 device_node.name" to the asoc tree
Message-ID: <20181117032903.DFF8E440078@finisterre.ee.mobilebroadband>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: Convert a few more users to using %pOFn instead of device_node.name

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From dc43d3aa045c6588f163f4c0f5084e09cb5c0295 Mon Sep 17 00:00:00 2001
From: Rob Herring <robh@kernel.org>
Date: Fri, 16 Nov 2018 15:43:49 -0600
Subject: [PATCH] ASoC: Convert a few more users to using %pOFn instead of
 device_node.name

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Olivier Moysan <olivier.moysan@st.com>
Cc: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Cc: alsa-devel at alsa-project.org
Cc: linux-stm32 at st-md-mailman.stormreply.com
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/mt6797/mt6797-afe-pcm.c | 2 +-
 sound/soc/mediatek/mt8173/mt8173-afe-pcm.c | 2 +-
 sound/soc/stm/stm32_sai.c                  | 8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/mediatek/mt6797/mt6797-afe-pcm.c b/sound/soc/mediatek/mt6797/mt6797-afe-pcm.c
index 192f4d7b37b6..bff7d71d0742 100644
--- a/sound/soc/mediatek/mt6797/mt6797-afe-pcm.c
+++ b/sound/soc/mediatek/mt6797/mt6797-afe-pcm.c
@@ -828,7 +828,7 @@ static int mt6797_afe_pcm_dev_probe(struct platform_device *pdev)
 	/* request irq */
 	irq_id = platform_get_irq(pdev, 0);
 	if (!irq_id) {
-		dev_err(dev, "%s no irq found\n", dev->of_node->name);
+		dev_err(dev, "%pOFn no irq found\n", dev->of_node);
 		return -ENXIO;
 	}
 	ret = devm_request_irq(dev, irq_id, mt6797_afe_irq_handler,
diff --git a/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c b/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
index c0b6697503fd..166aed28330d 100644
--- a/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
+++ b/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
@@ -1092,7 +1092,7 @@ static int mt8173_afe_pcm_dev_probe(struct platform_device *pdev)
 
 	irq_id = platform_get_irq(pdev, 0);
 	if (irq_id <= 0) {
-		dev_err(afe->dev, "np %s no irq\n", afe->dev->of_node->name);
+		dev_err(afe->dev, "np %pOFn no irq\n", afe->dev->of_node);
 		return irq_id < 0 ? irq_id : -ENXIO;
 	}
 	ret = devm_request_irq(afe->dev, irq_id, mt8173_afe_irq_handler,
diff --git a/sound/soc/stm/stm32_sai.c b/sound/soc/stm/stm32_sai.c
index d597eba61992..bcb35cae2a2c 100644
--- a/sound/soc/stm/stm32_sai.c
+++ b/sound/soc/stm/stm32_sai.c
@@ -74,14 +74,14 @@ static int stm32_sai_sync_conf_provider(struct stm32_sai_data *sai, int synco)
 		return ret;
 	}
 
-	dev_dbg(&sai->pdev->dev, "Set %s%s as synchro provider\n",
-		sai->pdev->dev.of_node->name,
+	dev_dbg(&sai->pdev->dev, "Set %pOFn%s as synchro provider\n",
+		sai->pdev->dev.of_node,
 		synco == STM_SAI_SYNC_OUT_A ? "A" : "B");
 
 	prev_synco = FIELD_GET(SAI_GCR_SYNCOUT_MASK, readl_relaxed(sai->base));
 	if (prev_synco != STM_SAI_SYNC_OUT_NONE && synco != prev_synco) {
-		dev_err(&sai->pdev->dev, "%s%s already set as sync provider\n",
-			sai->pdev->dev.of_node->name,
+		dev_err(&sai->pdev->dev, "%pOFn%s already set as sync provider\n",
+			sai->pdev->dev.of_node,
 			prev_synco == STM_SAI_SYNC_OUT_A ? "A" : "B");
 		clk_disable_unprepare(sai->pclk);
 		return -EINVAL;
-- 
2.19.1
