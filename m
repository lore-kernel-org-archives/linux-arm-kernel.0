From: linux.amoon@gmail.com (Anand Moon)
Date: Tue, 23 Feb 2016 14:47:18 +0530
Subject: [PATCH] ARM: dts: add support for gpio buttons for
 exynos5422-odroidxu3
In-Reply-To: <56CC194F.6080905@samsung.com>
References: <1456214467-3344-1-git-send-email-linux.amoon@gmail.com>
 <56CC167A.8040303@samsung.com> <56CC194F.6080905@samsung.com>
Message-ID: <CANAwSgTRu6pb9cdA50AzBSNLS+Y+sssyc_CX7FKuV=FDYWaOsA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On 23 February 2016 at 14:03, Krzysztof Kozlowski
<k.kozlowski@samsung.com> wrote:
> On 23.02.2016 17:21, Krzysztof Kozlowski wrote:
>> On 23.02.2016 17:01, Anand Moon wrote:
>>> Add support for gpio-based button on Odroid-XU3 boards
>>> for reboot/poweroff feature.
>>>
>>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>>> ---
>>> changes rebase based on linux next-20160222.
>>>
>>> Tested on Odroid-XU4
>>>
>>> dmesg output.
>>> [    3.286068] of_get_named_gpiod_flags: parsed 'gpios' property of node '/gpio_keys/power_key[0]' - status (0)
>>> [    3.286206] gpio-11 (power key): gpiod_set_debounce: missing set() or set_debounce() operations
>>> [    3.286600] input: gpio_keys as /devices/platform/gpio_keys/input/input0
>>> ---
>>>  arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 22 ++++++++++++++++++++++
>>>  1 file changed, 22 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
>>> index 1bd507b..db9770b 100644
>>> --- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
>>> +++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
>>> @@ -11,6 +11,7 @@
>>>  */
>>>
>>>  #include <dt-bindings/clock/samsung,s2mps11.h>
>>> +#include <dt-bindings/input/input.h>
>>>  #include <dt-bindings/interrupt-controller/irq.h>
>>>  #include <dt-bindings/gpio/gpio.h>
>>>  #include <dt-bindings/sound/samsung-i2s.h>
>>> @@ -54,6 +55,22 @@
>>>              #cooling-cells = <2>;
>>>              cooling-levels = <0 130 170 230>;
>>>      };
>>> +
>>> +    gpio_keys {
>>> +            compatible = "gpio-keys";
>>> +            pinctrl-names = "default";
>>> +            pinctrl-0 = <&gpio_power_key>;
>>> +
>>> +            power_key {
>>> +                    interrupt-parent = <&gpx0>;
>>> +                    interrupts = <3 IRQ_TYPE_NONE>;
>>
>> Hmmm.... why you specify the interrupts?
>>
>>> +                    gpios = <&gpx0 3 GPIO_ACTIVE_LOW>;
>
> Please, explain it to me. The SW2 key is connected to PWRON of PMIC.
> However you are adding a GPIO key for external interrupt source 3
> (XE.INT3)... which comes from PMIC's ONOB.
>
> It's interesting.... how does it work? The PMIC will generate ONOB
> interrupt on PWRON low->high change (when PWRHOLD is high)?
>
> Best regards,
> Krzysztof
>

I have re-base my changes on HK dts.
I could not find much details for the schematic diagram.
I don't know much low level detains on this.

How dose this works: This changes will initial the shudown/reboot on Ubuntu.
I have also tested this similar feature on Odroid U3.

Best Regards.
-Anand Moon
