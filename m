From: linux.amoon@gmail.com (Anand Moon)
Date: Tue, 17 Jul 2018 10:12:21 +0000
Subject: [PATCH 4/5] thermal: exynos: fixed the efuse min/max value for
 exynos5422
In-Reply-To: <1531822342-4293-1-git-send-email-linux.amoon@gmail.com>
References: <1531822342-4293-1-git-send-email-linux.amoon@gmail.com>
Message-ID: <1531822342-4293-4-git-send-email-linux.amoon@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

e-fuse range min~max range is 16~76. if e-fuse value is out of
this range, then thermal sensor may not sense thermal data properly.

CC: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 4a2733c..6481d91 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -940,11 +940,13 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 		data->reference_voltage = 16;
 		data->efuse_value = 55;
 		if (data->soc != SOC_ARCH_EXYNOS5420 &&
-		    data->soc != SOC_ARCH_EXYNOS5420_TRIMINFO)
+		    data->soc != SOC_ARCH_EXYNOS5420_TRIMINFO) {
+			data->min_efuse_value = 16;
+			data->max_efuse_value = 76;
+		} else {
 			data->min_efuse_value = 40;
-		else
-			data->min_efuse_value = 0;
-		data->max_efuse_value = 100;
+			data->max_efuse_value = 100;
+		}
 		break;
 	case SOC_ARCH_EXYNOS5433:
 		data->tmu_set_trip_temp = exynos5433_tmu_set_trip_temp;
-- 
2.7.4
