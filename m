From: heiner.kallweit@web.de (Heiner Kallweit)
Date: Wed, 08 Oct 2014 07:48:45 +0200
Subject: [PATCH v2] imx: thermal: imx_get_temp might be called before sensor
 clock is prepared
Message-ID: <5434D03D.7090408@web.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

imx_get_temp might be called before the sensor clock is prepared thus
resulting in a timeout of the first attempt to read temp:
thermal thermal_zone0: failed to read out thermal zone 0
Happened to me on a Utilite Standard with IMX6 Dual SoC.

Reason is that in imx_thermal_probe thermal_zone_device_register
is called before the sensor clock is prepared.
thermal_zone_device_register however calls
thermal_zone_device_update which eventually calls imx_get_temp.

Fix this by preparing the clock before calling
thermal_zone_device_register.

v2: revised error path. Bail out and tidy up properly if we can't
get the clock or fail to enable it.

Signed-off-by: Heiner Kallweit <heiner.kallweit@web.de>
---
 drivers/thermal/imx_thermal.c | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index 461bf3d..faf5d88 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -521,6 +521,28 @@ static int imx_thermal_probe(struct platform_device *pdev)
                return ret;
        }

+       data->thermal_clk = devm_clk_get(&pdev->dev, NULL);
+       if (IS_ERR(data->thermal_clk)) {
+               ret = PTR_ERR(data->thermal_clk);
+               dev_err(&pdev->dev, "failed to get thermal clk: %d\n", ret);
+               cpufreq_cooling_unregister(data->cdev);
+               return ret;
+       }
+
+       /*
+        * Thermal sensor needs clk on to get correct value, normally
+        * we should enable its clk before taking measurement and disable
+        * clk after measurement is done, but if alarm function is enabled,
+        * hardware will auto measure the temperature periodically, so we
+        * need to keep the clk always on for alarm function.
+        */
+       ret = clk_prepare_enable(data->thermal_clk);
+       if (ret) {
+               dev_err(&pdev->dev, "failed to enable thermal clk: %d\n", ret);
+               cpufreq_cooling_unregister(data->cdev);
+               return ret;
+       }
+
        data->tz = thermal_zone_device_register("imx_thermal_zone",
                                                IMX_TRIP_NUM,
                                                BIT(IMX_TRIP_PASSIVE), data,
@@ -531,26 +553,11 @@ static int imx_thermal_probe(struct platform_device *pdev)
                ret = PTR_ERR(data->tz);
                dev_err(&pdev->dev,
                        "failed to register thermal zone device %d\n", ret);
+               clk_disable_unprepare(data->thermal_clk);
                cpufreq_cooling_unregister(data->cdev);
                return ret;
        }

-       data->thermal_clk = devm_clk_get(&pdev->dev, NULL);
-       if (IS_ERR(data->thermal_clk)) {
-               dev_warn(&pdev->dev, "failed to get thermal clk!\n");
-       } else {
-               /*
-                * Thermal sensor needs clk on to get correct value, normally
-                * we should enable its clk before taking measurement and disable
-                * clk after measurement is done, but if alarm function is enabled,
-                * hardware will auto measure the temperature periodically, so we
-                * need to keep the clk always on for alarm function.
-                */
-               ret = clk_prepare_enable(data->thermal_clk);
-               if (ret)
-                       dev_warn(&pdev->dev, "failed to enable thermal clk: %d\n", ret);
-       }
-
        /* Enable measurements at ~ 10 Hz */
        regmap_write(map, TEMPSENSE1 + REG_CLR, TEMPSENSE1_MEASURE_FREQ);
        measure_freq = DIV_ROUND_UP(32768, 10); /* 10 Hz */
--
2.1.2
