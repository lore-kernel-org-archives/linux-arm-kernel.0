From: heiner.kallweit@web.de (Heiner Kallweit)
Date: Tue, 07 Oct 2014 21:36:19 +0200
Subject: [PATCH] imx: thermal: imx_get_temp might be called before the
 sensor clock ist prepared
In-Reply-To: <1412687071.2577.1.camel@pengutronix.de>
References: <5432E14C.2090403@web.de> <1412687071.2577.1.camel@pengutronix.de>
Message-ID: <543440B3.4070307@web.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for the hint, Philipp.
After thinking a little bit more about it I'm not sure about one thing:

If we can't get the clock or fail to enable it: Currently the code just throws
a warning and proceeds with trying to register the thermal device.
Does this make sense or shall we bail out instead (like in case of other error conditions
in imx_thermal_probe)? I'd tend to bail out ..

Regards, Heiner


Am 07.10.2014 um 15:04 schrieb Philipp Zabel:
> Hi Heiner,
> 
> Am Montag, den 06.10.2014, 20:37 +0200 schrieb Heiner Kallweit:
>> imx_get_temp might be called before the sensor clock ist prepared
>> thus resulting in a timeout of the first attempt to read temp:
>> thermal thermal_zone0: failed to read out thermal zone 0
>> Happened to me on a Utilite Standard with IMX6 Dual SoC.
>>
>> Reason is that in imx_thermal_probe thermal_zone_device_register
>> is called before the sensor clock is prepared.
>> thermal_zone_device_register however calls
>> thermal_zone_device_update which eventually calls imx_get_temp.
>>
>> Fix this by preparing the clock before calling
>> thermal_zone_device_register.
>>
>> Signed-off-by: Heiner Kallweit <heiner.kallweit@web.de>
> 
> Looks good to me, just an issue with the error path - see below.
> 
> [...]
>> @@ -551,6 +537,20 @@ static int imx_thermal_probe(struct platform_device *pdev)
>>                         dev_warn(&pdev->dev, "failed to enable thermal clk: %d\n", ret);
>>         }
>>
>> +       data->tz = thermal_zone_device_register("imx_thermal_zone",
>> +                                               IMX_TRIP_NUM,
>> +                                               BIT(IMX_TRIP_PASSIVE), data,
>> +                                               &imx_tz_ops, NULL,
>> +                                               IMX_PASSIVE_DELAY,
>> +                                               IMX_POLLING_DELAY);
>> +       if (IS_ERR(data->tz)) {
>> +               ret = PTR_ERR(data->tz);
>> +               dev_err(&pdev->dev,
>> +                       "failed to register thermal zone device %d\n", ret);
> 
> If the thermal_clk was enabled before, clk_disable_unprepare() should be
> called on it here.
> 
>> +               cpufreq_cooling_unregister(data->cdev);
>> +               return ret;
>> +       }
>> +
>>         /* Enable measurements at ~ 10 Hz */
>>         regmap_write(map, TEMPSENSE1 + REG_CLR, TEMPSENSE1_MEASURE_FREQ);
>>         measure_freq = DIV_ROUND_UP(32768, 10); /* 10 Hz */
>> --
>> 2.1.2
> 
> regards
> Philipp
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
