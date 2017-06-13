From: broonie@kernel.org (Mark Brown)
Date: Tue, 13 Jun 2017 22:09:31 +0100
Subject: Applied "spi: rockchip: fix error handling when probe" to the spi tree
Message-ID: <E1dKt47-0000lu-GO@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: rockchip: fix error handling when probe

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From c351587e2502050f36d16e9e32c6c98975ecd6a2 Mon Sep 17 00:00:00 2001
From: Jeffy Chen <jeffy.chen@rock-chips.com>
Date: Tue, 13 Jun 2017 13:25:40 +0800
Subject: [PATCH] spi: rockchip: fix error handling when probe

After failed to request dma tx chain, we need to disable pm_runtime.
Also cleanup error labels for better readability.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Reviewed-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-rockchip.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index acf31f36b898..bab9b13f0ad0 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -684,33 +684,33 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	rs->regs = devm_ioremap_resource(&pdev->dev, mem);
 	if (IS_ERR(rs->regs)) {
 		ret =  PTR_ERR(rs->regs);
-		goto err_ioremap_resource;
+		goto err_put_master;
 	}
 
 	rs->apb_pclk = devm_clk_get(&pdev->dev, "apb_pclk");
 	if (IS_ERR(rs->apb_pclk)) {
 		dev_err(&pdev->dev, "Failed to get apb_pclk\n");
 		ret = PTR_ERR(rs->apb_pclk);
-		goto err_ioremap_resource;
+		goto err_put_master;
 	}
 
 	rs->spiclk = devm_clk_get(&pdev->dev, "spiclk");
 	if (IS_ERR(rs->spiclk)) {
 		dev_err(&pdev->dev, "Failed to get spi_pclk\n");
 		ret = PTR_ERR(rs->spiclk);
-		goto err_ioremap_resource;
+		goto err_put_master;
 	}
 
 	ret = clk_prepare_enable(rs->apb_pclk);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to enable apb_pclk\n");
-		goto err_ioremap_resource;
+		goto err_put_master;
 	}
 
 	ret = clk_prepare_enable(rs->spiclk);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to enable spi_clk\n");
-		goto err_spiclk_enable;
+		goto err_disable_apbclk;
 	}
 
 	spi_enable_chip(rs, 0);
@@ -728,7 +728,7 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	if (!rs->fifo_len) {
 		dev_err(&pdev->dev, "Failed to get fifo length\n");
 		ret = -EINVAL;
-		goto err_get_fifo_len;
+		goto err_disable_spiclk;
 	}
 
 	spin_lock_init(&rs->lock);
@@ -755,7 +755,7 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 		/* Check tx to see if we need defer probing driver */
 		if (PTR_ERR(rs->dma_tx.ch) == -EPROBE_DEFER) {
 			ret = -EPROBE_DEFER;
-			goto err_get_fifo_len;
+			goto err_disable_pm_runtime;
 		}
 		dev_warn(rs->dev, "Failed to request TX DMA channel\n");
 		rs->dma_tx.ch = NULL;
@@ -786,23 +786,24 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	ret = devm_spi_register_master(&pdev->dev, master);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register master\n");
-		goto err_register_master;
+		goto err_free_dma_rx;
 	}
 
 	return 0;
 
-err_register_master:
-	pm_runtime_disable(&pdev->dev);
+err_free_dma_rx:
 	if (rs->dma_rx.ch)
 		dma_release_channel(rs->dma_rx.ch);
 err_free_dma_tx:
 	if (rs->dma_tx.ch)
 		dma_release_channel(rs->dma_tx.ch);
-err_get_fifo_len:
+err_disable_pm_runtime:
+	pm_runtime_disable(&pdev->dev);
+err_disable_spiclk:
 	clk_disable_unprepare(rs->spiclk);
-err_spiclk_enable:
+err_disable_apbclk:
 	clk_disable_unprepare(rs->apb_pclk);
-err_ioremap_resource:
+err_put_master:
 	spi_master_put(master);
 
 	return ret;
-- 
2.11.0
