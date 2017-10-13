From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Fri, 13 Oct 2017 18:41:37 +0800
Subject: [RESEND PATCH 1/2] spi: rockchip: Convert to late and early system PM
 callbacks
In-Reply-To: <20171013104138.3216-1-jeffy.chen@rock-chips.com>
References: <20171013104138.3216-1-jeffy.chen@rock-chips.com>
Message-ID: <20171013104138.3216-2-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently we are suspending the spi master in it's ->suspend callback,
which is racy as some other drivers may still want to transmit messages
on the bus(e.g. spi based pwm backlight).

Convert to late and early system PM callbacks to avoid the race.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

 drivers/spi/spi-rockchip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index fdcf3076681b..ae539c735ea6 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -914,7 +914,7 @@ static int rockchip_spi_runtime_resume(struct device *dev)
 #endif /* CONFIG_PM */
 
 static const struct dev_pm_ops rockchip_spi_pm = {
-	SET_SYSTEM_SLEEP_PM_OPS(rockchip_spi_suspend, rockchip_spi_resume)
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(rockchip_spi_suspend, rockchip_spi_resume)
 	SET_RUNTIME_PM_OPS(rockchip_spi_runtime_suspend,
 			   rockchip_spi_runtime_resume, NULL)
 };
-- 
2.11.0
