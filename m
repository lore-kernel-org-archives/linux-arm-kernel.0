From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Tue, 5 Feb 2013 09:06:46 +0800
Subject: [PATCH v8 01/12] gpio: add gpio offset in gpio range cells
 property
In-Reply-To: <20130205002338.GA25185@atomide.com>
References: <1359825953-15663-1-git-send-email-haojian.zhuang@linaro.org>
 <1359825953-15663-2-git-send-email-haojian.zhuang@linaro.org>
 <20130205002338.GA25185@atomide.com>
Message-ID: <CAD6h2NT-E6dOoEQxZ0fLkj0T70P1XFwjW805OxbK1vMfHK9FCQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 February 2013 08:23, Tony Lindgren <tony@atomide.com> wrote:
> * Haojian Zhuang <haojian.zhuang@linaro.org> [130202 09:29]:
>> Add gpio offset into "gpio-range-cells" property. It's used to support
>> sparse pinctrl range in gpio chip.
>>
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
>> ---
>>  Documentation/devicetree/bindings/gpio/gpio.txt |    6 +++---
>>  arch/arm/boot/dts/spear1310.dtsi                |    4 ++--
>>  arch/arm/boot/dts/spear1340.dtsi                |    4 ++--
>>  arch/arm/boot/dts/spear310.dtsi                 |    4 ++--
>>  arch/arm/boot/dts/spear320.dtsi                 |    4 ++--
>>  drivers/gpio/gpiolib-of.c                       |   15 ++-------------
>>  6 files changed, 13 insertions(+), 24 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/gpio/gpio.txt b/Documentation/devicetree/bindings/gpio/gpio.txt
>> index a336287..d933af3 100644
>> --- a/Documentation/devicetree/bindings/gpio/gpio.txt
>> +++ b/Documentation/devicetree/bindings/gpio/gpio.txt
>> @@ -98,7 +98,7 @@ announce the pinrange to the pin ctrl subsystem. For example,
>>               compatible = "fsl,qe-pario-bank-e", "fsl,qe-pario-bank";
>>               reg = <0x1460 0x18>;
>>               gpio-controller;
>> -             gpio-ranges = <&pinctrl1 20 10>, <&pinctrl2 50 20>;
>> +             gpio-ranges = <&pinctrl1 0 20 10>, <&pinctrl2 10 50 20>;
>>
>>      }
>>
>> @@ -107,8 +107,8 @@ where,
>>
>>     Next values specify the base pin and number of pins for the range
>>     handled by 'qe_pio_e' gpio. In the given example from base pin 20 to
>> -   pin 29 under pinctrl1 and pin 50 to pin 69 under pinctrl2 is handled
>> -   by this gpio controller.
>> +   pin 29 under pinctrl1 with gpio offset 0 and pin 50 to pin 69 under
>> +   pinctrl2 with gpio offset 10 is handled by this gpio controller.
>>
>>  The pinctrl node must have "#gpio-range-cells" property to show number of
>>  arguments to pass with phandle from gpio controllers node.
>> diff --git a/arch/arm/boot/dts/spear1310.dtsi b/arch/arm/boot/dts/spear1310.dtsi
>> index 1513c19..122ae94 100644
>> --- a/arch/arm/boot/dts/spear1310.dtsi
>> +++ b/arch/arm/boot/dts/spear1310.dtsi
>> @@ -89,7 +89,7 @@
>>               pinmux: pinmux at e0700000 {
>>                       compatible = "st,spear1310-pinmux";
>>                       reg = <0xe0700000 0x1000>;
>> -                     #gpio-range-cells = <2>;
>> +                     #gpio-range-cells = <3>;
>>               };
>>
>>               apb {
>
> Hmm is this safe to do if there are bootloaders using the old binding?
> Maybe we should support both #gpio-range-cells = <2> and <3> bindings
> instead?
>
> Regards,
>
> Tony

I think that bootloader aren't using the old binding. I always Cc Shiraz.
If it can't work, he would speak loudly.

And I don't want to add complexity in this function. So I force the number of
parameters is three.

Regards
Haojian
