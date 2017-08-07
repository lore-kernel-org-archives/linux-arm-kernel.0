From: broonie@kernel.org (Mark Brown)
Date: Mon, 07 Aug 2017 16:53:31 +0100
Subject: Applied "spi: rockchip: Fix clock handling in remove" to the spi tree
In-Reply-To: <1502109620-26813-3-git-send-email-jeffy.chen@rock-chips.com>
Message-ID: <E1dekLT-0005cd-N7@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: rockchip: Fix clock handling in remove

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

>From 6a06e895b262621a81b3b08126b4bc5e1b8eef05 Mon Sep 17 00:00:00 2001
From: Jeffy Chen <jeffy.chen@rock-chips.com>
Date: Mon, 7 Aug 2017 20:40:19 +0800
Subject: [PATCH] spi: rockchip: Fix clock handling in remove

We are assuming clocks enabled when calling rockchip_spi_remove, which
is not always true. Those clocks might already been disabled by the
runtime PM at that time.

Call pm_runtime_get_sync before trying to disable clocks to avoid that.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-rockchip.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 5497650992c7..a75fd9bb76de 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -816,11 +816,15 @@ static int rockchip_spi_remove(struct platform_device *pdev)
 	struct spi_master *master = spi_master_get(platform_get_drvdata(pdev));
 	struct rockchip_spi *rs = spi_master_get_devdata(master);
 
-	pm_runtime_disable(&pdev->dev);
+	pm_runtime_get_sync(&pdev->dev);
 
 	clk_disable_unprepare(rs->spiclk);
 	clk_disable_unprepare(rs->apb_pclk);
 
+	pm_runtime_put_noidle(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
+
 	if (rs->dma_tx.ch)
 		dma_release_channel(rs->dma_tx.ch);
 	if (rs->dma_rx.ch)
-- 
2.13.3
