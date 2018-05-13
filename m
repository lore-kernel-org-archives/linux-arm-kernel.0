From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun, 13 May 2018 19:54:02 +0200
Subject: [PATCH] thermal: exynos: Reduce severity of too early temperature read
Message-ID: <20180513175402.28887-1-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thermal core tries to read temperature during sensor registering in
thermal_zone_of_sensor_register().  In that time Exynos TMU driver and
hardware are not yet initialized.  Commit 0eb875d88aaa ("thermal:
exynos: Reading temperature makes sense only when TMU is turned on")
added a boolean flag to prevent reading bogus temperature in such
case but it exposed warning message during boot:
	[    3.864913] thermal thermal_zone0: failed to read out thermal zone (-22)

Return EAGAIN in such case to skip omitting such message because it
might mislead user.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/thermal/samsung/exynos_tmu.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 3b20309789e3..c24969d740d1 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -666,8 +666,14 @@ static int exynos_get_temp(void *p, int *temp)
 	struct exynos_tmu_data *data = p;
 	int value, ret = 0;
 
-	if (!data || !data->tmu_read || !data->enabled)
+	if (!data || !data->tmu_read)
 		return -EINVAL;
+	else if (!data->enabled)
+		/*
+		 * Called too early, probably
+		 * from thermal_zone_of_sensor_register().
+		 */
+		return -EAGAIN;
 
 	mutex_lock(&data->lock);
 	clk_enable(data->clk);
-- 
2.14.1
