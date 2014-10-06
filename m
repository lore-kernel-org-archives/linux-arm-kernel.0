From: heiner.kallweit@web.de (Heiner Kallweit)
Date: Mon, 06 Oct 2014 20:37:00 +0200
Subject: [PATCH] imx: thermal: imx_get_temp might be called before the sensor
 clock ist prepared
Message-ID: <5432E14C.2090403@web.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

imx_get_temp might be called before the sensor clock ist prepared
thus resulting in a timeout of the first attempt to read temp:
thermal thermal_zone0: failed to read out thermal zone 0
Happened to me on a Utilite Standard with IMX6 Dual SoC.

Reason is that in imx_thermal_probe thermal_zone_device_register
is called before the sensor clock is prepared.
thermal_zone_device_register however calls
thermal_zone_device_update which eventually calls imx_get_temp.

Fix this by preparing the clock before calling
thermal_zone_device_register.

Signed-off-by: Heiner Kallweit <heiner.kallweit@web.de>
---
 drivers/thermal/imx_thermal.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index 461bf3d..ef50df6 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -521,20 +521,6 @@ static int imx_thermal_probe(struct platform_device *pdev)
                return ret;
        }

-       data->tz = thermal_zone_device_register("imx_thermal_zone",
-                                               IMX_TRIP_NUM,
-                                               BIT(IMX_TRIP_PASSIVE), data,
-                                               &imx_tz_ops, NULL,
-                                               IMX_PASSIVE_DELAY,
-                                               IMX_POLLING_DELAY);
-       if (IS_ERR(data->tz)) {
-               ret = PTR_ERR(data->tz);
-               dev_err(&pdev->dev,
-                       "failed to register thermal zone device %d\n", ret);
-               cpufreq_cooling_unregister(data->cdev);
-               return ret;
-       }
-
        data->thermal_clk = devm_clk_get(&pdev->dev, NULL);
        if (IS_ERR(data->thermal_clk)) {
                dev_warn(&pdev->dev, "failed to get thermal clk!\n");
@@ -551,6 +537,20 @@ static int imx_thermal_probe(struct platform_device *pdev)
                        dev_warn(&pdev->dev, "failed to enable thermal clk: %d\n", ret);
        }

+       data->tz = thermal_zone_device_register("imx_thermal_zone",
+                                               IMX_TRIP_NUM,
+                                               BIT(IMX_TRIP_PASSIVE), data,
+                                               &imx_tz_ops, NULL,
+                                               IMX_PASSIVE_DELAY,
+                                               IMX_POLLING_DELAY);
+       if (IS_ERR(data->tz)) {
+               ret = PTR_ERR(data->tz);
+               dev_err(&pdev->dev,
+                       "failed to register thermal zone device %d\n", ret);
+               cpufreq_cooling_unregister(data->cdev);
+               return ret;
+       }
+
        /* Enable measurements at ~ 10 Hz */
        regmap_write(map, TEMPSENSE1 + REG_CLR, TEMPSENSE1_MEASURE_FREQ);
        measure_freq = DIV_ROUND_UP(32768, 10); /* 10 Hz */
--
2.1.2
