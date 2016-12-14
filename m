From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Wed, 14 Dec 2016 14:07:22 +0100
Subject: [PATCH v6 1/8] MFD: add bindings for STM32 Timers driver
In-Reply-To: <CAL_Jsq+qzhUAMG_jL6CSHz+kHu6M6N8Nko4KfRQRgRgtk-KTKg@mail.gmail.com>
References: <1481292919-26587-1-git-send-email-benjamin.gaignard@st.com>
 <1481292919-26587-2-git-send-email-benjamin.gaignard@st.com>
 <20161212185149.rt3xqpn3mbaavb4l@rob-hp-laptop>
 <CA+M3ks4ukP14YE5-6+gAzJBjEmjEyGyVbsVGOm8ehVm0EfzO-w@mail.gmail.com>
 <CAL_Jsq+qzhUAMG_jL6CSHz+kHu6M6N8Nko4KfRQRgRgtk-KTKg@mail.gmail.com>
Message-ID: <CA+M3ks62h6Qnqjp9kaz=mbCHwOf2jmy7TGQQvED2LLH2NP0cGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-12-13 22:07 GMT+01:00 Rob Herring <robh@kernel.org>:
> On Tue, Dec 13, 2016 at 3:29 AM, Benjamin Gaignard
> <benjamin.gaignard@linaro.org> wrote:
>> 2016-12-12 19:51 GMT+01:00 Rob Herring <robh@kernel.org>:
>>> On Fri, Dec 09, 2016 at 03:15:12PM +0100, Benjamin Gaignard wrote:
>>>> Add bindings information for STM32 Timers
>>>>
>>>> version 6:
>>>> - rename stm32-gtimer to stm32-timers
>>>> - change compatible
>>>> - add description about the IPs
>>>>
>>>> version 2:
>>>> - rename stm32-mfd-timer to stm32-gptimer
>>>> - only keep one compatible string
>>>>
>>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
>>>> ---
>>>>  .../devicetree/bindings/mfd/stm32-timers.txt       | 46 ++++++++++++++++++++++
>>>>  1 file changed, 46 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/mfd/stm32-timers.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/mfd/stm32-timers.txt b/Documentation/devicetree/bindings/mfd/stm32-timers.txt
>>>> new file mode 100644
>>>> index 0000000..b30868e
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/mfd/stm32-timers.txt
>>>> @@ -0,0 +1,46 @@
>>>> +STM32 Timers driver bindings
>>>> +
>>>> +This IP provides 3 types of timer along with PWM functionality:
>>>> +- advanced-control timers consist of a 16-bit auto-reload counter driven by a programmable
>>>> +  prescaler, break input feature, PWM outputs and complementary PWM ouputs channels.
>>>> +- general-purpose timers consist of a 16-bit or 32-bit auto-reload counter driven by a
>>>> +  programmable prescaler and PWM outputs.
>>>> +- basic timers consist of a 16-bit auto-reload counter driven by a programmable prescaler.
>>>> +
>>>> +Required parameters:
>>>> +- compatible: must be "st,stm32-timers"
>>>> +
>>>> +- reg:                       Physical base address and length of the controller's
>>>> +                     registers.
>>>> +- clock-names:               Set to "clk_int".
>>>
>>> 'clk' is redundant. Also, you don't really need -names when there is
>>> only one of them.
>>
>> I use devm_regmap_init_mmio_clk() which get the clock by it name so
>> I have to define it in DT.
>
> Are you sure NULL is not allowed? I don't know, but at least clk_get()
> allows NULL.

regmap_mmio_gen_context() doesn't call clk_get() if the clock name isn't set:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/base/regmap/regmap-mmio.c?id=refs/tags/v4.9#n308

so clock-names field is really needed.

> It's fine to keep, just drop the "clk_" part.

ok

>
>>
>>>> +- clocks:            Phandle to the clock used by the timer module.
>>>> +                     For Clk properties, please refer to ../clock/clock-bindings.txt
>>>> +
>>>> +Optional parameters:
>>>> +- resets:            Phandle to the parent reset controller.
>>>> +                     See ../reset/st,stm32-rcc.txt
>>>> +
>>>> +Optional subnodes:
>>>> +- pwm:                       See ../pwm/pwm-stm32.txt
>>>> +- timer:             See ../iio/timer/stm32-timer-trigger.txt
>>>> +
>>>> +Example:
>>>> +     timers at 40010000 {
>>>> +             #address-cells = <1>;
>>>> +             #size-cells = <0>;
>>>> +             compatible = "st,stm32-timers";
>>>> +             reg = <0x40010000 0x400>;
>>>> +             clocks = <&rcc 0 160>;
>>>> +             clock-names = "clk_int";
>>>> +
>>>> +             pwm {
>>>> +                     compatible = "st,stm32-pwm";
>>>> +                     pinctrl-0       = <&pwm1_pins>;
>>>> +                     pinctrl-names   = "default";
>>>> +             };
>>>> +
>>>> +             timer {
>>>> +                     compatible = "st,stm32-timer-trigger";
>>>> +                     reg = <0>;
>>>
>>> You don't need reg here as there is only one. In turn, you don't need
>>> #address-cells or #size-cells.
>>
>> I use "reg" to set each timer configuration.
>> From hardware point of view they are all the same except for which hardware
>> signals they could consume and/or send.
>
> This sounds okay, but...
>
>> "reg" is used as index of the two tables in driver code.
>
> this statement doesn't really sound like valid use of reg.
>
> If you keep reg, then the node needs a unit address (timer at 0).

I will do that in next version but I will wait for other maintainers (PWM/IIO)
remarks before send it

Thanks

Benjamin
>
> Rob



-- 
Benjamin Gaignard

Graphic Study Group

Linaro.org ? Open source software for ARM SoCs

Follow Linaro: Facebook | Twitter | Blog
