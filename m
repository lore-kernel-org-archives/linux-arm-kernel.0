From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 07 Oct 2014 15:04:31 +0200
Subject: [PATCH] imx: thermal: imx_get_temp might be called before the
 sensor clock ist prepared
In-Reply-To: <5432E14C.2090403@web.de>
References: <5432E14C.2090403@web.de>
Message-ID: <1412687071.2577.1.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiner,

Am Montag, den 06.10.2014, 20:37 +0200 schrieb Heiner Kallweit:
> imx_get_temp might be called before the sensor clock ist prepared
> thus resulting in a timeout of the first attempt to read temp:
> thermal thermal_zone0: failed to read out thermal zone 0
> Happened to me on a Utilite Standard with IMX6 Dual SoC.
> 
> Reason is that in imx_thermal_probe thermal_zone_device_register
> is called before the sensor clock is prepared.
> thermal_zone_device_register however calls
> thermal_zone_device_update which eventually calls imx_get_temp.
> 
> Fix this by preparing the clock before calling
> thermal_zone_device_register.
> 
> Signed-off-by: Heiner Kallweit <heiner.kallweit@web.de>

Looks good to me, just an issue with the error path - see below.

[...]
> @@ -551,6 +537,20 @@ static int imx_thermal_probe(struct platform_device *pdev)
>                         dev_warn(&pdev->dev, "failed to enable thermal clk: %d\n", ret);
>         }
> 
> +       data->tz = thermal_zone_device_register("imx_thermal_zone",
> +                                               IMX_TRIP_NUM,
> +                                               BIT(IMX_TRIP_PASSIVE), data,
> +                                               &imx_tz_ops, NULL,
> +                                               IMX_PASSIVE_DELAY,
> +                                               IMX_POLLING_DELAY);
> +       if (IS_ERR(data->tz)) {
> +               ret = PTR_ERR(data->tz);
> +               dev_err(&pdev->dev,
> +                       "failed to register thermal zone device %d\n", ret);

If the thermal_clk was enabled before, clk_disable_unprepare() should be
called on it here.

> +               cpufreq_cooling_unregister(data->cdev);
> +               return ret;
> +       }
> +
>         /* Enable measurements at ~ 10 Hz */
>         regmap_write(map, TEMPSENSE1 + REG_CLR, TEMPSENSE1_MEASURE_FREQ);
>         measure_freq = DIV_ROUND_UP(32768, 10); /* 10 Hz */
> --
> 2.1.2

regards
Philipp
