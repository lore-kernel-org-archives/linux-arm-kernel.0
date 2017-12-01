From: broonie@kernel.org (Mark Brown)
Date: Fri, 01 Dec 2017 13:44:06 +0000
Subject: Applied "ASoC: mt8173: Fix platform_get_irq's error checking" to the
 asoc tree
In-Reply-To: <79e17e6083f5142c4707c94519577b6682a76566.1511970158.git.arvind.yadav.cs@gmail.com>
Message-ID: <E1eKlbq-0001Ju-5D@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: mt8173: Fix platform_get_irq's error checking

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

>From d6e2c4ffdf67de68e0263630525d2b521132d66a Mon Sep 17 00:00:00 2001
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Wed, 29 Nov 2017 21:47:11 +0530
Subject: [PATCH] ASoC: mt8173: Fix platform_get_irq's error checking

The platform_get_irq() function returns negative if an error occurs.
zero or positive number on success. platform_get_irq() error checking
for zero is not correct.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/mt8173/mt8173-afe-pcm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c b/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
index 8a643a35d3d4..c7f7f8add5d9 100644
--- a/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
+++ b/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
@@ -1083,7 +1083,7 @@ static int mt8173_afe_init_audio_clk(struct mtk_base_afe *afe)
 static int mt8173_afe_pcm_dev_probe(struct platform_device *pdev)
 {
 	int ret, i;
-	unsigned int irq_id;
+	int irq_id;
 	struct mtk_base_afe *afe;
 	struct mt8173_afe_private *afe_priv;
 	struct resource *res;
@@ -1105,9 +1105,9 @@ static int mt8173_afe_pcm_dev_probe(struct platform_device *pdev)
 	afe->dev = &pdev->dev;
 
 	irq_id = platform_get_irq(pdev, 0);
-	if (!irq_id) {
+	if (irq_id <= 0) {
 		dev_err(afe->dev, "np %s no irq\n", afe->dev->of_node->name);
-		return -ENXIO;
+		return irq_id < 0 ? irq_id : -ENXIO;
 	}
 	ret = devm_request_irq(afe->dev, irq_id, mt8173_afe_irq_handler,
 			       0, "Afe_ISR_Handle", (void *)afe);
-- 
2.15.0
