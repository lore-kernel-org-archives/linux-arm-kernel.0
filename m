From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 06 Aug 2015 08:58:56 +0900
Subject: [PATCH-v2 2/2] regulator: 88pm800: Add support for configuration
 of dual phase on BUCK1
In-Reply-To: <55C1CD47.3060400@linaro.org>
References: <1437495782-15767-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1437495782-15767-3-git-send-email-vaibhav.hiremath@linaro.org>
 <CAJKOXPcMd9VvfA48kaBa0BYeHAfHTu6MzAbQv0HuRy9wbgz0wg@mail.gmail.com>
 <55C1CD47.3060400@linaro.org>
Message-ID: <55C2A340.6020809@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05.08.2015 17:45, Vaibhav Hiremath wrote:
> 
> 
> On Thursday 23 July 2015 10:21 AM, Krzysztof Kozlowski wrote:
>> 2015-07-22 1:23 GMT+09:00 Vaibhav Hiremath <vaibhav.hiremath@linaro.org>:
>>> 88PM860 device supports dual phase mode on BUCK1 output.
>>> In normal usecase, BUCK1A and BUCK1B operates independently with 3A
>>> capacity. And they both can work as a dual phase providing 6A capacity.
>>>
>>> This patch updates the regulator driver to read the respective
>>> DT property and enable dual-phase mode on BUCK1.
>>>
>>> Note that, this is init time (one time) initialization.
>>>
> 
> Sorry for delayed response, was on bed rest almost for week.
> 
>>> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
>>> ---
>>>   drivers/regulator/88pm800.c | 31 +++++++++++++++++++++++++++++++
>>>   include/linux/mfd/88pm80x.h |  3 +++
>>>   2 files changed, 34 insertions(+)
>>
>> Don't you need to update the constraints also? I think the BUCK1
>> regulator has fixed constraint of 3 A:
>>    PM800_BUCK(buck1, BUCK1, BUCK_ENA, 0, 3000000, buck1_volt_range,
>> 0x55),
>> and now it can handle 6 A.
>>
> 
> Actually, BUCK1A and BUCK1B both combined together provide 6A capacity.
> And as discussed earlier, we need board change for this.
> 
> I am quite not sure.

AFAIU the regulator driver creates one BUCK1 regulator with constraints
3 A. However after your change the regulator will handle up to 6 A.

This means that constraints set by driver are wrong.

Additionally I can't find BUCK1A and BUCK1B regulators. Driver provides
only BUCK1.

> 
> Should I read the property and update the constraint runtime during
> probe?

Driver should provide real constraints. Find the proper way to do this.

The pm800_regulator_info[] array is not const so you can change it in
whatever way you want (although it should be const for existing driver
because regulator core accepts const and passing it to driver_data is
not necessary).

Best regards,
Krzysztof

> 
> 
>>>
>>> diff --git a/drivers/regulator/88pm800.c b/drivers/regulator/88pm800.c
>>> index e846e4c..1bf2b35 100644
>>> --- a/drivers/regulator/88pm800.c
>>> +++ b/drivers/regulator/88pm800.c
>>> @@ -267,6 +267,31 @@ static struct pm800_regulator_info
>>> pm860_regulator_info[] = {
>>>          PM800_LDO(ldo20, LDO20, LDO_ENA1_3, 3, 10000, ldo_volt_table2),
>>>   };
>>>
>>> +static int pm800_regulator_init(struct platform_device *pdev)
>>> +{
>>> +       struct pm800_regulators *pm800_data =
>>> platform_get_drvdata(pdev);
>>> +       struct pm80x_chip *chip = pm800_data->chip;
>>> +       int ret;
>>
>> 'ret' is used only in if statement below. I don't have strong feelings
>> but can you move it there to limit its scope or always return 'ret'
>> (after initializing to '0'). To me this would be more readable.
>>
> 
> OK, will fix in V3.
> 
> I will wait to close on constraint discussion above.
> 
> Thanks,
> Vaibhav
> 
>> Best regards,
>> Krzysztof
>>
>>> +
>>> +       /* Currently only supported on 88pm860 device */
>>> +       if (chip->type != CHIP_PM860)
>>> +               return 0;
>>> +
>>> +       if (of_property_read_bool(pdev->dev.of_node,
>>> +                               "marvell,88pm860-buck1-dualphase-en")) {
>>> +               ret = regmap_update_bits(chip->subchip->regmap_power,
>>> +                                       PM860_BUCK1_MISC,
>>> +                                       BUCK1_DUAL_PHASE_SEL,
>>> +                                       BUCK1_DUAL_PHASE_SEL);
>>> +               if (ret) {
>>> +                       dev_err(chip->dev, "failed to set dual-pase
>>> mode %d\n", ret);
>>> +                       return ret;
>>> +               }
>>> +       }
>>> +
>>> +       return 0;
>>> +}
>>> +
>>>   static int pm800_regulator_probe(struct platform_device *pdev)
>>>   {
>>>          struct pm80x_chip *chip = dev_get_drvdata(pdev->dev.parent);
>>> @@ -336,6 +361,12 @@ static int pm800_regulator_probe(struct
>>> platform_device *pdev)
>>>                  }
>>>          }
>>>
>>> +       ret = pm800_regulator_init(pdev);
>>> +       if (ret) {
>>> +               dev_err(&pdev->dev, "failed to init 88pm800 regulator
>>> device\n");
>>> +               return ret;
>>> +       }
>>> +
>>>          return 0;
>>>   }
>>>
>>> diff --git a/include/linux/mfd/88pm80x.h b/include/linux/mfd/88pm80x.h
>>> index a92d173..05d9bad 100644
>>> --- a/include/linux/mfd/88pm80x.h
>>> +++ b/include/linux/mfd/88pm80x.h
>>> @@ -295,6 +295,9 @@ enum {
>>>   #define PM860_BUCK4_MISC2              (0x82)
>>>   #define PM860_BUCK4_FULL_DRV           BIT(2)
>>>
>>> +#define PM860_BUCK1_MISC               (0x8E)
>>> +#define BUCK1_DUAL_PHASE_SEL           BIT(2)
>>> +
>>>   struct pm80x_rtc_pdata {
>>>          int             vrtc;
>>>          int             rtc_wakeup;
>>> -- 
>>> 1.9.1
>>>
>>>
>>> _______________________________________________
>>> linux-arm-kernel mailing list
>>> linux-arm-kernel at lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
