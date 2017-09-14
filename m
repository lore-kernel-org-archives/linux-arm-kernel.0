From: broonie@kernel.org (Mark Brown)
Date: Thu, 14 Sep 2017 10:27:17 -0700 (PDT)
Subject: Applied "ASoC: rockchip: i2s: fix unbalanced clk_disable" to the asoc
 tree
In-Reply-To: <20170914155855.28768-1-john@metanate.com>
Message-ID: <20170914172717.1B3CE4400D2@finisterre.ee.mobilebroadband>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: rockchip: i2s: fix unbalanced clk_disable

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

>From 32debfcd3ff0939c93238ddde03ffcc96cca5c60 Mon Sep 17 00:00:00 2001
From: John Keeping <john@metanate.com>
Date: Thu, 14 Sep 2017 16:58:55 +0100
Subject: [PATCH] ASoC: rockchip: i2s: fix unbalanced clk_disable

mclk is enabled and disabled only in i2s_runtime_{resume,suspend}() and
we ensure that the device is runtime suspended before reaching this
clk_disable_unprepare() call, so it is wrong to call it again here.

Signed-off-by: John Keeping <john@metanate.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/rockchip_i2s.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index 199338fdeda0..a7972c2d4e7b 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -694,7 +694,6 @@ static int rockchip_i2s_remove(struct platform_device *pdev)
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		i2s_runtime_suspend(&pdev->dev);
 
-	clk_disable_unprepare(i2s->mclk);
 	clk_disable_unprepare(i2s->hclk);
 
 	return 0;
-- 
2.13.2
