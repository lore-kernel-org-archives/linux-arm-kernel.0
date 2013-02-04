From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 4 Feb 2013 10:21:32 +0800
Subject: [PATCH] regulator: anatop: improve precision of delay time
Message-ID: <1359944492-23130-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For cpufreq example, it takes 13 steps (25 mV for one step) to increase
vddcore from 0.95 V to 1.275 V, and the time of 64 clock cycles at
24 MHz for one step is ~2.67 uS, so the total delay time would be
~34.71 uS.  But the current calculation in the driver gives 39 uS.
Change the formula to have the addition of 1 be the last step, so that
we can get a more precise delay time.  For example above, the new
formula will give 35 uS.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/regulator/anatop-regulator.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/anatop-regulator.c b/drivers/regulator/anatop-regulator.c
index 0df9c6a..0d4a8cc 100644
--- a/drivers/regulator/anatop-regulator.c
+++ b/drivers/regulator/anatop-regulator.c
@@ -80,8 +80,8 @@ static int anatop_regmap_set_voltage_time_sel(struct regulator_dev *reg,
 		regmap_read(anatop_reg->anatop, anatop_reg->delay_reg, &val);
 		val = (val >> anatop_reg->delay_bit_shift) &
 			((1 << anatop_reg->delay_bit_width) - 1);
-		ret = (new_sel - old_sel) * ((LDO_RAMP_UP_UNIT_IN_CYCLES <<
-			val) / LDO_RAMP_UP_FREQ_IN_MHZ + 1);
+		ret = (new_sel - old_sel) * (LDO_RAMP_UP_UNIT_IN_CYCLES <<
+			val) / LDO_RAMP_UP_FREQ_IN_MHZ + 1;
 	}
 
 	return ret;
-- 
1.7.9.5
