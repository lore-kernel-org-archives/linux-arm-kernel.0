From: rogerq@ti.com (Roger Quadros)
Date: Tue, 28 Jun 2016 09:36:26 +0300
Subject: [PATCH] extcon: Add support for qcom SPMI PMIC USB id detection
 hardware
In-Reply-To: <146705583219.30684.18055040268826215722@sboyd-linaro>
References: <20160626055647.18898-1-stephen.boyd@linaro.org>
 <5770D847.7060901@ti.com>
 <146705583219.30684.18055040268826215722@sboyd-linaro>
Message-ID: <57721AEA.6010509@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/06/16 22:30, Stephen Boyd wrote:
> Quoting Roger Quadros (2016-06-27 00:39:51)
>> Hi Stephen,
>>
>> On 26/06/16 08:56, Stephen Boyd wrote:
>>> Some Qualcomm PMICs have a misc device that performs USB id pin
>>> detection via an interrupt. When the interrupt triggers, we
>>> should read the interrupt line to see if it has gone high or low.
>>> If the interrupt is low then the ID pin is grounded, and if the
>>> interrupt is high then the ID pin is being held high.
>>
>> Does this depend on any other drivers to configure the USB ID
>> interrupt or it works automatically once the interrupt is enabled?
> 
> No other configuration is required as far as I know.
> 
>>
>>>
>>> Cc: Roger Quadros <rogerq@ti.com>
>>> Cc: Chanwoo Choi <cw00.choi@samsung.com>
>>> Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
>>> ---
>>>  .../bindings/extcon/qcom,pm8941-misc.txt           |  41 +++++
>>>  drivers/extcon/Kconfig                             |   6 +
>>>  drivers/extcon/Makefile                            |   1 +
>>>  drivers/extcon/extcon-qcom-spmi-misc.c             | 170 +++++++++++++++++++++
>>
>> Should we make this driver more generic so that it can support
>> any other platforms as well that can give USB ID over interrupt.
> 
> I don't see a problem with that, but can that wait until we gain another
> user? I'd rather not make something generic when we only have one user.

OK.
> 
>>
>> What about USB_VBUS? How is that delivered?
> 
> The VBUS notification is done through another piece of hardware. In this
> case it's done by the charger module. I've sent a patch for that[1].

Isn't it better if ID event is handled as well in that PMIC driver instead of
creating a separate one here?

Why do you need ID to be handled outside of the PMIC driver?
You mentioned earlier that some Qualcomm PMICs have ID detection.

> 
>>> diff --git a/drivers/extcon/Makefile b/drivers/extcon/Makefile
>>> index 2a0e4f45d5b2..8cf6eb068d34 100644
>>> --- a/drivers/extcon/Makefile
>>> +++ b/drivers/extcon/Makefile
>>> @@ -15,4 +15,5 @@ obj-$(CONFIG_EXTCON_MAX8997)        += extcon-max8997.o
>>>  obj-$(CONFIG_EXTCON_PALMAS)  += extcon-palmas.o
>>>  obj-$(CONFIG_EXTCON_RT8973A) += extcon-rt8973a.o
>>>  obj-$(CONFIG_EXTCON_SM5502)  += extcon-sm5502.o
>>> +obj-$(CONFIG_EXTCON_QCOM_SPMI_MISC) += extcon-qcom-spmi-misc.o
>>>  obj-$(CONFIG_EXTCON_USB_GPIO)        += extcon-usb-gpio.o
>>> diff --git a/drivers/extcon/extcon-qcom-spmi-misc.c b/drivers/extcon/extcon-qcom-spmi-misc.c
>>> new file mode 100644
>>> index 000000000000..f0ec6f1541e1
>>> --- /dev/null
>>> +++ b/drivers/extcon/extcon-qcom-spmi-misc.c
>>> @@ -0,0 +1,170 @@
>>> +/**
>>> + * Based on extcon-usb-gpio.c
>>> + *
>>> + * Copyright (C) 2015 Texas Instruments Incorporated - http://www.ti.com
>>> + * Author: Roger Quadros <rogerq@ti.com>
>>
>> You don't need to carry the original (C) here.
> 
> Ok I'll drop those two lines. Thanks.
> 
> [1] http://lkml.kernel.org/g/20160626055437.18516-1-stephen.boyd at linaro.org
> 

--
cheers,
-roger
