From: wxt@rock-chips.com (Caesar Wang)
Date: Tue,  3 May 2016 10:23:50 +0800
Subject: [PATCH] thermal: rockchip: use the usleep_range instead of udelay
Message-ID: <1462242230-20873-1-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Documentation/timers/timers-howto.txt recommends to use
usleep_range on delays > 10usec.
The usleep_range indeed reduces CPU load, since the udelay will busy wait
for enough loop cycles to achieve the desired delay.

Fixes commit b06c52db39fd ("thermal: rockchip:
handle the power sequence for tsadc controller").

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Suggested-by: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Caesar Wang <wxt@rock-chips.com>

---

 drivers/thermal/rockchip_thermal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 86a1ab0..5d491f1 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -547,10 +547,10 @@ static void rk_tsadcv3_initialize(struct regmap *grf, void __iomem *regs,
 		regmap_write(grf, GRF_TSADC_TESTBIT_L, GRF_TSADC_TSEN_PD_ON);
 		mdelay(10);
 		regmap_write(grf, GRF_TSADC_TESTBIT_L, GRF_TSADC_TSEN_PD_OFF);
-		udelay(100); /* The spec note says at least 15 us */
+		usleep_range(15, 100); /* The spec note says at least 15 us */
 		regmap_write(grf, GRF_SARADC_TESTBIT, GRF_SARADC_TESTBIT_ON);
 		regmap_write(grf, GRF_TSADC_TESTBIT_H, GRF_TSADC_TESTBIT_H_ON);
-		udelay(200); /* The spec note says at least 90 us */
+		usleep_range(90, 200); /* The spec note says at least 90 us */
 	}
 
 	if (tshut_polarity == TSHUT_HIGH_ACTIVE)
-- 
1.9.1
