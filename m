From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 11 Jan 2018 18:14:40 +0800
Subject: [linux-sunxi] [PATCH 1/7] pinctrl: sunxi: add support for pin
 controllers without bus gate
In-Reply-To: <2ca1ee96-8dc6-c80b-ae11-45895d6a8484@arm.com>
References: <20180106042326.46519-1-icenowy@aosc.io>
 <2ca1ee96-8dc6-c80b-ae11-45895d6a8484@arm.com>
Message-ID: <CAGb2v64E-XOHVJG0Q-uZeCAdxF37QSVCDfiYmqtv7ydvseQwrw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 11, 2018 at 6:08 PM, Andre Przywara <andre.przywara@arm.com> wrote:
> Hi,
>
> On 06/01/18 04:23, Icenowy Zheng wrote:
>> The Allwinner H6 pin controllers (both the main one and the CPUs one)
>> have no bus gate clocks.
>>
>> Add support for this kind of pin controllers.
>>
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> ---
>>  drivers/pinctrl/sunxi/pinctrl-sunxi.c | 30 ++++++++++++++++++++----------
>>  drivers/pinctrl/sunxi/pinctrl-sunxi.h |  1 +
>>  2 files changed, 21 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
>> index 4b6cb25bc796..68cd505679d9 100644
>> --- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
>> +++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
>> @@ -1182,7 +1182,12 @@ static int sunxi_pinctrl_setup_debounce(struct sunxi_pinctrl *pctl,
>>       unsigned int hosc_div, losc_div;
>>       struct clk *hosc, *losc;
>>       u8 div, src;
>> -     int i, ret;
>> +     int i, ret, clk_count;
>> +
>> +     if (pctl->desc->without_bus_gate)
>> +             clk_count = 2;
>> +     else
>> +             clk_count = 3;
>>
>>       /* Deal with old DTs that didn't have the oscillators */
>>       if (of_count_phandle_with_args(node, "clocks", "#clock-cells") != 3)
>> @@ -1360,15 +1365,19 @@ int sunxi_pinctrl_init_with_variant(struct platform_device *pdev,
>>                       goto gpiochip_error;
>>       }
>>
>> -     clk = devm_clk_get(&pdev->dev, NULL);
>> -     if (IS_ERR(clk)) {
>> -             ret = PTR_ERR(clk);
>> -             goto gpiochip_error;
>> -     }
>> +     if (!desc->without_bus_gate) {
>
> Do we really need explicit support for that case?
> Can't we have something that works automatically?
>
> if (node has clock-names property)              (A)
>         use clocks as enumerated and named there

You still need to know if the hardware has a bus gate or not.
If it's missing, and it's disabled, you end up with unusable
hardware.

Unless you are fully trusting the device tree to be correct.
IMHO that makes for hard to find bugs during SoC bringup.

ChenYu

> else if (node has one clock reference)          (B)
>         use this as gate clock, no debounce support
> else if (node has no clock property at all)     (C)
>         no gate clock needed, no debounce support
>
> On top of that we should add the clock-names property to all DTs, even
> for those with only a "apb" clock. Shouldn't hurt existing kernels.
> Possibly even add debounce support for those on the way, if applicable.
>
> So we would just support case (B) and (C) for legacy reasons.
>
> Does that make sense?
>
> Cheers,
> Andre.
>
>> +             clk = devm_clk_get(&pdev->dev, NULL);
>> +             if (IS_ERR(clk)) {
>> +                     ret = PTR_ERR(clk);
>> +                     goto gpiochip_error;
>> +             }
>>
>> -     ret = clk_prepare_enable(clk);
>> -     if (ret)
>> -             goto gpiochip_error;
>> +             ret = clk_prepare_enable(clk);
>> +             if (ret)
>> +                     goto gpiochip_error;
>> +     } else {
>> +             clk = NULL;
>> +     }
>>
>>       pctl->irq = devm_kcalloc(&pdev->dev,
>>                                pctl->desc->irq_banks,
>> @@ -1425,7 +1434,8 @@ int sunxi_pinctrl_init_with_variant(struct platform_device *pdev,
>>       return 0;
>>
>>  clk_error:
>> -     clk_disable_unprepare(clk);
>> +     if (clk)
>> +             clk_disable_unprepare(clk);
>>  gpiochip_error:
>>       gpiochip_remove(pctl->chip);
>>       return ret;
>> diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.h b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
>> index 11b128f54ed2..ccb6230f0bb5 100644
>> --- a/drivers/pinctrl/sunxi/pinctrl-sunxi.h
>> +++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
>> @@ -113,6 +113,7 @@ struct sunxi_pinctrl_desc {
>>       unsigned                        irq_bank_base;
>>       bool                            irq_read_needs_mux;
>>       bool                            disable_strict_mode;
>> +     bool                            without_bus_gate;
>>  };
>>
>>  struct sunxi_pinctrl_function {
>>
