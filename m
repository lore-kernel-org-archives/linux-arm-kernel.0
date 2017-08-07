From: broonie@kernel.org (Mark Brown)
Date: Mon, 07 Aug 2017 16:53:26 +0100
Subject: Applied "spi: rockchip: Fix clock handling in suspend/resume" to the
 spi tree
In-Reply-To: <1502109620-26813-4-git-send-email-jeffy.chen@rock-chips.com>
Message-ID: <E1dekLO-0005bc-H0@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: rockchip: Fix clock handling in suspend/resume

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

>From d38c4ae194bb8a3d8cf7d95378c5b2799cdd0a3b Mon Sep 17 00:00:00 2001
From: Jeffy Chen <jeffy.chen@rock-chips.com>
Date: Mon, 7 Aug 2017 20:40:20 +0800
Subject: [PATCH] spi: rockchip: Fix clock handling in suspend/resume

The runtime suspend callback might be called by pm domain framework at
suspend_noirq stage. It would try to disable the clocks which already
been disabled by rockchip_spi_suspend.

Call pm_runtime_force_suspend/pm_runtime_force_resume when
suspend/resume to avoid that.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-rockchip.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index a75fd9bb76de..34f6440a5255 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -846,10 +846,9 @@ static int rockchip_spi_suspend(struct device *dev)
 	if (ret < 0)
 		return ret;
 
-	if (!pm_runtime_suspended(dev)) {
-		clk_disable_unprepare(rs->spiclk);
-		clk_disable_unprepare(rs->apb_pclk);
-	}
+	ret = pm_runtime_force_suspend(dev);
+	if (ret < 0)
+		return ret;
 
 	pinctrl_pm_select_sleep_state(dev);
 
@@ -864,17 +863,9 @@ static int rockchip_spi_resume(struct device *dev)
 
 	pinctrl_pm_select_default_state(dev);
 
-	if (!pm_runtime_suspended(dev)) {
-		ret = clk_prepare_enable(rs->apb_pclk);
-		if (ret < 0)
-			return ret;
-
-		ret = clk_prepare_enable(rs->spiclk);
-		if (ret < 0) {
-			clk_disable_unprepare(rs->apb_pclk);
-			return ret;
-		}
-	}
+	ret = pm_runtime_force_resume(dev);
+	if (ret < 0)
+		return ret;
 
 	ret = spi_master_resume(rs->master);
 	if (ret < 0) {
-- 
2.13.3
