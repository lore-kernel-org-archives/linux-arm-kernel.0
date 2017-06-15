From: broonie@kernel.org (Mark Brown)
Date: Thu, 15 Jun 2017 18:20:55 +0100
Subject: Applied "ASoC: rockchip: Fix an error handling in
 'rockchip_i2s_probe'" to the asoc tree
In-Reply-To: <20170615055311.8049-1-christophe.jaillet@wanadoo.fr>
Message-ID: <E1dLYRz-0001l4-SZ@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: rockchip: Fix an error handling in 'rockchip_i2s_probe'

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From c3a3d3c41b74b05267bab6173f2a8224a1443ba6 Mon Sep 17 00:00:00 2001
From: Christophe Jaillet <christophe.jaillet@wanadoo.fr>
Date: Thu, 15 Jun 2017 07:53:11 +0200
Subject: [PATCH] ASoC: rockchip: Fix an error handling in 'rockchip_i2s_probe'

If this memory allocation fail, we must disable what has been enabled.
Do not return immediately but go thrue the error handling path instead.

Also use 'devm_kmemdup' instead of 'devm_kzalloc+memcpy' to simplify code.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/rockchip_i2s.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index 66a26c56c658..ce09dee2202e 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -641,12 +641,13 @@ static int rockchip_i2s_probe(struct platform_device *pdev)
 			goto err_pm_disable;
 	}
 
-	soc_dai = devm_kzalloc(&pdev->dev,
+	soc_dai = devm_kmemdup(&pdev->dev, &rockchip_i2s_dai
 			       sizeof(*soc_dai), GFP_KERNEL);
-	if (!soc_dai)
-		return -ENOMEM;
+	if (!soc_dai) {
+		err = -ENOMEM;
+		goto err_pm_disable;
+	}
 
-	memcpy(soc_dai, &rockchip_i2s_dai, sizeof(*soc_dai));
 	if (!of_property_read_u32(node, "rockchip,playback-channels", &val)) {
 		if (val >= 2 && val <= 8)
 			soc_dai->playback.channels_max = val;
-- 
2.11.0
