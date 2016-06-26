From: cwchoi00@gmail.com (Chanwoo Choi)
Date: Sun, 26 Jun 2016 20:22:06 +0900
Subject: [PATCH] extcon: Add support for qcom SPMI PMIC USB id detection
 hardware
In-Reply-To: <CAGTfZH3ireJWo5-Jd5SEiSy-WMTsw43pweruOqwSesAZqagvtg@mail.gmail.com>
References: <20160626055647.18898-1-stephen.boyd@linaro.org>
 <CAGTfZH3ireJWo5-Jd5SEiSy-WMTsw43pweruOqwSesAZqagvtg@mail.gmail.com>
Message-ID: <CAGTfZH29dVhy31+ED2fPXz8WRApXYeKV-ABR6T-dOq2yZnfA_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

2016-06-26 20:20 GMT+09:00 Chanwoo Choi <cwchoi00@gmail.com>:
> Hi,
>
> This patch looks good to me.
> But, there is some comment.
>
> 2016-06-26 14:56 GMT+09:00 Stephen Boyd <stephen.boyd@linaro.org>:
>> Some Qualcomm PMICs have a misc device that performs USB id pin
>> detection via an interrupt. When the interrupt triggers, we
>> should read the interrupt line to see if it has gone high or low.
>> If the interrupt is low then the ID pin is grounded, and if the
>> interrupt is high then the ID pin is being held high.
>>
>> Cc: Roger Quadros <rogerq@ti.com>
>> Cc: Chanwoo Choi <cw00.choi@samsung.com>
>> Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
>> ---
>>  .../bindings/extcon/qcom,pm8941-misc.txt           |  41 +++++
>>  drivers/extcon/Kconfig                             |   6 +
>>  drivers/extcon/Makefile                            |   1 +
>>  drivers/extcon/extcon-qcom-spmi-misc.c             | 170 +++++++++++++++++++++
>>  4 files changed, 218 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/extcon/qcom,pm8941-misc.txt
>>  create mode 100644 drivers/extcon/extcon-qcom-spmi-misc.c
>>
>> diff --git a/Documentation/devicetree/bindings/extcon/qcom,pm8941-misc.txt b/Documentation/devicetree/bindings/extcon/qcom,pm8941-misc.txt
>> new file mode 100644
>> index 000000000000..35383adb10f1
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/extcon/qcom,pm8941-misc.txt
>> @@ -0,0 +1,41 @@
>> +Qualcomm's PM8941 USB ID Extcon device
>> +
>> +Some Qualcomm PMICs have a "misc" module that can be used to detect when
>> +the USB ID pin has been pulled low or high.
>> +
>> +PROPERTIES
>> +
>> +- compatible:
>> +    Usage: required
>> +    Value type: <string>
>> +    Definition: Should contain "qcom,pm8941-misc";
>> +
>> +- reg:
>> +    Usage: required
>> +    Value type: <u32>
>> +    Definition: Should contain the offset to the misc address space
>
> 'reg' property is used on extcon-qcom-spmi-misc.c?
> I think that you don't need to include this property.
>
>> +
>> +- interrupts:
>> +    Usage: required
>> +    Value type: <prop-encoded-array>
>> +    Definition: Should contain the usb id interrupt
>> +
>> +- interrupt-names:
>> +    Usage: required
>> +    Value type: <stringlist>
>> +    Definition: Should contain the string "usb_id" for the usb id interrupt
>> +
>> +Example:
>> +
>> +       pmic {
>> +               usb_id: misc at 900 {
>> +                       compatible = "qcom,pm8941-misc";
>> +                       reg = <0x900>;
>> +                       interrupts = <0x0 0x9 0 IRQ_TYPE_EDGE_BOTH>;
>> +                       interrupt-names = "usb_id";
>> +               };
>> +       }
>> +
>> +       usb-controller {
>> +               extcon = <&usb_id>;
>> +       };
>> diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
>> index 3d89e60a3e71..b2ee47cb10ca 100644
>> --- a/drivers/extcon/Kconfig
>> +++ b/drivers/extcon/Kconfig
>> @@ -119,6 +119,12 @@ config EXTCON_SM5502
>>           Silicon Mitus SM5502. The SM5502 is a USB port accessory
>>           detector and switch.
>>
>> +config EXTCON_QCOM_SPMI_MISC
>> +       tristate "Qualcomm USB extcon support"
>> +       help
>> +         Say Y here to enable SPMI PMIC based USB cable detection
>> +         support on Qualcomm PMICs such as PM8941.
>
> You need to reorder the entry alphabetically. You better to move
> it below

Sorry. Before completing the reply, I send the email.
You better to move the entry on below EXTCON_PALMAS.

>
>> +
>>  config EXTCON_USB_GPIO
>>         tristate "USB GPIO extcon support"
>>         depends on GPIOLIB || COMPILE_TEST
>> diff --git a/drivers/extcon/Makefile b/drivers/extcon/Makefile
>> index 2a0e4f45d5b2..8cf6eb068d34 100644
>> --- a/drivers/extcon/Makefile
>> +++ b/drivers/extcon/Makefile
>> @@ -15,4 +15,5 @@ obj-$(CONFIG_EXTCON_MAX8997)  += extcon-max8997.o
>>  obj-$(CONFIG_EXTCON_PALMAS)    += extcon-palmas.o
>>  obj-$(CONFIG_EXTCON_RT8973A)   += extcon-rt8973a.o
>>  obj-$(CONFIG_EXTCON_SM5502)    += extcon-sm5502.o
>> +obj-$(CONFIG_EXTCON_QCOM_SPMI_MISC) += extcon-qcom-spmi-misc.o

ditto.


Thanks,
Chanwoo Choi

[snip]
