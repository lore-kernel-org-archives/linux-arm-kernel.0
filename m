From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 31 May 2018 00:00:35 +0200
Subject: [PATCH] ASoC: mediatek: export mtk-afe symbols as needed
Message-ID: <20180530220057.1419933-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The new mt6797-afe driver uses some functions in a common file, which
works for a built-in driver but fails for a loadable module:

ERROR: "mtk_afe_pcm_free" [sound/soc/mediatek/mt6797/snd-soc-mt6797-afe.ko] undefined!
ERROR: "mtk_afe_add_sub_dai_control" [sound/soc/mediatek/mt6797/snd-soc-mt6797-afe.ko] undefined!
ERROR: "mtk_afe_pcm_new" [sound/soc/mediatek/mt6797/snd-soc-mt6797-afe.ko] undefined!
ERROR: "mtk_afe_combine_sub_dai" [sound/soc/mediatek/mt6797/snd-soc-mt6797-afe.ko] undefined!
ERROR: "mtk_afe_pcm_ops" [sound/soc/mediatek/mt6797/snd-soc-mt6797-afe.ko] undefined!

This exports the five symbols above for modules.

Fixes: b3c702f56bf5 ("ASoC: mt6797: combine DAI to register component")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/mediatek/common/mtk-afe-platform-driver.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/mediatek/common/mtk-afe-platform-driver.c b/sound/soc/mediatek/common/mtk-afe-platform-driver.c
index 00618587ef1e..51ec4ff6ed95 100644
--- a/sound/soc/mediatek/common/mtk-afe-platform-driver.c
+++ b/sound/soc/mediatek/common/mtk-afe-platform-driver.c
@@ -57,6 +57,7 @@ int mtk_afe_combine_sub_dai(struct mtk_base_afe *afe)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(mtk_afe_combine_sub_dai);
 
 int mtk_afe_add_sub_dai_control(struct snd_soc_component *component)
 {
@@ -90,6 +91,7 @@ int mtk_afe_add_sub_dai_control(struct snd_soc_component *component)
 	return 0;
 
 }
+EXPORT_SYMBOL_GPL(mtk_afe_add_sub_dai_control);
 
 static snd_pcm_uframes_t mtk_afe_pcm_pointer
 			 (struct snd_pcm_substream *substream)
@@ -130,6 +132,7 @@ const struct snd_pcm_ops mtk_afe_pcm_ops = {
 	.ioctl = snd_pcm_lib_ioctl,
 	.pointer = mtk_afe_pcm_pointer,
 };
+EXPORT_SYMBOL_GPL(mtk_afe_pcm_ops);
 
 int mtk_afe_pcm_new(struct snd_soc_pcm_runtime *rtd)
 {
@@ -143,11 +146,13 @@ int mtk_afe_pcm_new(struct snd_soc_pcm_runtime *rtd)
 						     afe->dev,
 						     size, size);
 }
+EXPORT_SYMBOL_GPL(mtk_afe_pcm_new);
 
 void mtk_afe_pcm_free(struct snd_pcm *pcm)
 {
 	snd_pcm_lib_preallocate_free_for_all(pcm);
 }
+EXPORT_SYMBOL_GPL(mtk_afe_pcm_free);
 
 const struct snd_soc_component_driver mtk_afe_pcm_platform = {
 	.name = AFE_PCM_NAME,
-- 
2.9.0
