From: broonie@kernel.org (Mark Brown)
Date: Sun, 19 Feb 2017 16:34:54 +0000
Subject: Applied "ASoC: sun4i-spdif: drop unnessary
 snd_soc_unregister_component()" to the asoc tree
In-Reply-To: <20170206152224.7566-1-weiyj.lk@gmail.com>
Message-ID: <E1cfURq-0004f9-8x@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: sun4i-spdif: drop unnessary snd_soc_unregister_component()

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

>From c97c4604c008f3d489cc3201de80e313aeb501d6 Mon Sep 17 00:00:00 2001
From: Wei Yongjun <weiyongjun1@huawei.com>
Date: Mon, 6 Feb 2017 15:22:24 +0000
Subject: [PATCH] ASoC: sun4i-spdif: drop unnessary
 snd_soc_unregister_component()

It's not necessary to unregister a component registered
with devm_snd_soc_register_component(). Also removed
pointness clk_disable_unprepare() from error path and
snd_soc_unregister_platform() from the remove.

Fixes: f8260afa444b ("ASoC: sunxi: Add support for the SPDIF block")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun4i-spdif.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-spdif.c b/sound/soc/sunxi/sun4i-spdif.c
index c03cd07a9b19..eaefd07a5ed0 100644
--- a/sound/soc/sunxi/sun4i-spdif.c
+++ b/sound/soc/sunxi/sun4i-spdif.c
@@ -510,8 +510,7 @@ static int sun4i_spdif_probe(struct platform_device *pdev)
 	host->spdif_clk = devm_clk_get(&pdev->dev, "spdif");
 	if (IS_ERR(host->spdif_clk)) {
 		dev_err(&pdev->dev, "failed to get a spdif clock.\n");
-		ret = PTR_ERR(host->spdif_clk);
-		goto err_disable_apb_clk;
+		return PTR_ERR(host->spdif_clk);
 	}
 
 	host->dma_params_tx.addr = res->start + quirks->reg_dac_txdata;
@@ -525,7 +524,7 @@ static int sun4i_spdif_probe(struct platform_device *pdev)
 		if (IS_ERR(host->rst) && PTR_ERR(host->rst) == -EPROBE_DEFER) {
 			ret = -EPROBE_DEFER;
 			dev_err(&pdev->dev, "Failed to get reset: %d\n", ret);
-			goto err_disable_apb_clk;
+			return ret;
 		}
 		if (!IS_ERR(host->rst))
 			reset_control_deassert(host->rst);
@@ -534,7 +533,7 @@ static int sun4i_spdif_probe(struct platform_device *pdev)
 	ret = devm_snd_soc_register_component(&pdev->dev,
 				&sun4i_spdif_component, &sun4i_spdif_dai, 1);
 	if (ret)
-		goto err_disable_apb_clk;
+		return ret;
 
 	pm_runtime_enable(&pdev->dev);
 	if (!pm_runtime_enabled(&pdev->dev)) {
@@ -552,9 +551,6 @@ static int sun4i_spdif_probe(struct platform_device *pdev)
 		sun4i_spdif_runtime_suspend(&pdev->dev);
 err_unregister:
 	pm_runtime_disable(&pdev->dev);
-	snd_soc_unregister_component(&pdev->dev);
-err_disable_apb_clk:
-	clk_disable_unprepare(host->apb_clk);
 	return ret;
 }
 
@@ -564,9 +560,6 @@ static int sun4i_spdif_remove(struct platform_device *pdev)
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		sun4i_spdif_runtime_suspend(&pdev->dev);
 
-	snd_soc_unregister_platform(&pdev->dev);
-	snd_soc_unregister_component(&pdev->dev);
-
 	return 0;
 }
 
-- 
2.11.0
