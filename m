From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Mon,  7 Aug 2017 20:40:20 +0800
Subject: [PATCH 3/3] spi: rockchip: Fix clock handling in suspend/resume
In-Reply-To: <1502109620-26813-1-git-send-email-jeffy.chen@rock-chips.com>
References: <1502109620-26813-1-git-send-email-jeffy.chen@rock-chips.com>
Message-ID: <1502109620-26813-4-git-send-email-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The runtime suspend callback might be called by pm domain framework at
suspend_noirq stage. It would try to disable the clocks which already
been disabled by rockchip_spi_suspend.

Call pm_runtime_force_suspend/pm_runtime_force_resume when
suspend/resume to avoid that.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

 drivers/spi/spi-rockchip.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index a75fd9b..34f6440 100644
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
2.1.4
