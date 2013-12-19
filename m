From: Anson.Huang@freescale.com (Anson.Huang at freescale.com)
Date: Thu, 19 Dec 2013 15:53:25 +0000
Subject: [PATCH V3 2/2] thermal: imx: add necessary clk operation
In-Reply-To: <52B2F0D9.2020704@ti.com>
References: <1387487791-3259-1-git-send-email-b20788@freescale.com>,
 <52B2F0D9.2020704@ti.com>
Message-ID: <C953959F-9F4F-4FB7-9686-0EDA5434FF50@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Sent from Anson's iPhone

> ? 2013?12?19??21:13?"Eduardo Valentin" <eduardo.valentin@ti.com> ???
> 
>> On 19-12-2013 17:16, Anson Huang wrote:
>> Thermal sensor needs pll3_usb_otg when measuring temperature,
>> otherwise the temperature read will be incorrect, so need to
>> enable this clk before sensor working, for alarm function,
>> as hardware will take measurement periodically, so we should
>> keep this clk always on once alarm function is enabled.
>> 
>> Signed-off-by: Anson Huang <b20788@freescale.com>
>> ---
>> .../devicetree/bindings/thermal/imx-thermal.txt    |    4 ++++
>> drivers/thermal/imx_thermal.c                      |   18 ++++++++++++++++++
>> 2 files changed, 22 insertions(+)
>> 
>> diff --git a/Documentation/devicetree/bindings/thermal/imx-thermal.txt b/Documentation/devicetree/bindings/thermal/imx-thermal.txt
>> index 541c25e..1f0f672 100644
>> --- a/Documentation/devicetree/bindings/thermal/imx-thermal.txt
>> +++ b/Documentation/devicetree/bindings/thermal/imx-thermal.txt
>> @@ -8,10 +8,14 @@ Required properties:
>>   calibration data, e.g. OCOTP on imx6q.  The details about calibration data
>>   can be found in SoC Reference Manual.
>> 
>> +Optional properties:
>> +- clocks : thermal sensor's clock source.
>> +
>> Example:
>> 
>> tempmon {
>>    compatible = "fsl,imx6q-tempmon";
>>    fsl,tempmon = <&anatop>;
>>    fsl,tempmon-data = <&ocotp>;
>> +    clocks = <&clks 172>;
>> };
>> diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
>> index 1d6c801..c2b8173 100644
>> --- a/drivers/thermal/imx_thermal.c
>> +++ b/drivers/thermal/imx_thermal.c
>> @@ -7,6 +7,7 @@
>>  *
>>  */
>> 
>> +#include <linux/clk.h>
>> #include <linux/cpu_cooling.h>
>> #include <linux/cpufreq.h>
>> #include <linux/delay.h>
>> @@ -73,6 +74,7 @@ struct imx_thermal_data {
>>    unsigned long last_temp;
>>    bool irq_enabled;
>>    int irq;
>> +    struct clk *thermal_clk;
>> };
>> 
>> static void imx_set_alarm_temp(struct imx_thermal_data *data,
>> @@ -457,6 +459,22 @@ static int imx_thermal_probe(struct platform_device *pdev)
>>        return ret;
>>    }
> 
> There are several reg writes before this point. Are you sure you won't
> need this clock for performing those operations?

thermal reg's access uses system ipg clock which is always on, so no need to enable it, actually there is no clock gate for this ipg clock.
> 
>> +    data->thermal_clk = devm_clk_get(&pdev->dev, NULL);
>> +    if (IS_ERR(data->thermal_clk)) {
>> +        dev_warn(&pdev->dev, "failed to get thermal clk!\n");
>> +    } else {
>> +        /*
>> +         * Thermal sensor needs clk on to get correct value, normally
>> +         * we should enable its clk before taking measurement and disable
>> +         * clk after measurement is done, but if alarm function is enabled,
>> +         * hardware will auto measure the temperature periodically, so we
>> +         * need to keep the clk always on for alarm function.
>> +         */
>> +        ret = clk_prepare_enable(data->thermal_clk);
>> +        if (ret)
>> +            dev_warn(&pdev->dev, "failed to enable thermal clk: %d\n", ret);
>> +    }
>> +
>>    /* Enable measurements at ~ 10 Hz */
>>    regmap_write(map, TEMPSENSE1 + REG_CLR, TEMPSENSE1_MEASURE_FREQ);
>>    measure_freq = DIV_ROUND_UP(32768, 10); /* 10 Hz */
> 
> Don't you need to release the clock when .remove is called either on
> driver or device removal?

yes, thanks for reminder.
> 
> What about suspend / resume path? Do you want to keep this clock on when
> suspending? Is it gonna work or prevent your system to enter low power
> states?

no need to disable this clock in suspend, as CCM will disable all clocks after entering stop mode. thermal sensor should be powered down in its suspend function. it will not impact any low power mode of thermal sensor.

BTW, current thermal driver will block system suspend as it is always be powered up and suspend function will return error, I will create another patch to fix that later.
> 
> 
> 
> -- 
> You have got to be excited about what you are doing. (L. Lamport)
> 
> Eduardo Valentin
> 
