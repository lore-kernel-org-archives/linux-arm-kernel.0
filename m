From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Mon,  6 Feb 2017 15:22:24 +0000
Subject: [PATCH -next] ASoC: sun4i-spdif: drop unnessary
 snd_soc_unregister_component()
Message-ID: <20170206152224.7566-1-weiyj.lk@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <weiyongjun1@huawei.com>

It's not necessary to unregister a component registered
with devm_snd_soc_register_component(). Also removed
pointness clk_disable_unprepare() from error path and
snd_soc_unregister_platform() from the remove.

Fixes: f8260afa444b ("ASoC: sunxi: Add support for the SPDIF block")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 sound/soc/sunxi/sun4i-spdif.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-spdif.c b/sound/soc/sunxi/sun4i-spdif.c
index c03cd07..eaefd07 100644
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
