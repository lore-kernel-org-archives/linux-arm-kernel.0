From: dianders@chromium.org (Doug Anderson)
Date: Tue,  9 Sep 2014 16:06:04 -0700
Subject: [PATCH] mfd: RK808: Add register caching
Message-ID: <1410303964-6943-1-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let's define the voltatile registers (those that can't be cached) and
enable caching.  The rk808 is accessed almost constantly with cpufreq
so this is really nice.

As measured by ftrace:
  before this change: cpu0_set_target() => ~2200us
  after this change:  cpu0_set_target() =>  ~500us

Signed-off-by: Doug Anderson <dianders@chromium.org>
---
 drivers/mfd/rk808.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
index 0324422..bd02150 100644
--- a/drivers/mfd/rk808.c
+++ b/drivers/mfd/rk808.c
@@ -29,10 +29,40 @@ struct rk808_reg_data {
 	int value;
 };
 
+static bool rk808_is_volatile_reg(struct device *dev, unsigned int reg)
+{
+	/*
+	 * Notes:
+	 * - Technically the ROUND_30s bit makes RTC_CTRL_REG volatile, but
+	 *   we don't use that feature.  It's better to cache.
+	 * - It's unlikely we care that RK808_DEVCTRL_REG is volatile since
+	 *   bits are cleared in case when we shutoff anyway, but better safe.
+	 */
+
+	switch (reg) {
+	case RK808_SECONDS_REG ... RK808_WEEKS_REG:
+	case RK808_RTC_STATUS_REG:
+	case RK808_VB_MON_REG:
+	case RK808_THERMAL_REG:
+	case RK808_DCDC_UV_STS_REG:
+	case RK808_LDO_UV_STS_REG:
+	case RK808_DCDC_PG_REG:
+	case RK808_LDO_PG_REG:
+	case RK808_DEVCTRL_REG:
+	case RK808_INT_STS_REG1:
+	case RK808_INT_STS_REG2:
+		return true;
+	}
+
+	return false;
+}
+
 static const struct regmap_config rk808_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 	.max_register = RK808_IO_POL_REG,
+	.cache_type = REGCACHE_RBTREE,
+	.volatile_reg = rk808_is_volatile_reg,
 };
 
 static struct resource rtc_resources[] = {
-- 
2.1.0.rc2.206.gedb03e5
