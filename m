From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 26 Jul 2016 19:00:18 -0700
Subject: [PATCH v2 1/4] iio: adc: rockchip_saradc: reset saradc controller
 before programming it
In-Reply-To: <57980362.3000406@rock-chips.com>
References: <1469535195-5227-1-git-send-email-wxt@rock-chips.com>
 <57976814.3040605@roeck-us.net> <579777F4.2090002@rock-chips.com>
 <20160726170023.GA6590@roeck-us.net> <57980362.3000406@rock-chips.com>
Message-ID: <579815B2.5010205@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/26/2016 05:42 PM, Caesar Wang wrote:
>
> On 2016?07?27? 01:00, Guenter Roeck wrote:
>> On Tue, Jul 26, 2016 at 10:47:16PM +0800, Caesar Wang wrote:
>>> On 2016?07?26? 21:39, Guenter Roeck wrote:
>>>>> static int rockchip_saradc_probe(struct platform_device *pdev)
>>>>> {
>>>>> struct rockchip_saradc *info = NULL;
>>>>> @@ -218,6 +231,21 @@ static int rockchip_saradc_probe(struct
>>>>> platform_device *pdev)
>>>>> if (IS_ERR(info->regs))
>>>>> return PTR_ERR(info->regs);
>>>>>
>>>>> + /*
>>>>> + * The reset should be an optional property, as it should work
>>>>> + * with old devicetrees as well
>>>>> + */
>>>>> + info->reset = devm_reset_control_get_optional(&pdev->dev,
>>>>> + "saradc-apb");
>>>> Does anyone know what the _optional API is for ? It seems to be exactly
>>>> the same
>>>> as devm_reset_control_get().
>>> ?
>>> As far as I see, the difference is WARN_ON(1)
>>> when CONFIG_RESET_CONTROLLER is not defined.
>>>
>>>
>>> The _optional functions were introduced by the following commit:
>>>
>>> ----------------->8-----------------
>>> commit b424080a9e086e683ad5fdc624a7cf3c024e0c0f
>>> Author: Philipp Zabel <p.zabel@xxxxxxxxxxxxxx>
>>> Date: Fri Mar 7 15:18:47 2014 +0100
>>>
>>> reset: Add optional resets and stubs
>>>
>>> This patch adds device_reset_optional and (devm_)reset_control_get_optional
>>> variants that drivers can use to indicate they can function without control
>>> over the reset line. For those functions, stubs are added so the drivers can
>>> be compiled with CONFIG_RESET_CONTROLLER disabled.
>>> Also, device_reset is annotated with __must_check. Drivers
>>> ignoring the return
>>> value should use device_reset_optional instead.
>>>
>> Is that really what we are looking for here ? CONFIG_RESET_CONTROLLER
>> is required for other functions of rk3399, isn't it ?
>
> Right, as the DRM and thermal are depend on the CONFIG_RESET_CONTROLLER .....
>

Since "optional" doesn't really mean "the reset property is optional"
but "CONFIG_RESET_CONTROLLER is optional", I would suggest to use
devm_reset_control_get().

Guenter
