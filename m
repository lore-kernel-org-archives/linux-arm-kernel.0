From: robh@kernel.org (Rob Herring)
Date: Fri, 16 Nov 2018 15:43:49 -0600
Subject: [PATCH] ASoC: Convert a few more users to using %pOFn instead of
 device_node.name
Message-ID: <20181116214349.20632-1-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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
